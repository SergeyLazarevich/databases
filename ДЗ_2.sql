/*
 * 1. ���������� ���� MySQL. �������� � �������� ���������� ���� .my.cnf, ����� � ��� ����� �
 * ������, ������� ���������� ��� ���������.
*/
[client]
user=root
password=master
/*
 * 2. �������� ���� ������ example, ���������� � ��� ������� users, ��������� �� ���� ��������,
 * ��������� id � ���������� name
 */
DROP DATABASE IF EXISTS example;
CREATE DATABASE  example;
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED,
	name VARCHAR(255)
	) COMMENT = '������� ��������� �� ���� ��������, ��������� id � ���������� name.';
DESCRIBE users;
/*
 * 3. �������� ���� ���� ������ example �� ����������� �������, ���������� ���������� �����
 * � ����� ���� ������ sample.
 */
-- C:\Users\VPSuser>mysqldump example > C:\example.sql
CREATE DATABASE  sample;
-- C:\Users\VPSuser>mysql  sample < C:\example.sql
USE sample;
DESCRIBE users;
DROP DATABASE IF EXISTS example;
DROP DATABASE IF EXISTS  sample;
/*
 * 4. (�� �������) ������������ ����� �������� � ������������� ������� mysqldump. ��������
 * ���� ������������ ������� help_keyword ���� ������ mysql. ������ ��������� ����, �����
 * ���� �������� ������ ������ 100 ����� �������
 */
-- C:\Users\VPSuser>mysqldump --where="true limit 100" mysql help_keyword > C:\sample.sql

