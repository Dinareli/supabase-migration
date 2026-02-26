CREATE TABLE IF NOT EXISTS "DB077_SIM_VENDA" (
    "000_Empresa" text,
    "99 - [COD_SimVenda" text,
    "99 - [D_COD_LancaSim" text,
    "99 - [D_VEN_Produto" text,
    "99 - [TipoLancamento" text,
    "99 - [VEN_CodInterno" text,
    "99 - [VEN_Desconto" text,
    "99 - [VEN_Preço" text,
    "99 - [VEN_SIM_NomeCliente" text,
    "99 - [VEN_SIM_TelCliente" text,
    "Z-UNIQUE - ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB077_SIM_VENDAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB077_SIM_VENDA" ENABLE ROW LEVEL SECURITY;
