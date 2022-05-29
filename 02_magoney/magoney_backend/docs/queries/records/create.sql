-- Table: public.records

-- DROP TABLE IF EXISTS public.records;

CREATE TABLE IF NOT EXISTS public.records
(
    id smallint NOT NULL DEFAULT nextval('records_id_seq'::regclass),
    donate_input bigint NOT NULL,
    donate_output bigint NOT NULL,
    bank_account_input bigint NOT NULL,
    bank_account_output bigint NOT NULL,
    other_input bigint NOT NULL,
    other_output bigint NOT NULL,
    symbol_fk smallint NOT NULL,
    CONSTRAINT records_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.records
    OWNER to postgres;