/*
1) Создайте двух пользователей которые имеют доступ к базе данных shop. 
   Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
   второму пользователю shop — любые операции в пределах базы данных shop.
*/

CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas1';
CREATE USER shop IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas2';
GRANT ALL ON shop TO 'shop';
GRANT SELECT ON shop.* TO 'shop_read';


