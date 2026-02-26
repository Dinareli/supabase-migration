CREATE TABLE IF NOT EXISTS "DB042_LAN_TRANSFERENCIAS" (
  "001_EmpresaOrigem" text, "002_EmpresaDestino" text, "003_EmpresasView" text, "004_Ativo" text, "005_Código" text, "006_Usuario-origem" text, "007_Usuario-destino" text, "008_Tipo-Origem" text, "009_Produto-Origem" text, "010_Custo-Origem" text, "011_LAN-Est-Produto-Origem" text, "012_LAN-Est-Produto-Destino" text, "013_Produto-Destino" text, "014_IMEI" text, "015_NUM-SERIE" text, "016_BATERIA" text, "017_COR" text, "018_Estoque-Origem" text, "019_Quantidade" bigint, "020_Data-Atualizacao" text, "021_Status" text, "022_Reprovado por" text, "023_Data-Entrada" text, "024_Origem-Fornecedor" text, "025_Saldo Estoque Final Origem" text, "026_Saldo Estoque Inicial Origem" text, "027_Saldo Estoque Final Destino" text, "028_Saldo Estoque Inicial Destino" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB042_LAN_TRANSFERENCIAS_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB042_LAN_TRANSFERENCIAS" ENABLE ROW LEVEL SECURITY;
