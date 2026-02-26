CREATE TABLE IF NOT EXISTS "DB010_CONF_CONTA" (
  "000_Empresa" text,
  "001_ATIVO]" boolean DEFAULT true,
  "002_NOME_CONTA]" text,
  "003_SALDO]" text,
  "004_ID-UNICO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB010_CONF_CONTAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB010_CONF_CONTA" ENABLE ROW LEVEL SECURITY;
