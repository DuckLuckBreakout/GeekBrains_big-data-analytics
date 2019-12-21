DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  created_at DATETIME NOT NULL,
  table_name VARCHAR(255) NOT NULL,
  key_id BIGINT(10) NOT NULL,
  name VARCHAR(255) NOT NULL
) ENGINE=Archive;

DROP TRIGGER IF EXISTS logs_users;
DELIMITER //
CREATE TRIGGER logs_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;


DROP TRIGGER IF EXISTS logs_catalogs;
DELIMITER //
CREATE TRIGGER logs_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;


DROP TRIGGER IF EXISTS logs_products;
DELIMITER //
CREATE TRIGGER logs_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, table_name, key_id, name)
    VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;
