-- Практическое задание по теме “Транзакции,
-- переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
-- транзакции.

START TRANSACTION;
UPDATE sample.users as u1 
JOIN shop.users as u2 on u2.id = 1
	SET 
	u1.name = u2.name , 
	u1.birthday_at = u2.birthday_at, 
	u1.created_at = u2.created_at , 
	u1.updated_at = u2.updated_at 
WHERE u1.id = 1;	
COMMIT;
	
-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW shop.cat (catalog, catalog_id) AS
	SELECT p.name, c.name
	    FROM shop.products as p
	JOIN shop.catalogs as c on c.id = p.catalog_id

SELECT * FROM shop.cat;

-- 3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
-- разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
-- 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
-- соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
-- отсутствует.


-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте
-- запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
-- записей.

-- Практическое задание по теме “Администрирование MySQL”
-- (эта тема изучается по вашему желанию)
-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
-- пользователю shop_read должны быть доступны только запросы на чтение данных, второму
-- пользователю shop — любые операции в пределах базы данных shop.


-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
-- username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
-- пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
-- извлекать записи из представления username.


-- Практическое задание по теме “Хранимые процедуры и
-- функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
-- текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
-- 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
-- вечер", с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello (times TIME)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE phrase VARCHAR(255);
	IF (times > '06:00' and times <= '12:00') THEN SET phrase = 'Доброе утро';
    ELSEIF (times > '12:00' and times <= '18:00') THEN SET phrase = 'Добрый день';
    ELSEIF (times > '18:00' and times <= '24:00') THEN SET phrase = 'Добрый вечер';
    ELSEIF (times > '00:00' and times <= '06:00') THEN SET phrase = 'Добрый ночи';
	ELSE SET phrase = 'Ошибка в параметре times';
	END IF;
RETURN phrase;
END; //
DELIMITER ;

SELECT hello ('07:00');
SELECT hello ('15:00');
SELECT hello ('19:00');
SELECT hello ('02:00');

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его
-- описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
-- принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
-- того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
-- NULL-значение необходимо отменить операцию.
DROP TRIGGER IF EXISTS check_products_insert;

DELIMITER //
CREATE TRIGGER check_products_insert BEFORE INSERT ON products
	FOR EACH ROW
	BEGIN
		IF (NEW.name IS NULL AND NEW.description IS NULL) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NOT NULL';
		END IF;
END//
DELIMITER ;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1);
 
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i5-7400', NULL, 12700.00, 1);
 
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL,NULL, 12700.00, 1);
-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух
-- предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
DROP FUNCTION IF EXISTS FIBONACCI;

DELIMITER //
CREATE FUNCTION FIBONACCI (namber INT)
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
	DECLARE a BIGINT UNSIGNED DEFAULT 0;
	DECLARE b BIGINT UNSIGNED DEFAULT 1;
	WHILE namber > 0 
	DO
	SET a = b;
	SET b = a + b;
	SET namber  = namber - 1;
	END WHILE;
RETURN a;
END; //
DELIMITER ;

SELECT FIBONACCI(50); 



