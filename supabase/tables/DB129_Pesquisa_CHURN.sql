CREATE TABLE IF NOT EXISTS "DB129_Pesquisa_CHURN" (
  "000_Empresa" text,
  "001_NomeUsuario" text,
  "002_EmailUsuario" text,
  "003_Funcao" text,
  "004_Pergunta01" text,
  "005_Pergunta02" text,
  "006_Pergunta03" text,
  "007_Pergunta04" text,
  "008_Pergunta05" text,
  "009_Pergunta06" text,
  "010_Pergunta07" text,
  "011_Pergunta08" text,
  "012_Pergunta09" text,
  "013_Pergunta10" text,
  "014_PressionouResponderDepois" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB129_Pesquisa_CHURNS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB129_Pesquisa_CHURN" ENABLE ROW LEVEL SECURITY;
