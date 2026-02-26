CREATE TABLE IF NOT EXISTS "DB024_FIN_ABRE_FECHA" (
  "000_Empresa" text,
  "001_FECHADO" text,
  "002_CONTA" text,
  "003_DATA_ABERTURA" text,
  "004_DATA_FECHAMENTO" text,
  "005_SALDO_ABERTURA" text,
  "006_SALDO_FECHAMENTO" text,
  "007_ID-UNICO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB024_FIN-ABRE-FECHAS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB024_FIN_ABRE_FECHA" ENABLE ROW LEVEL SECURITY;
