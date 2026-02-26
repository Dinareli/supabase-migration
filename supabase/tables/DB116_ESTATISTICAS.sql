CREATE TABLE IF NOT EXISTS "DB116_ESTATISTICAS" (
  "[001] - DATA" text,
  "[002] - KPI" text,
  "[003] - VALOR" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB116_ESTATISTICAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB116_ESTATISTICAS" ENABLE ROW LEVEL SECURITY;
