CREATE TABLE IF NOT EXISTS "DB026_FIN_SUBCATEGORIA_DRE" (
  "000_Empresa" text,
  "001_ATIVO" text,
  "002_DESCRICAO" text,
  "003_USO" text,
  "004_EDITAVEL" text,
  "005_CATEGORIA" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB026_FIN-SUBCATEGORIA-DRES_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB026_FIN_SUBCATEGORIA_DRE" ENABLE ROW LEVEL SECURITY;
