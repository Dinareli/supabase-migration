CREATE TABLE IF NOT EXISTS "DB075_SIM_PAGAMENTO" (
    "000_Empresa" text,
    "01 - [D_COD_SIMULACAO]" text,
    "02 - [D_FORMA_PAGTO]" text,
    "03 - [DESCONTO_FINAL]" text,
    "04 - [PAGTO_PARCELA]" text,
    "05 - [PAGTO_VALOR]" text,
    "06 - [PAGTO_VALOR_COM_TAXA]" text,
    "Z- OPT [OS] FORMA_PAGTO" text,
    "Z-UNIQUE - ID-UNICO" text,
    "Creation Date" text,
    "Modified Date" text,
    "Slug" text,
    "Creator" text,
    "unique_id" text NOT NULL,
    CONSTRAINT "DB075_SIM_PAGAMENTOS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB075_SIM_PAGAMENTO" ENABLE ROW LEVEL SECURITY;
