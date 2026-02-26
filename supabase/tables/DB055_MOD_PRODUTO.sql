CREATE TABLE IF NOT EXISTS "DB055_MOD_PRODUTO" (
  "001_Criacao" text, "002_Grupo" text, "003_Marca" text, "004_Memoria" text, "005_Nome do Produto" text, "006_TXTS_MEMORIA" text, "007_ID-UNICO" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB055_MOD-PRODUTOS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB055_MOD_PRODUTO" ENABLE ROW LEVEL SECURITY;
