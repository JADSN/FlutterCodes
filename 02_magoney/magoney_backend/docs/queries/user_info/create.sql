-- Table: public.user_info
-- DROP TABLE IF EXISTS public.user_info;

CREATE TABLE IF NOT EXISTS public.user_info
(
    id smallserial NOT NULL UNIQUE,
    congregation_name character varying NOT NULL UNIQUE,
    city_name character varying NOT NULL UNIQUE,
    state_name character varying NOT NULL UNIQUE,
    month smallint NOT NULL,
    year smallint NOT NULL,
    CONSTRAINT user_info_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_info
    OWNER to postgres;