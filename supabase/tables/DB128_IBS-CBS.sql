CREATE TABLE IF NOT EXISTS "DB128_IBS-CBS" (
  "000_Empresa" text,
  "001_TipoTributacao" text,
  "002_TipoPessoa" text,
  "003_Cenario" text,
  "004_SituacaoTributaria" text,
  "005_Classificacao" text,
  "006_SituacaoTributaria-RegimeRegular" text,
  "007_Classificacao-RegimeRegular" text,
  "008_ClassificacaoCreditoPresumido" text,
  "009_AliquotaIBSCreditoPresumido" text,
  "010_AliquotaCBSCreditoPresumido" text,
  "011_AliquotaIBSDiferimento-Estadual" text,
  "012_AliquotaIBSDiferimento-Municipal" text,
  "013_AliquotaCBSDiferimento" text,
  "014_ReferenciaImposto" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB128_IBS_CBS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB128_IBS-CBS" ENABLE ROW LEVEL SECURITY;
