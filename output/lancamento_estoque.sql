-- ============================================================================
-- LANCAMENTO ESTOQUE (DB031_LAN_ESTOQUE)
-- 98 colunas: id + bubble_unique_id + 96 campos na mesma ordem da DB031
-- para migracao 1:1 dos dados do Bubble.
-- ============================================================================
create table lancamento_estoque (
  id bigint generated always as identity primary key,
  bubble_unique_id text unique,
  -- DB031 campos 1-96 na ordem original
  status text,                                    -- 1  082_Status
  cod_os text,                                    -- 2  002_COD_OS
  est_sku text,                                   -- 3  069_EST_SKU
  ate_cod text,                                   -- 4  001_ATE_Cod
  est_imei text,                                  -- 5  054_EST_IMEI
  est_nome text,                                  -- 6  058_EST_Nome
  vendedor_id bigint references usuarios(id),     -- 7  088_Vendedor
  atendente_id bigint references usuarios(id),     -- 8  087_Atendente
  data_movimentacao date,                         -- 9  035_Data_Movimentacao
  est_origem text,                                -- 10 063_EST_Origem
  nome_cliente text,                              -- 11 003_NomeCliente
  cancelado boolean default false,                -- 12 030_Cancelado
  est_qtd numeric(12,2),                         -- 13 066_EST_Qtd
  est_num_serie text,                             -- 14 062_EST_NumSerie
  txt_memoria text,                               -- 15 090_TXT_MEMORIA
  informacao_temp boolean default true,            -- 16 093_Informacao_Temp
  nf_cor text,                                    -- 17 022_NF_COR
  nf_ncm text,                                    -- 18 025_NF_NCM
  est_bateria numeric(12,2),                     -- 19 041_EST_Bateria
  est_cor_id bigint references cores(id),         -- 20 045_EST_Cor
  seq_xml text,                                   -- 21 016_SEQ-XML
  nf_cest text,                                   -- 22 021_NF_CEST
  bri_desconto numeric(12,2),                     -- 23 029_BRI_Desconto
  est_cod_interno text,                          -- 24 044_EST_CodInterno
  est_custo_proposta_atualizado numeric(12,2),    -- 25 046_EST_CustoPropostaAtualizado
  com_cod text,                                   -- 26 018_COM-COD
  nf_categ text,                                  -- 27 020_NF_CATEG
  menu_entrada_info text,                         -- 28 079_MenuEntradaInfo
  transferencia boolean default false,            -- 29 083_TRANFERENCIA
  cod_interno_loja text,                          -- 30 031_COD_INTERNO_LOJA
  com_custo_total numeric(12,2),                  -- 31 034_COM_CustoTotal
  est_preco_venda numeric(12,2),                  -- 32 064_EST_PrecoVenda
  est_reservado_por_id bigint references usuarios(id), -- 33 068_EST_ReservadoPor
  est_venda_total numeric(12,2),                 -- 34 072_EST_VendaTotal
  est_marca_id bigint references marcas(id),      -- 35 056_EST_Marca
  est_qtd_negativa numeric(12,2),                 -- 36 067_EST_QtdNegativa
  percentual numeric(12,2),                       -- 37 084_Percentual
  garantia_flag boolean,                         -- 38 095_Garantia
  nf_subcateg text,                               -- 39 026_NF_SUBCATEG
  est_cod_lancamento text,                        -- 40 043_EST_Cod_lancamento
  est_desconto_total_dado numeric(12,2),          -- 41 005_EST_DescontoTotalDado
  est_grupo_id bigint references grupos(id),      -- 42 052_EST_Grupo
  est_nome_prod_concat text,                      -- 43 061_EST_NomeProdConcat
  est_tipo_lancamento text,                       -- 44 071_EST_TipoLancamento
  txt_estoques text,                              -- 45 089_TXT_ESTOQUES
  est_acrescimo_dado numeric(12,2),               -- 46 037_EST_AcrescimoDado
  est_entrada_ativa boolean default false,        -- 47 048_EST_EntradaAtiva
  est_identificado boolean,                       -- 48 053_EST_Identificado
  fotos_produto text[],                           -- 49 Fotos-Produto
  intencao text,                                  -- 50 073_Intencao
  id_unico text,                                  -- 51 092_ID-UNICO
  ent_fiscal boolean default false,              -- 52 012_ENT_FISCAL
  empresa_id bigint references empresas(id),      -- 53 000_Empresa
  est_categoria_id bigint references categorias(id), -- 54 042_EST_Categoria
  est_lucro_unitario numeric(12,2),              -- 55 055_EST_Lucro_unitario
  sai_fiscal boolean default false,               -- 56 013_SAI_FISCAL
  est_estoque text,                               -- 57 050_EST_Estoque
  est_memoria text,                               -- 58 057_EST_Memoria
  assis_cliente boolean,                          -- 59 094_ASSIS_CLIENTE
  info_inutilizacao text,                         -- 60 007_Info_Inutilizacao
  nf_id_prod_unif text,                          -- 61 019_NF_ID_PROD_UNIF
  nf_custo_unit numeric(12,2),                    -- 62 023_NF_CUSTO_UNIT
  cod_os_tarefa_id bigint references assistencia_ordens_servico(id), -- 63 032_COD_OS
  est_nome_origem_cli_outro text,                 -- 64 059_EST_NomeOrigemCliOutro
  proporcao_desc_extra numeric(12,2),             -- 65 081_Proporcao-desc-extra
  produto_id bigint references produtos(id),       -- 66 065_EST_Produto
  txt_tipo_produto text,                          -- 67 091_TXT_TIPO_PRODUTO
  nf_prod_custo_total numeric(12,2),              -- 68 014_NF_ProdCustoTotal
  est_avarias_ids jsonb,                          -- 69 038_EST_Avarias
  est_avarias_desconto_total numeric(12,2),      -- 70 039_EST_AvariasDescontoTotal
  est_custo_proposta_inicial numeric(12,2),      -- 71 047_EST_CustoPropostaInicial
  est_estoque_lo_id bigint references locais_estoque(id), -- 72 051_EST_EstoqueLO
  origem_transferencia text,                      -- 73 096_Origem Transferencia
  checklist_realizado boolean default false,      -- 74 011_Checklist-realizado
  lest_observacoes_adicionais text,               -- 75 078_LEST_Observacoes_adicionais
  est_desconto_no_produto numeric(12,2),          -- 76 004_EST_DescontoNoProduto
  desc_acres_aprovado_por_id bigint references usuarios(id), -- 77 006_desc_acres-aprovado-por
  checklist_aprovado text[],                       -- 78 009_Checklist-aprovado
  nf_cod_id bigint references notas_fiscais(id),  -- 79 017_NF-COD
  checklist_nao_aprovado text[],                  -- 80 010_Checklist-NaoAprovado
  com_cod_lancamento_id bigint references compras(id), -- 81 033_COM_Cod_Lancamento
  est_especificacao text,                         -- 82 049_EST_Especificacao
  est_tipo_de_produto_os text,                    -- 83 070_EST_TipoDeProdutoOS
  ate_cod_lancamento_id bigint references atendimentos(id), -- 84 028_ATE_Cod_Lancamento
  origem_cliente_id bigint references clientes(id), -- 85 080_ORIGEM_CLIENTE
  est_avarias_nome_ids jsonb,                      -- 86 040_EST_AvariasNome
  nome_origem_fornecedor_id bigint references fornecedores(id), -- 87 060_EST_NomeOrigemFornecedor
  xml_id_unico text,                              -- 88 086_XML-ID-UNICO
  emp_cod_lanca_id bigint references emprestimos(id), -- 89 036_EMP_CodLanca
  regra_fiscal_id bigint references parametros_imposto(id), -- 90 015_Regra Fiscal
  nf_emissor_id bigint references info_fiscal(id), -- 91 024_NF_EMISSOR
  transferencia_id bigint references transferencias(id), -- 92 097_Transferencia
  info_fiscal_estoque_id bigint,                  -- 93 027_INFO_FISCAL
  estoque_referenciado_id bigint references lancamento_estoque(id), -- 94 074_EstoqueReferenciado
  checklist_id bigint references checklist_avaliacao(id), -- 95 008_Checklist
  xml_id text                                     -- 96 085_XML-ID
);

create index idx_le_bubble_unique_id on lancamento_estoque(bubble_unique_id);
create index idx_le_empresa on lancamento_estoque(empresa_id);
create index idx_le_produto on lancamento_estoque(produto_id);
create index idx_le_data_movimentacao on lancamento_estoque(data_movimentacao);

comment on table lancamento_estoque is 'Tabela 1:1 com DB031_LAN_ESTOQUE (96 campos na mesma ordem). id + bubble_unique_id + 96 colunas para migracao correta dos dados do Bubble.';
