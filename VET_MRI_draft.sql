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
	address VARCHAR(150),
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

DROP TABLE IF EXISTS diagnoses;
CREATE TABLE diagnoses (
	id SERIAL,
	class ENUM('vascular', 'infectious', 'traumatic', 'autoimmune', 'metabolic', 'iatrogenic', 'neoplastic', 'congenital', 'degenerative'),
	title VARCHAR(50)
);


DROP TABLE IF EXISTS performed_mri;
CREATE TABLE performed_mri (
	id SERIAL,
	pet_id BIGINT UNSIGNED NOT NULL,
	inspection_zone VARCHAR(25),
	presumptive_diagnosis VARCHAR(50),
	
	FOREIGN KEY (pet_id) REFERENCES pets(id)
);

INSERT INTO owners (firstname, lastname, email, phone, address)
VALUES 
	('Olga', 'Fillipova', 'filkir66@gmail.com', '+79219575467', 'Долгоозерная 5*1*216'),
	('Vitaliy', 'Marochko', 'slypi@bk.ru', '+79617023287', 'Коломяжский пр 15-2-1132'),
	('Elena', 'Nemchinova', 'elenanemchinova91@gmail.com', '+79533534875', ' Бугры Шоссейная 38-78'),
	('Pavel', 'Shlik', 'shlyk_pasha@mail.ru', '+79315419960', 'Лен.Обл., пос.Молосковицы, Средняя, 6'),
	('Alexey', 'Stolnikov', 'alexei87-87@mail.ru', '+79811504387', 'ш.Фермское д.16 кв.54'),
	('Olga', 'Oderisheva', 'albinoniclassic@gmail.com', '+79500356633', null)
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

INSERT INTO diagnoses (class, title)
VALUES 
	('degenerative', 'degenerative lumbo-sacral stenosis'),
	('neoplastic', 'astrocytoma'),
	('degenerative', 'intervertebral disc disease'),
	('infectious', 'myelitis'),
	('vascular', 'ischemic infarction'),
	('autoimmune', 'necrotizing leukoencephalitis')
;

INSERT INTO performed_mri (pet_id, inspection_zone, presumptive_diagnosis)
VALUES 
	(1, 'L4-S3', 'degenerative lumbo-sacral stenosis'),
	(2, 'brain', 'astrocytoma'),
	(3, 'Th3-L3', 'intervertebral disc disease'),
	(4, 'C0-Th2', 'myelitis'),
	(5, 'brain', 'ischemic infarction'),
	(6, 'brain', 'necrotizing leukoencephalitis')
;
	












