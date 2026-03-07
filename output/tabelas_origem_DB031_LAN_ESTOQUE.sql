-- ============================================================================
-- TABELAS CRIADAS A PARTIR DA TABELA DE ORIGEM DB031_LAN_ESTOQUE
-- ============================================================================
-- No Bubble.io a tabela DB031_LAN_ESTOQUE (key: z_lancamentosestoque) era a
-- tabela central de lancamentos de estoque (~96 campos). No Schema V2 esses
-- dados foram normalizados: cada "lista de relacao -> DB031" virou uma
-- junction table. Abaixo estao apenas as tabelas V2 que recebem os dados
-- que na origem eram linhas em DB031 referenciadas por outras entidades.
--
-- Tabelas incluídas (9):
--   1. atendimento_produto   (J06) - DB029 VEN/TRO/BRI
--   2. pre_venda_produto     (J11) - DB038 listas produtos
--   3. compra_produto        (J13) - DB017 ProdutosComprados
--   4. nf_produto            (J15) - DB056 PRODUTOS
--   5. emprestimo_produto    (J18) - DB023 EMP_Produtos
--   6. historico_caixa_produto (J19) - DB025 PRODUTOS Compras/Trocas/Vendas
--   7. iniciante_ate_produto (J21) - DB033 ATE_TRO/VEN_Produtos
--   8. garantia_produto      (J23) - DB032 listas produto
--   9. os_peca               (J26) - DB082 Pecas_CI/SI_Utilizadas
-- ============================================================================

-- ============================================================================
-- 1. atendimento_produto (J06)
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
  created_by text
);

create index idx_ap_atendimento on atendimento_produto(atendimento_id);
create index idx_ap_produto on atendimento_produto(produto_id);
create index idx_ap_tipo on atendimento_produto(atendimento_id, tipo);

comment on table atendimento_produto is '[JUNCTION J06] produtos de um atendimento por tipo (venda, troca, brinde) com quantidade, preco, custo e desconto. Substitui: DB029."069_VEN_PRODUTOS", "066_TRO_PRODUTOS", "037_BRI_PRODUTOS".';

-- ============================================================================
-- 2. pre_venda_produto (J11)
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
  created_by text
);

create index idx_pvp_prevenda on pre_venda_produto(pre_venda_id);
create index idx_pvp_produto on pre_venda_produto(produto_id);

comment on table pre_venda_produto is '[JUNCTION J11] produtos de pre-venda por tipo (venda, troca, brinde). Flag is_snapshot indica copia congelada. Substitui: DB038."014-019_Lista Produtos Troca/Venda/Brinde" (6 colunas).';

-- ============================================================================
-- 3. compra_produto (J13)
-- Substitui: DB017."013_ProdutosComprados"
-- ============================================================================
create table compra_produto (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  custo numeric(12,2),
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_cp_compra on compra_produto(compra_id);
create index idx_cp_produto on compra_produto(produto_id);

comment on table compra_produto is '[JUNCTION J13] produtos adquiridos em uma compra com quantidade e custo unitario. Substitui: DB017."013_ProdutosComprados".';

-- ============================================================================
-- 4. nf_produto (J15)
-- Substitui: DB056."030_PRODUTOS"
-- ============================================================================
create table nf_produto (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  valor numeric(12,2),
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_nfp_nf on nf_produto(nf_id);
create index idx_nfp_produto on nf_produto(produto_id);

comment on table nf_produto is '[JUNCTION J15] produtos incluidos em uma nota fiscal com quantidade e valor. Substitui: DB056."030_PRODUTOS".';

-- ============================================================================
-- 5. emprestimo_produto (J18)
-- Substitui: DB023."014_EMP_Produtos"
-- ============================================================================
create table emprestimo_produto (
  id bigint generated always as identity primary key,
  emprestimo_id bigint not null references emprestimos(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_ep_emprestimo on emprestimo_produto(emprestimo_id);
create index idx_ep_produto on emprestimo_produto(produto_id);

comment on table emprestimo_produto is '[JUNCTION J18] produtos emprestados (comodato) com quantidade. Substitui: DB023."014_EMP_Produtos".';

-- ============================================================================
-- 6. historico_caixa_produto (J19)
-- Substitui: DB025."005-007_PRODUTOS_Compras/Trocas/Vendas"
-- ============================================================================
create table historico_caixa_produto (
  id bigint generated always as identity primary key,
  historico_id bigint not null references historico_caixa(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo_transacao text not null check (tipo_transacao in ('compra','troca','venda')),
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_hcp_historico on historico_caixa_produto(historico_id);
create index idx_hcp_produto on historico_caixa_produto(produto_id);

comment on table historico_caixa_produto is '[JUNCTION J19] produtos transacionados em um periodo de caixa por tipo (compra, troca, venda). Substitui: DB025."005-007_PRODUTOS_Compras/Trocas/Vendas".';

-- ============================================================================
-- 7. iniciante_ate_produto (J21)
-- Substitui: DB033."008_ATE_TRO_Produtos", "009_ATE_VEN_Produtos"
-- ============================================================================
create table iniciante_ate_produto (
  id bigint generated always as identity primary key,
  iniciante_ate_id bigint not null references atendimentos_iniciante(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda','troca')),
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_iap_iniciante on iniciante_ate_produto(iniciante_ate_id);
create index idx_iap_produto on iniciante_ate_produto(produto_id);

comment on table iniciante_ate_produto is '[JUNCTION J21] produtos de atendimento iniciante por tipo (venda, troca). Substitui: DB033."008_ATE_TRO_Produtos", "009_ATE_VEN_Produtos".';

-- ============================================================================
-- 8. garantia_produto (J23)
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
  created_by text
);

create index idx_gp_garantia on garantia_produto(garantia_id);
create index idx_gp_produto on garantia_produto(produto_id);

comment on table garantia_produto is '[JUNCTION J23] produtos de garantia por tipo (problema, problema_original, vendido) com custo e preco. Substitui: DB032 colunas 019-038 (6 colunas de listas de produtos).';

-- ============================================================================
-- 9. os_peca (J26)
-- Substitui: DB082 "[99] - Pecas_CI/SI_Utilizadas", "Lista_Pecas" (4+ colunas)
-- ============================================================================
create table os_peca (
  id bigint generated always as identity primary key,
  os_id bigint not null references assistencia_ordens_servico(id) on delete cascade,
  produto_id bigint not null references produtos(id),
  origem text not null check (origem in ('interna','externa')),
  custo numeric(12,2),
  quantidade integer not null default 1,
  created_at timestamptz not null default now(),
  created_by text
);

create index idx_osp_os on os_peca(os_id);
create index idx_osp_produto on os_peca(produto_id);

comment on table os_peca is '[JUNCTION J26] pecas utilizadas em uma OS com origem (interna/externa), custo e quantidade. Substitui: DB082."[99]-Pecas_CI/SI_Utilizadas", "Lista_Pecas" (4+ colunas).';

-- ============================================================================
-- RLS (habilitar em cada tabela; policies dependem do contexto do schema)
-- ============================================================================
alter table atendimento_produto enable row level security;
alter table pre_venda_produto enable row level security;
alter table compra_produto enable row level security;
alter table nf_produto enable row level security;
alter table emprestimo_produto enable row level security;
alter table historico_caixa_produto enable row level security;
alter table iniciante_ate_produto enable row level security;
alter table garantia_produto enable row level security;
alter table os_peca enable row level security;
