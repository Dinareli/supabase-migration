CREATE TABLE IF NOT EXISTS "DB096_METAS_COLABORADOR" (
  "000_Empresa" text,
  "01 - Data_Meta" text,
  "03 - Codigo" text,
  "04 - Colaborador" text,
  "05 - KPI_Fat_Geral" text,
  "06 - KPI_Fat_Disp" text,
  "07 - KPI_Fat_Acess" text,
  "08 - KPI_Qtd_Disp" text,
  "09 - KPI_Qtd_Acess" text,
  "10 - KPI_Luc_Disp" text,
  "11 - KPI_Luc_Acess" text,
  "12 - KPI_Usados" text,
  "13 - MetaVinculada" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB096_METAS_COLABORADORS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB096_METAS_COLABORADOR" ENABLE ROW LEVEL SECURITY;
