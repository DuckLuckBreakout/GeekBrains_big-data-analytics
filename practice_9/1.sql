/* 
1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
   Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
   Используйте транзакции.
*/
CREATE DATABASE sample;
CREATE TABLE sample.users LIKE shop.users;

START TRANSACTION;
INSERT sample.users
      SELECT *
        FROM shop.users
       WHERE id = 1;
DELETE 
  FROM shop.users
 WHERE id = 1;
COMMIT;


/*
2) Создайте представление, которое выводит название name товарной позиции из таблицы products 
   и соответствующее название каталога name из таблицы catalogs.
*/
CREATE VIEW names_view 
  AS SELECT products.name AS pr_name, catalogs.name AS cat_name 
       FROM products
            JOIN catalogs
            ON products.catalog_id = catalogs.id;


/*
3) (по желанию) Пусть имеется таблица с календарным полем created_at. 
   В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. 
   Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
   если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

DROP TABLE IF EXISTS test;
CREATE TABLE test(
    created_at DATETIME
);

INSERT INTO test 
     VALUES ('2018-08-01'),
            ('2018-08-04'),
            ('2018-08-16'),
            ('2018-08-17');
            
DROP TABLE IF EXISTS august;
CREATE TEMPORARY TABLE august (
    days INT
);

INSERT INTO august VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
                          (11), (12),(13),(14), (15), (16), (17), (18), (19), (20),
                          (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31);


SET @start_date = '2018-07-31';
SELECT @start + INTERVAL days DAY AS date_august,
       CASE 
            WHEN test.created_at is NULL 
                 THEN 0 
            ELSE 1 END AS answer 
  FROM august
       LEFT JOIN test 
              ON @start_date + INTERVAL days DAY = test.created_at
 ORDER BY date_august;



 /*
 4) (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
    Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */

DROP TABLE IF EXISTS for_delete;
CREATE TEMPORARY TABLE for_delete 
      SELECT * 
        FROM products;



PREPARE delete_old 
   FROM "DELETE 
           FROM for_delete 
          ORDER BY created_at 
          LIMIT ?";
         
         
SET @how_much_to_delete = (SELECT COUNT(*) FROM for_delete) - 5;
EXECUTE delete_old USING @how_much_to_delete;
SELECT * FROM for_delete;

