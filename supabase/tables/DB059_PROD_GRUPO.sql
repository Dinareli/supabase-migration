CREATE TABLE IF NOT EXISTS "DB059_PROD_GRUPO" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_GRUPO" text,
    "003_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB059_PROD-GRUPOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB059_PROD_GRUPO" ENABLE ROW LEVEL SECURITY;
