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
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

CREATE TABLE customers (
    customer_id bpchar NOT NULL PRIMARY KEY,
    contact_name character varying(30),
    address character varying(60),
    city character varying(60),
    postcode character varying(60),
    country character varying(60),
    phone_number character varying(60),
);

CREATE TABLE products (
    product_id smallint NOT NULL PRIMARY KEY,
    product_name character varying(40) NOT NULL,
    quantity_per_unit character varying(20),
    unit_price real,
    discontinued integer NOT NULL,
);

CREATE TABLE shops (
    shop_id smallint NOT NULL PRIMARY KEY,
    city varchar(30),
    country varchar(30),
);

CREATE TABLE orders (
    order_id smallint NOT NULL PRIMARY KEY,
    customer_id bpchar,
    shop_id smallint,
    order_date date,
    FOREIGN KEY (customer_id) REFERENCES customers,
    FOREIGN KEY (shop_id) REFERENCES shops,
);

CREATE TABLE order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products,
    FOREIGN KEY (order_id) REFERENCES orders
);