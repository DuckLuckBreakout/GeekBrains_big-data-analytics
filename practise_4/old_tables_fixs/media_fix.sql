/*
mysql> SELECT * FROM media LIMIT 10;
+----+---------------+---------+----------------+----------+-------------------------------------------------------------------+---------------------+---------------------+
| id | media_type_id | user_id | filename       | size     | metadata                                                          | created_at          | updated_at          |
+----+---------------+---------+----------------+----------+-------------------------------------------------------------------+---------------------+---------------------+
|  1 |             4 |     435 | odio           |        0 | Quia doloribus ad quia similique tempora totam.                   | 1996-05-13 13:04:59 | 1979-04-08 17:39:55 |
|  2 |             6 |     289 | exercitationem | 49185310 | Eligendi sed earum dolores sint voluptatem enim.                  | 2002-10-17 01:48:22 | 2004-09-28 12:22:16 |
|  3 |             5 |     936 | repudiandae    |   628529 | Nostrum saepe et dolores dolorum sed quo.                         | 2009-02-28 18:33:23 | 1990-08-07 01:31:29 |
|  4 |             5 |      69 | aut            |       78 | Est sed maxime molestiae inventore et distinctio excepturi.       | 2014-01-12 16:13:32 | 1993-10-31 17:05:28 |
|  5 |             2 |     349 | quo            |        0 | Doloremque dolor debitis ut eligendi odio fugit.                  | 1986-08-01 22:42:48 | 2016-12-08 22:05:09 |
|  6 |             3 |     382 | nostrum        |    38437 | Voluptatibus illum accusantium numquam id quis.                   | 2011-09-05 22:10:40 | 2007-06-20 01:34:53 |
|  7 |             5 |      14 | incidunt       |     7981 | Enim consequatur rerum incidunt quis.                             | 2003-02-16 14:34:30 | 2008-12-16 10:48:22 |
|  8 |             4 |     389 | in             |        0 | Dolorum et fugiat quo sunt.                                       | 2008-04-23 20:29:27 | 2017-10-15 04:50:11 |
|  9 |             3 |     609 | dolores        |      239 | Voluptatem eos consequatur molestiae voluptatem illo natus qui.   | 1986-11-09 16:57:12 | 1983-07-10 21:21:47 |
| 10 |             5 |     538 | soluta         |   508994 | Possimus ut vel laboriosam fugit facilis necessitatibus deleniti. | 2013-02-04 02:10:42 | 1973-12-12 19:54:55 |
+----+---------------+---------+----------------+----------+-------------------------------------------------------------------+---------------------+---------------------+
                   ^                                                     ^
                   |                                                     |
                   |                                                     |
                   error                                                 error
*/

UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));

-- media
SELECT * FROM media LIMIT 10;
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET metadata = CONCAT('{"', filename, '":"', size, '"}');
ALTER TABLE media MODIFY COLUMN metadata JSON;

/*
mysql> SELECT * FROM media LIMIT 10;
+----+---------------+---------+----------------+----------+--------------------------------+---------------------+---------------------+
| id | media_type_id | user_id | filename       | size     | metadata                       | created_at          | updated_at          |
+----+---------------+---------+----------------+----------+--------------------------------+---------------------+---------------------+
|  1 |             2 |      56 | odio           |        0 | {"odio": "0"}                  | 1996-05-13 13:04:59 | 2019-11-15 23:29:59 |
|  2 |             1 |       5 | exercitationem | 49185310 | {"exercitationem": "49185310"} | 2002-10-17 01:48:22 | 2019-11-15 23:29:59 |
|  3 |             3 |      55 | repudiandae    |   628529 | {"repudiandae": "628529"}      | 2009-02-28 18:33:23 | 2019-11-15 23:29:59 |
|  4 |             2 |      61 | aut            |       78 | {"aut": "78"}                  | 2014-01-12 16:13:32 | 2019-11-15 23:29:59 |
|  5 |             3 |      39 | quo            |        0 | {"quo": "0"}                   | 1986-08-01 22:42:48 | 2019-11-15 23:29:59 |
|  6 |             1 |      13 | nostrum        |    38437 | {"nostrum": "38437"}           | 2011-09-05 22:10:40 | 2019-11-15 23:29:59 |
|  7 |             3 |      46 | incidunt       |     7981 | {"incidunt": "7981"}           | 2003-02-16 14:34:30 | 2019-11-15 23:29:59 |
|  8 |             3 |      91 | in             |        0 | {"in": "0"}                    | 2008-04-23 20:29:27 | 2019-11-15 23:29:59 |
|  9 |             2 |      18 | dolores        |      239 | {"dolores": "239"}             | 1986-11-09 16:57:12 | 2019-11-15 23:29:59 |
| 10 |             1 |      16 | soluta         |   508994 | {"soluta": "508994"}           | 2013-02-04 02:10:42 | 2019-11-15 23:29:59 |
+----+---------------+---------+----------------+----------+--------------------------------+---------------------+---------------------+
10 rows in set (0,00 sec)
*/

/*
mysql> DESCRIBE media;
+---------------+------------------+------+-----+-------------------+-----------------------------------------------+
| Field         | Type             | Null | Key | Default           | Extra                                         |
+---------------+------------------+------+-----+-------------------+-----------------------------------------------+
| id            | int(10) unsigned | NO   | PRI | NULL              | auto_increment                                |
| media_type_id | int(10) unsigned | NO   |     | NULL              |                                               |
| user_id       | int(10) unsigned | NO   |     | NULL              |                                               |
| filename      | varchar(255)     | NO   |     | NULL              |                                               |
| size          | int(11)          | NO   |     | NULL              |                                               |
| metadata      | json             | YES  |     | NULL              |                                               |
| created_at    | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at    | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+---------------+------------------+------+-----+-------------------+-----------------------------------------------+
8 rows in set (0,01 sec)
*/