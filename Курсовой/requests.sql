USE sushi_house;

-- Рейтинг  продуктов
SELECT 
	name,
	count(*) as likes_count
  FROM products p
    JOIN likes_products lp ON lp.product_id = p.id and lp.vote = 1
  GROUP BY p.id
  ORDER BY likes_count DESC;

-- Рейтинг поваров
SELECT 
	first_name, 
	last_name,
	count(*) as likes_count
  FROM cooks с
    JOIN likes_cooks lс ON lс.cook_id = с.id and lс.vote = 1
  GROUP BY с.id
  ORDER BY likes_count DESC;

-- Рейтинг курьеров
SELECT 
	first_name, 
	last_name,
	count(*) as likes_count
  FROM courier_info сi
    JOIN likes_courier lс ON lс.courier_id = сi.id and lс.vote = 1
  GROUP BY сi.id
  ORDER BY likes_count DESC;

-- Доставка
SELECT
	first_name, 
	last_name,
	o.status
  FROM users u 
  	JOIN orders o ON o.user_id = u.id






















