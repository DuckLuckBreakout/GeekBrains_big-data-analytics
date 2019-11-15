/*
mysql> SELECT COUNT(*) FROM friendship WHERE user_id = friend_id;
+----------+
| COUNT(*) |
+----------+
|        7 |
+----------+
1 row in set (0,01 sec)
*/

-- Исправить случаи, когда пользователь дружит сам с собой
UPDATE friendship SET user_id = friend_id + 1 WHERE user_id = friend_id;
/*
mysql> SELECT COUNT(*) FROM friendship WHERE user_id = friend_id;
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0,01 sec)
*/

-- Проверить, не превысил ли "user_id" количество пользователей
SELECT COUNT(*) FROM friendship WHERE user_id > 1000;
/*
mysql> SELECT COUNT(*) FROM friendship WHERE user_id > 1000;
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0,01 sec)
*/