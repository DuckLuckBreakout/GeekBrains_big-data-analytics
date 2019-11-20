--Подсчитайте средний возраст пользователей в таблице users
/*
mysql> SELECT birthday_at FROM users;                                                    
+-------------+
| birthday_at |
+-------------+
| 1990-10-05  |
| 1984-11-12  |
| 1985-05-20  |
| 1988-02-14  |
| 1998-01-12  |
| 1992-08-29  |
+-------------+
6 rows in set (0,00 sec)
*/
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) avg FROM users;
/*
mysql> SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) avg FROM users;
+---------+
| avg     |
+---------+
| 29.5000 |
+---------+
1 row in set (0,00 sec)
*/



/*
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
/*
mysql> SELECT birthday_at FROM users;                                                    
+-------------+
| birthday_at |
+-------------+
| 1990-10-05  |
| 1984-11-12  |
| 1985-05-20  |
| 1988-02-14  |
| 1998-01-12  |
| 1992-08-29  |
+-------------+
6 rows in set (0,00 sec)
*/
SELECT 
    DAYNAME(birthday_at) days,
    COUNT(*) count 
FROM 
    users 
GROUP BY 
    days;
/*
+----------+-------+
| days     | count |
+----------+-------+
| Friday   |     1 |
| Monday   |     3 |
| Sunday   |     1 |
| Saturday |     1 |
+----------+-------+
4 rows in set (0,00 sec)
*/



--Подсчитайте произведение чисел в столбце таблицы
-- Было выбрано поле id таблицы users
/*
mysql> SELECT id FROM users;
+----+
| id |
+----+
|  1 |
|  2 |
|  3 |
|  4 |
|  5 |
|  6 |
+----+
6 rows in set (0,00 sec)
*/
SELECT ROUND(EXP(SUM(LOG(id))),6) product 
    FROM users;
/*
+------------+
| product    |
+------------+
| 720.000000 |
+------------+
1 row in set (0,00 sec)
*/
