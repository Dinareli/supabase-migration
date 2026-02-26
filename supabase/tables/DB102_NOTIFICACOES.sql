CREATE TABLE IF NOT EXISTS "DB102_NOTIFICACOES" (
  "000_Empresa" text,
  "01 - [TIPO_NOTIFICACAO]" text,
  "02 - [LIDO_POR]" text,
  "03 - [DESCRICAO]" text,
  "04 - [VINCULO_ATE]" text,
  "05 - [VISUALIZAVEL_SOMENTE_POR]" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB102_NOTIFICACOES_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB102_NOTIFICACOES" ENABLE ROW LEVEL SECURITY;
