--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE account_emailaddress OWNER TO adas;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailaddress_id_seq OWNER TO adas;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE account_emailaddress_id_seq OWNED BY account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE account_emailconfirmation OWNER TO adas;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_emailconfirmation_id_seq OWNER TO adas;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE account_emailconfirmation_id_seq OWNED BY account_emailconfirmation.id;


--
-- Name: addresses_address; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE addresses_address (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    street character varying(50) NOT NULL,
    street_number character varying(10) NOT NULL,
    postcode character varying(6) NOT NULL,
    city character varying(50) NOT NULL,
    taxpayer_id integer NOT NULL,
    user_id integer NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE addresses_address OWNER TO adas;

--
-- Name: addresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE addresses_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE addresses_address_id_seq OWNER TO adas;

--
-- Name: addresses_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE addresses_address_id_seq OWNED BY addresses_address.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO adas;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO adas;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO adas;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO adas;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO adas;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO adas;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE django_admin_log (
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


ALTER TABLE django_admin_log OWNER TO adas;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO adas;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO adas;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO adas;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO adas;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO adas;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO adas;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO adas;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO adas;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: locations_country; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE locations_country (
    id integer NOT NULL,
    continent integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(50) NOT NULL
);


ALTER TABLE locations_country OWNER TO adas;

--
-- Name: locations_country_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE locations_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_country_id_seq OWNER TO adas;

--
-- Name: locations_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE locations_country_id_seq OWNED BY locations_country.id;


--
-- Name: locations_location; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE locations_location (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    "position" geometry(Point,4326),
    country_id integer NOT NULL
);


ALTER TABLE locations_location OWNER TO adas;

--
-- Name: locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_location_id_seq OWNER TO adas;

--
-- Name: locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE locations_location_id_seq OWNED BY locations_location.id;


--
-- Name: orders_guest; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE orders_guest (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    second_name character varying(50) NOT NULL,
    order_id integer NOT NULL,
    document_id character varying(50) NOT NULL
);


ALTER TABLE orders_guest OWNER TO adas;

--
-- Name: orders_guest_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE orders_guest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_guest_id_seq OWNER TO adas;

--
-- Name: orders_guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE orders_guest_id_seq OWNED BY orders_guest.id;


--
-- Name: orders_order; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE orders_order (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    trip_id integer NOT NULL,
    user_id integer NOT NULL,
    note text NOT NULL,
    address_id integer NOT NULL,
    unit_price integer NOT NULL
);


ALTER TABLE orders_order OWNER TO adas;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_order_id_seq OWNER TO adas;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE orders_order_id_seq OWNED BY orders_order.id;


--
-- Name: payments_payment; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE payments_payment (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    cashier_id integer NOT NULL,
    form_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE payments_payment OWNER TO adas;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payments_payment_id_seq OWNER TO adas;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE payments_payment_id_seq OWNED BY payments_payment.id;


--
-- Name: payments_paymentform; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE payments_paymentform (
    id integer NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE payments_paymentform OWNER TO adas;

--
-- Name: payments_paymentform_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE payments_paymentform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payments_paymentform_id_seq OWNER TO adas;

--
-- Name: payments_paymentform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE payments_paymentform_id_seq OWNED BY payments_paymentform.id;


--
-- Name: trips_image; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE trips_image (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    trip_id integer NOT NULL
);


ALTER TABLE trips_image OWNER TO adas;

--
-- Name: trips_image_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE trips_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_image_id_seq OWNER TO adas;

--
-- Name: trips_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE trips_image_id_seq OWNED BY trips_image.id;


--
-- Name: trips_trip; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE trips_trip (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    description text NOT NULL,
    base_price integer NOT NULL,
    space integer NOT NULL,
    main_image character varying(100) NOT NULL,
    created_by_id integer NOT NULL,
    location_id integer NOT NULL,
    CONSTRAINT trips_trip_space_34f78413_check CHECK ((space >= 0))
);


ALTER TABLE trips_trip OWNER TO adas;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_trip_id_seq OWNER TO adas;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE trips_trip_id_seq OWNED BY trips_trip.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE users_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    discount integer NOT NULL
);


ALTER TABLE users_user OWNER TO adas;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE users_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE users_user_groups OWNER TO adas;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_groups_id_seq OWNER TO adas;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE users_user_groups_id_seq OWNED BY users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO adas;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE users_user_id_seq OWNED BY users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: adas; Tablespace: 
--

CREATE TABLE users_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE users_user_user_permissions OWNER TO adas;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: adas
--

CREATE SEQUENCE users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_user_permissions_id_seq OWNER TO adas;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adas
--

ALTER SEQUENCE users_user_user_permissions_id_seq OWNED BY users_user_user_permissions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY account_emailaddress ALTER COLUMN id SET DEFAULT nextval('account_emailaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('account_emailconfirmation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY addresses_address ALTER COLUMN id SET DEFAULT nextval('addresses_address_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY locations_country ALTER COLUMN id SET DEFAULT nextval('locations_country_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY locations_location ALTER COLUMN id SET DEFAULT nextval('locations_location_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_guest ALTER COLUMN id SET DEFAULT nextval('orders_guest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_order ALTER COLUMN id SET DEFAULT nextval('orders_order_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY payments_payment ALTER COLUMN id SET DEFAULT nextval('payments_payment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY payments_paymentform ALTER COLUMN id SET DEFAULT nextval('payments_paymentform_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY trips_image ALTER COLUMN id SET DEFAULT nextval('trips_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY trips_trip ALTER COLUMN id SET DEFAULT nextval('trips_trip_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user ALTER COLUMN id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_groups ALTER COLUMN id SET DEFAULT nextval('users_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('users_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
1	a@a.pl	t	t	1
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('account_emailaddress_id_seq', 1, true);


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
1	2016-05-11 07:30:09.732219+02	2016-05-11 07:30:09.755141+02	lttlpcstymdvvgfvdf1fygpin1mwuwdtg8vspw41nuksa1wnfkkv8wwuospspkqd	1
\.


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('account_emailconfirmation_id_seq', 1, true);


--
-- Data for Name: addresses_address; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY addresses_address (id, name, street, street_number, postcode, city, taxpayer_id, user_id, active) FROM stdin;
1	BIP RPO	Małopolska 5	25	25-000	Warszawa	2500	1	t
\.


--
-- Name: addresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('addresses_address_id_seq', 1, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add email address	7	add_emailaddress
20	Can change email address	7	change_emailaddress
21	Can delete email address	7	delete_emailaddress
22	Can add email confirmation	8	add_emailconfirmation
23	Can change email confirmation	8	change_emailconfirmation
24	Can delete email confirmation	8	delete_emailconfirmation
25	Can add user	9	add_user
26	Can change user	9	change_user
27	Can delete user	9	delete_user
28	Can add Trip	10	add_trip
29	Can change Trip	10	change_trip
30	Can delete Trip	10	delete_trip
31	Can add Image	11	add_image
32	Can change Image	11	change_image
33	Can delete Image	11	delete_image
34	Can add Order	12	add_order
35	Can change Order	12	change_order
36	Can delete Order	12	delete_order
37	Can view order	12	view_order
38	Can add Guest	13	add_guest
39	Can change Guest	13	change_guest
40	Can delete Guest	13	delete_guest
41	Can add Country	14	add_country
42	Can change Country	14	change_country
43	Can delete Country	14	delete_country
44	Can add Location	15	add_location
45	Can change Location	15	change_location
46	Can delete Location	15	delete_location
47	Can add Address	16	add_address
48	Can change Address	16	change_address
49	Can delete Address	16	delete_address
50	Can view address	16	view_address
51	Can add Form of payments	17	add_paymentform
52	Can change Form of payments	17	change_paymentform
53	Can delete Form of payments	17	delete_paymentform
54	Can add Payment	18	add_payment
55	Can change Payment	18	change_payment
56	Can delete Payment	18	delete_payment
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('auth_permission_id_seq', 56, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	account	emailaddress
8	account	emailconfirmation
9	users	user
10	trips	trip
11	trips	image
12	orders	order
13	orders	guest
14	locations	country
15	locations	location
16	addresses	address
17	payments	paymentform
18	payments	payment
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('django_content_type_id_seq', 18, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-05-11 07:29:09.900867+02
2	contenttypes	0002_remove_content_type_name	2016-05-11 07:29:09.960471+02
3	auth	0001_initial	2016-05-11 07:29:10.32504+02
4	auth	0002_alter_permission_name_max_length	2016-05-11 07:29:10.375932+02
5	auth	0003_alter_user_email_max_length	2016-05-11 07:29:10.413964+02
6	auth	0004_alter_user_username_opts	2016-05-11 07:29:10.453921+02
7	auth	0005_alter_user_last_login_null	2016-05-11 07:29:10.498173+02
8	auth	0006_require_contenttypes_0002	2016-05-11 07:29:10.517565+02
9	users	0001_initial	2016-05-11 07:29:10.958709+02
10	account	0001_initial	2016-05-11 07:29:11.255949+02
11	account	0002_email_max_length	2016-05-11 07:29:11.327792+02
12	addresses	0001_initial	2016-05-11 07:29:11.446639+02
13	addresses	0002_auto_20160409_1145	2016-05-11 07:29:11.602634+02
14	addresses	0003_auto_20160511_0522	2016-05-11 07:29:11.682567+02
15	admin	0001_initial	2016-05-11 07:29:11.871467+02
16	admin	0002_logentry_remove_auto_add	2016-05-11 07:29:11.940482+02
17	auth	0007_alter_validators_add_error_messages	2016-05-11 07:29:12.013938+02
18	locations	0001_initial	2016-05-11 07:29:12.241642+02
19	locations	0002_auto_20160409_0001	2016-05-11 07:29:12.260532+02
20	locations	0003_location_country	2016-05-11 07:29:12.46219+02
21	locations	0004_auto_20160409_0008	2016-05-11 07:29:12.515238+02
22	locations	0005_auto_20160428_0006	2016-05-11 07:29:12.544362+02
23	users	0002_auto_20160408_2342	2016-05-11 07:29:12.787896+02
24	trips	0001_initial	2016-05-11 07:29:13.251887+02
25	orders	0001_initial	2016-05-11 07:29:13.428557+02
26	orders	0002_order_note	2016-05-11 07:29:13.655308+02
27	orders	0003_order_address	2016-05-11 07:29:13.894318+02
28	orders	0004_auto_20160409_1145	2016-05-11 07:29:14.016654+02
29	orders	0005_auto_20160409_1421	2016-05-11 07:29:14.091636+02
30	orders	0006_auto_20160428_0005	2016-05-11 07:29:14.21215+02
31	orders	0007_order_unit_price	2016-05-11 07:29:14.434127+02
32	orders	0008_auto_20160428_2304	2016-05-11 07:29:14.506475+02
33	orders	0009_guest	2016-05-11 07:29:14.641265+02
34	orders	0010_auto_20160511_0457	2016-05-11 07:29:14.842148+02
35	orders	0011_auto_20160511_0522	2016-05-11 07:29:14.910512+02
36	payments	0001_initial	2016-05-11 07:29:15.255135+02
37	payments	0002_auto_20160510_2343	2016-05-11 07:29:15.391386+02
38	sessions	0001_initial	2016-05-11 07:29:15.537667+02
39	sites	0001_initial	2016-05-11 07:29:15.612964+02
40	sites	0002_set_site_domain_and_name	2016-05-11 07:29:15.657663+02
41	sites	0003_auto_20160408_2342	2016-05-11 07:29:15.741122+02
42	trips	0002_auto_20160409_0125	2016-05-11 07:29:16.03251+02
43	trips	0003_auto_20160409_0330	2016-05-11 07:29:16.133828+02
44	trips	0004_auto_20160430_1045	2016-05-11 07:29:16.258139+02
45	trips	0005_auto_20160510_2244	2016-05-11 07:29:16.328358+02
46	users	0003_delete_address	2016-05-11 07:29:16.366186+02
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('django_migrations_id_seq', 46, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
bv4kanw2zsol45vyz52grf4wdkeh7o8j	OGU1MGUwNDUyYjQ0MzQwYmIxNjFiZGI5N2ZmYTU1YjMwYTJkY2Y5Yjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWNkYTFlODY4MDQ1NjM1OTYxYTQ1N2M5ODA4NmVmOGNmNDljN2JhYSIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2016-05-25 07:30:22.329255+02
bjufs4tkte12za0jpej16nwq9wa11us4	ODNkZjRkMGYwZjYzNTM4YzEyODBmOWM1NWNkZjIzM2E5ZTVlM2M5Mzp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWNkYTFlODY4MDQ1NjM1OTYxYTQ1N2M5ODA4NmVmOGNmNDljN2JhYSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==	2016-06-07 03:07:28.842864+02
isz1ftbfhp8j54rqtj7xfjyi7l4vvdn7	ODNkZjRkMGYwZjYzNTM4YzEyODBmOWM1NWNkZjIzM2E5ZTVlM2M5Mzp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWNkYTFlODY4MDQ1NjM1OTYxYTQ1N2M5ODA4NmVmOGNmNDljN2JhYSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==	2016-06-17 18:51:10.026181+02
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY django_site (id, domain, name) FROM stdin;
1	taravel.jawne.info.pl	taravel
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('django_site_id_seq', 1, false);


--
-- Data for Name: locations_country; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY locations_country (id, continent, name, slug) FROM stdin;
1	5	Polska	polska
\.


--
-- Name: locations_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('locations_country_id_seq', 1, true);


--
-- Data for Name: locations_location; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY locations_location (id, name, slug, "position", country_id) FROM stdin;
1	Łazy	łazy	0101000020E610000000000000D02B33404079975A0C684940	1
2	Łazy	łazy-2	0101000020E610000000000000D02B33404079975A0C684940	1
\.


--
-- Name: locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('locations_location_id_seq', 2, true);


--
-- Data for Name: orders_guest; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY orders_guest (id, first_name, second_name, order_id, document_id) FROM stdin;
1	250	250	1	25000
\.


--
-- Name: orders_guest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('orders_guest_id_seq', 1, true);


--
-- Data for Name: orders_order; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY orders_order (id, created, trip_id, user_id, note, address_id, unit_price) FROM stdin;
1	2016-06-03 18:52:42.225002+02	1	1	aasdasdasdsa	1	250
\.


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('orders_order_id_seq', 1, true);


--
-- Data for Name: payments_payment; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY payments_payment (id, created, cashier_id, form_id, order_id) FROM stdin;
\.


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('payments_payment_id_seq', 1, false);


--
-- Data for Name: payments_paymentform; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY payments_paymentform (id, name) FROM stdin;
\.


--
-- Name: payments_paymentform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('payments_paymentform_id_seq', 1, false);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: trips_image; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY trips_image (id, file, trip_id) FROM stdin;
\.


--
-- Name: trips_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('trips_image_id_seq', 1, false);


--
-- Data for Name: trips_trip; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY trips_trip (id, created, modified, name, slug, description, base_price, space, main_image, created_by_id, location_id) FROM stdin;
1	2016-06-03 18:51:43.148218+02	2016-06-03 18:51:43.205649+02	XXXX	xxxx	<p>XX</p>	250	10	images/Zaznaczenie_602.png	1	1
\.


--
-- Name: trips_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('trips_trip_id_seq', 1, true);


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY users_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, name, discount) FROM stdin;
1	pbkdf2_sha256$24000$BCZPgnWCskoF$/JH2UuE4RaQZ5FS7xBogjZcbgrvCbtQbhacx/CAlnmA=	2016-06-03 18:51:10.016771+02	t	a			a@a.pl	t	t	2016-05-11 07:29:45.760751+02		0
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('users_user_id_seq', 1, true);


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: adas
--

COPY users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adas
--

SELECT pg_catalog.setval('users_user_user_permissions_id_seq', 1, false);


--
-- Name: account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: addresses_address_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY addresses_address
    ADD CONSTRAINT addresses_address_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: locations_country_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY locations_country
    ADD CONSTRAINT locations_country_pkey PRIMARY KEY (id);


--
-- Name: locations_country_slug_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY locations_country
    ADD CONSTRAINT locations_country_slug_key UNIQUE (slug);


--
-- Name: locations_location_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_location_pkey PRIMARY KEY (id);


--
-- Name: locations_location_slug_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_location_slug_key UNIQUE (slug);


--
-- Name: orders_guest_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY orders_guest
    ADD CONSTRAINT orders_guest_pkey PRIMARY KEY (id);


--
-- Name: orders_order_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);


--
-- Name: payments_payment_order_id_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY payments_payment
    ADD CONSTRAINT payments_payment_order_id_key UNIQUE (order_id);


--
-- Name: payments_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY payments_payment
    ADD CONSTRAINT payments_payment_pkey PRIMARY KEY (id);


--
-- Name: payments_paymentform_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY payments_paymentform
    ADD CONSTRAINT payments_paymentform_pkey PRIMARY KEY (id);


--
-- Name: trips_image_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY trips_image
    ADD CONSTRAINT trips_image_pkey PRIMARY KEY (id);


--
-- Name: trips_trip_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_pkey PRIMARY KEY (id);


--
-- Name: trips_trip_slug_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_slug_key UNIQUE (slug);


--
-- Name: users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups_user_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions_user_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: adas; Tablespace: 
--

ALTER TABLE ONLY users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: account_emailaddress_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX account_emailaddress_e8701ad4 ON account_emailaddress USING btree (user_id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailconfirmation_6f1edeac; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX account_emailconfirmation_6f1edeac ON account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: addresses_address_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX addresses_address_e8701ad4 ON addresses_address USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: locations_country_slug_bafce7fc_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX locations_country_slug_bafce7fc_like ON locations_country USING btree (slug varchar_pattern_ops);


--
-- Name: locations_location_93bfec8a; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX locations_location_93bfec8a ON locations_location USING btree (country_id);


--
-- Name: locations_location_position_id; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX locations_location_position_id ON locations_location USING gist ("position");


--
-- Name: locations_location_slug_0338bba7_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX locations_location_slug_0338bba7_like ON locations_location USING btree (slug varchar_pattern_ops);


--
-- Name: orders_guest_69dfcb07; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX orders_guest_69dfcb07 ON orders_guest USING btree (order_id);


--
-- Name: orders_order_c65d32e5; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX orders_order_c65d32e5 ON orders_order USING btree (trip_id);


--
-- Name: orders_order_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX orders_order_e8701ad4 ON orders_order USING btree (user_id);


--
-- Name: orders_order_ea8e5d12; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX orders_order_ea8e5d12 ON orders_order USING btree (address_id);


--
-- Name: payments_payment_1f6b8526; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX payments_payment_1f6b8526 ON payments_payment USING btree (cashier_id);


--
-- Name: payments_payment_d6cba1ad; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX payments_payment_d6cba1ad ON payments_payment USING btree (form_id);


--
-- Name: trips_image_c65d32e5; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX trips_image_c65d32e5 ON trips_image USING btree (trip_id);


--
-- Name: trips_trip_e274a5da; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX trips_trip_e274a5da ON trips_trip USING btree (location_id);


--
-- Name: trips_trip_e93cb7eb; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX trips_trip_e93cb7eb ON trips_trip USING btree (created_by_id);


--
-- Name: trips_trip_slug_61ab4bbd_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX trips_trip_slug_61ab4bbd_like ON trips_trip USING btree (slug varchar_pattern_ops);


--
-- Name: users_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX users_user_groups_0e939a4f ON users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX users_user_groups_e8701ad4 ON users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX users_user_user_permissions_8373b171 ON users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX users_user_user_permissions_e8701ad4 ON users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: adas; Tablespace: 
--

CREATE INDEX users_user_username_06e46fe6_like ON users_user USING btree (username varchar_pattern_ops);


--
-- Name: account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY account_emailconfirmation
    ADD CONSTRAINT account_em_email_address_id_5b7f8c58_fk_account_emailaddress_id FOREIGN KEY (email_address_id) REFERENCES account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress_user_id_2c513194_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: addresses_address_user_id_01a7dcfa_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY addresses_address
    ADD CONSTRAINT addresses_address_user_id_01a7dcfa_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: locations_location_country_id_eb02e82c_fk_locations_country_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY locations_location
    ADD CONSTRAINT locations_location_country_id_eb02e82c_fk_locations_country_id FOREIGN KEY (country_id) REFERENCES locations_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_guest_order_id_2ecfa65d_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_guest
    ADD CONSTRAINT orders_guest_order_id_2ecfa65d_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order_address_id_0daf897b_fk_addresses_address_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_order
    ADD CONSTRAINT orders_order_address_id_0daf897b_fk_addresses_address_id FOREIGN KEY (address_id) REFERENCES addresses_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order_trip_id_082877af_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_order
    ADD CONSTRAINT orders_order_trip_id_082877af_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order_user_id_e9b59eb1_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY orders_order
    ADD CONSTRAINT orders_order_user_id_e9b59eb1_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payment_cashier_id_a46eee7b_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY payments_payment
    ADD CONSTRAINT payments_payment_cashier_id_a46eee7b_fk_users_user_id FOREIGN KEY (cashier_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payment_form_id_89512cda_fk_payments_paymentform_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY payments_payment
    ADD CONSTRAINT payments_payment_form_id_89512cda_fk_payments_paymentform_id FOREIGN KEY (form_id) REFERENCES payments_paymentform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payment_order_id_22c479b7_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY payments_payment
    ADD CONSTRAINT payments_payment_order_id_22c479b7_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_image_trip_id_65ad1c0e_fk_trips_trip_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY trips_image
    ADD CONSTRAINT trips_image_trip_id_65ad1c0e_fk_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_created_by_id_f8d8c76e_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_created_by_id_f8d8c76e_fk_users_user_id FOREIGN KEY (created_by_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trips_trip_location_id_de3738c4_fk_locations_location_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY trips_trip
    ADD CONSTRAINT trips_trip_location_id_de3738c4_fk_locations_location_id FOREIGN KEY (location_id) REFERENCES locations_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_pe_permission_id_0b93982e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: adas
--

ALTER TABLE ONLY users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

