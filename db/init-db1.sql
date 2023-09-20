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
CREATE TABLE public.carts (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    user_id uuid NOT NULL,
    is_complete boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name text NOT NULL,
    email text NOT NULL
);
ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);

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
