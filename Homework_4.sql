
#i. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)

USE vk;

INSERT IGNORE INTO `users` (`firstname`, `lastname`, `email`, `phone`)
VALUES 
('Denis', 'Egorov', 'kolobok-99@yandex.ru', '89215560721'),
('Dmitry', 'Egorov', 'wisdom666@mail.ru', '89052040934'),
('Olga', 'Umeremkova', 'olenka3423@gmail.com', '89991233445'),
('Olga','Dashicheva','sunny123@yandex.ru','89114567834'),
('Alexandr', 'Volkov', 'vol4ara666@bing.com', '89049873452'),
('Natalya', 'Alfinova', 'natalf28@mail.ru', '89053843472'),
('Elena', 'Berezina', 'eleberez78@gmail.com', '89219856452'),
('Kseniya', 'Vinogradova', 'xenyavin@bing.com', '89139974454'),
('Sergey', 'Gridnev', 'sergrid67@yandex.ru', '89159809852'),
('Vladimir', 'Eliseenko', 'vladlen1945@bing.com', '89064773449'),
('Galina', 'Ivanova', 'galochka777@gmail.com', '89219879884'),
('Polina', 'Kalacheva', 'romashka13@ya.ru', '89029845487'),
('Alexey', 'Kutz', 'kutzok@bing.com', '89059573122')
;


INSERT IGNORE INTO profiles (user_id, gender, hometown, birthday)
VALUES
(1, '1', 'Pskov', '1992-03-29'),
(2, '1', 'Pskov', '1989-01-02'),
(3, '0', 'Moscow', '1993-02-21'),
(4, '0', 'Saint-Petersburg', '1996-09-23'),
(5, '1', 'London', '1999-07-19'),
(6, '0', 'Paris', '1991-11-29'),
(7, '0', 'Milano', '1995-12-13'),
(8, '0', 'Harkov', '1994-12-20'),
(9, '1', 'Ekaterinburg', '1999-11-14'),
(10, '1', 'Samara', '1999-11-29'),
(11, '0', 'Novgorod', '1995-12-12'),
(12, '0', 'Yakutsk', '1994-04-25'),
(13, '1', 'Ulan-ude', '1993-08-17')
;

INSERT IGNORE INTO messages  (from_user_id , to_user_id , body)
VALUES
(1, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
(2, 1, 'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(1, 3, 'Ut enim ad minim veniam, quis nostrud '),
(2, 1, 'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '),
(1, 12, 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit'),
(13, 6, 'aut fugit, sed quia consequuntur magni dolores eos qui'),
(3, 7, 'ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non'),
(3, 9, 'Ut enim ad minima veniam, quis'),
(7, 12, 'exercitationem ullam corporis suscipit laboriosam,'),
(5, 11, 'nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit')
;

INSERT IGNORE INTO media_types (name)
VALUES
('text'),
('image'),
('audio'),
('video')
;

INSERT IGNORE INTO media (user_id , media_type_id, filename)
VALUES
(1, 1, 'war and priest'),
(3, 2, 'Ut enim'),
(5, 3, 'voluptatem'),
(7, 4, 'Neque porro quisquam est'),
(9, 1, 'ut labore et dolore'),
(11, 2, 'quia dolor sit amet'),
(13, 3, 'exercitationem'),
(2, 4, 'reprehenderit qui')
;

INSERT IGNORE INTO likes (user_id , media_id)
VALUES
(2, 1),
(4, 3),
(6, 5),
(8, 7),
(10, 2),
(12, 4),
(1, 6),
(3, 8),
(5, 1)
;

INSERT IGNORE INTO friend_requests (initiator_user_id, target_user_id, status)
VALUES 
(1, 3, 'requested'),
(5, 7, 'requested'),
(9, 11, 'requested'),
(13, 2, 'requested'),
(4, 6, 'requested'),
(8, 10, 'requested'),
(12, 1, 'requested')
;

UPDATE friend_requests 
SET 
	status = 'approved'
WHERE initiator_user_id = 9 AND target_user_id = 11
;

UPDATE friend_requests 
SET 
	status = 'declined'
WHERE initiator_user_id = 4 AND target_user_id = 6
;

INSERT IGNORE INTO communities (name, admin_user_id)
VALUES 
('voluptatem quia', 12),
('itation ullamco', 9),
('laboris nisi ut', 6),
('aliquip ex ea commodo consequat', 4)
;


# ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname 
FROM users 
ORDER BY firstname ASC
;

/* iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1) */

ALTER TABLE profiles 
ADD COLUMN (
	is_active BOOL DEFAULT TRUE
);

INSERT IGNORE INTO `users` (`firstname`, `lastname`, `email`, `phone`)
VALUES 
('Alina', 'Kabaeva', 'kabalina_99@yandex.ru', '89256568726')
;
INSERT IGNORE INTO profiles (user_id, gender, hometown, birthday)
VALUES
(14, '0', 'Porhov', '2012-03-29')
;

UPDATE profiles 
SET 
	is_active  = FALSE
WHERE DATEDIFF(CURDATE(), birthday) < 6570 
;

# iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

DELETE FROM messages 
WHERE DATEDIFF(created_at, CURDATE()) > 0
;
