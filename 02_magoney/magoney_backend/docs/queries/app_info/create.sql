-- Table: public.app_info

-- DROP TABLE IF EXISTS public.app_info;

CREATE TABLE IF NOT EXISTS public.app_info
(
    id smallint NOT NULL DEFAULT nextval('app_info_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    version_major smallint NOT NULL,
    versiono_minor smallint NOT NULL,
    version_patch smallint NOT NULL,
    CONSTRAINT app_info_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.app_info
    OWNER to postgres;