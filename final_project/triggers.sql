/*
   Проверка типа предмета.
*/

DELIMITER //

CREATE TRIGGER new_item_item_type_id_insert_check BEFORE INSERT ON specific_items_on_sale
FOR EACH ROW
BEGIN 
      IF NEW.item_type_id NOT IN (SELECT id FROM item_types) THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Данный предмет не найден в таблице item_types.";
      END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER new_item_item_type_id_update_check BEFORE UPDATE ON specific_items_on_sale
FOR EACH ROW
BEGIN 
      IF NEW.item_type_id NOT IN (SELECT id FROM item_types) THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Данный предмет не найден в таблице item_types.";
      END IF;
END//

DELIMITER ;


/*
   Проверка стоимости предмета.
*/

DELIMITER //

CREATE TRIGGER new_item_price_insert_check BEFORE INSERT ON specific_items_on_sale
FOR EACH ROW
BEGIN 
      IF NEW.price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Цена предмета не может быть меньше 1 цента.";
      END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER new_item_price_update_check BEFORE UPDATE ON specific_items_on_sale
FOR EACH ROW
BEGIN 
      IF NEW.price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Цена предмета не может быть меньше 1 цента.";
      END IF;
END//

DELIMITER ;
/*
   Проверка suggested_price предмета
*/

DELIMITER //

CREATE TRIGGER new_item_type_suggested_price_insert_check BEFORE INSERT ON item_types
FOR EACH ROW
BEGIN 
      IF NEW.suggested_price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Suggested price предмета не может быть меньше 1 цента.";
      END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER new_item_type_suggested_price_update_check BEFORE UPDATE ON item_types
FOR EACH ROW
BEGIN 
      IF NEW.suggested_price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Suggested price предмета не может быть меньше 1 цента.";
      END IF;
END//

DELIMITER ;


/*
   Проверка цены запросы на покупку предмета.
*/

DELIMITER //

CREATE TRIGGER new_buy_order_price_insert_check BEFORE INSERT ON buy_orders
FOR EACH ROW
BEGIN 
      IF NEW.price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Нельзя создать запрос на покупку дешевле 1 цента.";
      END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER new_buy_order_price_update_check BEFORE UPDATE ON buy_orders
FOR EACH ROW
BEGIN 
      IF NEW.price < 1 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Нельзя создать запрос на покупку дешевле 1 цента.";
      END IF;
END//

DELIMITER ;

/*
   Проверка типа предмета в запросе на покупку.
*/

DELIMITER //

CREATE TRIGGER new_buy_order_item_type_id_insert_check BEFORE INSERT ON buy_orders
FOR EACH ROW
BEGIN 
      IF NEW.item_type_id NOT IN (SELECT id FROM item_types) THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Данный предмет не найден в таблице item_types.";
      END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER new_buy_order_item_type_id_update_check BEFORE UPDATE ON buy_orders
FOR EACH ROW
BEGIN 
      IF NEW.item_type_id NOT IN (SELECT id FROM item_types) THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Данный предмет не найден в таблице item_types.";
      END IF;
END//

DELIMITER ;

