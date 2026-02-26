CREATE TABLE IF NOT EXISTS "DB119_RF_NFSE" (
  "000_Empresa" text,
  "[001] - ID-INTERNO" text,
  "[002] - REF" text,
  "[003] - COD-SERVICO" text,
  "[004] - DESC-SERVICO" text,
  "[005] - COD-CNAE" bigint,
  "[006] - EXIG-ISS" text,
  "[007] - NFSE-Retido" text,
  "[008] - COD-TRIB-MUNIC" text,
  "[009] - RESP-RETENCAO" text,
  "[010] - NAT-OPERACAO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB119_RF_NFSES_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB119_RF_NFSE" ENABLE ROW LEVEL SECURITY;
