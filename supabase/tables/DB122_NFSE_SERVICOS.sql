CREATE TABLE IF NOT EXISTS "DB122_NFSE_SERVICOS" (
  "000_Empresa" text,
  "01 - Produto" text,
  "02 - Valor" text,
  "03 - NFSE" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB122_NFSE_SERVICOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB122_NFSE_SERVICOS" ENABLE ROW LEVEL SECURITY;
