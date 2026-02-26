# Auditoria de Boas Praticas Postgres/Supabase

**Escopo:** 90+ tabelas em `supabase/tables/`
**Referencia:** `.agents/skills/supabase-postgres-best-practices/`
**Origem dos dados:** Migracao lift-and-shift de plataforma Bubble.io
**Data:** 2026-02-18

---

## 1. CRITICAL -- Identificadores (naming convention)

**Regra violada:** `schema-lowercase-identifiers` -- Usar lowercase `snake_case`

| Problema | Abrangencia |
|---|---|
| Nomes de tabelas em UPPER_CASE com aspas | **100% (todas as tabelas)** |
| Nomes de colunas com prefixos numericos, hifens, espacos, colchetes, acentos | **100%** |
| Nomes com caracteres especiais (`"DB008_CONF_CHAVE PIX"`, `"002_CPF / CNPJ]"`) | ~20 tabelas |
| Palavra reservada como nome de tabela (`"User"`) | 1 tabela |
| Coluna chamada `"null"` na tabela `User` | 1 tabela |

**Impacto:** Todo SQL requer aspas duplas obrigatorias. Incompativel com ORMs, ferramentas de BI, e funcionalidades do Supabase client.

**Recomendacao:** Renomear para `snake_case` sem aspas (ex: `db029_lan_atendimento` -> `atendimentos`, `"001_ATIVO"` -> `ativo`).

---

## 2. CRITICAL -- Primary Keys

**Regra violada:** `schema-primary-keys` -- Usar `bigint identity` ou UUIDv7

| Problema | Abrangencia |
|---|---|
| PK e `"unique_id" text NOT NULL` sem auto-geracao | **100% (todas as tabelas)** |
| Valor da PK fornecido pela aplicacao (string opaca) | **100%** |
| Nenhuma tabela usa `serial`, `identity`, ou UUID gerado pelo banco | **100%** |

**Impacto:** Sem ordenacao temporal por PK, fragmentacao de indice, dependencia total da aplicacao para gerar IDs, impossibilita `GENERATED ALWAYS AS IDENTITY`.

**Recomendacao:** Migrar para `bigint generated always as identity primary key` ou UUIDv7 (com extensao `pg_uuidv7`). Manter `unique_id` como coluna secundaria com indice UNIQUE para compatibilidade durante migracao.

---

## 3. CRITICAL -- Tipos de dados

**Regra violada:** `schema-data-types` -- Escolher tipos adequados

### 3.1 Timestamps como `text`

| Problema | Abrangencia |
|---|---|
| `"Creation Date"` e `"Modified Date"` como `text` | ~70% das tabelas |
| `"Creation Date"` e `"Modified Date"` como `timestamp without time zone` | ~30% das tabelas |
| Colunas de data de negocio como `text` (ex: `"041_DATA_VENDA"`) | ~25 tabelas |
| Nenhuma tabela usa `timestamptz` | **0%** |

### 3.2 Valores monetarios/numericos como `text`

| Problema | Exemplos |
|---|---|
| Precos, totais, saldos como `text` | `"008_TOTAL_BRUTO"`, `"003_SALDO]"`, `"002_CAD_Preco_Varejo"` |
| Aliquotas fiscais como `text` | `"004_ALIQUOTA"`, `"007_ALIQ_MVA"` |
| `real` (float4) para valores financeiros | DB006, DB013, DB016 -- erro de arredondamento |
| `bigint` para valores monetarios (perde decimais) | DB114 `"[006] - VALOR"` |

### 3.3 Booleanos como `text`

| Problema | Abrangencia |
|---|---|
| Campos "ativo", "concretizado", "quitado" como `text` | **~50+ tabelas** |
| Algumas tabelas usam `boolean` corretamente | DB002_EMPRESAS, DB004, DB005, DB006, DB012, DB017 |

### 3.4 `bigint` oversize

| Problema | Exemplos |
|---|---|
| `bigint` para mes, ordem, status HTTP | `"07 - NUMERO_MES"`, `"[00] - ORDEM"`, `"[003] - STATUS_CODE"` |

**Recomendacao geral:**
- `text` -> `timestamptz` para datas
- `text` -> `boolean` para flags ativo/inativo
- `text` -> `numeric(10,2)` para valores monetarios
- `real`/`float` -> `numeric` para valores financeiros
- `bigint` -> `integer` ou `smallint` onde aplicavel

---

## 4. CRITICAL -- Foreign Keys e Indices

**Regra violada:** `schema-foreign-key-indexes` e `query-missing-indexes`

| Problema | Abrangencia |
|---|---|
| **Zero foreign keys** definidas | **100% (0 de 90+ tabelas)** |
| **Zero indices** alem do PK implicito | **100%** |
| Colunas `"000_Empresa"` sem FK nem indice | ~70 tabelas |
| Referencias logicas entre tabelas sem constraint | Dezenas |

**Impacto:**
- Zero integridade referencial no banco
- Todas as queries com WHERE/JOIN em colunas nao-PK fazem **Sequential Scan**
- `ON DELETE CASCADE` impossivel
- Dados orfaos nao sao prevenidos

**Recomendacao:**
1. Criar FK constraints para `"000_Empresa"` -> tabela de empresas
2. Criar indices em todas as colunas de FK
3. Criar indices em colunas frequentemente filtradas (datas, status, codigos)

---

## 5. CRITICAL -- Row Level Security (RLS)

**Regra violada:** `security-rls-basics`

| Aspecto | Status |
|---|---|
| `ENABLE ROW LEVEL SECURITY` | **100% das tabelas** |
| Policies RLS definidas | **0 policies nos arquivos analisados** |

**Impacto:** RLS habilitado sem policies = **acesso bloqueado por padrao para roles nao-owner**. Se policies existem em outro lugar, este ponto e informativo. Se nao existem, nenhum usuario (exceto o owner) pode ler/escrever dados.

**Recomendacao:** Definir policies para cada tabela, idealmente baseadas em `auth.uid()` ou tenant ID via `"000_Empresa"`.

---

## 6. HIGH -- Constraints (NOT NULL e CHECK)

**Regra violada:** `schema-constraints`

| Problema | Abrangencia |
|---|---|
| Apenas `"unique_id"` tem `NOT NULL` | **100% das tabelas** |
| Todas as colunas de negocio sao nullable | **100%** |
| Zero CHECK constraints | **100%** |

**Impacto:** Qualquer coluna pode ser NULL, mesmo quando logicamente obrigatoria (`"000_Empresa"`, `"Creation Date"`). Nenhuma validacao no nivel do banco.

**Recomendacao:**
- `NOT NULL` em: `"000_Empresa"`, `"Creation Date"`, campos obrigatorios de negocio
- `CHECK` constraints: scores NPS (1-10), status validos, valores >= 0

---

## 7. HIGH -- Seguranca de Credenciais

| Tabela | Problema |
|---|---|
| `DB073_RF_INFO_FISCAL` | Senha de certificado digital, API tokens/secrets em texto plano |
| `DB107_API-KEYS` | Consumer Key e Consumer Secret em texto plano |
| `DB108_API-LOG` | Authorization headers e secrets logados em texto plano |
| `DB118_NFSE_INFO_FISCAL` | Login, senha e token em texto plano |

**Recomendacao:** Usar Supabase Vault (`pgsodium`) para criptografar segredos em repouso, ou mover credenciais para um secret manager externo.

---

## Resumo Executivo por Prioridade

| Prioridade | Categoria | Score | Status |
|---|---|---|---|
| 1 | **Query Performance** (indices) | 0/10 | Zero indices, tudo Seq Scan |
| 2 | **Security & RLS** | 3/10 | RLS habilitado mas sem policies; credenciais em texto plano |
| 3 | **Schema Design** (tipos, PKs, constraints) | 1/10 | PKs text, tipos errados, zero constraints |
| 4 | **Naming Convention** | 0/10 | Zero tabelas seguem snake_case |
| 5 | **Referential Integrity** (FKs) | 0/10 | Zero foreign keys |

---

## 8. HIGH -- Colunas Tipo Lista e Tabelas Associativas

**Regra violada:** Normalizacao relacional -- listas devem ser tabelas associativas (junction tables)

No Bubble.io, relacionamentos muitos-para-muitos sao armazenados como listas de IDs serializadas em uma unica coluna `text`. No Postgres, esses relacionamentos devem ser representados por **tabelas associativas** com foreign keys e indices.

### 8.1 Inventario de Colunas Tipo Lista

Foram identificadas **~96 colunas** que armazenam listas em **26 tabelas**. Todas sao do tipo `text` (exceto 6 `jsonb` em DB099/DB108).

#### Tabelas com maior concentracao de listas

| Tabela | Qtd Colunas Lista | Contexto |
|---|---|---|
| `DB082_TREL_TAREFA_MANUT` | 18 | Checklists, pecas, servicos, financeiro |
| `DB029_LAN_ATENDIMENTO` | 10 | Produtos, pagamentos, termos |
| `DB032_LAN_GARANTIA` | 9 | Produtos problema/vendidos, avarias |
| `DB038_LAN_PRE_VENDA` | 8 | Produtos (venda/troca/brinde), pagamentos |
| `DB014_CONF_NEW_PERMISSAO` | 10 | Permissoes por modulo |
| `DB016_CLI_CLIENTE` | 6 | Empresas, etiquetas, atendimentos |
| `User` | 4 | Empresas vinculadas, filas, instancias, dispositivos |
| `DB056_LAN_NF` | 3 | Produtos, servicos, pagamentos |
| `DB040_LAN_SIMULACOES` | 3 | Pagamentos, trocas, vendas simuladas |
| `DB079_TREL_PROJETO` | 3 | Membros, tarefas |
| `DB025_FIN_HISTORICO_CAIXA` | 3 | Produtos por tipo transacao |
| `DB033_LAN_INICIANTE_ATE` | 3 | Pagamentos, produtos |
| `DB017_COM_COMPRA` | 2 | Produtos comprados, financeiro |
| `DB002_ACESSO` | 2 | Empresas, dispositivos |
| `DB002_EMPRESAS` | 2 | Empresas, dispositivos |
| `DB102_NOTIFICACOES` | 2 | Lido por, visivel por (usuarios) |
| `DB099_FORMS` | 5 (jsonb) | Dados estruturados |
| Outras (8 tabelas) | 1 cada | Diversos |

#### Inventario completo por coluna

**DB002_ACESSO / DB002_EMPRESAS:**
- `"003_EmpresasAcesso"` -- Lista de IDs de empresas com acesso -> `DB002_EMPRESAS`
- `"050_Dispositivos"` -- Lista de dispositivos -> `Device`

**DB004_CHECKLIST:**
- `"004_ListaItens"` -- Lista de itens do checklist

**DB011_CONF_FUNCOES:**
- `"002_PERMISSAO"` -- Lista de IDs de permissoes -> `DB014_CONF_NEW_PERMISSAO`

**DB014_CONF_NEW_PERMISSAO:**
- `"003_HOME-PERM"` a `"012_CONF-PERM"` -- 10 colunas com listas de permissoes granulares por modulo

**DB016_CLI_CLIENTE:**
- `"027_ETIQUETAS]"` -- Lista de etiquetas/tags -> `DB006_CONF_ETIQUETAS`
- `"030_ATENDIMENTOS-VINCULADOS"` -- Lista de atendimentos -> `DB029_LAN_ATENDIMENTO`
- `"033_VINCULADOS"` -- Lista de OS vinculadas -> `DB082_TREL_TAREFA_MANUT`
- `"041_Credito Historico de entradas"` -- Lista de creditos entrada -> `DB030_LAN_CAP_CAR`
- `"042_Credito Historico de saidas"` -- Lista de creditos saida -> `DB030_LAN_CAP_CAR`

**DB017_COM_COMPRA:**
- `"013_ProdutosComprados"` -- Lista de produtos -> `DB062_PROD_PRODUTO`
- `"029_CAP-CAR"` -- Lista de registros financeiros -> `DB030_LAN_CAP_CAR`

**DB023_EMP_EMPREST_UM:**
- `"014_EMP_Produtos"` -- Lista de produtos emprestados -> `DB062_PROD_PRODUTO`

**DB025_FIN_HISTORICO_CAIXA:**
- `"005_PRODUTOS_Compras"` -- Lista de produtos (compras) -> `DB062_PROD_PRODUTO`
- `"006_PRODUTOS_Trocas"` -- Lista de produtos (trocas) -> `DB062_PROD_PRODUTO`
- `"007_PRODUTOS_Vendas"` -- Lista de produtos (vendas) -> `DB062_PROD_PRODUTO`

**DB029_LAN_ATENDIMENTO:**
- `"032_Termos-selecionados"` -- Lista de termos -> `DB007_CONF_TERMO_GARANTIA`
- `"037_BRI_PRODUTOS"` -- Lista de produtos brinde -> `DB062_PROD_PRODUTO`
- `"049_FISCAL_PAGAMENTO"` -- Lista de pagamentos fiscais -> `DB030_LAN_CAP_CAR`
- `"066_TRO_PRODUTOS"` -- Lista de produtos troca -> `DB062_PROD_PRODUTO`
- `"069_VEN_PRODUTOS"` -- Lista de produtos venda -> `DB062_PROD_PRODUTO`
- `"079_z_CAP_CAR_Pagamento"` -- Lista de pagamentos -> `DB030_LAN_CAP_CAR`
- `"080_z_CAP_Custos"` -- Lista de custos -> `DB030_LAN_CAP_CAR`
- `"081_z_CAR_Pagamento"` -- Lista de recebimentos -> `DB030_LAN_CAP_CAR`
- `"084_COD_GARANTIA"` -- Lista de garantias -> `DB032_LAN_GARANTIA`

**DB032_LAN_GARANTIA:**
- `"017_Avarias"` -- Lista de avarias -> `DB018_CAD_AVARIA`
- `"019_Custo Produto Problema (Lista)"` -- Lista de custos (valores)
- `"020_Preco Preoduto Problema (Lista)"` -- Lista de precos (valores)
- `"025_Produto Problema (Lista)"` -- Lista de produtos -> `DB062_PROD_PRODUTO`
- `"027_Produto Problema Original (Lista)"` -- Lista de produtos -> `DB062_PROD_PRODUTO`
- `"032_Custo Produto Inicial Vendido (Lista)"` -- Lista de custos (valores)
- `"034_Custo Produto Vendido (Lista)"` -- Lista de custos (valores)
- `"036_Preco Produto Vendido (Lista)"` -- Lista de precos (valores)
- `"038_Produto Vendido (Lista)"` -- Lista de produtos -> `DB062_PROD_PRODUTO`

**DB033_LAN_INICIANTE_ATE:**
- `"007_ATE_Pagamento"` -- Lista de pagamentos -> `DB030_LAN_CAP_CAR`
- `"008_ATE_TRO_Produtos"` -- Lista de produtos troca -> `DB062_PROD_PRODUTO`
- `"009_ATE_VEN_Produtos"` -- Lista de produtos venda -> `DB062_PROD_PRODUTO`

**DB038_LAN_PRE_VENDA:**
- `"014_Lista Produtos Troca"` / `"015_...Inicial"` -- Lista de produtos troca -> `DB062_PROD_PRODUTO`
- `"016_Lista Produtos Venda"` / `"017_...Inicial"` -- Lista de produtos venda -> `DB062_PROD_PRODUTO`
- `"018_Lista Produtos Brinde"` / `"019_...Inicial"` -- Lista de produtos brinde -> `DB062_PROD_PRODUTO`
- `"024_Pagamentos realizados"` -- Lista de pagamentos -> `DB030_LAN_CAP_CAR`
- `"038_Lista Atualizacoes"` -- Lista de atualizacoes -> `DB103_LAN_ATUALIZACOES_PREVENDA`

**DB040_LAN_SIMULACOES:**
- `"003_BD_Pagamentos"` -- Lista de pagamentos simulados -> `DB075_SIM_PAGAMENTO`
- `"004_BD_Troca"` -- Lista de trocas simuladas -> `DB076_SIM_TROCA`
- `"005_BD_Venda"` -- Lista de vendas simuladas -> `DB077_SIM_VENDA`

**DB041_LAN_SUPORTE:**
- `"010_COMENTARIOS-TICKET]"` -- Lista de comentarios -> `DB078_TREL_COMENT_TAREFA`

**DB042_LAN_TRANSFERENCIAS:**
- `"003_EmpresasView"` -- Lista de empresas com visibilidade -> `DB002_EMPRESAS`

**DB056_LAN_NF:**
- `"030_PRODUTOS"` -- Lista de produtos na NF -> `DB062_PROD_PRODUTO`
- `"031_Servicos"` -- Lista de servicos -> `DB122_NFSE_SERVICOS`
- `"040_PAGAMENTO-CAP"` -- Lista de pagamentos -> `DB030_LAN_CAP_CAR`

**DB062_PROD_PRODUTO:**
- `"016_CAD_Especificacoes"` -- Lista de especificacoes
- `"027_CODIGO-ASSOCIADO"` -- Lista de produtos associados -> `DB062_PROD_PRODUTO` (auto-ref)

**DB079_TREL_PROJETO:**
- `"[02] - MEMBROS"` -- Lista de membros -> `User`
- `"[06] - TAREFAS-MANUT"` -- Lista de tarefas manutencao -> `DB082_TREL_TAREFA_MANUT`
- `"[07] - TAREFAS-CRM"` -- Lista de tarefas CRM -> `DB081_TREL_TAREFA_CRM`

**DB081_TREL_TAREFA_CRM:**
- `"[08] - LEAD-Comentarios"` -- Lista de comentarios -> `DB078_TREL_COMENT_TAREFA`

**DB082_TREL_TAREFA_MANUT:**
- `"[01] - CHECKLIST"` -- Lista de checklist items -> `DB999_VERIF_TASK_CHECKLIST`
- `"[03] - COMENTARIOS"` -- Lista de comentarios -> `DB078_TREL_COMENT_TAREFA`
- `"[66] - CHECKLIST_ORIGEM"` -- Lista de checklist origem -> `DB004_CHECKLIST`
- `"[67] - CHECK_PROBLEMAS"` / `"...INICIAL"` -- Lista de checklist problemas
- `"[71] - LISTA_PRECOS_SERVICOS"` -- Lista de precos de servicos (valores)
- `"[71] - LISTA_SERVICO"` / `"SERVICOS"` -- Lista de servicos
- `"[99] - CHECKLIST POSTERIOR"` / `"...LISTA"` / `"...ORIGEM"` -- Listas de checklist
- `"[99] - Lista Custo_Pecas_CI"` / `"...SI"` -- Listas de custos de pecas
- `"[99] - Lista_Pecas_CI_Utilizadas"` / `"...SI..."` -- Listas de pecas -> `DB062_PROD_PRODUTO`
- `"[99] - Pecas_CI_Utilizadas"` / `"...SI..."` -- Listas de pecas -> `DB062_PROD_PRODUTO`
- `"Z - Lista_CAP-CAR"` -- Lista de registros financeiros -> `DB030_LAN_CAP_CAR`

**DB087_CRM_INSTANCIAS:**
- `"10 - usuariosComAcesso"` -- Lista de usuarios -> `User`

**DB092_CRM_FUNIL:**
- `"03 - EtapasFunil"` -- Lista de etapas do funil -> `DB088_CRM_ETAPAS`

**DB095_METAS-GERAIS:**
- `"05 - MetasColaborador"` -- Lista de metas -> `DB096_METAS_COLABORADOR`

**DB102_NOTIFICACOES:**
- `"02 - [LIDO_POR]"` -- Lista de usuarios que leram -> `User`
- `"05 - [VISUALIZAVEL_SOMENTE_POR]"` -- Lista de usuarios com acesso -> `User`

**DB123_CHECK_LIST_AVALIACAO:**
- `"02 - APROVADOS"` -- Lista de itens aprovados
- `"03 - REPROVADOS"` -- Lista de itens reprovados

**DB124_CARTEIRA:**
- `"[004] - RECARGAS"` -- Lista de recargas

**DB126_DEVOCIONAL:**
- `"010_keywords"` -- Lista de keywords/tags

**DB999_VERIF_TASK_CHECKLIST:**
- `"[04] - LISTA-TXT"` -- Lista de itens do checklist

**User:**
- `"00_EMP_Vinculadas"` -- Lista de empresas -> `DB002_EMPRESAS`
- `"06 - filasUsuario"` -- Lista de filas CRM
- `"09 - instancias"` -- Lista de instancias -> `DB087_CRM_INSTANCIAS`
- `"99_Dispositivos"` -- Lista de dispositivos -> `Device`

---

### 8.2 Tabelas Associativas Recomendadas

Abaixo estao as tabelas associativas (junction tables) que devem ser criadas para substituir as colunas tipo lista. Organizadas por dominio de negocio.

#### A. Acesso e Multi-Tenancy

```sql
-- A1: Usuario <-> Empresas com acesso
create table usuario_empresa (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id),
  empresa_id bigint not null references empresas(id),
  created_at timestamptz not null default now(),
  unique(usuario_id, empresa_id)
);
create index idx_usuario_empresa_usuario on usuario_empresa(usuario_id);
create index idx_usuario_empresa_empresa on usuario_empresa(empresa_id);

-- A2: Usuario <-> Dispositivos
create table usuario_dispositivo (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id),
  dispositivo_id bigint not null references dispositivos(id),
  created_at timestamptz not null default now(),
  unique(usuario_id, dispositivo_id)
);

-- A3: Usuario <-> Instancias CRM (WhatsApp)
create table usuario_instancia (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id),
  instancia_id bigint not null references crm_instancias(id),
  created_at timestamptz not null default now(),
  unique(usuario_id, instancia_id)
);

-- A4: Usuario <-> Filas CRM
create table usuario_fila (
  id bigint generated always as identity primary key,
  usuario_id bigint not null references usuarios(id),
  fila text not null,
  created_at timestamptz not null default now()
);

-- A5: Transferencia <-> Empresas com visibilidade
create table transferencia_empresa_view (
  id bigint generated always as identity primary key,
  transferencia_id bigint not null references transferencias(id),
  empresa_id bigint not null references empresas(id),
  unique(transferencia_id, empresa_id)
);
```

#### B. Produtos em Transacoes (padrao mais recorrente)

```sql
-- B1: Atendimento <-> Produtos (por tipo: venda, troca, brinde)
create table atendimento_produto (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id),
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda', 'troca', 'brinde')),
  quantidade integer not null default 1,
  preco numeric(10,2),
  desconto numeric(10,2),
  created_at timestamptz not null default now()
);
create index idx_atendimento_produto_ate on atendimento_produto(atendimento_id);
create index idx_atendimento_produto_prod on atendimento_produto(produto_id);

-- B2: Pre-Venda <-> Produtos (por tipo e snapshot)
create table pre_venda_produto (
  id bigint generated always as identity primary key,
  pre_venda_id bigint not null references pre_vendas(id),
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda', 'troca', 'brinde')),
  is_snapshot boolean not null default false,
  quantidade integer not null default 1,
  preco numeric(10,2),
  created_at timestamptz not null default now()
);
create index idx_pre_venda_produto_pv on pre_venda_produto(pre_venda_id);

-- B3: Compra <-> Produtos
create table compra_produto (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id),
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  custo numeric(10,2),
  created_at timestamptz not null default now()
);

-- B4: Nota Fiscal <-> Produtos
create table nf_produto (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id),
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  valor numeric(10,2),
  created_at timestamptz not null default now()
);

-- B5: Nota Fiscal <-> Servicos
create table nf_servico (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id),
  servico_id bigint not null references nfse_servicos(id),
  valor numeric(10,2),
  created_at timestamptz not null default now()
);

-- B6: Emprestimo <-> Produtos
create table emprestimo_produto (
  id bigint generated always as identity primary key,
  emprestimo_id bigint not null references emprestimos(id),
  produto_id bigint not null references produtos(id),
  quantidade integer not null default 1,
  created_at timestamptz not null default now()
);

-- B7: Historico Caixa <-> Produtos (por tipo transacao)
create table historico_caixa_produto (
  id bigint generated always as identity primary key,
  historico_id bigint not null references historico_caixa(id),
  produto_id bigint not null references produtos(id),
  tipo_transacao text not null check (tipo_transacao in ('compra', 'troca', 'venda')),
  created_at timestamptz not null default now()
);

-- B8: Produto <-> Produtos Associados (auto-referencia)
create table produto_associado (
  id bigint generated always as identity primary key,
  produto_id bigint not null references produtos(id),
  produto_associado_id bigint not null references produtos(id),
  unique(produto_id, produto_associado_id),
  check (produto_id <> produto_associado_id)
);

-- B9: Atendimento Iniciante <-> Produtos (por tipo)
create table iniciante_ate_produto (
  id bigint generated always as identity primary key,
  iniciante_ate_id bigint not null references iniciante_atendimentos(id),
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('venda', 'troca')),
  created_at timestamptz not null default now()
);
```

#### C. Financeiro (Pagamentos / Contas a Pagar-Receber)

```sql
-- C1: Atendimento <-> Registros Financeiros (CAP/CAR)
create table atendimento_financeiro (
  id bigint generated always as identity primary key,
  atendimento_id bigint not null references atendimentos(id),
  cap_car_id bigint not null references cap_car(id),
  tipo text not null check (tipo in ('pagamento', 'custo', 'recebimento')),
  created_at timestamptz not null default now()
);
create index idx_atendimento_fin_ate on atendimento_financeiro(atendimento_id);
create index idx_atendimento_fin_cap on atendimento_financeiro(cap_car_id);

-- C2: Pre-Venda <-> Pagamentos
create table pre_venda_pagamento (
  id bigint generated always as identity primary key,
  pre_venda_id bigint not null references pre_vendas(id),
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now()
);

-- C3: Compra <-> Registros Financeiros
create table compra_financeiro (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id),
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now()
);

-- C4: Nota Fiscal <-> Pagamentos
create table nf_pagamento (
  id bigint generated always as identity primary key,
  nf_id bigint not null references notas_fiscais(id),
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now()
);

-- C5: Tarefa Manutencao <-> Registros Financeiros
create table tarefa_manut_financeiro (
  id bigint generated always as identity primary key,
  tarefa_id bigint not null references tarefas_manutencao(id),
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now()
);

-- C6: Atendimento Iniciante <-> Pagamentos
create table iniciante_ate_pagamento (
  id bigint generated always as identity primary key,
  iniciante_ate_id bigint not null references iniciante_atendimentos(id),
  cap_car_id bigint not null references cap_car(id),
  created_at timestamptz not null default now()
);
```

#### D. Garantias

```sql
-- D1: Garantia <-> Produtos (problema e vendidos, com custos/precos)
create table garantia_produto (
  id bigint generated always as identity primary key,
  garantia_id bigint not null references garantias(id),
  produto_id bigint not null references produtos(id),
  tipo text not null check (tipo in ('problema', 'problema_original', 'vendido')),
  custo numeric(10,2),
  custo_inicial numeric(10,2),
  preco numeric(10,2),
  created_at timestamptz not null default now()
);

-- D2: Garantia <-> Avarias
create table garantia_avaria (
  id bigint generated always as identity primary key,
  garantia_id bigint not null references garantias(id),
  avaria_id bigint not null references avarias(id),
  created_at timestamptz not null default now()
);
```

#### E. Ordem de Servico / Tarefas

```sql
-- E1: Tarefa Manutencao <-> Checklist Items
create table tarefa_checklist (
  id bigint generated always as identity primary key,
  tarefa_id bigint not null references tarefas_manutencao(id),
  checklist_item_id bigint not null references checklist_items(id),
  tipo text not null check (tipo in ('principal', 'origem', 'problema', 'posterior')),
  is_snapshot boolean not null default false,
  created_at timestamptz not null default now()
);

-- E2: Tarefa Manutencao <-> Pecas Utilizadas
create table tarefa_peca (
  id bigint generated always as identity primary key,
  tarefa_id bigint not null references tarefas_manutencao(id),
  produto_id bigint not null references produtos(id),
  origem text not null check (origem in ('interna', 'externa')),
  custo numeric(10,2),
  quantidade integer not null default 1,
  created_at timestamptz not null default now()
);

-- E3: Tarefa Manutencao <-> Servicos
create table tarefa_servico (
  id bigint generated always as identity primary key,
  tarefa_id bigint not null references tarefas_manutencao(id),
  descricao text not null,
  preco numeric(10,2),
  created_at timestamptz not null default now()
);

-- E4: Projeto <-> Membros
create table projeto_membro (
  id bigint generated always as identity primary key,
  projeto_id bigint not null references projetos(id),
  usuario_id bigint not null references usuarios(id),
  unique(projeto_id, usuario_id),
  created_at timestamptz not null default now()
);

-- E5: Projeto <-> Tarefas (ja existe relacao via FK na tarefa, mas se for M:N)
-- Nota: Se cada tarefa pertence a um unico projeto, basta uma FK em tarefas.
-- Se M:N, criar tabela associativa.
```

#### F. Permissoes

```sql
-- F1: Funcao <-> Permissoes por Modulo
create table funcao_permissao (
  id bigint generated always as identity primary key,
  funcao_id bigint not null references funcoes(id),
  modulo text not null check (modulo in (
    'home', 'cadastro', 'operacoes', 'financeiro', 'relatorios',
    'utilidades', 'fiscal', 'adicional', 'assistencia', 'configuracoes'
  )),
  permissao text not null,
  created_at timestamptz not null default now(),
  unique(funcao_id, modulo, permissao)
);
create index idx_funcao_permissao_funcao on funcao_permissao(funcao_id);
```

#### G. CRM e Comunicacao

```sql
-- G1: Funil <-> Etapas (ordem das etapas no funil)
create table funil_etapa (
  id bigint generated always as identity primary key,
  funil_id bigint not null references funis(id),
  etapa_id bigint not null references crm_etapas(id),
  ordem integer not null,
  unique(funil_id, etapa_id),
  created_at timestamptz not null default now()
);

-- G2: Instancia CRM <-> Usuarios com acesso
-- (coberto por A3: usuario_instancia)

-- G3: Metas Gerais <-> Metas Colaborador
-- Nota: Provavelmente 1:N (cada meta_colaborador pertence a uma meta_geral).
-- Adicionar FK em metas_colaborador -> metas_gerais ao inves de tabela associativa.
```

#### H. Clientes

```sql
-- H1: Cliente <-> Etiquetas/Tags
create table cliente_etiqueta (
  id bigint generated always as identity primary key,
  cliente_id bigint not null references clientes(id),
  etiqueta text not null,
  created_at timestamptz not null default now(),
  unique(cliente_id, etiqueta)
);

-- H2: Cliente <-> Atendimentos Vinculados
-- Nota: Provavelmente 1:N (cada atendimento ja tem campo cliente).
-- Nao necessita tabela associativa se atendimento ja referencia cliente via FK.

-- H3: Cliente <-> Historico de Creditos
create table cliente_credito (
  id bigint generated always as identity primary key,
  cliente_id bigint not null references clientes(id),
  cap_car_id bigint not null references cap_car(id),
  tipo text not null check (tipo in ('entrada', 'saida')),
  created_at timestamptz not null default now()
);
```

#### I. Notificacoes

```sql
-- I1: Notificacao <-> Usuarios (leitura e visibilidade)
create table notificacao_usuario (
  id bigint generated always as identity primary key,
  notificacao_id bigint not null references notificacoes(id),
  usuario_id bigint not null references usuarios(id),
  tipo text not null check (tipo in ('lido', 'visivel')),
  created_at timestamptz not null default now(),
  unique(notificacao_id, usuario_id, tipo)
);
```

#### J. Simulacoes

```sql
-- J1-J3: Ja existem tabelas filhas (DB075, DB076, DB077)
-- Basta adicionar FK nessas tabelas:
--   sim_pagamento.simulacao_id -> simulacoes(id)
--   sim_troca.simulacao_id -> simulacoes(id)
--   sim_venda.simulacao_id -> simulacoes(id)
-- E remover as colunas de lista da tabela simulacoes.
```

#### K. Especificacoes e Tags

```sql
-- K1: Produto <-> Especificacoes
create table produto_especificacao (
  id bigint generated always as identity primary key,
  produto_id bigint not null references produtos(id),
  chave text not null,
  valor text not null,
  created_at timestamptz not null default now()
);

-- K2: Devocional <-> Keywords
create table devocional_keyword (
  id bigint generated always as identity primary key,
  devocional_id bigint not null references devocionais(id),
  keyword text not null,
  created_at timestamptz not null default now()
);
```

---

### 8.3 Resumo das Tabelas Associativas

| # | Tabela Associativa | Substitui colunas em | Relacao |
|---|---|---|---|
| A1 | `usuario_empresa` | User, DB002_ACESSO, DB002_EMPRESAS | Usuario <-> Empresa |
| A2 | `usuario_dispositivo` | User, DB002 | Usuario <-> Dispositivo |
| A3 | `usuario_instancia` | User, DB087 | Usuario <-> Instancia CRM |
| A4 | `usuario_fila` | User | Usuario <-> Fila CRM |
| A5 | `transferencia_empresa_view` | DB042 | Transferencia <-> Empresa |
| B1 | `atendimento_produto` | DB029 (3 colunas) | Atendimento <-> Produto |
| B2 | `pre_venda_produto` | DB038 (6 colunas) | Pre-Venda <-> Produto |
| B3 | `compra_produto` | DB017 | Compra <-> Produto |
| B4 | `nf_produto` | DB056 | NF <-> Produto |
| B5 | `nf_servico` | DB056 | NF <-> Servico |
| B6 | `emprestimo_produto` | DB023 | Emprestimo <-> Produto |
| B7 | `historico_caixa_produto` | DB025 (3 colunas) | Hist. Caixa <-> Produto |
| B8 | `produto_associado` | DB062 | Produto <-> Produto |
| B9 | `iniciante_ate_produto` | DB033 (2 colunas) | Inic. Atend. <-> Produto |
| C1 | `atendimento_financeiro` | DB029 (3 colunas) | Atendimento <-> CAP/CAR |
| C2 | `pre_venda_pagamento` | DB038 | Pre-Venda <-> CAP/CAR |
| C3 | `compra_financeiro` | DB017 | Compra <-> CAP/CAR |
| C4 | `nf_pagamento` | DB056 | NF <-> CAP/CAR |
| C5 | `tarefa_manut_financeiro` | DB082 | Tarefa Manut <-> CAP/CAR |
| C6 | `iniciante_ate_pagamento` | DB033 | Inic. Atend. <-> CAP/CAR |
| D1 | `garantia_produto` | DB032 (6 colunas) | Garantia <-> Produto |
| D2 | `garantia_avaria` | DB032 | Garantia <-> Avaria |
| E1 | `tarefa_checklist` | DB082 (6 colunas) | Tarefa <-> Checklist |
| E2 | `tarefa_peca` | DB082 (4 colunas) | Tarefa <-> Peca/Produto |
| E3 | `tarefa_servico` | DB082 (3 colunas) | Tarefa <-> Servico |
| E4 | `projeto_membro` | DB079 | Projeto <-> Usuario |
| F1 | `funcao_permissao` | DB014 (10 colunas), DB011 | Funcao <-> Permissao |
| G1 | `funil_etapa` | DB092 | Funil <-> Etapa |
| H1 | `cliente_etiqueta` | DB016 | Cliente <-> Etiqueta |
| H3 | `cliente_credito` | DB016 (2 colunas) | Cliente <-> Credito |
| I1 | `notificacao_usuario` | DB102 (2 colunas) | Notificacao <-> Usuario |
| K1 | `produto_especificacao` | DB062 | Produto <-> Especificacao |
| K2 | `devocional_keyword` | DB126 | Devocional <-> Keyword |

**Total: 33 tabelas associativas** para substituir **~96 colunas tipo lista** em 26 tabelas.

---

### 8.4 Impacto da Normalizacao

| Aspecto | Antes (Bubble.io) | Depois (Normalizado) |
|---|---|---|
| Consulta de produtos de um atendimento | Parse de string delimitada na aplicacao | `SELECT * FROM atendimento_produto WHERE atendimento_id = ?` |
| Integridade referencial | Nenhuma (IDs orfaos possiveis) | FK constraints impedem dados invalidos |
| Performance de busca | Full table scan + parse de texto | Index scan na tabela associativa |
| Contagem de itens | Parse e count no app | `SELECT count(*) FROM atendimento_produto WHERE ...` |
| Filtro por item da lista | Impossivel sem LIKE/regex | `JOIN atendimento_produto ON ... WHERE produto_id = ?` |
| Agregacoes (soma, media) | Impossivel no banco | `SUM(preco)`, `AVG(custo)` direto no SQL |

---

## Conclusao

O schema atual e uma transcricao direta do Bubble.io e **viola praticamente todas as boas praticas** do Supabase/Postgres. E funcional como staging de migracao, mas precisa de uma reestruturacao completa antes de servir como schema de producao.

### Proximos passos sugeridos

1. **Redesenhar o schema** com nomes snake_case, tipos corretos e PKs identity/UUIDv7
2. **Criar script de migracao** que transforma dados do schema legado para o novo
3. **Adicionar FKs e indices** nas colunas de relacionamento e filtro
4. **Definir RLS policies** baseadas em empresa/usuario
5. **Proteger credenciais** com Supabase Vault ou secret manager
6. **Adicionar constraints** NOT NULL e CHECK onde aplicavel
