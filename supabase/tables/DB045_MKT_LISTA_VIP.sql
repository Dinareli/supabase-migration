CREATE TABLE IF NOT EXISTS "DB045_MKT_LISTA_VIP" (
  "001_ComoConheceu" text, "002_E-mail" text, "003_Nome" text, "004_Nome da empresa" text, "005_Telefone" text, "006_ID-UNICO" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB045_MKT-LISTA-VIPS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB045_MKT_LISTA_VIP" ENABLE ROW LEVEL SECURITY;
