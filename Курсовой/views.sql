-- представление, показывающее кто что готовил
DROP VIEW IF EXISTS sushi_house.cook_product;
CREATE OR REPLACE VIEW sushi_house.cook_product (name,total,cook_name) AS 
	SELECT 
		name,
		cp.total,
		CONCAT (c.last_name,' ',c.first_name)
	FROM  sushi_house.cooks_products cp
		JOIN sushi_house.products p ON cp.product_id = p.id
		JOIN sushi_house.cooks c ON c.id = cp.cooks_id;
		  	
SELECT * FROM sushi_house.cook_product;			  	
		  	

-- представление, показывающее пользователю полную информацию о заказанном продукте
DROP VIEW IF EXISTS sushi_house.all_product;
CREATE OR REPLACE VIEW sushi_house.all_product (users, product, cook, courier, status) AS 
	SELECT 
		CONCAT (u.last_name,' ',u.first_name), -- user
		p.name, -- product
		CONCAT (c.last_name,' ',c.first_name), -- cook
		CONCAT (ci.last_name,' ',ci.first_name), -- courier
		o2.status
		
	FROM  sushi_house.orders_products op
		JOIN sushi_house.orders o ON op.order_id = o.id 
		JOIN sushi_house.users u ON o.user_id = u.id 
		JOIN sushi_house.products p ON op.product_id = p.id 
		JOIN sushi_house.cooks_products cp ON p.id = cp.product_id 
		JOIN sushi_house.cooks c ON cp.cooks_id = c.id 
		JOIN sushi_house.courier_info ci ON o.courier_id = ci.id 
		JOIN sushi_house.orders o2 ON op.order_id = o2.id 
		;
		  	
SELECT * FROM sushi_house.all_product;
		  	
		  	
	  	
		  	
		  	
		  	
		  	
		  	
		  	
		  	
		  	