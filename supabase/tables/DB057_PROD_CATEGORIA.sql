CREATE TABLE IF NOT EXISTS "DB057_PROD_CATEGORIA" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_DELETAVEL" text,
    "003_CATEGORIA" text,
    "004_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB057_PROD-CATEGORIAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB057_PROD_CATEGORIA" ENABLE ROW LEVEL SECURITY;
