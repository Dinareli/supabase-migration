CREATE TABLE IF NOT EXISTS "DB071_RF_9_COFINS" (
    "000_Empresa" text,
    "001_ID-INTERNO" text,
    "002_TIPO_PESSOA" text,
    "003_PIS_CENARIO" text,
    "004_SIT_TRIBUTARIA" text,
    "005_ALIQUOTA" text,
    "006_WMBR] - Cenario" text,
    "007_WMBR] - CONFINS-Situacoes" text,
    "008_WMBR] - Pessoa" text,
    "009_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB071_RF_9_COFINS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB071_RF_9_COFINS" ENABLE ROW LEVEL SECURITY;
