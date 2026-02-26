CREATE TABLE IF NOT EXISTS "SAT" (
  "000_Empresa" text,
  "[01] - CONCRETIZADO" text,
  "[03] - VENDEDOR" text,
  "[04] - TIPO-VENDA" text,
  "[99] - 0CLI-CPF" text,
  "[99] - 0CLI-NOME" text,
  "[99] - 0COD_ATENDIMENTO" text,
  "[99] - CLI-INFORMACOES" text,
  "[99] - CLI_INTENCAO" text,
  "[99] - DATA_VENDA" text,
  "[99] - LANCA-ATIVO" text,
  "[99] - STATUS" text,
  "COD_GARANTIA" text,
  "DB29" text,
  "Estilo_Saida" text,
  "Possui Anexo" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "SAT_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "SAT" ENABLE ROW LEVEL SECURITY;
