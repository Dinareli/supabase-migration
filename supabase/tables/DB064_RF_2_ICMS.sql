CREATE TABLE IF NOT EXISTS "DB064_RF_2_ICMS" (
    "000_Empresa" text,
    "001_ID-INTERNO" text,
    "002_SUBCODIGO" text,
    "003_UF" text,
    "004_ALIQUOTA" bigint,
    "005_TXT_ESTADOS" text,
    "006_ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB064_RF_2_ICMS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB064_RF_2_ICMS" ENABLE ROW LEVEL SECURITY;
