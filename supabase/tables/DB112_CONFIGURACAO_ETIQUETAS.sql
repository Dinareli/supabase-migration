CREATE TABLE IF NOT EXISTS "DB112_CONFIGURACAO_ETIQUETAS" (
  "00 - Padrao" text,
  "000_Empresa" text,
  "01 - Nome Modelo" text,
  "02 - Altura Pagina" text,
  "03 - Largura Pagina" text,
  "04 - Margem Lateral Pagina" text,
  "05 - Margem Superior Pagina" text,
  "06 - Altura Etiqueta" text,
  "07 - Largura Etiqueta" text,
  "08 - Maximo de etiquetas" bigint,
  "09 - Colunas" bigint,
  "10 - Linhas" bigint,
  "11 - Dimensao Pagina" text,
  "12 - Entre Etiquetas" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB112_CONFIGURACAO_ETIQUETAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB112_CONFIGURACAO_ETIQUETAS" ENABLE ROW LEVEL SECURITY;
