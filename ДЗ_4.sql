-- 1. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)
-- База данных заполнена сгенерированными значениями при помощи сервиса http://filldb.info/

-- 2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname
	FROM users
	ORDER BY firstname ASC; -- необязательный параметр, так как он установлен по умолчанию

-- 3. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE profiles 
	ADD is_active ENUM ('true','false') NOT NULL DEFAULT 'true';
	
ALTER TABLE profiles 
	ADD age TINYINT UNSIGNED NOT NULL DEFAULT '0'; -- столбец «Возраст» используется для наглядности, так как он не был предусмотрен 
	
UPDATE profiles SET age = (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5));

UPDATE profiles SET is_active = 'false'
	WHERE age <= 18;

-- 4. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
SELECT DISTINCT COUNT(*)
	FROM messages
	WHERE created_at > CURRENT_DATE; -- запрос на количества сообщений из будущего

DELETE FROM messages
 	WHERE created_at > CURRENT_DATE;

-- 5. Написать название темы курсового проекта (в комментарии)
База данных интернет-магазина