CREATE TABLE IF NOT EXISTS "DB114_PATRIMONIO" (
  "000_Empresa" text,
  "[002] - ATIVO" text,
  "[003] - TIPO" text,
  "[004] - ID" text,
  "[005] - DESCRICAO" text,
  "[006] - VALOR" bigint,
  "[007] - RESPONSAVEL" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB114_PATRIMONIOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB114_PATRIMONIO" ENABLE ROW LEVEL SECURITY;
