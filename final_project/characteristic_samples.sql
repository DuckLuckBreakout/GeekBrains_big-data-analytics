/*
  Вывести информацию о пользователях с подтвержденными аккаунтами, в первом столбце вывести их API-key.
*/

SELECT profiles.api_key,
       CONCAT(users.first_name, ' ', users.last_name) AS user,
       users.email,
       users.phone,
       profiles.birthday,
       profiles.secure_access,
       profiles.balance,
       profiles.trade_url,
       profiles.steam_id
  FROM profiles
       JOIN users
       ON users.id = profiles.user_id
 WHERE users.is_confirmed = 1;


/*
  Вывести фамилии и имена пользователей, между которыми была совершена самая крупная сделка на сайте, а также сумму этой сделки в $.
*/

SELECT CONCAT(t1.first_name, ' ', t1.last_name) AS seller,
       CONCAT(t2.first_name, ' ', t2.last_name) AS buyer,
       t3.price AS price
  FROM users AS t1
       JOIN users AS t2
            JOIN
                (SELECT DISTINCT 
                        sold_items.seller_id AS seller_id,
                        sold_items.buyer_id AS buyer_id,
                        sold_items.price * 0.01 AS price
                   FROM sold_items
                        JOIN users
                  WHERE price = (SELECT MAX(price) FROM sold_items)) AS t3
            ON t1.id = seller_id  AND  t2.id = buyer_id;

/*
  Вывести steam_id бота, который хранит меньше всего вещей.
*/

SELECT steam_id
  FROM bots
 WHERE id = (SELECT bot_id 
               FROM (SELECT bot_id,
                            COUNT(*) AS items
                       FROM specific_items_on_sale
                   GROUP BY bot_id
                   ORDER BY items
                      LIMIT 1) AS t1);




 /*
   Вывести сколько предметов каждой из игр хранится на каждом боте, вывести процентное соотношение от числа всех предметов на сайте.
 */

SELECT cs.bot_id AS bot_id,
       cs.cs_count AS 'CSGO items',
       IFNULL(cs.cs_count, 0) / (SELECT COUNT(*)
                                   FROM specific_items_on_sale
                                        JOIN item_types
                                        ON specific_items_on_sale.item_type_id = item_types.id
                                  WHERE app_id = 1) * 100 AS 'CSGO items %',
       dota.dota_count AS 'DotA items',
       IFNULL(dota.dota_count, 0) / (SELECT COUNT(*)
                                       FROM specific_items_on_sale
                                            JOIN item_types
                                            ON specific_items_on_sale.item_type_id = item_types.id
                                      WHERE app_id = 2) * 100 AS 'DotA items %',
       h1z1.h1z1_count AS 'H1Z1 items',
       IFNULL(h1z1.h1z1_count, 0) / (SELECT COUNT(*)
                                       FROM specific_items_on_sale
                                            JOIN item_types
                                            ON specific_items_on_sale.item_type_id = item_types.id
                                      WHERE app_id = 3) * 100 AS 'H1Z1 items %',
       rust.rust_count AS 'RUST items',
       IFNULL(rust.rust_count, 0) / (SELECT COUNT(*)
                                       FROM specific_items_on_sale
                                            JOIN item_types
                                            ON specific_items_on_sale.item_type_id = item_types.id
                                      WHERE app_id = 4) * 100 AS 'RUST items %',
       IFNULL(cs.cs_count, 0) + IFNULL(dota.dota_count, 0) + IFNULL(h1z1.h1z1_count, 0) + IFNULL(rust.rust_count, 0) AS 'total items',
       (IFNULL(cs.cs_count, 0) + IFNULL(dota.dota_count, 0) + IFNULL(h1z1.h1z1_count, 0) + IFNULL(rust.rust_count, 0)) / (SELECT COUNT(*)
                                                                                                                          FROM specific_items_on_sale) * 100 AS 'all items %' 
  FROM
      (
       SELECT bot_id,
              COUNT(*) AS cs_count
         FROM specific_items_on_sale
              JOIN item_types
              ON specific_items_on_sale.item_type_id = item_types.id
        WHERE app_id = 1
        GROUP BY bot_id
       ) AS cs
       LEFT JOIN
       (
        SELECT bot_id,
               COUNT(*) AS dota_count
          FROM specific_items_on_sale
               JOIN item_types
               ON specific_items_on_sale.item_type_id = item_types.id
         WHERE app_id = 2
         GROUP BY bot_id
       ) AS dota
       ON cs.bot_id = dota.bot_id
       
       LEFT JOIN
       (
        SELECT bot_id,
               COUNT(*) AS h1z1_count 
          FROM specific_items_on_sale
               JOIN item_types
               ON specific_items_on_sale.item_type_id = item_types.id
         WHERE app_id = 3
         GROUP BY bot_id
       )AS h1z1
       ON cs.bot_id = h1z1.bot_id
        
       LEFT JOIN
       (
        SELECT bot_id,
               COUNT(*) AS rust_count
          FROM specific_items_on_sale
               JOIN item_types
               ON specific_items_on_sale.item_type_id = item_types.id
         WHERE app_id = 4
         GROUP BY bot_id
       )AS rust
       ON cs.bot_id = rust.bot_id
       ORDER BY cs.bot_id
;



  