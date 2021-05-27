DROP DATABASE IF EXISTS sushi_house;
CREATE DATABASE sushi_house;
USE sushi_house;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Разделы магазина';


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL (5,2) COMMENT 'Цена',
  catalog_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT = 'Товарные позиции';


DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  product_id BIGINT  UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT = 'Запасы';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL  COMMENT 'Имя',
  last_name VARCHAR(35) NOT NULL  COMMENT 'Фамилия',
  birthday_at DATE COMMENT 'Дата рождения',
  phone_number VARCHAR(20) NOT NULL COMMENT 'Телефон',
  street VARCHAR(25) NOT NULL COMMENT 'Улица',
  house INT NOT NULL COMMENT 'Дом',
  apartment INT NOT NULL COMMENT 'Квартира',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS courier_info;
CREATE TABLE courier_info (
id SERIAL PRIMARY KEY,
first_name VARCHAR(30) NOT NULL  COMMENT 'Имя курьера',
last_name VARCHAR(35) NOT NULL  COMMENT 'Фамилия курьера',
phone_number VARCHAR(20) NOT NULL  COMMENT 'Телефон',
delivery_type VARCHAR(10) NOT NULL  COMMENT 'Способ доставки',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
COMMENT = 'курьеры';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id  BIGINT  UNSIGNED,
  product_id  BIGINT  UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME COMMENT 'Начало',
  finished_at DATETIME COMMENT 'Конец',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Скидки';


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  courier_id BIGINT UNSIGNED,
  status ENUM('Доставлен', 'Отменён', 'Доставляется') default  ('Доставляется'),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (courier_id) REFERENCES courier_info(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Заказы';


DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  total INT UNSIGNED COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Состав заказа';


DROP TABLE IF EXISTS cooks;
CREATE TABLE cooks (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL  COMMENT 'Имя повара',
	last_name VARCHAR(35) NOT NULL  COMMENT 'Фамилия повара',
	phone_number VARCHAR(20) NOT NULL  COMMENT 'Телефон',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Повара';


DROP TABLE IF EXISTS cooks_products;
CREATE TABLE cooks_products (
  id SERIAL PRIMARY KEY,
  product_id BIGINT UNSIGNED,
  cooks_id BIGINT UNSIGNED,
  total INT UNSIGNED COMMENT 'Количество изготовленных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE cascade,
  FOREIGN KEY (cooks_id) REFERENCES cooks(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Состав заказа';


DROP TABLE IF EXISTS likes_products;
CREATE TABLE likes_products(
  user_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED NOT NULL,
  vote BIT DEFAULT 0 COMMENT 'Лайк или Дизлайк', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE cascade,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Рейтинг продуктов';


DROP TABLE IF EXISTS likes_cooks;
CREATE TABLE likes_cooks(
  user_id BIGINT UNSIGNED,
  cook_id BIGINT UNSIGNED NOT NULL,
  vote BIT DEFAULT 0 COMMENT 'Лайк или Дизлайк', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cook_id) REFERENCES cooks(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Рейтинг поворов';


DROP TABLE IF EXISTS likes_courier;
CREATE TABLE likes_courier(
  user_id BIGINT UNSIGNED,
  courier_id BIGINT UNSIGNED NOT NULL,
  vote BIT DEFAULT 0 COMMENT 'Лайк или Дизлайк', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (courier_id) REFERENCES courier_info(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Рейтинг курьеров';


DROP TABLE IF EXISTS Logs;
CREATE TABLE logs (
    created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'время и дата создания записи',
    table_name varchar(50) NOT NULL COMMENT 'название таблицы',
    row_id INT UNSIGNED NOT NULL COMMENT 'идентификатор первичного ключа'
) ENGINE = Archive;




















