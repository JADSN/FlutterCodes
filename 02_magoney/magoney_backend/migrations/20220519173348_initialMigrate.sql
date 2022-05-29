-- Table: public.app_info
-- DROP TABLE IF EXISTS public.app_info;
CREATE TABLE IF NOT EXISTS public.app_info
(
    id smallserial NOT NULL UNIQUE,
    label character varying NOT NULL UNIQUE,
    version_major smallint NOT NULL,
    versiono_minor smallint NOT NULL,
    version_patch smallint NOT NULL,
    CONSTRAINT app_info_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.app_info
    OWNER to postgres;


INSERT INTO public.app_info(label, version_major, versiono_minor, version_patch) VALUES ('Magoney', 0, 0, 1);

-- Table: public.user_info
-- DROP TABLE IF EXISTS public.user_info;

CREATE TABLE IF NOT EXISTS public.paper_account_info
(
    id smallserial NOT NULL UNIQUE,
    congregation_name character varying NOT NULL UNIQUE,
    city_name character varying NOT NULL UNIQUE,
    state_name character varying NOT NULL UNIQUE,
    CONSTRAINT paper_account_info_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.paper_account_info
    OWNER to postgres;

-- Table: public.receipt_type
-- DROP TABLE IF EXISTS public.receipt_type;
CREATE TABLE public.receipt_type
(
    id smallserial NOT NULL UNIQUE,
    label character varying NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.receipt_type
    OWNER to postgres;


INSERT INTO public.receipt_type(label) VALUES ('Donate');
INSERT INTO public.receipt_type(label) VALUES ('Bank deposit');
INSERT INTO public.receipt_type(label) VALUES ('Payment');
INSERT INTO public.receipt_type(label) VALUES ('Adavance money');

-- Table: public.receipts
-- DROP TABLE IF EXISTS public.receipts;

CREATE TABLE IF NOT EXISTS public.receipts
(
    id smallserial NOT NULL UNIQUE,
    code uuid NOT NULL UNIQUE,
    collection_date DATE NOT NULL,
    donate_world_work bigint NOT NULL,
    local_congregation_expenses bigint NOT NULL,
    receipt_type_fk smallint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT receipts_pkey PRIMARY KEY (id),
    CONSTRAINT receipt_type_fk FOREIGN KEY (receipt_type_fk) REFERENCES public.receipt_type (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.receipts
    OWNER to postgres;


-- Table: public.record_symbol
-- DROP TABLE IF EXISTS public.record_symbol;

CREATE TABLE IF NOT EXISTS public.record_symbol
(
    id smallserial NOT NULL UNIQUE,
    symbol character varying NOT NULL UNIQUE,
    label character varying NOT NULL UNIQUE,
    CONSTRAINT receipt_symbol_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.record_symbol
    OWNER to postgres;

INSERT INTO public.record_symbol(symbol, label)	VALUES ('O', 'Donativos para a obra mundial');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('C', 'Donativos para a congregação recolhidos das caixas');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('CE', 'Donativos para a congregação feitos por meio de transferência eletrônica');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('OE', 'Donativos recebidos para um objetivo específico');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('F', 'Fundos recebidos de Betel para um projeto de manutenção ou renovação de Salão do Reino');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('J', 'Juros da conta bancária');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('D', 'Depósito na conta');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('G', 'Gastos (despesas da congregação)');
INSERT INTO public.record_symbol(symbol, label)	VALUES ('GP', 'Gastos com um projeto de manutenção ou renovação de Salão do Reino custeado por Betel e devolução dos fundos que sobraram após o término do projeto');


-- Table: public.records
-- DROP TABLE IF EXISTS public.records;

CREATE TABLE IF NOT EXISTS public.records
(
    id smallserial NOT NULL UNIQUE,
    code uuid NOT NULL UNIQUE,
    record_date DATE NOT NULL,
    detail character varying NOT NULL,
    donate_input bigint NOT NULL,
    donate_output bigint NOT NULL,
    bank_account_input bigint NOT NULL,
    bank_account_output bigint NOT NULL,
    other_input bigint NOT NULL,
    other_output bigint NOT NULL,
    symbol_fk smallint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT records_pkey PRIMARY KEY (id),
    CONSTRAINT symbol_fk FOREIGN KEY (symbol_fk) REFERENCES public.record_symbol (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.records
    OWNER to postgres;