-- ============================================================================
-- SIMULAÇÃO STANDALONE: retorno das estruturas empresas_acesso
-- ============================================================================
-- Usa apenas CTEs (WITH). Não depende das tabelas reais. Rode em qualquer Postgres.
-- ============================================================================

WITH
-- Dados fictícios de empresas
empresas AS (
  SELECT * FROM (VALUES
    (1::bigint, 'Loja Alpha', true),
    (2::bigint, 'Loja Beta', true),
    (3::bigint, 'Loja Gama', true),
    (4::bigint, 'Loja Delta', true)
  ) AS t(id, nome, ativo)
),
-- Relação empresas_acesso: quem tem acesso a quem
empresa_empresas_acesso AS (
  SELECT * FROM (VALUES
    (1::bigint, 2::bigint),
    (1::bigint, 3::bigint),
    (2::bigint, 1::bigint),
    (2::bigint, 4::bigint),
    (3::bigint, 1::bigint)
  ) AS t(empresa_id, empresa_acesso_id)
),
-- Equivalente à view empresas_lista
empresas_lista AS (
  SELECT id, nome FROM empresas WHERE ativo = true ORDER BY nome
),
-- Equivalente à view empresas_com_acesso (array por empresa)
empresas_com_acesso AS (
  SELECT
    e.id,
    e.nome,
    e.ativo,
    coalesce(
      (SELECT array_agg(eea.empresa_acesso_id ORDER BY emp.nome)
       FROM empresa_empresas_acesso eea
       JOIN empresas emp ON emp.id = eea.empresa_acesso_id
       WHERE eea.empresa_id = e.id),
      '{}'
    ) AS empresas_acesso
  FROM empresas e
)
-- ========== SAÍDAS ==========
SELECT '1) empresas_lista (dropdown)' AS simulacao;
SELECT * FROM empresas_lista;

SELECT '2) empresa_empresas_acesso + nomes (empresa 1)' AS simulacao;
SELECT eea.empresa_id, eea.empresa_acesso_id, emp.nome AS empresa_acesso_nome
FROM empresa_empresas_acesso eea
JOIN empresas emp ON emp.id = eea.empresa_acesso_id
WHERE eea.empresa_id = 1
ORDER BY emp.nome;

SELECT '3) empresas_com_acesso (campo empresas_acesso)' AS simulacao;
SELECT id, nome, ativo, empresas_acesso FROM empresas_com_acesso ORDER BY id;

SELECT '4) contagem por empresa' AS simulacao;
SELECT e.id, e.nome,
       (SELECT count(*) FROM empresa_empresas_acesso eea WHERE eea.empresa_id = e.id) AS qtd_empresas_acesso
FROM empresas e
WHERE e.ativo = true
ORDER BY e.nome;
