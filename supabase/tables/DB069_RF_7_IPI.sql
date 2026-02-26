CREATE TABLE IF NOT EXISTS "DB069_RF_7_IPI" (
    "000_Empresa" text,
    "001_ID-INTERNO" text,
    "002_TIPO_PESSOA" text,
    "003_IPI_CENARIO" text,
    "004_SIT_TRIBUTARIA" text,
    "005_COD_ENQUAD" bigint,
    "006_ALIQUOTA" text,
    "007_WMBR] - Cenario" text,
    "008_WMBR] - IPI-Situacoes" text,
    "009_WMBR] - Pessoa" text,
    "010_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB069_RF_7_IPIS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB069_RF_7_IPI" ENABLE ROW LEVEL SECURITY;
