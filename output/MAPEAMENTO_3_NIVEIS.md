# Mapeamento de Schema em 3 Niveis

**Bubble.io (Origem)** -> **Supabase Legado (Lift-and-Shift)** -> **Schema V2 (Proposta)**

Data: 2026-02-18

---

## Legenda

| Simbolo | Significado |
|---------|-------------|
| `->` | Mapeamento direto |
| `[J##]` | Tabela junction criada no V2 |
| `[ELIMINADA]` | Tabela removida (dados absorvidos) |
| `[VAULT]` | Campo migrado para Supabase Vault |
| `text*` | Tipo errado no legado (deveria ser outro) |
| `FK` | Foreign key adicionada no V2 |
| `IDX` | Indice adicionado no V2 |

---

## 1. Resumo Quantitativo

| Metrica | Bubble/Legado | V2 Proposta |
|---------|---------------|-------------|
| Tabelas principais | ~90 | 100 |
| Tabelas junction | 0 | 41 |
| **Total tabelas** | **~90** | **141** |
| Foreign keys | 0 | ~180+ |
| Indices (alem PK) | 0 | 227 |
| Colunas tipo lista | ~96 | 0 (normalizadas) |
| RLS policies | 0 | Todas as tabelas |
| CHECK constraints | 0 | ~20+ |
| Tipo PK | `text` (app-generated) | `bigint identity` |
| Timestamps | `text` ou `timestamp` | `timestamptz` |
| Valores monetarios | `text` ou `real` | `numeric(12,2)` |
| Booleanos | `text` (~50%) | `boolean` (100%) |

---

## 2. Mapeamento de Tabelas

### 2.1 CORE

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 1 | User | `"User"` | `usuarios` | +`auth_uid uuid`, +`[J01] usuario_empresa`, +`[J02] usuario_dispositivo`, +`[J03] usuario_instancia`, +`[J04] usuario_fila` |
| 2 | Device | `"Device"` | `dispositivos` | FK `usuario_id` |
| 3 | DB002_EMPRESAS | `"DB002_EMPRESAS"` | `empresas` | Tabela raiz multi-tenancy |
| 4 | DB002_ACESSO | `"DB002_ACESSO"` | **[ELIMINADA]** | Dados em `usuario_empresa` [J01] |
| 5 | DB001_ASSINATURAS | `"DB001_ASSINATURAS"` | `assinaturas` | FK `empresa_id` |

### 2.2 CONFIGURACAO

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 6 | DB003_LOG | `"DB003_LOG"` | `logs_atividade` | FK `empresa_id`, IDX `created_at` |
| 7 | DB004_CHECKLIST | `"DB004_CHECKLIST"` | `checklists` | +`[J38] checklist_lista_item` |
| 8 | DB005_CONF_VINCULACAO | `"DB005_CONF_VINCULACAO"` | `conf_vinculacoes` | FK `empresa_id` |
| 9 | DB006_CONF_ETIQUETAS | `"DB006_CONF_ETIQUETAS"` | `conf_etiquetas` | FK `empresa_id` |
| 10 | DB007_CONF_TERMO_GARANTIA | `"DB007_CONF_TERMO_GARANTIA"` | `conf_termos_garantia` | FK `empresa_id` |
| 11 | DB008_CONF_CHAVE PIX | `"DB008_CONF_CHAVE PIX"` | `conf_chaves_pix` | FK `empresa_id` |
| 12 | DB009_CONF_CIDADES_BR | `"DB009_CONF_CIDADES_BR"` | `cidades_br` | Sem `empresa_id` (ref global), IDX `ibge` |
| 13 | DB010_CONF_CONTA | `"DB010_CONF_CONTA"` | `contas` | `saldo numeric(14,2)` |
| 14 | DB011_CONF_FUNCOES | `"DB011_CONF_FUNCOES"` | `funcoes` | +`[J30] funcao_permissao` |
| 15 | DB012_CONF_MAQUINA | `"DB012_CONF_MAQUINA"` | `maquinas_cartao` | FK `empresa_id` |
| 16 | DB013_CONF_TAXAS | `"DB013_CONF_TAXAS"` | `taxas_cartao` | Taxas `numeric(6,4)` |
| 17 | DB014_CONF_NEW_PERMISSAO | `"DB014_CONF_NEW_PERMISSAO"` | `permissoes` | 10 colunas lista -> `[J30] funcao_permissao` |
| 18 | DB112_CONFIGURACAO_ETIQUETAS | `"DB112_CONFIGURACAO_ETIQUETAS"` | `conf_modelos_etiqueta` | Layout impressao |

### 2.3 PRODUTOS

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 19 | DB057_PROD_CATEGORIA | `"DB057_PROD_CATEGORIA"` | `categorias` | FK `empresa_id` |
| 20 | DB058_PROD_COR | `"DB058_PROD_COR"` | `cores` | FK `empresa_id` |
| 21 | DB059_PROD_GRUPO | `"DB059_PROD_GRUPO"` | `grupos` | FK `empresa_id` |
| 22 | DB060_PROD_LOCAL | `"DB060_PROD_LOCAL"` | `locais_estoque` | FK `empresa_id` |
| 23 | DB061_PROD_MARCA | `"DB061_PROD_MARCA"` | `marcas` | FK `empresa_id` |
| 24 | DB055_MOD_PRODUTO | `"DB055_MOD_PRODUTO"` | `modelos_produto` | Catalogo global (sem `empresa_id`) |
| 25 | DB062_PROD_PRODUTO | `"DB062_PROD_PRODUTO"` | `produtos` | FK `categoria_id`, `grupo_id`, `marca_id`, +`[J20] produto_associado`, +`[J35] produto_especificacao` |

### 2.4 CLIENTES / FORNECEDORES

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 26 | DB016_CLI_CLIENTE | `"DB016_CLI_CLIENTE"` | `clientes` | `data_nascimento date`, IDX compostos, +`[J32] cliente_etiqueta`, +`[J33] cliente_credito` |
| 27 | DB020_CAD_FORNECEDOR | `"DB020_CAD_FORNECEDOR"` | `fornecedores` | FK `empresa_id` |
| 28 | DB018_CAD_AVARIA | `"DB018_CAD_AVARIA"` | `avarias` | FK `empresa_id` |
| 29 | DB019_CAD_AVARIA_ASSOCIADA | `"DB019_CAD_AVARIA_ASSOCIADA"` | `avarias_associadas` | FK `avaria_id`, `produto_id`, `valor numeric` |

### 2.5 TRANSACOES

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 30 | DB029_LAN_ATENDIMENTO | `"DB029_LAN_ATENDIMENTO"` | `atendimentos` | CHECK `status`, FK `cliente_id`, +`[J06] atendimento_produto`, +`[J07] atendimento_financeiro`, +`[J08] atendimento_termo`, +`[J09] atendimento_garantia`, +`[J10] atendimento_fiscal_pagamento` |
| 31 | DB033_LAN_INICIANTE_ATE | `"DB033_LAN_INICIANTE_ATE"` | `atendimentos_iniciante` | +`[J21] iniciante_ate_produto`, +`[J22] iniciante_ate_pagamento` |
| 32 | DB038_LAN_PRE_VENDA | `"DB038_LAN_PRE_VENDA"` | `pre_vendas` | FK `cliente_id`, +`[J11] pre_venda_produto`, +`[J12] pre_venda_pagamento` |
| 33 | DB039_LAN_PROD_PRE | `"DB039_LAN_PROD_PRE"` | `pre_venda_itens` | FK `pre_venda_id`, `produto_id` |
| 34 | DB103_LAN_ATUALIZACOES_PREVENDA | `"DB103_LAN_ATUALIZACOES_PREVENDA"` | `pre_venda_atualizacoes` | FK `pre_venda_id` |
| 35 | DB017_COM_COMPRA | `"DB017_COM_COMPRA"` | `compras` | FK `fornecedor_id`, +`[J13] compra_produto`, +`[J14] compra_financeiro` |
| 36 | DB023_EMP_EMPREST_UM | `"DB023_EMP_EMPREST_UM"` | `emprestimos` | FK `cliente_id`, +`[J18] emprestimo_produto` |
| 37 | DB042_LAN_TRANSFERENCIAS | `"DB042_LAN_TRANSFERENCIAS"` | `transferencias` | FK `empresa_origem_id`, `empresa_destino_id`, +`[J05] transferencia_empresa_view` |
| 38 | DB040_LAN_SIMULACOES | `"DB040_LAN_SIMULACOES"` | `simulacoes` | Listas -> FK em sim_pagamentos/trocas/vendas |
| 39 | DB032_LAN_GARANTIA | `"DB032_LAN_GARANTIA"` | `garantias` | FK `cliente_id`, `atendimento_origem_id`, +`[J23] garantia_produto`, +`[J24] garantia_avaria` |
| 40 | DB034_LAN_INICIANTE_ESTOQ | `"DB034_LAN_INICIANTE_ESTOQ"` | `estoque_iniciante` | FK `produto_id` |

### 2.6 SIMULACOES

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 41 | DB075_SIM_PAGAMENTO | `"DB075_SIM_PAGAMENTO"` | `sim_pagamentos` | FK `simulacao_id` |
| 42 | DB076_SIM_TROCA | `"DB076_SIM_TROCA"` | `sim_trocas` | FK `simulacao_id` |
| 43 | DB077_SIM_VENDA | `"DB077_SIM_VENDA"` | `sim_vendas` | FK `simulacao_id` |

### 2.7 FINANCEIRO

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 44 | DB030_LAN_CAP_CAR | `"DB030_LAN_CAP_CAR"` | `cap_car` | CHECK `tipo_lancamento`, valores `numeric(14,2)`, 7 indices |
| 45 | DB024_FIN_ABRE_FECHA | `"DB024_FIN_ABRE_FECHA"` | `caixa_abertura_fechamento` | FK `empresa_id` |
| 46 | DB025_FIN_HISTORICO_CAIXA | `"DB025_FIN_HISTORICO_CAIXA"` | `historico_caixa` | FK `abre_fecha_id`, +`[J19] historico_caixa_produto` |
| 47 | DB026_FIN_SUBCATEGORIA_DRE | `"DB026_FIN_SUBCATEGORIA_DRE"` | `subcategorias_dre` | FK `empresa_id` |
| 48 | DB086_UTIL_PRECIFICADOR | `"DB086_UTIL_PRECIFICADOR"` | `precificador` | CHECK `numero_mes 1-12` |

### 2.8 FISCAL

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 49 | DB028_FIS_NCM_CEST | `"DB028_FIS_NCM_CEST"` | `ncm_cest` | `ncm integer`, `cest integer` |
| 50 | DB056_LAN_NF | `"DB056_LAN_NF"` | `notas_fiscais` | CHECK `tipo_fiscal`, +`[J15] nf_produto`, +`[J16] nf_servico`, +`[J17] nf_pagamento` |
| 51 | DB073_RF_INFO_FISCAL | `"DB073_RF_INFO_FISCAL"` | `info_fiscal` | `[VAULT]` cert_senha, tokens, consumer keys |
| 52 | DB118_NFSE_INFO_FISCAL | `"DB118_NFSE_INFO_FISCAL"` | `nfse_info_fiscal` | `[VAULT]` login, senha, token |
| 53 | DB122_NFSE_SERVICOS | `"DB122_NFSE_SERVICOS"` | `nfse_servicos` | FK `empresa_id` |
| 54 | DB119_RF_NFSE | `"DB119_RF_NFSE"` | `rf_nfse` | FK `empresa_id` |
| 55 | DB063_RF_1_MVA | `"DB063_RF_1_MVA"` | `rf_mva` | `aliquota numeric(8,4)` |
| 56 | DB064_RF_2_ICMS | `"DB064_RF_2_ICMS"` | `rf_icms` | `aliquota numeric(8,4)` |
| 57 | DB065_RF_3_ICMS_ST | `"DB065_RF_3_ICMS_ST"` | `rf_icms_st` | `aliquota numeric(8,4)` |
| 58 | DB066_RF_4_FCP | `"DB066_RF_4_FCP"` | `rf_fcp` | `aliquota numeric(8,4)` |
| 59 | DB069_RF_7_IPI | `"DB069_RF_7_IPI"` | `rf_ipi` | `aliquota numeric(8,4)` |
| 60 | DB070_RF_8_PIS | `"DB070_RF_8_PIS"` | `rf_pis` | `aliquota numeric(8,4)` |
| 61 | DB071_RF_9_COFINS | `"DB071_RF_9_COFINS"` | `rf_cofins` | `aliquota numeric(8,4)` |
| 62 | DB072_RF_ICMS_INFO | `"DB072_RF_ICMS_INFO"` | `rf_icms_info` | Tabela fiscal mais complexa |
| 63 | DB074_RF_PARAM_IMPOSTO | `"DB074_RF_PARAM_IMPOSTO"` | `parametros_imposto` | FK `empresa_id` |
| 64 | DB128_IBS-CBS | `"DB128_IBS-CBS"` | `ibs_cbs` | Reforma tributaria |
| 65 | SAT | `"SAT"` | `sat_atendimentos` | FK `atendimento_id` |

### 2.9 OS / PROJETOS / TAREFAS

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 66 | DB082_TREL_TAREFA_MANUT | `"DB082_TREL_TAREFA_MANUT"` | `ordens_servico` | ~111 cols legado, FK `cliente_id`, +`[J25] os_checklist`, +`[J26] os_peca`, +`[J27] os_servico`, +`[J28] os_financeiro` |
| 67 | DB079_TREL_PROJETO | `"DB079_TREL_PROJETO"` | `projetos` | +`[J29] projeto_membro` |
| 68 | DB080_TREL_STATUS_TAREFA | `"DB080_TREL_STATUS_TAREFA"` | `status_tarefa` | FK `projeto_id` |
| 69 | DB078_TREL_COMENT_TAREFA | `"DB078_TREL_COMENT_TAREFA"` | `comentarios_tarefa` | IDX `cod_task` |
| 70 | DB081_TREL_TAREFA_CRM | `"DB081_TREL_TAREFA_CRM"` | `tarefas_crm` | +`[J41] tarefa_crm_comentario` |
| 71 | DB999_VERIF_TASK_CHECKLIST | `"DB999_VERIF_TASK_CHECKLIST"` | `checklist_items` | IDX `os_cod` |

### 2.10 SUPORTE / DOCUMENTOS

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 72 | DB041_LAN_SUPORTE | `"DB041_LAN_SUPORTE"` | `tickets_suporte` | +`[J40] ticket_comentario` |
| 73 | DB021_DOC_ASSIN | `"DB021_DOC_ASSIN"` | `documentos_assinados` | FK `empresa_id` |

### 2.11 CRM

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 74 | DB087_CRM_INSTANCIAS | `"DB087_CRM_INSTANCIAS"` | `crm_instancias` | +`[J03] usuario_instancia` |
| 75 | DB088_CRM_ETAPAS | `"DB088_CRM_ETAPAS"` | `crm_etapas` | FK `empresa_id` |
| 76 | DB092_CRM_FUNIL | `"DB092_CRM_FUNIL"` | `crm_funis` | +`[J31] funil_etapa` |
| 77 | DB093_CRM-EVENTO | `"DB093_CRM-EVENTO"` | `crm_eventos` | IDX `data_inicio` |
| 78 | DB094_CRM-DADOS-USER | `"DB094_CRM-DADOS-USER"` | `crm_dados_usuario` | Contadores `integer` |

### 2.12 METAS / MARKETING

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 79 | DB095_METAS-GERAIS | `"DB095_METAS-GERAIS"` | `metas_gerais` | FK `empresa_id` |
| 80 | DB096_METAS_COLABORADOR | `"DB096_METAS_COLABORADOR"` | `metas_colaborador` | FK `meta_geral_id`, KPIs `numeric` |
| 81 | DB044_MKT_CUPOM | `"DB044_MKT_CUPOM"` | `cupons` | Tabela global |
| 82 | DB045_MKT_LISTA_VIP | `"DB045_MKT_LISTA_VIP"` | `lista_vip` | Tabela global |

### 2.13 API / INTEGRACOES

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 83 | DB107_API-KEYS | `"DB107_API-KEYS"` | `api_keys` | `[VAULT]` consumer_key, consumer_secret |
| 84 | DB108_API-LOG | `"DB108_API-LOG"` | `api_logs` | Auth headers removidos, `status_code smallint` |
| 85 | DB109_API-RATE-LIMIT | `"DB109_API-RATE-LIMIT"` | `api_rate_limits` | Defaults e tipos corretos |
| 86 | DB106_WHATSAPP-DISTRIBUIDOR | `"DB106_WHATSAPP-DISTRIBUIDOR"` | `whatsapp_distribuidor` | Tabela global |

### 2.14 ANALYTICS / UTILIDADES

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 87 | DB097_CHANGELOG | `"DB097_CHANGELOG"` | `changelog` | `publicacao timestamptz` |
| 88 | DB099_FORMS | `"DB099_FORMS"` | `formularios` | Campos `jsonb` mantidos |
| 89 | DB102_NOTIFICACOES | `"DB102_NOTIFICACOES"` | `notificacoes` | +`[J34] notificacao_usuario` |
| 90 | DB113_UTILIZACAO_SUBMODULOS | `"DB113_UTILIZACAO_SUBMODULOS"` | `utilizacao_submodulos` | ~50 contadores `integer` |
| 91 | DB114_PATRIMONIO | `"DB114_PATRIMONIO"` | `patrimonios` | `valor numeric(14,2)` |
| 92 | DB115_NPS-GERAL | `"DB115_NPS-GERAL"` | `nps_geral` | CHECK `q1..q5 between 1 and 10` |
| 93 | DB116_ESTATISTICAS | `"DB116_ESTATISTICAS"` | `estatisticas` | IDX `data`, `kpi` |
| 94 | DB117_ENGAJAMENTO | `"DB117_ENGAJAMENTO"` | `engajamento` | FK `empresa_id` |
| 95 | DB123_CHECK_LIST_AVALIACAO | `"DB123_CHECK_LIST_AVALIACAO"` | `checklist_avaliacao` | Tabela global |
| 96 | DB124_CARTEIRA | `"DB124_CARTEIRA"` | `carteiras` | +`[J37] carteira_recarga` |
| 97 | DB126_DEVOCIONAL | `"DB126_DEVOCIONAL"` | `devocionais` | +`[J36] devocional_keyword` |
| 98 | DB129_Pesquisa_CHURN | `"DB129_Pesquisa_CHURN"` | `pesquisa_churn` | FK `empresa_id` |

### 2.15 VERIFICACAO (AUXILIARES)

| # | Bubble.io | Supabase Legado | V2 Proposta | Mudancas |
|---|-----------|-----------------|-------------|----------|
| 99 | DB999_VERIF_CONTAS_PAGAR | `"DB999_VERIF_CONTAS_PAGAR"` | `verif_contas_pagar` | FK `empresa_id` |
| 100 | DB999_VERIF_CONTAS_RECEB | `"DB999_VERIF_CONTAS_RECEB"` | `verif_contas_receber` | FK `empresa_id` |

---

## 3. Tabelas Junction (41 novas tabelas no V2)

Substituem ~96 colunas tipo lista em 26 tabelas do legado.

| J# | Tabela Junction V2 | Substitui colunas de | Relacao |
|----|--------------------|----------------------|---------|
| J01 | `usuario_empresa` | User, DB002_ACESSO, DB002_EMPRESAS | Usuario <-> Empresa (multi-tenancy) |
| J02 | `usuario_dispositivo` | User, DB002 | Usuario <-> Dispositivo |
| J03 | `usuario_instancia` | User, DB087 | Usuario <-> Instancia WhatsApp |
| J04 | `usuario_fila` | User | Usuario <-> Fila CRM |
| J05 | `transferencia_empresa_view` | DB042 | Transferencia <-> Empresa (visibilidade) |
| J06 | `atendimento_produto` | DB029 (3 cols: VEN/TRO/BRI) | Atendimento <-> Produto (tipo: venda/troca/brinde) |
| J07 | `atendimento_financeiro` | DB029 (3 cols: CAP/CAR) | Atendimento <-> CAP/CAR (tipo: pagto/custo/receb) |
| J08 | `atendimento_termo` | DB029 (Termos-selecionados) | Atendimento <-> Termo Garantia |
| J09 | `atendimento_garantia` | DB029 (COD_GARANTIA) | Atendimento <-> Garantia |
| J10 | `atendimento_fiscal_pagamento` | DB029 (FISCAL_PAGAMENTO) | Atendimento <-> CAP/CAR fiscal |
| J11 | `pre_venda_produto` | DB038 (6 cols produtos) | Pre-Venda <-> Produto (tipo + snapshot) |
| J12 | `pre_venda_pagamento` | DB038 (Pagamentos) | Pre-Venda <-> CAP/CAR |
| J13 | `compra_produto` | DB017 (ProdutosComprados) | Compra <-> Produto |
| J14 | `compra_financeiro` | DB017 (CAP-CAR) | Compra <-> CAP/CAR |
| J15 | `nf_produto` | DB056 (PRODUTOS) | Nota Fiscal <-> Produto |
| J16 | `nf_servico` | DB056 (Servicos) | Nota Fiscal <-> Servico NFSe |
| J17 | `nf_pagamento` | DB056 (PAGAMENTO-CAP) | Nota Fiscal <-> CAP/CAR |
| J18 | `emprestimo_produto` | DB023 (EMP_Produtos) | Emprestimo <-> Produto |
| J19 | `historico_caixa_produto` | DB025 (3 cols por tipo) | Hist. Caixa <-> Produto (compra/troca/venda) |
| J20 | `produto_associado` | DB062 (CODIGO-ASSOCIADO) | Produto <-> Produto (auto-ref) |
| J21 | `iniciante_ate_produto` | DB033 (2 cols TRO/VEN) | Atendimento Iniciante <-> Produto |
| J22 | `iniciante_ate_pagamento` | DB033 (ATE_Pagamento) | Atendimento Iniciante <-> CAP/CAR |
| J23 | `garantia_produto` | DB032 (6 cols produto) | Garantia <-> Produto (problema/original/vendido) |
| J24 | `garantia_avaria` | DB032 (Avarias) | Garantia <-> Avaria |
| J25 | `os_checklist` | DB082 (6+ cols checklist) | OS <-> Checklist Item (7 tipos) |
| J26 | `os_peca` | DB082 (4+ cols pecas) | OS <-> Peca/Produto (interna/externa) |
| J27 | `os_servico` | DB082 (3 cols servico) | OS <-> Servico (descricao + preco) |
| J28 | `os_financeiro` | DB082 (Lista_CAP-CAR) | OS <-> CAP/CAR |
| J29 | `projeto_membro` | DB079 (MEMBROS) | Projeto <-> Usuario |
| J30 | `funcao_permissao` | DB014 (10 cols), DB011 | Funcao <-> Permissao (10 modulos) |
| J31 | `funil_etapa` | DB092 (EtapasFunil) | Funil <-> Etapa CRM (com ordem) |
| J32 | `cliente_etiqueta` | DB016 (ETIQUETAS) | Cliente <-> Tag |
| J33 | `cliente_credito` | DB016 (2 cols credito) | Cliente <-> CAP/CAR (entrada/saida) |
| J34 | `notificacao_usuario` | DB102 (2 cols lido/visivel) | Notificacao <-> Usuario (lido/visivel) |
| J35 | `produto_especificacao` | DB062 (CAD_Especificacoes) | Produto <-> Especificacao (chave-valor) |
| J36 | `devocional_keyword` | DB126 (keywords) | Devocional <-> Keyword |
| J37 | `carteira_recarga` | DB124 (RECARGAS) | Carteira <-> Recarga |
| J38 | `checklist_lista_item` | DB004 (ListaItens) | Checklist <-> Item (template) |
| J39 | *(FK direto)* | DB095 (MetasColaborador) | Meta Geral -> Meta Colaborador (1:N) |
| J40 | `ticket_comentario` | DB041 (COMENTARIOS-TICKET) | Ticket <-> Comentario |
| J41 | `tarefa_crm_comentario` | DB081 (LEAD-Comentarios) | Tarefa CRM <-> Comentario |

---

## 4. Transformacoes de Tipos (padrao global)

### 4.1 Todas as tabelas

| Coluna Legada | Tipo Legado | Tipo V2 | Exemplo |
|---------------|-------------|---------|---------|
| `"unique_id"` (PK) | `text NOT NULL` | `bigint generated always as identity` | PK auto-gerado |
| `"unique_id"` (valor) | `text NOT NULL` | `bubble_unique_id text unique` | Mantido para mapeamento |
| `"Creation Date"` | `text` ou `timestamp` | `created_at timestamptz default now()` | Timezone-aware |
| `"Modified Date"` | `text` ou `timestamp` | `updated_at timestamptz default now()` | + trigger auto-update |
| `"000_Empresa"` | `text` (ref logica) | `empresa_id bigint FK` | FK real + indice |
| `"001_ATIVO"` | `text` (~50%) | `ativo boolean default true` | Tipo correto |
| Precos/Valores | `text` ou `real` | `numeric(12,2)` ou `numeric(14,2)` | Sem erro de arredondamento |
| Aliquotas | `text` | `numeric(8,4)` | 4 casas decimais |
| Datas de negocio | `text` | `timestamptz` | Timezone-aware |
| Colunas lista | `text` (IDs serializados) | Tabela junction | Normalizado |
| Meses/Ordem | `bigint` | `integer` ou `smallint` | Tamanho correto |
| Status HTTP | `bigint` | `smallint` | Tamanho correto |
| NPS scores | `text` ou `bigint` | `smallint CHECK (between 1 and 10)` | Validacao no banco |

### 4.2 Naming Convention

| Aspecto | Legado | V2 |
|---------|--------|-----|
| Tabelas | `"DB029_LAN_ATENDIMENTO"` (UPPER, aspas) | `atendimentos` (snake_case, sem aspas) |
| Colunas | `"069_VEN_PRODUTOS"` (numerico, aspas) | `ven_produtos` ou junction table |
| Caracteres especiais | `"002_CPF / CNPJ]"`, `"CONF_CHAVE PIX"` | `cpf_cnpj`, `conf_chaves_pix` |
| Palavra reservada | `"User"`, `"null"` | `usuarios`, removida |

---

## 5. Seguranca: Campos para Vault

Campos de credenciais que devem ser migrados do `text` plano para **Supabase Vault (pgsodium)**:

| Tabela V2 | Campo | Conteudo |
|-----------|-------|----------|
| `info_fiscal` | `cert_senha` | Senha do certificado digital |
| `info_fiscal` | `nfce_codigo_csc` | Codigo CSC da NFCe |
| `info_fiscal` | `nfse_login` | Login NFSe |
| `info_fiscal` | `nfse_senha` | Senha NFSe |
| `info_fiscal` | `wmbr_access_token` | Token WebmaniaBR |
| `info_fiscal` | `wmbr_access_token_secret` | Token Secret WebmaniaBR |
| `info_fiscal` | `wmbr_bearer_access_token` | Bearer Token WebmaniaBR |
| `info_fiscal` | `wmbr_consumer_key` | Consumer Key WebmaniaBR |
| `info_fiscal` | `wmbr_consumer_secret` | Consumer Secret WebmaniaBR |
| `nfse_info_fiscal` | `login` | Login NFSe municipal |
| `nfse_info_fiscal` | `senha` | Senha NFSe municipal |
| `nfse_info_fiscal` | `token` | Token NFSe municipal |
| `api_keys` | `consumer_key` | API Key publica |
| `api_keys` | `consumer_secret` | API Key secreta |

---

## 6. Tabelas Mais Complexas (detalhamento)

### 6.1 Atendimentos (DB029 -> atendimentos)

A tabela com mais junction tables associadas:

```
Bubble DB029_LAN_ATENDIMENTO (~90 colunas)
  ├── "069_VEN_PRODUTOS"          -> [J06] atendimento_produto (tipo='venda')
  ├── "066_TRO_PRODUTOS"          -> [J06] atendimento_produto (tipo='troca')
  ├── "037_BRI_PRODUTOS"          -> [J06] atendimento_produto (tipo='brinde')
  ├── "079_z_CAP_CAR_Pagamento"   -> [J07] atendimento_financeiro (tipo='pagamento')
  ├── "080_z_CAP_Custos"          -> [J07] atendimento_financeiro (tipo='custo')
  ├── "081_z_CAR_Pagamento"       -> [J07] atendimento_financeiro (tipo='recebimento')
  ├── "032_Termos-selecionados"   -> [J08] atendimento_termo
  ├── "084_COD_GARANTIA"          -> [J09] atendimento_garantia
  └── "049_FISCAL_PAGAMENTO"      -> [J10] atendimento_fiscal_pagamento
```

### 6.2 Ordens de Servico (DB082 -> ordens_servico)

A tabela mais complexa do sistema (~111 colunas no legado):

```
Bubble DB082_TREL_TAREFA_MANUT (~111 colunas, 18 listas)
  ├── "[01] - CHECKLIST"           -> [J25] os_checklist (tipo='principal')
  ├── "[66] - CHECKLIST_ORIGEM"    -> [J25] os_checklist (tipo='origem')
  ├── "[67] - CHECK_PROBLEMAS"     -> [J25] os_checklist (tipo='problema')
  ├── "[99] - CHECKLIST POSTERIOR"  -> [J25] os_checklist (tipo='posterior')
  ├── "[99] - Pecas_CI_Utilizadas" -> [J26] os_peca (origem='interna')
  ├── "[99] - Pecas_SI_Utilizadas" -> [J26] os_peca (origem='externa')
  ├── "[71] - LISTA_SERVICO"       -> [J27] os_servico
  └── "Z - Lista_CAP-CAR"         -> [J28] os_financeiro
```

### 6.3 Usuarios (User -> usuarios)

```
Bubble User (~50 colunas, 4 listas)
  ├── "00_EMP_Vinculadas"    -> [J01] usuario_empresa
  ├── "99_Dispositivos"      -> [J02] usuario_dispositivo
  ├── "09 - instancias"      -> [J03] usuario_instancia
  └── "06 - filasUsuario"    -> [J04] usuario_fila

  + auth_uid (uuid) vinculado a auth.users do Supabase
  + DB002_ACESSO eliminada (absorvida por [J01])
```

---

## 7. Infraestrutura V2

### 7.1 RLS (Row Level Security)

- **Multi-tenant** via funcao `empresas_do_usuario()`
- Todas as 141 tabelas com RLS habilitado
- Tabelas com `empresa_id`: policies `SELECT/INSERT/UPDATE/DELETE` filtram por tenant
- Tabelas globais (sem `empresa_id`): `SELECT` para `auth.uid() is not null`

### 7.2 Triggers

- `set_updated_at()`: trigger `BEFORE UPDATE` em todas as tabelas com `updated_at`

### 7.3 Extensions

- `pgcrypto`
- `uuid-ossp`
- `pg_stat_statements`
- (futuro) `pgsodium` para Vault

---

## 8. Fluxo de Migracao por Tabela

Para cada tabela, o script de migracao deve:

```
1. INSERT INTO tabela_v2 (bubble_unique_id, col1, col2, ...)
   SELECT "unique_id", cast("col1" as tipo_correto), ...
   FROM "TABELA_LEGADA"

2. Para cada coluna lista:
   INSERT INTO junction_table (parent_id, child_id)
   SELECT v2_parent.id, v2_child.id
   FROM legado
   CROSS JOIN LATERAL unnest(string_to_array("coluna_lista", ',')) AS child_uid
   JOIN v2_child ON v2_child.bubble_unique_id = trim(child_uid)
   JOIN v2_parent ON v2_parent.bubble_unique_id = legado."unique_id"
```
