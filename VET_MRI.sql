/*
 * База пациентов МРТ создана для сбора данных о владельцах, их животных и их болезнях.
 * При помощи этой БД можно:
 * 	Удобно вычислить на каких пациентах клиника зарабатывает больше денег, это позволит
 * 		выгоднее тратить средства на обновление и расширение парка оборудования
 * 	Следить за средней выручкой за выбранный временной период
 * 	Следить за географией пациентов (польза при составлении географии проведения 
 * 		мастер-классов для врачей других клиник)
 * 	Выработать статистику по обнаружаемым болезням, 
 * 		что позволит правильно профилировать врачей в клиническом отделении
 * 	Вести "научную" статистику - к примеру, какая порода (или возраст, или пол)
 * 		предрасположена к выбранной болезни, что полезно при подготовке 
 * 		материалов для выступления на конференциях
 */






DROP DATABASE IF EXISTS vet_mri;
CREATE DATABASE vet_mri;
USE vet_mri;




DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX owners_ind (firstname, lastname)
);


DROP TABLE IF EXISTS pets;
CREATE TABLE pets (
	id SERIAL,
	owner_id BIGINT UNSIGNED NOT NULL,
	species ENUM('cat', 'dog'),
	breed VARCHAR(50),
	name VARCHAR(20),
	sex BIT,
	birthday DATE,
	
	FOREIGN KEY (owner_id) REFERENCES owners(id)
);


DROP TABLE IF EXISTS disease_types;
CREATE TABLE disease_types (
	id SERIAL,
	title VARCHAR(255)
);


DROP TABLE IF EXISTS diseases;
CREATE TABLE diseases (
	id SERIAL,
	title VARCHAR(50),
	disease_type_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (disease_type_id) REFERENCES disease_types(id)
);



DROP TABLE IF EXISTS country;
CREATE TABLE country (
	id SERIAL,
	country_name VARCHAR(50),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS city;
CREATE TABLE city (
	id SERIAL,
	city_name VARCHAR(50),
	country_id BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (country_id) REFERENCES country(id)
);


DROP TABLE IF EXISTS address;
CREATE TABLE address (
	id SERIAL,
	owners_id BIGINT UNSIGNED NOT NULL,
	address VARCHAR(50),	
	city_id BIGINT UNSIGNED NOT NULL,
	country_id BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (owners_id) REFERENCES owners(id),
	FOREIGN KEY (city_id) REFERENCES city(id),
	FOREIGN KEY (country_id) REFERENCES country(id)
);

DROP TABLE IF EXISTS mri_procedure;
CREATE TABLE mri_procedure (
	id SERIAL,
	title VARCHAR(50)
);

DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
	id SERIAL,
	owners_id BIGINT UNSIGNED NOT NULL,
	pets_id BIGINT UNSIGNED NOT NULL,
	procedure_id BIGINT UNSIGNED NOT NULL,
	value INT NOT NULL,
	performed_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (owners_id) REFERENCES owners(id),
	FOREIGN KEY (pets_id) REFERENCES pets(id),
	FOREIGN KEY (procedure_id) REFERENCES mri_procedure(id)
);


DROP TABLE IF EXISTS performed_mri;
CREATE TABLE performed_mri (
	id SERIAL,
	owners_id BIGINT UNSIGNED NOT NULL,
	pets_id BIGINT UNSIGNED NOT NULL,
	procedure_id BIGINT UNSIGNED NOT NULL,
	presumptive_disease_id BIGINT UNSIGNED NOT NULL,
	payment_id BIGINT UNSIGNED NOT NULL,
	performed_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (owners_id) REFERENCES owners(id),
	FOREIGN KEY (pets_id) REFERENCES pets(id),
	FOREIGN KEY (procedure_id) REFERENCES mri_procedure(id),
	FOREIGN KEY (presumptive_disease_id) REFERENCES diseases(id),
	FOREIGN KEY (payment_id) REFERENCES payment(id)
);


INSERT INTO owners (firstname, lastname, email, phone)
VALUES 
	('Olga', 'Fillipova', 'filkir66@gmail.com', '+79219575467'),
	('Vitaliy', 'Marochko', 'slypi@bk.ru', '+79617023287'),
	('Elena', 'Nemchinova', 'elenanemchinova91@gmail.com', '+79218974547'),
	('Pavel', 'Shlik', 'shlyk_pasha@mail.ru', '+79315419960'),
	('Alexey', 'Stolnikov', 'alexei87-87@mail.ru', '+79811504387'),
	('Olga', 'Oderisheva', 'albinoniclassic@gmail.com', '+79500356633')
;


INSERT INTO pets (owner_id, species, breed, name, sex, birthday)
VALUES 
	(1, 'dog', 'german shepherd', 'Agassy', 1, '2015-07-26'),
	(2, 'cat', 'domestic short haired', 'Vatrushka', 0, '2020-10-12'),
	(3, 'cat', 'domestic short haired', 'Zefir', 1, '2015-08-18'),
	(4, 'dog', 'yorkshire terrier', 'Senya', 1, '2015-04-12'),
	(5, 'dog', 'pug', 'Mila', 0, '2015-06-19'),
	(6, 'dog', 'labrador', 'Joy', 1, '2013-02-27')
;


INSERT INTO disease_types (title)
VALUES 
	('vascular'),
	('infectious'),
	('traumatic'),
	('autoimmune'),
	('metabolic'),
	('idiopathic'),
	('neoplastic'),
	('degenerative'),
	('congenital')	
;


INSERT INTO diseases (title, disease_type_id)
VALUES 
	('degenerative lumbo-sacral stenosis', 8),
	('astrocytoma', 7),
	('intervertebral disc disease', 8),
	('myelitis', 4),
	('ischemic infarction', 1),
	('necrotizing leukoencephalitis', 4)
;

INSERT INTO country (country_name)
VALUES 
	('Russia'),
	('Belarus'),
	('Ukraine'),
	('Kazakhstan'),
	('Kyrgyzstan'),
	('Finland'),
	('Estonia'),
	('Latvia'),
	('Lithuania')	
;


INSERT INTO city (city_name, country_id)
VALUES 
	('St. Petersburg', 1),
	('Moscow', 1),
	('Pskov', 1),
	('Yekaterinburg', 1),
	('Novosibirsk', 1),
	('Samara', 1),
	('Kaliningrad', 1),
	('Vitebsk', 2),
	('Minsk', 2), 
	('Sumy', 3),
	('Kyiv', 3),
	('Astana', 4),
	('Lapenraanta', 6),
	('Helsinki', 6),
	('Tallinn', 7)	
;


INSERT INTO address (owners_id, address, city_id, country_id)
VALUES 
	(1, 'Кондратьевский пр., 64 корпус 5', 1, 1),
	(2, 'ул. Миклухо-Маклая, 55 строение 2', 2, 1),
	(3, '3-й Серафимовича пер., 4', 5, 1),
	(4, 'ул. Огарева, 111', 7, 1),
	(5, 'ул. Паньковская, 6А', 11, 3),
	(6, 'Kannelkatu 6', 13, 6)
;


INSERT INTO mri_procedure (title)
VALUES 
	('Brain MRI'),
	('Cervical MRI C1-C5'),
	('Cervical MRI C5-Th2'),
	('Thoracic MRI Th3-L3'),
	('Lumbar MRI L4-S1')	
;


INSERT INTO payment (owners_id, pets_id, procedure_id, value)
VALUES
	(1, 2, 1, 9800),
 	(2, 1, 2, 10200),
 	(3, 4, 3, 8700),
 	(4, 3, 2, 11600),
 	(5, 6, 5, 13300),
 	(6, 5, 2, 9800)	
;



INSERT INTO performed_mri (owners_id, pets_id, procedure_id, presumptive_disease_id, payment_id)
VALUES 
	(1, 2, 1, 1, 6),
 	(2, 1, 2, 2, 5),
 	(3, 4, 3, 3, 4),
 	(4, 3, 2, 4, 3),
 	(5, 6, 5, 5, 2),
 	(6, 5, 2, 6, 1)	
;


/*сколько денег мы заработали на дегенеративных болячках*/
SELECT sum(p.value) 
FROM performed_mri AS pm
JOIN diseases AS d ON pm.presumptive_disease_id = d.id 
JOIN payment AS p ON pm.payment_id = p.id  
WHERE disease_type_id = (
	SELECT id FROM disease_types WHERE title = 'degenerative')
;



/*средний возраст животных на мрт*/
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, p.birthday, NOW())), 1) AS 'average age' 
FROM performed_mri AS pm
JOIN pets AS p ON pm.pets_id = p.id 
;



/*средний чек на мрт*/
SELECT ROUND(AVG(value), 2) AS 'average pay'
FROM payment 
;



/*самая частая зона исследования на МРТ*/
SELECT title, count(id) AS 'counter'
FROM mri_procedure
WHERE id IN (
	SELECT procedure_id FROM performed_mri)
GROUP BY id
;


/*адекватный вид карты клиента*/
CREATE OR REPLACE VIEW client_card AS 
	SELECT 
		CONCAT(firstname, ' ', lastname) AS name, email, phone, address, city_name AS city, country_name AS country
	FROM owners AS o 
	JOIN address AS a ON o.id = a.owners_id
	JOIN city AS c ON a.city_id = c.id
	JOIN country AS cc ON a.country_id = cc.id
	ORDER BY name
;

SELECT * FROM client_card;


/*адекватный вид списка проведенных МРТ*/
CREATE OR REPLACE VIEW mri_list AS 
	SELECT CONCAT(firstname, ' ', lastname) AS owners_name, species, breed, name AS pets_name, title, performed_at 
	FROM performed_mri AS pm
	JOIN owners AS o ON pm.owners_id = o.id 
	JOIN pets AS p ON pm.pets_id = p.id 
	JOIN mri_procedure AS mp ON pm.procedure_id = mp.id 
;
SELECT * FROM mri_list;


/*возвращает кличку животного по имени и фамилии владельца*/
DROP FUNCTION IF EXISTS owners_pets;
CREATE FUNCTION owners_pets (s CHAR(20))
RETURNS CHAR(50) DETERMINISTIC
BEGIN 
	DECLARE pets_name CHAR(50);
		SELECT p.name INTO pets_name
		FROM pets AS p
		JOIN owners AS o ON p.owner_id = o.id
		WHERE CONCAT(o.firstname, ' ', o.lastname) = s;
	RETURN (pets_name);
END


SELECT owners_pets('Elena Nemchinova');






