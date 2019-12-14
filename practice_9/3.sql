/*
1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости 
   от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
   с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
   с 00:00 до 6:00 — "Доброй ночи".
*/

DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(255) READS SQL DATA
BEGIN
    DECLARE hour_ INT;
    SET hour_ = HOUR(now());
    CASE
         WHEN hour_ BETWEEN 0 AND 5 THEN
              RETURN "Доброй ночи";
         WHEN hour_ BETWEEN 6 AND 11 THEN
              RETURN "Доброе утро";
         WHEN hour_ BETWEEN 12 AND 17 THEN
              RETURN "Добрый день";
         WHEN hour_ BETWEEN 18 AND 23 THEN
              RETURN "Добрый вечер";
    END CASE;
END//
DELIMITER ;


/*
2) В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
   Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
   значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
   При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

DELIMITER //

DROP TRIGGER IF EXISTS tesk2_delete//
CREATE TRIGGER task2_delete BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
      IF NEW.name IS NULL AND NEW.description IS NULL THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Имя и описания не могут быть пустыми одновременно.";
      END IF;
END//


DROP TRIGGER IF EXISTS tesk2_update//
CREATE TRIGGER task2_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN 
      IF NEW.name IS NULL AND NEW.description IS NULL THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Имя и описания не могут быть пустыми одновременно.";
      END IF;
END//

DELIMITER ;


/*
3) (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
   Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
   Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

DELIMITER //

DROP FUNCTION IF EXISTS FIBONACCI//

CREATE FUNCTION FIBONACCI(value INT)
RETURNS INT DETERMINISTIC
BEGIN
   DECLARE i INT DEFAULT 1;

   DECLARE a INT DEFAULT 0;
   DECLARE b INT DEFAULT 1;
   DECLARE c INT DEFAULT 1;
  
   IF (value = 0) THEN
       RETURN 0;
   END IF;
  
   WHILE i < value DO
        SET c = b;
          SET b = a + b;
        SET a = c;
        SET i = i + 1;
   END WHILE;
  
   RETURN b;
END//
DELIMITER ;
