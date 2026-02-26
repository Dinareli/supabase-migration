# Bubble.io Database Schema
> 137 tables | 2109 active fields

## Table of Contents

| # | Table Name | Key | Fields | Relations |
|---|-----------|-----|--------|-----------|
| 1 | [DB001_ASSINATURA](#db001-assinatura) | `bd_infopagtoassinatura` | 27 | 1 |
| 2 | [DB002_EMPRESAS](#db002-empresas) | `z_empresas` | 53 | 7 |
| 3 | [DB003_LOG](#db003-log) | `z_log_info` | 17 | 3 |
| 4 | [DB004_CHECKLIST](#db004-checklist) | `_assist__checklist` | 6 | 1 |
| 5 | [DB005_CONF_VINCULACAO](#db005-conf-vinculacao) | `bd_vinculacao` | 7 | 2 |
| 6 | [DB006_CONF_ETIQUETAS](#db006-conf-etiquetas) | `_conf____termo_garantia1` | 22 | 2 |
| 7 | [DB007_CONF_TERMO_GARANTIA](#db007-conf-termo-garantia) | `_conf____termo_garantia` | 6 | 1 |
| 8 | [DB008_CONF_CHAVE PIX](#db008-conf-chave-pix) | `_conf__chave_pix` | 7 | 2 |
| 9 | [DB009_CONF_CIDADES_BR](#db009-conf-cidades-br) | `_zz__cidades_br1` | 7 | 0 |
| 10 | [DB010_CONF_CONTA](#db010-conf-conta) | `bd_conta` | 5 | 1 |
| 11 | [DB011_CONF_FUNCOES](#db011-conf-funcoes) | `_conf__funcoes` | 3 | 2 |
| 12 | [DB012_CONF_MAQUINA](#db012-conf-maquina) | `bd_maquinas` | 9 | 2 |
| 13 | [DB013_CONF_TAXAS](#db013-conf-taxas) | `cart_o` | 18 | 2 |
| 14 | [DB014_CONF_NEW_PERMISSAO](#db014-conf-new-permissao) | `_conf____perm_home` | 13 | 2 |
| 15 | [DB015_ASSIST_OS](#db015-assist-os) | `_assist__os` | 22 | 7 |
| 16 | [DB016_CLI_CLIENTE](#db016-cli-cliente) | `cliente_fornecedor` | 43 | 8 |
| 17 | [DB017_COM_COMPRA](#db017-com-compra) | `bd_compras` | 33 | 7 |
| 18 | [DB018_CAD_AVARIA](#db018-cad-avaria) | `avarias` | 4 | 1 |
| 19 | [DB019_CAD_AVARIA_ASSOCIADA](#db019-cad-avaria-associada) | `bd_valorporproduto` | 5 | 2 |
| 20 | [DB020_CAD_FORNECEDOR](#db020-cad-fornecedor) | `fornecedor` | 23 | 2 |
| 21 | [DB021_DOC_ASSIN](#db021-doc-assin) | `_doc__assin` | 18 | 1 |
| 22 | [DB022_EMP_EMPREST_DOIS](#db022-emp-emprest-dois) | `z_lanc_emp` | 12 | 2 |
| 23 | [DB023_EMP_EMPREST_UM](#db023-emp-emprest-um) | `z_lancamentosemprestimo` | 16 | 4 |
| 24 | [DB024_FIN_ABRE_FECHA](#db024-fin-abre-fecha) | `bd_abrefechacaixa` | 8 | 2 |
| 25 | [DB025_FIN_HISTORICO_CAIXA](#db025-fin-historico-caixa) | `bd_historicocaixas` | 19 | 7 |
| 26 | [DB026_FIN_SUBCATEGORIA_DRE](#db026-fin-subcategoria-dre) | `_fin__categoria` | 6 | 1 |
| 27 | [DB027_FIS_ESTOQUE_FISCAL](#db027-fis-estoque-fiscal) | `_fiscal__estoque_fiscal` | 29 | 6 |
| 28 | [DB028_FIS_NCM_CEST](#db028-fis-ncm-cest) | `_os__ncm` | 9 | 1 |
| 29 | [DB029_LAN_ATENDIMENTO](#db029-lan-atendimento) | `z_lancamentos` | 87 | 23 |
| 30 | [DB030_LAN_CAP-CAR](#db030-lan-cap-car) | `z_lancamentos_cap_car` | 69 | 17 |
| 31 | [DB031_LAN_ESTOQUE](#db031-lan-estoque) | `z_lancamentosestoque` | 96 | 26 |
| 32 | [DB032_LAN_GARANTIA](#db032-lan-garantia) | `_lan__garantia` | 43 | 16 |
| 33 | [DB033_LAN_INICIANTE_ATE](#db033-lan-iniciante-ate) | `z_lancamentosatendimento2` | 19 | 7 |
| 34 | [DB034_LAN_INICIANTE_ESTOQ](#db034-lan-iniciante-estoq) | `z_lancamentosestoque1` | 27 | 3 |
| 35 | [DB035_LAN_NOTAS FISCAIS_ATE](#db035-lan-notas-fiscais-ate) | `_lan__notas_fiscais` | 24 | 3 |
| 36 | [DB036_LAN_PAGTO_COMPRAS](#db036-lan-pagto-compras) | `z_lancamentoscompras` | 12 | 3 |
| 37 | [DB037_LAN_PAGTO_FISCAL](#db037-lan-pagto-fiscal) | `_lan__cap_car` | 17 | 3 |
| 38 | [DB038_LAN_PRE_VENDA](#db038-lan-pre-venda) | `_lan__pre_venda` | 42 | 16 |
| 39 | [DB039_LAN_PROD_PRE](#db039-lan-prod-pre) | `_lan__prod_pre` | 9 | 4 |
| 40 | [DB040_LAN_SIMULACOES](#db040-lan-simulacoes) | `z_lancamentosatendimento` | 13 | 6 |
| 41 | [DB041_LAN_SUPORTE](#db041-lan-suporte) | `_lan__suporte` | 16 | 2 |
| 42 | [DB042_LAN_TRANSFERENCIAS](#db042-lan-transferencias) | `_lan__transferencias` | 28 | 7 |
| 43 | [DB043_LEAD_COMO_CONHECEU](#db043-lead-como-conheceu) | `_lead__comoconheceu` | 4 | 1 |
| 44 | [DB044_MKT_CUPOM](#db044-mkt-cupom) | `cupom` | 3 | 0 |
| 45 | [DB045_MKT_LISTA_VIP](#db045-mkt-lista-vip) | `z_lista_vip` | 6 | 0 |
| 46 | [DB046_MOD_AVARIA](#db046-mod-avaria) | `x_bd_conf_categorias` | 2 | 0 |
| 47 | [DB047_MOD_CATEGORIA](#db047-mod-categoria) | `00bd_confiniciais_categorias` | 2 | 0 |
| 48 | [DB048_MOD_CONTA](#db048-mod-conta) | `x_bd_conf_taxas_parcelas` | 3 | 0 |
| 49 | [DB049_MOD_COR](#db049-mod-cor) | `x_bd_conf_categorias1` | 2 | 0 |
| 50 | [DB050_MOD_FRASE](#db050-mod-frase) | `x_bd_conf_frases` | 1 | 0 |
| 51 | [DB051_MOD_GRUPO](#db051-mod-grupo) | `1bd_confiniciais` | 1 | 0 |
| 52 | [DB052_MOD_MAQUINA](#db052-mod-maquina) | `x_bd_conf_contas` | 5 | 0 |
| 53 | [DB053_MOD_MARCA](#db053-mod-marca) | `00bd_confiniciais_marcas` | 2 | 0 |
| 54 | [DB054_MOD_PARCELA](#db054-mod-parcela) | `x_bd_conf_avarias` | 3 | 0 |
| 55 | [DB055_MOD_PRODUTO](#db055-mod-produto) | `bd_produtosiniciais` | 7 | 0 |
| 56 | [DB056_LAN_NF](#db056-lan-nf) | `_fis__entrada` | 60 | 14 |
| 57 | [DB057_PROD_CATEGORIA](#db057-prod-categoria) | `tipo` | 5 | 1 |
| 58 | [DB058_PROD_COR](#db058-prod-cor) | `cor` | 5 | 1 |
| 59 | [DB059_PROD_GRUPO](#db059-prod-grupo) | `grupo1` | 4 | 1 |
| 60 | [DB060_PROD_LOCAL](#db060-prod-local) | `_prod__local` | 5 | 1 |
| 61 | [DB061_PROD_MARCA](#db061-prod-marca) | `marca` | 5 | 1 |
| 62 | [DB062_PROD_PRODUTO](#db062-prod-produto) | `z_lan_cad` | 38 | 7 |
| 63 | [DB063_RF_1_MVA](#db063-rf-1-mva) | `_rf__mva` | 7 | 2 |
| 64 | [DB064_RF_2_ICMS](#db064-rf-2-icms) | `_rf__icms` | 7 | 2 |
| 65 | [DB065_RF_3_ICMS_ST](#db065-rf-3-icms-st) | `_rf__icms_st` | 7 | 2 |
| 66 | [DB066_RF_4_FCP](#db066-rf-4-fcp) | `_rf__fcp` | 7 | 2 |
| 67 | [DB067_RF_5_FCP_ST](#db067-rf-5-fcp-st) | `_rf__fcp_st` | 7 | 2 |
| 68 | [DB068_RF_6_BENEFICIO](#db068-rf-6-beneficio) | `_rf__5_fcp_st4` | 7 | 2 |
| 69 | [DB069_RF_7_IPI](#db069-rf-7-ipi) | `_rf__5_fcp_st` | 11 | 2 |
| 70 | [DB070_RF_8_PIS](#db070-rf-8-pis) | `_rf__7_ipi` | 10 | 2 |
| 71 | [DB071_RF_9_COFINS](#db071-rf-9-cofins) | `_rf__8_pis` | 10 | 2 |
| 72 | [DB072_RF_ICMS_INFO](#db072-rf-icms-info) | `_rf__5_fcp_st3` | 38 | 9 |
| 73 | [DB073_RF_INFO_FISCAL](#db073-rf-info-fiscal) | `_rf__informacao_fiscal` | 60 | 2 |
| 74 | [DB074_RF_PARAM_IMPOSTO](#db074-rf-param-imposto) | `_nf__categ_imposto` | 18 | 7 |
| 75 | [DB075_SIM_PAGAMENTO](#db075-sim-pagamento) | `bd_sim_pagamentos` | 9 | 2 |
| 76 | [DB076_SIM_TROCA](#db076-sim-troca) | `z_lanc_troca` | 13 | 5 |
| 77 | [DB077_SIM_VENDA](#db077-sim-venda) | `z_lanc_venda` | 11 | 3 |
| 78 | [DB078_TREL_COMENT_TAREFA](#db078-trel-coment-tarefa) | `communication_comment` | 4 | 2 |
| 79 | [DB079_TREL_PROJETO](#db079-trel-projeto) | `function` | 8 | 5 |
| 80 | [DB080_TREL_STATUS_TAREFA](#db080-trel-status-tarefa) | `task_status` | 7 | 3 |
| 81 | [DB081_TREL_TAREFA_CRM](#db081-trel-tarefa-crm) | `_trel____tarefa_crm` | 18 | 2 |
| 82 | [DB082_TREL_TAREFA_MANUT](#db082-trel-tarefa-manut) | `communication` | 111 | 25 |
| 83 | [DB083_UAZ_TRANSACIONAL](#db083-uaz-transacional) | `whatsapp_transacional` | 4 | 0 |
| 84 | [DB084_UAZ_VERIF_TEL](#db084-uaz-verif-tel) | `verificar_telefone` | 3 | 0 |
| 85 | [DB085_UAZ_WEBHOOK](#db085-uaz-webhook) | `webhook_uazapi_otimizado` | 27 | 0 |
| 86 | [DB086_UTIL_PRECIFICADOR](#db086-util-precificador) | `bd_precificador` | 9 | 1 |
| 87 | [DB087_CRM_INSTANCIAS](#db087-crm-instancias) | `whatsapp` | 12 | 2 |
| 88 | [DB088_CRM_ETAPAS](#db088-crm-etapas) | `_db_88__crm_deptos` | 5 | 2 |
| 89 | [DB089_CRM_FILAS](#db089-crm-filas) | `_db_89__crm_filas` | 4 | 2 |
| 90 | [DB090_CRM_CONTATOS](#db090-crm-contatos) | `_db_90__crm_contatos` | 14 | 3 |
| 91 | [DB091_CRM_ETIQUETAS](#db091-crm-etiquetas) | `_db_91__crm_etiquetas` | 3 | 1 |
| 92 | [DB092_CRM_FUNIL](#db092-crm-funil) | `_db_92__crm_coluna_kanban` | 4 | 2 |
| 93 | [DB093_CRM-EVENTO](#db093-crm-evento) | `%e1` | 16 | 2 |
| 94 | [DB094_CRM-DADOS-USER](#db094-crm-dados-user) | `_db_102__crm_dados_user` | 8 | 2 |
| 95 | [DB095_METAS-GERAIS](#db095-metas-gerais) | `_db_95__metas1` | 7 | 3 |
| 96 | [DB096_METAS_COLABORADOR](#db096-metas-colaborador) | `_db_95__metas` | 13 | 3 |
| 97 | [DB097_CHANGELOG](#db097-changelog) | `_db_97__changelog` | 4 | 0 |
| 98 | [DB098_MARKETPLACE](#db098-marketplace) | `_db_98__marketplace` | 10 | 0 |
| 99 | [DB099_FORMS](#db099-forms) | `_db99___forms_` | 7 | 0 |
| 100 | [DB100_PERSONALIZACAO](#db100-personalizacao) | `_db_100____white_label` | 6 | 0 |
| 101 | [DB101_IMP-MANUAL](#db101-imp-manual) | `_db_101__imp_manual` | 12 | 3 |
| 102 | [DB102_NOTIFICACOES](#db102-notificacoes) | `_db_94__notificacoes` | 6 | 4 |
| 103 | [DB103_LAN_ATUALIZACOES_PREVENDA](#db103-lan-atualizacoes-prevenda) | `_db_103__lan_atualizacoes_prevenda` | 4 | 3 |
| 104 | [DB104_EMP_SALDO_FISCAL](#db104-emp-saldo-fiscal) | `_db_104__emp_saldo_fiscal` | 4 | 3 |
| 105 | [DB105_LAN_DRE](#db105-lan-dre) | `_db_105__lan_dre__novo_` | 41 | 2 |
| 106 | [DB106_WHATSAPP-DISTRIBUIDOR](#db106-whatsapp-distribuidor) | `_db_106__whatsapp_distribuidor` | 1 | 0 |
| 107 | [DB107_API-KEYS](#db107-api-keys) | `_db_107__chave_api` | 5 | 1 |
| 108 | [DB108_API-LOG](#db108-api-log) | `_db_108__log_api` | 8 | 1 |
| 109 | [DB109_API-RATE-LIMIT](#db109-api-rate-limit) | `_db_109__api_rate_limit` | 6 | 2 |
| 110 | [DB110_AUX-OS](#db110-aux-os) | `_db_110__aux_os` | 1 | 0 |
| 111 | [DB111_IMPRESSAO_ETIQUETAS](#db111-impressao-etiquetas) | `_db_110__impressao_etiquetas` | 29 | 2 |
| 112 | [DB112_CONFIGURACAO_ETIQUETAS](#db112-configuracao-etiquetas) | `_db_111__configuracao_etiquetas` | 14 | 1 |
| 113 | [DB113_UTILIZACAO_SUBMODULOS](#db113-utilizacao-submodulos) | `_db_112__utilizacao_submodulos` | 68 | 1 |
| 114 | [DB114_PATRIMONIO](#db114-patrimonio) | `_db_113__patrim_nio` | 7 | 1 |
| 115 | [DB115_NPS-GERAL](#db115-nps-geral) | `_db_115__nps_geral` | 10 | 2 |
| 116 | [DB116_ESTATISTICAS](#db116-estatisticas) | `_db_116__estatisticas` | 3 | 0 |
| 117 | [DB117_ENGAJAMENTO](#db117-engajamento) | `_db_117__engajamento` | 2 | 1 |
| 118 | [DB118_NFSE_INFO_FISCAL](#db118-nfse-info-fiscal) | `_db_118__nfse_info_fiscal` | 19 | 2 |
| 119 | [DB119_RF_NFSE](#db119-rf-nfse) | `_db_063__rf_1_mva` | 11 | 2 |
| 120 | [DB120_RETORNO_LOTE](#db120-retorno-lote) | `_db_120__retorno_lote_nfse` | 11 | 2 |
| 121 | [DB121_RETORNO_NFSE](#db121-retorno-nfse) | `_db_121__retorno_nfse` | 14 | 2 |
| 122 | [DB122_NFSE_SERVICOS](#db122-nfse-servicos) | `_db_122__nfse_servicos` | 4 | 3 |
| 123 | [DB123_CHECK_LIST_AVALIACAO](#db123-check-list-avaliacao) | `_db_123__check_list_avaliacao` | 3 | 1 |
| 124 | [DB124_CARTEIRA](#db124-carteira) | `_db_124__carteira` | 6 | 2 |
| 125 | [DB125_HISTORICO_RECARGA](#db125-historico-recarga) | `_db_125__historico_recarga` | 9 | 2 |
| 126 | [DB126_DEVOCIONAL](#db126-devocional) | `db126_devocional` | 12 | 0 |
| 127 | [DB127_AUDITORIA-INTERNA](#db127-auditoria-interna) | `db127_auditoria_interna` | 10 | 2 |
| 128 | [DB128_IBS-CBS](#db128-ibs-cbs) | `db128_ibs_cbs` | 15 | 2 |
| 129 | [DB129_Pesquisa_CHURN](#db129-pesquisa-churn) | `db129_pesquisa_churn` | 15 | 2 |
| 130 | [DB130_SEQ-OS](#db130-seq-os) | `db130_seq_os` | 4 | 1 |
| 131 | [DB999_VERIF_CONTAS_PAGAR](#db999-verif-contas-pagar) | `bd_contas_pagar` | 21 | 5 |
| 132 | [DB999_VERIF_CONTAS_RECEB](#db999-verif-contas-receb) | `bd_contar_receber` | 27 | 5 |
| 133 | [DB999_VERIF_ESTOQ_ACESSORIO](#db999-verif-estoq-acessorio) | `zzz_estoque_acessorio` | 4 | 3 |
| 134 | [DB999_VERIF_NOTIFICATIONS](#db999-verif-notifications) | `notification1` | 6 | 4 |
| 135 | [DB999_VERIF_TASK_CHECKLIST](#db999-verif-task-checklist) | `task___checklist` | 6 | 3 |
| 136 | [SAT](#sat) | `db029_lan_atendimento` | 16 | 5 |
| 137 | [User](#user) | `user` | 37 | 13 |

---

## DB001_ASSINATURA
> Key: `bd_infopagtoassinatura` | Fields: 27 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 024_CupomAtivado | text |  |
| 2 | 021_AsaasEvento | text |  |
| 3 | 022_AsaasStatus | text |  |
| 4 | 004_Mensalidade | number |  |
| 5 | 025_DToken | text |  |
| 6 | 001_CusID | text |  |
| 7 | 023_AsaasValorRecebido | number |  |
| 8 | 002_AsaasDescricao | text |  |
| 9 | 003_AsaasParcela | number |  |
| 10 | 006_Recorrencia | text |  |
| 11 | 007_TotalPago | number |  |
| 12 | 012_Cancelado | boolean | `false` |
| 13 | 018_AssinanteUF | text |  |
| 14 | 008_TicketMedio | number |  |
| 15 | 016_NomeAssinante | text |  |
| 16 | 010_DataAcessoAte | date |  |
| 17 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 18 | 017_CidadeAssinante | text |  |
| 19 | 020_FormaEntrada | text |  |
| 20 | 015_DataCancelamento | date |  |
| 21 | 017_ContatoAssinante | text |  |
| 22 | 005_Plano | option([OS] PLANOS) |  |
| 23 | 011_Ativo | boolean | `false` |
| 24 | 013_MotivoCancelamento | text |  |
| 25 | 019_ObservacoesAdicionais | text |  |
| 26 | 009_DataCriacaoAssinatura | date |  |
| 27 | 014_TipoMotivoCancelamento | option([OS] - MOTIVO-CHURN) |  |

---

## DB002_EMPRESAS
> Key: `z_empresas` | Fields: 53 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 013_CNPJ | text |  |
| 2 | 040_APIKey | text |  |
| 3 | 017_Instagram | text |  |
| 4 | 001_AcessoAte | date |  |
| 5 | 043_FaturaUrl | text |  |
| 6 | 011_AsaasCusID | text |  |
| 7 | 020_NomeEmpresa | text | `` |
| 8 | 043_Engajamento | number |  |
| 9 | 009_FiscIE | text |  |
| 10 | 026_Beta | boolean |  |
| 11 | 024_TermoEmpresa | text |  |
| 12 | 022_QtdVendedores | number |  |
| 13 | 004_Recorrencia | text |  |
| 14 | 008_FiscCNPJ | text |  |
| 15 | 014_ComercialStatus | text | ` ` |
| 16 | 021_PrimeiroAcesso | boolean | `true` |
| 17 | 015_EnderecoEmpresa | text |  |
| 18 | 023_TelefoneEmpresa | text |  |
| 19 | 018_LimiteUsuarios | number |  |
| 20 | 019_LogoEmpresa | image |  |
| 21 | 006_Plano | option([OS] PLANOS) |  |
| 22 | 047_OSPlanos | text |  |
| 23 | 034_NovasCores | boolean |  |
| 24 | 030_Certificado | file |  |
| 25 | 039_AdicionaDias | boolean |  |
| 26 | 044_PrimeiroPagto | boolean | `false` |
| 27 | 007_FiscAtivo | boolean | `false` |
| 28 | 012_CadastroCompleto | boolean | `false` |
| 29 | 045_IDUnicoTXT | text |  |
| 30 | 005_NovosModelos | boolean |  |
| 31 | 027_SuperBeta | boolean |  |
| 32 | 033_EmailEmpresa | text |  |
| 33 | 002_UltimoAcesso | date |  |
| 34 | 025_UsuarioAdicional | number |  |
| 35 | 038_CRMAcessoAte | date |  |
| 36 | 016_InfoPagtoAssinatura | boolean | `false` |
| 37 | 048_Project | list<relation -> DB079_TREL_PROJETO> |  |
| 38 | 042_AssinaturaIrregular | boolean |  |
| 39 | 036_AddOnEmpFiscal | number |  |
| 40 | 035_AddOnAssistencia | boolean | `true` |
| 41 | 051_EngajamentoCount-2025 | number |  |
| 42 | 052_EngajamentoCount-2026 | number |  |
| 43 | 032_AguardandoAprovacao | boolean | `true` |
| 44 | 049_RegimeTribuario | text |  |
| 45 | 037_Carteira | relation -> DB124_CARTEIRA |  |
| 46 | 003_EmpresasAcesso | list<relation -> DB002_EMPRESAS> |  |
| 47 | 041_Assinatura | relation -> DB001_ASSINATURA |  |
| 48 | 050_Dispositivos | list<relation -> static.device [?]> |  |
| 49 | 029_IDVisual | option([OS] - ID_VISUAL) | `padrao` |
| 50 | 031_RFFiscal | relation -> DB073_RF_INFO_FISCAL |  |
| 51 | 028_Termos | list<relation -> DB007_CONF_TERMO_GARANTIA> |  |
| 52 | 046_ConfiguracoesGerais | list<option([OS] - CONFIG_GERAIS)> |  |
| 53 | 010_RegimeTrib | option([OS] REGIME_TRIBUTARIO) |  |

---

## DB003_LOG
> Key: `z_log_info` | Fields: 17 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Acao | text |  |
| 2 | 014_Tela | text |  |
| 3 | 002_Botao | text |  |
| 4 | 004_Codigo | text |  |
| 5 | 015_Usuario | relation -> User |  |
| 6 | 005_InfoDeletada | text |  |
| 7 | 006_InfoModificada | text |  |
| 8 | 003_ClienteFornecedor | text |  |
| 9 | 016_UnicoID | text |  |
| 10 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 11 | 013_InfoModificadaQtd | number |  |
| 12 | 009_InfoModificadaIMEI | list<text> |  |
| 13 | 010_InfoModificadaOBSExterna | text |  |
| 14 | 011_InfoModificadaOBSInterna | text |  |
| 15 | 008_InfoModificadaCusto | list<number> |  |
| 16 | 007_InfoModificadaBateria | list<number> |  |
| 17 | 012_InfoModificadaProdutos | list<relation -> DB031_LAN_ESTOQUE> |  |

---

## DB004_CHECKLIST
> Key: `_assist__checklist` | Fields: 6 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_CodChecklist | text |  |
| 2 | 003_Descricao | text |  |
| 3 | 001_Ativo | boolean |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 5 | 004_ListaItens | list<text> |  |
| 6 | 005_TipoUso | option([OS] TIPO-CHECKLIST) |  |

---

## DB005_CONF_VINCULACAO
> Key: `bd_vinculacao` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_Compensacao | number |  |
| 2 | 003_Conta | relation -> DB010_CONF_CONTA |  |
| 3 | 001_Ativo | boolean | `true` |
| 4 | 006_IDUnico | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 005_TXT_FormaPagto | text |  |
| 7 | 004_FormaPagto | option([OS] FORMA_PAGTO) |  |

---

## DB006_CONF_ETIQUETAS
> Key: `_conf____termo_garantia1` | Fields: 22 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 006_SKU | boolean | `false` |
| 2 | 008_COR | boolean | `false` |
| 3 | 004_IMEI | boolean | `false` |
| 4 | 010_BATERIA | boolean | `false` |
| 5 | 011_MEMORIA | boolean | `false` |
| 6 | 019_CONF-LOGO | image |  |
| 7 | 005_NUM-SERIE | boolean | `false` |
| 8 | 009_CATEGORIA | boolean | `false` |
| 9 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 10 | 007_COD-INTERNO | boolean | `false` |
| 11 | 014_SCAN-COD-BARRA | text |  |
| 12 | 015_CONF-NOME-ETIQ | text | `` |
| 13 | 020_PRECO-VENDA | boolean | `false` |
| 14 | 003_NOME-PRODUTO | boolean | `false` |
| 15 | 018_CONF-LARG-COD | number | `3` |
| 16 | 012_ARMAZENAMENTO | boolean | `false` |
| 17 | 016_CONF-ALTU-ETIQ | number |  |
| 18 | 017_CONF-LARG-ETIQ | number |  |
| 19 | 013_ESPECIFICACOES | boolean | `false` |
| 20 | 001_TIPO-PROD-OS | option([OS] TIPO_PRODUTO) |  |
| 21 | 002_SUBTIPO-PROD-OS | option([OS] SUBTIPO_PRODUTO) |  |
| 22 | 021_MODELO_IMPRESSAO | list<relation -> DB112_CONFIGURACAO_ETIQUETAS> |  |

---

## DB007_CONF_TERMO_GARANTIA
> Key: `_conf____termo_garantia` | Fields: 6 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Ativo | boolean | `true` |
| 2 | 005_Padrao | boolean |  |
| 3 | 003_Titulo do termo | text |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 5 | 004_Texto | text |  |
| 6 | 002_Uso de termo | option([OS] TIPO_TERMO) |  |

---

## DB008_CONF_CHAVE PIX
> Key: `_conf__chave_pix` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_ATIVO] | boolean |  |
| 2 | 003_CHAVE PIX] | text |  |
| 3 | 006_ID-UNICO | text | `PIX` |
| 4 | 005_TXT_FORMA_PAGTO | text |  |
| 5 | 002_D_CONTA] | relation -> DB010_CONF_CONTA |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 004_D_FORMA_PAGTO] | option([OS] FORMA_PAGTO) | `pix` |

---

## DB009_CONF_CIDADES_BR
> Key: `_zz__cidades_br1` | Fields: 7 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_Nome | text |  |
| 2 | 005_IBGE | text |  |
| 3 | 004_UF TEXT | text |  |
| 4 | 006_TXT_ESTADOS | text |  |
| 5 | 007_ID-UNICO | text |  |
| 6 | 003_UF | option([OS] ESTADOS) |  |
| 7 | 001_Cidade-normalizada | text |  |

---

## DB010_CONF_CONTA
> Key: `bd_conta` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_NOME_CONTA] | text |  |
| 2 | 001_ATIVO] | boolean | `true` |
| 3 | 003_SALDO] | number | `0` |
| 4 | 004_ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB011_CONF_FUNCOES
> Key: `_conf__funcoes` | Fields: 3 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_NOME-FUNCAO] | text |  |
| 2 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 3 | 002_PERMISSAO | relation -> DB014_CONF_NEW_PERMISSAO |  |

---

## DB012_CONF_MAQUINA
> Key: `bd_maquinas` | Fields: 9 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_MÁQUINA] | text |  |
| 2 | 002_DESATIVADO | boolean | `false` |
| 3 | 001_ATIVO | boolean | `true` |
| 4 | 006_TEMPO_COMPENSACAO] | number | `0` |
| 5 | 008_ID-UNICO | text |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 007_TXT_FORMA_PAGTO | text |  |
| 8 | 003_CONTA] | relation -> DB010_CONF_CONTA |  |
| 9 | 005_FORMA_PAGTO] | option([OS] FORMA_PAGTO) | `cr_dito` |

---

## DB013_CONF_TAXAS
> Key: `cart_o` | Fields: 18 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 007_LOJA_ELO] | number | `0` |
| 2 | 009_LOJA_VISA] | number | `0` |
| 3 | 015_DISPLAY] | text |  |
| 4 | 010_LOJA_OUTRAS] | number | `0` |
| 5 | 008_LOJA_MASTER] | number | `0` |
| 6 | 002_CLIENTE_ELO] | number | `0` |
| 7 | 012_PARCELA_NOVA] | number |  |
| 8 | 001_CLIENTE_AMEX] | number | `0` |
| 9 | 004_CLIENTE_VISA] | number | `0` |
| 10 | 005_CLIENTE_OUTRAS] | number | `0` |
| 11 | 006_LOJA_AMEX] | number | `0` |
| 12 | 017_ID-UNICO | text |  |
| 13 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 14 | 003_CLIENTE_MASTER] | number | `0` |
| 15 | 016_TXT_PARCELAS_DEBITO | text |  |
| 16 | 013_ORDEM-PARCELAS] | number |  |
| 17 | 011_MAQUINA] | relation -> DB012_CONF_MAQUINA |  |
| 18 | 014_PARCELA] | option([OS] PARCELAS + DEBITO) |  |

---

## DB014_CONF_NEW_PERMISSAO
> Key: `_conf____perm_home` | Fields: 13 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_NOME-FUNCAO | text |  |
| 2 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 3 | 001_FUNCAO | relation -> DB011_CONF_FUNCOES |  |
| 4 | 004_CAD-PERM | list<option([OS] - PERM-CADASTROS)> |  |
| 5 | 003_HOME-PERM | list<option([OS] - PERM-HOME)> |  |
| 6 | 005_OPS-PERM | list<option([OS] - PERM-OPERACOES)> |  |
| 7 | 006_FIN-PERM | list<option([OS] - PERM-FINANCEIRO)> |  |
| 8 | 007_REL-PERM | list<option([OS] - PERM-RELATORIOS)> |  |
| 9 | 008_UTI-PERM | list<option([OS] - PERM-UTILITARIOS)> |  |
| 10 | 009_FIS-PERM | list<option([OS] - PERM-FISCAL)> |  |
| 11 | 010_ADIC-PERM | list<option([OS] - PERM-ADICIONAIS)> |  |
| 12 | 012_CONF-PERM | list<option([OS] - PERM-CONFIGURACOES)> |  |
| 13 | 011_ASSIS-PERM | list<option([OS] - PERM-ASSISTENCIA)> |  |

---

## DB015_ASSIST_OS
> Key: `_assist__os` | Fields: 22 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_DATA_TASK | date |  |
| 2 | 011_COR | text |  |
| 3 | 012_IMEI | text |  |
| 4 | 019_MARCA | text |  |
| 5 | 020_GRUPO | text |  |
| 6 | 002_COD_TASK | text |  |
| 7 | 004_STATUS | text |  |
| 8 | 001_ATIVO | boolean |  |
| 9 | 006_RESPONSAVEL | relation -> User |  |
| 10 | 007_CRIADO POR | relation -> User |  |
| 11 | 010_BATERIA | number |  |
| 12 | 013_NUM_SERIE | text |  |
| 13 | 021_NOME_PRODUTO | text |  |
| 14 | 017_ITEM_CHECKLIST | list<text> |  |
| 15 | 018_STATUS_CHECKLIST | list<text> |  |
| 16 | 016_COD_COMPARTILHAR | text |  |
| 17 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 18 | 009_MEMORIA_ESPECIFICACAO | text |  |
| 19 | 014_AVARIAS | list<relation -> DB018_CAD_AVARIA> |  |
| 20 | 008_PROD_CLIENTE | relation -> DB062_PROD_PRODUTO |  |
| 21 | 015_ESTOQUE_LOCAL | relation -> DB060_PROD_LOCAL |  |
| 22 | 003_DADOS_CLIENTE | relation -> DB016_CLI_CLIENTE |  |

---

## DB016_CLI_CLIENTE
> Key: `cliente_fornecedor` | Fields: 43 | Relations: 8

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 016_END_CEP] | text |  |
| 2 | 002_CLIENTE_NOME] | text |  |
| 3 | 005_CLIENTE_EMAIL] | text |  |
| 4 | 022_DATA_CRIACAO] | text |  |
| 5 | 011_END_RUA] | text |  |
| 6 | 004_CLIENTE_CPF_OU_CNPJ] | text |  |
| 7 | 037_Teste123 | number |  |
| 8 | 017_END_UF] | text |  |
| 9 | 036_QTD-CARAC | number |  |
| 10 | 006_CLIENTE_TELEFONE_01] | text |  |
| 11 | 018_COMO_CONHECEU] | text |  |
| 12 | 029_INSTAGRAM_CLIENTE | text |  |
| 13 | 019_OUTRA_FORMA] | text |  |
| 14 | 034_TOTAL-OS | number |  |
| 15 | 001_ATIVO] | boolean | `true` |
| 16 | 014_END_BAIRRO] | text |  |
| 17 | 015_END_CIDADE | text |  |
| 18 | 013_END_NUM] | text |  |
| 19 | 010_CLIENTE_GENERO] | option([OS] GENERO) |  |
| 20 | 023_TIPO_CLIENTE] | text |  |
| 21 | 020_POSSUI_EMP] | boolean |  |
| 22 | 025_DDI_NUMERO] | text | `+55` |
| 23 | 008_CLIENTE_MES_ANIVER] | number |  |
| 24 | 038_TXT_GENERO | text |  |
| 25 | 007_CLIENTE_DATA_NASCIMENTO] | date |  |
| 26 | 009_CLIENTE_DIA_ANIVER] | number |  |
| 27 | 026_DATA_CORRETA] | date |  |
| 28 | 035_ULTIMA-OS-DATA | date |  |
| 29 | 039_ID-UNICO | text |  |
| 30 | 031_TOTAL-ATE | number |  |
| 31 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 32 | 024_INFO_ADICIONAL] | text |  |
| 33 | 012_END_COMPLEMENTO] | text |  |
| 34 | 032_ULTIMO-ATE-DATA | date |  |
| 35 | 028_CARTEIRA_USUARIO] | relation -> User |  |
| 36 | 040_Credito em vendas | number |  |
| 37 | 003_CPF_CNPJ_Normalizado | text |  |
| 38 | 033_VINCULADOS | list<relation -> DB082_TREL_TAREFA_MANUT> |  |
| 39 | 021_EMP_ATIVOS] | list<relation -> DB023_EMP_EMPREST_UM> |  |
| 40 | 027_ETIQUETAS] | list<relation -> DB091_CRM_ETIQUETAS> |  |
| 41 | 030_ATENDIMENTOS-VINCULADOS | list<relation -> DB029_LAN_ATENDIMENTO> |  |
| 42 | 042_Credito Historico de saidas | list<relation -> DB030_LAN_CAP-CAR> |  |
| 43 | 041_Credito Historico de entradas | list<relation -> DB030_LAN_CAP-CAR> |  |

---

## DB017_COM_COMPRA
> Key: `bd_compras` | Fields: 33 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 016_ORIGEM] | text |  |
| 2 | 010_CPF-CNPJ] | text |  |
| 3 | 001_ATIVO] | boolean | `false` |
| 4 | 009_COD_NOTA] | text |  |
| 5 | 024_TOTAL_PRODUTOS] | number |  |
| 6 | 014_DATA_COMPRA] | date |  |
| 7 | 017_PAGTO_DATA] | date |  |
| 8 | 027_ID-CHAVE | text |  |
| 9 | 030_MenuEntradaInfo | text |  |
| 10 | 003_PAGTO_FRETE] | number |  |
| 11 | 020_PAGTO_QUITADO] | text |  |
| 12 | 023_TOTAL_BRUTO] | number |  |
| 13 | 006_Cancelada por | relation -> User |  |
| 14 | 002_CONCRETIZADA] | boolean | `false` |
| 15 | 004_PAGTO_IMPOSTO] | number |  |
| 16 | 032_ID-UNICO | text |  |
| 17 | 026_DOC_FISCAL | boolean |  |
| 18 | 018_PAGTO_DESCONTO] | number |  |
| 19 | 019_PAGTO_OCORRENCIA] | text |  |
| 20 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 21 | 005_PAGTO_OUTRAS] | number |  |
| 22 | 007_Data cancelamento | date |  |
| 23 | 022_QTD_PARCELAS] | number |  |
| 24 | 031_TXT_FORMA_PAGTO | text |  |
| 25 | 021_PAGTO_RECORRENCIA] | number |  |
| 26 | 008_Motivo cancelamento | text |  |
| 27 | 011_CAIXA] | relation -> DB010_CONF_CONTA |  |
| 28 | 025_VALOR_POR_PARCELA] | number |  |
| 29 | 015_FORNECEDOR] | relation -> DB020_CAD_FORNECEDOR |  |
| 30 | 028_NF_Cod-ENT | relation -> DB056_LAN_NF |  |
| 31 | 029_CAP-CAR | list<relation -> DB030_LAN_CAP-CAR> |  |
| 32 | 012_FORMA] | option([OS] FORMA_PAGTO) |  |
| 33 | 013_ProdutosComprados | list<relation -> DB031_LAN_ESTOQUE> |  |

---

## DB018_CAD_AVARIA
> Key: `avarias` | Fields: 4 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_NOME_AVARIA] | text |  |
| 2 | 001_ATIVO] | boolean | `true` |
| 3 | 003_ID-UNICO | text |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB019_CAD_AVARIA_ASSOCIADA
> Key: `bd_valorporproduto` | Fields: 5 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_PRODUTO] | text |  |
| 2 | 003_VALOR] | number |  |
| 3 | 001_AVARIA] | relation -> DB018_CAD_AVARIA |  |
| 4 | 004_ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB020_CAD_FORNECEDOR
> Key: `fornecedor` | Fields: 23 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 011_Endereço_UF] | text |  |
| 2 | 007_Endereço_CEP] | text |  |
| 3 | 012_Nome / Nome fantasia] | text |  |
| 4 | 021_Tipo_fornecedor] | text |  |
| 5 | 006_Endereço_Bairro] | text |  |
| 6 | 005_E-mail] | text |  |
| 7 | 009_Endereço_Endereço] | text |  |
| 8 | 002_CPF / CNPJ] | text |  |
| 9 | 003_Cód. Interno] | text |  |
| 10 | 015_PJ_Insc_estadual] | text |  |
| 11 | 016_PJ_Insc_municipal] | text |  |
| 12 | 008_Endereço_cidade] | text |  |
| 13 | 010_Endereço_número] | text |  |
| 14 | 014_PIX] | text |  |
| 15 | 017_PJ_Razão social] | text |  |
| 16 | 013_Nota_fornecedor] | number |  |
| 17 | 018_PJ_Tipo_contribuinte] | text |  |
| 18 | 019_Telefone principal] | text |  |
| 19 | 001_ATIVO] | boolean | `true` |
| 20 | 020_Telefone secundário] | text |  |
| 21 | 022_ID-UNICO | text |  |
| 22 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 23 | 004_Tipo_Prod_vendido] | list<relation -> DB061_PROD_MARCA> |  |

---

## DB021_DOC_ASSIN
> Key: `_doc__assin` | Fields: 18 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_CPF | text |  |
| 2 | 004_HASH SHA256 | text |  |
| 3 | 003_EMAIL | text |  |
| 4 | 016_ESTADO | text |  |
| 5 | 009_CELULAR | text |  |
| 6 | 017_PAÍS-IP | text |  |
| 7 | 010_IP-ADRESS | text |  |
| 8 | 015_CIDADE-IP | text |  |
| 9 | 008_CAMINHO-URL | text |  |
| 10 | 011_DETALHES-IP | text |  |
| 11 | 002_NOME-COMPLETO | text |  |
| 12 | 012_DETALHES-DISP | text |  |
| 13 | 013_IDENTIFICADOR | text |  |
| 14 | 014_ABRIU-PRIM-VEZ | date |  |
| 15 | 006_DATA-ASSINATURA | date |  |
| 16 | 007_TOKEN | text |  |
| 17 | 005_IMAGEM-ASSINATURA | text |  |
| 18 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB022_EMP_EMPREST_DOIS
> Key: `z_lanc_emp` | Fields: 12 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_EMP_CodInterno] | text |  |
| 2 | 004_EMP_Cor] | text |  |
| 3 | 006_EMP_IMEI] | text |  |
| 4 | 008_EMP_Produto] | text |  |
| 5 | 002_EMP_Bateria] | number |  |
| 6 | 007_EMP_PossuiIMEI] | text |  |
| 7 | 010_TipoLancamento] | text |  |
| 8 | 005_EMP_Devolvido] | boolean | `false` |
| 9 | 009_EMP_ValorProduto] | number |  |
| 10 | 011_ID-UNICO | text |  |
| 11 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 12 | 001_Cod. Lancamento | relation -> DB023_EMP_EMPREST_UM |  |

---

## DB023_EMP_EMPREST_UM
> Key: `z_lancamentosemprestimo` | Fields: 16 | Relations: 4

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_CPF | text |  |
| 2 | 005_IMEI | text |  |
| 3 | 002_Cliente | text |  |
| 4 | 006_NumSerie | text |  |
| 5 | 012_EMP_Motivo | text |  |
| 6 | 003_CodInterno | text |  |
| 7 | 001_LancAtivo | boolean | `false` |
| 8 | 007_EMP_Atendente | relation -> User |  |
| 9 | 013_EMP_Observacoes | text |  |
| 10 | 011_EMP_Devolvido | boolean |  |
| 11 | 009_EMP_Cod_Lancamento | text |  |
| 12 | 010_EMP_DataEmprestimo | date |  |
| 13 | 015_ID-UNICO | text |  |
| 14 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 15 | 008_EMP_Cliente | relation -> DB016_CLI_CLIENTE |  |
| 16 | 014_EMP_Produtos | list<relation -> DB031_LAN_ESTOQUE> |  |

---

## DB024_FIN_ABRE_FECHA
> Key: `bd_abrefechacaixa` | Fields: 8 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_FECHADO] | boolean | `false` |
| 2 | 004_DATA_FECHAMENTO] | date |  |
| 3 | 003_DATA_ABERTURA] | date |  |
| 4 | 002_CONTA] | relation -> DB010_CONF_CONTA |  |
| 5 | 007_ID-UNICO | text |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 005_SALDO_ABERTURA] | number |  |
| 8 | 006_SALDO_FECHAMENTO] | number |  |

---

## DB025_FIN_HISTORICO_CAIXA
> Key: `bd_historicocaixas` | Fields: 19 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 008_QuemAbriu] | relation -> User |  |
| 2 | 001_Aberto] | boolean | `false` |
| 3 | 009_QuemFechou] | relation -> User |  |
| 4 | 014_Valor_PIX] | number |  |
| 5 | 016_Valor_TED] | number |  |
| 6 | 015_Valor_Taxas] | number |  |
| 7 | 003_DataFechamento] | date |  |
| 8 | 010_Valor_Boleto] | number |  |
| 9 | 012_Valor_Debito] | number |  |
| 10 | 002_DataAbertura] | date |  |
| 11 | 011_Valor_Credito] | number |  |
| 12 | 013_Valor_Dinheiro] | number |  |
| 13 | 018_ID-UNICO | text |  |
| 14 | 017_ID-ABRE_FECHA] | text |  |
| 15 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 16 | 004_CAIXA-ABERTO] | list<relation -> DB024_FIN_ABRE_FECHA> |  |
| 17 | 006_PRODUTOS_Trocas] | list<relation -> DB031_LAN_ESTOQUE> |  |
| 18 | 007_PRODUTOS_Vendas] | list<relation -> DB031_LAN_ESTOQUE> |  |
| 19 | 005_PRODUTOS_Compras] | list<relation -> DB031_LAN_ESTOQUE> |  |

---

## DB026_FIN_SUBCATEGORIA_DRE
> Key: `_fin__categoria` | Fields: 6 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_USO | text |  |
| 2 | 001_ATIVO | boolean |  |
| 3 | 004_EDITAVEL | boolean | `true` |
| 4 | 002_DESCRICAO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 005_CATEGORIA | option([OS] CATEGORIAS-DRE) |  |

---

## DB027_FIS_ESTOQUE_FISCAL
> Key: `_fiscal__estoque_fiscal` | Fields: 29 | Relations: 6

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 026_SEQUENCIA | number |  |
| 2 | 027_TXT_TIPO_PRODUTO | text |  |
| 3 | 001_ATIVO | boolean | `false` |
| 4 | 012_PROD_COR | text |  |
| 5 | 016_PROD_NCM | text |  |
| 6 | 006_FIS_CATEG | text |  |
| 7 | 015_PROD_IMEI | text |  |
| 8 | 004_FIS_CODIGO | text |  |
| 9 | 021_PROD_QTD | number |  |
| 10 | 003_LAN_COD_UNICO | text |  |
| 11 | 022_PROD_STATUS | text |  |
| 12 | 008_FIS_SUBCATEG | text |  |
| 13 | 028_ID-UNICO | text |  |
| 14 | 017_PROD_NUMSERIE | text |  |
| 15 | 010_PROD_BATERIA | number |  |
| 16 | 014_PROD_DESCONTO | number |  |
| 17 | 002_FIS_VALOR_TOTAL | number |  |
| 18 | 005_DATA_MOVIMENTACAO | date |  |
| 19 | 009_FIS_TIPOLANCAMENTO | text |  |
| 20 | 023_PROD_VALORENTRADA | number |  |
| 21 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 22 | 013_PROD_CUSTOUNITARIO | number |  |
| 23 | 019_PROD_ORIGEM_CLIOUTRO | text |  |
| 24 | 024_PRODUTO | relation -> DB062_PROD_PRODUTO |  |
| 25 | 011_PROD_CATEGORIA | relation -> DB057_PROD_CATEGORIA |  |
| 26 | 025_TIPO_PRODUTO | option([OS] TIPO_PRODUTO) |  |
| 27 | 007_FIS_CODIGO | relation -> DB035_LAN_NOTAS FISCAIS_ATE |  |
| 28 | 018_PROD_ORIGEM | relation -> DB031_LAN_ESTOQUE |  |
| 29 | 020_PROD_ORIGEM_FORNECEDOR | relation -> DB020_CAD_FORNECEDOR |  |

---

## DB028_FIS_NCM_CEST
> Key: `_os__ncm` | Fields: 9 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_NCM | text |  |
| 2 | 002_CATEGORIA | text |  |
| 3 | 005_CEST | text |  |
| 4 | 003_SUBCATEGORIA | text |  |
| 5 | 006_PRIORIDADE | number |  |
| 6 | 008_ID-UNICO | text |  |
| 7 | 007_TXT_TIPO_PRODUTO | text |  |
| 8 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 9 | 001_TIPO_PRODUTO | option([OS] TIPO_PRODUTO) |  |

---

## DB029_LAN_ATENDIMENTO
> Key: `z_lancamentos` | Fields: 87 | Relations: 23

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 062_STATUS | text |  |
| 2 | 033_CLI-CPF | text |  |
| 3 | 082_CRIADO_POR | relation -> User |  |
| 4 | 004_TIPO_FISCAL | text |  |
| 5 | 023_UUID | text |  |
| 6 | 067_VALOR_FRETE | number |  |
| 7 | 034_CLI-NOME | text |  |
| 8 | 001_CONCRETIZADO | boolean | `false` |
| 9 | 019_Chave | text |  |
| 10 | 040_COMO-CONHECEU | text |  |
| 11 | 073_Estilo_Saida | text |  |
| 12 | 008_TOTAL_BRUTO | number |  |
| 13 | 005_VENDEDOR | relation -> User |  |
| 14 | 041_DATA_VENDA | date |  |
| 15 | 002_ATENDENTE | relation -> User |  |
| 16 | 022_URL_XML | text |  |
| 17 | 043_END_CEP | text |  |
| 18 | 056_OBS_NA-NOTA | text |  |
| 19 | 035_COD_ATENDIMENTO | text |  |
| 20 | 060_PAGTO_PIX | number |  |
| 21 | 009_TOTAL_TAXAS | number |  |
| 22 | 015_LINK-DOC-ASSINADO | text |  |
| 23 | 047_END_IBGE | text |  |
| 24 | 055_OBS_INTERNO | text |  |
| 25 | 074_MenuEntradaInfo | text |  |
| 26 | 064_TOTAL_LIQUIDO | number |  |
| 27 | 052_LUCRO_BRUTO | number |  |
| 28 | 006_TIPO-VENDA | text |  |
| 29 | 016_ENVIOU-DOC | date |  |
| 30 | 024_CIDADE-TXT | text |  |
| 31 | 025_ESTADO-TXT | text |  |
| 32 | 042_END_BAIRRO | text |  |
| 33 | 044_END_CIDADE | text |  |
| 34 | 048_END_NUMERO | text |  |
| 35 | 061_PAGTO_TED | number |  |
| 36 | 007_TOTAL_CUSTO_V+B | number |  |
| 37 | 011_ASS-CAMINHO-URL | text |  |
| 38 | 072_DEVOLVIDO-VENDA | boolean |  |
| 39 | 050_LANCA-ATIVO | boolean | `false` |
| 40 | 076_TXT_ESTADOS | text |  |
| 41 | 010_DOC-FILE-URL | text |  |
| 42 | 045_END_ENDERECO | text |  |
| 43 | 077_TXT_INTENCAO | text |  |
| 44 | 078_ID-UNICO | text |  |
| 45 | 018_FOLDER-STRUCT | text |  |
| 46 | 028_CANCELADO POR | relation -> User |  |
| 47 | 003_DOC_FISCAL | boolean | `false` |
| 48 | 083_TipoInteracao | text |  |
| 49 | 036_BRI_CUSTO-TOTAL | number |  |
| 50 | 065_TRO_CUSTO-TOTAL | number |  |
| 51 | 068_VEN_CUSTO-TOTAL | number |  |
| 52 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 53 | 057_PAGTO_CARTAO | number |  |
| 54 | 020_URL_DANFE_FULL | text |  |
| 55 | 054_NF-COD_INTERNO | text |  |
| 56 | 014_ASS-ASSINADO | boolean | `false` |
| 57 | 027_POSSUI-ANEXO | boolean |  |
| 58 | 058_PAGTO_DESC-TOTAL | number |  |
| 59 | 059_PAGTO_DINHEIRO | number |  |
| 60 | 085_COD_GARANTIA TXT | text |  |
| 61 | 070_DESC ADICIONAL | number |  |
| 62 | 039_CLI_INTENCAO | option([OS] INTENCAO) |  |
| 63 | 063_TOTAL_CUSTO_V+B+TAXAS | number |  |
| 64 | 021_URL_DANFE_SIMPLES | text |  |
| 65 | 029_DATA_CANCELAMENTO | date |  |
| 66 | 071_DESCONTO-PRODUTO | number |  |
| 67 | 053_LUCRO_OPERACIONAL | number |  |
| 68 | 030_MOTIVO_CANCELAMENTO | text |  |
| 69 | 031_AlteraTaxaAutorizado | relation -> User |  |
| 70 | 075_son | relation -> SAT |  |
| 71 | 086_desc_acres-aprovado-por | relation -> User |  |
| 72 | 080_z_CAP_Custos | relation -> DB999_VERIF_CONTAS_PAGAR |  |
| 73 | 017_DOC-CRIADO | relation -> DB021_DOC_ASSIN |  |
| 74 | 013_NF-Codigo-SAI | relation -> DB056_LAN_NF |  |
| 75 | 046_END_ESTADO | option([OS] ESTADOS) |  |
| 76 | 038_CLI-INFORMACOES | relation -> DB016_CLI_CLIENTE |  |
| 77 | 051_LANCA-ESTOQUE | relation -> DB031_LAN_ESTOQUE |  |
| 78 | 084_COD_GARANTIA | relation -> DB032_LAN_GARANTIA |  |
| 79 | 012_NF-Codigo-ENT | relation -> DB056_LAN_NF |  |
| 80 | 026_ATE-REFERENCIA | relation -> DB029_LAN_ATENDIMENTO |  |
| 81 | 066_TRO_PRODUTOS | list<relation -> DB031_LAN_ESTOQUE> |  |
| 82 | 081_z_CAR_Pagamento | list<relation -> DB999_VERIF_CONTAS_RECEB> |  |
| 83 | 069_VEN_PRODUTOS | list<relation -> DB031_LAN_ESTOQUE> |  |
| 84 | 049_FISCAL_PAGAMENTO | list<relation -> DB037_LAN_PAGTO_FISCAL> |  |
| 85 | 037_BRI_PRODUTOS | list<relation -> DB031_LAN_ESTOQUE> |  |
| 86 | 079_z_CAP_CAR_Pagamento | list<relation -> DB030_LAN_CAP-CAR> |  |
| 87 | 032_Termos-selecionados | list<relation -> DB007_CONF_TERMO_GARANTIA> |  |

---

## DB030_LAN_CAP-CAR
> Key: `z_lancamentos_cap_car` | Fields: 69 | Relations: 17

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_ATE_Cod__01 | text |  |
| 2 | 050_Subtipo__26 | text |  |
| 3 | 001_Ativo__13 | boolean | `false` |
| 4 | 033_TXT_FIN_CATEGORIAS | text |  |
| 5 | 061_DRE_Uso | text |  |
| 6 | 018_CAP_Quitado__05 | text |  |
| 7 | 036_TXT_RECORRENCIA | text |  |
| 8 | 044_Desconto__20 | number |  |
| 9 | 003_COM_COD__85 | text |  |
| 10 | 025_ID-TRANSACAO | text |  |
| 11 | 034_TXT_FORMA_PAGTO | text |  |
| 12 | 020_Cod_Interno_Lançamento__15 | text |  |
| 13 | 049_Situação__25 | boolean |  |
| 14 | 017_CAP_Ocorrencia__04 | text |  |
| 15 | 031_TipoLancamento__12 | text |  |
| 16 | 043_DataVencimento__17 | date |  |
| 17 | 042_DataTransacao__19 | date |  |
| 18 | 047_Parcelas_CAP__23 | number |  |
| 19 | 063_CreationDate__33 | date |  |
| 20 | 028_MOSTRA-TABELA | boolean |  |
| 21 | 041_DataRecebimento__18 | date |  |
| 22 | 023_Data_movimentacao | date |  |
| 23 | 062_BotaoSemJuros__32 | boolean |  |
| 24 | 064_UsuarioCriador__34 | relation -> User |  |
| 25 | 004_Descricao_ou_nome__02 | text |  |
| 26 | 027_Lancador/atendente__11 | relation -> User |  |
| 27 | 040_DataPagamento__40 | date |  |
| 28 | 056_ValorPorParcela__31 | number |  |
| 29 | 016_CAP_InforAdicionais | text |  |
| 30 | 026_Intencao__10 | option([OS] INTENCAO) |  |
| 31 | 035_TXT_INTENCAO | text |  |
| 32 | 068_ID-UNICO | text |  |
| 33 | 051_TaxasLojista_CAR__27 | number |  |
| 34 | 052_Valor_Original35 | number |  |
| 35 | 022_COM_Cod__08 | relation -> DB017_COM_COMPRA |  |
| 36 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 37 | 032_TXT_BANDEIRAS | text |  |
| 38 | 058_DRE_Categoria_TXT | text |  |
| 39 | 065_Autorizado Por | relation -> User |  |
| 40 | 007_TRANSF CONTA | boolean | `false` |
| 41 | 009_LANCA-FISCAL | boolean |  |
| 42 | 012_Fluxo_Valor__37 | number |  |
| 43 | 014_CAP_CAR_COD__07 | text |  |
| 44 | 021_COD_OS | relation -> DB082_TREL_TAREFA_MANUT |  |
| 45 | 038_Bandeira__14 | option([OS] BANDEIRAS) |  |
| 46 | 046_Maquina__22 | relation -> DB012_CONF_MAQUINA |  |
| 47 | 048_Parcelas_CAR__24 | relation -> DB013_CONF_TAXAS |  |
| 48 | 055_ValorLiquidoReceber__30 | number |  |
| 49 | 067_Valor Serviço | number |  |
| 50 | 013_ATE_Cod__03 | relation -> DB029_LAN_ATENDIMENTO |  |
| 51 | 024_DiasCompensarNegativo | number |  |
| 52 | 060_DRE_Subcategoria_TXT | text |  |
| 53 | 053_ValorBruto(ComAcresc)__28 | number |  |
| 54 | 054_ValorBruto(SemAcresc)__29 | number |  |
| 55 | 037_DiasParaCompensar__35 | number |  |
| 56 | 011_Fluxo_TipoDeLancamento__36 | text |  |
| 57 | 005_NF-COD | relation -> DB056_LAN_NF |  |
| 58 | 045_forma__21 | option([OS] FORMA_PAGTO) |  |
| 59 | 006_desc_acres-aprovado-por | relation -> User |  |
| 60 | 010_Fluxo_DataUnificada__38 | date |  |
| 61 | 039_conta-Referencia__16 | relation -> DB010_CONF_CONTA |  |
| 62 | 019_CAP_Recorrencia__06 | option([OS] RECORRENCIA) |  |
| 63 | 008_CHAVE-PIX | relation -> DB008_CONF_CHAVE PIX |  |
| 64 | 015_CAP_CategGasto | option([OS] FIN_CATEGORIAS) |  |
| 65 | 066_Serviço Executado | relation -> DB062_PROD_PRODUTO |  |
| 66 | 059_DRE_Subcategoria | relation -> DB026_FIN_SUBCATEGORIA_DRE |  |
| 67 | 030_Taxa vinculada | relation -> DB030_LAN_CAP-CAR |  |
| 68 | 057_DRE_Categoria | option([OS] CATEGORIAS-DRE) |  |
| 69 | 029_REF_CAR_Parcial | relation -> DB030_LAN_CAP-CAR |  |

---

## DB031_LAN_ESTOQUE
> Key: `z_lancamentosestoque` | Fields: 96 | Relations: 26

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 082_Status | text |  |
| 2 | 002_COD_OS | text |  |
| 3 | 069_EST_SKU | text |  |
| 4 | 001_ATE_Cod | text |  |
| 5 | 054_EST_IMEI | text |  |
| 6 | 058_EST_Nome | text |  |
| 7 | 088_Vendedor | relation -> User |  |
| 8 | 087_Atendente | relation -> User |  |
| 9 | 035_Data_Movimentacao | date |  |
| 10 | 063_EST_Origem | text |  |
| 11 | 003_NomeCliente | text |  |
| 12 | 030_Cancelado | boolean | `false` |
| 13 | 066_EST_Qtd | number |  |
| 14 | 062_EST_NumSerie | text |  |
| 15 | 090_TXT_MEMORIA | text |  |
| 16 | 093_Informacao_Temp | boolean | `true` |
| 17 | 022_NF_COR | text |  |
| 18 | 025_NF_NCM | text |  |
| 19 | 041_EST_Bateria | number |  |
| 20 | 045_EST_Cor | relation -> DB058_PROD_COR |  |
| 21 | 016_SEQ-XML | text |  |
| 22 | 021_NF_CEST | text |  |
| 23 | 029_BRI_Desconto | number |  |
| 24 | 044_EST_CodInterno | text |  |
| 25 | 046_EST_CustoPropostaAtualizado | number |  |
| 26 | 018_COM-COD | text |  |
| 27 | 020_NF_CATEG | text |  |
| 28 | 079_MenuEntradaInfo | text |  |
| 29 | 083_TRANFERENCIA | boolean | `false` |
| 30 | 031_COD_INTERNO_LOJA | text |  |
| 31 | 034_COM_CustoTotal | number |  |
| 32 | 064_EST_PrecoVenda | number |  |
| 33 | 068_EST_ReservadoPor | relation -> User |  |
| 34 | 072_EST_VendaTotal | number |  |
| 35 | 056_EST_Marca | relation -> DB061_PROD_MARCA |  |
| 36 | 067_EST_QtdNegativa | number |  |
| 37 | 084_Percentual | number |  |
| 38 | 095_Garantia | boolean |  |
| 39 | 026_NF_SUBCATEG | text |  |
| 40 | 043_EST_Cod_lancamento | text |  |
| 41 | 005_EST_DescontoTotalDado | number |  |
| 42 | 052_EST_Grupo | relation -> DB059_PROD_GRUPO |  |
| 43 | 061_EST_NomeProdConcat | text |  |
| 44 | 071_EST_TipoLancamento | text |  |
| 45 | 089_TXT_ESTOQUES | text |  |
| 46 | 037_EST_AcrescimoDado | number |  |
| 47 | 048_EST_EntradaAtiva | boolean | `false` |
| 48 | 053_EST_Identificado | boolean |  |
| 49 | Fotos-Produto | list<image> |  |
| 50 | 073_Intencao | option([OS] INTENCAO) |  |
| 51 | 092_ID-UNICO | text |  |
| 52 | 012_ENT_FISCAL | boolean | `false` |
| 53 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 54 | 042_EST_Categoria | relation -> DB057_PROD_CATEGORIA |  |
| 55 | 055_EST_Lucro_unitario | number |  |
| 56 | 013_SAI_FISCAL | boolean | `false` |
| 57 | 050_EST_Estoque | option([OS] ESTOQUES) |  |
| 58 | 057_EST_Memoria | option([OS] MEMORIA) |  |
| 59 | 094_ASSIS_CLIENTE | boolean |  |
| 60 | 007_Info_Inutilizacao | text |  |
| 61 | 019_NF_ID_PROD_UNIF | text |  |
| 62 | 023_NF_CUSTO_UNIT | number |  |
| 63 | 032_COD_OS | relation -> DB082_TREL_TAREFA_MANUT |  |
| 64 | 059_EST_NomeOrigemCliOutro | text |  |
| 65 | 081_Proporcao-desc-extra | number |  |
| 66 | 065_EST_Produto | relation -> DB062_PROD_PRODUTO |  |
| 67 | 091_TXT_TIPO_PRODUTO | text |  |
| 68 | 014_NF_ProdCustoTotal | number |  |
| 69 | 038_EST_Avarias | list<relation -> DB018_CAD_AVARIA> |  |
| 70 | 039_EST_AvariasDescontoTotal | number |  |
| 71 | 047_EST_CustoPropostaInicial | number |  |
| 72 | 051_EST_EstoqueLO | relation -> DB060_PROD_LOCAL |  |
| 73 | 096_Origem Transferencia | text |  |
| 74 | 011_Checklist-realizado | boolean | `false` |
| 75 | 078_LEST_Observacoes_adicionais | text |  |
| 76 | 004_EST_DescontoNoProduto | number |  |
| 77 | 006_desc_acres-aprovado-por | relation -> User |  |
| 78 | 009_Checklist-aprovado | list<text> |  |
| 79 | 017_NF-COD | relation -> DB056_LAN_NF |  |
| 80 | 010_Checklist-NaoAprovado | list<text> |  |
| 81 | 033_COM_Cod_Lancamento | relation -> DB017_COM_COMPRA |  |
| 82 | 049_EST_Especificacao | option([OS] ESPECIFICACOES) |  |
| 83 | 070_EST_TipoDeProdutoOS | option([OS] TIPO_PRODUTO) |  |
| 84 | 028_ATE_Cod_Lancamento | relation -> DB029_LAN_ATENDIMENTO |  |
| 85 | 080_ORIGEM_CLIENTE | relation -> DB016_CLI_CLIENTE |  |
| 86 | 040_EST_AvariasNome | list<relation -> DB019_CAD_AVARIA_ASSOCIADA> |  |
| 87 | 060_EST_NomeOrigemFornecedor | relation -> DB020_CAD_FORNECEDOR |  |
| 88 | 086_XML-ID-UNICO | api(apiconnector2.bUgTG.bXEse) |  |
| 89 | 036_EMP_CodLanca | relation -> DB023_EMP_EMPREST_UM |  |
| 90 | 015_Regra Fiscal | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 91 | 024_NF_EMISSOR | relation -> DB073_RF_INFO_FISCAL |  |
| 92 | 097_Transferencia | relation -> DB042_LAN_TRANSFERENCIAS |  |
| 93 | 027_INFO_FISCAL | relation -> DB027_FIS_ESTOQUE_FISCAL |  |
| 94 | 074_EstoqueReferenciado | relation -> DB031_LAN_ESTOQUE |  |
| 95 | 008_Checklist | relation -> DB123_CHECK_LIST_AVALIACAO |  |
| 96 | 085_XML-ID | api(apiconnector2.bUgTG.bUgTH.nfeProc.NFe.infNFe.det) |  |

---

## DB032_LAN_GARANTIA
> Key: `_lan__garantia` | Fields: 43 | Relations: 16

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Ativo | boolean |  |
| 2 | 003_Status | text |  |
| 3 | 030_Origem | text |  |
| 4 | 006_CPF/CNPJ | text |  |
| 5 | 007_Atendente | relation -> User |  |
| 6 | 008_Responsável | relation -> User |  |
| 7 | 005_Nome Cliente | text |  |
| 8 | 002_Cod Garantia | text |  |
| 9 | 009_Data Garantia | date |  |
| 10 | 010_Tipo Garantia | text |  |
| 11 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 12 | 042_OS Garantia TXT | text |  |
| 13 | 016_Cliente antigo | boolean |  |
| 14 | 029_Produto Problema TXT | text |  |
| 15 | 013_Atendimento Origem TXT | text |  |
| 16 | 017_Avarias | list<relation -> DB018_CAD_AVARIA> |  |
| 17 | 033_Custo Produto Vendido | number |  |
| 18 | 035_Preco Produto Vendido | number |  |
| 19 | 040_Atendimento Garantia TXT | text |  |
| 20 | 018_Custo Produto Problema | number |  |
| 21 | 021_Preco Produto Problema | number |  |
| 22 | 015_Ordem de serviço Origem TXT | text |  |
| 23 | 041_OS Garantia | relation -> DB082_TREL_TAREFA_MANUT |  |
| 24 | 023_Produto Ordem de serviço Problema TXT | text |  |
| 25 | 028_Produto Problema Original TXT | text |  |
| 26 | 031_Custo Produto Inicial Vendido | number |  |
| 27 | 004_Dados Cliente | relation -> DB016_CLI_CLIENTE |  |
| 28 | 012_Atendimento Origem | relation -> DB029_LAN_ATENDIMENTO |  |
| 29 | 039_Atendimento Garantia | relation -> DB029_LAN_ATENDIMENTO |  |
| 30 | 034_Custo Produto Vendido (Lista) | list<number> |  |
| 31 | 036_Preco Produto Vendido (Lista) | list<number> |  |
| 32 | 011_Tipo Garantia OS | option([OS] INT_GAR_MANUT) |  |
| 33 | 019_Custo Produto Problema (Lista) | list<number> |  |
| 34 | 020_Preco Preoduto Problema (Lista) | list<number> |  |
| 35 | 037_Produto Vendido | relation -> DB031_LAN_ESTOQUE |  |
| 36 | 014_Ordem de serviço Origem | relation -> DB082_TREL_TAREFA_MANUT |  |
| 37 | 024_Produto Problema | relation -> DB031_LAN_ESTOQUE |  |
| 38 | 025_Produto Problema (Lista) | list<relation -> DB031_LAN_ESTOQUE> |  |
| 39 | 032_Custo Produto Inicial Vendido (Lista) | list<number> |  |
| 40 | 022_Produto Ordem de serviço Problema | relation -> DB062_PROD_PRODUTO |  |
| 41 | 026_Produto Problema Original | relation -> DB031_LAN_ESTOQUE |  |
| 42 | 038_Produto Vendido (Lista) | list<relation -> DB031_LAN_ESTOQUE> |  |
| 43 | 027_Produto Problema Original (Lista) | list<relation -> DB031_LAN_ESTOQUE> |  |

---

## DB033_LAN_INICIANTE_ATE
> Key: `z_lancamentosatendimento2` | Fields: 19 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 011_CPFCliente | text |  |
| 2 | 012_Criado_por | relation -> User |  |
| 3 | 004_ATE_Frete | number |  |
| 4 | 015_NomeCliente | text |  |
| 5 | 010_Concretizada | boolean | `false` |
| 6 | 016_TOTAL_BRUTO | number |  |
| 7 | 001_ATE_Vendedor | relation -> User |  |
| 8 | 003_ATE_DataVenda | date |  |
| 9 | 006_ATE_OBS_NaNota | text |  |
| 10 | 002_ATE_Cod_lancamento | text |  |
| 11 | 014_LancamentoAtivo | boolean |  |
| 12 | 017_TXT_INTENCAO | text |  |
| 13 | 018_ID-UNICO | text |  |
| 14 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 15 | 005_ATE_Intencao | option([OS] INTENCAO) |  |
| 16 | 013_LancaEstoque | relation -> DB031_LAN_ESTOQUE |  |
| 17 | 007_ATE_Pagamento | list<relation -> DB034_LAN_INICIANTE_ESTOQ> |  |
| 18 | 008_ATE_TRO_Produtos | list<relation -> DB034_LAN_INICIANTE_ESTOQ> |  |
| 19 | 009_ATE_VEN_Produtos | list<relation -> DB034_LAN_INICIANTE_ESTOQ> |  |

---

## DB034_LAN_INICIANTE_ESTOQ
> Key: `z_lancamentosestoque1` | Fields: 27 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_INI_EST_CPF | text |  |
| 2 | 022_Status | text |  |
| 3 | 008_INI_EST_IMEI | text |  |
| 4 | 023_Vendedor | relation -> User |  |
| 5 | 010_INI_EST_NomeCliente | text |  |
| 6 | 011_INI_EST_NumSerie | text |  |
| 7 | 026_Informacao_Temp | boolean |  |
| 8 | 004_INI_EST_Cor | text |  |
| 9 | 002_INI_EST_Bateria | number |  |
| 10 | 007_INI_EST_Forma | text |  |
| 11 | 019_COD_INTERNO_LOJA | text |  |
| 12 | 021_EST_VendaTotal | number |  |
| 13 | 017_INI_EST_Valor | number |  |
| 14 | 013_INI_EST_Produto | text |  |
| 15 | 006_INI_EST_DescontoDado | number |  |
| 16 | 015_INI_EST_TipoLancamento | text |  |
| 17 | 024_TXT_MEMORIA | text |  |
| 18 | 003_INI_EST_Categoria | text |  |
| 19 | 012_INI_EST_Parcela | number |  |
| 20 | 020_EST_EntradaAtiva | boolean |  |
| 21 | 025_ID-UNICO | text |  |
| 22 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 23 | 018_INI_EST_VEN_ValorVenda | number |  |
| 24 | 009_INI_EST_Memoria | option([OS] MEMORIA) |  |
| 25 | 014_INI_EST_ProdutoConcatenado | text |  |
| 26 | 016_INI_EST_TRO_ValorProposta | number |  |
| 27 | 001_INI_EST_ATE_Cod_Lancamento | relation -> DB033_LAN_INICIANTE_ATE |  |

---

## DB035_LAN_NOTAS FISCAIS_ATE
> Key: `_lan__notas_fiscais` | Fields: 24 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_TIPO | text |  |
| 2 | 007_UUID | text |  |
| 3 | 004_Chave | text |  |
| 4 | 020_ORIGEM | text |  |
| 5 | 005_URL_DANFE_FULL | text |  |
| 6 | 006_URL_DANFE_SIMPLES | text |  |
| 7 | 011_END_CEP | text |  |
| 8 | 001_CONCRETIZADO | boolean | `false` |
| 9 | 015_END_IBGE | text |  |
| 10 | 010_END_BAIRRO | text |  |
| 11 | 012_END_CIDADE | text |  |
| 12 | 016_END_NUMERO | text |  |
| 13 | 009_DATA_VENDA | date |  |
| 14 | 022_TXT_ESTADOS | text |  |
| 15 | 013_END_ENDERECO | text |  |
| 16 | 023_ID-UNICO | text |  |
| 17 | 002_NF-COD_INTERNO | text |  |
| 18 | 018_FORA_ESTADO | boolean |  |
| 19 | 019_OBS_NA-NOTA | text |  |
| 20 | 008_CLI-NOME | text |  |
| 21 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 22 | 014_END_ESTADO | option([OS] ESTADOS) |  |
| 23 | 017_FISCAL_PAGAMENTO | list<relation -> DB037_LAN_PAGTO_FISCAL> |  |
| 24 | 021_VEN_PRODUTOS | list<relation -> DB027_FIS_ESTOQUE_FISCAL> |  |

---

## DB036_LAN_PAGTO_COMPRAS
> Key: `z_lancamentoscompras` | Fields: 12 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_COM_PAGTO_Data | date |  |
| 2 | 007_COM_PAGTO_Quitado | text |  |
| 3 | 011_ID-UNICO | text |  |
| 4 | 005_COM_PAGTO_Ocorrencia | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 006_COM_PAGTO_QtdParcela | number |  |
| 7 | 010_TXT_FORMA_PAGTO | text |  |
| 8 | 008_COM_PAGTO_Recorrencia | number |  |
| 9 | 001_COM_Cod_Nota | relation -> DB017_COM_COMPRA |  |
| 10 | 002_COM_PAGTO_Caixa | relation -> DB010_CONF_CONTA |  |
| 11 | 009_COM_PAGTO_ValorPorParcela | number |  |
| 12 | 004_COM_PAGTO_Forma | option([OS] FORMA_PAGTO) |  |

---

## DB037_LAN_PAGTO_FISCAL
> Key: `_lan__cap_car` | Fields: 17 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_ATE_Cod__01 | text |  |
| 2 | 001_Ativo__13 | boolean | `false` |
| 3 | 013_Desconto__20 | number |  |
| 4 | 006_Cod_Interno_Lançamento__15 | text |  |
| 5 | 008_TipoLancamento__12 | text |  |
| 6 | 012_DataTransacao__19 | date |  |
| 7 | 011_DataRecebimento__18 | date |  |
| 8 | 003_Descricao_ou_nome__02 | text |  |
| 9 | 007_Lancador/atendente__11 | relation -> User |  |
| 10 | 010_DataPagamento__40 | date |  |
| 11 | 005_CAP_InforAdicionais | text |  |
| 12 | 016_ID-UNICO | text |  |
| 13 | 015_VALOR_PAGTO | number |  |
| 14 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 15 | 009_TXT_PAGTO-FISCAL | text |  |
| 16 | 004_ATE_Cod__03 | relation -> DB029_LAN_ATENDIMENTO |  |
| 17 | 014_forma__21 | option([OS] PAGTO-FISCAL) |  |

---

## DB038_LAN_PRE_VENDA
> Key: `_lan__pre_venda` | Fields: 42 | Relations: 16

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 010_STATUS | text | `Rascunho` |
| 2 | 035_Wasabi | text |  |
| 3 | 021_QR-Code | text |  |
| 4 | 022_Frete | number |  |
| 5 | 037_Ordem | number |  |
| 6 | 012_Vendedor | relation -> User |  |
| 7 | 001_Ativo | boolean | `false` |
| 8 | 033_URL Nota | text |  |
| 9 | 004_CriadoPor | relation -> User |  |
| 10 | 013_Atendente | relation -> User |  |
| 11 | 039_Cancelado Por | relation -> User |  |
| 12 | 008_NOME-CLIENTE | text |  |
| 13 | 003_Pre-COD-Lanca | text |  |
| 14 | 005_DATA_PREVENDA | date |  |
| 15 | 023_Saldo devedor | number |  |
| 16 | 026_Tipo de pagamento | text |  |
| 17 | 040_Data cancelamento | date |  |
| 18 | 007_CPF/CNPJ-CLIENTE | text |  |
| 19 | 031_Possui anexos | boolean |  |
| 20 | 011_VALOR-PRE-VENDA | number |  |
| 21 | 020_Link Visualizacao | text |  |
| 22 | 041_Motivo cancelamento | text |  |
| 23 | 027_Status Produtos | boolean |  |
| 24 | 009_INTENCAO | option([OS] INTENCAO) |  |
| 25 | 025_Status Pagamento | boolean |  |
| 26 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 27 | 028_Observacoes Externas | text |  |
| 28 | 029_Observacoes Internas | text |  |
| 29 | 034_Link para assinatura | text |  |
| 30 | 032_Documento Assinado | boolean |  |
| 31 | 036_Data envio assinatura | date |  |
| 32 | 002_ATECOD | relation -> DB029_LAN_ATENDIMENTO |  |
| 33 | 006_CLI-INFORMACOES | relation -> DB016_CLI_CLIENTE |  |
| 34 | 030_Termo de garantia | relation -> DB007_CONF_TERMO_GARANTIA |  |
| 35 | 014_Lista Produtos Troca | list<relation -> DB031_LAN_ESTOQUE> |  |
| 36 | 018_Lista Produtos Brinde | list<relation -> DB031_LAN_ESTOQUE> |  |
| 37 | 016_Lista Produtos Venda | list<relation -> DB031_LAN_ESTOQUE> |  |
| 38 | 015_Lista Produtos Troca Inicial | list<relation -> DB039_LAN_PROD_PRE> |  |
| 39 | 017_Lista Produtos Venda Inicial | list<relation -> DB039_LAN_PROD_PRE> |  |
| 40 | 024_Pagamentos realizados | list<relation -> DB030_LAN_CAP-CAR> |  |
| 41 | 019_Lista Produtos Brinde Inicial | list<relation -> DB039_LAN_PROD_PRE> |  |
| 42 | 038_Lista Atualizacoes | list<relation -> DB103_LAN_ATUALIZACOES_PREVENDA> |  |

---

## DB039_LAN_PROD_PRE
> Key: `_lan__prod_pre` | Fields: 9 | Relations: 4

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_QTD | number |  |
| 2 | 006_COR | relation -> DB058_PROD_COR |  |
| 3 | 004_TIPO-LANCA | text |  |
| 4 | 007_DESCONTO | number |  |
| 5 | 008_ACRESCIMO | number |  |
| 6 | 002_PRODUTO | relation -> DB062_PROD_PRODUTO |  |
| 7 | 003_PRECO-AVALIACAO | number |  |
| 8 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 9 | 001_COD-PRE-VENDA | relation -> DB038_LAN_PRE_VENDA |  |

---

## DB040_LAN_SIMULACOES
> Key: `z_lancamentosatendimento` | Fields: 13 | Relations: 6

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 010_SIM_Nome | text |  |
| 2 | 008_OBS_NaNota | text |  |
| 3 | 007_OBS_Interna | text |  |
| 4 | 009_SIM_Contato | text |  |
| 5 | 011_SimuladoPor | relation -> User |  |
| 6 | 006_Cod_lancamento | text |  |
| 7 | 001_LancamentoAtivo | boolean | `false` |
| 8 | 012_ID-UNICO | text |  |
| 9 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 10 | 005_BD_Venda | list<relation -> DB077_SIM_VENDA> |  |
| 11 | 002_AlteraTaxaAutorizadoPor | relation -> User |  |
| 12 | 004_BD_Troca | list<relation -> DB076_SIM_TROCA> |  |
| 13 | 003_BD_Pagamentos | list<relation -> DB075_SIM_PAGAMENTO> |  |

---

## DB041_LAN_SUPORTE
> Key: `_lan__suporte` | Fields: 16 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_STATUS] | text |  |
| 2 | 007_CONTATO] | text |  |
| 3 | 001_COD-TICKET] | text |  |
| 4 | 008_ABERTO-POR] | relation -> User |  |
| 5 | 011_PRIORIDADE] | text |  |
| 6 | 002_QUAL-MODULO] | text |  |
| 7 | 006_NOME-USUARIO] | text |  |
| 8 | 003_NIVEL-HIERARQ] | text |  |
| 9 | 013_FINALIZADO-POR] | relation -> User |  |
| 10 | 014_DATA-ABERTURA] | date |  |
| 11 | 000_EMPRESA-TICKET] | text |  |
| 12 | 015_DATA-FECHAMENTO] | date |  |
| 13 | 009_TIPO-SOLICITACAO] | text |  |
| 14 | 004_DESCRICAO-TICKET] | text |  |
| 15 | 010_COMENTARIOS-TICKET] | text |  |
| 16 | 012_FINALIZADO-SIM-NAO] | text |  |

---

## DB042_LAN_TRANSFERENCIAS
> Key: `_lan__transferencias` | Fields: 28 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 017_COR | text |  |
| 2 | 014_IMEI | text |  |
| 3 | 005_Código | text |  |
| 4 | 021_Status | text |  |
| 5 | 004_Ativo | boolean |  |
| 6 | 015_NUM-SERIE | text |  |
| 7 | 016_BATERIA | number |  |
| 8 | 020_Data-Atualizacao | date |  |
| 9 | 019_Quantidade | number |  |
| 10 | 023_Data-Entrada | date |  |
| 11 | 022_Reprovado por | text |  |
| 12 | 006_Usuario-origem | text |  |
| 13 | 018_Estoque-Origem | text |  |
| 14 | 010_Custo-Origem | number |  |
| 15 | 007_Usuario-destino | text |  |
| 16 | 024_Origem-Fornecedor | text |  |
| 17 | 001_EmpresaOrigem | relation -> DB002_EMPRESAS |  |
| 18 | 026_Saldo Estoque Inicial Origem | number |  |
| 19 | 028_Saldo Estoque Inicial Destino | number |  |
| 20 | 008_Tipo-Origem | option([OS] TIPO_PRODUTO) |  |
| 21 | 009_Produto-Origem | relation -> DB062_PROD_PRODUTO |  |
| 22 | 013_Produto-Destino | relation -> DB062_PROD_PRODUTO |  |
| 23 | 002_EmpresaDestino | relation -> DB002_EMPRESAS |  |
| 24 | 025_Saldo Estoque Final Origem | number |  |
| 25 | 027_Saldo Estoque Final Destino | number |  |
| 26 | 003_EmpresasView | list<relation -> DB002_EMPRESAS> |  |
| 27 | 011_LAN-Est-Produto-Origem | relation -> DB031_LAN_ESTOQUE |  |
| 28 | 012_LAN-Est-Produto-Destino | relation -> DB031_LAN_ESTOQUE |  |

---

## DB043_LEAD_COMO_CONHECEU
> Key: `_lead__comoconheceu` | Fields: 4 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_ORIGEM | text |  |
| 2 | 001_ATIVO | boolean |  |
| 3 | 003_ID-UNICO | text |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB044_MKT_CUPOM
> Key: `cupom` | Fields: 3 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_CUPOM] | text |  |
| 2 | 001_ATIVO] | boolean |  |
| 3 | 003_ID-UNICO | text |  |

---

## DB045_MKT_LISTA_VIP
> Key: `z_lista_vip` | Fields: 6 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_Nome | text |  |
| 2 | 002_E-mail | text |  |
| 3 | 005_Telefone | text |  |
| 4 | 001_ComoConheceu | text |  |
| 5 | 004_Nome da empresa | text |  |
| 6 | 006_ID-UNICO | text |  |

---

## DB046_MOD_AVARIA
> Key: `x_bd_conf_categorias` | Fields: 2 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Avarias | text |  |
| 2 | 002_ID-UNICO | text |  |

---

## DB047_MOD_CATEGORIA
> Key: `00bd_confiniciais_categorias` | Fields: 2 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Categorias | text |  |
| 2 | 002_ID-UNICO | text |  |

---

## DB048_MOD_CONTA
> Key: `x_bd_conf_taxas_parcelas` | Fields: 3 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_NomeDaConta | text |  |
| 2 | 002_SaldoDaConta | number |  |
| 3 | 003_ID-UNICO | text |  |

---

## DB049_MOD_COR
> Key: `x_bd_conf_categorias1` | Fields: 2 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Cor | text |  |
| 2 | 002_ID-UNICO | text |  |

---

## DB050_MOD_FRASE
> Key: `x_bd_conf_frases` | Fields: 1 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Frase | text |  |

---

## DB051_MOD_GRUPO
> Key: `1bd_confiniciais` | Fields: 1 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Grupos | text |  |

---

## DB052_MOD_MAQUINA
> Key: `x_bd_conf_contas` | Fields: 5 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_NomeDaMaquina | text |  |
| 2 | 003_TempoDeCompensacao | number |  |
| 3 | 005_ID-UNICO | text |  |
| 4 | 004_TXT_FORMA_PAGTO | text | `Cartão` |
| 5 | 001_FormaDePagamento | option([OS] FORMA_PAGTO) | `cr_dito` |

---

## DB053_MOD_MARCA
> Key: `00bd_confiniciais_marcas` | Fields: 2 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Marcas | text |  |
| 2 | 002_ID-UNICO | text |  |

---

## DB054_MOD_PARCELA
> Key: `x_bd_conf_avarias` | Fields: 3 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_Display | text |  |
| 2 | 002_Parcela | number |  |
| 3 | 003_ID-UNICO | text |  |

---

## DB055_MOD_PRODUTO
> Key: `bd_produtosiniciais` | Fields: 7 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_Grupo | text |  |
| 2 | 003_Marca | text |  |
| 3 | 001_Criacao | date |  |
| 4 | 005_Nome do Produto | text |  |
| 5 | 007_ID-UNICO | text |  |
| 6 | 004_Memoria | list<option([OS] MEMORIA)> |  |
| 7 | 006_TXTS_MEMORIA | list<text> |  |

---

## DB056_LAN_NF
> Key: `_fis__entrada` | Fields: 60 | Relations: 14

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 028_CLI-IE | text |  |
| 2 | 049_MODELO | text |  |
| 3 | 027_CLI-CPF-CNPJ | text |  |
| 4 | 035_WBM-XML | text |  |
| 5 | 047_SERIE | number |  |
| 6 | 050_QR-LINK | text |  |
| 7 | 001_ATIVO | boolean | `false` |
| 8 | 029_CLI-NOME | text |  |
| 9 | 034_WBM-UUID | text |  |
| 10 | 042_Vendedor | relation -> User |  |
| 11 | 044_ID-CHAVE | text |  |
| 12 | 046_LINK-XML | text |  |
| 13 | 056_MenuEntradaInfo | text |  |
| 14 | 016_DATA-INFO | date |  |
| 15 | 032_WBM-Chave | text |  |
| 16 | 033_WBM-Danfe | text |  |
| 17 | 041_Atendente | relation -> User |  |
| 18 | 055_STATUS_NF | text |  |
| 19 | 008_NF-SAI-PIX | number |  |
| 20 | 009_NF-SAI-TED | number |  |
| 21 | 011_DEVOLVIDO | boolean |  |
| 22 | 018_CLI-END-BAIRRO | text |  |
| 23 | 043_XML-Subido | text |  |
| 24 | 002_NF-COD | text |  |
| 25 | 015_TIPO-FISCAL | text |  |
| 26 | 017_ENTRADA-POR | relation -> User |  |
| 27 | 019_CLI-END-CEP | text |  |
| 28 | 025_CLI-END-NUM | text |  |
| 29 | 038_OBS-Externa | text |  |
| 30 | 039_OBS-Interna | text |  |
| 31 | 048_SEQUENCIA | number |  |
| 32 | 057_TXT_ESTADOS | text |  |
| 33 | 007_NF-SAI-FRETE | number |  |
| 34 | 010_NF-SAI-TROCA | number |  |
| 35 | 026_CLI-END-RUA | text |  |
| 36 | 058_ID-UNICO | text |  |
| 37 | 003_NF-SAI-BOLETO | number |  |
| 38 | 004_NF-SAI-CARTAO | number |  |
| 39 | 037_TOTAL-SAIDA | number |  |
| 40 | 014_SUBTIPO-FISCAL | text |  |
| 41 | 021_CLI-END-CIDADE-TEXT | text |  |
| 42 | 023_CLI-END-ESTADO-TEXT | text |  |
| 43 | 005_NF-SAI-DESCONTO | number |  |
| 44 | 006_NF-SAI-DINHEIRO | number |  |
| 45 | 036_TOTAL-ENTRADA | number |  |
| 46 | 034_WBM-DanfeSimples | text |  |
| 47 | 024_CLI-END-IBGE | text |  |
| 48 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 49 | 013_COM-COD | relation -> DB017_COM_COMPRA |  |
| 50 | 012_ATE-COD | relation -> DB029_LAN_ATENDIMENTO |  |
| 51 | 045_REF | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 52 | 051_TIPO-PESSOA | option([WMBR] - Pessoa) |  |
| 53 | 022_CLI-END-ESTADO-OS | option([OS] ESTADOS) |  |
| 54 | 052_EMISSOR | relation -> DB073_RF_INFO_FISCAL |  |
| 55 | 020_CLI-END-CIDADE-OS | relation -> DB009_CONF_CIDADES_BR |  |
| 56 | 030_PRODUTOS | list<relation -> DB031_LAN_ESTOQUE> |  |
| 57 | 054_RETORNO_NFSE | relation -> DB121_RETORNO_NFSE |  |
| 58 | 031_Servicos | list<relation -> DB122_NFSE_SERVICOS> |  |
| 59 | 053_RETORNO_LOTE | relation -> DB120_RETORNO_LOTE |  |
| 60 | 040_PAGAMENTO-CAP | list<relation -> DB030_LAN_CAP-CAR> |  |

---

## DB057_PROD_CATEGORIA
> Key: `tipo` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_CATEGORIA] | text |  |
| 2 | 002_DELETAVEL] | boolean | `true` |
| 3 | 001_ATIVO] | boolean | `true` |
| 4 | 004_ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB058_PROD_COR
> Key: `cor` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_Remover | boolean |  |
| 2 | 002_COR] | text |  |
| 3 | 001_ATIVO] | boolean | `true` |
| 4 | 004_ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB059_PROD_GRUPO
> Key: `grupo1` | Fields: 4 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_GRUPO] | text |  |
| 2 | 001_ATIVO] | boolean | `true` |
| 3 | 003_ID-UNICO | text |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB060_PROD_LOCAL
> Key: `_prod__local` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_NOME_LOCAL | text |  |
| 2 | 001_ATIVO | boolean |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | 003_COR_IDENTIFICACAO | option([OS] - COR_LOCAL) |  |
| 5 | 004_FINALIDADE | option([OS] - FINALIDADE) | `estoque` |

---

## DB061_PROD_MARCA
> Key: `marca` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_MARCA] | text |  |
| 2 | 001_ATIVO] | boolean | `true` |
| 3 | 003_CriadoAdmin] | boolean |  |
| 4 | 004_ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB062_PROD_PRODUTO
> Key: `z_lan_cad` | Fields: 38 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 030_Remover | boolean |  |
| 2 | 001_ATIVO] | boolean | `true` |
| 3 | 010_CAD_NomeProduto] | text |  |
| 4 | 007_CAD_Est_Max] | number |  |
| 5 | 008_CAD_Est_Min] | number |  |
| 6 | 013_CAD_TRO_Max] | number |  |
| 7 | 014_CAD_TRO_Min] | number |  |
| 8 | 012_CAD_SKU] | text |  |
| 9 | 018_CAD_Marca] | relation -> DB061_PROD_MARCA |  |
| 10 | 002_CAD_Preço_Varejo] | number |  |
| 11 | 004_ACESS_CustoTotal] | number |  |
| 12 | 005_ACESS_VendaTotal] | number |  |
| 13 | 017_CAD_Grupo] | relation -> DB059_PROD_GRUPO |  |
| 14 | 023_Saldo_de_estoque] | number | `0` |
| 15 | 032_TXT_MEMORIA | text |  |
| 16 | 009_CAD_NomeConcatenado] | text |  |
| 17 | 036_ID-UNICO | text |  |
| 18 | 024_Custo_Externa | number |  |
| 19 | 025_Custo_Interna | number |  |
| 20 | 026_PrecoAjustado | number |  |
| 21 | 015_CAD_Categoria] | relation -> DB057_PROD_CATEGORIA |  |
| 22 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 23 | 028_NF-Saldo Fiscal | number |  |
| 24 | 019_CAD_Memoria] | option([OS] MEMORIA) |  |
| 25 | 027_CODIGO-ASSOCIADO | text |  |
| 26 | 034_TXT_TIPO_PRODUTO | text |  |
| 27 | 031_TXT_ESPECIFICACOES | text |  |
| 28 | 003_CAD_Preço_Atacado] | number |  |
| 29 | 006_CAD_CustoMedio] | number |  |
| 30 | 035_TXT_MEMORIA PC [OS] ESPECIFICACOES | text |  |
| 31 | 033_TXT_SUBTIPO_PRODUTO | text |  |
| 32 | 020_CAD_Memória_PC] | option([OS] ESPECIFICACOES) |  |
| 33 | 021_CAD_Subtipo] | option([OS] SUBTIPO_PRODUTO) |  |
| 34 | 022_CAD_TipoDeProdutoOS] | option([OS] TIPO_PRODUTO) |  |
| 35 | 016_CAD_Especificacoes] | option([OS] ESPECIFICACOES) |  |
| 36 | 011_CAD_Servico_Avaria] | list<relation -> DB018_CAD_AVARIA> |  |
| 37 | 037_Estoque-acessorio | list<relation -> DB999_VERIF_ESTOQ_ACESSORIO> |  |
| 38 | 029_EMP_SALDO_FISCAL | list<relation -> DB104_EMP_SALDO_FISCAL> |  |

---

## DB063_RF_1_MVA
> Key: `_rf__mva` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_ALIQUOTA | number |  |
| 2 | 002_SUBCODIGO | number |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB064_RF_2_ICMS
> Key: `_rf__icms` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_ALIQUOTA | number |  |
| 2 | 002_SUBCODIGO | number |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB065_RF_3_ICMS_ST
> Key: `_rf__icms_st` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_ALIQUOTA | number |  |
| 2 | 002_SUBCODIGO | number |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB066_RF_4_FCP
> Key: `_rf__fcp` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_ALIQUOTA | number |  |
| 2 | 002_SUBCODIGO | number |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB067_RF_5_FCP_ST
> Key: `_rf__fcp_st` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_ALIQUOTA | number |  |
| 2 | 002_SUBCODIGO | number |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB068_RF_6_BENEFICIO
> Key: `_rf__5_fcp_st4` | Fields: 7 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 002_SUBCODIGO | number |  |
| 2 | 004_CODIGO_BENF | text |  |
| 3 | 005_TXT_ESTADOS | text |  |
| 4 | 006_ID-UNICO | text |  |
| 5 | 003_UF | option([OS] ESTADOS) |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB069_RF_7_IPI
> Key: `_rf__5_fcp_st` | Fields: 11 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 007_WMBR] - Cenario | text |  |
| 2 | 008_WMBR] - IPI-Situacoes | text |  |
| 3 | 006_ALIQUOTA | number |  |
| 4 | 005_COD_ENQUAD | text |  |
| 5 | 009_WMBR] - Pessoa | text |  |
| 6 | 010_ID-UNICO | text |  |
| 7 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 8 | 002_TIPO_PESSOA | option([WMBR] - Pessoa) |  |
| 9 | 003_IPI_CENARIO | option([WMBR] - Cenario) |  |
| 10 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 11 | 004_SIT_TRIBUTARIA | option([WMBR] - IPI-Situacoes) |  |

---

## DB070_RF_8_PIS
> Key: `_rf__7_ipi` | Fields: 10 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_ALIQUOTA | number |  |
| 2 | 009_ID-UNICO | text |  |
| 3 | 007_WMBR] - Pessoa | text |  |
| 4 | 006_WMBR] - Cenario | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 008_WMBR] - PIS-Situacoes | text |  |
| 7 | 002_TIPO_PESSOA | option([WMBR] - Pessoa) |  |
| 8 | 003_PIS_CENARIO | option([WMBR] - Cenario) |  |
| 9 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 10 | 004_SIT_TRIBUTARIA | option([WMBR] - PIS-Situacoes) |  |

---

## DB071_RF_9_COFINS
> Key: `_rf__8_pis` | Fields: 10 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_ALIQUOTA | number |  |
| 2 | 009_ID-UNICO | text |  |
| 3 | 008_WMBR] - Pessoa | text |  |
| 4 | 006_WMBR] - Cenario | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 007_WMBR] - CONFINS-Situacoes | text |  |
| 7 | 002_TIPO_PESSOA | option([WMBR] - Pessoa) |  |
| 8 | 003_PIS_CENARIO | option([WMBR] - Cenario) |  |
| 9 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 10 | 004_SIT_TRIBUTARIA | option([WMBR] - COFINS-Situacoes) |  |

---

## DB072_RF_ICMS_INFO
> Key: `_rf__5_fcp_st3` | Fields: 38 | Relations: 9

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 005_CFOP | text |  |
| 2 | 013_ALIQUOTA-ICMS | number |  |
| 3 | 037_ID-UNICO | text |  |
| 4 | 019_BC_ST-Retido | number |  |
| 5 | 033_WMBR] - Pessoa | text |  |
| 6 | 031_WMBR] - Cenario | text |  |
| 7 | 035_ICMS [WMBR] - Motivo | text |  |
| 8 | 020_Aliq_ST-Retido | number |  |
| 9 | 026_Aliq_ICMS_Efet | number |  |
| 10 | 021_Valor_ST-Retido | number |  |
| 11 | 024_Aliq_FCP-Retido | number |  |
| 12 | 025_Aliq_BC_Efetivo | number |  |
| 13 | 014_ALIQUOTA-BC-ICMS | number |  |
| 14 | 023_Valor_FCP-Retido | number |  |
| 15 | 027_Aliq_ICMS-Diferim | number |  |
| 16 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 17 | 015_ALIQUOTA-BC-ICMS-ST | number |  |
| 18 | 036_ICMS-ST [WMBR] - Motivo | text |  |
| 19 | 016_ALIQUOTA-EFET-BC-ICMS | number |  |
| 20 | 022_Valor_ICMS-Substituto | number |  |
| 21 | 007_ALIQ_MVA | list<relation -> DB063_RF_1_MVA> |  |
| 22 | 010_ALIQ_FCP | list<relation -> DB066_RF_4_FCP> |  |
| 23 | 018_IPI | list<relation -> DB069_RF_7_IPI> |  |
| 24 | 032_WMBR] - COFINS-Situacoes | text |  |
| 25 | 028_Aliq_ICMS-ST-DiferimFCP | number |  |
| 26 | 008_ALIQ_ICMS | list<relation -> DB064_RF_2_ICMS> |  |
| 27 | 017_ALIQUOTA-EFET-BC-ICMS-ST | number |  |
| 28 | 034_WMBR] - Tipo_de_tributacao | text |  |
| 29 | 002_TIPO_PESSOA | option([WMBR] - Pessoa) |  |
| 30 | 011_ALIQ_FCP-ST | list<relation -> DB067_RF_5_FCP_ST> |  |
| 31 | 001_ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 32 | 004_SIT_TRIBUT | option([WMBR] - ICMS-Situacoes) |  |
| 33 | 009_ALIQ_ICMS-ST | list<relation -> DB065_RF_3_ICMS_ST> |  |
| 34 | 003_CENARIO_FISCAL | option([WMBR] - Cenario) |  |
| 35 | 012_ALIQ_BENEFICIO | list<relation -> DB068_RF_6_BENEFICIO> |  |
| 36 | 006_TIPO_TRIBUTACAO | option([WMBR] - Tipo_de_tributacao) |  |
| 37 | 029_Motiv_Deson-ICMS | option([WMBR] - Motivo) |  |
| 38 | 030_Motiv_Deson-ICMS-ST | option([WMBR] - Motivo) |  |

---

## DB073_RF_INFO_FISCAL
> Key: `_rf__informacao_fiscal` | Fields: 60 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 026_RF - IE] | text |  |
| 2 | 027_RF - IM] | text |  |
| 3 | 001_ATIVO] | boolean |  |
| 4 | 006_RF - CNPJ] | text |  |
| 5 | 041_CompanyId | text |  |
| 6 | 053_WMBR - ID | text |  |
| 7 | 021_RF - PORTE] | text |  |
| 8 | 030_Cert-Senha | text |  |
| 9 | 037_NFSE-SERIE | text |  |
| 10 | 039_NFSE-LOGIN | text |  |
| 11 | 040_NFSE-SENHA | text |  |
| 12 | 028_Cert-Base64 | text |  |
| 13 | 029_Cert-Expira | date |  |
| 14 | 031_NFE-SERIE | number |  |
| 15 | 035_NFCE-ID-CSC | text |  |
| 16 | 055_TXT_ESTADOS | text |  |
| 17 | 008_RF - END_CEP] | text |  |
| 18 | 033_SERIE-NFCE | number |  |
| 19 | 058_ID-UNICO | text |  |
| 20 | 014_RF - END_TIPO] | text |  |
| 21 | 024_RF - SITUACAO] | text |  |
| 22 | 042_NFE-INFO-FISCO | text |  |
| 23 | 007_RF - END_BAIRRO] | text |  |
| 24 | 009_RF - END_CIDADE] | text |  |
| 25 | 012_RF - END_ESTADO] | text |  |
| 26 | 013_RF - END_NUMERO] | text |  |
| 27 | 036_NFCE-CODIGO-CSC | text |  |
| 28 | 044_UNIDADE EMPRESA | text | `matriz` |
| 29 | 045_WM - EMP_UUID | text |  |
| 30 | 003_RF - CIDADE_IBGE] | text |  |
| 31 | 025_RF - TELEFONE_01] | text |  |
| 32 | 032_NFE-ATUAL-NOTA | number |  |
| 33 | 038_NFSE-ATUAL-RPS | number |  |
| 34 | 011_RF - END_ENDERECO] | text |  |
| 35 | 017_RF - NAT_JURIDICA] | text |  |
| 36 | 022_RF - RAZAO_SOCIAL] | text |  |
| 37 | 034_NFCE-ATUAL-NOTA | number |  |
| 38 | 018_RF - NOME_FANTASIA] | text |  |
| 39 | 046_WMBR - AccessToken | text |  |
| 40 | 051_WMBR - ConsumerKey | text |  |
| 41 | 002_RF - CERT-VALIDO] | boolean | `false` |
| 42 | 004_RF - CNAE_PRINCIPAL] | text |  |
| 43 | 019_RF - OPTANTE_MEI] | boolean |  |
| 44 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 45 | 010_RF - END_CONCATENADO] | text |  |
| 46 | 050_WMBR - ClaImp - Saida | text |  |
| 47 | 052_WMBR - ConsumerSecret | text |  |
| 48 | 056_TXT_REGIME_TRIBUTARIO | text |  |
| 49 | 016_RF - INICIO_ATIVIDADES] | date |  |
| 50 | 020_RF - OPTANTE_SIMPLES] | boolean |  |
| 51 | 049_WMBR - ClaImp - Entrada | text |  |
| 52 | 047_WMBR - AccessTokenSecret | text |  |
| 53 | 048_WMBR - BearerAccessToken | text |  |
| 54 | 057_WMBR] Tipo_de_tributacao | text |  |
| 55 | 005_RF - CNAE_PRINCIPAL_DESCRICAO] | text |  |
| 56 | 015_RF - Estado IE] | option([OS] ESTADOS) |  |
| 57 | 059_IBS/CBS-RemoverObrigatoriedade | boolean |  |
| 58 | 043_NFSE_INFO_FISCAL | relation -> DB118_NFSE_INFO_FISCAL |  |
| 59 | 054_RF - TIPO_TRIBUTACAO] | option([WMBR] - Tipo_de_tributacao) |  |
| 60 | 023_RF - REGIME_TRIBUTARIO] | option([OS] REGIME_TRIBUTARIO) |  |

---

## DB074_RF_PARAM_IMPOSTO
> Key: `_nf__categ_imposto` | Fields: 18 | Relations: 7

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 004_REF | text |  |
| 2 | 007_APELIDO | text |  |
| 3 | 001_ATIVO | boolean | `false` |
| 4 | 005_DESCRICAO | text |  |
| 5 | 006_SUGEST-USO | text |  |
| 6 | 002_ID-INTERNO | text |  |
| 7 | 017_ID-UNICO | text |  |
| 8 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 9 | 013_RF-PIS | list<relation -> DB070_RF_8_PIS> |  |
| 10 | 018_IBS-CBS | list<relation -> DB128_IBS-CBS> |  |
| 11 | 016_WMBR] - Tipo_de_tributacao | text |  |
| 12 | 010_RF-COFINS | list<relation -> DB071_RF_9_COFINS> |  |
| 13 | 012_RF-IPI | list<relation -> DB069_RF_7_IPI> |  |
| 14 | 015_RF-NFSE | relation -> DB119_RF_NFSE |  |
| 15 | 011_RF-ICMS | list<relation -> DB072_RF_ICMS_INFO> |  |
| 16 | 014_NAT-OPS | option([OS] - FIS-NAT-OPS) |  |
| 17 | 008_TIPO-TRIBUTACAO | option([WMBR] - Tipo_de_tributacao) |  |
| 18 | 009_REGIME-TRIBUTARIO | option([OS] REGIME_TRIBUTARIO) |  |

---

## DB075_SIM_PAGAMENTO
> Key: `bd_sim_pagamentos` | Fields: 9 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 05 - [PAGTO_VALOR] | number |  |
| 2 | 04 - [PAGTO_PARCELA] | number |  |
| 3 | Z- OPT [OS] FORMA_PAGTO | text |  |
| 4 | Z-UNIQUE - ID-UNICO | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 06 - [PAGTO_VALOR_COM_TAXA] | number |  |
| 7 | 03 - [DESCONTO_FINAL] | number |  |
| 8 | 02 - [D_FORMA_PAGTO] | option([OS] FORMA_PAGTO) |  |
| 9 | 01 - [D_COD_SIMULACAO] | relation -> DB040_LAN_SIMULACOES |  |

---

## DB076_SIM_TROCA
> Key: `z_lanc_troca` | Fields: 13 | Relations: 5

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 99 - [TRO_IMEI | text |  |
| 2 | 99 - [TRO_Bateria | number |  |
| 3 | 99 - [D_TRO_Cor | relation -> DB058_PROD_COR |  |
| 4 | 99 - [TipoLancamento | text |  |
| 5 | 99 - [TRO_CodInterno | text |  |
| 6 | 99 - [TRO_Proposta | number |  |
| 7 | 99 - [TRO_SIM_NomeCliente | text |  |
| 8 | 99 - [TRO_SIM_TelCliente | text |  |
| 9 | Z-UNIQUE - ID-UNICO | text |  |
| 10 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 11 | 99 - [D_TRO_Produto | relation -> DB062_PROD_PRODUTO |  |
| 12 | 99 - [D_TRO_Avarias | list<relation -> DB018_CAD_AVARIA> |  |
| 13 | 99 - [D_COD_LancaSim | relation -> DB040_LAN_SIMULACOES |  |

---

## DB077_SIM_VENDA
> Key: `z_lanc_venda` | Fields: 11 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 99 - [VEN_Preço | number |  |
| 2 | 99 - [COD_SimVenda | text |  |
| 3 | 99 - [TipoLancamento | text |  |
| 4 | 99 - [VEN_CodInterno | text |  |
| 5 | 99 - [VEN_Desconto | number |  |
| 6 | 99 - [VEN_SIM_TelCliente | text |  |
| 7 | 99 - [VEN_SIM_NomeCliente | text |  |
| 8 | Z-UNIQUE - ID-UNICO | text |  |
| 9 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 10 | 99 - [D_VEN_Produto | relation -> DB062_PROD_PRODUTO |  |
| 11 | 99 - [D_COD_LancaSim | relation -> DB040_LAN_SIMULACOES |  |

---

## DB078_TREL_COMENT_TAREFA
> Key: `communication_comment` | Fields: 4 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [00] - TEXTO | text |  |
| 2 | [01] - TIPO-NOTA | text |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | [02] - COD-TASK | relation -> DB082_TREL_TAREFA_MANUT |  |

---

## DB079_TREL_PROJETO
> Key: `function` | Fields: 8 | Relations: 5

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [01] - DESCRICAO | text |  |
| 2 | [03] - NOME | text |  |
| 3 | [04] - PINNED? | boolean |  |
| 4 | [02] - MEMBROS | list<relation -> User> |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | [05] - STATUS | list<relation -> DB080_TREL_STATUS_TAREFA> |  |
| 7 | [06] - TAREFAS-MANUT | list<relation -> DB082_TREL_TAREFA_MANUT> |  |
| 8 | [07] - TAREFAS-CRM | list<relation -> DB081_TREL_TAREFA_CRM> |  |

---

## DB080_TREL_STATUS_TAREFA
> Key: `task_status` | Fields: 7 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [00] - COR | text |  |
| 2 | [00] - NOME DO STATUS | text |  |
| 3 | [00] - ORDEM DO STATUS | number |  |
| 4 | [00] - 0PROJETO | text |  |
| 5 | [00] - PROJETO | relation -> DB079_TREL_PROJETO |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | [01] - Local | relation -> DB060_PROD_LOCAL |  |

---

## DB081_TREL_TAREFA_CRM
> Key: `_trel____tarefa_crm` | Fields: 18 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [12] - LEAD-Assistencia | text |  |
| 2 | [16] - Data | date |  |
| 3 | [09] - LEAD-Status | boolean |  |
| 4 | [03] - LEAD-Nome | text |  |
| 5 | [15] - LEAD-Email | text |  |
| 6 | [02] - LEAD-Codigo | text |  |
| 7 | [06] - LEAD-Origem | text |  |
| 8 | [14] - LEAD-Entrada | date |  |
| 9 | [04] - LEAD-Telefone | text |  |
| 10 | [15] - LEAD-FimTeste | date |  |
| 11 | [05] - LEAD-Instagram | text |  |
| 12 | [10] - LEAD-Interesse | text |  |
| 13 | [01] - EMPRESA-MANUAL | text |  |
| 14 | [08] - LEAD-Comentarios | text |  |
| 15 | [11] - LEAD-Responsavel | text |  |
| 16 | [13] - LEAD-Loja Fisica | text |  |
| 17 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 18 | [07] - LEAD-FaseFunil | relation -> DB080_TREL_STATUS_TAREFA |  |

---

## DB082_TREL_TAREFA_MANUT
> Key: `communication` | Fields: 111 | Relations: 25

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [00] - NOME | text |  |
| 2 | [00] - RESPONSAVEL | relation -> User |  |
| 3 | [00] - RESUMO | text |  |
| 4 | [62] - COR | text |  |
| 5 | [04] - LINK | text |  |
| 6 | [63] - IMEI | text |  |
| 7 | ASSINADO-RECIBO | boolean |  |
| 8 | Z - Taxas | number |  |
| 9 | [01] - APROVADO? | boolean |  |
| 10 | Z - LucroOS | number |  |
| 11 | [99] - QR-CODE | text |  |
| 12 | [50] - COD_TASK | text |  |
| 13 | [53] - ATIVO | boolean |  |
| 14 | [55] - RESPONSAVEL | relation -> User |  |
| 15 | [68] - ID_APPLE | text |  |
| 16 | POSSUI-ANEXO | boolean |  |
| 17 | Z - PAGTO_PIX | number |  |
| 18 | Z - PAGTO_TED | number |  |
| 19 | [50] - COD_SEQ | number |  |
| 20 | [52] - STATUS_OS | text |  |
| 21 | [54] - DATA_TASK | date |  |
| 22 | [56] - CRIADO POR | relation -> User |  |
| 23 | [61] - BATERIA | number |  |
| 24 | [64] - NUM_SERIE | text |  |
| 25 | [68] - TEMPO_USO | text |  |
| 26 | [82] - ENVIOU-DOC-RECIBO | date |  |
| 27 | ASSINADO-FINAL | boolean |  |
| 28 | [02] - DESCRICAO | text |  |
| 29 | [50] - COD_OS_TASK | text |  |
| 30 | [51] - CPF_CLIENTE | text |  |
| 31 | [74] - PrazoEstimado | date |  |
| 32 | Z - LucroBrutoOS | number |  |
| 33 | Z - PAGTO_Boleto | number |  |
| 34 | Z - PAGTO_Cartao | number |  |
| 35 | Z - TotalCustoOS | number |  |
| 36 | [51] - NOME_CLIENTE | text |  |
| 37 | [68] - SENHA_ICLOUD | text |  |
| 38 | [80] - DOC-FILE-URL-RECIBO | text |  |
| 39 | [99] - Desligado | boolean |  |
| 40 | [00] - PROJETO | relation -> DB079_TREL_PROJETO |  |
| 41 | [74] - ChipDevolvido | text |  |
| 42 | [74] - Pagto_Frete | number |  |
| 43 | [84] - FOLDER-STRUCT | text |  |
| 44 | [99] - Custo_Pecas | number |  |
| 45 | [99] - Finalizado em | date |  |
| 46 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 47 | Z - PAGTO_Dinheiro | number |  |
| 48 | [71] - E-MAIL_CLIENTE | text |  |
| 49 | [74] - OBS_PAGTO_LOJA | text |  |
| 50 | [99] - Finalizado por | relation -> User |  |
| 51 | Z - Custo_MaoDeObra | number |  |
| 52 | [72] - PRAZO_ORCAMENTO | date |  |
| 53 | [72] - SALDO_DEVEDOR | number |  |
| 54 | [81] - ASS-CAMINHO-URL-RECIBO | text |  |
| 55 | Z - TotalPagoCliente | number |  |
| 56 | [52] - OS_CANCELADO POR | relation -> User |  |
| 57 | [70] - PRECO-ESTIMADO | number |  |
| 58 | [71] - TELEFONE_CLIENTE | text |  |
| 59 | [72] - STATUS_PAGAMENTO | text |  |
| 60 | [73] - Tipo_Assistencia | text |  |
| 61 | [87] - ENVIOU-DOC-FINAL | date |  |
| 62 | [99] - Local Manutencao | text |  |
| 63 | [68] - APARELHO_TEM_CHIP | text |  |
| 64 | [74] - OBS_PAGTO_CLIENTE | text |  |
| 65 | [00] - STATUS | relation -> DB080_TREL_STATUS_TAREFA |  |
| 66 | Z - ValorEstimadoFinal | number |  |
| 67 | [68] - OBSERVACOES_GERAIS | text |  |
| 68 | [71] - LISTA_SERVICO | list<text> |  |
| 69 | [85] - DOC-FILE-URL-FINAL | text |  |
| 70 | [52] - OS_DATA_CANCELAMENTO | date |  |
| 71 | [67] - CHECK_PROBLEMAS | list<text> |  |
| 72 | [72] - VALIDADE_ORCAMENTO | number |  |
| 73 | [73] - ORÇAMENTO_INICIAL | boolean |  |
| 74 | Z - TotalCustoOS_SEMTAXAS | number |  |
| 75 | [60] - MEMORIA_ESPECIFICACAO | text |  |
| 76 | [68] - MARCAS_DE_USO | text |  |
| 77 | [68] - PASSOU_GARANTIA_APPLE | text |  |
| 78 | [86] - ASS-CAMINHO-URL-FINAL | text |  |
| 79 | [52] - OS_MOTIVO_CANCELAMENTO | text |  |
| 80 | [68] - SENHA_APARELHO_CLIENTE | text |  |
| 81 | [99] - CHECKLIST POSTERIOR | boolean |  |
| 82 | [99] - CHECKLIST_PERGUNTADO | boolean |  |
| 83 | [57] - PROD_CLIENTE | relation -> DB062_PROD_PRODUTO |  |
| 84 | [83] - DOC-CRIADO-RECIBO | relation -> DB021_DOC_ASSIN |  |
| 85 | [99] - Lista Custo_Peças_SI | list<number> |  |
| 86 | [00] - PRIORIDADE | option([TREL] - PRIORIDADE TAREFA) |  |
| 87 | ZZZ - Garantia | relation -> DB032_LAN_GARANTIA |  |
| 88 | [71] - SERVIÇOS | list<relation -> DB062_PROD_PRODUTO> |  |
| 89 | [68] - MOTIVO_ASSISTENCIA_ANTERIOR | text |  |
| 90 | [68] - PASSOU_ASSISTENCIA_ANTERIOR | text |  |
| 91 | [75] - NOTA_FISCAL | relation -> DB056_LAN_NF |  |
| 92 | [99] - Lista Custo_Pecas_CI | list<number> |  |
| 93 | [99] - LOCAL-REPARO | relation -> DB060_PROD_LOCAL |  |
| 94 | [65] - ESTOQUE_LOCAL | relation -> DB060_PROD_LOCAL |  |
| 95 | [67] - CHECK_PROBLEMAS_INICIAL | list<text> |  |
| 96 | [71] - LISTA_PRECOS_SERVICOS | list<number> |  |
| 97 | [71] - CUSTO_MAODEOBRA_SERVICO | list<number> |  |
| 98 | [88] - DOC-CRIADO-FINAL | relation -> DB021_DOC_ASSIN |  |
| 99 | [99] - CHECKLIST_POSTERIOR_LISTA | list<text> |  |
| 100 | [99] - Lista_Pecas_CI_Utilizadas | list<text> |  |
| 101 | [99] - Lista_Pecas_SI_Utilizadas | list<text> |  |
| 102 | [01] - CHECKLIST | list<relation -> DB999_VERIF_TASK_CHECKLIST> |  |
| 103 | [51] - DADOS_CLIENTE | relation -> DB016_CLI_CLIENTE |  |
| 104 | [03] - COMENTARIOS | list<relation -> DB078_TREL_COMENT_TAREFA> |  |
| 105 | Z - Lista_CAP-CAR | list<relation -> DB030_LAN_CAP-CAR> |  |
| 106 | [99] - Pecas_SI_Utilizadas | list<relation -> DB062_PROD_PRODUTO> |  |
| 107 | [66] - CHECKLIST_ORIGEM | relation -> DB004_CHECKLIST |  |
| 108 | [74] - TermoGarantia | relation -> DB007_CONF_TERMO_GARANTIA |  |
| 109 | [99] - LOCAL-INT-EXT | option([OS] - FINALIDADE) |  |
| 110 | [99] - Pecas_CI_Utilizadas | list<relation -> DB031_LAN_ESTOQUE> |  |
| 111 | [99] - CHECKLIST_ORIGEM_POSTERIOR | relation -> DB004_CHECKLIST |  |

---

## DB083_UAZ_TRANSACIONAL
> Key: `whatsapp_transacional` | Fields: 4 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | URL | text |  |
| 2 | API-KEY | text |  |
| 3 | Ativo | boolean | `false` |
| 4 | Instancia | text |  |

---

## DB084_UAZ_VERIF_TEL
> Key: `verificar_telefone` | Fields: 3 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | telefone | text |  |
| 2 | senha | text |  |
| 3 | status | text |  |

---

## DB085_UAZ_WEBHOOK
> Key: `webhook_uazapi_otimizado` | Fields: 27 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | event | text |  |
| 2 | state | text |  |
| 3 | msg_id | text |  |
| 4 | source | text |  |
| 5 | status | text |  |
| 6 | arquivo | file |  |
| 7 | instance | text |  |
| 8 | mensagem_texto | text |  |
| 9 | pushname | text |  |
| 10 | fromMe | boolean |  |
| 11 | remotejid | text |  |
| 12 | qual grupo | text |  |
| 13 | voto enquete | text |  |
| 14 | imagem perfil | text |  |
| 15 | status_reason | text |  |
| 16 | file_extension | text |  |
| 17 | audio_seconds | number |  |
| 18 | owner | text |  |
| 19 | qrcode instance | text |  |
| 20 | tipo de mensagem | text |  |
| 21 | ID_da_list | text |  |
| 22 | id msg menu respondido | text |  |
| 23 | participante(grupo) | text |  |
| 24 | qrcode base64 | text |  |
| 25 | participantes(grupo) | list<text> |  |
| 26 | url do arquivo da mensagem | text |  |
| 27 | participante no grupo (saiu, entrou...) | text |  |

---

## DB086_UTIL_PRECIFICADOR
> Key: `bd_precificador` | Fields: 9 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 04 - [GRAVADO_FATURAMENTO] | boolean |  |
| 2 | 06 - [NOME_MES] | text |  |
| 3 | 05 - [ANO] | text |  |
| 4 | 07 - [NUMERO_MES] | number |  |
| 5 | 03 - [VALOR_FATURAMENTO] | number |  |
| 6 | 01 - [VALOR_CUSTO] | number |  |
| 7 | 02 - [GRAVADO_CUSTOS] | boolean |  |
| 8 | Z-UNIQUE - ID-UNICO | text |  |
| 9 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB087_CRM_INSTANCIAS
> Key: `whatsapp` | Fields: 12 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 04 - fotoConectado | image |  |
| 2 | 02 - chave | text |  |
| 3 | 09 - qrcode | text |  |
| 4 | 03 - instanciaNome | text |  |
| 5 | 05 - logConexao | list<text> |  |
| 6 | 11 - URL | text |  |
| 7 | 01 - status | text |  |
| 8 | 06 - nomeConexao | text |  |
| 9 | 07 - owner (numero) | text |  |
| 10 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 11 | 10 - usuariosComAcesso | list<relation -> User> |  |
| 12 | 08 - canalConectado | option([CRM] - CONEXOES) |  |

---

## DB088_CRM_ETAPAS
> Key: `_db_88__crm_deptos` | Fields: 5 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 02 - ativo | boolean | `false` |
| 2 | 03 - NomeEtapa | text |  |
| 3 | 03 - OrdemEtapa | number |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 5 | 01 - Funil | relation -> DB092_CRM_FUNIL |  |

---

## DB089_CRM_FILAS
> Key: `_db_89__crm_filas` | Fields: 4 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 01 - nomeFila | text |  |
| 2 | 02 - ativo | boolean |  |
| 3 | 03 - usuarioFila | list<relation -> User> |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB090_CRM_CONTATOS
> Key: `_db_90__crm_contatos` | Fields: 14 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 05 - [CLIENTE_TELEFONE_01] | text |  |
| 2 | 03 - [CLIENTE_CPF_OU_CNPJ] | text |  |
| 3 | 27 - [INSTAGRAM_CLIENTE] | text |  |
| 4 | 23 - [DDI_NUMERO] | text | `+55` |
| 5 | 02 - [CLIENTE_NOME] | text |  |
| 6 | 24 - [DATA_CORRETA] | date |  |
| 7 | 04 - [CLIENTE_EMAIL] | text |  |
| 8 | zz - fotoCliente | image |  |
| 9 | 22 - [INFO_ADICIONAL] | text |  |
| 10 | 06 - [CLIENTE_DATA_NASCIMENTO] | text |  |
| 11 | 26 - [CARTEIRA_USUARIO] | relation -> User |  |
| 12 | 09 - [D_CLIENTE_GENERO] | option([OS] GENERO) | `outro` |
| 13 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 14 | 25 - [ETIQUETAS] | list<relation -> DB091_CRM_ETIQUETAS> |  |

---

## DB091_CRM_ETIQUETAS
> Key: `_db_91__crm_etiquetas` | Fields: 3 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 02 - ativo | boolean |  |
| 2 | 01 - nomeEtiqueta | text |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB092_CRM_FUNIL
> Key: `_db_92__crm_coluna_kanban` | Fields: 4 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 01 - ativo | boolean |  |
| 2 | 02 - nomeFunil | text |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | 03 - EtapasFunil | list<relation -> DB088_CRM_ETAPAS> |  |

---

## DB093_CRM-EVENTO
> Key: `%e1` | Fields: 16 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | name | text |  |
| 2 | type | text |  |
| 3 | title | text |  |
| 4 | dueDate | date |  |
| 5 | endTime | date |  |
| 6 | ativo | boolean | `true` |
| 7 | priority | text |  |
| 8 | interesse | text |  |
| 9 | startTime | date |  |
| 10 | relatedContact | text |  |
| 11 | responsavel | relation -> User |  |
| 12 | description | text |  |
| 13 | informacoesAdicionais | text |  |
| 14 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 15 | tempoAtendimento | option([OS] CRM_TEMPO) |  |
| 16 | tipoReuniao | option([OS] CRM_TIPO_REUNIAO) |  |

---

## DB094_CRM-DADOS-USER
> Key: `_db_102__crm_dados_user` | Fields: 8 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 00 - USER | relation -> User |  |
| 2 | 04 - ATENDIDOS | number |  |
| 3 | 03 - FINALIZADOS | number |  |
| 4 | 05 - TRANSFER-RECEBIDOS | number |  |
| 5 | 06 - TRANSFER-ENVIADOS | number |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | 01 - FINALIZADOS-SEM-MENSAGEM | number |  |
| 8 | 02 - FINALIZADOS-COM-MENSAGEM | number |  |

---

## DB095_METAS-GERAIS
> Key: `_db_95__metas1` | Fields: 7 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 01 - Periodo | date |  |
| 2 | 07 - Salvo | boolean | `false` |
| 3 | 06 - Quem lancou | relation -> User |  |
| 4 | 03 - Dias uteis | number |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | 05 - MetasColaborador | list<relation -> DB096_METAS_COLABORADOR> |  |
| 7 | 04 - Tipo de meta | option([OS] - KPI-TIPO-META) |  |

---

## DB096_METAS_COLABORADOR
> Key: `_db_95__metas` | Fields: 13 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 03 - Codigo | text |  |
| 2 | 04 - Colaborador | relation -> User |  |
| 3 | 05 - KPI_Fat_Geral | number |  |
| 4 | 01 - Data_Meta | date |  |
| 5 | 06 - KPI_Fat_Disp | number |  |
| 6 | 10 - KPI_Luc_Disp | number |  |
| 7 | 08 - KPI_Qtd_Disp | number |  |
| 8 | 07 - KPI_Fat_Acess | number |  |
| 9 | 11 - KPI_Luc_Acess | number |  |
| 10 | 09 - KPI_Qtd_Acess | number |  |
| 11 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 12 | 13 - MetaVinculada | relation -> DB095_METAS-GERAIS |  |
| 13 | 12 - KPI_Usados | list<option([OS] - KPI_METAS)> |  |

---

## DB097_CHANGELOG
> Key: `_db_97__changelog` | Fields: 4 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 03 - DESCRICAO | text |  |
| 2 | 02 - VERSIONAMENTO | text |  |
| 3 | 04 - PUBLICACAO | date |  |
| 4 | 01 - TIPO | option([OS] - VERSIONAMENTO) | `patch` |

---

## DB098_MARKETPLACE
> Key: `_db_98__marketplace` | Fields: 10 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 08 - LINK | text |  |
| 2 | 02 - TITULO | text |  |
| 3 | 01 - IMAGEM | image |  |
| 4 | 04 - VALOR | number |  |
| 5 | 03 - DESCRICAO | text |  |
| 6 | 06 - VENDIDO_POR | text |  |
| 7 | 07 - TOTAL_VENDAS | number |  |
| 8 | 10 - WALLET_DESTINO | text |  |
| 9 | 09 - TAXA_COMISSAO | number |  |
| 10 | 05 - TIPO_COBRANCA | option([OS] - MKTPLACE_COBRANCA) |  |

---

## DB099_FORMS
> Key: `_db99___forms_` | Fields: 7 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | LEAD | text |  |
| 2 | ORIGEM | text |  |
| 3 | ATUACAO | text |  |
| 4 | TELEFONE | text |  |
| 5 | INSTAGRAM | text |  |
| 6 | NOME EMPRESA | text |  |
| 7 | INFO-ADICIONAL | text |  |

---

## DB100_PERSONALIZACAO
> Key: `_db_100____white_label` | Fields: 6 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 04 - LOGO | image | `//51806a6eef94fd6381ad6bd43b8e637b.cdn.bubble.io/f1743114282553x993266645594188500/aas2.png` |
| 2 | 05 - BACKGROUND | image |  |
| 3 | 02 - ENDING_COLOR | text | `#3368be` |
| 4 | 01 - STARTING_COLOR | text | `#480072` |
| 5 | 03 - INTERMEDIATE_COLOR | text | `#470475` |
| 6 | 00 - ID_VISUAL | option([OS] - ID_VISUAL) | `padrao` |

---

## DB101_IMP-MANUAL
> Key: `_db_101__imp_manual` | Fields: 12 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 01 - ICMS - bc_st_retido | number |  |
| 2 | 04 - ICMS - bc_st_dest | number |  |
| 3 | 05 - ICMS - valor_st_dest	 | number |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 5 | 03 - ICMS - valor_st_retido | number |  |
| 6 | 06 - ICMS - valor_fcp_retido | number |  |
| 7 | 02 - ICMS - aliquota_st_retido | number |  |
| 8 | 07 - ICMS - aliquota_fcp_retido | number |  |
| 9 | 08 - ICMS - aliquota_bc_efetivo | number |  |
| 10 | 09 - ICMS - aliquota_icms_efetivo | number |  |
| 11 | 0 - LAN_ESTOQUE | relation -> DB031_LAN_ESTOQUE |  |
| 12 | 10 - PARAM_IMP | relation -> DB074_RF_PARAM_IMPOSTO |  |

---

## DB102_NOTIFICACOES
> Key: `_db_94__notificacoes` | Fields: 6 | Relations: 4

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 03 - [DESCRICAO] | text |  |
| 2 | 02 - [LIDO_POR] | list<relation -> User> |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | 05 - [VISUALIZAVEL_SOMENTE_POR] | relation -> User |  |
| 5 | 04 - [VINCULO_ATE] | relation -> DB029_LAN_ATENDIMENTO |  |
| 6 | 01 - [TIPO_NOTIFICACAO] | option([OS] - TIPO_NOTIFICACAO) |  |

---

## DB103_LAN_ATUALIZACOES_PREVENDA
> Key: `_db_103__lan_atualizacoes_prevenda` | Fields: 4 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [02] - Acao | text |  |
| 2 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 3 | [01] - Cod Pre venda | relation -> DB038_LAN_PRE_VENDA |  |
| 4 | [03] - Pagamento | relation -> DB030_LAN_CAP-CAR |  |

---

## DB104_EMP_SALDO_FISCAL
> Key: `_db_104__emp_saldo_fiscal` | Fields: 4 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | SALDO_FISCAL | number |  |
| 2 | PRODUTO | relation -> DB062_PROD_PRODUTO |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | CNPJ_EMISSOR | relation -> DB073_RF_INFO_FISCAL |  |

---

## DB105_LAN_DRE
> Key: `_db_105__lan_dre__novo_` | Fields: 41 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 00.01 - Data | date |  |
| 2 | 10.00 - IR | number |  |
| 3 | 00.02 - Ativo | boolean |  |
| 4 | 10.01 - CSLL | number |  |
| 5 | 01.00 - Vendas | number |  |
| 6 | 03.03 - Peças | number |  |
| 7 | 05.05 - Frete | number |  |
| 8 | 06.02 - Juros | number |  |
| 9 | 06.03 - Multas | number |  |
| 10 | 01.02 - Servicos | number |  |
| 11 | 06.01 - Dividas | number |  |
| 12 | 01.03 - Pagamentos | number |  |
| 13 | 05.01 - Comissoes | number |  |
| 14 | 05.03 - Softwares | number |  |
| 15 | 02.05 - Devoluções | number |  |
| 16 | 05.08 - Pro-labore | number |  |
| 17 | 06.00 - Emprestimo | number |  |
| 18 | 07.00 - Rendimentos | number |  |
| 19 | 01.01 - Brindes | number |  |
| 20 | 03.02 - Mao de obra | number |  |
| 21 | 05.04 - Combustivel | number |  |
| 22 | 05.06 - Alimentacao | number |  |
| 23 | 05.02 - Bonificacoes | number |  |
| 24 | 02.04 - Cancelamentos | number |  |
| 25 | 03.01 - Custo brindes | number |  |
| 26 | 03.00 - Custo vendidos | number |  |
| 27 | 04.01 - Troca (upgrade) | number |  |
| 28 | 06.04 - Taxas de cartap | number |  |
| 29 | 06.05 - Taxas bancarias | number |  |
| 30 | 08.00 - Outras receitas | number |  |
| 31 | 09.00 - Outras despesas | number |  |
| 32 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 33 | 05.00 - Salario (vendas) | number |  |
| 34 | 04.02 - Troca (downgrade) | number |  |
| 35 | 04.00 - Compra de fornecedor | number |  |
| 36 | 02.03 - Impostos sobre vendas | number |  |
| 37 | 02.02 - Descontos (no serviço) | number |  |
| 38 | 02.00 - Descontos (no produtos) | number |  |
| 39 | 05.07 - Salario (administrativo) | number |  |
| 40 | 02.01 - Descontos (no atendimento) | number |  |
| 41 | 00.03 - CAP-CAR | relation -> DB030_LAN_CAP-CAR |  |

---

## DB106_WHATSAPP-DISTRIBUIDOR
> Key: `_db_106__whatsapp_distribuidor` | Fields: 1 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | ULTIMO | option([OS] - COMERCIAL) |  |

---

## DB107_API-KEYS
> Key: `_db_107__chave_api` | Fields: 5 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [005] - ATIVO | boolean |  |
| 2 | [003] - CONSUMER-KEY | text |  |
| 3 | [002] - NOME-CHAVE-API | text |  |
| 4 | [004] - CONSUMER-SECRET | text |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB108_API-LOG
> Key: `_db_108__log_api` | Fields: 8 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [011] - C-KEY | text |  |
| 2 | [004] - ENDPOINT | text |  |
| 3 | [012] - C-SECRET | text |  |
| 4 | [002] - DATA_HORA | date |  |
| 5 | [003] - STATUS_CODE | text |  |
| 6 | [010] - AUTHORIZATION | text |  |
| 7 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 8 | [005] - PARAMETROS_FILTROS | list<text> |  |

---

## DB109_API-RATE-LIMIT
> Key: `_db_109__api_rate_limit` | Fields: 6 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [003] - LIMITE_DIARIO | number |  |
| 2 | [004] - ULTIMA_REQUISICAO | date |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | [005] - REQUISICOES_DO_DIA | number |  |
| 5 | [006] - REQUISICOES_TOTAIS | number |  |
| 6 | [002] - API_KEY | list<relation -> DB107_API-KEYS> |  |

---

## DB110_AUX-OS
> Key: `_db_110__aux_os` | Fields: 1 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | OPT-S  | text |  |

---

## DB111_IMPRESSAO_ETIQUETAS
> Key: `_db_110__impressao_etiquetas` | Fields: 29 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 02 - IMEI | boolean |  |
| 2 | 04 - SKU | boolean |  |
| 3 | 06 - Cor | boolean |  |
| 4 | 15 - Info SKU | text |  |
| 5 | 20 - Info Cor | text |  |
| 6 | 13 - Info IMEI | text |  |
| 7 | 07 - Bateria | boolean |  |
| 8 | 08 - Memoria | boolean |  |
| 9 | 03 - Num Serie | boolean |  |
| 10 | 07 - Categoria | boolean |  |
| 11 | 18 - Info Memoria | text |  |
| 12 | 05 - Cod Interno | boolean |  |
| 13 | 11 - Preco Venda | boolean |  |
| 14 | 14 - Info Num Serie | text |  |
| 15 | 21 - Info Categoria | text |  |
| 16 | 22 - Info Bateria | number |  |
| 17 | 25 - IMG Cod Barras | text |  |
| 18 | 01 - Nome Produto | boolean |  |
| 19 | 12 - Info Cod Barras | text |  |
| 20 | 09 - Armazenamento | boolean |  |
| 21 | 16 - Info Cod Interno | text |  |
| 22 | 24 - Info Preco Venda | text |  |
| 23 | 10 - Especificacoes | boolean |  |
| 24 | 19 - Info Armazenamento | text |  |
| 25 | 23 - Info Especificacoes | text |  |
| 26 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 27 | 26 - IMG Cod Barras URL 2 | text |  |
| 28 | 26 - IMG Cod Barra URL | option(IMG) |  |
| 29 | 17 - Info Produto | relation -> DB062_PROD_PRODUTO |  |

---

## DB112_CONFIGURACAO_ETIQUETAS
> Key: `_db_111__configuracao_etiquetas` | Fields: 14 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 10 - Linhas | number |  |
| 2 | 00 - Padrao | boolean |  |
| 3 | 09 - Colunas | number |  |
| 4 | 01 - Nome Modelo | text |  |
| 5 | 02 - Altura Pagina | number |  |
| 6 | 11 - Dimensao Pagina | text |  |
| 7 | 03 - Largura Pagina | number |  |
| 8 | 07 - Largura Etiqueta | number |  |
| 9 | 12 - Entre Etiquetas | number |  |
| 10 | 06 - Altura Etiqueta | number |  |
| 11 | 08 - Maximo de etiquetas | number |  |
| 12 | 04 - Margem Lateral Pagina | number |  |
| 13 | 05 - Margem Superior Pagina | number |  |
| 14 | 000_Empresa | list<relation -> DB002_EMPRESAS> |  |

---

## DB113_UTILIZACAO_SUBMODULOS
> Key: `_db_112__utilizacao_submodulos` | Fields: 68 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [304] - FIN-DRE | number |  |
| 2 | [802] - ADI-CRM | number |  |
| 3 | [104] - CAD-Cores | number |  |
| 4 | [106] - CAD-Local | number |  |
| 5 | [804] - ADI-Metas | number |  |
| 6 | [101] - CAD-Grupos | number |  |
| 7 | [102] - CAD-Marcas | number |  |
| 8 | [402] - REL-Vendas | number |  |
| 9 | [407] - REL-Fiscal | number |  |
| 10 | [901] - CON-Gerais | number |  |
| 11 | [103] - CAD-Avarias | number |  |
| 12 | [107] - CAD-Cliente | number |  |
| 13 | [202] - OPS-Estoque | number |  |
| 14 | [303] - FIN-Compras | number |  |
| 15 | [403] - REL-Estoque | number |  |
| 16 | [100] - CAD-Produtos | number |  |
| 17 | [205] - OPS-Comodato | number |  |
| 18 | [206] - OPS-PreVenda | number |  |
| 19 | [207] - OPS-Garantia | number |  |
| 20 | [607] - FIS-NCM-CEST | number |  |
| 21 | [705] - ASS-Servicos | number |  |
| 22 | [707] - AST-Garantia | number |  |
| 23 | [806] - ADI-ChaveAPI | number |  |
| 24 | [401] - REL-Cadastros | number |  |
| 25 | [406] - REL-Gerencial | number |  |
| 26 | [508] - UTI-Etiquetas | number |  |
| 27 | [603] - FIS-NotaSaida | number |  |
| 28 | [706] - ASS-CheckList | number |  |
| 29 | [903] - CON-TrocaLoja | number |  |
| 30 | [105] - CAD-Categorias | number |  |
| 31 | [108] - CAD-Fornecedor | number |  |
| 32 | [302] - FIN-ContaPagar | number |  |
| 33 | [404] - REL-Financeiro | number |  |
| 34 | [601] - FIS-Instrucoes | number |  |
| 35 | [807] - ADI-Patrimonio | number |  |
| 36 | [808] - ADI-Devocional | number |  |
| 37 | [201] - OPS-Atendimento | number |  |
| 38 | [405] - REL-TrafegoPago | number |  |
| 39 | [408] - REL-Assistencia | number |  |
| 40 | [501] - UTI-TabelaVenda | number |  |
| 41 | [502] - UTI-TabelaTroca | number |  |
| 42 | [602] - FIS-NotaEntrada | number |  |
| 43 | [609] - FIS-NotaServico | number |  |
| 44 | [801] - ADI-TrafegoPago | number |  |
| 45 | [805] - ADI-Marketplace | number |  |
| 46 | [904] - CON-DarSugestao | number |  |
| 47 | [203] - OPS-SimularVenda | number |  |
| 48 | [204] - OPS-SimularTaxas | number |  |
| 49 | [301] - FIN-ContaReceber | number |  |
| 50 | [701] - ASS-OrdemServico | number |  |
| 51 | [703] - ASS-EstoquePecas | number |  |
| 52 | [902] - CON-TrocaUsuario | number |  |
| 53 | [503] - UTI-TabelaAvarias | number |  |
| 54 | [505] - UTI-AjusteEstoque | number |  |
| 55 | [506] - UTI-Transferencia | number |  |
| 56 | [608] - FIS-Configuracoes | number |  |
| 57 | [605] - FIS-EstoqueFiscal | number |  |
| 58 | [606] - FIS-RegrasFiscais | number |  |
| 59 | [610] - FIS-MonitorFiscal | number |  |
| 60 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 61 | [504] - UTI-TabelaServicos | number |  |
| 62 | [604] - FIS-NotaCanceladas | number |  |
| 63 | [803] - ADI-AgendaComercial | number |  |
| 64 | [809] - ADI-AuditoriaInterna | number |  |
| 65 | [702] - ASS-EstoqueManutencao | number |  |
| 66 | [704] - ASS-EsteiraManutencao | number |  |
| 67 | [208] - OPS-EstoqueInutilizado | number |  |
| 68 | [507] - UTI-EstoqueCompartilhado | number |  |

---

## DB114_PATRIMONIO
> Key: `_db_113__patrim_nio` | Fields: 7 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [004] - ID | text |  |
| 2 | [003] - TIPO | text |  |
| 3 | [006] - VALOR | number |  |
| 4 | [002] - ATIVO | boolean |  |
| 5 | [005] - DESCRICAO | text |  |
| 6 | [007] - RESPONSAVEL | text |  |
| 7 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB115_NPS-GERAL
> Key: `_db_115__nps_geral` | Fields: 10 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [004] - Q1 | number |  |
| 2 | [005] - Q2 | number |  |
| 3 | [006] - Q3 | number |  |
| 4 | [007] - Q4 | number |  |
| 5 | [008] - Q5 | number |  |
| 6 | [003] - FUNCAO | text |  |
| 7 | [002] - USER | relation -> User |  |
| 8 | [009] - COMENTARIO | text |  |
| 9 | [010] - FUNC-MAIS-GOSTA | text |  |
| 10 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB116_ESTATISTICAS
> Key: `_db_116__estatisticas` | Fields: 3 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [001] - DATA | date |  |
| 2 | [003] - VALOR | number |  |
| 3 | [002] - KPI | option([OS] - KPI-INTERNO) |  |

---

## DB117_ENGAJAMENTO
> Key: `_db_117__engajamento` | Fields: 2 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [002] - DATA | date |  |
| 2 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB118_NFSE_INFO_FISCAL
> Key: `_db_118__nfse_info_fiscal` | Fields: 19 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [023] - LOGIN | text |  |
| 2 | [024] - SENHA | text |  |
| 3 | [025] - TOKEN | text |  |
| 4 | [007] - modelo | text |  |
| 5 | [008] - versao | text |  |
| 6 | [005] - pdf_nfse | boolean |  |
| 7 | [003] - emissao | list<text> |  |
| 8 | [004] - funcoes | list<text> |  |
| 9 | [006] - pdf_sincrono | boolean |  |
| 10 | [021] - ATUAL-SERIE-RPS | text |  |
| 11 | [022] - ATUAL-NUM-RPS | number |  |
| 12 | [029] - PROX-LOTE-RPS | number |  |
| 13 | [002] - autenticacao | list<text> |  |
| 14 | [009] - codigo_servico | list<text> |  |
| 15 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 16 | [010] - RF_INFO_FISCAL | relation -> DB073_RF_INFO_FISCAL |  |
| 17 | [026] - REGIME-APUR-SN | option([OS] - NFSE-REGIME-APUR-SN) |  |
| 18 | [027] - REGIME-ESPEC-NAC | option([OS] - NFSE-REGIME-ESPEC-NAC) |  |
| 19 | [028] - REGIME-ESPEC-MUNIC | option([OS] - NFSE-REGIME-ESPEC-MUNIC) |  |

---

## DB119_RF_NFSE
> Key: `_db_063__rf_1_mva` | Fields: 11 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [002] - REF | text |  |
| 2 | [005] - COD-CNAE | text |  |
| 3 | [003] - COD-SERVICO | text |  |
| 4 | [004] - DESC-SERVICO | text |  |
| 5 | [008] - COD-TRIB-MUNIC | text |  |
| 6 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 7 | [007] - NFSE-Retido | option([OS] - SIM/NAO) |  |
| 8 | [001] - ID-INTERNO | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 9 | [006] - EXIG-ISS | option([OS] - NFSE-EXIG-ISS) |  |
| 10 | [009] - RESP-RETENCAO | option([OS] - NFSE-RESP-RETENCAO) |  |
| 11 | [010] - NAT-OPERACAO | option([OS] - NFSE-NAT-OPERACAO) |  |

---

## DB120_RETORNO_LOTE
> Key: `_db_120__retorno_lote_nfse` | Fields: 11 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [003] - uuid | text |  |
| 2 | [004] - modelo | text |  |
| 3 | [006] - motivo | text |  |
| 4 | [005] - status | text |  |
| 5 | [010] - protocolo | text |  |
| 6 | [008] - serie_lote | text |  |
| 7 | [007] - numero_lote | text |  |
| 8 | [011] - info_nfse | list<text> |  |
| 9 | [009] - quantidade_rps | text |  |
| 10 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 11 | [002] - NFSE | relation -> DB056_LAN_NF |  |

---

## DB121_RETORNO_NFSE
> Key: `_db_121__retorno_nfse` | Fields: 14 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [011] - xml | text |  |
| 2 | [003] - uuid | text |  |
| 3 | [004] - modelo | text |  |
| 4 | [006] - motivo | text |  |
| 5 | [007] - numero | text |  |
| 6 | [005] - status | text |  |
| 7 | [014] - pdf_rps | text |  |
| 8 | [012] - pdf_nfse | text |  |
| 9 | [009] - serie_rps | text |  |
| 10 | [010] - numero_rps | text |  |
| 11 | [013] - pdf_nfse_status | text |  |
| 12 | [008] - codigo_verificacao | text |  |
| 13 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 14 | [002] - NFSE | relation -> DB056_LAN_NF |  |

---

## DB122_NFSE_SERVICOS
> Key: `_db_122__nfse_servicos` | Fields: 4 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 02 - Valor | number |  |
| 2 | 01 - Produto | relation -> DB062_PROD_PRODUTO |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | 03 - NFSE | relation -> DB056_LAN_NF |  |

---

## DB123_CHECK_LIST_AVALIACAO
> Key: `_db_123__check_list_avaliacao` | Fields: 3 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 02 - APROVADOS | list<text> |  |
| 2 | 03 - REPROVADOS | list<text> |  |
| 3 | 01 - ESTOQUE | relation -> DB031_LAN_ESTOQUE |  |

---

## DB124_CARTEIRA
> Key: `_db_124__carteira` | Fields: 6 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [006] - SALDO_COMPRADO | number |  |
| 2 | [005] - COTA_MENSAL_ATUAL | number |  |
| 3 | [002] - TOKEN_COMPRADO | number |  |
| 4 | [003] - TOTAL_TOKEN | number |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | [004] - RECARGAS | list<relation -> DB125_HISTORICO_RECARGA> |  |

---

## DB125_HISTORICO_RECARGA
> Key: `_db_125__historico_recarga` | Fields: 9 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [006] - PayID | text |  |
| 2 | [005] - STATUS | text |  |
| 3 | [004] - VALOR | number |  |
| 4 | [008] - PAYLOAD | text |  |
| 5 | [007] - URL-FATURA | text |  |
| 6 | [003] - DATA_RECARGA | date |  |
| 7 | [009] - ENCODED-IMAGE | text |  |
| 8 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 9 | [002] - CARTEIRA | relation -> DB124_CARTEIRA |  |

---

## DB126_DEVOCIONAL
> Key: `db126_devocional` | Fields: 12 | Relations: 0

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 001_data | date |  |
| 2 | 009_autor | text |  |
| 3 | 011_fonte | text |  |
| 4 | 012_audio | text |  |
| 5 | 002_titulo | text |  |
| 6 | 008_pedido | text |  |
| 7 | 005_destaque | text |  |
| 8 | 007_reflexao | text |  |
| 9 | 003_referencia | text |  |
| 10 | 004_devocional | text |  |
| 11 | 006_texto_apoio | text |  |
| 12 | 010_keywords | list<text> |  |

---

## DB127_AUDITORIA-INTERNA
> Key: `db127_auditoria_interna` | Fields: 10 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 07 - Data | date |  |
| 2 | 02 - Modulo | text |  |
| 3 | 03 - Submodulo | text |  |
| 4 | 04 - Descricao | text |  |
| 5 | 08 - Responsavel | relation -> User |  |
| 6 | 05 - Informacao Original | text |  |
| 7 | 06 - Informacao Alterada | text |  |
| 8 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 9 | 01 - Acao | option([OS] - ACOES_AUDITORIA) |  |
| 10 | 09 - OrigemDado | option([OS] - ORIGEM_DADO_CRIACAO) |  |

---

## DB128_IBS-CBS
> Key: `db128_ibs_cbs` | Fields: 15 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 2 | 013_AliquotaCBSDiferimento | number |  |
| 3 | 003_Cenario | option([WMBR] - Cenario) |  |
| 4 | 002_TipoPessoa | option([WMBR] - Pessoa) |  |
| 5 | 009_AliquotaIBSCreditoPresumido | number |  |
| 6 | 010_AliquotaCBSCreditoPresumido | number |  |
| 7 | 004_SituacaoTributaria | option([WMBR] - RT CST) |  |
| 8 | 011_AliquotaIBSDiferimento-Estadual | number |  |
| 9 | 012_AliquotaIBSDiferimento-Municipal | number |  |
| 10 | 014_ReferenciaImposto | relation -> DB074_RF_PARAM_IMPOSTO |  |
| 11 | 001_TipoTributacao | option([WMBR] - Tipo_de_tributacao) |  |
| 12 | 005_Classificacao | option([WMBR] - RT Classificacao CST) |  |
| 13 | 006_SituacaoTributaria-RegimeRegular | option([WMBR] - RT CST) |  |
| 14 | 007_Classificacao-RegimeRegular | option([WMBR] - RT Classificacao CST) |  |
| 15 | 008_ClassificacaoCreditoPresumido | option([WMBR] - RT Classificacao Credito Presumido) |  |

---

## DB129_Pesquisa_CHURN
> Key: `db129_pesquisa_churn` | Fields: 15 | Relations: 2

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 013_Pergunta10 | text |  |
| 2 | 001_NomeUsuario | text |  |
| 3 | 002_EmailUsuario | text |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 5 | 003_Funcao | relation -> DB011_CONF_FUNCOES |  |
| 6 | 014_PressionouResponderDepois | boolean | `false` |
| 7 | 004_Pergunta01 | list<option([PESQ] - CHURN_Q1)> |  |
| 8 | 005_Pergunta02 | list<option([PESQ] - CHURN_Q2)> |  |
| 9 | 006_Pergunta03 | list<option([PESQ] - CHURN_Q3)> |  |
| 10 | 007_Pergunta04 | list<option([PESQ] - CHURN_Q4)> |  |
| 11 | 008_Pergunta05 | list<option([PESQ] - CHURN_Q5)> |  |
| 12 | 009_Pergunta06 | list<option([PESQ] - CHURN_Q6)> |  |
| 13 | 010_Pergunta07 | list<option([PESQ] - CHURN_Q7)> |  |
| 14 | 011_Pergunta08 | list<option([PESQ] - CHURN_Q8)> |  |
| 15 | 012_Pergunta09 | list<option([PESQ] - CHURN_Q9)> |  |

---

## DB130_SEQ-OS
> Key: `db130_seq_os` | Fields: 4 | Relations: 1

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | 003_SEQ-Atual | number |  |
| 2 | 001_SEQ-Inicio | boolean | `false` |
| 3 | 002_SEQ-A partir | number |  |
| 4 | 000_Empresa | relation -> DB002_EMPRESAS |  |

---

## DB999_VERIF_CONTAS_PAGAR
> Key: `bd_contas_pagar` | Fields: 21 | Relations: 5

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | Lancador__17 | relation -> User |  |
| 2 | ZSubtipo__18 | text |  |
| 3 | CAP_Quitado__10 | text |  |
| 4 | CAP_Ativo__02 | boolean | `false` |
| 5 | CAP_DataPagto__05 | date |  |
| 6 | CAP_Ocorrencia__08 | text |  |
| 7 | CAP_ValorBruto__12 | number |  |
| 8 | CAP_QtdParcelas__09 | number |  |
| 9 | CAP_Recorrencia__11 | number |  |
| 10 | CAP_DescricaoPagto__06 | text |  |
| 11 | CAP_ValorParcela__13 | number |  |
| 12 | Z-OPT [OS] FORMA_PAGTO | text |  |
| 13 | CAP_Cod_lancamento__04 | text |  |
| 14 | Intencao__16 | option([OS] INTENCAO) |  |
| 15 | Z-OPT [OS] INTENCAO | text |  |
| 16 | Z-UNIQUE - ID-UNICO | text |  |
| 17 | CAP_Caixa__03 | relation -> DB010_CONF_CONTA |  |
| 18 | COM_Cod__14 | relation -> DB017_COM_COMPRA |  |
| 19 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 20 | ATE_Cod__01 | relation -> DB029_LAN_ATENDIMENTO |  |
| 21 | CAP_FormaPagto__07 | option([OS] FORMA_PAGTO) |  |

---

## DB999_VERIF_CONTAS_RECEB
> Key: `bd_contar_receber` | Fields: 27 | Relations: 5

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | CAR_Cod__04 | text |  |
| 2 | 0ATE_Cod__01 | text |  |
| 3 | ZCAR_Cod__11 | text |  |
| 4 | zValor__19 | number |  |
| 5 | ZAtivo__09 | boolean | `false` |
| 6 | ZDataComp__13 | date |  |
| 7 | zSituação__18 | boolean |  |
| 8 | Z-OPT [OS] FORMA_PAGTO | text |  |
| 9 | zDesconto__14 | number |  |
| 10 | 0Nome_Cliente__02 | text |  |
| 11 | Taxas_Lojista__06 | number |  |
| 12 | zValorComTaxa__20 | number |  |
| 13 | zValorReceber__23 | number |  |
| 14 | zzBotaoSemJuros__24 | boolean |  |
| 15 | ZValorNegativo__21 | number |  |
| 16 | Z-OPT [OS] BANDEIRAS | text |  |
| 17 | zParcela__17 | relation -> DB013_CONF_TAXAS |  |
| 18 | ValorComAcrescimo__07 | number |  |
| 19 | ValorSemAcrescimo__08 | number |  |
| 20 | Z-UNIQUE - ID-UNICO | text |  |
| 21 | ZValorPositivoPAC__22 | number |  |
| 22 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 23 | zBandeira__10 | option([OS] BANDEIRAS) |  |
| 24 | ZContaReceb__12 | relation -> DB010_CONF_CONTA |  |
| 25 | zMaquina__16 | relation -> DB012_CONF_MAQUINA |  |
| 26 | ATE_Cod__03 | relation -> DB029_LAN_ATENDIMENTO |  |
| 27 | zForma__15 | option([OS] FORMA_PAGTO) |  |

---

## DB999_VERIF_ESTOQ_ACESSORIO
> Key: `zzz_estoque_acessorio` | Fields: 4 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | QTD | number |  |
| 2 | Produto | relation -> DB062_PROD_PRODUTO |  |
| 3 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 4 | Local | relation -> DB060_PROD_LOCAL |  |

---

## DB999_VERIF_NOTIFICATIONS
> Key: `notification1` | Fields: 6 | Relations: 4

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | text | text |  |
| 2 | user-seen | list<relation -> User> |  |
| 3 | receivers | list<relation -> User> |  |
| 4 | project? | relation -> DB079_TREL_PROJETO |  |
| 5 | task? | relation -> DB082_TREL_TAREFA_MANUT |  |
| 6 | cause | option([ZZ] - OS - notification cause) |  |

---

## DB999_VERIF_TASK_CHECKLIST
> Key: `task___checklist` | Fields: 6 | Relations: 3

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [00] - TEXTO | text |  |
| 2 | [00] - FEITO | boolean | `false` |
| 3 | [00] - TAREFA | relation -> DB082_TREL_TAREFA_MANUT |  |
| 4 | [04] - LISTA-TXT | list<text> |  |
| 5 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 6 | [05] - OS-COD | relation -> DB015_ASSIST_OS |  |

---

## SAT
> Key: `db029_lan_atendimento` | Fields: 16 | Relations: 5

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | [99] - STATUS | text |  |
| 2 | [99] - 0CLI-CPF | text |  |
| 3 | [99] - 0CLI-NOME | text |  |
| 4 | [01] - CONCRETIZADO | boolean |  |
| 5 | Estilo_Saida | text |  |
| 6 | [03] - VENDEDOR | relation -> User |  |
| 7 | [99] - DATA_VENDA | date |  |
| 8 | [99] - 0COD_ATENDIMENTO | text |  |
| 9 | Possui Anexo | boolean |  |
| 10 | [04] - TIPO-VENDA | text |  |
| 11 | [99] - LANCA-ATIVO | boolean |  |
| 12 | 000_Empresa | relation -> DB002_EMPRESAS |  |
| 13 | DB29 | relation -> DB029_LAN_ATENDIMENTO |  |
| 14 | [99] - CLI_INTENCAO | option([OS] INTENCAO) |  |
| 15 | COD_GARANTIA | relation -> DB032_LAN_GARANTIA |  |
| 16 | [99] - CLI-INFORMACOES | relation -> DB016_CLI_CLIENTE |  |

---

## User
> Key: `user` | Fields: 37 | Relations: 13

| # | Field | Type | Default |
|---|-------|------|---------|
| 1 | CPF | text |  |
| 2 | teste | text |  |
| 3 | Token | text |  |
| 4 | Telefone | text |  |
| 5 | DATA NASCI | date |  |
| 6 | LogoEmpresa | image |  |
| 7 | Como_conheceu | text |  |
| 8 | 07 - fotoUsuario | image |  |
| 9 | Logo_empresa2 | file |  |
| 10 | 50 - CRM-NOME_CHAT | text |  |
| 11 | nome | text |  |
| 12 | 01 - ativo | boolean |  |
| 13 | 04 - emailUsuario | text |  |
| 14 | 03 - sobrenomeUsuario | text |  |
| 15 | telefone_whatsapp | text |  |
| 16 | basico_completo | boolean | `false` |
| 17 | telefone_mascarado | text |  |
| 18 | 88 - AtualizaPag | boolean |  |
| 19 | 001_EmpresaWeb | relation -> DB002_EMPRESAS |  |
| 20 | 02 - nomeUsuario | text |  |
| 21 | 82 - Acesso Master | boolean |  |
| 22 | NPS-GERAL-RESPONDIDO | boolean | `false` |
| 23 | [TEMP] - Pesquisa CHURN | boolean | `false` |
| 24 | 002_EmpresaApp | relation -> DB002_EMPRESAS |  |
| 25 | NPS | list<relation -> DB115_NPS-GERAL> |  |
| 26 | WhatsApp-Instancia | relation -> DB087_CRM_INSTANCIAS |  |
| 27 | INATIVO-Usuario_permissao | option([OS] PERMISSOES) |  |
| 28 | 09 - instancias | list<relation -> DB087_CRM_INSTANCIAS> |  |
| 29 | 20 - FUNCAO_LOGADA | relation -> DB011_CONF_FUNCOES |  |
| 30 | 99_Dispositivos | list<relation -> static.device [?]> |  |
| 31 | 00_EMP_Vinculadas | list<relation -> DB002_EMPRESAS> |  |
| 32 | 81 - ULTIMO_CHANGELOG | relation -> DB097_CHANGELOG |  |
| 33 | 05 - perfilUsuario | option([OS] CRM_PERFIL_ACESSO) |  |
| 34 | 06 - filasUsuario | list<relation -> DB089_CRM_FILAS> |  |
| 35 | 21 - FUNCAO_VINCULADA | list<relation -> DB011_CONF_FUNCOES> |  |
| 36 | 51 - CRM-DADOS_USER | relation -> DB094_CRM-DADOS-USER |  |
| 37 | 08 - departamentoUsuario | list<relation -> DB088_CRM_ETAPAS> |  |
