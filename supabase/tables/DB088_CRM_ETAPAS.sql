CREATE TABLE IF NOT EXISTS "DB088_CRM_ETAPAS" (
  "000_Empresa" text,
  "01 - Funil" text,
  "02 - ativo" text,
  "03 - NomeEtapa" text,
  "03 - OrdemEtapa" bigint,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB088_CRM_ETAPAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB088_CRM_ETAPAS" ENABLE ROW LEVEL SECURITY;
