/*
mysql> mysql> SELECT * FROM media_types LIMIT 10;
+----+---------------+
| id | name          |
+----+---------------+
|  5 | autem         |
|  2 | et            |
|  6 | reprehenderit |
|  4 | vero          |
|  1 | voluptas      |
|  3 | voluptatem    |
+----+---------------+
6 rows in set (0,00 sec)
*/

DELETE FROM media_types;
TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

/*
mysql> SELECT * FROM media_types LIMIT 10;
+----+-------+
| id | name  |
+----+-------+
|  3 | audio |
|  1 | photo |
|  2 | video |
+----+-------+
3 rows in set (0,00 sec)
*/