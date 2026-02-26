CREATE TABLE IF NOT EXISTS "DB018_CAD_AVARIA" (
  "000_Empresa" text,
  "001_ATIVO" text,
  "002_NOME_AVARIA" text,
  "003_ID-UNICO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB018_CAD_AVARIAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB018_CAD_AVARIA" ENABLE ROW LEVEL SECURITY;
