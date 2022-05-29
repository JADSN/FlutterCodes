-- Table: public.receipts

-- DROP TABLE IF EXISTS public.receipts;

CREATE TABLE IF NOT EXISTS public.receipts
(
    id smallserial NOT NULL UNIQUE,
    code uuid NOT NULL UNIQUE,
    collection_date DATE NOT NULL,
    donate_world_work bigint NOT NULL,
    local_congregation_expenses bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT receipts_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.receipts
    OWNER to postgres;