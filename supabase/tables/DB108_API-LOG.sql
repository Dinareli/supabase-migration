CREATE TABLE IF NOT EXISTS "DB108_API-LOG" (
  "000_Empresa" text,
  "[002] - DATA_HORA" text,
  "[003] - STATUS_CODE" bigint,
  "[004] - ENDPOINT" jsonb,
  "[005] - PARAMETROS_FILTROS" text,
  "[010] - AUTHORIZATION" text,
  "[011] - C-KEY" text,
  "[012] - C-SECRET" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB108_API_LOGS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB108_API-LOG" ENABLE ROW LEVEL SECURITY;
