-- PostgreSQL config
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

-- Drop old tables
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS people;

CREATE TABLE interests (
    interest_id smallint PRIMARY KEY,
    likes integer NOT NULL,
    interest_name character varying(30)
);

CREATE TABLE people (
    person_id smallint PRIMARY KEY,
    person_name character varying(30),
    age integer,
    gender character varying(30),
    education character varying(20),
    salary integer,
    interest_id integer,
    FOREIGN KEY (interest_id) REFERENCES interests
);