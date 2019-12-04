-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

-- Вариант №1
SELECT
  *
FROM
  users
WHERE
  id
  IN
    (SELECT 
      user_id 
    FROM 
      orders);

-- Вариант №2
SELECT
  *
FROM
  users
WHERE EXISTS
   (SELECT 
      user_id 
    FROM 
      orders
    WHERE 
      orders.user_id = users.id);

-- Вариант №3
SELECT
  DISTINCT users.*
FROM
  users JOIN orders
ON
  orders.user_id = users.id;


-- Вариант №4
SELECT
  DISTINCT users.*
FROM
  users
RIGHT JOIN
  orders
ON
  users.id = orders.user_id;




-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

-- Вариант №1
SELECT
  products.name,
  (SELECT
     catalogs.name
   FROM
     catalogs
   WHERE
     catalogs.id = products.catalog_id)
FROM 
  products
WHERE EXISTS
  (SELECT
     catalog_id
   FROM
     catalogs
   WHERE
     catalogs.id = products.catalog_id);


-- Вариант №2
SELECT
  products.name,
  catalogs.name
FROM
  products JOIN catalogs
ON
  products.catalog_id = catalogs.id;

-- Вариант №3
SELECT
  products.name,
  catalogs.name
FROM
  products
LEFT JOIN
  catalogs
ON
  products.catalog_id = catalogs.id;




/*
3) (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from_ VARCHAR(255),
  to_ VARCHAR(255)
);

INSERT INTO
  flights
VALUES
  (1, 'moscow', 'omsk'),
  (2, 'novgorod', 'kazan'),
  (3, 'irkutsk', 'moscow'),
  (4, 'omsk', 'irkutsk'),
  (5, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO
  cities
VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');

-- Вариант №1
SELECT
  id,
  (SELECT
     cities.name
   FROM
     cities
   WHERE
     cities.label = flights.from_) AS from_,
  (SELECT
     cities.name
   FROM
     cities
   WHERE
     cities.label = flights.to_) AS to_
FROM
  flights;


-- Вариант №2
SELECT
  id,
  tabl3.from_rus AS from_,
  tabl3.to_rus AS to_
FROM 
  flights
JOIN
  (SELECT
    tabl1.label AS from_en,
    tabl2.label AS to_en,
    tabl1.name AS from_rus,
    tabl2.name AS to_rus
  FROM
    cities AS tabl1
  JOIN 
    cities AS tabl2) AS tabl3
ON
  tabl3.from_en = flights.from_ 
AND
  tabl3.to_en = flights.to_ 
ORDER BY
  id 
;



