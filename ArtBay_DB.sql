--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.14
-- Dumped by pg_dump version 9.3.14
-- Started on 2016-11-05 21:46:14 AST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2084 (class 1262 OID 16526)
-- Dependencies: 2083
-- Name: ArtBay_DB; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON DATABASE "ArtBay_DB" IS 'Database for the ArtBay website application project.';


--
-- TOC entry 1 (class 3079 OID 11787)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 16747)
-- Name: advertisement; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE advertisement (
    aid integer NOT NULL,
    adprice double precision,
    duration integer,
    addimage character varying(250),
    link character varying(250),
    adddescription character varying(500)
);


--
-- TOC entry 181 (class 1259 OID 16745)
-- Name: advertisement_aid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE advertisement_aid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 181
-- Name: advertisement_aid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE advertisement_aid_seq OWNED BY advertisement.aid;


--
-- TOC entry 172 (class 1259 OID 16537)
-- Name: artuser; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE artuser (
    uid integer NOT NULL,
    ufirst character varying(15),
    ulast character varying(15),
    unickname character varying(15),
    uemail character varying(50),
    passwrd character varying(50),
    ustreet character varying(100),
    ucity character varying(20),
    ustate character(2),
    uzip integer
);


--
-- TOC entry 171 (class 1259 OID 16535)
-- Name: artuser_uid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE artuser_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 171
-- Name: artuser_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE artuser_uid_seq OWNED BY artuser.uid;


--
-- TOC entry 185 (class 1259 OID 16784)
-- Name: auctions; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auctions (
    aid integer NOT NULL,
    iid integer,
    startingbid double precision,
    adeadline character(8)
);


--
-- TOC entry 184 (class 1259 OID 16782)
-- Name: auctions_aid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auctions_aid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 184
-- Name: auctions_aid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auctions_aid_seq OWNED BY auctions.aid;


--
-- TOC entry 186 (class 1259 OID 16795)
-- Name: bids; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE bids (
    aid integer,
    uid integer,
    bid double precision
);



--
-- TOC entry 178 (class 1259 OID 16677)
-- Name: commission; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE commission (
    petitioner integer NOT NULL,
    artist integer,
    price double precision,
    cdeadline character(8),
    ctype character varying(15),
    cdescription character varying(250)
);



--
-- TOC entry 175 (class 1259 OID 16595)
-- Name: creditcard; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE creditcard (
    cid integer NOT NULL,
    uid integer,
    cname character varying(15),
    cnumber integer,
    ctype character varying(15),
    expdate character(8)
);



--
-- TOC entry 174 (class 1259 OID 16593)
-- Name: creditcard_cid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE creditcard_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 174
-- Name: creditcard_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE creditcard_cid_seq OWNED BY creditcard.cid;


--
-- TOC entry 177 (class 1259 OID 16609)
-- Name: item; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE item (
    iid integer NOT NULL,
    uid integer,
    iname character varying(15),
    price double precision,
    itype character varying(15),
    icolor character varying(15),
    featured character(1),
    imageurl character varying(250),
    dimensions character varying(15),
    idescription character varying(250)
);



--
-- TOC entry 176 (class 1259 OID 16607)
-- Name: item_iid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE item_iid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 176
-- Name: item_iid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE item_iid_seq OWNED BY item.iid;


--
-- TOC entry 179 (class 1259 OID 16709)
-- Name: itemreview; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE itemreview (
    iid integer NOT NULL,
    reviewer integer,
    comment character varying(500),
    rating integer
);


--
-- TOC entry 183 (class 1259 OID 16769)
-- Name: purchases; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE purchases (
    iid integer,
    uid integer,
    qty integer,
    shprice double precision,
    shcompany character varying(15),
    totalprice double precision,
    date character(8)
);



--
-- TOC entry 187 (class 1259 OID 16809)
-- Name: shoppingcart; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE shoppingcart (
    uid integer,
    iid integer
);



--
-- TOC entry 173 (class 1259 OID 16583)
-- Name: uphone; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE uphone (
    uid integer NOT NULL,
    phonenum character(10)
);



--
-- TOC entry 180 (class 1259 OID 16727)
-- Name: userreview; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE userreview (
    uid integer NOT NULL,
    reviewer integer,
    comment character varying(500),
    rating integer
);



--
-- TOC entry 1919 (class 2604 OID 16750)
-- Name: aid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY advertisement ALTER COLUMN aid SET DEFAULT nextval('advertisement_aid_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 16540)
-- Name: uid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY artuser ALTER COLUMN uid SET DEFAULT nextval('artuser_uid_seq'::regclass);


--
-- TOC entry 1920 (class 2604 OID 16787)
-- Name: aid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auctions ALTER COLUMN aid SET DEFAULT nextval('auctions_aid_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 16598)
-- Name: cid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY creditcard ALTER COLUMN cid SET DEFAULT nextval('creditcard_cid_seq'::regclass);


--
-- TOC entry 1918 (class 2604 OID 16612)
-- Name: iid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY item ALTER COLUMN iid SET DEFAULT nextval('item_iid_seq'::regclass);


--
-- TOC entry 2073 (class 0 OID 16747)
-- Dependencies: 182
-- Data for Name: advertisement; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 181
-- Name: advertisement_aid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('advertisement_aid_seq', 1, false);


--
-- TOC entry 2063 (class 0 OID 16537)
-- Dependencies: 172
-- Data for Name: artuser; Type: TABLE DATA; Schema: public; Owner: admin
--




--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 171
-- Name: artuser_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('artuser_uid_seq', 1, false);


--
-- TOC entry 2076 (class 0 OID 16784)
-- Dependencies: 185
-- Data for Name: auctions; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 184
-- Name: auctions_aid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auctions_aid_seq', 1, false);


--
-- TOC entry 2077 (class 0 OID 16795)
-- Dependencies: 186
-- Data for Name: bids; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2069 (class 0 OID 16677)
-- Dependencies: 178
-- Data for Name: commission; Type: TABLE DATA; Schema: public; Owner: admin
--




--
-- TOC entry 2066 (class 0 OID 16595)
-- Dependencies: 175
-- Data for Name: creditcard; Type: TABLE DATA; Schema: public; Owner: admin
--




--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 174
-- Name: creditcard_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('creditcard_cid_seq', 1, false);


--
-- TOC entry 2068 (class 0 OID 16609)
-- Dependencies: 177
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: admin
--




--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 176
-- Name: item_iid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('item_iid_seq', 1, false);


--
-- TOC entry 2070 (class 0 OID 16709)
-- Dependencies: 179
-- Data for Name: itemreview; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2074 (class 0 OID 16769)
-- Dependencies: 183
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 2078 (class 0 OID 16809)
-- Dependencies: 187
-- Data for Name: shoppingcart; Type: TABLE DATA; Schema: public; Owner: admin
--




--
-- TOC entry 2064 (class 0 OID 16583)
-- Dependencies: 173
-- Data for Name: uphone; Type: TABLE DATA; Schema: public; Owner: admin
--


--
-- TOC entry 2071 (class 0 OID 16727)
-- Dependencies: 180
-- Data for Name: userreview; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 1936 (class 2606 OID 16755)
-- Name: advertisement_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY advertisement
    ADD CONSTRAINT advertisement_pkey PRIMARY KEY (aid);


--
-- TOC entry 1922 (class 2606 OID 16545)
-- Name: artuser_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY artuser
    ADD CONSTRAINT artuser_pkey PRIMARY KEY (uid);


--
-- TOC entry 1938 (class 2606 OID 16789)
-- Name: auctions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auctions
    ADD CONSTRAINT auctions_pkey PRIMARY KEY (aid);


--
-- TOC entry 1930 (class 2606 OID 16681)
-- Name: commission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY commission
    ADD CONSTRAINT commission_pkey PRIMARY KEY (petitioner);


--
-- TOC entry 1926 (class 2606 OID 16600)
-- Name: creditcard_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY creditcard
    ADD CONSTRAINT creditcard_pkey PRIMARY KEY (cid);


--
-- TOC entry 1928 (class 2606 OID 16617)
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (iid);


--
-- TOC entry 1932 (class 2606 OID 16716)
-- Name: itemreview_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY itemreview
    ADD CONSTRAINT itemreview_pkey PRIMARY KEY (iid);


--
-- TOC entry 1924 (class 2606 OID 16587)
-- Name: uphone_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY uphone
    ADD CONSTRAINT uphone_pkey PRIMARY KEY (uid);


--
-- TOC entry 1934 (class 2606 OID 16734)
-- Name: userreview_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY userreview
    ADD CONSTRAINT userreview_pkey PRIMARY KEY (uid);


--
-- TOC entry 1950 (class 2606 OID 16790)
-- Name: auctions_iid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auctions
    ADD CONSTRAINT auctions_iid_fkey FOREIGN KEY (iid) REFERENCES item(iid);


--
-- TOC entry 1951 (class 2606 OID 16798)
-- Name: bids_aid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_aid_fkey FOREIGN KEY (aid) REFERENCES auctions(aid);


--
-- TOC entry 1952 (class 2606 OID 16803)
-- Name: bids_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1943 (class 2606 OID 16687)
-- Name: commission_artist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY commission
    ADD CONSTRAINT commission_artist_fkey FOREIGN KEY (artist) REFERENCES artuser(uid);


--
-- TOC entry 1942 (class 2606 OID 16682)
-- Name: commission_petitioner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY commission
    ADD CONSTRAINT commission_petitioner_fkey FOREIGN KEY (petitioner) REFERENCES artuser(uid);


--
-- TOC entry 1940 (class 2606 OID 16601)
-- Name: creditcard_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY creditcard
    ADD CONSTRAINT creditcard_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1941 (class 2606 OID 16618)
-- Name: item_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1944 (class 2606 OID 16717)
-- Name: itemreview_iid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY itemreview
    ADD CONSTRAINT itemreview_iid_fkey FOREIGN KEY (iid) REFERENCES item(iid);


--
-- TOC entry 1945 (class 2606 OID 16722)
-- Name: itemreview_reviewer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY itemreview
    ADD CONSTRAINT itemreview_reviewer_fkey FOREIGN KEY (reviewer) REFERENCES artuser(uid);


--
-- TOC entry 1948 (class 2606 OID 16772)
-- Name: purchases_iid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY purchases
    ADD CONSTRAINT purchases_iid_fkey FOREIGN KEY (iid) REFERENCES item(iid);


--
-- TOC entry 1949 (class 2606 OID 16777)
-- Name: purchases_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY purchases
    ADD CONSTRAINT purchases_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1954 (class 2606 OID 16817)
-- Name: shoppingcart_iid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY shoppingcart
    ADD CONSTRAINT shoppingcart_iid_fkey FOREIGN KEY (iid) REFERENCES item(iid);


--
-- TOC entry 1953 (class 2606 OID 16812)
-- Name: shoppingcart_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY shoppingcart
    ADD CONSTRAINT shoppingcart_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1939 (class 2606 OID 16588)
-- Name: uphone_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY uphone
    ADD CONSTRAINT uphone_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 1947 (class 2606 OID 16740)
-- Name: userreview_reviewer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY userreview
    ADD CONSTRAINT userreview_reviewer_fkey FOREIGN KEY (reviewer) REFERENCES artuser(uid);


--
-- TOC entry 1946 (class 2606 OID 16735)
-- Name: userreview_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY userreview
    ADD CONSTRAINT userreview_uid_fkey FOREIGN KEY (uid) REFERENCES artuser(uid);


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--F


--
-- TOC entry 1548 (class 826 OID 16822)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

-- Completed on 2016-11-05 21:46:15 AST

--
-- PostgreSQL database dump complete
--

