CREATE TABLE IF NOT EXISTS "DB066_RF_4_FCP" (
    "000_Empresa" text,
    "001_ID-INTERNO" text,
    "002_SUBCODIGO" text,
    "003_UF" text,
    "004_ALIQUOTA" text,
    "005_TXT_ESTADOS" text,
    "006_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB066_RF_4_FCPS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB066_RF_4_FCP" ENABLE ROW LEVEL SECURITY;
