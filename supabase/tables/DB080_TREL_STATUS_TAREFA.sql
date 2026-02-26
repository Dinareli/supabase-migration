CREATE TABLE IF NOT EXISTS "DB080_TREL_STATUS_TAREFA" (
    "000_Empresa" text,
    "[00] - 0PROJETO" text,
    "[00] - COR" text,
    "[00] - NOME DO STATUS" text,
    "[00] - ORDEM DO STATUS" bigint,
    "[00] - PROJETO" text,
    "[01] - Local" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB080_TREL_STATUS_TAREFAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB080_TREL_STATUS_TAREFA" ENABLE ROW LEVEL SECURITY;
