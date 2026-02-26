CREATE TABLE IF NOT EXISTS "DB109_API-RATE-LIMIT" (
  "000_Empresa" text,
  "[002] - API_KEY" text,
  "[003] - LIMITE_DIARIO" bigint,
  "[004] - ULTIMA_REQUISICAO" text,
  "[005] - REQUISICOES_DO_DIA" bigint,
  "[006] - REQUISICOES_TOTAIS" bigint,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB109_API_RATE_LIMITS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB109_API-RATE-LIMIT" ENABLE ROW LEVEL SECURITY;
