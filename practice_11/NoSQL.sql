/*
 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
*/


HINCRBY adresses '127.0.0.1' 1
HINCRBY adresses '127.0.0.1' 1
HINCRBY adresses '127.0.0.1' 1
HINCRBY adresses '127.0.0.1' 1
HINCRBY adresses '127.0.0.1' 1

HINCRBY adresses '127.0.0.2' 1
HINCRBY adresses '127.0.0.2' 5
HINCRBY adresses '127.0.0.2' 4

HGETALL adresses
HGET adresses '127.0.0.1'
HGET adresses '127.0.0.2'


/*
 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и 
    наоборот, поиск электронного адреса пользователя по его имени.
*/

HSET emails 'user1' 'user1@gmail.com'
HSET emails 'user2' 'user2@mail.ru'
HSET emails 'user3' 'user3@yandex.ru'

HGET emails 'user3'

HSET users 'user1@gmail.com' 'user1'
HSET users 'user2@mail.ru' 'user2'
HSET users 'user3@yandex.ru' 'user3'

HGET users 'user3@yandex.ru'


/*
 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/

use shop1
db.createCollection('catalogs')
db.createCollection('products')


db.catalogs.insert({name: 'Процессоры'})
db.catalogs.insert({name: 'Материнские платы'})
db.catalogs.insert({name: 'Видеокарты'})
db.catalogs.insert({name: 'Жесткие диски'})
db.catalogs.insert({name: 'Оперативная память'})


db.catalogs.find()
/*
{ "_id" : ObjectId("5dfdf35fc4d477318c961503"), "name" : "Процессоры" }
{ "_id" : ObjectId("5dfdf35fc4d477318c961504"), "name" : "Материнские платы" }
{ "_id" : ObjectId("5dfdf35fc4d477318c961505"), "name" : "Видеокарты" }
{ "_id" : ObjectId("5dfdf35fc4d477318c961506"), "name" : "Жесткие диски" }
{ "_id" : ObjectId("5dfdf361c4d477318c961507"), "name" : "Оперативная память" }
*/

db.products.insert(
    {
        name: 'Intel Core i3-8100',
        description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
        price: 7890.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961503")  
    }
);

db.products.insert(
    {
        name: 'Intel Core i5-7400',
        description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
        price: 12700.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961503")  
    }
);

db.products.insert(
    {
        name: 'AMD FX-8320E',
        description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
        price: 4780.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961503")  
    }
);

db.products.insert(
    {
        name: 'AMD FX-8320',
        description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
        price: 7120.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961503")  
    }
);

db.products.insert(
    {
        name: 'ASUS ROG MAXIMUS X HERO',
        description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
        price: 19310.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961504")  
    }
);

db.products.insert(
    {
        name: 'Gigabyte H310M S2H',
        description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
        price: 4790.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961504")  
    }
);

db.products.insert(
    {
        name: 'MSIB250M GAMING PRO',
        description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',
        price: 4790.00,
        catalog_id: new ObjectId("5dfdf35fc4d477318c961504")  
    }
);

db.products.insert(
    {
        name: 'PATRIOT PSD34G13332',
        description: 'Оперативная память',
        price: 4790.00,
        catalog_id: new ObjectId("5dfdf361c4d477318c961507")  
    }
);




