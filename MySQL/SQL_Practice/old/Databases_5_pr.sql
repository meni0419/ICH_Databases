-- Разделите самолеты на три класса по возрасту. Если самолет произведен раньше 2000 года, 
-- то отнесите его к классу 'Old'. Если самолет произведен между 2000 и 2010 годами включительно, 
-- то отнесите его к классу 'Mid'. Более новые самолеты отнесите к классу 'New'. 
-- Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
-- Отсортируйте выборку по классу возраста в порядке возрастания.
-- В выборке должны присутствовать два атрибута — side_number, age.

SELECT 
	side_number,
	CASE
		WHEN production_year > 2010
			THEN "New"
		WHEN production_year >= 2000 
			THEN "Mid"
		ELSE "Old"
	END AS age
FROM airliners
WHERE `range` <=10000
ORDER BY `range`  

-- Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, 
-- а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, trip_id, new_price.

SELECT
	t.id,
	t.trip_id,
	t.price,
	CASE
		WHEN t.service_class = 'Business'
			THEN t.price * 0.9
		WHEN t.service_class = 'PremiumEconomy' 
			THEN t.price * 0.8
		WHEN t.service_class = 'Economy' 
			THEN t.price * 0.85
		ELSE NULL
	END AS new_price
FROM
	tickets t
WHERE
	t.trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G')
ORDER BY
	t.price DESC;

-- Выведите данные о билетах разной ценовой категории. Среди билетов экономкласса (Economy) 
-- добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. 
-- Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 до 30 000 включительно. 
-- Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000. 
-- В решении необходимо использовать оператор CASE.
-- В выборке должны присутствовать три атрибута — id, service_class, price.
-- case inside where

SELECT
	id,
	service_class,
	price
FROM
	tickets
WHERE
	CASE
		service_class
		WHEN 'Business' THEN price > 100000
		WHEN 'Economy' THEN price BETWEEN 10000 AND 11000
		WHEN 'PremiumEconomy' THEN price between 20000 AND 30000
	END
ORDER BY
	price DESC;

-- Разделите самолеты на ближне-, средне- и дальнемагистральные. Ближнемагистральными будем считать самолеты, 
-- дальность полета которых > 1000 км и <= 2500 км. Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. В выборке должно быть два столбца, где в первом указана модель самолета. 
-- Во втором, category, — категория, со значениями short-haul, medium-haul, long-haul (ближне-, средне- и дальнемагистральные соответственно). 
-- Каждый самолет точно попадает ровно в одну категорию.
-- В выборке должны присутствовать два атрибута — model_name, category.
SELECT 
	a.model_name,
	CASE 
		WHEN a.`range` > 6000 THEN 'long-haul'
		WHEN a.`range` > 2500 THEN 'medium-haul'
		WHEN a.`range` > 1000 THEN 'short-haul'
		ELSE 'unknow'
	END AS category,
	`range` 
FROM
	airliners a
	ORDER BY a.`range` DESC;