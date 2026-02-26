CREATE TABLE IF NOT EXISTS "DB076_SIM_TROCA" (
    "000_Empresa" text,
    "99 - [D_COD_LancaSim" text,
    "99 - [D_TRO_Avarias" text,
    "99 - [D_TRO_Cor" text,
    "99 - [D_TRO_Produto" text,
    "99 - [TipoLancamento" text,
    "99 - [TRO_Bateria" text,
    "99 - [TRO_CodInterno" text,
    "99 - [TRO_IMEI" text,
    "99 - [TRO_Proposta" text,
    "99 - [TRO_SIM_NomeCliente" text,
    "99 - [TRO_SIM_TelCliente" text,
    "Z-UNIQUE - ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB076_SIM_TROCAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB076_SIM_TROCA" ENABLE ROW LEVEL SECURITY;
