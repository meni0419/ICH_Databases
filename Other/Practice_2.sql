#16
SELECT 
	e.first_name, e.last_name, e.department_id
FROM employees e 
WHERE e.department_id NOT IN (80, 110);

#17
SELECT 
	e.first_name, e.last_name, e.salary, e.salary 
FROM employees e 
WHERE e.salary BETWEEN 5000 and 7000
ORDER BY e.salary DESC;

# WORLD
#1
SELECT 
	(SELECT COUNT(c.ID) FROM city c) as 'count city',
	(SELECT COUNT(c2.Code) FROM country c2) as 'count country';

-- SELECT 
-- 	COUNT(c.ID) as 'count city',
-- 	COUNT(c2.Code) as 'count country'
-- FROM city c
-- JOIN country c2 ON c.CountryCode = c2.Code 
-- 
-- SELECT
-- 	COUNT(c.ID) as 'count city',
-- 	COUNT(c2.Code) as 'count country'	
-- FROM city c, country c2 
-- WHERE c.CountryCode = c2.Code

SELECT 
	sum(if (c.Continent = 'Asia', 1,0)) as 'count on Asia' 
FROM country c;

SELECT
	c.Name, c.LocalName, c.Continent 
FROM country c 
WHERE c.Continent = 'Asia';

SELECT 
	c.Name 
FROM country c 
WHERE c.Population > 1000000000

SELECT 
	c.Name as 'city', c2.Name 'country'
FROM city c, country c2 
WHERE c.CountryCode = c2.Code 
AND c2.Name = 'India';

SELECT 
	c.Name 
FROM city c 
WHERE c.Name LIKE 'A_%'
ORDER BY c.Name;
