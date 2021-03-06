/*
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  1 | Геннадий           | 1990-10-05  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  2 | Наталья            | 1984-11-12  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  3 | Александр          | 1985-05-20  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  4 | Сергей             | 1988-02-14  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  5 | Иван               | 1998-01-12  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  6 | Мария              | 1992-08-29  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
+----+--------------------+-------------+---------------------+---------------------+
6 rows in set (0,00 sec)
*/

SELECT * FROM users
    WHERE MONTHNAME(birthday_at) IN ('may', 'august')
/*
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  3 | Александр          | 1985-05-20  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
|  6 | Мария              | 1992-08-29  | 2019-11-20 14:01:24 | 2019-11-20 14:01:24 |
+----+--------------------+-------------+---------------------+---------------------+
2 rows in set (0,01 sec)
*/
