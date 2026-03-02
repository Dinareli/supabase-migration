-- ============================================================================
-- CORE: Tabela empresas (tenants)
-- ============================================================================
-- Cadastro de empresas. Tabela raiz do multi-tenancy.
-- ============================================================================

create table empresas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  -- dados cadastrais
  nome text not null,
  cnpj text,
  email text,
  telefone text,
  instagram text,
  endereco text,
  logo_url text,
  slug text,

  -- plano / assinatura
  plano text,
  recorrencia text,
  acesso_ate timestamptz,
  ultimo_acesso timestamptz,
  limite_usuarios integer,
  qtd_vendedores integer,
  usuario_adicional integer,

  -- flags
  ativo boolean not null default true,
  cadastro_completo boolean not null default false,
  primeiro_acesso boolean not null default true,
  aguardando_aprovacao boolean not null default true,
  beta boolean not null default false,
  super_beta boolean not null default false,
  novos_modelos boolean not null default false,
  novas_cores boolean not null default false,
  info_pagto_assinatura boolean not null default false,
  assinatura_irregular boolean not null default false,
  primeiro_pagto boolean not null default false,
  adiciona_dias boolean not null default false,

  -- fiscal
  fiscal_ativo boolean not null default false,
  fiscal_cnpj text,
  fiscal_ie text,
  regime_tributario text,
  certificado_ref text,
  rf_fiscal_ref text,

  -- add-ons
  addon_assistencia boolean not null default true,
  addon_emp_fiscal text,
  addon_os_planos text,

  -- integracao
  asaas_customer_id text,
  assinatura_ref text,
  api_key text,
  project_ref text,
  carteira_ref text,
  engajamento_ref text,
  fatura_url text,
  configuracoes_gerais jsonb,

  -- CRM
  crm_acesso_ate timestamptz,

  -- termos
  termos text,
  termo_empresa text,
  id_visual text,

  -- audit
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by text
);

create index idx_empresas_cnpj on empresas(cnpj) where cnpj is not null;
create index idx_empresas_ativo on empresas(ativo) where ativo = true;

comment on table empresas is 'Cadastro de empresas (tenants). Tabela raiz do multi-tenancy.';
