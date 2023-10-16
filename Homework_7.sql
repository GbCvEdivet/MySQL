/* 1)
 * Составьте список пользователей users, которые осуществили хотя 
 * бы один заказ orders в интернет магазине.
 */
-- Я может быть неправильно понял это задание?
USE shop;
SELECT name FROM users WHERE id IN (
	SELECT DISTINCT user_id FROM orders
);

/* 2)
 * Выведите список товаров products и разделов catalogs, которые соответствуют товару.
 */
SELECT 
	p.name AS 'Название', p.price AS 'Цена', c.name AS 'Категория'
FROM products AS p
JOIN catalogs AS c
ON p.catalog_id = c.id
ORDER BY p.id
;


/* 3)
 * Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.
 */

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255),
	`to` VARCHAR(255)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(255),
	name VARCHAR(255)
);

INSERT INTO flights (`from`, `to`) VALUES 
	('moskow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moskow'),
	('omsk', 'irkutsk'),
	('moskow', 'kazan')
;

INSERT INTO cities (label, name) VALUES
	('moskow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск')
;

SELECT c.name AS 'откуда', cc.name AS 'куда'
FROM flights AS f
JOIN cities AS c 
ON f.`from` = c.label 
JOIN cities AS cc 
ON f.`to` = cc.label
ORDER BY id;
 


