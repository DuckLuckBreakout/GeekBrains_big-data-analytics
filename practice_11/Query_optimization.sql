/*
  1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
     catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
     идентификатор первичного ключа и содержимое поля name.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  created_at DATETIME NOT NULL,
  table_name VARCHAR(255) NOT NULL,
  key_id BIGINT(10) NOT NULL,
  name VARCHAR(255) NOT NULL
) ENGINE=Archive;

DROP TRIGGER IF EXISTS logs_users;
DELIMITER //
CREATE TRIGGER logs_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;


DROP TRIGGER IF EXISTS logs_catalogs;
DELIMITER //
CREATE TRIGGER logs_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;


DROP TRIGGER IF EXISTS logs_products;
DELIMITER //
CREATE TRIGGER logs_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;




/*
   2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
CREATE TABLE samples (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
)ENGINE = HEAP;


INSERT INTO samples (name, birthday_at) 
     VALUES
            ('Дмитрий', '2000-01-01'),
            ('Елизавета', '1992-11-21'),
            ('Иван', '1990-08-09'),
            ('Инна', '2005-02-11'),
            ('Кристина', '1967-02-04'),
            ('Леонид', '1998-07-14'),
            ('Матвей', '1991-11-11'),
            ('Михаил', '1990-12-21'),
            ('Николай', '1977-10-14'),
            ('Полина', '2001-02-03');


INSERT INTO users (users.name, users.birthday_at) 
     SELECT t1.name, t1.birthday_at
       FROM samples AS t1,
            samples AS t2,
            samples AS t3,
            samples AS t4,
            samples AS t5,
            samples AS t6;


