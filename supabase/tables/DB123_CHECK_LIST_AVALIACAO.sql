CREATE TABLE IF NOT EXISTS "DB123_CHECK_LIST_AVALIACAO" (
  "01 - ESTOQUE" text,
  "02 - APROVADOS" text,
  "03 - REPROVADOS" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB123_CHECK-LIST_AVALIACAOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB123_CHECK_LIST_AVALIACAO" ENABLE ROW LEVEL SECURITY;
