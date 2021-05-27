-- Процедура вставки нового пользователя
DROP PROCEDURE IF EXISTS add_user;
DELIMITER //
CREATE PROCEDURE add_user(first_name VARCHAR(30),
  						  last_name VARCHAR(35),
  						  birthday_at DATE,
  						  phone_number VARCHAR(20),
  						  street VARCHAR(25),
  						  house INT,
  						  apartment INT,
  						  OUT u_in_status VARCHAR(200))
BEGIN
	DECLARE _rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET _rollback = 1;
			GET STACKED DIAGNOSTICS CONDITION 1
				code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
			SET u_in_status := concat('Aborted. Error code: ', code, '. Text: ', error_string);
		END;

	START TRANSACTION;
	INSERT INTO users
		(first_name,  last_name, birthday_at, phone_number, street, house, apartment)
	VALUES
		(first_name,  last_name, birthday_at, phone_number, street, house, apartment);

	IF _rollback THEN
		ROLLBACK;
	ELSE
		SET u_in_status := 'OK';
		COMMIT;
	END IF;

END //
DELIMITER ;


--- --------------------------------------------

-- Процедура вставки нового продукта
DROP PROCEDURE IF EXISTS add_product;
DELIMITER //
CREATE PROCEDURE add_product( name VARCHAR(255),
  							desription TEXT,
 						    price DECIMAL (5,2),
  							catalog_id BIGINT,
  						  OUT u_in_status VARCHAR(200))
BEGIN
	DECLARE _rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET _rollback = 1;
			GET STACKED DIAGNOSTICS CONDITION 1
				code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
			SET u_in_status := concat('Aborted. Error code: ', code, '. Text: ', error_string);
		END;

	START TRANSACTION;
	INSERT INTO products
		(name, desription, price, catalog_id)
	VALUES
		(name, desription, price, catalog_id);

	IF _rollback THEN
		ROLLBACK;
	ELSE
		SET u_in_status := 'OK';
		COMMIT;
	END IF;

END //
DELIMITER ;


--- --------------------------------------------

-- Процедура вставки нового ордера на покупку
DROP PROCEDURE IF EXISTS add_orders;
DELIMITER //
CREATE PROCEDURE add_orders(user_id BIGINT UNSIGNED,
  							courier_id BIGINT UNSIGNED,
  							product_id BIGINT UNSIGNED,
  							total INT UNSIGNED,
  						  OUT u_in_status VARCHAR(300))
BEGIN
	DECLARE _rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(50);
	DECLARE error_string VARCHAR(250);
	DECLARE last_user_id INT;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET _rollback = 1;
			GET STACKED DIAGNOSTICS CONDITION 1
				code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
			SET u_in_status := concat('Aborted. Error code: ', code, '. Text: ', error_string);
		END;

	START TRANSACTION;
	INSERT INTO orders
		(user_id, courier_id)
	VALUES
		(user_id, courier_id);
	SELECT last_insert_id() INTO @last_user_id;
	INSERT INTO orders_products
		(order_id,  product_id, total)
	VALUES
		(@last_user_id,  product_id, total);

	IF _rollback THEN
		ROLLBACK;
	ELSE
		SET u_in_status := 'OK';
		COMMIT;
	END IF;

END //
DELIMITER ;


--- --------------------------------------------

CALL add_user('Сргей','Рабинович', '1960-12-21', '37528456247', 'Пушкинский','25','103',  @u_in_status);
SELECT @u_in_status;

CALL add_orders('5', '3', '10', '2',  @u_in_status);
SELECT @u_in_status;

CALL add_product('Акаи Каки','Рис, нори, креветка, огурец, икра тобико, сыр творожный, тунец.','13', '1',  @u_in_status);
SELECT @u_in_status;


-- Триггеры заполнения таблицы logs

DELIMITER //
DROP TRIGGER IF EXISTS log_users//
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, row_id) VALUES ( 'users', NEW.id);
END//

DROP TRIGGER IF EXISTS log_products//
CREATE TRIGGER log_products AFTER  INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, row_id)  VALUES ( 'products', NEW.id);
END//

DROP TRIGGER IF EXISTS log_orders//
CREATE TRIGGER log_orders AFTER  INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, row_id)  VALUES ( 'orders', NEW.id);
END//
DELIMITER ;
































