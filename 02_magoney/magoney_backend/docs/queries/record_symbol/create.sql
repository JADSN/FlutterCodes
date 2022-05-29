-- Table: public.record_symbol
-- DROP TABLE IF EXISTS public.record_symbol;

CREATE TABLE IF NOT EXISTS public.record_symbol
(
    id smallserial NOT NULL UNIQUE,
    symbol "char" NOT NULL UNIQUE,
    label character varying NOT NULL UNIQUE,
    CONSTRAINT receipt_symbol_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.record_symbol
    OWNER to postgres;