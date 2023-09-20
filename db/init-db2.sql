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
ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);

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