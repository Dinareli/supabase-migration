CREATE TABLE IF NOT EXISTS "DB044_MKT_CUPOM" (
  "001_ATIVO" text, "002_CUPOM" text, "003_ID-UNICO" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB044_MKT-CUPOMS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB044_MKT_CUPOM" ENABLE ROW LEVEL SECURITY;
