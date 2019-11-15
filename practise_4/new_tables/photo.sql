CREATE TABLE photo (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    media_type_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    filename VARCHAR(255) NOT NULL,
    size INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

INSERT INTO photo (media_type_id, user_id, filename, size, created_at, updated_at)
SELECT media_type_id, user_id, filename, size, created_at, updated_at FROM media WHERE media_type_id = 1;