CREATE TABLE IF NOT EXISTS "DB115_NPS-GERAL" (
  "000_Empresa" text,
  "[002] - USER" text,
  "[003] - FUNCAO" text,
  "[004] - Q1" bigint,
  "[005] - Q2" bigint,
  "[006] - Q3" bigint,
  "[007] - Q4" bigint,
  "[008] - Q5" bigint,
  "[009] - COMENTARIO" text,
  "[010] - FUNC-MAIS-GOSTA" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB115_NPS-GERALS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB115_NPS-GERAL" ENABLE ROW LEVEL SECURITY;
