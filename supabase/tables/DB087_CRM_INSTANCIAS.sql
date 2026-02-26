CREATE TABLE IF NOT EXISTS "DB087_CRM_INSTANCIAS" (
  "000_Empresa" text,
  "01 - status" text,
  "02 - chave" text,
  "03 - instanciaNome" text,
  "04 - fotoConectado" text,
  "05 - logConexao" text,
  "06 - nomeConexao" text,
  "07 - owner (numero)" bigint,
  "08 - canalConectado" text,
  "09 - qrcode" text,
  "10 - usuariosComAcesso" text,
  "11 - URL" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "DB087_CRM_INSTANCIAS_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "DB087_CRM_INSTANCIAS" ENABLE ROW LEVEL SECURITY;
