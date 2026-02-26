CREATE TABLE IF NOT EXISTS "DB074_RF_PARAM_IMPOSTO" (
    "000_Empresa" text,
    "001_ATIVO" text,
    "002_ID-INTERNO" text,
    "004_REF" text,
    "005_DESCRICAO" text,
    "006_SUGEST-USO" text,
    "007_APELIDO" text,
    "008_TIPO-TRIBUTACAO" text,
    "009_REGIME-TRIBUTARIO" text,
    "010_RF-COFINS" text,
    "011_RF-ICMS" text,
    "012_RF-IPI" text,
    "013_RF-PIS" text,
    "014_NAT-OPS" text,
    "015_RF-NFSE" text,
    "016_WMBR] - Tipo_de_tributacao" text,
    "017_ID-UNICO" text,
    "018_IBS-CBS" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB074_RF_PARAM-IMPOSTOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB074_RF_PARAM_IMPOSTO" ENABLE ROW LEVEL SECURITY;
