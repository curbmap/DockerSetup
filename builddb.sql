GRANT ALL ON SCHEMA public TO testing;

GRANT ALL ON SCHEMA public TO PUBLIC;
-- DROP DATABASE "CurbMapUsers";

GRANT ALL ON DATABASE "CurbMapUsers" TO testing;

GRANT TEMPORARY, CONNECT ON DATABASE "CurbMapUsers" TO PUBLIC;

CREATE TABLE public.lines
(
    userid character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    lines_created jsonb,
    CONSTRAINT "useridPK" PRIMARY KEY (userid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.lines
    OWNER to testing;

GRANT ALL ON TABLE public.lines TO testing;

CREATE TABLE public.photos
(
    userid character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    photos_created jsonb,
    CONSTRAINT photos_pkey PRIMARY KEY (userid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.photos
    OWNER to testing;

GRANT ALL ON TABLE public.photos TO testing;

CREATE TABLE public.standard_user
(
    id_user character varying(255) COLLATE pg_catalog."default" NOT NULL,
    active_account integer NOT NULL,
    auth_token character varying(255) COLLATE pg_catalog."default",
    authorized integer NOT NULL,
    date_created timestamp without time zone NOT NULL,
    external_auth_key character varying(255) COLLATE pg_catalog."default",
    external_auth_service character varying(255) COLLATE pg_catalog."default",
    password_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    role character varying(255) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    external_auth_id character varying(64) COLLATE pg_catalog."default",
    "updatedAt" timestamp without time zone DEFAULT now(),
    "createdAt" timestamp without time zone DEFAULT now(),
    "badge_updatedAt" timestamp without time zone,
    score bigint,
    "score_updatedAt" timestamp without time zone,
    badge integer DEFAULT 1,
    CONSTRAINT standard_user_pkey PRIMARY KEY (id_user),
    CONSTRAINT uk_ari93f4i6r669u3vvtno4ni9p UNIQUE (user_email),
    CONSTRAINT uk_ow3udbl7wpnfa58r7vpw3kp97 UNIQUE (username)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.standard_user
    OWNER to testing;

GRANT ALL ON TABLE public.standard_user TO testing;
