-- ============================================================================
-- USUARIOS_ACESSO: lista de usuarios (fonte: tabela usuarios) por usuario
-- ============================================================================
-- Permite que cada usuario tenha um conjunto de "usuarios de acesso" (lista
-- de itens cuja fonte são os próprios usuarios cadastrados).
-- Uso: dropdown/lista no UI usa view usuarios_lista; a relação N:N fica
-- em usuario_usuarios_acesso.
-- ============================================================================

-- 1) View usuarios_lista já existe (00016); garante atualizada para uso como opções
create or replace view usuarios_lista as
select id, nome, sobrenome, email, empresa_web_id, empresa_app_id, ativo
from usuarios
where ativo = true
order by nome nulls last, id;

comment on view usuarios_lista is 'Lista de usuarios ativos para uso em listas/dropdowns. Fonte: tabela usuarios.';

-- 2) Tabela de junção: quais usuarios cada usuario tem em "usuarios_acesso"
create table usuario_usuarios_acesso (
  usuario_id bigint not null references usuarios(id) on delete cascade,
  usuario_acesso_id bigint not null references usuarios(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (usuario_id, usuario_acesso_id),
  constraint chk_usuario_acesso_diferente check (usuario_id <> usuario_acesso_id)
);

create index idx_usuario_usuarios_acesso_usuario on usuario_usuarios_acesso(usuario_id);
create index idx_usuario_usuarios_acesso_acesso on usuario_usuarios_acesso(usuario_acesso_id);

comment on table usuario_usuarios_acesso is 'Relação N:N: para cada usuario, lista de outros usuarios em "usuarios_acesso". Fonte dos itens: tabela usuarios (use view usuarios_lista no UI).';

-- 3) View: usuarios com coluna usuarios_acesso como array de IDs (para leitura conveniente)
create or replace view usuarios_com_acesso as
select
  u.id,
  u.nome,
  u.sobrenome,
  u.email,
  u.empresa_web_id,
  u.empresa_app_id,
  u.ativo,
  coalesce(
    (select array_agg(uua.usuario_acesso_id order by u2.nome nulls last, u2.id)
     from usuario_usuarios_acesso uua
     join usuarios u2 on u2.id = uua.usuario_acesso_id
     where uua.usuario_id = u.id),
    '{}'
  ) as usuarios_acesso
from usuarios u;

comment on view usuarios_com_acesso is 'Usuarios com coluna usuarios_acesso (array de IDs) para uso quando precisar do campo agregado. Opções do dropdown: use usuarios_lista.';

alter table usuario_usuarios_acesso enable row level security;
