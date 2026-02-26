CREATE TABLE IF NOT EXISTS "DB093_CRM-EVENTO" (
  "000_Empresa" text,
  "ativo" text,
  "description" text,
  "dueDate" text,
  "endTime" text,
  "informacoesAdicionais" text,
  "interesse" text,
  "name" text,
  "priority" text,
  "relatedContact" text,
  "responsavel" text,
  "startTime" text,
  "tempoAtendimento" text,
  "tipoReuniao" text,
  "title" text,
  "type" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB093_CRM_EVENTOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB093_CRM-EVENTO" ENABLE ROW LEVEL SECURITY;
