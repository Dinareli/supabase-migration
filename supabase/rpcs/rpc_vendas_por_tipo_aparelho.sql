-- RPC: vendas_por_tipo_aparelho
-- Dashboard: soma de vendas (R$) agrupada por tipo de aparelho (categoria)
-- Filtra apenas atendimentos concretizados e itens do tipo 'venda'

create or replace function vendas_por_tipo_aparelho(
  p_empresa_id bigint,
  p_data_inicio timestamptz default null,
  p_data_fim    timestamptz default null
)
returns table (
  tipo_aparelho   text,
  total_vendas_rs numeric,
  qtd_itens       bigint,
  qtd_atendimentos bigint
)
language sql
stable
security invoker
as $$
  select
    coalesce(c.nome, p.txt_tipo_produto, 'Sem categoria') as tipo_aparelho,
    coalesce(sum(ap.preco * ap.quantidade), 0)             as total_vendas_rs,
    sum(ap.quantidade)::bigint                             as qtd_itens,
    count(distinct a.id)                                   as qtd_atendimentos
  from atendimentos a
  join atendimento_produto ap on ap.atendimento_id = a.id
  join produtos p             on p.id = ap.produto_id
  left join categorias c      on c.id = p.categoria_id
  where a.empresa_id   = p_empresa_id
    and a.concretizado = true
    and a.cancelado    = false
    and ap.tipo        = 'venda'
    and (p_data_inicio is null or a.data_venda >= p_data_inicio)
    and (p_data_fim    is null or a.data_venda <  p_data_fim)
  group by coalesce(c.nome, p.txt_tipo_produto, 'Sem categoria')
  order by total_vendas_rs desc;
$$;
