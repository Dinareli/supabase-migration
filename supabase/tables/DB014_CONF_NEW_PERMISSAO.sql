CREATE TABLE IF NOT EXISTS "DB014_CONF_NEW_PERMISSAO" (
  "000_Empresa" text,
  "001_FUNCAO" text,
  "002_NOME-FUNCAO" text,
  "003_HOME-PERM" text,
  "004_CAD-PERM" text,
  "005_OPS-PERM" text,
  "006_FIN-PERM" text,
  "007_REL-PERM" text,
  "008_UTI-PERM" text,
  "009_FIS-PERM" text,
  "010_ADIC-PERM" text,
  "011_ASSIS-PERM" text,
  "012_CONF-PERM" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB014_CONF-NEW-PERMISSAOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB014_CONF_NEW_PERMISSAO" ENABLE ROW LEVEL SECURITY;
