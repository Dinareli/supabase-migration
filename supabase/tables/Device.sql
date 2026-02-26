CREATE TABLE IF NOT EXISTS "Device" (
  "Current user" text,
  "Push notification token" text,
  "Type" text,
  "Creation Date" text,
  "Modified Date" text,
  "Slug" text,
  "Creator" text,
  "unique_id" text NOT NULL,
  CONSTRAINT "Devices_pkey" PRIMARY KEY ("unique_id")
);

ALTER TABLE "Device" ENABLE ROW LEVEL SECURITY;
