CREATE TABLE IF NOT EXISTS "DB086_UTIL_PRECIFICADOR" (
  "000_Empresa" text,
  "01 - [VALOR_CUSTO]" text,
  "02 - [GRAVADO_CUSTOS]" text,
  "03 - [VALOR_FATURAMENTO]" text,
  "04 - [GRAVADO_FATURAMENTO]" text,
  "05 - [ANO]" bigint,
  "06 - [NOME_MES]" text,
  "07 - [NUMERO_MES]" bigint,
  "Z-UNIQUE - ID-UNICO" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB086_UTIL_PRECIFICADORS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB086_UTIL_PRECIFICADOR" ENABLE ROW LEVEL SECURITY;
