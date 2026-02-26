CREATE TABLE IF NOT EXISTS "DB081_TREL_TAREFA_CRM" (
    "000_Empresa" text,
    "[01] - EMPRESA-MANUAL" text,
    "[02] - LEAD-Codigo" text,
    "[03] - LEAD-Nome" text,
    "[04] - LEAD-Telefone" text,
    "[05] - LEAD-Instagram" text,
    "[06] - LEAD-Origem" text,
    "[07] - LEAD-FaseFunil" text,
    "[08] - LEAD-Comentarios" text,
    "[09] - LEAD-Status" text,
    "[10] - LEAD-Interesse" text,
    "[11] - LEAD-Responsavel" text,
    "[12] - LEAD-Assistencia" text,
    "[13] - LEAD-Loja Fisica" text,
    "[14] - LEAD-Entrada" text,
    "[15] - LEAD-Email" text,
    "[15] - LEAD-FimTeste" text,
    "[16] - Data" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB081_TREL_TAREFA_CRMS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB081_TREL_TAREFA_CRM" ENABLE ROW LEVEL SECURITY;
