CREATE TABLE IF NOT EXISTS "DB040_LAN_SIMULACOES" (
  "000_Empresa" text, "001_LancamentoAtivo" text, "002_AlteraTaxaAutorizadoPor" text, "003_BD_Pagamentos" text, "004_BD_Troca" text, "005_BD_Venda" text, "006_Cod_lancamento" text, "007_OBS_Interna" text, "008_OBS_NaNota" text, "009_SIM_Contato" text, "010_SIM_Nome" text, "011_SimuladoPor" text, "012_ID-UNICO" text,
  "Creation Date" text, "Modified Date" text, "Slug" text, "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB040_LAN_SIMULACOES_pkey" PRIMARY KEY ("unique_id")
);
ALTER TABLE "DB040_LAN_SIMULACOES" ENABLE ROW LEVEL SECURITY;
