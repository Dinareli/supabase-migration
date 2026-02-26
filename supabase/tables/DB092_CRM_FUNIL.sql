CREATE TABLE IF NOT EXISTS "DB092_CRM_FUNIL" (
  "000_Empresa" text,
  "01 - ativo" text,
  "02 - nomeFunil" text,
  "03 - EtapasFunil" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB092_CRM_FUNILS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB092_CRM_FUNIL" ENABLE ROW LEVEL SECURITY;
