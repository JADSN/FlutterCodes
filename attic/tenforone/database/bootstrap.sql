CREATE TABLE IF NOT EXISTS public.app
(
    id smallserial NOT NULL,
    name character varying(20) COLLATE pg_catalog."default" NOT NULL UNIQUE,
    version_major integer NOT NULL,
    version_minor integer NOT NULL,
    version_patch integer NOT NULL,
    CONSTRAINT app_pkey PRIMARY KEY (id),
    CONSTRAINT check_version_major_is_positive CHECK (version_major >= 0),
    CONSTRAINT check_version_minor_is_positive CHECK (version_minor >= 0),
    CONSTRAINT check_version_patch_is_positive CHECK (version_patch >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.app
    OWNER to postgres;

INSERT INTO public.app(name, version_major, version_minor, version_patch) VALUES ('app_name', 0, 0, 1);

-- Table: public.owners

-- DROP TABLE IF EXISTS public.owners;


CREATE TABLE public.owners
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.owners
    OWNER to postgres;


INSERT INTO public.owners(name) VALUES ('Owner A');

-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    id smallserial NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    price money NOT NULL,
    owner_id integer NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (id),
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id)
        REFERENCES public.owners (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_owner_id_is_positive CHECK (owner_id > 0)
);

-- Table: public.clients

-- DROP TABLE IF EXISTS public.clients;

CREATE TABLE IF NOT EXISTS public.clients
(
    id smallserial NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    owner_id smallint NOT NULL,
    CONSTRAINT clients_pkey PRIMARY KEY (id),
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id)
        REFERENCES public.owners (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_click_id_is_positive CHECK (owner_id > 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.clients
    OWNER to postgres;


INSERT INTO public.clients(name, owner_id) VALUES ('Client A', 1);
INSERT INTO public.clients(name, owner_id) VALUES ('Client B', 1);
INSERT INTO public.clients(name, owner_id) VALUES ('Client C', 1);

-- Table: public.stamps

-- DROP TABLE IF EXISTS public.stamps;

CREATE TABLE IF NOT EXISTS public.stamps
(
    id smallserial NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT stamps_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.stamps
    OWNER to postgres;

