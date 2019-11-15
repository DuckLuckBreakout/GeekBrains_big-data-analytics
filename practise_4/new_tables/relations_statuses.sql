CREATE TABLE relation_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);
INSERT INTO relation_statuses (name) VALUES 
  ('son'),
  ('daughter'),
  ('mother'),
  ('father'),
  ('wife'),
  ('husband')
;