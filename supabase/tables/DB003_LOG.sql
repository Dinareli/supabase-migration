CREATE TABLE IF NOT EXISTS "DB003_LOG" (
  "000_Empresa" text,
  "001_Acao" text,
  "002_Botao" text,
  "003_ClienteFornecedor" text,
  "004_Codigo" text,
  "005_InfoDeletada" text,
  "006_InfoModificada" text,
  "007_InfoModificadaBateria" text,
  "008_InfoModificadaCusto" text,
  "009_InfoModificadaIMEI" text,
  "010_InfoModificadaOBSExterna" text,
  "011_InfoModificadaOBSInterna" text,
  "012_InfoModificadaProdutos" text,
  "013_InfoModificadaQtd" text,
  "014_Tela" text,
  "015_Usuario" text,
  "016_UnicoID" text,
  "Creation Date" timestamp without time zone,
  "Modified Date" timestamp without time zone,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB003_LOG_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB003_LOG" ENABLE ROW LEVEL SECURITY;
