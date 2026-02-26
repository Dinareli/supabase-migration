-- ============================================================================
-- RPC: dashboard_home
-- Retorna todos os dados do dashboard principal em uma unica chamada
-- ============================================================================
-- Metricas retornadas:
--   faturamento, qtd_atendimentos, qtd_ordens_servico, lucro_total,
--   taxa_lucro, lucro_medio_geral, lucro_medio_dispositivo,
--   lucro_medio_acessorio, historico_faturamento (7 meses), aniversariantes
-- ============================================================================

create or replace function dashboard_home(
  p_empresa_id bigint,
  p_ano        integer,
  p_mes        integer,
  p_data_hoje  date default current_date
)
returns jsonb
language plpgsql
stable
security invoker
as $$
declare
  v_inicio timestamptz;
  v_fim    timestamptz;
  v_hist_inicio timestamptz;

  v_fat_vendas    numeric := 0;
  v_qtd_ate       bigint  := 0;
  v_lucro_vendas  numeric := 0;

  v_fat_os        numeric := 0;
  v_qtd_os        bigint  := 0;
  v_lucro_os      numeric := 0;

  v_fat_total     numeric;
  v_lucro_total   numeric;
  v_taxa_lucro    numeric;
  v_lucro_medio   numeric;

  v_lucro_med_disp numeric := 0;
  v_lucro_med_aces numeric := 0;

  v_historico     jsonb;
  v_aniversarios  jsonb;
begin
  v_inicio      := make_timestamptz(p_ano, p_mes, 1, 0, 0, 0);
  v_fim         := v_inicio + interval '1 month';
  v_hist_inicio := v_inicio - interval '6 months';

  -- ========================================================================
  -- 1. Vendas do mes (atendimentos concretizados)
  -- ========================================================================
  select
    coalesce(sum(a.total_bruto), 0),
    count(*),
    coalesce(sum(a.lucro_bruto), 0)
  into v_fat_vendas, v_qtd_ate, v_lucro_vendas
  from atendimentos a
  where a.empresa_id   = p_empresa_id
    and a.concretizado = true
    and a.cancelado    = false
    and a.data_venda  >= v_inicio
    and a.data_venda   < v_fim;

  -- ========================================================================
  -- 2. Ordens de servico do mes (ativas, nao canceladas)
  -- ========================================================================
  select
    coalesce(sum(os.total_pago_cliente), 0),
    count(*),
    coalesce(sum(os.lucro_os), 0)
  into v_fat_os, v_qtd_os, v_lucro_os
  from ordens_servico os
  where os.empresa_id = p_empresa_id
    and os.ativo       = true
    and os.data_task  >= v_inicio
    and os.data_task   < v_fim;

  -- ========================================================================
  -- 3. Totais combinados
  -- ========================================================================
  v_fat_total   := v_fat_vendas + v_fat_os;
  v_lucro_total := v_lucro_vendas + v_lucro_os;

  v_taxa_lucro := case
    when v_fat_total > 0
    then round((v_lucro_total / v_fat_total) * 100, 2)
    else 0
  end;

  v_lucro_medio := case
    when (v_qtd_ate + v_qtd_os) > 0
    then round(v_lucro_total / (v_qtd_ate + v_qtd_os), 2)
    else 0
  end;

  -- ========================================================================
  -- 4. Lucro medio por tipo de produto (dispositivo vs acessorio)
  --    Classificacao via grupos.nome: '%acess%' = acessorio, demais = dispositivo
  -- ========================================================================
  select
    coalesce(round(
      sum(case when lower(g.nome) not like '%acess%'
               then (coalesce(ap.preco, 0) - coalesce(ap.custo, 0)) * ap.quantidade end)
      / nullif(sum(case when lower(g.nome) not like '%acess%' then ap.quantidade end), 0)
    , 2), 0),
    coalesce(round(
      sum(case when lower(g.nome) like '%acess%'
               then (coalesce(ap.preco, 0) - coalesce(ap.custo, 0)) * ap.quantidade end)
      / nullif(sum(case when lower(g.nome) like '%acess%' then ap.quantidade end), 0)
    , 2), 0)
  into v_lucro_med_disp, v_lucro_med_aces
  from atendimentos a
  join atendimento_produto ap on ap.atendimento_id = a.id
  join produtos p             on p.id = ap.produto_id
  left join grupos g          on g.id = p.grupo_id
  where a.empresa_id   = p_empresa_id
    and a.concretizado = true
    and a.cancelado    = false
    and ap.tipo        = 'venda'
    and a.data_venda  >= v_inicio
    and a.data_venda   < v_fim;

  -- ========================================================================
  -- 5. Historico de faturamento (ultimos 7 meses incluindo o atual)
  -- ========================================================================
  with meses as (
    select gs as inicio, gs + interval '1 month' as fim
    from generate_series(v_hist_inicio, v_inicio, interval '1 month') gs
  ),
  fat_vendas as (
    select
      date_trunc('month', a.data_venda) as mes,
      sum(a.total_bruto) as total
    from atendimentos a
    where a.empresa_id   = p_empresa_id
      and a.concretizado = true
      and a.cancelado    = false
      and a.data_venda  >= v_hist_inicio
      and a.data_venda   < v_fim
    group by 1
  ),
  fat_os as (
    select
      date_trunc('month', os.data_task) as mes,
      sum(os.total_pago_cliente) as total
    from ordens_servico os
    where os.empresa_id = p_empresa_id
      and os.ativo       = true
      and os.data_task  >= v_hist_inicio
      and os.data_task   < v_fim
    group by 1
  )
  select coalesce(jsonb_agg(
    jsonb_build_object(
      'ano',         extract(year from m.inicio)::integer,
      'mes',         extract(month from m.inicio)::integer,
      'mes_nome',    trim(to_char(m.inicio, 'TMMonth')),
      'faturamento', coalesce(fv.total, 0) + coalesce(fo.total, 0)
    ) order by m.inicio
  ), '[]'::jsonb)
  into v_historico
  from meses m
  left join fat_vendas fv on fv.mes = m.inicio
  left join fat_os fo     on fo.mes = m.inicio;

  -- ========================================================================
  -- 6. Aniversariantes do dia
  -- ========================================================================
  select coalesce(jsonb_agg(
    jsonb_build_object(
      'id',               c.id,
      'nome',             c.nome,
      'telefone',         c.telefone,
      'data_nascimento',  c.data_nascimento
    ) order by c.nome
  ), '[]'::jsonb)
  into v_aniversarios
  from clientes c
  where c.empresa_id      = p_empresa_id
    and c.ativo            = true
    and c.dia_aniversario  = extract(day   from p_data_hoje)::integer
    and c.mes_aniversario  = extract(month from p_data_hoje)::integer;

  -- ========================================================================
  -- 7. Resultado final
  -- ========================================================================
  return jsonb_build_object(
    'faturamento',             v_fat_total,
    'faturamento_vendas',      v_fat_vendas,
    'faturamento_os',          v_fat_os,
    'qtd_atendimentos',        v_qtd_ate,
    'qtd_ordens_servico',      v_qtd_os,
    'lucro_total',             v_lucro_total,
    'lucro_vendas',            v_lucro_vendas,
    'lucro_os',                v_lucro_os,
    'taxa_lucro',              v_taxa_lucro,
    'lucro_medio_geral',       v_lucro_medio,
    'lucro_medio_dispositivo', v_lucro_med_disp,
    'lucro_medio_acessorio',   v_lucro_med_aces,
    'historico_faturamento',   v_historico,
    'aniversariantes',         v_aniversarios
  );
end;
$$;

-- ============================================================================
-- INDEX sugerido para aniversariantes (se nao existir)
-- ============================================================================
create index if not exists idx_clientes_aniversario
  on clientes(empresa_id, mes_aniversario, dia_aniversario)
  where ativo = true;
