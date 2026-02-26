CREATE TABLE IF NOT EXISTS "DB007_CONF_TERMO_GARANTIA" (
  "000_Empresa" text,
  "001_Ativo" boolean DEFAULT true,
  "002_Uso de termo" text,
  "003_Titulo do termo" text,
  "004_Texto" text,
  "005_Padrao" boolean,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB007_CONF_TERMOS_GARANTIA_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB007_CONF_TERMO_GARANTIA" ENABLE ROW LEVEL SECURITY;
