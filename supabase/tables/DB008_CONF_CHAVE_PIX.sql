CREATE TABLE IF NOT EXISTS "DB008_CONF_CHAVE PIX" (
  "000_Empresa" text,
  "001_ATIVO]" boolean,
  "002_D_CONTA]" text,
  "003_CHAVE PIX]" text,
  "004_D_FORMA_PAGTO]" text,
  "005_TXT_FORMA_PAGTO" text,
  "006_ID-UNICO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB008_CONF_CHAVE PIXES_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB008_CONF_CHAVE PIX" ENABLE ROW LEVEL SECURITY;
