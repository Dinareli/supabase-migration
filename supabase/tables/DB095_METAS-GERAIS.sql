CREATE TABLE IF NOT EXISTS "DB095_METAS-GERAIS" (
  "000_Empresa" text,
  "01 - Periodo" text,
  "03 - Dias uteis" bigint,
  "04 - Tipo de meta" text,
  "05 - MetasColaborador" text,
  "06 - Quem lancou" text,
  "07 - Salvo" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB095_METAS_GERAIS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB095_METAS-GERAIS" ENABLE ROW LEVEL SECURITY;
