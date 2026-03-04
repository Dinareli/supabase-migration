-- Migration 00016: Schema V2 completo (tabelas, views, RLS, policies, triggers)
-- Fonte: output/schema_v2.sql. Empresas e empresa_empresas_acesso já existem (00002, 00015).

-- ============================================================================
create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create table usuarios (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  auth_uid uuid unique,                -- referencia para auth.users

  -- perfil
  nome text,
  sobrenome text,
  email text,
  cpf text,
  telefone text,
  telefone_mascarado text,
  telefone_whatsapp text,
  data_nascimento text,
  foto_url text,

  -- vinculo atual
  empresa_web_id bigint references empresas(id),
  empresa_app_id bigint references empresas(id),
  funcao_logada_ref text,
  funcao_vinculada_ref text,
  departamento text,
  perfil text,

  -- estado
  ativo boolean not null default true,
  basico_completo text,
  acesso_master boolean not null default false,
  logo_empresa_url text,
  logo_empresa2_url text,

  -- CRM
  crm_nome_chat text,
  crm_dados_user_ref text,
  whatsapp_instancia_ref text,

  -- engagement
  ultimo_changelog text,
  nps text,
  nps_geral_respondido boolean not null default false,
  como_conheceu text,
  token text,
  pesquisa_churn_ref text,
  atualiza_pag text,
  permissao_inativo text,

  -- audit
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_usuarios_email on usuarios(email) where email is not null;
create index idx_usuarios_auth_uid on usuarios(auth_uid) where auth_uid is not null;
create index idx_usuarios_empresa_web on usuarios(empresa_web_id);
create index idx_usuarios_empresa_app on usuarios(empresa_app_id);
create index idx_usuarios_ativo on usuarios(ativo) where ativo = true;

-- Lista de usuarios para uso em listas/dropdowns (fonte: própria tabela usuarios)
create or replace view usuarios_lista as
select id, nome, sobrenome, email, empresa_web_id, empresa_app_id, ativo
from usuarios
where ativo = true
order by nome nulls last, id;

-- ============================================================================

-- Coluna created_by na tabela de junção (criada em 00015 sem esta coluna)
alter table empresa_empresas_acesso add column created_by bigint references usuarios(id);

-- ============================================================================
create table assinaturas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- asaas
  asaas_customer_id text,
  asaas_descricao text,
  asaas_parcela text,
  asaas_evento text,
  asaas_status text,
  asaas_valor_recebido numeric(12,2),

  -- dados
  mensalidade numeric(12,2),
  plano text,
  recorrencia text,
  total_pago numeric(12,2),
  ticket_medio numeric(12,2),

  -- datas
  data_criacao_assinatura timestamptz,
  data_acesso_ate timestamptz,
  data_cancelamento timestamptz,

  -- flags
  ativo boolean not null default false,
  cancelado boolean not null default false,
  motivo_cancelamento text,
  tipo_motivo_cancelamento text,

  -- assinante
  nome_assinante text,
  contato_assinante text,
  cidade_assinante text,
  uf_assinante text,
  observacoes text,
  forma_entrada text,
  cupom_ativado text,
  d_token text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_assinaturas_empresa on assinaturas(empresa_id);
create index idx_assinaturas_ativo on assinaturas(ativo) where ativo = true;

-- ============================================================================
-- 7. CONFIGURACAO: LOGS DE ATIVIDADE
-- ============================================================================
create table logs_atividade (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  acao text,
  botao text,
  tela text,
  codigo text,
  usuario_ref text,
  cliente_fornecedor text,
  info_deletada text,
  info_modificada text,
  info_modificada_bateria text,
  info_modificada_custo text,
  info_modificada_imei text,
  info_modificada_obs_externa text,
  info_modificada_obs_interna text,
  info_modificada_produtos text,
  info_modificada_qtd text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_logs_atividade_empresa on logs_atividade(empresa_id);
create index idx_logs_atividade_created on logs_atividade(created_at);

-- ============================================================================
-- 8. CONFIGURACAO: CHECKLISTS
-- ============================================================================
create table checklists (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  codigo text,
  descricao text,
  tipo_uso text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_checklists_empresa on checklists(empresa_id);

-- ============================================================================
-- 9. CONFIGURACAO: VINCULACOES (forma pagto <-> conta)
-- ============================================================================
create table conf_vinculacoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  compensacao integer,
  conta text,
  forma_pagto text,
  forma_pagto_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_conf_vinculacoes_empresa on conf_vinculacoes(empresa_id);

-- ============================================================================
-- 10. CONFIGURACAO: ETIQUETAS (config de impressao)
-- ============================================================================
create table conf_etiquetas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- campos visiveis na etiqueta
  tipo_prod_os text,
  subtipo_prod_os text,
  exibir_nome_produto boolean not null default false,
  exibir_imei boolean not null default false,
  exibir_num_serie boolean not null default false,
  exibir_sku boolean not null default false,
  exibir_cod_interno boolean not null default false,
  exibir_cor boolean not null default false,
  exibir_categoria boolean not null default false,
  exibir_bateria boolean not null default false,
  exibir_memoria boolean not null default false,
  exibir_armazenamento boolean not null default false,
  exibir_especificacoes boolean not null default false,
  exibir_preco_venda boolean not null default false,

  -- config impressao
  scan_cod_barra text,
  nome_etiqueta text,
  altura_etiqueta numeric(8,2),
  largura_etiqueta numeric(8,2),
  largura_codigo numeric(8,2),
  logo_url text,
  modelo_impressao text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_conf_etiquetas_empresa on conf_etiquetas(empresa_id);

-- ============================================================================
-- 11. CONFIGURACAO: TERMOS DE GARANTIA
-- ============================================================================
create table conf_termos_garantia (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  uso_termo text,
  titulo text,
  texto text,
  padrao boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_conf_termos_garantia_empresa on conf_termos_garantia(empresa_id);

-- ============================================================================
-- 12. CONFIGURACAO: CHAVES PIX
-- ============================================================================
create table conf_chaves_pix (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  conta text,
  chave_pix text,
  forma_pagto text,
  forma_pagto_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_conf_chaves_pix_empresa on conf_chaves_pix(empresa_id);

-- ============================================================================
-- 13. REFERENCIA: CIDADES BRASILEIRAS
-- ============================================================================
create table cidades_br (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  nome text not null,
  nome_normalizado text,
  uf text not null,
  uf_texto text,
  ibge integer,
  estado_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cidades_br_uf on cidades_br(uf);
create index idx_cidades_br_ibge on cidades_br(ibge) where ibge is not null;
create index idx_cidades_br_nome on cidades_br(nome_normalizado);

-- ============================================================================
-- 14. CONFIGURACAO: CONTAS FINANCEIRAS
-- ============================================================================
create table contas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  saldo numeric(14,2) not null default 0,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_contas_empresa on contas(empresa_id);

-- ============================================================================
-- 15. CONFIGURACAO: FUNCOES (roles de usuario)
-- ============================================================================
create table funcoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  nome text not null,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_funcoes_empresa on funcoes(empresa_id);

-- ============================================================================
-- 16. CONFIGURACAO: PERMISSOES POR FUNCAO
-- ============================================================================
create table permissoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  funcao_id bigint references funcoes(id),
  nome_funcao text,

  -- permissoes por modulo (listas serao normalizadas na junction funcao_permissao)
  -- mantidas aqui para compatibilidade inicial
  perm_home text,
  perm_cadastro text,
  perm_operacoes text,
  perm_financeiro text,
  perm_relatorios text,
  perm_utilidades text,
  perm_fiscal text,
  perm_adicional text,
  perm_assistencia text,
  perm_configuracoes text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_permissoes_empresa on permissoes(empresa_id);
create index idx_permissoes_funcao on permissoes(funcao_id);

-- ============================================================================
-- 17. CONFIGURACAO: MAQUINAS DE CARTAO
-- ============================================================================
create table maquinas_cartao (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  desativado boolean not null default false,
  conta text,
  maquina text,
  forma_pagto text,
  tempo_compensacao integer not null default 0,
  forma_pagto_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_maquinas_cartao_empresa on maquinas_cartao(empresa_id);

-- ============================================================================
-- 18. CONFIGURACAO: TAXAS DE CARTAO
-- ============================================================================
create table taxas_cartao (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- taxas cliente (percentual)
  cliente_amex numeric(6,4),
  cliente_elo numeric(6,4),
  cliente_master numeric(6,4),
  cliente_visa numeric(6,4),
  cliente_outras numeric(6,4),

  -- taxas loja (percentual)
  loja_amex numeric(6,4),
  loja_elo numeric(6,4),
  loja_master numeric(6,4),
  loja_visa numeric(6,4),
  loja_outras numeric(6,4),

  maquina text,
  parcela_nova numeric(6,4),
  ordem_parcelas numeric(6,4),
  parcela text,
  display integer,
  parcelas_debito_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_taxas_cartao_empresa on taxas_cartao(empresa_id);

-- ============================================================================
-- 19. CONFIGURACAO: MODELOS DE ETIQUETA (layout impressao)
-- ============================================================================
create table conf_modelos_etiqueta (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  padrao boolean not null default false,
  nome_modelo text,
  altura_pagina numeric(8,2),
  largura_pagina numeric(8,2),
  margem_lateral numeric(8,2),
  margem_superior numeric(8,2),
  altura_etiqueta numeric(8,2),
  largura_etiqueta numeric(8,2),
  max_etiquetas integer,
  colunas integer,
  linhas integer,
  dimensao_pagina text,
  entre_etiquetas numeric(8,2),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_conf_modelos_etiqueta_empresa on conf_modelos_etiqueta(empresa_id);

-- ============================================================================
-- 20. PRODUTOS: CATEGORIAS
-- ============================================================================
create table categorias (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  deletavel boolean not null default true,
  nome text not null,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_categorias_empresa on categorias(empresa_id);

-- ============================================================================
-- 21. PRODUTOS: CORES
-- ============================================================================
create table cores (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cores_empresa on cores(empresa_id);

-- ============================================================================
-- 22. PRODUTOS: GRUPOS
-- ============================================================================
create table grupos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_grupos_empresa on grupos(empresa_id);

-- ============================================================================
-- 23. PRODUTOS: LOCAIS DE ESTOQUE
-- ============================================================================
create table locais_estoque (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  cor_identificacao text,
  finalidade text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_locais_estoque_empresa on locais_estoque(empresa_id);

-- ============================================================================
-- 24. PRODUTOS: MARCAS
-- ============================================================================
create table marcas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  criado_admin boolean not null default false,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_marcas_empresa on marcas(empresa_id);

-- ============================================================================
-- 25. PRODUTOS: MODELOS DE PRODUTO
-- ============================================================================
create table modelos_produto (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  criacao text,
  grupo text,
  marca text,
  memoria text,
  nome text,
  txts_memoria text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 26. PRODUTOS: CATALOGO
-- ============================================================================
create table produtos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  nome_concatenado text,
  sku text,
  cod_interno text,

  -- precos
  preco_varejo numeric(12,2),
  preco_atacado numeric(12,2),
  preco_ajustado numeric(12,2),
  custo_medio numeric(12,2),
  custo_total_acessorios numeric(12,2),
  venda_total_acessorios numeric(12,2),
  custo_externa numeric(12,2),
  custo_interna numeric(12,2),

  -- estoque
  saldo_estoque numeric(12,2) not null default 0,
  estoque_minimo numeric(12,2),
  estoque_maximo numeric(12,2),
  troca_minimo numeric(12,2),
  troca_maximo numeric(12,2),
  saldo_fiscal numeric(12,2),
  emp_saldo_fiscal numeric(12,2),
  estoque_acessorio numeric(12,2),

  -- classificacao
  categoria_id bigint references categorias(id),
  grupo_id bigint references grupos(id),
  marca_id bigint references marcas(id),
  cor_ref text,
  memoria text,
  memoria_pc text,
  subtipo text,
  tipo_produto_os text,

  -- flags
  servico_avaria boolean not null default false,
  remover boolean not null default false,

  -- textos denormalizados (para manter compat, idealmente usar JOIN)
  txt_especificacoes text,
  txt_memoria text,
  txt_subtipo_produto text,
  txt_tipo_produto text,
  txt_memoria_pc_os_esp text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_produtos_empresa on produtos(empresa_id);
create index idx_produtos_sku on produtos(empresa_id, sku) where sku is not null;
create index idx_produtos_categoria on produtos(categoria_id);
create index idx_produtos_grupo on produtos(grupo_id);
create index idx_produtos_marca on produtos(marca_id);
create index idx_produtos_ativo on produtos(empresa_id, ativo) where ativo = true;
create index idx_produtos_nome on produtos(empresa_id, nome);

-- ============================================================================
-- 27. CLIENTES
-- ============================================================================
create table clientes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text,
  cpf_cnpj text,
  cpf_cnpj_normalizado text,
  email text,
  telefone text,
  ddi integer,
  instagram text,

  -- dados pessoais
  data_nascimento date,
  mes_aniversario integer check (mes_aniversario between 1 and 12),
  dia_aniversario integer check (dia_aniversario between 1 and 31),
  genero text,
  genero_txt text,
  tipo_cliente text,
  info_adicional text,
  como_conheceu text,
  outra_forma text,

  -- endereco
  end_rua text,
  end_complemento text,
  end_numero text,
  end_bairro text,
  end_cidade text,
  end_cep text,
  end_uf text,

  -- flags
  possui_emp boolean not null default false,
  emp_ativos text,

  -- estatisticas (desnormalizadas - atualizadas por triggers/app)
  total_atendimentos integer not null default 0,
  ultimo_ate_data timestamptz,
  total_os integer not null default 0,
  ultima_os_data timestamptz,
  qtd_caracteres integer,

  -- credito
  credito_vendas numeric(12,2) not null default 0,
  carteira_usuario_ref text,

  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_clientes_empresa on clientes(empresa_id);
create index idx_clientes_cpf on clientes(empresa_id, cpf_cnpj_normalizado) where cpf_cnpj_normalizado is not null;
create index idx_clientes_nome on clientes(empresa_id, nome);
create index idx_clientes_telefone on clientes(empresa_id, telefone) where telefone is not null;
create index idx_clientes_ativo on clientes(empresa_id, ativo) where ativo = true;

-- ============================================================================
-- 28. FORNECEDORES
-- ============================================================================
create table fornecedores (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text,
  cpf_cnpj text,
  cod_interno text,
  tipo_prod_vendido text,
  email text,
  telefone_principal text,
  telefone_secundario text,
  tipo_fornecedor text,
  nota_fornecedor text,
  pix text,

  -- PJ
  razao_social text,
  inscricao_estadual text,
  inscricao_municipal text,
  tipo_contribuinte text,

  -- endereco
  end_rua text,
  end_numero text,
  end_bairro text,
  end_cep text,
  end_cidade text,
  end_uf text,

  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_fornecedores_empresa on fornecedores(empresa_id);
create index idx_fornecedores_cpf on fornecedores(empresa_id, cpf_cnpj) where cpf_cnpj is not null;

-- ============================================================================
-- 29. AVARIAS (tipos de defeito)
-- ============================================================================
create table avarias (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_avarias_empresa on avarias(empresa_id);

-- ============================================================================
-- 30. AVARIAS ASSOCIADAS (avaria <-> produto com valor)
-- ============================================================================
create table avarias_associadas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  avaria_id bigint references avarias(id),
  produto_id bigint references produtos(id),
  valor numeric(12,2),
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_avarias_assoc_empresa on avarias_associadas(empresa_id);
create index idx_avarias_assoc_avaria on avarias_associadas(avaria_id);
create index idx_avarias_assoc_produto on avarias_associadas(produto_id);

-- ============================================================================
-- 31. TRANSACOES: ATENDIMENTOS (tabela principal de vendas)
-- ============================================================================
create table atendimentos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- identificacao
  cod_atendimento text,
  id_unico text,
  slug text,

  -- status
  concretizado boolean not null default false,
  cancelado boolean not null default false,
  devolvido boolean not null default false,
  status text check (status in ('aberto','concretizado','cancelado','devolvido')),
  lanca_ativo boolean not null default true,
  lanca_estoque boolean not null default true,

  -- participantes
  atendente_ref text,
  vendedor_ref text,
  criado_por text,
  cliente_id bigint references clientes(id),
  cli_cpf text,
  cli_nome text,
  cli_informacoes text,
  cli_intencao text,

  -- datas
  data_venda timestamptz,
  data_cancelamento timestamptz,
  cancelado_por text,
  motivo_cancelamento text,

  -- valores
  total_custo_vb numeric(12,2),
  total_bruto numeric(12,2),
  total_taxas numeric(12,2),
  total_custo_vb_taxas numeric(12,2),
  total_liquido numeric(12,2),
  lucro_bruto numeric(12,2),
  lucro_operacional numeric(12,2),
  valor_frete numeric(12,2),

  -- custos por tipo
  bri_custo_total numeric(12,2),
  tro_custo_total numeric(12,2),
  ven_custo_total numeric(12,2),

  -- pagamento resumo
  pagto_cartao numeric(12,2),
  pagto_desc_total numeric(12,2),
  pagto_dinheiro numeric(12,2),
  pagto_pix numeric(12,2),
  pagto_ted numeric(12,2),
  desconto_adicional numeric(12,2),
  desconto_produto numeric(12,2),

  -- fiscal
  doc_fiscal text,
  tipo_fiscal text,
  nf_cod_ent text,
  nf_cod_sai text,

  -- documento / assinatura
  doc_file_url text,
  ass_caminho_url text,
  ass_assinado boolean not null default false,
  link_doc_assinado text,
  enviou_doc boolean not null default false,
  doc_criado boolean not null default false,
  folder_struct text,

  -- danfe
  chave text,
  url_danfe_full text,
  url_danfe_simples text,
  url_xml text,
  uuid_fiscal text,

  -- endereco
  cidade_txt text,
  estado_txt text,
  end_bairro text,
  end_cep text,
  end_cidade text,
  end_endereco text,
  end_estado text,
  end_ibge text,
  end_numero text,

  -- referencias
  ate_referencia text,
  possui_anexo boolean not null default false,
  altera_taxa_autorizado boolean not null default false,
  tipo_venda text,
  estilo_saida text,
  menu_entrada_info text,
  son text,
  tipo_interacao text,
  cod_garantia_ref text,
  cod_garantia_txt text,
  desc_acres_aprovado_por text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_atendimentos_empresa on atendimentos(empresa_id);
create index idx_atendimentos_cod on atendimentos(empresa_id, cod_atendimento);
create index idx_atendimentos_cliente on atendimentos(cliente_id);
create index idx_atendimentos_status on atendimentos(empresa_id, status);
create index idx_atendimentos_data on atendimentos(empresa_id, data_venda);
create index idx_atendimentos_concretizado on atendimentos(empresa_id, concretizado) where concretizado = true;

-- Lista de atendimentos para uso em listas/dropdowns (fonte: própria tabela atendimentos)
create or replace view atendimentos_lista as
select id, empresa_id, cod_atendimento, data_venda, status
from atendimentos
order by data_venda desc nulls last, id desc;

-- ============================================================================
-- 32. TRANSACOES: ATENDIMENTOS MODO INICIANTE
-- ============================================================================
create table atendimentos_iniciante (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  vendedor_ref text,
  cod_lancamento text,
  data_venda timestamptz,
  frete numeric(12,2),
  intencao text,
  intencao_txt text,
  obs_na_nota text,
  concretizada boolean not null default false,
  lancamento_ativo boolean not null default true,
  lanca_estoque boolean not null default true,
  cpf_cliente text,
  nome_cliente text,
  total_bruto numeric(12,2),
  criado_por text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ate_iniciante_empresa on atendimentos_iniciante(empresa_id);

-- ============================================================================
-- 33. TRANSACOES: PRE-VENDAS
-- ============================================================================
create table pre_vendas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- identificacao
  cod_lancamento text,
  ate_cod_ref text,
  ordem integer,
  id_unico text,

  -- status
  ativo boolean not null default true,
  status text,
  status_pagamento text,
  status_produtos text,
  cancelado_por text,
  data_cancelamento timestamptz,
  motivo_cancelamento text,

  -- participantes
  criado_por text,
  vendedor_ref text,
  atendente_ref text,
  cliente_id bigint references clientes(id),
  cpf_cnpj_cliente text,
  nome_cliente text,
  cli_informacoes text,

  -- valores
  data_prevenda timestamptz,
  intencao text,
  valor_prevenda numeric(12,2),
  frete numeric(12,2),
  saldo_devedor numeric(12,2),
  tipo_pagamento text,

  -- links
  link_visualizacao text,
  qr_code text,

  -- observacoes
  obs_externas text,
  obs_internas text,
  termo_garantia_ref text,

  -- documento
  possui_anexos boolean not null default false,
  documento_assinado boolean not null default false,
  url_nota text,
  link_assinatura text,
  wasabi_ref text,
  data_envio_assinatura timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pre_vendas_empresa on pre_vendas(empresa_id);
create index idx_pre_vendas_cliente on pre_vendas(cliente_id);
create index idx_pre_vendas_status on pre_vendas(empresa_id, status);

-- ============================================================================
-- 34. TRANSACOES: ITENS DE PRE-VENDA (line items)
-- ============================================================================
create table pre_venda_itens (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  pre_venda_id bigint references pre_vendas(id),
  produto_id bigint references produtos(id),
  cod_pre_venda text,
  preco_avaliacao numeric(12,2),
  tipo_lanca text,
  quantidade integer not null default 1,
  cor text,
  desconto numeric(12,2),
  acrescimo numeric(12,2),

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pv_itens_prevenda on pre_venda_itens(pre_venda_id);
create index idx_pv_itens_produto on pre_venda_itens(produto_id);

-- ============================================================================
-- 35. TRANSACOES: ATUALIZACOES DE PRE-VENDA
-- ============================================================================
create table pre_venda_atualizacoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  pre_venda_id bigint references pre_vendas(id),
  cod_pre_venda text,
  acao text,
  pagamento text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pv_atualizacoes_prevenda on pre_venda_atualizacoes(pre_venda_id);

-- ============================================================================
-- 36. TRANSACOES: COMPRAS
-- ============================================================================
create table compras (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  concretizada boolean not null default false,
  cod_nota text,
  cpf_cnpj text,
  fornecedor_id bigint references fornecedores(id),
  fornecedor_ref text,
  origem text,

  -- pagamento
  caixa text,
  forma text,
  forma_pagto_txt text,
  data_compra timestamptz,
  data_pagto timestamptz,
  pagto_frete numeric(12,2),
  pagto_imposto numeric(12,2),
  pagto_outras numeric(12,2),
  pagto_desconto numeric(12,2),
  pagto_ocorrencia text,
  pagto_quitado boolean not null default false,
  pagto_recorrencia integer,
  qtd_parcelas integer,
  total_bruto numeric(12,2),
  total_produtos numeric(12,2),
  valor_por_parcela numeric(12,2),

  -- cancelamento
  cancelada_por text,
  data_cancelamento timestamptz,
  motivo_cancelamento text,

  -- fiscal
  doc_fiscal boolean not null default false,
  id_chave text,
  nf_cod_ent text,
  menu_entrada_info text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_compras_empresa on compras(empresa_id);
create index idx_compras_fornecedor on compras(fornecedor_id);
create index idx_compras_data on compras(empresa_id, data_compra);

-- ============================================================================
-- 37. TRANSACOES: EMPRESTIMOS
-- ============================================================================
create table emprestimos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  cliente_id bigint references clientes(id),
  cliente_ref text,
  cod_interno text,
  cpf text,
  imei text,
  num_serie text,
  atendente_ref text,
  cod_lancamento text,
  data_emprestimo timestamptz,
  devolvido boolean not null default false,
  motivo text,
  observacoes text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_emprestimos_empresa on emprestimos(empresa_id);
create index idx_emprestimos_cliente on emprestimos(cliente_id);

-- ============================================================================
-- 38. TRANSACOES: TRANSFERENCIAS (entre empresas)
-- ============================================================================
create table transferencias (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  empresa_origem_id bigint references empresas(id),
  empresa_destino_id bigint references empresas(id),
  empresa_origem_ref text,
  empresa_destino_ref text,

  ativo boolean not null default true,
  codigo text,
  status text,
  usuario_origem_ref text,
  usuario_destino_ref text,
  produto_origem_id bigint references produtos(id),
  produto_destino_id bigint references produtos(id),
  produto_origem_ref text,
  produto_destino_ref text,
  custo_origem numeric(12,2),
  lan_est_produto_origem text,
  lan_est_produto_destino text,
  imei text,
  num_serie text,
  bateria text,
  cor text,
  estoque_origem text,
  quantidade integer not null default 1,
  data_atualizacao timestamptz,
  data_entrada timestamptz,
  reprovado_por text,
  origem_fornecedor text,

  -- saldos snapshot
  saldo_estoque_final_origem numeric(12,2),
  saldo_estoque_inicial_origem numeric(12,2),
  saldo_estoque_final_destino numeric(12,2),
  saldo_estoque_inicial_destino numeric(12,2),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_transferencias_empresa_orig on transferencias(empresa_origem_id);
create index idx_transferencias_empresa_dest on transferencias(empresa_destino_id);
create index idx_transferencias_status on transferencias(status);

-- ============================================================================
-- 39. TRANSACOES: SIMULACOES
-- ============================================================================
create table simulacoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  cod_lancamento text,
  altera_taxa_autorizado_por text,
  obs_interna text,
  obs_na_nota text,
  contato text,
  nome text,
  simulado_por text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_simulacoes_empresa on simulacoes(empresa_id);

-- ============================================================================
-- 40. SIMULACOES: PAGAMENTOS
-- ============================================================================
create table sim_pagamentos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  simulacao_id bigint references simulacoes(id),

  cod_simulacao text,
  forma_pagto text,
  forma_pagto_os text,
  desconto_final numeric(12,2),
  parcela integer,
  valor numeric(12,2),
  valor_com_taxa numeric(12,2),
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_sim_pagamentos_simulacao on sim_pagamentos(simulacao_id);

-- ============================================================================
-- 41. SIMULACOES: TROCAS
-- ============================================================================
create table sim_trocas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  simulacao_id bigint references simulacoes(id),

  cod_simulacao text,
  tipo_lancamento text,
  produto_ref text,
  cor text,
  avarias_ref text,
  bateria text,
  cod_interno text,
  imei text,
  proposta numeric(12,2),
  nome_cliente text,
  tel_cliente text,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_sim_trocas_simulacao on sim_trocas(simulacao_id);

-- ============================================================================
-- 42. SIMULACOES: VENDAS
-- ============================================================================
create table sim_vendas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  simulacao_id bigint references simulacoes(id),

  cod_simulacao text,
  cod_venda text,
  tipo_lancamento text,
  produto_ref text,
  cod_interno text,
  desconto numeric(12,2),
  preco numeric(12,2),
  nome_cliente text,
  tel_cliente text,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_sim_vendas_simulacao on sim_vendas(simulacao_id);

-- ============================================================================
-- 43. TRANSACOES: GARANTIAS
-- ============================================================================
create table garantias (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  cod_garantia text,
  status text,
  origem text,

  -- cliente
  cliente_id bigint references clientes(id),
  dados_cliente text,
  nome_cliente text,
  cpf_cnpj text,
  cliente_antigo text,

  -- participantes
  atendente_ref text,
  responsavel_ref text,

  -- datas
  data_garantia timestamptz,
  tipo_garantia text,
  tipo_garantia_os text,

  -- origem
  atendimento_origem_id bigint references atendimentos(id),
  atendimento_origem_ref text,
  atendimento_origem_txt text,
  os_origem_ref text,
  os_origem_txt text,

  -- produto problema (campos escalares - listas vao para junction)
  produto_problema_ref text,
  produto_problema_txt text,
  produto_os_problema_ref text,
  produto_os_problema_txt text,
  produto_problema_original_ref text,
  produto_problema_original_txt text,
  custo_produto_problema numeric(12,2),
  preco_produto_problema numeric(12,2),

  -- produto vendido (campos escalares)
  produto_vendido_ref text,
  custo_produto_vendido numeric(12,2),
  custo_produto_inicial_vendido numeric(12,2),
  preco_produto_vendido numeric(12,2),

  -- garantia destino
  atendimento_garantia_id bigint references atendimentos(id),
  atendimento_garantia_ref text,
  atendimento_garantia_txt text,
  os_garantia_ref text,
  os_garantia_txt text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_garantias_empresa on garantias(empresa_id);
create index idx_garantias_cliente on garantias(cliente_id);
create index idx_garantias_ate_origem on garantias(atendimento_origem_id);
create index idx_garantias_status on garantias(empresa_id, status);

-- ============================================================================
-- 44. TRANSACOES: ESTOQUE INICIANTE
-- ============================================================================
create table estoque_iniciante (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  cod_lancamento text,
  produto_id bigint references produtos(id),
  produto_ref text,
  produto_concatenado text,
  tipo_lancamento text,
  status text,
  entrada_ativa boolean not null default true,

  -- dados do item
  bateria text,
  categoria text,
  cor text,
  imei text,
  memoria text,
  memoria_txt text,
  num_serie text,
  cod_interno text,

  -- financeiro
  forma text,
  parcela integer,
  desconto_dado numeric(12,2),
  valor numeric(12,2),
  tro_valor_proposta numeric(12,2),
  ven_valor_venda numeric(12,2),
  venda_total numeric(12,2),

  -- cliente
  cpf text,
  nome_cliente text,
  vendedor_ref text,
  informacao_temp text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_estoque_ini_empresa on estoque_iniciante(empresa_id);
create index idx_estoque_ini_produto on estoque_iniciante(produto_id);

-- ============================================================================
-- 45. FINANCEIRO: CONTAS A PAGAR / RECEBER (CAP/CAR)
-- ============================================================================
create table cap_car (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- identificacao
  cod_lancamento text,
  id_unico text,

  -- status
  ativo boolean not null default true,
  quitado boolean not null default false,
  situacao text,
  tipo_lancamento text check (tipo_lancamento in ('pagar','receber')),
  subtipo text,
  intencao text,
  mostra_tabela boolean not null default true,

  -- referencias
  ate_cod_01 text,
  ate_cod_03 text,
  com_cod text,
  nf_cod text,
  cod_os text,

  -- descricao
  descricao text,
  informacoes_adicionais text,
  lancador text,
  usuario_criador text,
  autorizado_por text,
  desc_acres_aprovado_por text,

  -- forma pagamento
  forma text,
  forma_pagto_txt text,
  bandeira text,
  bandeira_txt text,
  maquina text,
  conta_referencia text,
  chave_pix text,
  transf_conta text,
  taxa_vinculada text,
  id_transacao text,
  botao_sem_juros boolean not null default false,

  -- valores
  valor_original numeric(14,2),
  valor_bruto_com_acres numeric(14,2),
  valor_bruto_sem_acres numeric(14,2),
  valor_liquido_receber numeric(14,2),
  valor_por_parcela numeric(14,2),
  desconto numeric(14,2),
  taxas_lojista numeric(14,2),

  -- parcelas
  parcelas_cap integer,
  parcelas_car integer,
  ocorrencia text,
  recorrencia text,
  recorrencia_txt text,
  dias_compensar integer,
  dias_compensar_negativo integer,

  -- datas
  data_movimentacao timestamptz,
  data_pagamento timestamptz,
  data_recebimento timestamptz,
  data_transacao timestamptz,
  data_vencimento timestamptz,
  data_criacao timestamptz,

  -- fluxo
  fluxo_data_unificada timestamptz,
  fluxo_tipo text,
  fluxo_valor numeric(14,2),

  -- DRE
  dre_categoria text,
  dre_categoria_txt text,
  dre_subcategoria text,
  dre_subcategoria_txt text,
  dre_uso text,

  -- fiscal
  lanca_fiscal boolean not null default false,
  cap_categ_gasto text,
  intencao_txt text,
  ref_car_parcial text,

  -- servico
  servico_executado text,
  valor_servico numeric(14,2),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cap_car_empresa on cap_car(empresa_id);
create index idx_cap_car_tipo on cap_car(empresa_id, tipo_lancamento);
create index idx_cap_car_situacao on cap_car(empresa_id, situacao);
create index idx_cap_car_vencimento on cap_car(empresa_id, data_vencimento);
create index idx_cap_car_ativo on cap_car(empresa_id, ativo) where ativo = true;
create index idx_cap_car_quitado on cap_car(empresa_id, quitado);
create index idx_cap_car_ate on cap_car(ate_cod_01) where ate_cod_01 is not null;

-- Lista de cap_car para uso em listas/dropdowns (fonte: própria tabela cap_car)
create or replace view cap_car_lista as
select id, empresa_id, cod_lancamento, tipo_lancamento, situacao, data_vencimento, valor_original, quitado, ativo
from cap_car
where ativo = true
order by data_vencimento desc nulls last, id desc;

-- ============================================================================
-- 46. FINANCEIRO: ABERTURA/FECHAMENTO DE CAIXA
-- ============================================================================
create table caixa_abertura_fechamento (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  fechado boolean not null default false,
  conta text,
  data_abertura timestamptz,
  data_fechamento timestamptz,
  saldo_abertura numeric(14,2),
  saldo_fechamento numeric(14,2),
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_caixa_af_empresa on caixa_abertura_fechamento(empresa_id);
create index idx_caixa_af_data on caixa_abertura_fechamento(empresa_id, data_abertura);

-- ============================================================================
-- 47. FINANCEIRO: HISTORICO DE CAIXA
-- ============================================================================
create table historico_caixa (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  aberto boolean not null default true,
  caixa_aberto boolean not null default true,
  data_abertura timestamptz,
  data_fechamento timestamptz,
  quem_abriu text,
  quem_fechou text,

  abre_fecha_id bigint references caixa_abertura_fechamento(id),
  abre_fecha_ref text,

  -- valores
  valor_boleto numeric(14,2),
  valor_credito numeric(14,2),
  valor_debito numeric(14,2),
  valor_dinheiro numeric(14,2),
  valor_pix numeric(14,2),
  valor_taxas numeric(14,2),
  valor_ted numeric(14,2),
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_hist_caixa_empresa on historico_caixa(empresa_id);
create index idx_hist_caixa_data on historico_caixa(empresa_id, data_abertura);

-- ============================================================================
-- 48. FINANCEIRO: SUBCATEGORIAS DRE
-- ============================================================================
create table subcategorias_dre (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  descricao text,
  uso text,
  editavel boolean not null default true,
  categoria text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_subcategorias_dre_empresa on subcategorias_dre(empresa_id);

-- ============================================================================
-- 49. FINANCEIRO: PRECIFICADOR
-- ============================================================================
create table precificador (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  valor_custo numeric(14,2),
  gravado_custos boolean not null default false,
  valor_faturamento numeric(14,2),
  gravado_faturamento boolean not null default false,
  ano integer,
  nome_mes text,
  numero_mes integer check (numero_mes between 1 and 12),
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_precificador_empresa on precificador(empresa_id);

-- ============================================================================
-- 50. FISCAL: NCM / CEST
-- ============================================================================
create table ncm_cest (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  tipo_produto text,
  categoria text,
  subcategoria text,
  ncm integer,
  cest integer,
  prioridade text,
  tipo_produto_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ncm_cest_empresa on ncm_cest(empresa_id);
create index idx_ncm_cest_ncm on ncm_cest(ncm) where ncm is not null;

-- ============================================================================
-- 51. FISCAL: NOTAS FISCAIS
-- ============================================================================
create table notas_fiscais (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- identificacao
  ativo boolean not null default true,
  nf_cod text,
  subtipo_fiscal text,
  tipo_fiscal text check (tipo_fiscal in ('nfe','nfce','nfse','entrada','saida')),
  status_nf text,
  devolvido boolean not null default false,

  -- referencias
  ate_cod text,
  com_cod text,
  data_info timestamptz,
  entrada_por text,
  atendente_ref text,
  vendedor_ref text,
  emissor text,

  -- cliente
  cli_nome text,
  cli_cpf_cnpj text,
  cli_ie text,
  tipo_pessoa text,

  -- endereco cliente
  cli_end_rua text,
  cli_end_num text,
  cli_end_bairro text,
  cli_end_cep text,
  cli_end_cidade_os text,
  cli_end_cidade_txt text,
  cli_end_estado_os text, -- Ex: Salvar como "AC" (igual o Display do OS)
  cli_end_estado_txt text,
  cli_end_ibge text,

  -- valores pagamento (saida)
  nf_sai_boleto numeric(12,2),
  nf_sai_cartao numeric(12,2),
  nf_sai_desconto numeric(12,2),
  nf_sai_dinheiro numeric(12,2),
  nf_sai_frete numeric(12,2),
  nf_sai_pix numeric(12,2),
  nf_sai_ted numeric(12,2),
  nf_sai_troca numeric(12,2),
  total_entrada numeric(12,2),
  total_saida numeric(12,2),

  -- observacoes
  obs_externa text,
  obs_interna text,

  -- SEFAZ / emissao
  chave text,
  danfe_url text,
  danfe_simples_url text,
  xml_url text,
  uuid_fiscal text,
  xml_subido boolean not null default false,
  id_chave text,
  referencia text,
  serie text,
  sequencia text,
  modelo text,
  qr_link text,
  retorno_lote text,
  retorno_nfse text,
  link_xml text,
  menu_entrada_info text,
  estados_txt text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nf_empresa on notas_fiscais(empresa_id);
create index idx_nf_tipo on notas_fiscais(empresa_id, tipo_fiscal);
create index idx_nf_chave on notas_fiscais(chave) where chave is not null;
create index idx_nf_data on notas_fiscais(empresa_id, data_info);
create index idx_nf_status on notas_fiscais(empresa_id, status_nf);

-- ============================================================================
-- 52. FISCAL: INFO FISCAL DA EMPRESA
-- Nota: campos de credenciais devem ser migrados para Supabase Vault
-- ============================================================================
create table info_fiscal (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,

  -- dados receita federal
  cnpj text,
  razao_social text,
  nome_fantasia text,
  cnae_principal text,
  cnae_principal_descricao text,
  natureza_juridica text,
  porte text,
  situacao text,
  optante_simples boolean,
  optante_mei boolean,
  inicio_atividades text,
  regime_tributario text,
  regime_tributario_txt text,
  tipo_tributacao text,
  ie text,
  im text,
  estado_ie text,
  telefone text,

  -- endereco
  end_bairro text,
  end_cep text,
  end_cidade text,
  end_concatenado text,
  end_endereco text,
  end_estado text,
  end_numero text,
  end_tipo text,
  cidade_ibge integer,
  estados_txt text,

  -- certificado digital
  -- AVISO: migrar para Supabase Vault (pgsodium)
  cert_base64 text,
  cert_expira timestamptz,
  cert_senha text,        -- SEGREDO: mover para vault
  cert_valido boolean,

  -- NFe
  nfe_serie integer,
  nfe_atual_nota integer,

  -- NFCe
  nfce_serie text,
  nfce_atual_nota integer,
  nfce_id_csc text,
  nfce_codigo_csc text,   -- SEGREDO: mover para vault

  -- NFSe
  nfse_serie text,
  nfse_atual_rps integer,
  nfse_login text,        -- SEGREDO: mover para vault
  nfse_senha text,        -- SEGREDO: mover para vault
  nfse_info_fiscal_ref text,

  -- integracao WebmaniaBR
  company_id text,
  nfe_info_fisco text,
  unidade_empresa text,
  wm_emp_uuid text,
  wmbr_access_token text,        -- SEGREDO
  wmbr_access_token_secret text, -- SEGREDO
  wmbr_bearer_access_token text, -- SEGREDO
  wmbr_consumer_key text,        -- SEGREDO
  wmbr_consumer_secret text,     -- SEGREDO
  wmbr_id text,
  wmbr_claimp_entrada text,
  wmbr_claimp_saida text,
  wmbr_tipo_tributacao text,

  -- IBS/CBS
  ibs_cbs_remover_obrigatoriedade boolean not null default false,

  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_info_fiscal_empresa on info_fiscal(empresa_id);
create unique index idx_info_fiscal_empresa_unico on info_fiscal(empresa_id) where ativo = true;

-- ============================================================================
-- 53. FISCAL: NFSe INFO FISCAL
-- ============================================================================
create table nfse_info_fiscal (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  autenticacao text,
  emissao text,
  funcoes text,
  pdf_nfse text,
  pdf_sincrono text,
  modelo text,
  versao numeric(4,1),
  codigo_servico text,
  rf_info_fiscal_ref text,
  atual_serie_rps text,
  atual_num_rps integer,
  login text,           -- SEGREDO: mover para vault
  senha text,           -- SEGREDO: mover para vault
  token text,           -- SEGREDO: mover para vault
  regime_apur_sn text,
  regime_espec_nac text,
  regime_espec_munic text,
  prox_lote_rps integer,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nfse_info_empresa on nfse_info_fiscal(empresa_id);

-- ============================================================================
-- 54. FISCAL: SERVICOS NFSe
-- ============================================================================
create table nfse_servicos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  produto text,
  valor numeric(12,2),
  nfse_ref text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nfse_servicos_empresa on nfse_servicos(empresa_id);

-- ============================================================================
-- 55. FISCAL: REGRAS NFSE
-- ============================================================================
create table rf_nfse (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  id_interno text,
  referencia text,
  cod_servico text,
  desc_servico text,
  cod_cnae integer,
  exig_iss text,
  nfse_retido boolean,
  cod_trib_munic text,
  resp_retencao text,
  nat_operacao text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_rf_nfse_empresa on rf_nfse(empresa_id);

-- ============================================================================
-- 56-61. FISCAL: REGRAS DE IMPOSTO (MVA, ICMS, ICMS-ST, FCP, IPI, PIS, COFINS)
-- ============================================================================

-- MVA
create table rf_mva (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  subcodigo text,
  uf text,
  aliquota numeric(8,4),
  estados_txt text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_mva_empresa on rf_mva(empresa_id);

-- ICMS
create table rf_icms (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  subcodigo text,
  uf text,
  aliquota numeric(8,4),
  estados_txt text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_icms_empresa on rf_icms(empresa_id);

-- ICMS-ST
create table rf_icms_st (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  subcodigo text,
  uf text,
  aliquota numeric(8,4),
  estados_txt text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_icms_st_empresa on rf_icms_st(empresa_id);

-- FCP
create table rf_fcp (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  subcodigo text,
  uf text,
  aliquota numeric(8,4),
  estados_txt text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_fcp_empresa on rf_fcp(empresa_id);

-- IPI
create table rf_ipi (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  tipo_pessoa text,
  cenario text,
  sit_tributaria text,
  cod_enquad integer,
  aliquota numeric(8,4),
  wmbr_cenario text,
  wmbr_ipi_situacoes text,
  wmbr_pessoa text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_ipi_empresa on rf_ipi(empresa_id);

-- PIS
create table rf_pis (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  tipo_pessoa text,
  cenario text,
  sit_tributaria text,
  aliquota numeric(8,4),
  wmbr_cenario text,
  wmbr_pessoa text,
  wmbr_pis_situacoes text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_pis_empresa on rf_pis(empresa_id);

-- COFINS
create table rf_cofins (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),
  id_interno text,
  tipo_pessoa text,
  cenario text,
  sit_tributaria text,
  aliquota numeric(8,4),
  wmbr_cenario text,
  wmbr_cofins_situacoes text,
  wmbr_pessoa text,
  id_unico text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);
create index idx_rf_cofins_empresa on rf_cofins(empresa_id);

-- ============================================================================
-- 62. FISCAL: ICMS INFO (regras completas de ICMS)
-- ============================================================================
create table rf_icms_info (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  id_interno text,
  tipo_pessoa text,
  cenario_fiscal text,
  sit_tribut text,
  cfop integer,
  tipo_tributacao text,

  -- aliquotas
  aliq_mva numeric(8,4),
  aliq_icms numeric(8,4),
  aliq_icms_st numeric(8,4),
  aliq_fcp numeric(8,4),
  aliq_fcp_st numeric(8,4),
  aliq_beneficio numeric(8,4),
  aliquota_icms numeric(8,4),
  aliquota_bc_icms numeric(8,4),
  aliquota_bc_icms_st numeric(8,4),
  aliquota_efet_bc_icms numeric(8,4),
  aliquota_efet_bc_icms_st numeric(8,4),
  ipi_ref text,

  -- ST retido
  bc_st_retido numeric(14,2),
  aliq_st_retido numeric(8,4),
  valor_st_retido numeric(14,2),
  valor_icms_substituto numeric(14,2),
  valor_fcp_retido numeric(14,2),
  aliq_fcp_retido numeric(8,4),

  -- efetivo
  aliq_bc_efetivo numeric(8,4),
  aliq_icms_efet numeric(8,4),
  aliq_icms_diferim numeric(8,4),
  aliq_icms_st_diferim_fcp numeric(8,4),

  -- desoneracoes
  motiv_deson_icms text,
  motiv_deson_icms_st text,

  -- WebmaniaBR mappings
  wmbr_cenario text,
  wmbr_cofins_situacoes text,
  wmbr_pessoa text,
  wmbr_tipo_tributacao text,
  icms_wmbr_motivo text,
  icms_st_wmbr_motivo text,

  id_unico text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_rf_icms_info_empresa on rf_icms_info(empresa_id);
create index idx_rf_icms_info_cfop on rf_icms_info(cfop) where cfop is not null;

-- ============================================================================
-- 63. FISCAL: PARAMETROS DE IMPOSTO
-- ============================================================================
create table parametros_imposto (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  id_interno text,
  referencia text,
  descricao text,
  sugestao_uso text,
  apelido text,
  tipo_tributacao text,
  regime_tributario text,

  -- refs para regras fiscais
  rf_cofins_ref text,
  rf_icms_ref text,
  rf_ipi_ref text,
  rf_pis_ref text,
  nat_operacao text,
  rf_nfse_ref text,
  wmbr_tipo_tributacao text,
  ibs_cbs_ref text,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_param_imposto_empresa on parametros_imposto(empresa_id);

-- ============================================================================
-- 64. FISCAL: IBS/CBS (reforma tributaria)
-- ============================================================================
create table ibs_cbs (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  tipo_tributacao text,
  tipo_pessoa text,
  cenario text,
  sit_tributaria text,
  classificacao text,
  sit_tributaria_regime_regular text,
  classificacao_regime_regular text,
  classificacao_credito_presumido text,
  aliq_ibs_credito_presumido numeric(8,4),
  aliq_cbs_credito_presumido numeric(8,4),
  aliq_ibs_diferimento_estadual numeric(8,4),
  aliq_ibs_diferimento_municipal numeric(8,4),
  aliq_cbs_diferimento numeric(8,4),
  referencia_imposto text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ibs_cbs_empresa on ibs_cbs(empresa_id);

-- ============================================================================
-- 65. FISCAL: SAT (resumo atendimento fiscal)
-- ============================================================================
create table sat_atendimentos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  concretizado boolean not null default false,
  vendedor_ref text,
  tipo_venda text,
  cli_cpf text,
  cli_nome text,
  cli_informacoes text,
  cli_intencao text,
  cod_atendimento text,
  data_venda timestamptz,
  lanca_ativo boolean not null default true,
  status text,
  estilo_saida text,
  possui_anexo boolean not null default false,
  cod_garantia_ref text,
  atendimento_id bigint references atendimentos(id),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_sat_empresa on sat_atendimentos(empresa_id);

-- ============================================================================
-- 66. ORDENS DE SERVICO (a maior tabela - 111 cols no legado)
-- ============================================================================
create table ordens_servico (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- identificacao
  cod_os text,
  cod_seq text,
  cod_task text,
  slug text,

  -- projeto / tarefa
  nome text,
  descricao text,
  resumo text,
  prioridade text,
  projeto_ref text,
  link text,

  -- status
  status text,
  status_os text,
  ativo boolean not null default true,
  aprovado boolean,

  -- participantes
  responsavel_ref text,
  criado_por text,
  finalizado_por text,
  data_task timestamptz,
  finalizado_em timestamptz,

  -- cliente
  cliente_id bigint references clientes(id),
  cpf_cliente text,
  dados_cliente text,
  nome_cliente text,
  email_cliente text,
  telefone_cliente text,

  -- produto do cliente
  produto_cliente_ref text,
  memoria_especificacao text,
  bateria text,
  cor text,
  imei text,
  num_serie text,
  estoque_local text,

  -- checklist info (dados escalares - listas na junction)
  checklist_perguntado boolean not null default false,

  -- dados do aparelho (assistencia)
  aparelho_tem_chip boolean,
  id_apple text,
  marcas_de_uso text,
  motivo_assistencia_anterior text,
  observacoes_gerais text,
  passou_assistencia_anterior boolean,
  passou_garantia_apple boolean,
  senha_aparelho_cliente text,
  senha_icloud text,
  tempo_uso text,

  -- orcamento
  preco_estimado numeric(12,2),
  orcamento_inicial numeric(12,2),
  valor_estimado_final numeric(12,2),
  custo_mao_de_obra numeric(12,2),
  prazo_orcamento text,
  validade_orcamento text,
  tipo_assistencia text,
  prazo_estimado text,

  -- pagamento
  status_pagamento text,
  saldo_devedor numeric(12,2),
  obs_pagto_cliente text,
  obs_pagto_loja text,
  pagto_frete numeric(12,2),
  termo_garantia_ref text,
  chip_devolvido boolean,

  -- totais
  total_custo_os numeric(12,2),
  total_custo_os_sem_taxas numeric(12,2),
  total_pago_cliente numeric(12,2),
  custo_pecas numeric(12,2),
  lucro_bruto_os numeric(12,2),
  lucro_os numeric(12,2),
  taxas numeric(12,2),

  -- pagamentos por forma
  pagto_boleto numeric(12,2),
  pagto_cartao numeric(12,2),
  pagto_dinheiro numeric(12,2),
  pagto_pix numeric(12,2),
  pagto_ted numeric(12,2),

  -- nota fiscal
  nota_fiscal_ref text,

  -- documentos recibo
  doc_file_url_recibo text,
  ass_caminho_url_recibo text,
  enviou_doc_recibo boolean not null default false,
  doc_criado_recibo boolean not null default false,
  assinado_recibo boolean not null default false,

  -- documentos final
  doc_file_url_final text,
  ass_caminho_url_final text,
  enviou_doc_final boolean not null default false,
  doc_criado_final boolean not null default false,
  assinado_final boolean not null default false,

  folder_struct text,
  possui_anexo boolean not null default false,

  -- local
  local_manutencao text,
  local_int_ext text,
  local_reparo text,
  desligado boolean,

  -- flags
  qr_code text,
  garantia_ref text,

  -- cancelamento
  cancelado_por text,
  data_cancelamento timestamptz,
  motivo_cancelamento text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_os_empresa on ordens_servico(empresa_id);
create index idx_os_status on ordens_servico(empresa_id, status_os);
create index idx_os_cliente on ordens_servico(cliente_id);
create index idx_os_cod on ordens_servico(empresa_id, cod_os);
create index idx_os_ativo on ordens_servico(empresa_id, ativo) where ativo = true;
create index idx_os_data on ordens_servico(empresa_id, data_task);

-- ============================================================================
-- 67. PROJETOS
-- ============================================================================
create table projetos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  nome text,
  descricao text,
  status text,
  pinned boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_projetos_empresa on projetos(empresa_id);

-- ============================================================================
-- 68. STATUS DE TAREFA (workflow steps)
-- ============================================================================
create table status_tarefa (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  nome text not null,
  cor text,
  ordem integer,
  projeto_id bigint references projetos(id),
  projeto_ref text,
  local_tipo text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_status_tarefa_empresa on status_tarefa(empresa_id);
create index idx_status_tarefa_projeto on status_tarefa(projeto_id);

-- ============================================================================
-- 69. COMENTARIOS DE TAREFA
-- ============================================================================
create table comentarios_tarefa (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  texto text,
  tipo_nota text,
  cod_task text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_comentarios_empresa on comentarios_tarefa(empresa_id);
create index idx_comentarios_task on comentarios_tarefa(cod_task) where cod_task is not null;

-- ============================================================================
-- 70. VERIFICACAO: TASK CHECKLIST
-- ============================================================================
create table checklist_items (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  feito boolean not null default false,
  tarefa_ref text,
  texto text,
  os_cod text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_checklist_items_empresa on checklist_items(empresa_id);
create index idx_checklist_items_os on checklist_items(os_cod) where os_cod is not null;

-- ============================================================================
-- 71. SUPORTE: TICKETS
-- ============================================================================
create table tickets_suporte (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  cod_ticket text,
  modulo text,
  nivel_hierarquico text,
  descricao text,
  status text,
  prioridade text,
  tipo_solicitacao text,
  nome_usuario text,
  contato text,
  aberto_por text,
  finalizado boolean not null default false,
  finalizado_por text,
  data_abertura timestamptz,
  data_fechamento timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_tickets_empresa on tickets_suporte(empresa_id);
create index idx_tickets_status on tickets_suporte(empresa_id, status);

-- ============================================================================
-- 72. DOCUMENTOS ASSINADOS
-- ============================================================================
create table documentos_assinados (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  cpf text,
  nome_completo text,
  email text,
  hash_sha256 text,
  imagem_assinatura text,
  data_assinatura timestamptz,
  token bigint,
  caminho_url text,
  celular text,
  ip_address text,
  detalhes_ip text,
  detalhes_dispositivo text,
  identificador text,
  abriu_primeira_vez boolean,
  cidade_ip text,
  estado text,
  pais_ip text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_docs_assinados_empresa on documentos_assinados(empresa_id);

-- ============================================================================
-- 73. CRM: INSTANCIAS (WhatsApp)
-- ============================================================================
create table crm_instancias (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  status text,
  chave text,
  nome text,
  foto_conectado text,
  log_conexao text,
  nome_conexao text,
  owner_numero bigint,
  canal_conectado text,
  qrcode text,
  url text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_crm_instancias_empresa on crm_instancias(empresa_id);

-- ============================================================================
-- 74. CRM: ETAPAS DO FUNIL
-- ============================================================================
create table crm_etapas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  funil_ref text,
  ativo boolean not null default true,
  nome text not null,
  ordem integer,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_crm_etapas_empresa on crm_etapas(empresa_id);

-- ============================================================================
-- 75. CRM: FUNIS
-- ============================================================================
create table crm_funis (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  nome text not null,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_crm_funis_empresa on crm_funis(empresa_id);

-- ============================================================================
-- 76. CRM: EVENTOS
-- ============================================================================
create table crm_eventos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  titulo text,
  nome text,
  descricao text,
  tipo text,
  prioridade text,
  interesse text,
  tipo_reuniao text,
  informacoes_adicionais text,

  contato_relacionado text,
  responsavel_ref text,
  tempo_atendimento text,

  data_inicio timestamptz,
  data_fim timestamptz,
  data_vencimento timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_crm_eventos_empresa on crm_eventos(empresa_id);
create index idx_crm_eventos_data on crm_eventos(empresa_id, data_inicio);

-- ============================================================================
-- 77. CRM: DADOS USUARIO (metricas por usuario)
-- ============================================================================
create table crm_dados_usuario (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  usuario_ref text,
  finalizados_sem_mensagem integer not null default 0,
  finalizados_com_mensagem integer not null default 0,
  finalizados integer not null default 0,
  atendidos integer not null default 0,
  transfer_recebidos integer not null default 0,
  transfer_enviados integer not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_crm_dados_usuario_empresa on crm_dados_usuario(empresa_id);

-- ============================================================================
-- 78. CRM: TAREFAS CRM (Leads)
-- ============================================================================
create table tarefas_crm (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  empresa_manual text,
  codigo text,
  nome text,
  telefone text,
  instagram text,
  email text,
  origem text,
  fase_funil text,
  status text,
  interesse text,
  responsavel_ref text,
  assistencia text,
  loja_fisica text,
  entrada text,
  fim_teste timestamptz,
  data timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_tarefas_crm_empresa on tarefas_crm(empresa_id);
create index idx_tarefas_crm_status on tarefas_crm(empresa_id, status);

-- ============================================================================
-- 79. METAS: GERAIS
-- ============================================================================
create table metas_gerais (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  periodo text,
  dias_uteis integer,
  tipo_meta text,
  quem_lancou text,
  salvo boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_metas_gerais_empresa on metas_gerais(empresa_id);

-- ============================================================================
-- 80. METAS: COLABORADOR
-- ============================================================================
create table metas_colaborador (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  meta_geral_id bigint references metas_gerais(id),
  meta_vinculada_ref text,
  data_meta timestamptz,
  codigo text,
  colaborador_ref text,

  -- KPIs
  kpi_fat_geral numeric(14,2),
  kpi_fat_disp numeric(14,2),
  kpi_fat_acess numeric(14,2),
  kpi_qtd_disp integer,
  kpi_qtd_acess integer,
  kpi_luc_disp numeric(14,2),
  kpi_luc_acess numeric(14,2),
  kpi_usados numeric(14,2),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_metas_colab_empresa on metas_colaborador(empresa_id);
create index idx_metas_colab_geral on metas_colaborador(meta_geral_id);

-- ============================================================================
-- 81. MARKETING: CUPONS
-- ============================================================================
create table cupons (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  ativo boolean not null default true,
  cupom text not null,
  id_unico text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 82. MARKETING: LISTA VIP
-- ============================================================================
create table lista_vip (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  como_conheceu text,
  email text,
  nome text,
  nome_empresa text,
  telefone text,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 83. NOTIFICACOES
-- ============================================================================
create table notificacoes (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  tipo text,
  descricao text,
  vinculo_ate_ref text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_notificacoes_empresa on notificacoes(empresa_id);

-- ============================================================================
-- 84. API: CHAVES
-- Nota: Consumer Key/Secret devem migrar para Supabase Vault
-- ============================================================================
create table api_keys (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  nome text,
  consumer_key text,     -- SEGREDO: mover para vault
  consumer_secret text,  -- SEGREDO: mover para vault
  ativo boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_api_keys_empresa on api_keys(empresa_id);

-- ============================================================================
-- 85. API: LOGS
-- ============================================================================
create table api_logs (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  data_hora timestamptz,
  status_code smallint,
  endpoint jsonb,
  parametros_filtros text,
  -- authorization/keys removidos por seguranca no novo schema

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_api_logs_empresa on api_logs(empresa_id);
create index idx_api_logs_data on api_logs(empresa_id, data_hora);

-- ============================================================================
-- 86. API: RATE LIMIT
-- ============================================================================
create table api_rate_limits (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  api_key_ref text,
  limite_diario integer not null default 1000,
  ultima_requisicao timestamptz,
  requisicoes_do_dia integer not null default 0,
  requisicoes_totais bigint not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_api_rate_empresa on api_rate_limits(empresa_id);

-- ============================================================================
-- 87. WHATSAPP: DISTRIBUIDOR
-- ============================================================================
create table whatsapp_distribuidor (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  ultimo integer,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 88. CHANGELOG
-- ============================================================================
create table changelog (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  tipo text,
  versionamento text,
  descricao text,
  publicacao timestamptz,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 89. FORMULARIOS (dados de leads)
-- ============================================================================
create table formularios (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  atuacao text,
  origem text,
  info_adicional jsonb,
  instagram jsonb,
  lead jsonb,
  nome_empresa jsonb,
  telefone jsonb,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 90. NPS GERAL
-- ============================================================================
create table nps_geral (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  usuario_ref text,
  funcao text,
  q1 smallint check (q1 between 1 and 10),
  q2 smallint check (q2 between 1 and 10),
  q3 smallint check (q3 between 1 and 10),
  q4 smallint check (q4 between 1 and 10),
  q5 smallint check (q5 between 1 and 10),
  comentario text,
  func_mais_gosta text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nps_geral_empresa on nps_geral(empresa_id);

-- ============================================================================
-- 91. ESTATISTICAS
-- ============================================================================
create table estatisticas (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  data timestamptz,
  kpi text,
  valor numeric(14,2),

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_estatisticas_data on estatisticas(data);
create index idx_estatisticas_kpi on estatisticas(kpi);

-- ============================================================================
-- 92. ENGAJAMENTO
-- ============================================================================
create table engajamento (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  data timestamptz,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_engajamento_empresa on engajamento(empresa_id);

-- ============================================================================
-- 93. UTILIZACAO DE SUBMODULOS
-- ============================================================================
create table utilizacao_submodulos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  -- cadastro
  cad_produtos integer default 0,
  cad_grupos integer default 0,
  cad_marcas integer default 0,
  cad_avarias integer default 0,
  cad_cores integer default 0,
  cad_categorias integer default 0,
  cad_local integer default 0,
  cad_cliente integer default 0,
  cad_fornecedor integer default 0,

  -- operacoes
  ops_atendimento integer default 0,
  ops_estoque integer default 0,
  ops_simular_venda integer default 0,
  ops_simular_taxas integer default 0,
  ops_comodato integer default 0,
  ops_pre_venda integer default 0,
  ops_garantia integer default 0,
  ops_estoque_inutilizado integer default 0,

  -- financeiro
  fin_conta_receber integer default 0,
  fin_conta_pagar integer default 0,
  fin_compras integer default 0,
  fin_dre integer default 0,

  -- relatorios
  rel_cadastros integer default 0,
  rel_vendas integer default 0,
  rel_estoque integer default 0,
  rel_financeiro integer default 0,
  rel_trafego_pago integer default 0,
  rel_gerencial integer default 0,
  rel_fiscal integer default 0,
  rel_assistencia integer default 0,

  -- utilidades
  uti_tabela_venda integer default 0,
  uti_tabela_troca integer default 0,
  uti_tabela_avarias integer default 0,
  uti_tabela_servicos integer default 0,
  uti_ajuste_estoque integer default 0,
  uti_transferencia integer default 0,
  uti_estoque_compartilhado integer default 0,
  uti_etiquetas integer default 0,

  -- fiscal
  fis_instrucoes integer default 0,
  fis_nota_entrada integer default 0,
  fis_nota_saida integer default 0,
  fis_nota_canceladas integer default 0,
  fis_estoque_fiscal integer default 0,
  fis_regras_fiscais integer default 0,
  fis_ncm_cest integer default 0,
  fis_configuracoes integer default 0,
  fis_nota_servico integer default 0,
  fis_monitor_fiscal integer default 0,

  -- assistencia
  ass_ordem_servico integer default 0,
  ass_estoque_manutencao integer default 0,
  ass_estoque_pecas integer default 0,
  ass_esteira_manutencao integer default 0,
  ass_servicos integer default 0,
  ass_checklist integer default 0,
  ass_garantia integer default 0,

  -- adicional
  adi_trafego_pago integer default 0,
  adi_crm integer default 0,
  adi_agenda_comercial integer default 0,
  adi_metas integer default 0,
  adi_marketplace integer default 0,
  adi_chave_api integer default 0,
  adi_patrimonio integer default 0,
  adi_devocional integer default 0,
  adi_auditoria_interna integer default 0,

  -- configuracoes
  con_gerais integer default 0,
  con_troca_usuario integer default 0,
  con_troca_loja integer default 0,
  con_dar_sugestao integer default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_util_submod_empresa on utilizacao_submodulos(empresa_id);

-- ============================================================================
-- 94. PATRIMONIO
-- ============================================================================
create table patrimonios (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ativo boolean not null default true,
  tipo text,
  identificador text,
  descricao text,
  valor numeric(14,2),
  responsavel_ref text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_patrimonios_empresa on patrimonios(empresa_id);

-- ============================================================================
-- 95. CHECKLIST DE AVALIACAO
-- ============================================================================
create table checklist_avaliacao (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  estoque_ref text,
  aprovados text,
  reprovados text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 96. CARTEIRA (tokens/creditos da plataforma)
-- ============================================================================
create table carteiras (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  token_comprado integer not null default 0,
  total_token integer not null default 0,
  cota_mensal_atual integer not null default 0,
  saldo_comprado numeric(14,2) not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_carteiras_empresa on carteiras(empresa_id);

-- ============================================================================
-- 97. DEVOCIONAL
-- ============================================================================
create table devocionais (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,

  data date,
  titulo text,
  referencia text,
  devocional text,
  destaque text,
  texto_apoio text,
  reflexao text,
  pedido text,
  autor text,
  fonte text,
  audio text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

-- ============================================================================
-- 98. PESQUISA CHURN
-- ============================================================================
create table pesquisa_churn (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  nome_usuario text,
  email_usuario text,
  funcao text,
  pergunta_01 text,
  pergunta_02 text,
  pergunta_03 text,
  pergunta_04 text,
  pergunta_05 text,
  pergunta_06 text,
  pergunta_07 text,
  pergunta_08 text,
  pergunta_09 text,
  pergunta_10 text,
  pressionou_responder_depois boolean not null default false,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pesquisa_churn_empresa on pesquisa_churn(empresa_id);

-- ============================================================================
-- 99-100. VERIFICACAO: CONTAS A PAGAR / RECEBER (utility tables)
-- ============================================================================
create table verif_contas_pagar (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ate_cod text,
  ativo boolean,
  caixa text,
  cod_lancamento text,
  data_pagto timestamptz,
  descricao_pagto text,
  forma_pagto text,
  forma_pagto_os text,
  intencao_os text,
  ocorrencia text,
  qtd_parcelas integer,
  quitado boolean,
  recorrencia text,
  valor_bruto numeric(14,2),
  valor_parcela numeric(14,2),
  com_cod text,
  intencao text,
  lancador text,
  subtipo text,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_verif_cp_empresa on verif_contas_pagar(empresa_id);

create table verif_contas_receber (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  empresa_id bigint not null references empresas(id),

  ate_cod_01 text,
  nome_cliente text,
  ate_cod_03 text,
  car_cod text,
  taxas_lojista numeric(14,2),
  valor_com_acrescimo numeric(14,2),
  valor_sem_acrescimo numeric(14,2),
  bandeira_os text,
  forma_pagto_os text,
  ativo boolean,
  bandeira text,
  car_cod_2 text,
  conta_receb text,
  data_comp timestamptz,
  desconto numeric(14,2),
  forma text,
  maquina text,
  parcela integer,
  situacao text,
  valor numeric(14,2),
  valor_com_taxa numeric(14,2),
  valor_negativo numeric(14,2),
  valor_positivo_pac numeric(14,2),
  valor_receber numeric(14,2),
  botao_sem_juros boolean,
  id_unico text,

  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_verif_cr_empresa on verif_contas_receber(empresa_id);

-- ============================================================================
-- CORE: DISPOSITIVOS (referenciado por usuario_dispositivo; ausente no schema_v2)
-- ============================================================================
create table dispositivos (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  created_at timestamptz not null default now()
);

create index idx_dispositivos_bubble on dispositivos(bubble_unique_id) where bubble_unique_id is not null;

-- ============================================================================
-- ============================================================================
-- TABELAS ASSOCIATIVAS (JUNCTION TABLES)
-- Substituem ~96 colunas tipo lista em 26 tabelas do schema legado
-- ============================================================================
-- ============================================================================

-- ============================================================================
-- J01. USUARIO <-> EMPRESA (multi-tenancy / acesso)
-- Substitui: User."00_EMP_Vinculadas", DB002_ACESSO."003_EmpresasAcesso"
-- ============================================================================
create table usuario_empresa (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  empresa_id bigint not null references empresas(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique(usuario_id, empresa_id)
);

create index idx_ue_usuario on usuario_empresa(usuario_id);
create index idx_ue_empresa on usuario_empresa(empresa_id);

-- ============================================================================
-- J02. USUARIO <-> DISPOSITIVO
-- Substitui: User."99_Dispositivos", DB002."050_Dispositivos"
-- ============================================================================
create table usuario_dispositivo (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  dispositivo_id bigint not null references dispositivos(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique(usuario_id, dispositivo_id)
);

create index idx_ud_usuario on usuario_dispositivo(usuario_id);
create index idx_ud_dispositivo on usuario_dispositivo(dispositivo_id);

-- ============================================================================
-- J03. USUARIO <-> INSTANCIA CRM (WhatsApp)
-- Substitui: User."09 - instancias", DB087."10 - usuariosComAcesso"
-- ============================================================================
create table usuario_instancia (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  instancia_id bigint not null references crm_instancias(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique(usuario_id, instancia_id)
);

create index idx_ui_usuario on usuario_instancia(usuario_id);
create index idx_ui_instancia on usuario_instancia(instancia_id);

-- ============================================================================
-- J04. USUARIO <-> FILA CRM
-- Substitui: User."06 - filasUsuario"
-- ============================================================================
create table usuario_fila (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  fila text not null,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_uf_usuario on usuario_fila(usuario_id);

-- ============================================================================
-- J05. TRANSFERENCIA <-> EMPRESA (visibilidade)
-- Substitui: DB042."003_EmpresasView"
-- ============================================================================
create table transferencia_empresa_view (
  id bigint generated always as identity primary key,
  transferencia_id bigint not null references transferencias(id) on delete cascade,
  empresa_id bigint not null references empresas(id) on delete cascade,
  unique(transferencia_id, empresa_id)
);

create index idx_tev_transferencia on transferencia_empresa_view(transferencia_id);
create index idx_tev_empresa on transferencia_empresa_view(empresa_id);

-- ============================================================================
-- J06. ATENDIMENTO <-> PRODUTO (venda, troca, brinde)
-- Substitui: DB029."069_VEN_PRODUTOS", "066_TRO_PRODUTOS", "037_BRI_PRODUTOS"
-- ============================================================================
create table atendimento_produto (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda','troca','brinde')),
  quantidade integer not null default 1,
  preco numeric(12,2),
  custo numeric(12,2),
  desconto numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ap_atendimento on atendimento_produto(atendimento_id);
create index idx_ap_produto on atendimento_produto(produto_id);
create index idx_ap_tipo on atendimento_produto(atendimento_id, tipo);

-- ============================================================================
-- J07. ATENDIMENTO <-> FINANCEIRO (CAP/CAR)
-- Substitui: DB029."079_z_CAP_CAR_Pagamento", "080_z_CAP_Custos", "081_z_CAR_Pagamento"
-- ============================================================================
create table atendimento_financeiro (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  tipo text not null check (tipo in ('pagamento','custo','recebimento')),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_af_atendimento on atendimento_financeiro(atendimento_id);
create index idx_af_cap_car on atendimento_financeiro(cap_car_id);

-- ============================================================================
-- J08. ATENDIMENTO <-> TERMO DE GARANTIA
-- Substitui: DB029."032_Termos-selecionados"
-- ============================================================================
create table atendimento_termo (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  termo_id bigint not null references conf_termos_garantia(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_at_atendimento on atendimento_termo(atendimento_id);

-- ============================================================================
-- J09. ATENDIMENTO <-> GARANTIA
-- Substitui: DB029."084_COD_GARANTIA"
-- ============================================================================
create table atendimento_garantia (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  garantia_id bigint not null references garantias(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ag_atendimento on atendimento_garantia(atendimento_id);
create index idx_ag_garantia on atendimento_garantia(garantia_id);

-- ============================================================================
-- J10. ATENDIMENTO <-> NF FISCAL PAGAMENTO
-- Substitui: DB029."049_FISCAL_PAGAMENTO"
-- ============================================================================
create table atendimento_fiscal_pagamento (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_afp_atendimento on atendimento_fiscal_pagamento(atendimento_id);

-- ============================================================================
-- J11. PRE-VENDA <-> PRODUTO
-- Substitui: DB038 colunas 014-019 (6 colunas de listas de produtos)
-- ============================================================================
create table pre_venda_produto (
  id bigint generated always as identity primary key,
  pre_venda_id bigint not null references pre_vendas(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda','troca','brinde')),
  is_snapshot boolean not null default false,
  quantidade integer not null default 1,
  preco numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pvp_prevenda on pre_venda_produto(pre_venda_id);
create index idx_pvp_produto on pre_venda_produto(produto_id);

-- ============================================================================
-- J12. PRE-VENDA <-> PAGAMENTO (CAP/CAR)
-- Substitui: DB038."024_Pagamentos realizados"
-- ============================================================================
create table pre_venda_pagamento (
  id bigint generated always as identity primary key,
  pre_venda_id bigint not null references pre_vendas(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pvpag_prevenda on pre_venda_pagamento(pre_venda_id);
create index idx_pvpag_capcar on pre_venda_pagamento(cap_car_id);

-- ============================================================================
-- J13. COMPRA <-> PRODUTO
-- Substitui: DB017."013_ProdutosComprados"
-- ============================================================================
create table compra_produto (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  custo numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cp_compra on compra_produto(compra_id);
create index idx_cp_produto on compra_produto(produto_id);

-- ============================================================================
-- J14. COMPRA <-> FINANCEIRO (CAP/CAR)
-- Substitui: DB017."029_CAP-CAR"
-- ============================================================================
create table compra_financeiro (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cf_compra on compra_financeiro(compra_id);
create index idx_cf_capcar on compra_financeiro(cap_car_id);

-- ============================================================================
-- J15. NOTA FISCAL <-> PRODUTO
-- Substitui: DB056."030_PRODUTOS"
-- ============================================================================
create table nf_produto (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  valor numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nfp_nf on nf_produto(nf_id);
create index idx_nfp_produto on nf_produto(produto_id);

-- ============================================================================
-- J16. NOTA FISCAL <-> SERVICO
-- Substitui: DB056."031_Servicos"
-- ============================================================================
create table nf_servico (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id) on delete cascade,
  servico_id bigint not null references nfse_servicos(id),
  valor numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nfs_nf on nf_servico(nf_id);
create index idx_nfs_servico on nf_servico(servico_id);

-- ============================================================================
-- J17. NOTA FISCAL <-> PAGAMENTO (CAP/CAR)
-- Substitui: DB056."040_PAGAMENTO-CAP"
-- ============================================================================
create table nf_pagamento (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_nfpag_nf on nf_pagamento(nf_id);
create index idx_nfpag_capcar on nf_pagamento(cap_car_id);

-- ============================================================================
-- J18. EMPRESTIMO <-> PRODUTO
-- Substitui: DB023."014_EMP_Produtos"
-- ============================================================================
create table emprestimo_produto (
  id bigint generated always as identity primary key,
  emprestimo_id bigint not null references emprestimos(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ep_emprestimo on emprestimo_produto(emprestimo_id);
create index idx_ep_produto on emprestimo_produto(produto_id);

-- ============================================================================
-- J19. HISTORICO CAIXA <-> PRODUTO (por tipo transacao)
-- Substitui: DB025."005-007_PRODUTOS_Compras/Trocas/Vendas"
-- ============================================================================
create table historico_caixa_produto (
  id bigint generated always as identity primary key,
  historico_id bigint not null references historico_caixa(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo_transacao text not null check (tipo_transacao in ('compra','troca','venda')),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_hcp_historico on historico_caixa_produto(historico_id);
create index idx_hcp_produto on historico_caixa_produto(produto_id);

-- ============================================================================
-- J20. PRODUTO <-> PRODUTO ASSOCIADO (auto-referencia)
-- Substitui: DB062."027_CODIGO-ASSOCIADO"
-- ============================================================================
create table produto_associado (
  id bigint generated always as identity primary key,
  produto_id bigint not null references produtos(id) on delete cascade,
  produto_associado_id bigint not null references produtos(id) on delete cascade,
  unique(produto_id, produto_associado_id),
  check (produto_id <> produto_associado_id)
);

create index idx_pa_produto on produto_associado(produto_id);
create index idx_pa_associado on produto_associado(produto_associado_id);

-- ============================================================================
-- J21. ATENDIMENTO INICIANTE <-> PRODUTO
-- Substitui: DB033."008_ATE_TRO_Produtos", "009_ATE_VEN_Produtos"
-- ============================================================================
create table iniciante_ate_produto (
  id bigint generated always as identity primary key,
  iniciante_ate_id bigint not null references atendimentos_iniciante(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda','troca')),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_iap_iniciante on iniciante_ate_produto(iniciante_ate_id);
create index idx_iap_produto on iniciante_ate_produto(produto_id);

-- ============================================================================
-- J22. ATENDIMENTO INICIANTE <-> PAGAMENTO
-- Substitui: DB033."007_ATE_Pagamento"
-- ============================================================================
create table iniciante_ate_pagamento (
  id bigint generated always as identity primary key,
  iniciante_ate_id bigint not null references atendimentos_iniciante(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_iapag_iniciante on iniciante_ate_pagamento(iniciante_ate_id);

-- ============================================================================
-- J23. GARANTIA <-> PRODUTO (problema, original, vendido)
-- Substitui: DB032 colunas 019-038 (listas de produtos com custos/precos)
-- ============================================================================
create table garantia_produto (
  id bigint generated always as identity primary key,
  garantia_id bigint not null references garantias(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('problema','problema_original','vendido')),
  custo numeric(12,2),
  custo_inicial numeric(12,2),
  preco numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_gp_garantia on garantia_produto(garantia_id);
create index idx_gp_produto on garantia_produto(produto_id);

-- ============================================================================
-- J24. GARANTIA <-> AVARIA
-- Substitui: DB032."017_Avarias"
-- ============================================================================
create table garantia_avaria (
  id bigint generated always as identity primary key,
  garantia_id bigint not null references garantias(id) on delete cascade,
  avaria_id bigint not null references avarias(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_ga_garantia on garantia_avaria(garantia_id);
create index idx_ga_avaria on garantia_avaria(avaria_id);

-- ============================================================================
-- J25. OS <-> CHECKLIST ITEMS
-- Substitui: DB082 "[01] - CHECKLIST", "[66]", "[67]", "[99]" (6+ colunas)
-- ============================================================================
create table os_checklist (
  id bigint generated always as identity primary key,
  os_id bigint not null references ordens_servico(id) on delete cascade,
  checklist_item_id bigint not null references checklist_items(id),
  tipo text not null check (tipo in ('principal','origem','problema','problema_inicial','posterior','posterior_origem','posterior_lista')),
  is_snapshot boolean not null default false,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_osc_os on os_checklist(os_id);
create index idx_osc_item on os_checklist(checklist_item_id);

-- ============================================================================
-- J26. OS <-> PECAS UTILIZADAS (produtos internos/externos)
-- Substitui: DB082 "[99] - Pecas_CI/SI_Utilizadas", "Lista_Pecas" (4+ colunas)
-- ============================================================================
create table os_peca (
  id bigint generated always as identity primary key,
  os_id bigint not null references ordens_servico(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  origem text not null check (origem in ('interna','externa')),
  custo numeric(12,2),
  quantidade integer not null default 1,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_osp_os on os_peca(os_id);
create index idx_osp_produto on os_peca(produto_id);

-- ============================================================================
-- J27. OS <-> SERVICOS
-- Substitui: DB082 "[71] - LISTA_SERVICO", "SERVIÇOS", "LISTA_PRECOS_SERVICOS"
-- ============================================================================
create table os_servico (
  id bigint generated always as identity primary key,
  os_id bigint not null references ordens_servico(id) on delete cascade,
  descricao text not null,
  preco numeric(12,2),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_oss_os on os_servico(os_id);

-- ============================================================================
-- J28. OS <-> FINANCEIRO (CAP/CAR)
-- Substitui: DB082 "Z - Lista_CAP-CAR"
-- ============================================================================
create table os_financeiro (
  id bigint generated always as identity primary key,
  os_id bigint not null references ordens_servico(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_osf_os on os_financeiro(os_id);
create index idx_osf_capcar on os_financeiro(cap_car_id);

-- ============================================================================
-- J29. PROJETO <-> MEMBROS
-- Substitui: DB079."[02] - MEMBROS"
-- ============================================================================
create table projeto_membro (
  id bigint generated always as identity primary key,
  projeto_id bigint not null references projetos(id) on delete cascade,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  unique(projeto_id, usuario_id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pm_projeto on projeto_membro(projeto_id);
create index idx_pm_usuario on projeto_membro(usuario_id);

-- ============================================================================
-- J30. FUNCAO <-> PERMISSAO (granular por modulo)
-- Substitui: DB014 "003-012_*-PERM" (10 colunas), DB011."002_PERMISSAO"
-- ============================================================================
create table funcao_permissao (
  id bigint generated always as identity primary key,
  funcao_id bigint not null references funcoes(id) on delete cascade,
  modulo text not null check (modulo in (
    'home','cadastro','operacoes','financeiro','relatorios',
    'utilidades','fiscal','adicional','assistencia','configuracoes'
  )),
  permissao text not null,
  created_at timestamptz not null default now(),
  unique(funcao_id, modulo, permissao)
);

create index idx_fp_funcao on funcao_permissao(funcao_id);

-- ============================================================================
-- J31. FUNIL <-> ETAPA (com ordem)
-- Substitui: DB092."03 - EtapasFunil"
-- ============================================================================
create table funil_etapa (
  id bigint generated always as identity primary key,
  funil_id bigint not null references crm_funis(id) on delete cascade,
  etapa_id bigint not null references crm_etapas(id) on delete cascade,
  ordem integer not null,
  unique(funil_id, etapa_id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_fe_funil on funil_etapa(funil_id);
create index idx_fe_etapa on funil_etapa(etapa_id);

-- ============================================================================
-- J32. CLIENTE <-> ETIQUETA/TAG
-- Substitui: DB016."027_ETIQUETAS]"
-- ============================================================================
create table cliente_etiqueta (
  id bigint generated always as identity primary key,
  cliente_id bigint not null references clientes(id) on delete cascade,
  etiqueta text not null,
  created_at timestamptz not null default now(),
  unique(cliente_id, etiqueta)
);

create index idx_ce_cliente on cliente_etiqueta(cliente_id);

-- ============================================================================
-- J33. CLIENTE <-> CREDITOS (historico entrada/saida)
-- Substitui: DB016."041_Credito Historico de entradas", "042_...saidas"
-- ============================================================================
create table cliente_credito (
  id bigint generated always as identity primary key,
  cliente_id bigint not null references clientes(id) on delete cascade,
  cap_car_id bigint not null references cap_car(id),
  tipo text not null check (tipo in ('entrada','saida')),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cc_cliente on cliente_credito(cliente_id);
create index idx_cc_capcar on cliente_credito(cap_car_id);

-- ============================================================================
-- J34. NOTIFICACAO <-> USUARIO (leitura e visibilidade)
-- Substitui: DB102."02 - [LIDO_POR]", "05 - [VISUALIZAVEL_SOMENTE_POR]"
-- ============================================================================
create table notificacao_usuario (
  id bigint generated always as identity primary key,
  notificacao_id bigint not null references notificacoes(id) on delete cascade,
  usuario_id bigint not null references usuarios(id) on delete cascade,
  tipo text not null check (tipo in ('lido','visivel')),
  created_at timestamptz not null default now(),
  unique(notificacao_id, usuario_id, tipo)
);

create index idx_nu_notificacao on notificacao_usuario(notificacao_id);
create index idx_nu_usuario on notificacao_usuario(usuario_id);

-- ============================================================================
-- J35. PRODUTO <-> ESPECIFICACAO
-- Substitui: DB062."016_CAD_Especificacoes"
-- ============================================================================
create table produto_especificacao (
  id bigint generated always as identity primary key,
  produto_id bigint not null references produtos(id) on delete cascade,
  chave text not null,
  valor text not null,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_pe_produto on produto_especificacao(produto_id);

-- ============================================================================
-- J36. DEVOCIONAL <-> KEYWORD
-- Substitui: DB126."010_keywords"
-- ============================================================================
create table devocional_keyword (
  id bigint generated always as identity primary key,
  devocional_id bigint not null references devocionais(id) on delete cascade,
  keyword text not null,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_dk_devocional on devocional_keyword(devocional_id);

-- ============================================================================
-- J37. CARTEIRA <-> RECARGAS
-- Substitui: DB124."[004] - RECARGAS"
-- ============================================================================
create table carteira_recarga (
  id bigint generated always as identity primary key,
  carteira_id bigint not null references carteiras(id) on delete cascade,
  valor numeric(14,2) not null,
  descricao text,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cr_carteira on carteira_recarga(carteira_id);

-- ============================================================================
-- J38. CHECKLIST <-> ITENS (lista de itens do template)
-- Substitui: DB004."004_ListaItens"
-- ============================================================================
create table checklist_lista_item (
  id bigint generated always as identity primary key,
  checklist_id bigint not null references checklists(id) on delete cascade,
  texto text not null,
  ordem integer,
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_cli_checklist on checklist_lista_item(checklist_id);

-- ============================================================================
-- J39. METAS GERAIS <-> METAS COLABORADOR
-- (1:N com FK - ja definido em metas_colaborador.meta_geral_id)
-- ============================================================================

-- ============================================================================
-- J40. TICKET SUPORTE <-> COMENTARIOS
-- Substitui: DB041."010_COMENTARIOS-TICKET]"
-- ============================================================================
create table ticket_comentario (
  id bigint generated always as identity primary key,
  ticket_id bigint not null references tickets_suporte(id) on delete cascade,
  comentario_id bigint not null references comentarios_tarefa(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_tc_ticket on ticket_comentario(ticket_id);

-- ============================================================================
-- J41. TAREFA CRM <-> COMENTARIOS
-- Substitui: DB081."[08] - LEAD-Comentarios"
-- ============================================================================
create table tarefa_crm_comentario (
  id bigint generated always as identity primary key,
  tarefa_crm_id bigint not null references tarefas_crm(id) on delete cascade,
  comentario_id bigint not null references comentarios_tarefa(id),
  created_at timestamptz not null default now(),
  created_by bigint references usuarios(id)
);

create index idx_tcc_tarefa on tarefa_crm_comentario(tarefa_crm_id);

-- ============================================================================
-- ============================================================================
-- COMENTARIOS NAS TABELAS
-- ============================================================================
-- ============================================================================

-- Core
comment on table empresas is 'Cadastro de empresas (tenants). Tabela raiz do multi-tenancy. Cada empresa possui plano, flags, configuracoes fiscais e integracoes (Asaas, WebmaniaBR).';
comment on table usuarios is 'Perfil de usuario vinculado a auth.users do Supabase via auth_uid. Um usuario pode pertencer a varias empresas via usuario_empresa.';
comment on table dispositivos is 'Dispositivos moveis registrados para push notifications, vinculados ao usuario.';
comment on table assinaturas is 'Historico de assinaturas/planos de cada empresa com integracao Asaas para cobranca recorrente.';

-- Configuracao
comment on table logs_atividade is 'Auditoria de acoes dos usuarios (CRUD, navegacao, alteracoes em campos criticos). Append-only.';
comment on table checklists is 'Templates de checklist reutilizaveis por empresa (ex: checklist de entrada de OS). Itens em checklist_lista_item.';
comment on table conf_vinculacoes is 'Vinculacao entre forma de pagamento e conta financeira da empresa.';
comment on table conf_etiquetas is 'Config de etiquetas de produto: campos visiveis, dimensoes de impressao, codigo de barras.';
comment on table conf_termos_garantia is 'Modelos de termos de garantia por empresa, usados em atendimentos e OS.';
comment on table conf_chaves_pix is 'Chaves PIX cadastradas pela empresa, vinculadas a conta e forma de pagamento.';
comment on table cidades_br is 'Referencia: municipios brasileiros com UF e codigo IBGE. Compartilhada entre todas as empresas (sem empresa_id).';
comment on table contas is 'Contas financeiras da empresa (caixa, banco, cofre etc). Mantem saldo atualizado.';
comment on table funcoes is 'Funcoes/roles de usuario dentro da empresa (ex: vendedor, gerente, tecnico). Permissoes granulares em funcao_permissao.';
comment on table permissoes is 'Permissoes por funcao agrupadas por modulo. Formato legado (text); normalizacao granular em funcao_permissao.';
comment on table maquinas_cartao is 'Maquinas de cartao cadastradas pela empresa com tempo de compensacao e vinculo a conta.';
comment on table taxas_cartao is 'Taxas percentuais de cartao por bandeira (Visa, Master, Elo, Amex), separadas entre cliente e loja, por parcela.';
comment on table conf_modelos_etiqueta is 'Layout de impressao de etiquetas: dimensoes de pagina, margens, colunas e linhas por folha.';

-- Produtos
comment on table categorias is 'Categorias de produto por empresa (ex: Smartphone, Acessorio, Peca).';
comment on table cores is 'Catalogo de cores de produto por empresa.';
comment on table grupos is 'Grupos de produto por empresa (ex: Apple, Samsung). Nivel acima de categoria.';
comment on table locais_estoque is 'Locais fisicos de estoque por empresa (ex: Loja, Deposito, Vitrine) com finalidade e cor de identificacao.';
comment on table marcas is 'Marcas de produto por empresa. Pode ser criada pelo admin ou pela propria empresa.';
comment on table modelos_produto is 'Catalogo compartilhado de modelos de produto (ex: iPhone 15 Pro 256GB). Sem empresa_id - dados globais.';
comment on table produtos is 'Catalogo de produtos por empresa. Precos (varejo/atacado), saldos de estoque, classificacao (categoria/grupo/marca) e flags.';

-- Clientes / Fornecedores
comment on table clientes is 'Cadastro de clientes por empresa com dados pessoais, endereco, estatisticas desnormalizadas e credito.';
comment on table fornecedores is 'Cadastro de fornecedores por empresa com dados PJ (razao social, IE, IM) e endereco.';
comment on table avarias is 'Tipos de defeito/avaria cadastrados por empresa (ex: Tela quebrada, Bateria viciada).';
comment on table avarias_associadas is 'Vinculo avaria <-> produto com valor de reparo. Precifica cada defeito por produto.';

-- Transacoes
comment on table atendimentos is 'Tabela principal de vendas. Registra venda completa com status, participantes, valores, pagamentos, fiscal e documentacao.';
comment on table atendimentos_iniciante is 'Atendimentos simplificados (modo iniciante) para empresas em fase inicial. Sem fiscal/documentos.';
comment on table pre_vendas is 'Pre-vendas/orcamentos com status de pagamento e produtos. Conversivel em atendimento. Link de visualizacao e QR code.';
comment on table pre_venda_itens is 'Itens individuais de uma pre-venda com preco de avaliacao, quantidade, desconto e acrescimo. Append-only.';
comment on table pre_venda_atualizacoes is 'Historico de atualizacoes de pre-venda (mudanca de status, pagamentos). Append-only.';
comment on table compras is 'Compras de produtos de fornecedores com forma de pagamento, parcelas, valores e notas de entrada.';
comment on table emprestimos is 'Emprestimos de produtos (comodato) para clientes com data, motivo e status de devolucao.';
comment on table transferencias is 'Transferencias de produtos entre empresas do mesmo grupo. Origem/destino, status de aprovacao e saldos. Sem empresa_id unico - usa empresa_origem_id/destino_id.';
comment on table simulacoes is 'Simulacoes de venda (orcamento rapido) sem efetivar estoque/financeiro. Detalhes em sim_pagamentos/trocas/vendas.';
comment on table sim_pagamentos is 'Pagamentos de uma simulacao: forma, parcela, valor com taxa. Append-only.';
comment on table sim_trocas is 'Itens de troca de uma simulacao: produto avaliado com proposta de valor. Append-only.';
comment on table sim_vendas is 'Itens de venda de uma simulacao: produto com preco e desconto. Append-only.';
comment on table garantias is 'Registros de garantia vinculando atendimento/OS de origem a produto com problema. Rastreia produto vendido e garantia de destino.';
comment on table estoque_iniciante is 'Lancamentos de estoque no modo iniciante: entrada/saida simplificada com dados do produto e valores.';

-- Financeiro
comment on table cap_car is 'Contas a Pagar e Receber (CAP/CAR). Lancamentos financeiros unificados com tipo (pagar/receber), forma de pagamento, DRE e fluxo de caixa.';
comment on table caixa_abertura_fechamento is 'Abertura e fechamento de caixa por empresa com saldo inicial e final.';
comment on table historico_caixa is 'Historico de caixa com valores por forma de pagamento (dinheiro, PIX, credito, debito, TED, boleto).';
comment on table subcategorias_dre is 'Subcategorias do DRE (Demonstrativo de Resultado) por empresa para classificacao de receitas/despesas.';
comment on table precificador is 'Valores mensais de custo e faturamento para calculo de markup/precificacao por empresa.';

-- Fiscal
comment on table ncm_cest is 'Vinculo NCM/CEST por tipo de produto para empresa. Usado na emissao de NF-e/NFC-e.';
comment on table notas_fiscais is 'Notas fiscais emitidas/recebidas (NF-e, NFC-e, NFS-e). Integra com SEFAZ via WebmaniaBR. Armazena chave, DANFE e XML.';
comment on table info_fiscal is 'Dados fiscais da empresa: CNPJ, regime tributario, certificado digital, config NF-e/NFC-e/NFS-e e credenciais WebmaniaBR. ATENCAO: campos de senha/token devem migrar para Supabase Vault.';
comment on table nfse_info_fiscal is 'Config especificas de NFS-e: modelo, versao, serie RPS e credenciais. ATENCAO: login/senha/token devem migrar para Vault.';
comment on table nfse_servicos is 'Servicos vinculados a uma NFS-e com produto e valor. Append-only.';
comment on table rf_nfse is 'Regras fiscais NFS-e: codigo de servico, CNAE, exigibilidade ISS, natureza da operacao.';
comment on table rf_mva is 'Regras fiscais: aliquotas de MVA (Margem de Valor Agregado) por UF. Append-only.';
comment on table rf_icms is 'Regras fiscais: aliquotas de ICMS por UF. Append-only.';
comment on table rf_icms_st is 'Regras fiscais: aliquotas de ICMS-ST (Substituicao Tributaria) por UF. Append-only.';
comment on table rf_fcp is 'Regras fiscais: aliquotas de FCP (Fundo de Combate a Pobreza) por UF. Append-only.';
comment on table rf_ipi is 'Regras fiscais: IPI por cenario, situacao tributaria e tipo de pessoa (PF/PJ). Append-only.';
comment on table rf_pis is 'Regras fiscais: PIS por cenario, situacao tributaria e tipo de pessoa. Append-only.';
comment on table rf_cofins is 'Regras fiscais: COFINS por cenario, situacao tributaria e tipo de pessoa. Append-only.';
comment on table rf_icms_info is 'Regras completas de ICMS: CFOP, MVA, ICMS-ST, FCP, desoneracao e mapeamento WebmaniaBR. Tabela mais detalhada do modulo fiscal.';
comment on table parametros_imposto is 'Conjuntos de parametros fiscais pre-configurados que referenciam regras individuais (ICMS, PIS, COFINS, IPI, NFS-e).';
comment on table ibs_cbs is 'Regras fiscais IBS/CBS da reforma tributaria brasileira. Aliquotas de credito presumido e diferimento por regime.';
comment on table sat_atendimentos is 'Resumo fiscal de atendimentos para integracao SAT. Espelha dados-chave do atendimento.';

-- OS / Projetos
comment on table ordens_servico is 'Ordens de servico (OS) para assistencia tecnica. Tabela mais complexa do sistema (~100 colunas). Dados do aparelho, orcamento, pagamento, pecas, checklist e documentos.';
comment on table projetos is 'Projetos de gerenciamento de tarefas/OS por empresa. Agrupa ordens de servico e tarefas.';
comment on table status_tarefa is 'Etapas/status do workflow de tarefas/OS dentro de um projeto (ex: Aberto, Em andamento, Finalizado). Ordenavel.';
comment on table comentarios_tarefa is 'Comentarios/notas em tarefas e OS. Vinculado via cod_task (text). TODO: migrar para FK proper.';
comment on table checklist_items is 'Itens individuais de checklist vinculados a OS via os_cod (text). Registra estado feito/pendente. TODO: migrar para FK proper.';

-- Suporte / Documentos
comment on table tickets_suporte is 'Tickets de suporte interno da plataforma com status, prioridade e dados do solicitante.';
comment on table documentos_assinados is 'Registros de assinatura digital com hash SHA-256, IP, dispositivo e dados do signatario.';

-- CRM
comment on table crm_instancias is 'Instancias de WhatsApp conectadas via API. QR code, status de conexao e dados do canal.';
comment on table crm_etapas is 'Etapas do funil CRM (ex: Novo lead, Qualificado, Proposta enviada, Fechado). Ordenavel.';
comment on table crm_funis is 'Funis de vendas CRM por empresa. Etapas vinculadas via funil_etapa junction.';
comment on table crm_eventos is 'Eventos/atividades CRM (reuniao, ligacao, visita) com datas, tipo, prioridade e responsavel.';
comment on table crm_dados_usuario is 'Metricas de performance CRM por usuario: atendimentos finalizados, transferidos e atendidos.';
comment on table tarefas_crm is 'Leads/tarefas do CRM com fase do funil, origem, interesse e responsavel. Comentarios via tarefa_crm_comentario.';

-- Metas
comment on table metas_gerais is 'Metas gerais da empresa por periodo (mensal/semanal) com tipo e dias uteis.';
comment on table metas_colaborador is 'Metas individuais por colaborador com KPIs de faturamento, quantidade e lucro (dispositivos/acessorios).';

-- Marketing / Notificacoes
comment on table cupons is 'Cupons de desconto da plataforma. Tabela global (sem empresa_id).';
comment on table lista_vip is 'Lista de interessados (leads) capturados via landing page. Tabela global. Append-only.';
comment on table notificacoes is 'Notificacoes in-app por empresa. Leitura/visibilidade controlada via notificacao_usuario junction.';

-- API
comment on table api_keys is 'Chaves de API por empresa para integracao externa. ATENCAO: consumer_key/secret devem migrar para Vault.';
comment on table api_logs is 'Log de requisicoes da API externa por empresa com endpoint e status. Append-only.';
comment on table api_rate_limits is 'Rate limit por chave de API: limite diario, contador e total acumulado.';

-- Utilidades
comment on table whatsapp_distribuidor is 'Round-robin de distribuicao de mensagens WhatsApp entre instancias. Tabela global.';
comment on table changelog is 'Release notes do sistema com versionamento e tipo de mudanca. Tabela global, append-only.';
comment on table formularios is 'Leads capturados via formularios externos. Campos JSONB para flexibilidade. Tabela global.';
comment on table nps_geral is 'Pesquisa NPS (Net Promoter Score) por empresa com 5 perguntas (escala 1-10). Append-only.';
comment on table estatisticas is 'KPIs globais da plataforma por data (ex: usuarios ativos, MRR). Append-only.';
comment on table engajamento is 'Registro de engajamento por empresa com data de acesso. Metricas de retencao. Append-only.';
comment on table utilizacao_submodulos is 'Contadores de utilizacao de cada submodulo do sistema por empresa (~50 contadores). Telemetria de uso.';
comment on table patrimonios is 'Bens patrimoniais da empresa (equipamentos, moveis) com tipo, valor e responsavel.';
comment on table checklist_avaliacao is 'Resultado de avaliacao de checklist de estoque com itens aprovados/reprovados. Tabela global.';
comment on table carteiras is 'Saldo de tokens/creditos da plataforma por empresa. Recargas em carteira_recarga.';
comment on table devocionais is 'Conteudo devocional diario (texto religioso) com audio. Tabela global, feature opcional.';
comment on table pesquisa_churn is 'Pesquisa de churn (cancelamento) com 10 perguntas por empresa/usuario. Append-only.';
comment on table verif_contas_pagar is 'Tabela auxiliar de verificacao/reconciliacao de contas a pagar. Validacao de migracao. Append-only.';
comment on table verif_contas_receber is 'Tabela auxiliar de verificacao/reconciliacao de contas a receber. Validacao de migracao. Append-only.';

-- Junction tables
-- Junction tables
comment on table usuario_empresa is '[JUNCTION J01] usuario <-> empresa. Define acesso multi-tenant. Base da funcao empresas_do_usuario() usada no RLS. Substitui: User."00_EMP_Vinculadas", DB002_ACESSO."003_EmpresasAcesso".';
comment on table usuario_dispositivo is '[JUNCTION J02] usuario <-> dispositivo movel para push notifications. Substitui: User."99_Dispositivos", DB002."050_Dispositivos".';
comment on table usuario_instancia is '[JUNCTION J03] usuario <-> instancia WhatsApp (CRM). Define acesso por canal. Substitui: User."09 - instancias", DB087."10 - usuariosComAcesso".';
comment on table usuario_fila is '[JUNCTION J04] usuario <-> fila de atendimento CRM. Distribuicao de leads. Substitui: User."06 - filasUsuario".';
comment on table transferencia_empresa_view is '[JUNCTION J05] empresas com visibilidade sobre uma transferencia entre lojas. Substitui: DB042."003_EmpresasView".';
comment on table atendimento_produto is '[JUNCTION J06] produtos de um atendimento por tipo (venda, troca, brinde) com quantidade, preco, custo e desconto. Substitui: DB029."069_VEN_PRODUTOS", "066_TRO_PRODUTOS", "037_BRI_PRODUTOS".';
comment on table atendimento_financeiro is '[JUNCTION J07] lancamentos CAP/CAR vinculados a um atendimento por tipo (pagamento, custo, recebimento). Substitui: DB029."079_z_CAP_CAR_Pagamento", "080_z_CAP_Custos", "081_z_CAR_Pagamento".';
comment on table atendimento_termo is '[JUNCTION J08] termos de garantia selecionados para um atendimento. Substitui: DB029."032_Termos-selecionados".';
comment on table atendimento_garantia is '[JUNCTION J09] registros de garantia vinculados a um atendimento. Substitui: DB029."084_COD_GARANTIA".';
comment on table atendimento_fiscal_pagamento is '[JUNCTION J10] pagamentos fiscais (CAP/CAR) vinculados a atendimento para emissao de NF. Substitui: DB029."049_FISCAL_PAGAMENTO".';
comment on table pre_venda_produto is '[JUNCTION J11] produtos de pre-venda por tipo (venda, troca, brinde). Flag is_snapshot indica copia congelada. Substitui: DB038."014-019_Lista Produtos Troca/Venda/Brinde" (6 colunas).';
comment on table pre_venda_pagamento is '[JUNCTION J12] pagamentos (CAP/CAR) realizados em uma pre-venda. Substitui: DB038."024_Pagamentos realizados".';
comment on table compra_produto is '[JUNCTION J13] produtos adquiridos em uma compra com quantidade e custo unitario. Substitui: DB017."013_ProdutosComprados".';
comment on table compra_financeiro is '[JUNCTION J14] lancamentos financeiros (CAP/CAR) de uma compra. Substitui: DB017."029_CAP-CAR".';
comment on table nf_produto is '[JUNCTION J15] produtos incluidos em uma nota fiscal com quantidade e valor. Substitui: DB056."030_PRODUTOS".';
comment on table nf_servico is '[JUNCTION J16] servicos incluidos em uma NFS-e com valor. Substitui: DB056."031_Servicos".';
comment on table nf_pagamento is '[JUNCTION J17] lancamentos financeiros (CAP/CAR) de uma nota fiscal. Substitui: DB056."040_PAGAMENTO-CAP".';
comment on table emprestimo_produto is '[JUNCTION J18] produtos emprestados (comodato) com quantidade. Substitui: DB023."014_EMP_Produtos".';
comment on table historico_caixa_produto is '[JUNCTION J19] produtos transacionados em um periodo de caixa por tipo (compra, troca, venda). Substitui: DB025."005-007_PRODUTOS_Compras/Trocas/Vendas".';
comment on table produto_associado is '[JUNCTION J20] auto-referencia produto <-> produto (acessorios, kits). Check impede auto-associacao. Substitui: DB062."027_CODIGO-ASSOCIADO".';
comment on table iniciante_ate_produto is '[JUNCTION J21] produtos de atendimento iniciante por tipo (venda, troca). Substitui: DB033."008_ATE_TRO_Produtos", "009_ATE_VEN_Produtos".';
comment on table iniciante_ate_pagamento is '[JUNCTION J22] pagamentos (CAP/CAR) de um atendimento iniciante. Substitui: DB033."007_ATE_Pagamento".';
comment on table garantia_produto is '[JUNCTION J23] produtos de garantia por tipo (problema, problema_original, vendido) com custo e preco. Substitui: DB032 colunas 019-038 (6 colunas de listas de produtos).';
comment on table garantia_avaria is '[JUNCTION J24] avarias/defeitos registrados em uma garantia. Substitui: DB032."017_Avarias".';
comment on table os_checklist is '[JUNCTION J25] itens de checklist de uma OS por tipo (principal, origem, problema, posterior etc). Flag is_snapshot indica copia congelada. Substitui: DB082."[01]-CHECKLIST", "[66]-CHECKLIST_ORIGEM", "[67]-CHECK_PROBLEMAS", "[99]-CHECKLIST POSTERIOR" (6+ colunas).';
comment on table os_peca is '[JUNCTION J26] pecas utilizadas em uma OS com origem (interna/externa), custo e quantidade. Substitui: DB082."[99]-Pecas_CI/SI_Utilizadas", "Lista_Pecas" (4+ colunas).';
comment on table os_servico is '[JUNCTION J27] servicos executados em uma OS com descricao e preco. Substitui: DB082."[71]-LISTA_SERVICO", "SERVICOS", "LISTA_PRECOS_SERVICOS".';
comment on table os_financeiro is '[JUNCTION J28] lancamentos financeiros (CAP/CAR) de uma ordem de servico. Substitui: DB082."Z - Lista_CAP-CAR".';
comment on table projeto_membro is '[JUNCTION J29] membros (usuarios) de um projeto. Unique constraint impede duplicatas. Substitui: DB079."[02] - MEMBROS".';
comment on table funcao_permissao is '[JUNCTION J30] permissoes granulares por funcao e modulo (10 modulos). Substitui: DB014."003-012_*-PERM" (10 colunas de listas), DB011."002_PERMISSAO".';
comment on table funil_etapa is '[JUNCTION J31] etapas de um funil CRM com ordem de exibicao. Substitui: DB092."03 - EtapasFunil".';
comment on table cliente_etiqueta is '[JUNCTION J32] tags/etiquetas de clientes para segmentacao. Substitui: DB016."027_ETIQUETAS]".';
comment on table cliente_credito is '[JUNCTION J33] historico de creditos do cliente (entrada/saida) vinculado a CAP/CAR. Substitui: DB016."041_Credito Historico de entradas", "042_...saidas".';
comment on table notificacao_usuario is '[JUNCTION J34] notificacao <-> usuario por tipo (lido, visivel). Controla visibilidade e leitura. Substitui: DB102."02 - [LIDO_POR]", "05 - [VISUALIZAVEL_SOMENTE_POR]".';
comment on table produto_especificacao is '[JUNCTION J35] especificacoes tecnicas em formato chave-valor (ex: RAM=8GB, Tela=6.1pol). Substitui: DB062."016_CAD_Especificacoes".';
comment on table devocional_keyword is '[JUNCTION J36] palavras-chave para busca de conteudo devocional. Substitui: DB126."010_keywords".';
comment on table carteira_recarga is '[JUNCTION J37] historico de recargas de tokens/creditos de uma carteira. Substitui: DB124."[004] - RECARGAS".';
comment on table checklist_lista_item is '[JUNCTION J38] itens de um template de checklist com texto e ordem. Substitui: DB004."004_ListaItens".';
comment on table ticket_comentario is '[JUNCTION J40] comentarios vinculados a um ticket de suporte. Substitui: DB041."010_COMENTARIOS-TICKET]".';
comment on table tarefa_crm_comentario is '[JUNCTION J41] comentarios vinculados a uma tarefa/lead CRM. Substitui: DB081."[08] - LEAD-Comentarios".';

-- ============================================================================
-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================
-- ============================================================================
-- Estrategia: multi-tenant via empresa_id
-- O usuario autenticado tem acesso apenas aos dados das empresas vinculadas
-- via usuario_empresa junction table.
--
-- Helper function para buscar empresas do usuario logado (com cache):
-- ============================================================================

create or replace function empresas_do_usuario()
returns setof bigint
language sql
stable
security definer
set search_path = ''
as $$
  select ue.empresa_id
  from public.usuario_empresa ue
  inner join public.usuarios u on u.id = ue.usuario_id
  where u.auth_uid = auth.uid()
$$;

-- ============================================================================
-- Habilitar RLS em TODAS as tabelas
-- ============================================================================

-- Core
alter table empresas enable row level security;
alter table usuarios enable row level security;
alter table dispositivos enable row level security;
alter table assinaturas enable row level security;

-- Config
alter table logs_atividade enable row level security;
alter table checklists enable row level security;
alter table conf_vinculacoes enable row level security;
alter table conf_etiquetas enable row level security;
alter table conf_termos_garantia enable row level security;
alter table conf_chaves_pix enable row level security;
alter table cidades_br enable row level security;
alter table contas enable row level security;
alter table funcoes enable row level security;
alter table permissoes enable row level security;
alter table maquinas_cartao enable row level security;
alter table taxas_cartao enable row level security;
alter table conf_modelos_etiqueta enable row level security;

-- Produtos
alter table categorias enable row level security;
alter table cores enable row level security;
alter table grupos enable row level security;
alter table locais_estoque enable row level security;
alter table marcas enable row level security;
alter table modelos_produto enable row level security;
alter table produtos enable row level security;

-- Clientes / Fornecedores
alter table clientes enable row level security;
alter table fornecedores enable row level security;
alter table avarias enable row level security;
alter table avarias_associadas enable row level security;

-- Transacoes
alter table atendimentos enable row level security;
alter table atendimentos_iniciante enable row level security;
alter table pre_vendas enable row level security;
alter table pre_venda_itens enable row level security;
alter table pre_venda_atualizacoes enable row level security;
alter table compras enable row level security;
alter table emprestimos enable row level security;
alter table transferencias enable row level security;
alter table simulacoes enable row level security;
alter table sim_pagamentos enable row level security;
alter table sim_trocas enable row level security;
alter table sim_vendas enable row level security;
alter table garantias enable row level security;
alter table estoque_iniciante enable row level security;

-- Financeiro
alter table cap_car enable row level security;
alter table caixa_abertura_fechamento enable row level security;
alter table historico_caixa enable row level security;
alter table subcategorias_dre enable row level security;
alter table precificador enable row level security;

-- Fiscal
alter table ncm_cest enable row level security;
alter table notas_fiscais enable row level security;
alter table info_fiscal enable row level security;
alter table nfse_info_fiscal enable row level security;
alter table nfse_servicos enable row level security;
alter table rf_nfse enable row level security;
alter table rf_mva enable row level security;
alter table rf_icms enable row level security;
alter table rf_icms_st enable row level security;
alter table rf_fcp enable row level security;
alter table rf_ipi enable row level security;
alter table rf_pis enable row level security;
alter table rf_cofins enable row level security;
alter table rf_icms_info enable row level security;
alter table parametros_imposto enable row level security;
alter table ibs_cbs enable row level security;
alter table sat_atendimentos enable row level security;

-- CRM / Support
alter table ordens_servico enable row level security;
alter table projetos enable row level security;
alter table status_tarefa enable row level security;
alter table comentarios_tarefa enable row level security;
alter table checklist_items enable row level security;
alter table tickets_suporte enable row level security;
alter table documentos_assinados enable row level security;
alter table crm_instancias enable row level security;
alter table crm_etapas enable row level security;
alter table crm_funis enable row level security;
alter table crm_eventos enable row level security;
alter table crm_dados_usuario enable row level security;
alter table tarefas_crm enable row level security;

-- Goals / Marketing / Analytics / API / Utility
alter table metas_gerais enable row level security;
alter table metas_colaborador enable row level security;
alter table cupons enable row level security;
alter table lista_vip enable row level security;
alter table notificacoes enable row level security;
alter table api_keys enable row level security;
alter table api_logs enable row level security;
alter table api_rate_limits enable row level security;
alter table whatsapp_distribuidor enable row level security;
alter table changelog enable row level security;
alter table formularios enable row level security;
alter table nps_geral enable row level security;
alter table estatisticas enable row level security;
alter table engajamento enable row level security;
alter table utilizacao_submodulos enable row level security;
alter table patrimonios enable row level security;
alter table checklist_avaliacao enable row level security;
alter table carteiras enable row level security;
alter table devocionais enable row level security;
alter table pesquisa_churn enable row level security;
alter table verif_contas_pagar enable row level security;
alter table verif_contas_receber enable row level security;

-- Junction tables
alter table usuario_empresa enable row level security;
alter table usuario_dispositivo enable row level security;
alter table usuario_instancia enable row level security;
alter table usuario_fila enable row level security;
alter table transferencia_empresa_view enable row level security;
alter table atendimento_produto enable row level security;
alter table atendimento_financeiro enable row level security;
alter table atendimento_termo enable row level security;
alter table atendimento_garantia enable row level security;
alter table atendimento_fiscal_pagamento enable row level security;
alter table pre_venda_produto enable row level security;
alter table pre_venda_pagamento enable row level security;
alter table compra_produto enable row level security;
alter table compra_financeiro enable row level security;
alter table nf_produto enable row level security;
alter table nf_servico enable row level security;
alter table nf_pagamento enable row level security;
alter table emprestimo_produto enable row level security;
alter table historico_caixa_produto enable row level security;
alter table produto_associado enable row level security;
alter table iniciante_ate_produto enable row level security;
alter table iniciante_ate_pagamento enable row level security;
alter table garantia_produto enable row level security;
alter table garantia_avaria enable row level security;
alter table os_checklist enable row level security;
alter table os_peca enable row level security;
alter table os_servico enable row level security;
alter table os_financeiro enable row level security;
alter table projeto_membro enable row level security;
alter table funcao_permissao enable row level security;
alter table funil_etapa enable row level security;
alter table cliente_etiqueta enable row level security;
alter table cliente_credito enable row level security;
alter table notificacao_usuario enable row level security;
alter table produto_especificacao enable row level security;
alter table devocional_keyword enable row level security;
alter table carteira_recarga enable row level security;
alter table checklist_lista_item enable row level security;
alter table ticket_comentario enable row level security;
alter table tarefa_crm_comentario enable row level security;

-- ============================================================================
-- RLS POLICIES: Padrao multi-tenant
-- Tabelas com empresa_id usam a funcao empresas_do_usuario()
-- ============================================================================

-- Macro: cria policies padrao (select/insert/update/delete) para tabelas tenant
-- Exemplo aplicado para as tabelas mais criticas:

-- EMPRESAS: usuario ve apenas empresas vinculadas
create policy "empresas_select" on empresas
  for select using (id in (select empresas_do_usuario()));

create policy "empresas_insert" on empresas
  for insert with check (true); -- criacao controlada por service_role

create policy "empresas_update" on empresas
  for update using (id in (select empresas_do_usuario()));

-- USUARIOS: usuario ve a si mesmo e colegas das mesmas empresas
create policy "usuarios_select" on usuarios
  for select using (
    auth_uid = auth.uid()
    or id in (
      select ue.usuario_id from usuario_empresa ue
      where ue.empresa_id in (select empresas_do_usuario())
    )
  );

create policy "usuarios_update" on usuarios
  for update using (auth_uid = auth.uid());

-- USUARIO_EMPRESA: ve apenas seus proprios vinculos
create policy "ue_select" on usuario_empresa
  for select using (
    usuario_id in (
      select u.id from usuarios u where u.auth_uid = auth.uid()
    )
    or empresa_id in (select empresas_do_usuario())
  );

-- TEMPLATE: Policy padrao para tabelas com empresa_id
-- Replicar esse padrao para todas as tabelas com empresa_id.
-- Abaixo as policies criticas; as demais seguem o mesmo padrao.

do $$
declare
  t text;
begin
  for t in
    select unnest(array[
      'assinaturas','logs_atividade','checklists','conf_vinculacoes',
      'conf_etiquetas','conf_termos_garantia','conf_chaves_pix','contas',
      'funcoes','permissoes','maquinas_cartao','taxas_cartao',
      'conf_modelos_etiqueta','categorias','cores','grupos',
      'locais_estoque','marcas','produtos','clientes','fornecedores',
      'avarias','avarias_associadas','atendimentos','atendimentos_iniciante',
      'pre_vendas','pre_venda_itens','pre_venda_atualizacoes','compras',
      'emprestimos','simulacoes','sim_pagamentos','sim_trocas','sim_vendas',
      'garantias','estoque_iniciante','cap_car','caixa_abertura_fechamento',
      'historico_caixa','subcategorias_dre','precificador','ncm_cest',
      'notas_fiscais','info_fiscal','nfse_info_fiscal','nfse_servicos',
      'rf_nfse','rf_mva','rf_icms','rf_icms_st','rf_fcp','rf_ipi',
      'rf_pis','rf_cofins','rf_icms_info','parametros_imposto','ibs_cbs',
      'sat_atendimentos','ordens_servico','projetos','status_tarefa',
      'comentarios_tarefa','checklist_items','tickets_suporte',
      'documentos_assinados','crm_instancias','crm_etapas','crm_funis',
      'crm_eventos','crm_dados_usuario','tarefas_crm','metas_gerais',
      'metas_colaborador','notificacoes','api_keys','api_logs',
      'api_rate_limits','nps_geral','engajamento','utilizacao_submodulos',
      'patrimonios','carteiras','pesquisa_churn','verif_contas_pagar',
      'verif_contas_receber'
    ])
  loop
    execute format(
      'create policy %I on %I for select using (empresa_id in (select empresas_do_usuario()))',
      t || '_tenant_select', t
    );
    execute format(
      'create policy %I on %I for insert with check (empresa_id in (select empresas_do_usuario()))',
      t || '_tenant_insert', t
    );
    execute format(
      'create policy %I on %I for update using (empresa_id in (select empresas_do_usuario()))',
      t || '_tenant_update', t
    );
    execute format(
      'create policy %I on %I for delete using (empresa_id in (select empresas_do_usuario()))',
      t || '_tenant_delete', t
    );
  end loop;
end $$;

-- Tabelas publicas (sem empresa_id): acesso de leitura para autenticados
do $$
declare
  t text;
begin
  for t in
    select unnest(array[
      'cidades_br','modelos_produto','cupons','lista_vip',
      'whatsapp_distribuidor','changelog','formularios',
      'estatisticas','checklist_avaliacao','devocionais'
    ])
  loop
    execute format(
      'create policy %I on %I for select using (auth.uid() is not null)',
      t || '_auth_select', t
    );
  end loop;
end $$;

-- ============================================================================
-- TRIGGERS: updated_at automatico
-- ============================================================================

do $$
declare
  t text;
begin
  for t in
    select unnest(array[
      'empresas','usuarios','dispositivos','assinaturas',
      'logs_atividade','checklists','conf_vinculacoes','conf_etiquetas',
      'conf_termos_garantia','conf_chaves_pix','contas','funcoes',
      'permissoes','maquinas_cartao','taxas_cartao','conf_modelos_etiqueta',
      'categorias','cores','grupos','locais_estoque','marcas',
      'modelos_produto','produtos','clientes','fornecedores',
      'avarias','avarias_associadas','atendimentos','atendimentos_iniciante',
      'pre_vendas','compras','emprestimos','transferencias','simulacoes',
      'garantias','estoque_iniciante','cap_car','caixa_abertura_fechamento',
      'historico_caixa','subcategorias_dre','precificador',
      'ncm_cest','notas_fiscais','info_fiscal','nfse_info_fiscal',
      'rf_nfse','rf_icms_info','parametros_imposto','ibs_cbs',
      'sat_atendimentos','ordens_servico','projetos','status_tarefa',
      'comentarios_tarefa','checklist_items','tickets_suporte',
      'documentos_assinados','crm_instancias','crm_etapas','crm_funis',
      'crm_eventos','crm_dados_usuario','tarefas_crm',
      'metas_gerais','metas_colaborador','notificacoes',
      'api_keys','api_rate_limits','whatsapp_distribuidor',
      'utilizacao_submodulos','patrimonios','carteiras'
    ])
  loop
    execute format(
      'create trigger trg_%s_updated_at before update on %I for each row execute function set_updated_at()',
      t, t
    );
  end loop;
end $$;

-- ============================================================================
-- ============================================================================
-- MAPEAMENTO LEGADO -> NOVO (referencia para scripts de migracao)
-- ============================================================================
-- ============================================================================
--
-- | Tabela Legada                    | Tabela Nova               | Notas                          |
-- |----------------------------------|---------------------------|--------------------------------|
-- | "User"                           | usuarios                  | + usuario_empresa junction     |
-- | "Device"                         | dispositivos              | + usuario_dispositivo junction |
-- | "DB001_ASSINATURAS"              | assinaturas               |                                |
-- | "DB002_ACESSO"                   | (eliminada)               | Dados em usuario_empresa       |
-- | "DB002_EMPRESAS"                 | empresas                  |                                |
-- | "DB003_LOG"                      | logs_atividade            |                                |
-- | "DB004_CHECKLIST"                | checklists                | + checklist_lista_item         |
-- | "DB005_CONF_VINCULACAO"          | conf_vinculacoes          |                                |
-- | "DB006_CONF_ETIQUETAS"           | conf_etiquetas            |                                |
-- | "DB007_CONF_TERMO_GARANTIA"      | conf_termos_garantia      |                                |
-- | "DB008_CONF_CHAVE PIX"           | conf_chaves_pix           |                                |
-- | "DB009_CONF_CIDADES_BR"          | cidades_br                |                                |
-- | "DB010_CONF_CONTA"               | contas                    |                                |
-- | "DB011_CONF_FUNCOES"             | funcoes                   | + funcao_permissao junction    |
-- | "DB012_CONF_MAQUINA"             | maquinas_cartao           |                                |
-- | "DB013_CONF_TAXAS"               | taxas_cartao              |                                |
-- | "DB014_CONF_NEW_PERMISSAO"       | permissoes                | + funcao_permissao junction    |
-- | "DB016_CLI_CLIENTE"              | clientes                  | + cliente_etiqueta, credito    |
-- | "DB017_COM_COMPRA"               | compras                   | + compra_produto, financeiro   |
-- | "DB018_CAD_AVARIA"               | avarias                   |                                |
-- | "DB019_CAD_AVARIA_ASSOCIADA"     | avarias_associadas        |                                |
-- | "DB020_CAD_FORNECEDOR"           | fornecedores              |                                |
-- | "DB021_DOC_ASSIN"                | documentos_assinados      |                                |
-- | "DB023_EMP_EMPREST_UM"           | emprestimos               | + emprestimo_produto           |
-- | "DB024_FIN_ABRE_FECHA"           | caixa_abertura_fechamento |                                |
-- | "DB025_FIN_HISTORICO_CAIXA"      | historico_caixa           | + historico_caixa_produto      |
-- | "DB026_FIN_SUBCATEGORIA_DRE"     | subcategorias_dre         |                                |
-- | "DB028_FIS_NCM_CEST"             | ncm_cest                  |                                |
-- | "DB029_LAN_ATENDIMENTO"          | atendimentos              | + 5 junction tables            |
-- | "DB030_LAN_CAP-CAR"              | cap_car                   |                                |
-- | "DB032_LAN_GARANTIA"             | garantias                 | + garantia_produto, avaria     |
-- | "DB033_LAN_INICIANTE_ATE"        | atendimentos_iniciante    | + iniciante_ate_produto/pagto  |
-- | "DB034_LAN_INICIANTE_ESTOQ"      | estoque_iniciante         |                                |
-- | "DB038_LAN_PRE_VENDA"            | pre_vendas                | + pre_venda_produto/pagto      |
-- | "DB039_LAN_PROD_PRE"             | pre_venda_itens           |                                |
-- | "DB040_LAN_SIMULACOES"           | simulacoes                | FK em sim_pagamentos/trocas    |
-- | "DB041_LAN_SUPORTE"              | tickets_suporte           | + ticket_comentario            |
-- | "DB042_LAN_TRANSFERENCIAS"       | transferencias            | + transferencia_empresa_view   |
-- | "DB044_MKT_CUPOM"                | cupons                    |                                |
-- | "DB045_MKT_LISTA_VIP"            | lista_vip                 |                                |
-- | "DB055_MOD_PRODUTO"              | modelos_produto           |                                |
-- | "DB056_LAN_NF"                   | notas_fiscais             | + nf_produto/servico/pagto     |
-- | "DB057_PROD_CATEGORIA"           | categorias                |                                |
-- | "DB058_PROD_COR"                 | cores                     |                                |
-- | "DB059_PROD_GRUPO"               | grupos                    |                                |
-- | "DB060_PROD_LOCAL"               | locais_estoque            |                                |
-- | "DB061_PROD_MARCA"               | marcas                    |                                |
-- | "DB062_PROD_PRODUTO"             | produtos                  | + produto_associado/espec      |
-- | "DB063-071_RF_*"                 | rf_mva..rf_cofins         |                                |
-- | "DB072_RF_ICMS_INFO"             | rf_icms_info              |                                |
-- | "DB073_RF_INFO_FISCAL"           | info_fiscal               | Segredos -> Vault              |
-- | "DB074_RF_PARAM_IMPOSTO"         | parametros_imposto        |                                |
-- | "DB075_SIM_PAGAMENTO"            | sim_pagamentos            | FK simulacao_id                |
-- | "DB076_SIM_TROCA"                | sim_trocas                | FK simulacao_id                |
-- | "DB077_SIM_VENDA"                | sim_vendas                | FK simulacao_id                |
-- | "DB078_TREL_COMENT_TAREFA"       | comentarios_tarefa        |                                |
-- | "DB079_TREL_PROJETO"             | projetos                  | + projeto_membro               |
-- | "DB080_TREL_STATUS_TAREFA"       | status_tarefa             |                                |
-- | "DB081_TREL_TAREFA_CRM"          | tarefas_crm               | + tarefa_crm_comentario        |
-- | "DB082_TREL_TAREFA_MANUT"        | ordens_servico            | + os_checklist/peca/servico/fin|
-- | "DB086_UTIL_PRECIFICADOR"        | precificador              |                                |
-- | "DB087_CRM_INSTANCIAS"           | crm_instancias            | + usuario_instancia            |
-- | "DB088_CRM_ETAPAS"               | crm_etapas                |                                |
-- | "DB092_CRM_FUNIL"                | crm_funis                 | + funil_etapa                  |
-- | "DB093_CRM-EVENTO"               | crm_eventos               |                                |
-- | "DB094_CRM-DADOS-USER"           | crm_dados_usuario         |                                |
-- | "DB095_METAS-GERAIS"             | metas_gerais              |                                |
-- | "DB096_METAS_COLABORADOR"        | metas_colaborador         | FK meta_geral_id               |
-- | "DB097_CHANGELOG"                | changelog                 |                                |
-- | "DB099_FORMS"                    | formularios               |                                |
-- | "DB102_NOTIFICACOES"             | notificacoes              | + notificacao_usuario          |
-- | "DB103_LAN_ATUALIZACOES_PREVENDA"| pre_venda_atualizacoes    |                                |
-- | "DB106_WHATSAPP-DISTRIBUIDOR"    | whatsapp_distribuidor     |                                |
-- | "DB107_API-KEYS"                 | api_keys                  | Segredos -> Vault              |
-- | "DB108_API-LOG"                  | api_logs                  | Auth headers removidos         |
-- | "DB109_API-RATE-LIMIT"           | api_rate_limits           |                                |
-- | "DB112_CONFIGURACAO_ETIQUETAS"   | conf_modelos_etiqueta     |                                |
-- | "DB113_UTILIZACAO_SUBMODULOS"    | utilizacao_submodulos     |                                |
-- | "DB114_PATRIMONIO"               | patrimonios               |                                |
-- | "DB115_NPS-GERAL"                | nps_geral                 | CHECK 1-10 nos scores          |
-- | "DB116_ESTATISTICAS"             | estatisticas              |                                |
-- | "DB117_ENGAJAMENTO"              | engajamento               |                                |
-- | "DB118_NFSE_INFO_FISCAL"         | nfse_info_fiscal          | Segredos -> Vault              |
-- | "DB119_RF_NFSE"                  | rf_nfse                   |                                |
-- | "DB122_NFSE_SERVICOS"            | nfse_servicos             |                                |
-- | "DB123_CHECK_LIST_AVALIACAO"     | checklist_avaliacao       |                                |
-- | "DB124_CARTEIRA"                 | carteiras                 | + carteira_recarga             |
-- | "DB126_DEVOCIONAL"               | devocionais               | + devocional_keyword           |
-- | "DB128_IBS-CBS"                  | ibs_cbs                   |                                |
-- | "DB129_Pesquisa_CHURN"           | pesquisa_churn            |                                |
-- | "DB999_VERIF_CONTAS_PAGAR"       | verif_contas_pagar        |                                |
-- | "DB999_VERIF_CONTAS_RECEB"       | verif_contas_receber      |                                |
