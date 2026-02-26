CREATE TABLE IF NOT EXISTS "DB097_CHANGELOG" (
  "01 - TIPO" text,
  "02 - VERSIONAMENTO" text,
  "03 - DESCRICAO" text,
  "04 - PUBLICACAO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB097_CHANGELOGS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB097_CHANGELOG" ENABLE ROW LEVEL SECURITY;
