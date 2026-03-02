-- ============================================================================
-- EMPRESAS_ACESSO: lista de empresas (fonte: tabela empresas) por empresa
-- ============================================================================
-- Permite que cada empresa tenha um conjunto de "empresas de acesso" (lista
-- de itens cuja fonte são as próprias empresas cadastradas).
-- Uso: dropdown/lista no UI usa view empresas_lista; a relação N:N fica
-- em empresa_empresas_acesso.
-- ============================================================================

-- 1) View: lista de empresas para uso como opções (dropdown/select)
-- Fonte: tabela empresas (ativas, ordenadas por nome)
create or replace view empresas_lista as
select id, nome
from empresas
where ativo = true
order by nome;

comment on view empresas_lista is 'Lista id/nome de empresas ativas para uso em listas/dropdowns. Fonte: tabela empresas.';

-- 2) Tabela de junção: quais empresas cada empresa tem em "empresas_acesso"
create table empresa_empresas_acesso (
  empresa_id bigint not null references empresas(id) on delete cascade,
  empresa_acesso_id bigint not null references empresas(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (empresa_id, empresa_acesso_id),
  constraint chk_empresa_acesso_diferente check (empresa_id <> empresa_acesso_id)
);

create index idx_empresa_empresas_acesso_empresa on empresa_empresas_acesso(empresa_id);
create index idx_empresa_empresas_acesso_acesso on empresa_empresas_acesso(empresa_acesso_id);

comment on table empresa_empresas_acesso is 'Relação N:N: para cada empresa, lista de outras empresas em "empresas_acesso". Fonte dos itens: tabela empresas (use view empresas_lista no UI).';

-- 3) View: empresas com coluna empresas_acesso como array de IDs (para leitura conveniente)
create or replace view empresas_com_acesso as
select
  e.id,
  e.nome,
  e.ativo,
  coalesce(
    (select array_agg(eea.empresa_acesso_id order by emp.nome)
     from empresa_empresas_acesso eea
     join empresas emp on emp.id = eea.empresa_acesso_id
     where eea.empresa_id = e.id),
    '{}'
  ) as empresas_acesso
from empresas e;

comment on view empresas_com_acesso is 'Empresas com coluna empresas_acesso (array de IDs) para uso quando precisar do campo agregado. Opções do dropdown: use empresas_lista.';

ALTER TABLE empresa_empresas_acesso ENABLE ROW LEVEL SECURITY;
