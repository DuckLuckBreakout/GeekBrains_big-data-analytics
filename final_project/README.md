# Модель хранения данных сайта Bitskins.com
## Описание сайта
Данный сайт является неофициальной торговой площадкой предметов Steam.
Пользователи размещают свои предметы на продажу, другие пользователи могут купить данные предметы за счёт баланса на сайте. После размещения лота на продажу, пользователь передает предмет одному из ботов сайта, что позволяет продавать предмет независимо от того, находится продавец онлайн или нет. Также пользователи могут оставлять запросы на автопокупку предметов по выбранной цене.
<a href="https://imageup.ru/img113/3534608/snimok-ehkrana-2020-01-08-v-180533.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534608/snimok-ehkrana-2020-01-08-v-180533.jpg" border="0" alt="Хостинг фотографий"></a>
https://bitskins.com/
## Задачи, решаемые базой данных
Необходимо обеспечить:

* хранение данных пользователей
* хранение данных ботов сайта
* хранение типов предметов, пригодных для продажи на сайте
* хранение информации о предметах, которые в данный момент находятся на продаже
* хранение информации о проданных предметах
* хранение запросов на автопокупку предметов
* обеспечить актуальность предполагаемой цены предмета
* обеспечить проверку на мошенничество
## Описание реализованной модели БД:
### Хранение данных о пользователях реализовано двумя таблицами:
<a href="https://imageup.ru/img113/3534598/snimok-ehkrana-2020-01-08-v-175818.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534598/snimok-ehkrana-2020-01-08-v-175818.jpg" border="0" alt="загрузка изображений"></a>
<a href="https://imageup.ru/img113/3534599/snimok-ehkrana-2020-01-08-v-175825.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534599/snimok-ehkrana-2020-01-08-v-175825.jpg" border="0" alt="выложить фотографии"></a>
### Хранение данных о ботах реализовано таблицей:
<a href="https://imageup.ru/img113/3534612/snimok-ehkrana-2020-01-08-v-181031.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534612/snimok-ehkrana-2020-01-08-v-181031.jpg" border="0" alt="бесплатный хостинг для хранения изображений"></a>
### Хранение типов предметов реализовано таблицей:
<a href="https://imageup.ru/img113/3534600/snimok-ehkrana-2020-01-08-v-180050.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534600/snimok-ehkrana-2020-01-08-v-180050.jpg" border="0" alt="загрузить картинку и получить ссылку"></a>
### Хранение информации о предметах, которые в данный момент находятся на продаже:
<a href="https://imageup.ru/img113/3534603/snimok-ehkrana-2020-01-08-v-180136.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534603/snimok-ehkrana-2020-01-08-v-180136.jpg" border="0" alt="Хостинг фото"></a>
### Хранение информации о проданных предметах:
<a href="https://imageup.ru/img113/3534604/snimok-ehkrana-2020-01-08-v-180213.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534604/snimok-ehkrana-2020-01-08-v-180213.jpg" border="0" alt="залить картинку"></a>
### Хранение запросов на автопокупку предметов:
<a href="https://imageup.ru/img113/3534606/snimok-ehkrana-2020-01-08-v-180245.jpg.html" target="_blank"><img src="https://imageup.ru/img113/3534606/snimok-ehkrana-2020-01-08-v-180245.jpg" border="0" alt="хранилище фото"></a>
### Обеспечение актуальности предполагаемой цены предмета реализовано процедурой:
``` sql
DELIMITER //
CREATE PROCEDURE update_suggested_prices ()
BEGIN
    -- Т.к. для item_type_id создан индекс, то можно не использовать цикл
      UPDATE item_types 
         SET suggested_price = (SELECT new_suggested_price FROM new_suggested_prices WHERE item_type_id = id)
       WHERE id IN (SELECT item_type_id FROM new_suggested_prices);
END //
DELIMITER ;
```
### Проверка на мошенничество реализована процедурой:
``` sql
DELIMITER //
CREATE PROCEDURE get_suspicious_transaction (N INT(10))
BEGIN
      SELECT sold_items.seller_id,
             sold_items.buyer_id,
             sold_items.price,
             item_types.suggested_price,
             sold_items.steam_item_id,
             sold_items.sold_at
        FROM sold_items
             JOIN item_types
             ON sold_items.item_type_id = item_types.id
       WHERE sold_items.price > item_types.suggested_price * N
             OR
             sold_items.price < item_types.suggested_price / N;
END //
DELIMITER ;

```

