CREATE TABLE IF NOT EXISTS "DB126_DEVOCIONAL" (
  "001_data" text,
  "002_titulo" text,
  "003_referencia" text,
  "004_devocional" text,
  "005_destaque" text,
  "006_texto_apoio" text,
  "007_reflexao" text,
  "008_pedido" text,
  "009_autor" text,
  "010_keywords" text,
  "011_fonte" text,
  "012_audio" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB126_DEVOCIONALS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB126_DEVOCIONAL" ENABLE ROW LEVEL SECURITY;
