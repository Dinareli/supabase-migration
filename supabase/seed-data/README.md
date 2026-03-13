# Seed data (supabase/migrations)

Dados convertidos do Bubble para o formato das tabelas em **`supabase/migrations/`** (00002 empresas, 00016 assinaturas). Headers e tipos alinhados ao schema atual do Supabase para evitar conflito na importação.

## Arquivos

| Arquivo | Origem | Script de conversão |
|---------|--------|----------------------|
| **empresas.csv** | `bubble-export/data/DB002_EMPRESAS.csv` | `scripts/convert_empresas.py` |
| **assinaturas.csv** | `bubble-export/data/DB001_ASSINATURAS.csv` | `scripts/convert_assinaturas.py` |
| **seed_empresas.sql** | — | Gerado por `seed_to_sql.py` (parte 1; rodar primeiro) |
| **seed_assinaturas.sql** | — | Gerado por `seed_to_sql.py` (parte 2; rodar depois de empresas) |
| **seed_empresas_assinaturas.sql** | — | Arquivo único (empresas + assinaturas); use com psql se o Editor der "query too large") |

A coluna **empresa_nome** em assinaturas.csv é usada na geração do SQL para resolver a FK `empresa_id` (subquery por `nome`).

## Ordem de carga (FKs)

1. empresas  
2. assinaturas (e demais tabelas que referenciam empresas)

---

## Como importar no Supabase (dados já tratados)

### Pré-requisito

- Projeto Supabase criado e **migrations já aplicadas** (tabelas `empresas` e `assinaturas` existem).

### Opção A – Executar o SQL de seed (recomendado)

1. **Gerar o SQL** (se ainda não tiver):
   ```bash
   py -3 scripts/seed_to_sql.py
   ```
   Isso cria `seed_empresas_assinaturas.sql`. Para evitar "query too large" no SQL Editor, use os arquivos separados:

2. No **Supabase Dashboard**: **SQL Editor** → **New query**.

3. **Primeiro:** abra `seed_empresas.sql`, copie todo o conteúdo, cole no editor e clique em **Run** (insere as empresas).

4. **Depois:** nova query; abra `seed_assinaturas.sql`, copie todo o conteúdo, cole e clique em **Run** (insere as assinaturas; `empresa_id` é resolvido por nome).

   Se preferir o arquivo único, use `seed_empresas_assinaturas.sql` conectando ao banco direto (psql ou outro cliente), pois o SQL Editor tem limite de tamanho.

### Opção B – Importar CSV pela interface

1. **Empresas:** Table Editor → tabela **empresas** → **Import data from CSV** → escolha `supabase/seed-data/empresas.csv` (encoding UTF-8, delimiter vírgula, primeira linha = cabeçalho).

2. **Assinaturas:** o CSV de assinaturas tem `empresa_nome`, não `empresa_id`. Use o SQL gerado pela Opção A apenas para as assinaturas, ou rode o script `seed_to_sql.py` e execute no SQL Editor a parte dos INSERT de assinaturas (após já ter importado empresas).

### Reexecutar conversões

```bash
py -3 scripts/convert_empresas.py
py -3 scripts/convert_assinaturas.py
py -3 scripts/seed_to_sql.py
```
