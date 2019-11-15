/*
        mysql> DESCRIBE messages;
        +--------------+------------------+------+-----+-------------------+-------------------+
        | Field        | Type             | Null | Key | Default           | Extra             |
        +--------------+------------------+------+-----+-------------------+-------------------+
        | id           | int(10) unsigned | NO   | PRI | NULL              | auto_increment    |
error-->| from_user_if | int(10) unsigned | NO   |     | NULL              |                   |
        | to_user_id   | int(10) unsigned | NO   |     | NULL              |                   |
error-->| bode         | text             | NO   |     | NULL              |                   |
        | is_important | tinyint(1)       | YES  |     | NULL              |                   |
        | is_delivered | tinyint(1)       | YES  |     | NULL              |                   |
        | created_at   | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
        +--------------+------------------+------+-----+-------------------+-------------------+
        7 rows in set (0,04 sec)
*/

-- Переименовать столбец "bode" в "body"
ALTER TABLE messages CHANGE bode body TEXT;
-- Переименовать столбец "from_user_if" в "from_user_id"
ALTER TABLE messages CHANGE from_user_if from_user_id INT(10) UNSIGNED;

/*
mysql> DESCRIBE messages;
+--------------+------------------+------+-----+-------------------+-------------------+
| Field        | Type             | Null | Key | Default           | Extra             |
+--------------+------------------+------+-----+-------------------+-------------------+
| id           | int(10) unsigned | NO   | PRI | NULL              | auto_increment    |
| from_user_id | int(10) unsigned | YES  |     | NULL              |                   |
| to_user_id   | int(10) unsigned | NO   |     | NULL              |                   |
| body         | text             | YES  |     | NULL              |                   |
| is_important | tinyint(1)       | YES  |     | NULL              |                   |
| is_delivered | tinyint(1)       | YES  |     | NULL              |                   |
| created_at   | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+--------------+------------------+------+-----+-------------------+-------------------+
7 rows in set (0,00 sec)
*/


/*
mysql> SELECT COUNT(*) FROM messages WHERE from_user_id = to_user_id;
+----------+
| COUNT(*) |
+----------+
|        9 |
+----------+
1 row in set (0,01 sec)
*/
-- Исправить случаи, когда пользователь отправляет сообщение самому себе
UPDATE messages SET to_user_id = from_user_id + 1 WHERE to_user_id = from_user_id;
/*
mysql> SELECT COUNT(*) FROM messages WHERE from_user_id = to_user_id;
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0,00 sec)
*/

-- Проверить, не превысил ли "to_user_id" количество пользователей
SELECT COUNT(*) FROM messages WHERE to_user_id > 1000;
/*
mysql> SELECT COUNT(*) FROM messages WHERE to_user_id > 1000;
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0,01 sec)
*/


