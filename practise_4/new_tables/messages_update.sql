ALTER TABLE messages ADD COLUMN header VARCHAR(255) AFTER to_user_id;
-- Заполним
UPDATE messages SET header = SUBSTRING(body, 1, 50);

ALTER TABLE messages ADD column attached_media_id INT UNSIGNED AFTER body;
-- Заполним
UPDATE messages SET attached_media_id = (
  SELECT id FROM media WHERE user_id = from_user_id LIMIT 1
);