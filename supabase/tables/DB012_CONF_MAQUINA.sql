CREATE TABLE IF NOT EXISTS "DB012_CONF_MAQUINA" (
  "000_Empresa" text,
  "001_ATIVO" boolean DEFAULT true,
  "002_DESATIVADO" boolean DEFAULT false,
  "003_CONTA]" text,
  "004_MÁQUINA]" text,
  "005_FORMA_PAGTO]" text,
  "006_TEMPO_COMPENSACAO]" numeric DEFAULT '0'::numeric,
  "007_TXT_FORMA_PAGTO" text,
  "008_ID-UNICO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB012_CONF-MAQUINAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB012_CONF_MAQUINA" ENABLE ROW LEVEL SECURITY;
