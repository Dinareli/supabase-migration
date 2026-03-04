-- ============================================================================
-- ATENDIMENTOS_ACESSO: lista de atendimentos (fonte: tabela atendimentos) por atendimento
-- ============================================================================
-- Permite que cada atendimento tenha um conjunto de "atendimentos de acesso" (lista
-- de itens cuja fonte são os próprios atendimentos cadastrados).
-- Uso: dropdown/lista no UI usa view atendimentos_lista; a relação N:N fica
-- em atendimento_atendimentos_acesso.
-- ============================================================================

-- 1) View atendimentos_lista já existe (00016); garante atualizada para uso como opções
create or replace view atendimentos_lista as
select id, empresa_id, cod_atendimento, data_venda, status
from atendimentos
order by data_venda desc nulls last, id desc;

comment on view atendimentos_lista is 'Lista de atendimentos para uso em listas/dropdowns. Fonte: tabela atendimentos.';

-- 2) Tabela de junção: quais atendimentos cada atendimento tem em "atendimentos_acesso"
create table atendimento_atendimentos_acesso (
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  atendimento_acesso_id bigint not null references atendimentos(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (atendimento_id, atendimento_acesso_id),
  constraint chk_atendimento_acesso_diferente check (atendimento_id <> atendimento_acesso_id)
);

create index idx_atendimento_atendimentos_acesso_atendimento on atendimento_atendimentos_acesso(atendimento_id);
create index idx_atendimento_atendimentos_acesso_acesso on atendimento_atendimentos_acesso(atendimento_acesso_id);

comment on table atendimento_atendimentos_acesso is 'Relação N:N: para cada atendimento, lista de outros atendimentos em "atendimentos_acesso". Fonte dos itens: tabela atendimentos (use view atendimentos_lista no UI).';

-- 3) View: atendimentos com coluna atendimentos_acesso como array de IDs (para leitura conveniente)
create or replace view atendimentos_com_acesso as
select
  a.id,
  a.empresa_id,
  a.cod_atendimento,
  a.data_venda,
  a.status,
  coalesce(
    (select array_agg(ata.atendimento_acesso_id order by a2.data_venda desc nulls last, a2.id desc)
     from atendimento_atendimentos_acesso ata
     join atendimentos a2 on a2.id = ata.atendimento_acesso_id
     where ata.atendimento_id = a.id),
    '{}'
  ) as atendimentos_acesso
from atendimentos a;

comment on view atendimentos_com_acesso is 'Atendimentos com coluna atendimentos_acesso (array de IDs) para uso quando precisar do campo agregado. Opções do dropdown: use atendimentos_lista.';

alter table atendimento_atendimentos_acesso enable row level security;
