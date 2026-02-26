CREATE TABLE IF NOT EXISTS "DB019_CAD_AVARIA_ASSOCIADA" (
  "000_Empresa" text,
  "001_AVARIA" text,
  "002_PRODUTO" text,
  "003_VALOR" text,
  "004_ID-UNICO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB019_CAD_AVARIA_ASSOCIADAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB019_CAD_AVARIA_ASSOCIADA" ENABLE ROW LEVEL SECURITY;
