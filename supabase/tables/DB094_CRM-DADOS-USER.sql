CREATE TABLE IF NOT EXISTS "DB094_CRM-DADOS-USER" (
  "00 - USER" text,
  "000_Empresa" text,
  "01 - FINALIZADOS-SEM-MENSAGEM" text,
  "02 - FINALIZADOS-COM-MENSAGEM" text,
  "03 - FINALIZADOS" text,
  "04 - ATENDIDOS" bigint,
  "05 - TRANSFER-RECEBIDOS" text,
  "06 - TRANSFER-ENVIADOS" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB094_CRM_DADOS_USERS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB094_CRM-DADOS-USER" ENABLE ROW LEVEL SECURITY;
