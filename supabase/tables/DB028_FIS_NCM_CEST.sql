CREATE TABLE IF NOT EXISTS "DB028_FIS_NCM_CEST" (
  "000_Empresa" text,
  "001_TIPO_PRODUTO" text,
  "002_CATEGORIA" text,
  "003_SUBCATEGORIA" text,
  "004_NCM" bigint,
  "005_CEST" bigint,
  "006_PRIORIDADE" text,
  "007_TXT_TIPO_PRODUTO" text,
  "008_ID-UNICO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB028_FIS-NCM-CESTS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB028_FIS_NCM_CEST" ENABLE ROW LEVEL SECURITY;
