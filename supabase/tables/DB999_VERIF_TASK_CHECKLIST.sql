CREATE TABLE IF NOT EXISTS "DB999_VERIF_TASK_CHECKLIST" (
  "000_Empresa" text,
  "[00] - FEITO" text,
  "[00] - TAREFA" text,
  "[00] - TEXTO" text,
  "[04] - LISTA-TXT" text,
  "[05] - OS-COD" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB999_VERIF_TASK_CHECKLISTS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB999_VERIF_TASK_CHECKLIST" ENABLE ROW LEVEL SECURITY;
