USE vk;
/* 1)
 * ����� � ������� users ���� created_at � updated_at ��������� ��������������. 
 * ��������� �� �������� ����� � ��������.
 */

ALTER TABLE users
ADD COLUMN (created_at DATETIME),
ADD COLUMN (updated_at DATETIME);

UPDATE users 
SET 
	created_at = (SELECT NOW()),
	updated_at = (SELECT NOW());

/*2)
 * ������� users ���� �������� ��������������. 
 * ������ created_at � updated_at ���� ������ ����� VARCHAR � � 
 * ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". 
 * ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
*/


ALTER TABLE users
DROP COLUMN created_at,
DROP COLUMN updated_at;

ALTER TABLE users
ADD COLUMN created_at VARCHAR(255),
ADD COLUMN updated_at VARCHAR(255);

UPDATE users 
SET 
	created_at = "20.10.2017 8:10",
	updated_at = "20.10.2017 8:10";
	
ALTER TABLE users 
ADD COLUMN created_at_new DATETIME,
ADD COLUMN updated_at_new DATETIME;

UPDATE users 
SET 
	created_at_new = STR_TO_DATE((SELECT created_at), '%d.%m.%Y %h:%i'),
	updated_at_new = STR_TO_DATE((SELECT updated_at), '%d.%m.%Y %h:%i');

ALTER TABLE users
DROP COLUMN created_at,
DROP COLUMN updated_at;

ALTER TABLE users
RENAME COLUMN created_at_new TO created_at,
RENAME COLUMN updated_at_new TO updated_at;

/*3)
 * � ������� ��������� ������� storehouses_products � ���� value ����� 
 * ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, 
 * ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
 * ����� ��� ���������� � ������� ���������� �������� value. ������, ������� 
 * ������ ������ ���������� � �����, ����� ���� �������.
 */


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL,
	value BIGINT UNSIGNED NOT NULL
);


INSERT INTO storehouses_products (value)
VALUES 
(500),
(600),
(488),
(0),
(12489),
(0),
(900),
(200)
;

SELECT value FROM storehouses_products ORDER BY value = 0, value;

SELECT value FROM storehouses_products ORDER BY IF (value = 0, 1, 0), value;


/*
 * 4)
 *Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий ('may', 'august')
 */


SELECT 
	CONCAT(firstname, ', ', lastname) AS full_name
FROM 
	users
WHERE id IN (
	SELECT 
		user_id 
	FROM 
		profiles 
	WHERE 
		(SELECT (MONTHNAME(birthday) IN ('may', 'august')))
	)	
;
	
/* 5)
 * Из таблицы catalogs извлекаются записи при помощи запроса 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
 */

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL,
	shortname VARCHAR(100)
);


INSERT INTO catalogs (shortname)
VALUES 
('Sed'),
('Nemo'),
('voluptatem'),
('voluptat'),
('corporis'),
('dolor'),
('omnis'),
('quasi')
;
  
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


/*
 * Практическое задание теме “Агрегация данных”
 */
/*
 * 1)
 * Подсчитайте средний возраст пользователей в таблице users
 */

SELECT 
	ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, CURDATE())), 1) AS avg_age
FROM profiles;

/*
 * 2)
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */
SELECT
	DAYNAME(MAKEDATE((SELECT EXTRACT(YEAR FROM CURDATE())), DAYOFYEAR(birthday))) AS day_name, COUNT(*)
FROM profiles
GROUP BY day_name
;

/*
 * 3)
 * Подсчитайте произведение чисел в столбце таблицы
 */
SELECT 
	exp(SUM(log(user_id)))
FROM 
	profiles 
;

