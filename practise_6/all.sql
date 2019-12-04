/*
2) Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался 
с нашим пользователем.
*/
SELECT
  (SELECT 
     CONCAT(first_name, ' ', last_name) 
   FROM
     users 
   WHERE 
     id = friend_id) AS friend,
  MAX(mess_count) AS mess_count
FROM
  (SELECT
    friend_id,
    COUNT(*) AS mess_count
  FROM
    (SELECT
       to_user_id AS friend_id 
     FROM 
       messages
     WHERE
       from_user_id = 3
  UNION ALL
    SELECT 
      from_user_id 
    FROM 
      messages 
    WHERE 
      to_user_id = 3) AS tabl1
GROUP BY friend_id) AS tabl2
GROUP BY friend
ORDER BY mess_count DESC
LIMIT 1;



-- 3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT
  COUNT(*) AS result
FROM
 (SELECT 
    user_id
  FROM
    (SELECT 
       user_id,
       (SELECT 
          birthday
        FROM
          profiles
        WHERE 
          profiles.user_id IN (SELECT user_id FROM media WHERE media.id = target_id)) AS birthday
     FROM
       likes
     ORDER BY
       birthday DESC
  ) AS tabl1) AS tabl2
WHERE
  user_id 
IN
  (SELECT 
    user_id
  FROM
    (SELECT 
       DISTINCT user_id,
       (SELECT 
          birthday
        FROM
          profiles
        WHERE 
          profiles.user_id IN (SELECT user_id FROM media WHERE media.id = target_id)) AS birthday
     FROM
       likes
     ORDER BY
       birthday DESC
     LIMIT 10
  ) AS tabl1)
;



-- 4) Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT
  sex
FROM 
  (SELECT
     sex,
     COUNT((SELECT
              COUNT(*)
            FROM
              likes
            WHERE
              likes.user_id = profiles.user_id)) AS likes_count
   FROM 
     profiles
   WHERE 
     sex = 'm'
   GROUP BY
     sex
   
   UNION ALL

   SELECT
     sex,
     COUNT((SELECT
              COUNT(*)
            FROM
              likes
            WHERE
              likes.user_id = profiles.user_id)) AS likes_count
   FROM 
     profiles
   WHERE 
     sex = 'w'
   GROUP BY
     sex
   ) AS tmp
GROUP BY sex
ORDER BY MAX(likes_count) DESC
LIMIT 1;



-- 5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

/*
Самая простая проверка на активность - сложить количество отправленных пользователем сообщений, его лайки,
число его друзей и количество сообществ, в которых он состоит.
Чем больше конечная сумма пользователя - тем более он активный.
*/
SELECT 
  (SELECT
     CONCAT(first_name, ' ', last_name) 
   FROM 
     users 
   WHERE 
     id = user_id) AS name,
  SUM(tmp.points) AS points
FROM
  (SELECT 
     from_user_id AS user_id, 
     COUNT(*) AS points  
   FROM 
     messages -- Неактивные пользователи сами мало отправляют сообщения(неважно, сколько сообщений отправляют им)
   GROUP BY
     from_user_id
  UNION ALL
   SELECT 
     user_id, 
     COUNT(*)  
   FROM
     likes -- Неактивные пользователи ставят мало лайков
   GROUP BY
     user_id
  UNION ALL
   SELECT 
     user_id, 
     COUNT(*)  
   FROM 
     friendship -- У неактивных пользователей мало друзей(необходима проверка в две стороны)
   GROUP BY 
     user_id
  UNION ALL
   SELECT 
     friend_id, 
     COUNT(*) 
   FROM 
     friendship 
   GROUP BY 
     friend_id
  UNION ALL
   SELECT 
     user_id, 
     COUNT(*)  
   FROM 
     communities_users -- Неактивные пользователи состоят в малом количестве сообществ
   GROUP BY 
     user_id
) AS tmp
GROUP BY name
ORDER BY points
LIMIT 10;