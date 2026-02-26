CREATE TABLE IF NOT EXISTS "DB009_CONF_CIDADES_BR" (
  "001_Cidade-normalizada" text,
  "002_Nome" text,
  "003_UF" text,
  "004_UF TEXT" text,
  "005_IBGE" bigint,
  "006_TXT_ESTADOS" text,
  "007_ID-UNICO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB009_CONF_CIDADES_BRS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB009_CONF_CIDADES_BR" ENABLE ROW LEVEL SECURITY;
