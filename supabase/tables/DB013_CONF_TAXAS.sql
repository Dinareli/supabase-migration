CREATE TABLE IF NOT EXISTS "DB013_CONF_TAXAS" (
  "000_Empresa" text,
  "001_CLIENTE_AMEX]" real,
  "002_CLIENTE_ELO]" real,
  "003_CLIENTE_MASTER]" real,
  "004_CLIENTE_VISA]" real,
  "005_CLIENTE_OUTRAS]" real,
  "006_LOJA_AMEX]" real,
  "007_LOJA_ELO]" real,
  "008_LOJA_MASTER]" real,
  "009_LOJA_VISA]" real,
  "010_LOJA_OUTRAS]" real,
  "011_MAQUINA]" text,
  "012_PARCELA_NOVA]" real,
  "013_ORDEM-PARCELAS]" real,
  "014_PARCELA]" text,
  "015_DISPLAY]" bigint,
  "016_TXT_PARCELAS_DEBITO" text,
  "017_ID-UNICO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB013_CONF-TAXAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB013_CONF_TAXAS" ENABLE ROW LEVEL SECURITY;
