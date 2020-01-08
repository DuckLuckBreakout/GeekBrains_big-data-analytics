CREATE VIEW specific_items_on_sale_with_items_and_qualities_names AS
SELECT specific_items_on_sale.steam_item_id,
       item_types.market_hash_name AS name,
       item_qualities.name AS quality,
       item_types.suggested_price AS suggested_price,
       item_types.app_id AS app_id
  FROM specific_items_on_sale
       JOIN item_qualities
       ON specific_items_on_sale.item_quality_id = item_qualities.id
       JOIN item_types
       ON specific_items_on_sale.item_type_id = item_types.id;

CREATE VIEW specific_items_on_sale_stattrak_items AS
SELECT *
  FROM specific_items_on_sale_with_items_and_qualities_names
 WHERE name LIKE '%StatTrak%';

CREATE VIEW specific_items_on_sale_souvenir_items AS
SELECT *
  FROM specific_items_on_sale_with_items_and_qualities_names
 WHERE name LIKE '%Souvenir%';


CREATE VIEW specific_items_on_sale_with_app_name AS 
SELECT steam_item_id,
       t1.name,
       quality,
       suggested_price,
       apps.name AS app_name
  FROM specific_items_on_sale_with_items_and_qualities_names AS t1
       JOIN
       apps
       ON app_id = apps.id;