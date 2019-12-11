/*
2) Пусть задан некоторый пользователь. 
   Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
*/

SELECT (SELECT CONCAT(first_name, ' ', last_name) 
          FROM users 
         WHERE id = from_user_id
       ) AS friend,
       COUNT(*) AS total_messages
  FROM
       (SELECT messages.from_user_id
          FROM messages
              JOIN friendship
              ON messages.from_user_id = friendship.user_id
                 OR messages.from_user_id = friendship.friend_id
              JOIN users 
              ON users.id = friendship.friend_id
                 OR users.id = friendship.user_id   
        WHERE users.id = 7 AND messages.to_user_id = 7) AS T
 GROUP BY from_user_id
 ORDER BY total_messages DESC
 LIMIT 1;


-- 3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(total_likes) AS answer 
  FROM 
       (SELECT T1.user_id, T2.* 
          FROM 
               (SELECT * 
                  FROM 
                       (SELECT user_id 
                          FROM profiles 
                         ORDER BY birthday DESC 
                         LIMIT 10 
                       ) AS sorted_profiles
               ) AS T1 
       JOIN 
           (SELECT users.id, 
                   first_name, 
                   last_name, 
                   COUNT(*) AS total_likes
              FROM users
                   JOIN media
                   ON users.id = media.user_id
                   JOIN likes
                   ON media.id = likes.target_id
                   JOIN target_types
                   ON likes.target_type_id = target_types.id
             WHERE target_types.id = 3
             GROUP BY users.id
           ) AS T2
       ON T1.user_id = T2.id
       ) AS T3;


-- 4) Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
  sex,
  COUNT(*) AS total_likes 
  FROM profiles 
       JOIN likes 
       ON profiles.user_id = likes.user_id 
 GROUP BY sex 
 ORDER BY total_likes DESC 
 LIMIT 1;


-- 5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT DISTINCT likes.user_id, 
       COUNT(*) AS total_act 
  FROM messages 
       JOIN likes
       ON messages.from_user_id = likes.user_id
       JOIN friendship 
       ON likes.user_id = friendship.friend_id
       JOIN communities_users
       ON friendship.friend_id = communities_users.user_id
 GROUP BY likes.id
 ORDER BY total_act
 LIMIT 10;
