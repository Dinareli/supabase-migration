# Simulação: retorno prático das tabelas empresas_acesso

Dados de exemplo usados na simulação:

| id | nome      | ativo |
|----|-----------|-------|
| 1  | Loja Alpha| true  |
| 2  | Loja Beta | true  |
| 3  | Loja Gama | true  |
| 4  | Loja Delta| true  |

**Relações em `empresa_empresas_acesso`:**

| empresa_id | empresa_acesso_id |
|------------|-------------------|
| 1          | 2                 |
| 1          | 3                 |
| 2          | 1                 |
| 2          | 4                 |
| 3          | 1                 |

*(Alpha tem acesso a Beta e Gama; Beta tem acesso a Alpha e Delta; Gama tem acesso a Alpha.)*

---

## 1) `SELECT * FROM empresas_lista`

Lista para popular dropdown/select (fonte: tabela empresas, só ativas, ordenadas por nome).

| id | nome       |
|----|------------|
| 1  | Loja Alpha |
| 2  | Loja Beta  |
| 3  | Loja Gama  |
| 4  | Loja Delta |

---

## 2) Lista de empresas_acesso da empresa id = 1 (com nomes)

```sql
SELECT eea.empresa_id, eea.empresa_acesso_id, emp.nome AS empresa_acesso_nome
FROM empresa_empresas_acesso eea
JOIN empresas emp ON emp.id = eea.empresa_acesso_id
WHERE eea.empresa_id = 1
ORDER BY emp.nome;
```

| empresa_id | empresa_acesso_id | empresa_acesso_nome |
|------------|-------------------|---------------------|
| 1          | 2                 | Loja Beta           |
| 1          | 3                 | Loja Gama           |

---

## 3) `SELECT * FROM empresas_com_acesso`

View com o “campo” `empresas_acesso` como array de IDs.

| id | nome       | ativo | empresas_acesso |
|----|------------|-------|-----------------|
| 1  | Loja Alpha | true  | {2, 3}          |
| 2  | Loja Beta  | true  | {1, 4}          |
| 3  | Loja Gama  | true  | {1}             |
| 4  | Loja Delta | true  | {}              |

*(Arrays em ordem por nome da empresa de acesso.)*

---

## 4) Contagem de empresas_acesso por empresa

```sql
SELECT e.id, e.nome,
       (SELECT count(*) FROM empresa_empresas_acesso eea WHERE eea.empresa_id = e.id) AS qtd_empresas_acesso
FROM empresas e
WHERE e.ativo = true
ORDER BY e.nome;
```

| id | nome       | qtd_empresas_acesso |
|----|------------|---------------------|
| 1  | Loja Alpha | 2                   |
| 2  | Loja Beta  | 2                   |
| 3  | Loja Gama  | 1                   |
| 4  | Loja Delta | 0                   |

---

## Como rodar a simulação no Postgres

Se tiver `psql` ou Supabase local:

```bash
# Com conexão ao banco (ajuste a connection string)
psql "postgresql://..." -f scripts/simulacao_empresas_acesso_standalone.sql
```

O arquivo `simulacao_empresas_acesso_standalone.sql` usa só CTEs e não depende das tabelas reais; ele “simula” as tabelas e mostra o mesmo formato de retorno acima.
