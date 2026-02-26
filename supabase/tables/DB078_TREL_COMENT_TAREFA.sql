CREATE TABLE IF NOT EXISTS "DB078_TREL_COMENT_TAREFA" (
    "000_Empresa" text,
    "[00] - TEXTO" text,
    "[01] - TIPO-NOTA" text,
    "[02] - COD-TASK" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB078_TREL_COMENT_TAREFAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB078_TREL_COMENT_TAREFA" ENABLE ROW LEVEL SECURITY;
