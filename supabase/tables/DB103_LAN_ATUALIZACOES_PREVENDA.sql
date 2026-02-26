CREATE TABLE IF NOT EXISTS "DB103_LAN_ATUALIZACOES_PREVENDA" (
  "000_Empresa" text,
  "[01] - Cod Pre venda" text,
  "[02] - Acao" text,
  "[03] - Pagamento" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB103_LAN_ATUALIZACOES_PREVENDAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB103_LAN_ATUALIZACOES_PREVENDA" ENABLE ROW LEVEL SECURITY;
