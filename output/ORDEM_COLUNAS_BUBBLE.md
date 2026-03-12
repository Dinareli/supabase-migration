# Ordem das colunas por tabela (1:1 com Bubble)

Para migração correta dos dados, cada tabela Supabase deve ter:
- `id` (PK)
- `bubble_unique_id` (text unique)
- **N colunas na mesma ordem** dos campos 1..N do schema Bubble (bubble-schema.md)
- Opcional: `created_at`, `updated_at`, `created_by` ao final

Referência: **bubble-schema.md** (cada `## DBxxx` lista os campos na ordem 1..N).

## Tabelas já reordenadas no bubble_supabase.sql

As tabelas abaixo já têm comentário `-- Colunas na ordem DBxxx (1-N)` e colunas na ordem do Bubble:

| Bubble | Supabase | Campos |
|--------|----------|--------|
| DB003_LOG | logs_atividade | 17 |
| DB004_CHECKLIST | checklists | 6 |
| DB005_CONF_VINCULACAO | conf_vinculacoes | 7 |
| DB006_CONF_ETIQUETAS | conf_etiquetas | 22 |
| DB007_CONF_TERMO_GARANTIA | conf_termos_garantia | 6 |
| DB008_CONF_CHAVE PIX | conf_chaves_pix | 7 |
| DB009_CONF_CIDADES_BR | cidades_br | 7 |
| DB010_CONF_CONTA | contas | 5 |
| DB011_CONF_FUNCOES | funcoes | 3 |
| DB012_CONF_MAQUINA | maquinas_cartao | 9 |
| DB057_PROD_CATEGORIA | categorias | 5 |
| DB058_PROD_COR | cores | 5 |
| DB059_PROD_GRUPO | grupos | 4 |
| DB060_PROD_LOCAL | locais_estoque | 5 |
| DB061_PROD_MARCA | marcas | 5 |
| DB062_PROD_PRODUTO | produtos | 38 |
| DB031_LAN_ESTOQUE | lancamento_estoque | 96 (+ id + bubble_unique_id = 98 colunas) |
| DB001_ASSINATURA | assinaturas | 27 |
| DB002_EMPRESAS | empresas | 53 |
| DB016_CLI_CLIENTE | clientes | 43 |
| DB017_COM_COMPRA | compras | 33 |
| DB029_LAN_ATENDIMENTO | atendimentos | 87 |
| DB056_LAN_NF | notas_fiscais | 60 |

## Demais tabelas

Para cada uma das outras tabelas no bubble_supabase.sql que correspondem a uma tabela Bubble:

1. Abra **bubble-schema.md** e localize a seção `## DBxxx_NOME` correspondente.
2. A tabela mostra `| # | Field | Type |` — a ordem das linhas é a ordem 1, 2, 3, … N.
3. Reordene as colunas do `create table` no bubble_supabase.sql para: `id`, `bubble_unique_id`, depois as colunas na mesma ordem 1..N (mapeando o nome Bubble para o nome snake_case já existente na tabela).
4. Adicione no topo do `create table` o comentário: `-- Colunas na ordem DBxxx_NOME (1-N) para migracao 1:1`.

## Mapeamento Bubble table -> Supabase table (resumo)

Ver também o bloco de comentários no final do bubble_supabase.sql (MAPEAMENTO LEGADO -> NOVO).
