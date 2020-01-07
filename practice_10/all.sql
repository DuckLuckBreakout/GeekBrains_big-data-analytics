/*
   1. Проанализировать какие запросы могут выполняться наиболее часто в процессе 
      работы приложения и добавить необходимые индексы.
*/

CREATE INDEX profiles_birthday_idx ON profiles(birthday);

CREATE INDEX friendship_user_id_friend_id_idx ON friendship(user_id, friend_id);

CREATE INDEX messages_to_user_id_idx ON messages(to_user_id);

CREATE INDEX messages_from_user_id_idx ON messages(from_user_id);

/*
2. Задание на оконные функции
   Построить запрос, который будет выводить следующие столбцы:
       имя группы
       среднее количество пользователей в группах
       самый молодой пользователь в группе
       самый пожилой пользователь в группе
       общее количество пользователей в группе
       всего пользователей в системе
       отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
*/

SELECT DISTINCT communities.name,
  COUNT(communities_users.user_id) OVER() / communities.id AS average,

  (SELECT profiles.birthday 
     FROM profiles 
    WHERE profiles.user_id 
       IN (SELECT communities_users.user_id 
             FROM communities_users 
            WHERE communities_users.community_id = communities.id) 
    ORDER BY profiles.birthday DESC LIMIT 1) AS the_youngest,

  (SELECT profiles.birthday 
     FROM profiles 
    WHERE profiles.user_id 
          IN (SELECT communities_users.user_id 
                FROM communities_users 
               WHERE communities_users.community_id = communities.id) 
    ORDER BY profiles.birthday LIMIT 1) AS the_oldest,

  COUNT(communities_users.user_id) OVER w AS total_in_community,
  COUNT(communities_users.user_id) OVER() AS total,
  COUNT(communities_users.user_id) OVER w / COUNT(communities_users.user_id) OVER() * 100 AS "%"
    FROM (communities
      JOIN communities_users
        ON communities_users.community_id = communities.id)
      LEFT JOIN profiles
        ON communities_users.user_id = profiles.user_id
        WINDOW w AS (PARTITION BY communities_users.community_id);




