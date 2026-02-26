CREATE TABLE IF NOT EXISTS "DB039_LAN_PROD_PRE" (
  "000_Empresa" text, "001_COD-PRE-VENDA" text, "002_PRODUTO" text, "003_PRECO-AVALIACAO" text, "004_TIPO-LANCA" text, "005_QTD" bigint, "006_COR" text, "007_DESCONTO" text, "008_ACRESCIMO" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB039_LAN-PROD-PRES_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB039_LAN_PROD_PRE" ENABLE ROW LEVEL SECURITY;
