CREATE TABLE IF NOT EXISTS "DB060_PROD_LOCAL" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_NOME_LOCAL" text,
    "003_COR_IDENTIFICACAO" text,
    "004_FINALIDADE" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB060_PROD-LOCALS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB060_PROD_LOCAL" ENABLE ROW LEVEL SECURITY;
