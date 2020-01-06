SHOW DATABASES;
USE bitskins;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,  
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  is_confirmed BOOL NOT NULL DEFAULT FALSE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT(10) UNSIGNED NOT NULL PRIMARY KEY,
  birthday DATE,
  address VARCHAR(100),
  api_key VARCHAR(100) NOT NULL UNIQUE,
  secure_access VARCHAR(100) NOT NULL UNIQUE,
  balance INT(10) NOT NULL DEFAULT 0, -- Баланс хранится в центах
  trade_url VARCHAR(100) NOT NULL UNIQUE,
  steam_id INT(10) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS apps;
CREATE TABLE apps (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  short_name VARCHAR(100) NOT NULL
);


DROP TABLE IF EXISTS item_qualities;
CREATE TABLE item_qualities (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100)
 );

DROP TABLE IF EXISTS specific_items_on_sale;
CREATE TABLE specific_items_on_sale (  
  steam_item_id INT(10) UNSIGNED NOT NULL UNIQUE,
  item_type_id INT(10) UNSIGNED NOT NULL,
  item_quality_id INT(10) UNSIGNED NOT NULL,
  price INT(10) UNSIGNED NOT NULL,
  seller_id INT(10) UNSIGNED NOT NULL,
  inspectable BOOL DEFAULT TRUE,
  inspect_link VARCHAR(100) DEFAULT NULL,
  is_featured BOOL DEFAULT FALSE,
  bot_id INT(10) UNSIGNED NOT NULL,  
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);



DROP TABLE IF EXISTS sold_items;
CREATE TABLE sold_items (
  steam_item_id INT(10) UNSIGNED NOT NULL,
  item_type_id INT(10) UNSIGNED NOT NULL,
  item_quality_id INT(10) UNSIGNED NOT NULL,
  price INT(10) UNSIGNED NOT NULL,
  seller_id INT(10) UNSIGNED NOT NULL,
  buyer_id INT(10) UNSIGNED NOT NULL,
  sold_at DATETIME DEFAULT NOW()
);


DROP TABLE IF EXISTS images;
CREATE TABLE images (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  url VARCHAR(100)
);


DROP TABLE IF EXISTS bots;
CREATE TABLE bots (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  steam_id INT(10) UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS items_types;
CREATE TABLE items_types (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  market_hash_name VARCHAR(100) NOT NULL UNIQUE,
  image_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  suggested_price INT(10) DEFAULT 0,
  app_id INT(10) UNSIGNED NOT NULL DEFAULT 0
);



DROP TABLE IF EXISTS buy_orders;
CREATE TABLE buy_orders (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  buyer_id INT(10) UNSIGNED NOT NULL,
  item_type_id INT(10) UNSIGNED NOT NULL,
  item_quality_id INT(10) UNSIGNED NOT NULL,
  price INT(10) NOT NULL,
  app_id INT(10) UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT NOW()
);


ALTER TABLE sold_items DROP FOREIGN KEY sold_items_seller_id_fk;
ALTER TABLE sold_items DROP FOREIGN KEY sold_items_buyer_id_fk;
ALTER TABLE sold_items DROP FOREIGN KEY sold_items_item_type_id_fk;
ALTER TABLE sold_items DROP FOREIGN KEY sold_items_item_quality_id_fk;

ALTER TABLE sold_items
  ADD CONSTRAINT sold_items_seller_id_fk
    FOREIGN KEY (seller_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_buyer_id_fk
    FOREIGN KEY (buyer_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES items_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_item_quality_id_fk
    FOREIGN KEY (item_quality_id) REFERENCES item_qualities(id)
      ON DELETE CASCADE;


ALTER TABLE items_types DROP FOREIGN KEY items_types_image_id_fk;
ALTER TABLE items_types DROP FOREIGN KEY items_types_app_id_fk;


ALTER TABLE items_types
  ADD CONSTRAINT items_types_image_id_fk
    FOREIGN KEY (image_id) REFERENCES images(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT items_types_app_id_fk
    FOREIGN KEY (app_id) REFERENCES apps(id)
      ON DELETE CASCADE;


ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;


ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;



ALTER TABLE specific_items_on_sale DROP FOREIGN KEY specific_items_on_sale_item_type_id_fk;
ALTER TABLE specific_items_on_sale DROP FOREIGN KEY specific_items_on_sale_item_quality_id_fk;
ALTER TABLE specific_items_on_sale DROP FOREIGN KEY specific_items_on_sale_item_type_id_fk;
ALTER TABLE specific_items_on_sale DROP FOREIGN KEY specific_items_on_sale_bot_id_fk;

ALTER TABLE specific_items_on_sale
  ADD CONSTRAINT specific_items_on_sale_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES items_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT specific_items_on_sale_item_quality_id_fk
    FOREIGN KEY (item_quality_id) REFERENCES item_qualities(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT specific_items_on_sale_seller_id_fk
    FOREIGN KEY (seller_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT specific_items_on_sale_bot_id_fk
    FOREIGN KEY (bot_id) REFERENCES bots(id)
      ON DELETE CASCADE;



ALTER TABLE buy_orders DROP FOREIGN KEY buy_orders_seller_id_fk;
ALTER TABLE buy_orders DROP FOREIGN KEY buy_orders_item_type_id_fk;
ALTER TABLE buy_orders DROP FOREIGN KEY buy_orders_item_quality_id_fk;
ALTER TABLE buy_orders DROP FOREIGN KEY buy_orders_app_id_id_fk;

ALTER TABLE buy_orders
  ADD CONSTRAINT buy_orders_seller_id_fk
    FOREIGN KEY (buyer_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES items_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_item_quality_id_fk
    FOREIGN KEY (item_quality_id) REFERENCES item_qualities(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_app_id_id_fk
    FOREIGN KEY (app_id) REFERENCES apps(id)
      ON DELETE CASCADE;


