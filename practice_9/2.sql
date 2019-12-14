/*
1) Создайте двух пользователей которые имеют доступ к базе данных shop. 
   Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
   второму пользователю shop — любые операции в пределах базы данных shop.
*/

CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas1';
CREATE USER shop IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas2';
GRANT ALL ON shop.* TO 'shop';
GRANT SELECT ON shop.* TO 'shop_read';

/*
2) (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
   содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, 
   предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
   однако, мог бы извлекать записи из представления username.
*/

CREATE TABLE accounts(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    password VARCHAR(255)
    );

DROP VIEW IF EXISTS username;
CREATE VIEW username AS SELECT id, name FROM accounts;


CREATE USER user_read IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas3';
GRANT SELECT ON username TO 'user_read';
