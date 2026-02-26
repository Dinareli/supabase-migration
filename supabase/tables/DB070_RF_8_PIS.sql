CREATE TABLE IF NOT EXISTS "DB070_RF_8_PIS" (
    "000_Empresa" text,
    "001_ID-INTERNO" text,
    "002_TIPO_PESSOA" text,
    "003_PIS_CENARIO" text,
    "004_SIT_TRIBUTARIA" text,
    "005_ALIQUOTA" text,
    "006_WMBR] - Cenario" text,
    "007_WMBR] - Pessoa" text,
    "008_WMBR] - PIS-Situacoes" text,
    "009_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB070_RF_8_PIS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB070_RF_8_PIS" ENABLE ROW LEVEL SECURITY;
