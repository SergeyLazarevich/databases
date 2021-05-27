/*
 * 1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и
 * пароль, который указывался при установке.
*/
[client]
user=root
password=master
/*
 * 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов,
 * числового id и строкового name
 */
DROP DATABASE IF EXISTS example;
CREATE DATABASE  example;
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED,
	name VARCHAR(255)
	) COMMENT = 'таблица состоящую из двух столбцов, числового id и строкового name.';
DESCRIBE users;
/*
 * 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа
 * в новую базу данных sample.
 */
-- C:\Users\VPSuser>mysqldump example > C:\example.sql
CREATE DATABASE  sample;
-- C:\Users\VPSuser>mysql  sample < C:\example.sql
USE sample;
DESCRIBE users;
DROP DATABASE IF EXISTS example;
DROP DATABASE IF EXISTS  sample;
/*
 * 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте
 * дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы
 * дамп содержал только первые 100 строк таблицы
 */
-- C:\Users\VPSuser>mysqldump --where="true limit 100" mysql help_keyword > C:\sample.sql

