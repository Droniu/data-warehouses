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
DROP TABLE IF EXISTS w_products;
DROP TABLE IF EXISTS w_clients;
DROP TABLE IF EXISTS W_shops;
DROP TABLE IF EXISTS w_dates;
DROP TABLE IF EXISTS w_sales;

CREATE TABLE w_products (
    id_product smallint NOT NULL PRIMARY KEY,
    price_class smallint,
    availibility smallint
);

CREATE TABLE w_clients (
    id_client smallint NOT NULL PRIMARY KEY,
    education character varying(20),
    wealthiness smallint,
    age smallint,
    interest character varying(20)
);

CREATE TABLE W_shops (
    id_shop smallint NOT NULL PRIMARY KEY,
    city character varying(20),
    country character varying(20)
);

CREATE TABLE w_dates (
    id_date smallint NOT NULL PRIMARY KEY,
    month smallint,
    quarter smallint,
    year smallint
);

CREATE TABLE w_sales (
    id_date smallint NOT NULL,
    id_product smallint NOT NULL,
    id_shop smallint NOT NULL,
    id_client smallint NOT NULL,
    price real,
    items_amount smallint,
    PRIMARY KEY (id_date, id_product, id_shop, id_client),
    FOREIGN KEY (id_date) REFERENCES w_dates,
    FOREIGN KEY (id_product) REFERENCES w_products,
    FOREIGN KEY (id_shop) REFERENCES w_shops,
    FOREIGN KEY (id_client) REFERENCES w_clients
)