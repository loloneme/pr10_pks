CREATE TABLE "drink"(
    "drink_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "compound" TEXT NOT NULL,
    "is_cold" BOOLEAN NOT NULL DEFAULT '1',
    "is_hot" BOOLEAN NOT NULL DEFAULT '1'
);
ALTER TABLE
    "drink" ADD PRIMARY KEY("drink_id");

CREATE TABLE "user"(
    "user_id" SERIAL NOT NULL,
    "fullname" TEXT NOT NULL,
    "email" TEXT NULL,
    "phone" TEXT NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("user_id");

CREATE TABLE "volumes"(
    "volume_id" SERIAL NOT NULL,
    "drink_id" BIGINT NOT NULL,
    "volume" TEXT NOT NULL,
    "price" BIGINT NOT NULL
);
ALTER TABLE
    "volumes" ADD PRIMARY KEY("volume_id");

CREATE TABLE "cart_item"(
    "cart_item_id" SERIAL NOT NULL,
    "volume_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "is_hot" BOOLEAN NOT NULL,
    "is_cold" BOOLEAN NOT NULL,
    "quantity" BIGINT NOT NULL
);
ALTER TABLE
    "cart_item" ADD PRIMARY KEY("cart_item_id");

CREATE TABLE "favorites"(
    "user_id" BIGINT NOT NULL,
    "drink_id" BIGINT NOT NULL,
    PRIMARY KEY ("user_id", "drink_id")
);

ALTER TABLE "favorites" 
    ADD CONSTRAINT "favorites_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("user_id") ON DELETE CASCADE;
ALTER TABLE "favorites" 
    ADD CONSTRAINT "favorites_drink_id_foreign" FOREIGN KEY("drink_id") REFERENCES "drink"("drink_id") ON DELETE CASCADE;
ALTER TABLE "volumes" 
    ADD CONSTRAINT "volumes_drink_id_foreign" FOREIGN KEY("drink_id") REFERENCES "drink"("drink_id") ON DELETE CASCADE;
ALTER TABLE "cart_item" 
    ADD CONSTRAINT "cart_item_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("user_id") ON DELETE CASCADE;
ALTER TABLE "cart_item" 
    ADD CONSTRAINT "cart_item_volume_id_foreign" FOREIGN KEY("volume_id") REFERENCES "volumes"("volume_id") ON DELETE CASCADE;
