DROP TABLE IF EXISTS user_with_bad_fields;
CREATE TABLE user_with_bad_fields (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO user_with_bad_fields (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.12.2017 18:01'),
  ('Наталья', '1984-11-12', '12.11.2013 10:10', '21.11.2018 19:12'),
  ('Александр', '1985-05-20', '18.01.2001 21:00', '18.01.2001 21:00'),
  ('Сергей', '1988-02-14', '25.12.2012 22:00', '31.12.2018 14:13'),
  ('Иван', '1998-01-12', '10.10.2010 19:00', '12.10.2011 1:20'),
  ('Мария', '1992-08-29', '19.04.2001 23:59', '20.04.2001 11:00');

/*
+----+--------------------+-------------+------------------+------------------+
| id | name               | birthday_at | created_at       | updated_at       |
+----+--------------------+-------------+------------------+------------------+
|  1 | Геннадий           | 1990-10-05  | 20.10.2017 8:10  | 20.12.2017 18:01 |
|  2 | Наталья            | 1984-11-12  | 12.11.2013 10:10 | 21.11.2018 19:12 |
|  3 | Александр          | 1985-05-20  | 18.01.2001 21:00 | 18.01.2001 21:00 |
|  4 | Сергей             | 1988-02-14  | 25.12.2012 22:00 | 31.12.2018 14:13 |
|  5 | Иван               | 1998-01-12  | 10.10.2010 19:00 | 12.10.2011 1:20  |
|  6 | Мария              | 1992-08-29  | 19.04.2001 23:59 | 20.04.2001 11:00 |
+----+--------------------+-------------+------------------+------------------+
6 rows in set (0,00 sec)
*/

UPDATE user_with_bad_fields
    SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
ALTER TABLE user_with_bad_fields MODIFY COLUMN created_at DATETIME;

UPDATE user_with_bad_fields
    SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE user_with_bad_fields MODIFY COLUMN updated_at DATETIME;
/*
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  1 | Геннадий           | 1990-10-05  | 2017-10-20 08:10:00 | 2017-12-20 18:01:00 |
|  2 | Наталья            | 1984-11-12  | 2013-11-12 10:10:00 | 2018-11-21 19:12:00 |
|  3 | Александр          | 1985-05-20  | 2001-01-18 21:00:00 | 2001-01-18 21:00:00 |
|  4 | Сергей             | 1988-02-14  | 2012-12-25 22:00:00 | 2018-12-31 14:13:00 |
|  5 | Иван               | 1998-01-12  | 2010-10-10 19:00:00 | 2011-10-12 01:20:00 |
|  6 | Мария              | 1992-08-29  | 2001-04-19 23:59:00 | 2001-04-20 11:00:00 |
+----+--------------------+-------------+---------------------+---------------------+
6 rows in set (0,01 sec)
*/

