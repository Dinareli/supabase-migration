-- ============================================================================
-- SIMULAÇÃO: retorno prático das tabelas/views empresas_acesso
-- ============================================================================
-- Dados fictícios apenas para demonstrar o formato dos resultados.
-- Execute em um banco que já tenha as tabelas empresas, empresa_empresas_acesso
-- e as views empresas_lista e empresas_com_acesso (migration 00015).
-- ============================================================================

-- Dados de exemplo (descomente e rode ANTES se estiver em banco vazio de empresas)
/*
INSERT INTO empresas (nome, ativo) VALUES
  ('Loja Alpha', true),
  ('Loja Beta', true),
  ('Loja Gama', true),
  ('Loja Delta', true)
RETURNING id, nome;
-- Assumindo ids 1,2,3,4 respectivamente:

INSERT INTO empresa_empresas_acesso (empresa_id, empresa_acesso_id) VALUES
  (1, 2), (1, 3),   -- Alpha tem acesso a Beta e Gama
  (2, 1), (2, 4),   -- Beta tem acesso a Alpha e Delta
  (3, 1);           -- Gama tem acesso a Alpha
*/

-- ========== 1) VIEW empresas_lista (fonte para dropdown) ==========
-- SELECT * FROM empresas_lista;
--
-- Retorno esperado (exemplo):
\echo '=== 1) empresas_lista (opções do dropdown) ==='

SELECT * FROM empresas_lista
LIMIT 10;

-- ========== 2) Tabela empresa_empresas_acesso com nomes (join) ==========
-- Para uma empresa específica, listar "empresas de acesso" com nome
\echo ''
\echo '=== 2) Lista de empresas_acesso da empresa id=1 (com nomes) ==='

SELECT eea.empresa_id, eea.empresa_acesso_id, emp.nome AS empresa_acesso_nome
FROM empresa_empresas_acesso eea
JOIN empresas emp ON emp.id = eea.empresa_acesso_id
WHERE eea.empresa_id = 1
ORDER BY emp.nome;

-- ========== 3) VIEW empresas_com_acesso (campo empresas_acesso = array) ==========
\echo ''
\echo '=== 3) empresas_com_acesso (coluna empresas_acesso como array) ==='

SELECT id, nome, ativo, empresas_acesso
FROM empresas_com_acesso
ORDER BY id
LIMIT 10;

-- ========== 4) Resumo: quantas empresas cada uma tem em "acesso" ==========
\echo ''
\echo '=== 4) Contagem de empresas_acesso por empresa ==='

SELECT e.id, e.nome,
       (SELECT count(*) FROM empresa_empresas_acesso eea WHERE eea.empresa_id = e.id) AS qtd_empresas_acesso
FROM empresas e
WHERE e.ativo = true
ORDER BY e.nome
LIMIT 10;
