CREATE TABLE likes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL, -- кто поставил
    media_id INT UNSIGNED NOT NULL, 
    is_hidden BOOLEAN, -- скрыть от всех, кроме хозяина сущности, на которую ставится лайк
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
