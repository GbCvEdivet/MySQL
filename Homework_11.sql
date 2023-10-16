/*
 * Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
 * catalogs и products в таблицу logs помещается время и дата создания записи, 
 * название таблицы, идентификатор первичного ключа и содержимое поля name.
 */

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id SERIAL, 
	table_id BIGINT,
	table_name VARCHAR(255),
	name_from_table VARCHAR(255),
	created_at DATETIME DEFAULT NOW()	
) ENGINE=Archive
;

DROP TRIGGER IF EXISTS products_log;
CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW 
BEGIN
	INSERT INTO logs (table_id, table_name,  name_from_table) 
	VALUES 
		(NEW.id, 'products', NEW.name);
END 

DROP TRIGGER IF EXISTS catalogs_log;
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
	INSERT INTO logs (table_id, table_name,  name_from_table) 
	VALUES 
		(NEW.id, 'catalogs', NEW.name);
END 

DROP TRIGGER IF EXISTS users_log;
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW 
BEGIN
	INSERT INTO logs (table_id, table_name,  name_from_table) 
	VALUES 
		(NEW.id, 'users', NEW.name);
END 



/*
 * Создайте SQL-запрос, который помещает в таблицу users миллион записей.
 */


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29'),
  ('Иван', '1998-01-12'),
  ('Александр', '1985-05-20'),
  ('Геннадий', '1990-10-05'),
  ('Александр', '1985-05-20');
 
 INSERT INTO 
 	users (name, birthday_at) 
 SELECT users.name, users.birthday_at FROM users
 JOIN users AS u2
 JOIN users AS u3
 JOIN users AS u4
 JOIN users AS u5
 JOIN users AS u6
 ;


SELECT count(*) FROM users;

















