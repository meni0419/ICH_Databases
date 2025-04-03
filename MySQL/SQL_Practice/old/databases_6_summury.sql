/* Выведите название страны с кодом DEU как “Германия”.*/
SELECT
	if(Code = 'DEU', 'Deutchland', c.Name) AS new_name,
	Code 
FROM
	country c

/* Выведите список городов Германии так, чтобы название страны рядом с названием города, было по-русски.*/
SELECT
	c2.Name ,
	if(c2.CountryCode = 'DEU', 'Deutchland', c.Name) AS name_country 
FROM
	country c, city c2
WHERE c.Code = c2.CountryCode 
AND c.Code = 'DEU'
ORDER BY name_country

/* Отсортируйте города Германии по возрастанию населения.*/
SELECT
	Name 
FROM
	city c
WHERE c.CountryCode = 'DEU'
ORDER BY c.Population 

/* Разделите страны на 4 категории по площади: меньше 1000 - tiny, более 1000, но менее 100000 - small, более 100000, 
 * но менее миллиона - medium, и более миллиона - big. Напишите запрос, который выводит названия страны и категорию по площади.*/
SELECT
	c.Name ,
	CASE
		WHEN SurfaceArea < 1000
			THEN 'tiny'
		WHEN SurfaceArea < 100000
			THEN 'small'
		WHEN SurfaceArea < 1000000
			THEN 'medium'
		ELSE 'big'
	END AS cat_surfaceArea,
	SurfaceArea 
FROM
	country c
ORDER BY c.SurfaceArea DESC

/*Ознакомьтесь с языками, на которых говорят в Канаде.*/
/*Разделите языки Канады на две категорию распространённости по своему усмотрению.*/

SELECT
	c2.`Language` ,
	IF(c2.Percentage>60, 'BIG', 'small') AS popularity,
	c2.Percentage 
FROM
	country c, countrylanguage c2 
WHERE c.Code = c2.CountryCode 
AND c.Name = 'Canada'
ORDER BY c2.Percentage DESC 

#Посчитайте количество людей, живущих в Азии
SELECT
	c.Continent ,
	SUM(c.Population) 
FROM
	country c 
WHERE c.Continent = 'Asia'

#Выведите список городов Индии и Германии: названия города, название страны так, чтобы название страны было на русском. 
SELECT
	c2.Name ,
	if(c.Code = 'DEU',
	'Deutchland',
	if(c.Code = 'IND',
	'Bharata',
	c2.Name)) AS name_country,
	c.Code 
FROM
	country c,
	city c2
WHERE
	c.Code = c2.CountryCode
	AND (c.Code = 'DEU'
		OR c.Code = 'IND')
ORDER BY
	name_country

#Подумайте о других способах написать этот запрос (использовать LIKE, IN, =, etc)
SELECT
	c2.Name ,
	IF(c.Code LIKE 'DEU',
	'Deutchland',
	IF(c.Code LIKE 'IND',
	'Bharata',
	c2.Name)) AS name_country,
	c.Code
FROM
	country c,
	city c2
WHERE
	c.Code = c2.CountryCode
	AND (c.Code IN ('DEU', 'IND') OR c.Code LIKE '_U_')
ORDER BY
	name_country
