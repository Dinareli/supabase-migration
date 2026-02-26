CREATE TABLE IF NOT EXISTS "DB058_PROD_COR" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_COR" text,
    "003_Remover" text,
    "004_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB058_PROD-COR_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB058_PROD_COR" ENABLE ROW LEVEL SECURITY;
