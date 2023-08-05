CREATE TABLE public."user"
(
    user_id bigint NOT NULL,
    name character varying(254) NOT NULL,
    email character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    PRIMARY KEY (user_id)
);

ALTER TABLE IF EXISTS public."user"
    OWNER to postgres;

CREATE TABLE public."group"
(
    group_id bigint NOT NULL,
    name character varying(254) NOT NULL,
    PRIMARY KEY (group_id)
);

ALTER TABLE IF EXISTS public."group"
    OWNER to postgres;

CREATE TABLE public.group_member
(
    user_id bigint NOT NULL,
    group_id bigint NOT NULL,
    CONSTRAINT group_member_pk PRIMARY KEY (user_id, group_id),
    CONSTRAINT group_member_fk1 FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT group_member_fk2 FOREIGN KEY (group_id)
        REFERENCES public."group" (group_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.group_member
    OWNER to postgres;

CREATE TABLE public.debt
(
    debt_id bigint NOT NULL,
    creditor bigint NOT NULL,
    debtor bigint NOT NULL,
    amount integer NOT NULL,
    PRIMARY KEY (debt_id),
    CONSTRAINT debt_fk1 FOREIGN KEY (creditor)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT debt_fk2 FOREIGN KEY (debtor)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.debt
    OWNER to postgres;

CREATE TABLE public.transaction
(
    transaction_id bigint NOT NULL,
    description character varying(2000) NOT NULL,
    date date NOT NULL,
    group_id bigint NOT NULL,
    total_amount integer NOT NULL,
    amount_per_person integer NOT NULL,
    photo bytea,
    PRIMARY KEY (transaction_id),
    CONSTRAINT transaction_fk1 FOREIGN KEY (group_id)
        REFERENCES public."group" (group_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.transaction
    OWNER to postgres;

CREATE TABLE public.transaction_member
(
    transaction_id bigint NOT NULL,
    member_id bigint NOT NULL,
    CONSTRAINT transaction_member_pk PRIMARY KEY (transaction_id, member_id),
    CONSTRAINT transaction_member_fk1 FOREIGN KEY (transaction_id)
        REFERENCES public.transaction (transaction_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT transaction_member_fk2 FOREIGN KEY (member_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.transaction_member
    OWNER to postgres;