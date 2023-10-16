/* 1)
 * Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
 * который больше всех общался с выбранным пользователем (написал ему сообщений).
 */

USE vk;


SELECT 
	from_user_id, 
	COUNT(*) AS cntr
FROM 
	messages 
WHERE 
	to_user_id = 3
GROUP BY 
	from_user_id
ORDER BY 
	cntr DESC
LIMIT 1
;	


/*
 * 2)
 * Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
 */

SELECT 
	COUNT(*) AS likes_counter 
FROM 
	likes 
WHERE 
	media_id IN (
	SELECT id 
	FROM media 
	WHERE user_id IN (
		SELECT 	user_id 
		FROM profiles 
		WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <= 10)
			)	
;



/*
 * 3)Определить кто больше поставил лайков (всего): мужчины или женщины.
 */

SELECT 
CASE 
	WHEN 
(
	SELECT COUNT(*) 
	FROM likes 
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles 
		WHERE gender = 0)
) > (
	SELECT COUNT(*) 
	FROM likes 
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles 
		WHERE gender = 1)
) 
	THEN 'женских лайков больше'
	ELSE 'мужских лайков больше'
END AS 'считалка лайков'
;
