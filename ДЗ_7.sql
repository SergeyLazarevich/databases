-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
-- интернет магазине.
SELECT name 
    FROM users
    WHERE id IN (SELECT user_id FROM orders)
	ORDER BY name


-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog'
    FROM products

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities -- (label,name). Поля from, to и label содержат английские названия городов, поле name —
-- русское. Выведите список рейсов flights с русскими названиями городов.
DROP DATABASE IF EXISTS flight;
CREATE DATABASE flight;
USE flight;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
    froms VARCHAR(50),
    to_to VARCHAR(50)
) COMMENT 'перелёты';

INSERT INTO flights 
	(froms, to_to) VALUES
  ('moskow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moskow'),
  ('omsk', 'irkutsk'),
  ('moskow', 'kazan');
 
 DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
    lebel VARCHAR(50),
    name VARCHAR(50)
) COMMENT 'перевод';

INSERT INTO cities VALUES
  ('moskow', 'Москва'),
  ('novgorod', 'Новгород'),
  ('irkutsk', 'Иркуцк'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань');
 
SELECT 
	(SELECT name FROM cities WHERE froms = lebel) AS 'отправление',
	(SELECT name FROM cities WHERE to_to = lebel) AS 'прибытие'
	FROM flights
