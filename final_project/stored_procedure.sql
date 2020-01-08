/*
   Получить информацию о предметах на продаже по заданному столбцу.
*/

DELIMITER //
CREATE PROCEDURE get_specific_items_on_sale_by_entity (entity VARCHAR(45), entity_name VARCHAR(45))
BEGIN
      IF entity = "name" 
         THEN 
              SELECT *
                FROM specific_items_on_sale_with_app_name
               WHERE name = entity_name;
      END IF;
      IF entity = "app_name" 
         THEN 
              SELECT *
                FROM specific_items_on_sale_with_app_name
               WHERE app_name = entity_name;
      END IF;
      IF entity = "quality" 
         THEN 
              SELECT *
                FROM specific_items_on_sale_with_app_name
               WHERE quality = entity_name;
      END IF;
END //
DELIMITER ;


/*
   Обновить поле suggested_price.
*/

DELIMITER //
CREATE PROCEDURE update_suggested_prices ()
BEGIN
    -- Т.к. для item_type_id создан индекс, то можно не использовать цикл
      UPDATE item_types 
         SET suggested_price = (SELECT new_suggested_price FROM new_suggested_prices WHERE item_type_id = id)
       WHERE id IN (SELECT item_type_id FROM new_suggested_prices);
END //
DELIMITER ;


/*
   Найти все подозрительные продажи(Подозрительной будет считаться продажа, цена которой отличается от suggested_price более чем в N раз)
*/
DELIMITER //
CREATE PROCEDURE get_suspicious_transaction (N INT(10))
BEGIN
      SELECT sold_items.seller_id,
             sold_items.buyer_id,
             sold_items.price,
             item_types.suggested_price,
             sold_items.steam_item_id,
             sold_items.sold_at
        FROM sold_items
             JOIN item_types
             ON sold_items.item_type_id = item_types.id
       WHERE sold_items.price > item_types.suggested_price * N
             OR
             sold_items.price < item_types.suggested_price / N;
END //
DELIMITER ;


