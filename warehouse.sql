DROP TABLE IF EXISTS w_sales;
DROP TABLE IF EXISTS w_products;
DROP TABLE IF EXISTS w_clients;
DROP TABLE IF EXISTS W_shops;
DROP TABLE IF EXISTS w_dates;

-- products
SELECT
    product_id AS "id_product",
    (CASE
        WHEN unit_price<20 THEN 1
        WHEN unit_price<40 THEN 2
        ELSE 3
    END) AS "price_class",
    (CASE
        WHEN discontinued=0 THEN 1
        WHEN discontinued=1 THEN 0
    END) AS "availibility"
INTO w_products
FROM products;
ALTER TABLE w_products ADD PRIMARY KEY (id_product);

-- shops
SELECT 
    shop_id AS "id_shop",
    city,
    country
INTO w_shops
FROM shops;
ALTER TABLE w_shops ADD PRIMARY KEY (id_shop);

-- dates
SELECT DISTINCT
    order_date AS "full_date",
    date_part('month', order_date) AS "month",
    date_part('quarter', order_date) AS "quarter",
    date_part('year', order_date) AS "year"
INTO w_dates
FROM orders;
ALTER TABLE w_dates ADD id_date SERIAL PRIMARY KEY;

-- clients
SELECT
    people.person_id AS "id_client",
    people.person_name,
    people.education,
    (CASE
        WHEN people.salary<3000 THEN 1
        WHEN people.salary<5000 THEN 2
        ELSE 3
    END) AS "wealthiness",
    people.age,
    interests.interest_name
INTO w_clients
FROM people
INNER JOIN interests
ON people.interest_id = interests.interest_id;
ALTER TABLE w_clients ADD PRIMARY KEY (id_client);

-- sales
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
);
INSERT INTO w_sales
SELECT 
    (SELECT w_dates.id_date 
    FROM w_dates
    WHERE w_dates.full_date = orders.order_date),
    order_details.product_id AS "id_product",
    orders.shop_id AS "id_shop",
    (SELECT id_client
    FROM w_clients
    WHERE people.person_name = w_clients.person_name),
    order_details.unit_price
    * order_details.quantity
    * (1-order_details.discount)
    AS "price",
    order_details.quantity AS "items_amount"
FROM order_details
INNER JOIN orders
ON order_details.order_id = orders.order_id
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN people
ON customers.contact_name = people.person_name;