CREATE TABLE IF NOT EXISTS "DB107_API-KEYS" (
  "000_Empresa" text,
  "[002] - NOME-CHAVE-API" text,
  "[003] - CONSUMER-KEY" text,
  "[004] - CONSUMER-SECRET" text,
  "[005] - ATIVO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB107_API_KEYS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB107_API-KEYS" ENABLE ROW LEVEL SECURITY;
