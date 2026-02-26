CREATE TABLE IF NOT EXISTS "DB004_CHECKLIST" (
  "000_Empresa" text,
  "001_Ativo" boolean,
  "002_CodChecklist" text,
  "003_Descricao" text,
  "004_ListaItens" text,
  "005_TipoUso" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB004_CHECKLISTS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB004_CHECKLIST" ENABLE ROW LEVEL SECURITY;
