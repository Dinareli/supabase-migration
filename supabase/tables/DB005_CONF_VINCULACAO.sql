CREATE TABLE IF NOT EXISTS "DB005_CONF_VINCULACAO" (
  "000_Empresa" text,
  "001_Ativo" boolean DEFAULT true,
  "002_Compensacao" integer,
  "003_Conta" text,
  "004_FormaPagto" text,
  "005_TXT_FormaPagto" text,
  "006_IDUnico" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB005_CONF_VINCULACAOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB005_CONF_VINCULACAO" ENABLE ROW LEVEL SECURITY;
