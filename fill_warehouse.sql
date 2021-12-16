DROP TABLE IF EXISTS w_products;
DROP TABLE IF EXISTS w_clients;
DROP TABLE IF EXISTS W_shops;
DROP TABLE IF EXISTS w_dates;
DROP TABLE IF EXISTS w_sales;


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

-- shops
SELECT 
    shop_id AS "id_shop",
    city,
    country
INTO w_shops
FROM shops;

-- dates
SELECT DISTINCT
    date_part('month', order_date) AS "month",
    date_part('quarter', order_date) AS "quarter",
    date_part('year', order_date) AS "year"
INTO w_dates
FROM orders;
ALTER TABLE w_dates ADD id_date SERIAL PRIMARY KEY;

-- clients
SELECT
    people.person_id AS "id_client",
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
ON people.interest_id = interests.interest_id