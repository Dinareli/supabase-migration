CREATE TABLE IF NOT EXISTS "DB011_CONF_FUNCOES" (
  "000_Empresa" text,
  "001_NOME-FUNCAO]" text,
  "002_PERMISSAO" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB011_CONF_FUNCOES_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB011_CONF_FUNCOES" ENABLE ROW LEVEL SECURITY;
