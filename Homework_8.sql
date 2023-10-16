/* 1)
 * Пусть задан некоторый пользователь. Из всех пользователей соц. сети 
 * найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
 */

USE vk;

-- допустим, выбран пользователь 12

SELECT u.firstname, u.lastname, m.to_user_id, count(*) AS 'cntr'
FROM messages AS m
JOIN users AS u
ON m.from_user_id = u.id 
WHERE to_user_id = 12
GROUP BY u.firstname, u.lastname, m.to_user_id
ORDER BY count(*) DESC 
LIMIT 1
;

/* 2)
 * Подсчитать общее количество лайков, которые получили пользователи младше 10 лет
 */

SELECT count(*)
FROM (
	SELECT 
		m.user_id AS 'id кому поставили лайк', 
		l.media_id AS 'id записи, которой ставят лайк',
		TIMESTAMPDIfF(YEAR, p.birthday, now()) AS 'age'
	FROM media AS m
	JOIN likes AS l JOIN profiles AS p
	ON (l.media_id = m.id AND p.user_id = m.user_id)
		) AS tbl1
WHERE age <= 10
;

/* 3)
 * Определить кто больше поставил лайков (всего): мужчины или женщины.
 */


SELECT 
	p.gender AS 'gender',
	count(*) AS 'cntr'
FROM likes AS l
JOIN profiles AS p 
ON l.user_id = p.user_id 
GROUP BY gender
;









