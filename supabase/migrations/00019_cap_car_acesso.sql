-- ============================================================================
-- CAP_CAR_ACESSO: lista de cap_car (fonte: tabela cap_car) por cap_car
-- ============================================================================
-- Permite que cada registro cap_car tenha um conjunto de "cap_car de acesso" (lista
-- de itens cuja fonte são os próprios registros cap_car cadastrados).
-- Uso: dropdown/lista no UI usa view cap_car_lista; a relação N:N fica
-- em cap_car_cap_car_acesso.
-- ============================================================================

-- 1) View cap_car_lista já existe (00016); garante atualizada para uso como opções
create or replace view cap_car_lista as
select id, empresa_id, cod_lancamento, tipo_lancamento, situacao, data_vencimento, valor_original, quitado, ativo
from cap_car
where ativo = true
order by data_vencimento desc nulls last, id desc;

comment on view cap_car_lista is 'Lista de cap_car (contas a pagar/receber) ativos para uso em listas/dropdowns. Fonte: tabela cap_car.';

-- 2) Tabela de junção: quais cap_car cada cap_car tem em "cap_car_acesso"
create table cap_car_cap_car_acesso (
  cap_car_id bigint not null references cap_car(id) on delete cascade,
  cap_car_acesso_id bigint not null references cap_car(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (cap_car_id, cap_car_acesso_id),
  constraint chk_cap_car_acesso_diferente check (cap_car_id <> cap_car_acesso_id)
);

create index idx_cap_car_cap_car_acesso_cap_car on cap_car_cap_car_acesso(cap_car_id);
create index idx_cap_car_cap_car_acesso_acesso on cap_car_cap_car_acesso(cap_car_acesso_id);

comment on table cap_car_cap_car_acesso is 'Relação N:N: para cada cap_car, lista de outros cap_car em "cap_car_acesso". Fonte dos itens: tabela cap_car (use view cap_car_lista no UI).';

-- 3) View: cap_car com coluna cap_car_acesso como array de IDs (para leitura conveniente)
create or replace view cap_car_com_acesso as
select
  c.id,
  c.empresa_id,
  c.cod_lancamento,
  c.tipo_lancamento,
  c.situacao,
  c.data_vencimento,
  c.valor_original,
  c.quitado,
  c.ativo,
  coalesce(
    (select array_agg(cca.cap_car_acesso_id order by c2.data_vencimento desc nulls last, c2.id desc)
     from cap_car_cap_car_acesso cca
     join cap_car c2 on c2.id = cca.cap_car_acesso_id
     where cca.cap_car_id = c.id),
    '{}'
  ) as cap_car_acesso
from cap_car c;

comment on view cap_car_com_acesso is 'Cap_car com coluna cap_car_acesso (array de IDs) para uso quando precisar do campo agregado. Opções do dropdown: use cap_car_lista.';

alter table cap_car_cap_car_acesso enable row level security;
