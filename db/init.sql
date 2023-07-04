SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET escape_string_warning = off;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.cart_items (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    product_id uuid NOT NULL,
    cart_id uuid NOT NULL,
    quantity integer NOT NULL
);
CREATE TABLE public.carts (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    user_id uuid NOT NULL,
    is_complete boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.categories (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.manufacturers (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.products (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    price integer NOT NULL,
    manufacturer uuid NOT NULL,
    category uuid NOT NULL,
    image text NOT NULL,
    country_of_origin text NOT NULL
);
CREATE TABLE public.reviews (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    product_id uuid NOT NULL,
    user_id uuid NOT NULL,
    rating integer NOT NULL,
    text text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.threads (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    thread_id uuid NOT NULL,
    user_id uuid NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    is_read boolean DEFAULT false NOT NULL
);
CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name text NOT NULL,
    email text NOT NULL
);
ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_reviews_updated_at BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_reviews_updated_at ON public.reviews IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.carts(id);
ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id);
ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_foreign FOREIGN KEY (category) REFERENCES public.categories(id);
ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_manufacturer_foreign FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(id);
ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id);
ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_thread_id_foreign FOREIGN KEY (thread_id) REFERENCES public.threads(id);
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);

INSERT INTO public.users (id, name, email) VALUES ('7cf0a66c-65b7-11ed-b904-fb49f034fbbb', 'Sean', 'seandemo@hasura.io');
INSERT INTO public.users (id, name, email) VALUES ('82001336-65b7-11ed-b905-7fa26a16d198', 'Rob', 'robdemo@hasura.io');
INSERT INTO public.users (id, name, email) VALUES ('86d5fba0-65b7-11ed-b906-afb985970e2e', 'Marion', 'mariondemo@hasura.io');
INSERT INTO public.users (id, name, email) VALUES ('8dea1160-65b7-11ed-b907-e3c5123cb650', 'Sandeep', 'sandeepdemo@hasura.io');
INSERT INTO public.users (id, name, email) VALUES ('9bd9d300-65b7-11ed-b908-571fef22d2ba', 'Abby', 'abbydemo@hasura.io');

INSERT INTO public.carts (id, user_id, is_complete) VALUES ('e2f27008-673d-11ed-8a24-7224baf239e5', '7cf0a66c-65b7-11ed-b904-fb49f034fbbb', true);
INSERT INTO public.carts (id, user_id) VALUES ('e6e0edc0-673d-11ed-8a25-7224baf239e5', '82001336-65b7-11ed-b905-7fa26a16d198');
INSERT INTO public.carts (id, user_id) VALUES ('ea226f5e-673d-11ed-8a26-7224baf239e5', '86d5fba0-65b7-11ed-b906-afb985970e2e');
INSERT INTO public.carts (id, user_id, is_complete) VALUES ('ee2c0948-673d-11ed-8a27-7224baf239e5', '8dea1160-65b7-11ed-b907-e3c5123cb650', true);
INSERT INTO public.carts (id, user_id) VALUES ('f11e43aa-673d-11ed-8a28-7224baf239e5', '9bd9d300-65b7-11ed-b908-571fef22d2ba');

INSERT INTO public.categories (id, name) VALUES ('672913fc-65b5-11ed-860f-6a8b11ef7372', 'T-Shirts');
INSERT INTO public.categories (id, name) VALUES ('698eccf4-65b5-11ed-8610-6a8b11ef7372', 'Hats');
INSERT INTO public.categories (id, name) VALUES ('6dfe1074-65b5-11ed-8611-6a8b11ef7372', 'Merchandise');

INSERT INTO public.manufacturers (id, name) VALUES ('e5d9e8a8-65b4-11ed-b13a-6a8b11ef7372', 'Hasura Hat Co.');
INSERT INTO public.manufacturers (id, name) VALUES ('e99cbfe2-65b4-11ed-b13b-6a8b11ef7372', 'Hasura Tee Co.');
INSERT INTO public.manufacturers (id, name) VALUES ('ec1ea762-65b4-11ed-b13c-6a8b11ef7372', 'Hasura Merch Co.');

INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('7992fdfa-65b5-11ed-8612-6a8b11ef7372', 'The Original Tee', 'When you want to keep it simple', 1000, 'e99cbfe2-65b4-11ed-b13b-6a8b11ef7372', '672913fc-65b5-11ed-860f-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1666262766/Swag%20Store/hasura_original_tee_noncvu.jpg', 'US');
INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('8aa93f86-65b6-11ed-901c-f320d4e17bb2', 'Dark Furry Logo Tee', 'A little darker, a little fun..er', 1000, 'e99cbfe2-65b4-11ed-b13b-6a8b11ef7372', '672913fc-65b5-11ed-860f-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1665118078/Swag%20Store/hasura_black_tee_oknbkr.png', 'US');
INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('a44eda7c-65b6-11ed-997b-53b5bdb7117e', 'Hasuras in The Cloud Tee', 'It''s Hasura but on someone else''s computer ;)', 1000, 'e99cbfe2-65b4-11ed-b13b-6a8b11ef7372', '672913fc-65b5-11ed-860f-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1665118078/Swag%20Store/hasura_white_tee_n424ys.png', 'US');
INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('cd6be51c-65b6-11ed-a2f4-4b71f0d3d70f', 'Get Ship Done Mug', 'A little reminder everytime you take a sip', 1600, 'ec1ea762-65b4-11ed-b13c-6a8b11ef7372', '6dfe1074-65b5-11ed-8611-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1665118078/Swag%20Store/hasura_mug_qv1wvp.png', 'GB');
INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('e0a70b16-65b6-11ed-8788-8fa2504d64a3', 'Sticker Sheet', '6 stickers all about that Hasura life. Featuring a few Hasuras and a lot of attitude.', 150, 'ec1ea762-65b4-11ed-b13c-6a8b11ef7372', '6dfe1074-65b5-11ed-8611-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1665118078/Swag%20Store/hasura_stickers_sheet_twebnl.png', 'IN');
INSERT INTO public.products (id, name, description, price, manufacturer, category, image, country_of_origin) VALUES ('fef9c02c-65b6-11ed-be19-2b4fad811971', 'Monogram Baseball Cap', 'Keep Hasura on your mind and the sun outta your eyes', 1100, 'e5d9e8a8-65b4-11ed-b13a-6a8b11ef7372', '698eccf4-65b5-11ed-8610-6a8b11ef7372', 'https://res.cloudinary.com/dh8fp23nd/image/upload/v1665118078/Swag%20Store/hasura_hat_ifpelt.png', 'AU');

INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('0d656070-673e-11ed-ac6c-7224baf239e5', 'e0a70b16-65b6-11ed-8788-8fa2504d64a3', 'e2f27008-673d-11ed-8a24-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('15956d4e-673e-11ed-ac6d-7224baf239e5', '8aa93f86-65b6-11ed-901c-f320d4e17bb2', 'e2f27008-673d-11ed-8a24-7224baf239e5', 2);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('3fddf1e8-673e-11ed-bf8f-7224baf239e5', 'a44eda7c-65b6-11ed-997b-53b5bdb7117e', 'e6e0edc0-673d-11ed-8a25-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('43b56e54-673e-11ed-bf90-7224baf239e5', 'cd6be51c-65b6-11ed-a2f4-4b71f0d3d70f', 'e6e0edc0-673d-11ed-8a25-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('48a1028e-673e-11ed-bf91-7224baf239e5', 'e0a70b16-65b6-11ed-8788-8fa2504d64a3', 'e6e0edc0-673d-11ed-8a25-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('530d4534-673e-11ed-bf92-7224baf239e5', 'fef9c02c-65b6-11ed-be19-2b4fad811971', 'ea226f5e-673d-11ed-8a26-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('5641b122-673e-11ed-bf93-7224baf239e5', '7992fdfa-65b5-11ed-8612-6a8b11ef7372', 'ea226f5e-673d-11ed-8a26-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('5bd9afd6-673e-11ed-bf94-7224baf239e5', 'e0a70b16-65b6-11ed-8788-8fa2504d64a3', 'ea226f5e-673d-11ed-8a26-7224baf239e5', 2);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('653b2f50-673e-11ed-bf95-7224baf239e5', 'a44eda7c-65b6-11ed-997b-53b5bdb7117e', 'ee2c0948-673d-11ed-8a27-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('6b96a780-673e-11ed-bf96-7224baf239e5', 'cd6be51c-65b6-11ed-a2f4-4b71f0d3d70f', 'ee2c0948-673d-11ed-8a27-7224baf239e5', 1);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('7a34aa08-673e-11ed-bf97-7224baf239e5', 'fef9c02c-65b6-11ed-be19-2b4fad811971', 'f11e43aa-673d-11ed-8a28-7224baf239e5', 2);
INSERT INTO public.cart_items (id, product_id, cart_id, quantity) VALUES ('7d5b6924-673e-11ed-bf98-7224baf239e5', '7992fdfa-65b5-11ed-8612-6a8b11ef7372', 'f11e43aa-673d-11ed-8a28-7224baf239e5', 2);

INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('c3c52c80-673c-11ed-88eb-7224baf239e5', '7992fdfa-65b5-11ed-8612-6a8b11ef7372', '7cf0a66c-65b7-11ed-b904-fb49f034fbbb', 5, 'Such a great t-shirt. I wear it everywhere.', '2022-11-18 12:30:19.779355+00', '2022-11-18 12:30:19.779355+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('dc9768a4-673c-11ed-b682-7224baf239e5', '8aa93f86-65b6-11ed-901c-f320d4e17bb2', '82001336-65b7-11ed-b905-7fa26a16d198', 5, 'Furry logos for the win! So soft, so comfy!', '2022-11-18 12:31:01.423848+00', '2022-11-18 12:31:01.423848+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('fcc86da8-673c-11ed-a17f-7224baf239e5', 'a44eda7c-65b6-11ed-997b-53b5bdb7117e', '86d5fba0-65b7-11ed-b906-afb985970e2e', 4, 'I love this t-shirt almost as much as I love Hasura.', '2022-11-18 12:31:55.434743+00', '2022-11-18 12:31:55.434743+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('225c954e-673d-11ed-8105-7224baf239e5', 'cd6be51c-65b6-11ed-a2f4-4b71f0d3d70f', '8dea1160-65b7-11ed-b907-e3c5123cb650', 4, 'Everytime I take a sip I work faster. I don''t know if it''s the coffee or the mug...', '2022-11-18 12:32:58.482696+00', '2022-11-18 12:32:58.482696+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('3e25c84a-673d-11ed-a82a-7224baf239e5', 'e0a70b16-65b6-11ed-8788-8fa2504d64a3', '9bd9d300-65b7-11ed-b908-571fef22d2ba', 5, 'I think I need more computers because I''ve run out of sticker space.', '2022-11-18 12:33:45.096466+00', '2022-11-18 12:33:45.096466+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('587de934-673d-11ed-a7d4-7224baf239e5', 'fef9c02c-65b6-11ed-be19-2b4fad811971', '7cf0a66c-65b7-11ed-b904-fb49f034fbbb', 5, 'I thought I had a big head from using Hasura, but it fits perfectly in this cap.', '2022-11-18 12:34:29.296082+00', '2022-11-18 12:34:29.296082+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('708de0ce-673d-11ed-b2ce-7224baf239e5', '7992fdfa-65b5-11ed-8612-6a8b11ef7372', '82001336-65b7-11ed-b905-7fa26a16d198', 5, 'Most of my clothes are now Hasura swag. Sorry, not sorry.', '2022-11-18 12:35:09.666383+00', '2022-11-18 12:35:09.666383+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('833145c2-673d-11ed-90b8-7224baf239e5', '8aa93f86-65b6-11ed-901c-f320d4e17bb2', '86d5fba0-65b7-11ed-b906-afb985970e2e', 5, 'If only all logos were this furry.', '2022-11-18 12:35:40.936559+00', '2022-11-18 12:35:40.936559+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('94b4a582-673d-11ed-90b9-7224baf239e5', 'a44eda7c-65b6-11ed-997b-53b5bdb7117e', '8dea1160-65b7-11ed-b907-e3c5123cb650', 4, 'More cloud. More Hasura.', '2022-11-18 12:36:10.31957+00', '2022-11-18 12:36:10.31957+00');
INSERT INTO public.reviews (id, product_id, user_id, rating, text, created_at, updated_at) VALUES ('a6108b8e-673d-11ed-90ba-7224baf239e5', 'cd6be51c-65b6-11ed-a2f4-4b71f0d3d70f', '9bd9d300-65b7-11ed-b908-571fef22d2ba', 5, 'Oh yeah. I ship. ', '2022-11-18 12:36:39.443237+00', '2022-11-18 12:36:39.443237+00');

insert INTO public.threads (id, user_id, created_at) VALUES ('75e0f7b0-b5fc-11ed-ad85-1a122c2a1c44', '82001336-65b7-11ed-b905-7fa26a16d198', '2023-01-01 00:00:00');

