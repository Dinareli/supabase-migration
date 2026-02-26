CREATE TABLE IF NOT EXISTS "DB061_PROD_MARCA" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_MARCA" text,
    "003_CriadoAdmin" text,
    "004_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB061_PROD-MARCAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB061_PROD_MARCA" ENABLE ROW LEVEL SECURITY;
