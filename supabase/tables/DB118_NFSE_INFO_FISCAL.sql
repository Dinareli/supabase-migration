CREATE TABLE IF NOT EXISTS "DB118_NFSE_INFO_FISCAL" (
  "000_Empresa" text,
  "[002] - autenticacao" text,
  "[003] - emissao" text,
  "[004] - funcoes" text,
  "[005] - pdf_nfse" text,
  "[006] - pdf_sincrono" text,
  "[007] - modelo" text,
  "[008] - versao" double precision,
  "[009] - codigo_servico" text,
  "[010] - RF_INFO_FISCAL" text,
  "[021] - ATUAL-SERIE-RPS" text,
  "[022] - ATUAL-NUM-RPS" text,
  "[023] - LOGIN" text,
  "[024] - SENHA" text,
  "[025] - TOKEN" text,
  "[026] - REGIME-APUR-SN" text,
  "[027] - REGIME-ESPEC-NAC" text,
  "[028] - REGIME-ESPEC-MUNIC" text,
  "[029] - PROX-LOTE-RPS" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB118_NFSE_INFO_FISCALS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB118_NFSE_INFO_FISCAL" ENABLE ROW LEVEL SECURITY;
