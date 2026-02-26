CREATE TABLE IF NOT EXISTS "DB117_ENGAJAMENTO" (
  "000_Empresa" text,
  "[002] - DATA" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB117_ENGAJAMENTOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB117_ENGAJAMENTO" ENABLE ROW LEVEL SECURITY;
