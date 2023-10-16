

/* 1)
 * В базе данных shop и sample присутствуют одни и те же таблицы, 
 * учебной базы данных. Переместите запись id = 1 из таблицы 
 * shop.users в таблицу sample.users. Используйте транзакции.
 */
START TRANSACTION;

INSERT IGNORE INTO sample.users (id, name) 
	SELECT id, name
	FROM shop.users 
	WHERE id = 1
;

DELETE FROM shop.users 
WHERE id = 1
;

COMMIT;

/* 2)
 * Создайте представление, которое выводит название name 
 * товарной позиции из таблицы products и соответствующее 
 * название каталога name из таблицы catalogs.
 */
USE shop;

CREATE OR REPLACE VIEW prod (name, category) AS 
	SELECT p.name, c.name
	FROM products AS p
	JOIN catalogs AS c
	ON p.catalog_id = c.id
;
SELECT * FROM prod;


/* 
 * Создайте двух пользователей которые имеют доступ к базе данных shop. 
 * Первому пользователю shop_read должны быть доступны только запросы на 
 * чтение данных, второму пользователю shop — любые операции в пределах 
 * базы данных shop.
 */
CREATE USER 'shop'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost';

CREATE USER 'shop_read'@'localhost';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';



/*
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости 
 * от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
 * с 00:00 до 6:00 — "Доброй ночи".
 */


DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello()
RETURNS char(15) DETERMINISTIC 
BEGIN
	SELECT time(now()) INTO @t;
	IF '06:00:00' < @t AND @t < '12:00:00' THEN RETURN  "Доброе утро";
    ELSEIF '12:00:00' < @t AND @t < '18:00:00' THEN RETURN "Добрый день";
    ELSEIF '18:00:00' < @t AND @t < '00:00:00' THEN RETURN "Добрый вечер";
      ELSE
        RETURN "Доброй ночи";
    END IF;
END

SELECT hello();

/*
 * В таблице products есть два текстовых поля: name с названием товара и description
 * с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда
 * оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
 * добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке 
 * присвоить полям NULL-значение необходимо отменить операцию.
 */

CREATE TRIGGER check_data BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'at list on of fields has to be not null'; 
  END IF;
END 
