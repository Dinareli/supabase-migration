CREATE TABLE IF NOT EXISTS "DB079_TREL_PROJETO" (
    "000_Empresa" text,
    "[01] - DESCRICAO" text,
    "[02] - MEMBROS" text,
    "[03] - NOME" text,
    "[04] - PINNED?" text,
    "[05] - STATUS" text,
    "[06] - TAREFAS-MANUT" text,
    "[07] - TAREFAS-CRM" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB079_TREL_PROJETOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB079_TREL_PROJETO" ENABLE ROW LEVEL SECURITY;
