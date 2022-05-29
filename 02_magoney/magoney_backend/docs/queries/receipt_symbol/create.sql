-- Table: public.receipt_symbol
-- DROP TABLE IF EXISTS public.receipt_symbol;

CREATE TABLE IF NOT EXISTS public.receipt_symbol
(
    id smallserial NOT NULL UNIQUE,
    symbol "char" NOT NULL UNIQUE,
    CONSTRAINT receipt_symbol_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.receipt_symbol
    OWNER to postgres;