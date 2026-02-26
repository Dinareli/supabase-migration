CREATE TABLE IF NOT EXISTS "DB021_DOC_ASSIN" (
  "000_Empresa" text,
  "001_CPF" text,
  "002_NOME-COMPLETO" text,
  "003_EMAIL" text,
  "004_HASH SHA256" text,
  "005_IMAGEM-ASSINATURA" text,
  "006_DATA-ASSINATURA" text,
  "007_TOKEN" bigint,
  "008_CAMINHO-URL" text,
  "009_CELULAR" bigint,
  "010_IP-ADRESS" text,
  "011_DETALHES-IP" text,
  "012_DETALHES-DISP" text,
  "013_IDENTIFICADOR" text,
  "014_ABRIU-PRIM-VEZ" text,
  "015_CIDADE-IP" text,
  "016_ESTADO" text,
  "017_PAÍS-IP" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB021_DOC-ASSINS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB021_DOC_ASSIN" ENABLE ROW LEVEL SECURITY;
