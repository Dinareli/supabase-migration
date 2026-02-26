CREATE TABLE IF NOT EXISTS "DB065_RF_3_ICMS_ST" (
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
    CONSTRAINT "DB065_RF_3_ICMS-STS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB065_RF_3_ICMS_ST" ENABLE ROW LEVEL SECURITY;
