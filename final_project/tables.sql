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

CREATE INDEX profiles_api_key_idx ON profiles(api_key);
CREATE INDEX profiles_secure_access_idx ON profiles(secure_access);
CREATE INDEX profiles_trade_url_idx ON profiles(trade_url);


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


CREATE INDEX specific_items_on_sale_item_type_id_idx ON specific_items_on_sale(item_type_id);



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

CREATE INDEX sold_items_item_type_id_idx ON sold_items(item_type_id);



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

DROP TABLE IF EXISTS item_types;
CREATE TABLE item_types (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  market_hash_name VARCHAR(100) NOT NULL UNIQUE,
  image_id INT(10) UNSIGNED NOT NULL,
  suggested_price INT(10) DEFAULT 0,
  app_id INT(10) UNSIGNED NOT NULL
);

CREATE INDEX item_types_market_hash_name_idx ON item_types(market_hash_name);


DROP TABLE IF EXISTS buy_orders;
CREATE TABLE buy_orders (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  buyer_id INT(10) UNSIGNED NOT NULL,
  item_type_id INT(10) UNSIGNED NOT NULL,
  item_quality_id INT(10) UNSIGNED NOT NULL,
  price INT(10) NOT NULL,
  app_id INT(10) UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW()
);

CREATE INDEX buy_orders_item_type_id_idx ON buy_orders(item_type_id);

ALTER TABLE sold_items
  ADD CONSTRAINT sold_items_seller_id_fk
    FOREIGN KEY (seller_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_buyer_id_fk
    FOREIGN KEY (buyer_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES item_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT sold_items_item_quality_id_fk
    FOREIGN KEY (item_quality_id) REFERENCES item_qualities(id)
      ON DELETE CASCADE;




ALTER TABLE item_types
  ADD CONSTRAINT item_types_image_id_fk
    FOREIGN KEY (image_id) REFERENCES images(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT item_types_app_id_fk
    FOREIGN KEY (app_id) REFERENCES apps(id)
      ON DELETE CASCADE;



ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;




ALTER TABLE specific_items_on_sale
  ADD CONSTRAINT specific_items_on_sale_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES item_types(id)
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




ALTER TABLE buy_orders
  ADD CONSTRAINT buy_orders_seller_id_fk
    FOREIGN KEY (buyer_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_item_type_id_fk
    FOREIGN KEY (item_type_id) REFERENCES item_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_item_quality_id_fk
    FOREIGN KEY (item_quality_id) REFERENCES item_qualities(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT buy_orders_app_id_id_fk
    FOREIGN KEY (app_id) REFERENCES apps(id)
      ON DELETE CASCADE;


