CREATE TABLE IF NOT EXISTS "DB124_CARTEIRA" (
  "000_Empresa" text,
  "[002] - TOKEN_COMPRADO" text,
  "[003] - TOTAL_TOKEN" text,
  "[004] - RECARGAS" text,
  "[005] - COTA_MENSAL_ATUAL" text,
  "[006] - SALDO_COMPRADO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB124_CARTEIRAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB124_CARTEIRA" ENABLE ROW LEVEL SECURITY;
