-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT from_user_id, 
       COUNT(to_user_id) AS total
    FROM messages 
	WHERE to_user_id = 1
    GROUP BY from_user_id 
	ORDER BY total DESC
    LIMIT 1;
    
-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT 
	COUNT(*) AS kid
FROM likes 
WHERE user_id IN (
  SELECT id FROM users 
  WHERE id IN (SELECT user_id FROM profiles 
                WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10 ));
              
-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины
SELECT 
(SELECT 
	COUNT(*)
FROM likes 
WHERE user_id IN (SELECT id FROM users WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'f')) ) AS woman,
(SELECT 
	COUNT(*)
FROM likes 
WHERE user_id IN (SELECT id FROM users WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'm')) ) AS man;

