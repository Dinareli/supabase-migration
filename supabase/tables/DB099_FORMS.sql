CREATE TABLE IF NOT EXISTS "DB099_FORMS" (
  "ATUACAO" text,
  "INFO-ADICIONAL" jsonb,
  "INSTAGRAM" jsonb,
  "LEAD" jsonb,
  "NOME EMPRESA" jsonb,
  "ORIGEM" text,
  "TELEFONE" jsonb,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB099_FORMS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB099_FORMS" ENABLE ROW LEVEL SECURITY;
