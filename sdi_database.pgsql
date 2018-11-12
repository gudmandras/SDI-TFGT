--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: databank_footprints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databank_footprints (
    id integer NOT NULL,
    min_y numeric(13,10) NOT NULL,
    min_x numeric(13,10) NOT NULL,
    max_y numeric(13,10) NOT NULL,
    max_x numeric(13,10) NOT NULL,
    path character varying(33) NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.databank_footprints OWNER TO postgres;

--
-- Name: databank_footprints_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.databank_footprints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.databank_footprints_id_seq OWNER TO postgres;

--
-- Name: databank_footprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.databank_footprints_id_seq OWNED BY public.databank_footprints.id;


--
-- Name: databank_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databank_position (
    id integer NOT NULL,
    max_x numeric(6,4) NOT NULL,
    max_y numeric(6,4) NOT NULL,
    min_x numeric(6,4) NOT NULL,
    min_y numeric(6,4) NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.databank_position OWNER TO postgres;

--
-- Name: databank_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.databank_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.databank_position_id_seq OWNER TO postgres;

--
-- Name: databank_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.databank_position_id_seq OWNED BY public.databank_position.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: footprints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.footprints (
    id integer NOT NULL,
    min_y numeric(13,10) NOT NULL,
    min_x numeric(13,10) NOT NULL,
    max_y numeric(13,10) NOT NULL,
    max_x numeric(13,10) NOT NULL,
    path character varying(33) NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.footprints OWNER TO postgres;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: databank_footprints id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databank_footprints ALTER COLUMN id SET DEFAULT nextval('public.databank_footprints_id_seq'::regclass);


--
-- Name: databank_position id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databank_position ALTER COLUMN id SET DEFAULT nextval('public.databank_position_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add position	7	add_position
20	Can change position	7	change_position
21	Can delete position	7	delete_position
22	Can add footprints	8	add_footprints
23	Can change footprints	8	change_footprints
24	Can delete footprints	8	delete_footprints
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$100000$fi5O8R92bjEw$BPBltJ/tDWzWPdFg3dnHe0/vOv3tv6wdOJ5tx2mme2Q=	2018-04-24 14:43:12.573458+00	t	levente			leventec3@gmail.com	t	t	2018-04-24 14:41:34.408308+00
2	pbkdf2_sha256$100000$ZIF2E6Zku14d$JSLjhbfCu5LWUZLqG78VGnRgUJmBmFOZbnrfk2hMwT8=	2018-05-28 17:19:05.775398+00	t	lvnt			leventec3@gmail.com	t	t	2018-04-28 10:49:44.11977+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: databank_footprints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databank_footprints (id, min_y, min_x, max_y, max_x, path, name) FROM stdin;
\.


--
-- Data for Name: databank_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databank_position (id, max_x, max_y, min_x, min_y, username) FROM stdin;
1	1.0000	1.0000	0.5000	0.5000	guest
2	5.0000	6.0000	4.0000	2.0000	guest
3	47.7393	20.0616	17.9851	17.9851	guest
4	47.5654	20.0396	46.8865	18.0071	guest
5	47.6284	20.2813	46.8151	18.0346	guest
6	47.4652	19.8199	46.7963	17.8753	lvnt
7	47.4689	19.8144	46.9615	17.8808	lvnt
8	47.4689	19.8144	46.9615	17.8808	lvnt
9	46.3621	20.3260	46.1722	19.9484	lvnt
10	46.3621	20.3260	46.1722	19.9484	lvnt
11	46.4151	20.3307	46.2179	20.0231	lvnt
12	46.4085	20.4649	46.2007	19.8648	lvnt
13	46.3668	20.3619	46.1950	19.8868	lvnt
14	46.3479	20.4457	46.1836	19.9898	lvnt
15	46.4237	20.4841	46.2359	19.9582	lvnt
16	46.3536	20.3688	46.1874	19.9499	lvnt
17	46.3763	20.4017	46.2074	19.9582	lvnt
18	46.4653	20.4347	46.2274	19.8922	lvnt
19	46.3867	20.4141	46.2122	19.9307	lvnt
20	46.3356	20.3976	46.1798	19.9211	lvnt
21	46.3356	20.4374	46.1922	19.9321	lvnt
22	46.3545	20.4296	46.2064	19.9187	lvnt
23	46.3550	20.3495	46.1898	19.9025	lvnt
24	46.3213	20.3049	46.1879	19.9430	lvnt
25	46.2841	20.2035	46.2304	20.0748	lvnt
26	46.2881	20.2355	46.2150	20.0442	lvnt
27	46.2727	20.2073	46.2122	20.0957	lvnt
28	46.2594	20.1590	46.2525	20.1433	lvnt
29	46.2836	20.2410	46.2074	20.0810	lvnt
30	46.3962	20.3633	46.2843	20.0268	lvnt
31	46.2922	20.2235	46.2212	20.0446	lvnt
32	46.2815	20.2163	46.2036	20.0584	lvnt
33	46.2815	20.2163	46.2036	20.0584	lvnt
34	46.2815	20.2163	46.2036	20.0584	lvnt
35	46.2815	20.2163	46.2036	20.0584	lvnt
36	46.2815	20.2163	46.2036	20.0584	lvnt
37	46.2815	20.2163	46.2036	20.0584	lvnt
38	46.2815	20.2163	46.2036	20.0584	lvnt
39	46.2815	20.2163	46.2036	20.0584	lvnt
40	46.2815	20.2163	46.2036	20.0584	lvnt
41	46.2815	20.2163	46.2036	20.0584	lvnt
42	46.2815	20.2163	46.2036	20.0584	lvnt
43	46.2815	20.2163	46.2036	20.0584	lvnt
44	46.2815	20.2163	46.2036	20.0584	lvnt
45	46.2815	20.2163	46.2036	20.0584	lvnt
46	46.2815	20.2163	46.2036	20.0584	lvnt
47	46.2815	20.2163	46.2036	20.0584	lvnt
48	46.2815	20.2163	46.2036	20.0584	lvnt
49	46.2815	20.2163	46.2036	20.0584	lvnt
50	46.2815	20.2163	46.2036	20.0584	lvnt
51	46.2815	20.2163	46.2036	20.0584	lvnt
52	46.2815	20.2163	46.2036	20.0584	lvnt
53	46.3128	20.2813	46.2179	20.0725	lvnt
54	46.3128	20.2813	46.2179	20.0725	lvnt
55	46.3128	20.2813	46.2179	20.0725	lvnt
56	46.3128	20.2813	46.2179	20.0725	lvnt
57	46.3128	20.2813	46.2179	20.0725	lvnt
58	46.3128	20.2813	46.2179	20.0725	lvnt
59	46.3128	20.2813	46.2179	20.0725	lvnt
60	46.3128	20.2813	46.2179	20.0725	lvnt
61	46.3128	20.2813	46.2179	20.0725	lvnt
62	46.3128	20.2813	46.2179	20.0725	lvnt
63	46.3128	20.2813	46.2179	20.0725	lvnt
64	46.3128	20.2813	46.2179	20.0725	lvnt
65	46.3128	20.2813	46.2179	20.0725	lvnt
66	46.3128	20.2813	46.2179	20.0725	lvnt
67	46.2853	20.2260	46.2217	20.0694	lvnt
68	46.6042	20.4241	46.4265	20.0341	lvnt
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-04-24 15:29:59.804824+00	1	1, 1, 0.5, 1, 0.5	1	[{"added": {}}]	7	1
2	2018-04-28 10:51:39.423199+00	2	2, 5, 4, 6, 2	1	[{"added": {}}]	7	2
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	databank	position
8	databank	footprints
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-04-21 22:03:17.78587+00
2	auth	0001_initial	2018-04-21 22:03:19.739334+00
3	admin	0001_initial	2018-04-21 22:03:20.044417+00
4	admin	0002_logentry_remove_auto_add	2018-04-21 22:03:20.090281+00
5	contenttypes	0002_remove_content_type_name	2018-04-21 22:03:20.517427+00
6	auth	0002_alter_permission_name_max_length	2018-04-21 22:03:20.574426+00
7	auth	0003_alter_user_email_max_length	2018-04-21 22:03:20.640441+00
8	auth	0004_alter_user_username_opts	2018-04-21 22:03:20.739456+00
9	auth	0005_alter_user_last_login_null	2018-04-21 22:03:20.78946+00
10	auth	0006_require_contenttypes_0002	2018-04-21 22:03:20.80446+00
11	auth	0007_alter_validators_add_error_messages	2018-04-21 22:03:20.844463+00
12	auth	0008_alter_user_username_max_length	2018-04-21 22:03:21.211547+00
13	auth	0009_alter_user_last_name_max_length	2018-04-21 22:03:21.250301+00
14	sessions	0001_initial	2018-04-21 22:03:21.565394+00
15	databank	0001_initial	2018-04-24 14:40:41.361464+00
16	databank	0002_auto_20180424_1728	2018-04-24 15:29:02.512556+00
17	databank	0002_position_username	2018-04-30 22:27:59.442483+00
18	databank	0003_footprints	2018-05-02 10:46:46.192068+00
19	databank	0004_auto_20180508_0041	2018-05-07 22:47:35.01745+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
xd0u7h1krtbhuvg7d74bltrhyrypqr64	YTkyMmFiZDJhOGMzNDgzOTc1NGM2YmU2NjI1YWVhMTA5YzhlNDlmZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODUxOTM3Y2IzZjJkMzE5OTg0Yjg2NDEwM2E3MjhmYTEwNWFjOGRjIn0=	2018-05-08 14:43:12.58194+00
\.


--
-- Data for Name: footprints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.footprints (id, min_y, min_x, max_y, max_x, path, name) FROM stdin;
1	19.9597668002	46.4563848954	20.0385212615	46.4930226369	databank/topo/Csongrad/27-111.jpg	27-111.jpg
2	20.0378617814	46.4556747210	20.1166663219	46.4923659563	databank/topo/Csongrad/27-112.jpg	27-112.jpg
3	19.9591601684	46.4204038703	20.0378617775	46.4570411409	databank/topo/Csongrad/27-113.jpg	27-113.jpg
4	20.0372031704	46.4196941641	20.1159547942	46.4563848936	databank/topo/Csongrad/27-114.jpg	27-114.jpg
5	20.1159547982	46.4549106223	20.1948092581	46.4916553131	databank/topo/Csongrad/27-121.jpg	27-121.jpg
6	20.1940456956	46.4540926020	20.2729499148	46.4908907098	databank/topo/Csongrad/27-122.jpg	27-122.jpg
7	20.1152442124	46.4189305692	20.1940456916	46.4556747192	databank/topo/Csongrad/27-123.jpg	27-123.jpg
8	20.1932831399	46.4181130882	20.2721343147	46.4549106204	databank/topo/Csongrad/27-124.jpg	27-124.jpg
9	19.9585543391	46.3844228968	20.0372031665	46.4210596830	databank/topo/Csongrad/27-131.jpg	27-131.jpg
10	20.0365454305	46.3837136583	20.1152442085	46.4204038684	databank/topo/Csongrad/27-132.jpg	27-132.jpg
11	19.9579493102	46.3484419893	20.0365454266	46.3850782774	databank/topo/Csongrad/27-133.jpg	27-133.jpg
12	20.0358885597	46.3477332178	20.1145345625	46.3844228950	databank/topo/Csongrad/27-134.jpg	27-134.jpg
13	20.1145345664	46.3829505665	20.1932831359	46.4196941623	databank/topo/Csongrad/27-141.jpg	27-141.jpg
14	20.1925215927	46.3821336242	20.2713197943	46.4189305673	databank/topo/Csongrad/27-142.jpg	27-142.jpg
15	20.1138258581	46.3469706284	20.1925215887	46.3837136565	databank/topo/Csongrad/27-143.jpg	27-143.jpg
16	20.1917610516	46.3461542240	20.2705063510	46.3829505646	databank/topo/Csongrad/27-144.jpg	27-144.jpg
17	20.2721343187	46.4532206635	20.3510881368	46.4900721496	databank/topo/Csongrad/27-211.jpg	27-211.jpg
18	20.3502205126	46.4522948099	20.4292237689	46.4891996354	databank/topo/Csongrad/27-212.jpg	27-212.jpg
19	20.2713197982	46.4172417245	20.3502205087	46.4540926002	databank/topo/Csongrad/27-213.jpg	27-213.jpg
20	20.3493540330	46.4163164812	20.4283041186	46.4532206616	databank/topo/Csongrad/27-214.jpg	27-214.jpg
21	20.4283041226	46.4513150448	20.5073566559	46.4882731706	databank/topo/Csongrad/27-221.jpg	27-221.jpg
22	20.5063849937	46.4502813719	20.5854866427	46.4872927588	databank/topo/Csongrad/27-222.jpg	27-222.jpg
23	20.4273856896	46.4153373620	20.5063849898	46.4522948080	databank/topo/Csongrad/27-223.jpg	27-223.jpg
24	20.5054146137	46.4143043706	20.5844629674	46.4513150429	databank/topo/Csongrad/27-224.jpg	27-224.jpg
25	20.2705063549	46.3812628345	20.3493540290	46.4181130864	databank/topo/Csongrad/27-231.jpg	27-231.jpg
26	20.3484886991	46.3803382008	20.4273856856	46.4172417226	databank/topo/Csongrad/27-232.jpg	27-232.jpg
27	20.2696939864	46.3452840076	20.3484886952	46.3821336223	databank/topo/Csongrad/27-233.jpg	27-233.jpg
28	20.3476245085	46.3443599827	20.4264684671	46.3812628327	databank/topo/Csongrad/27-234.jpg	27-234.jpg
29	20.4264684711	46.3793597266	20.5054146097	46.4163164794	databank/topo/Csongrad/27-241.jpg	27-241.jpg
30	20.5044455167	46.3783274156	20.5834406468	46.4153373602	databank/topo/Csongrad/27-242.jpg	27-242.jpg
31	20.4255524643	46.3433821526	20.5044455127	46.3803381990	databank/topo/Csongrad/27-243.jpg	27-243.jpg
32	20.5034776999	46.3423505211	20.5824196780	46.3793597247	databank/topo/Csongrad/27-244.jpg	27-244.jpg
33	19.9573450801	46.3124611617	20.0358885558	46.3490969383	databank/topo/Csongrad/27-311.jpg	27-311.jpg
34	20.0352325560	46.3117528566	20.1138258542	46.3484419874	databank/topo/Csongrad/27-312.jpg	27-312.jpg
35	19.9567416469	46.2764804283	20.0352325521	46.3131156798	databank/topo/Csongrad/27-313.jpg	27-313.jpg
36	20.0345774175	46.2757725890	20.1131180814	46.3124611599	databank/topo/Csongrad/27-314.jpg	27-314.jpg
37	20.1131180853	46.3109907690	20.1917610477	46.3477332160	databank/topo/Csongrad/27-321.jpg	27-321.jpg
38	20.1910015145	46.3101749018	20.2696939824	46.3469706266	databank/topo/Csongrad/27-322.jpg	27-322.jpg
39	20.1124112459	46.2750110026	20.1910015106	46.3117528548	databank/topo/Csongrad/27-323.jpg	27-323.jpg
40	20.1902429790	46.2741956718	20.2688826861	46.3109907672	databank/topo/Csongrad/27-324.jpg	27-324.jpg
41	19.9561390088	46.2404998033	20.0345774136	46.2771345160	databank/topo/Csongrad/27-331.jpg	27-331.jpg
42	20.0339231422	46.2397924291	20.1124112420	46.2764804265	databank/topo/Csongrad/27-332.jpg	27-332.jpg
43	19.9555371639	46.2045193006	20.0339231383	46.2411534610	databank/topo/Csongrad/27-333.jpg	27-333.jpg
44	20.0332697281	46.2038123911	20.1117053339	46.2404998014	databank/topo/Csongrad/27-334.jpg	27-334.jpg
45	20.1117053378	46.2390313431	20.1902429751	46.2757725872	databank/topo/Csongrad/27-341.jpg	27-341.jpg
46	20.1894854429	46.2382165481	20.2680724597	46.2750110007	databank/topo/Csongrad/27-342.jpg	27-342.jpg
47	20.1110003589	46.2030518049	20.1894854389	46.2397924273	databank/topo/Csongrad/27-343.jpg	27-343.jpg
48	20.1887289038	46.2022375449	20.2672633006	46.2390313413	databank/topo/Csongrad/27-344.jpg	27-344.jpg
49	20.2688826901	46.3093052580	20.3476245046	46.3461542221	databank/topo/Csongrad/27-411.jpg	27-411.jpg
50	20.3467614585	46.3083818410	20.4255524603	46.3452840058	databank/topo/Csongrad/27-412.jpg	27-412.jpg
51	20.2680724636	46.2733265998	20.3467614546	46.3101749000	databank/topo/Csongrad/27-413.jpg	27-413.jpg
52	20.3458995465	46.2724037899	20.4246376625	46.3093052562	databank/topo/Csongrad/27-414.jpg	27-414.jpg
53	20.4246376664	46.3074046542	20.5034776959	46.3443599808	databank/topo/Csongrad/27-421.jpg	27-421.jpg
54	20.5025111604	46.3063737014	20.5814000577	46.3433821507	databank/topo/Csongrad/27-422.jpg	27-422.jpg
55	20.4237240747	46.2714272456	20.5025111564	46.3083818391	databank/topo/Csongrad/27-423.jpg	27-423.jpg
56	20.5015458952	46.2703969706	20.5803817831	46.3074046524	databank/topo/Csongrad/27-424.jpg	27-424.jpg
57	20.2672633045	46.2373480472	20.3458995426	46.2741956700	databank/topo/Csongrad/27-431.jpg	27-431.jpg
58	20.3450387700	46.2364258436	20.4237240708	46.2733265980	databank/topo/Csongrad/27-432.jpg	27-432.jpg
59	20.2664552104	46.2013696143	20.3450387661	46.2382165463	databank/topo/Csongrad/27-433.jpg	27-433.jpg
60	20.3441791263	46.2004480163	20.4228116826	46.2373480454	databank/topo/Csongrad/27-434.jpg	27-434.jpg
61	20.4228116865	46.2354499410	20.5015458912	46.2724037881	databank/topo/Csongrad/27-441.jpg	27-441.jpg
62	20.5005819015	46.2344203428	20.5793648509	46.2714272438	databank/topo/Csongrad/27-442.jpg	27-442.jpg
63	20.4219004990	46.1994727544	20.5005818975	46.2364258418	databank/topo/Csongrad/27-443.jpg	27-443.jpg
64	20.4996191763	46.1984438322	20.5783492582	46.2354499391	databank/topo/Csongrad/27-444.jpg	27-444.jpg
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 24, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: databank_footprints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.databank_footprints_id_seq', 1, false);


--
-- Name: databank_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.databank_position_id_seq', 68, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 2, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 8, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: databank_footprints databank_footprints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databank_footprints
    ADD CONSTRAINT databank_footprints_pkey PRIMARY KEY (id);


--
-- Name: databank_position databank_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databank_position
    ADD CONSTRAINT databank_position_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: footprints footprints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.footprints
    ADD CONSTRAINT footprints_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

