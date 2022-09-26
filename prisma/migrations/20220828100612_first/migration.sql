-- CreateEnum
CREATE TYPE "address_category_enum" AS ENUM ('Work', 'Home', 'Other');

-- CreateEnum
CREATE TYPE "contact_category_enum" AS ENUM ('Person', 'Company');

-- CreateEnum
CREATE TYPE "email_category_enum" AS ENUM ('Work', 'Personal', 'Other');

-- CreateEnum
CREATE TYPE "events_privacy_enum" AS ENUM ('Public', 'Private');

-- CreateEnum
CREATE TYPE "group_membership_role_enum" AS ENUM ('Member', 'Leader');

-- CreateEnum
CREATE TYPE "group_privacy_enum" AS ENUM ('Private', 'Public');

-- CreateEnum
CREATE TYPE "identification_category_enum" AS ENUM ('Nin', 'Passport', 'DrivingPermit', 'VillageCard', 'Nssf', 'Other');

-- CreateEnum
CREATE TYPE "occasion_category_enum" AS ENUM ('Birthday', 'Anniversary', 'Salvation', 'Engaged', 'Other');

-- CreateEnum
CREATE TYPE "person_civilstatus_enum" AS ENUM ('Other', 'Single', 'Married', 'Dating');

-- CreateEnum
CREATE TYPE "person_gender_enum" AS ENUM ('Male', 'Female');

-- CreateEnum
CREATE TYPE "person_salutation_enum" AS ENUM ('Mr', 'Mrs', 'Ms', 'Dr', 'Prof', 'Other');

-- CreateEnum
CREATE TYPE "phone_category_enum" AS ENUM ('Mobile', 'Office', 'Home', 'Fax', 'Other');

-- CreateEnum
CREATE TYPE "relationship_category_enum" AS ENUM ('Mother', 'Father', 'Daughter', 'Son', 'Fiancee', 'Sister', 'Brother', 'Other');

-- CreateEnum
CREATE TYPE "request_category_enum" AS ENUM ('Birthday', 'Anniversary', 'Salvation', 'Engaged', 'Other');

-- CreateTable
CREATE TABLE "address" (
    "id" SERIAL NOT NULL,
    "category" "address_category_enum" NOT NULL DEFAULT 'Home',
    "isPrimary" BOOLEAN NOT NULL,
    "country" VARCHAR NOT NULL,
    "district" VARCHAR NOT NULL,
    "county" VARCHAR,
    "subCounty" VARCHAR,
    "village" VARCHAR,
    "parish" VARCHAR,
    "postalCode" VARCHAR,
    "street" VARCHAR,
    "freeForm" VARCHAR,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "geoCoordinates" point,
    "placeId" VARCHAR,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contact" (
    "id" SERIAL NOT NULL,
    "category" "contact_category_enum" NOT NULL DEFAULT 'Person',

    CONSTRAINT "contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email" (
    "id" SERIAL NOT NULL,
    "category" "email_category_enum" NOT NULL DEFAULT 'Personal',
    "value" VARCHAR NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "email_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "event_attendance" (
    "id" SERIAL NOT NULL,
    "isVisitor" BOOLEAN NOT NULL,
    "eventId" INTEGER NOT NULL,
    "contactId" INTEGER NOT NULL,
    "attended" BOOLEAN NOT NULL,

    CONSTRAINT "event_attendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "event_category" (
    "id" VARCHAR(40) NOT NULL,
    "name" VARCHAR(200) NOT NULL,

    CONSTRAINT "event_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "event_field" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(40) NOT NULL,
    "label" VARCHAR(100) NOT NULL,
    "details" VARCHAR(200) NOT NULL,
    "type" VARCHAR(25) NOT NULL,
    "isRequired" BOOLEAN NOT NULL,
    "categoryId" VARCHAR(40) NOT NULL,

    CONSTRAINT "event_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events" (
    "id" SERIAL NOT NULL,
    "privacy" "events_privacy_enum",
    "name" VARCHAR(100) NOT NULL,
    "startDate" TIMESTAMP(6),
    "endDate" TIMESTAMP(6),
    "submittedAt" TIMESTAMP(6),
    "submittedById" INTEGER,
    "details" VARCHAR(500) NOT NULL,
    "venue" JSONB,
    "groupId" INTEGER,
    "metaData" JSONB,
    "categoryId" VARCHAR(40) NOT NULL,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group" (
    "id" SERIAL NOT NULL,
    "privacy" "group_privacy_enum",
    "name" VARCHAR(100) NOT NULL,
    "details" VARCHAR(500),
    "metaData" JSONB,
    "parentId" INTEGER,
    "freeForm" VARCHAR,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "geoCoordinates" point,
    "placeId" VARCHAR,
    "categoryId" VARCHAR(40) NOT NULL,

    CONSTRAINT "group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_category" (
    "id" VARCHAR(40) NOT NULL,
    "name" VARCHAR(200) NOT NULL,

    CONSTRAINT "group_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_membership" (
    "id" SERIAL NOT NULL,
    "groupId" INTEGER NOT NULL,
    "contactId" INTEGER NOT NULL,
    "role" "group_membership_role_enum",

    CONSTRAINT "group_membership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_membership_request" (
    "id" SERIAL NOT NULL,
    "contactId" INTEGER NOT NULL,
    "parentId" INTEGER,
    "groupId" INTEGER NOT NULL,
    "distanceKm" INTEGER NOT NULL,

    CONSTRAINT "group_membership_request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identification" (
    "id" SERIAL NOT NULL,
    "value" VARCHAR NOT NULL,
    "cardNumber" VARCHAR NOT NULL,
    "issuingCountry" VARCHAR NOT NULL,
    "startDate" TIMESTAMP(6) NOT NULL,
    "expiryDate" TIMESTAMP(6) NOT NULL,
    "category" "identification_category_enum" NOT NULL DEFAULT 'Nin',
    "isPrimary" BOOLEAN NOT NULL,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "identification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "occasion" (
    "id" SERIAL NOT NULL,
    "value" TIMESTAMP(6) NOT NULL,
    "details" VARCHAR NOT NULL,
    "category" "occasion_category_enum" NOT NULL DEFAULT 'Birthday',
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "occasion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person" (
    "id" SERIAL NOT NULL,
    "salutation" "person_salutation_enum",
    "firstName" VARCHAR(40) NOT NULL,
    "lastName" VARCHAR(40) NOT NULL,
    "middleName" VARCHAR(40),
    "ageGroup" VARCHAR,
    "placeOfWork" VARCHAR,
    "gender" "person_gender_enum" NOT NULL,
    "civilStatus" "person_civilstatus_enum",
    "avatar" VARCHAR,
    "dateOfBirth" DATE,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "phone" (
    "id" SERIAL NOT NULL,
    "category" "phone_category_enum" NOT NULL DEFAULT 'Mobile',
    "value" VARCHAR NOT NULL,
    "isPrimary" BOOLEAN NOT NULL,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "phone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "query-result-cache" (
    "id" SERIAL NOT NULL,
    "identifier" VARCHAR,
    "time" BIGINT NOT NULL,
    "duration" INTEGER NOT NULL,
    "query" TEXT NOT NULL,
    "result" TEXT NOT NULL,

    CONSTRAINT "query-result-cache_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "relationship" (
    "id" SERIAL NOT NULL,
    "category" "relationship_category_enum" NOT NULL DEFAULT 'Other',
    "contactId" INTEGER NOT NULL,
    "relativeId" INTEGER NOT NULL,

    CONSTRAINT "relationship_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "request" (
    "id" SERIAL NOT NULL,
    "value" TIMESTAMP(6) NOT NULL,
    "details" VARCHAR NOT NULL,
    "category" "request_category_enum" NOT NULL DEFAULT 'Birthday',
    "relativeId" INTEGER NOT NULL,
    "contactId" INTEGER NOT NULL,

    CONSTRAINT "request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(40) NOT NULL,
    "password" VARCHAR(100) NOT NULL,
    "contactId" INTEGER NOT NULL,
    "roles" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "company_contactId_key" ON "company"("contactId");

-- CreateIndex
CREATE UNIQUE INDEX "person_contactId_key" ON "person"("contactId");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "user_contactId_key" ON "user"("contactId");

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company" ADD CONSTRAINT "company_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "email" ADD CONSTRAINT "email_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event_attendance" ADD CONSTRAINT "event_attendance_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event_attendance" ADD CONSTRAINT "event_attendance_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event_field" ADD CONSTRAINT "event_field_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "event_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "event_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group" ADD CONSTRAINT "group_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "group_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group" ADD CONSTRAINT "group_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group_membership" ADD CONSTRAINT "group_membership_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group_membership" ADD CONSTRAINT "group_membership_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group_membership_request" ADD CONSTRAINT "group_membership_request_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group_membership_request" ADD CONSTRAINT "group_membership_request_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identification" ADD CONSTRAINT "identification_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "occasion" ADD CONSTRAINT "occasion_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person" ADD CONSTRAINT "person_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "phone" ADD CONSTRAINT "phone_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "relationship" ADD CONSTRAINT "relationship_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "relationship" ADD CONSTRAINT "relationship_relativeId_fkey" FOREIGN KEY ("relativeId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request" ADD CONSTRAINT "request_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
