-- 2. Выведите список стран с языками, на которых в них говорят.
SELECT country.Name AS Country, countrylanguage.Language
FROM country
         JOIN countrylanguage ON country.Code = countrylanguage.CountryCode;

-- 3. Выведите список городов с их населением и названием стран
SELECT city.Name AS City, city.Population, country.Name AS Country
FROM city
         JOIN country ON city.CountryCode = country.Code;

-- 4. Выведите список городов в South Africa
SELECT city.Name AS City
FROM city
         JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'South Africa';

-- 5. Выведите список стран с названиями столиц.
-- Подсказка: в таблице country есть поле Capital, которое содержит номер города из таблицы City.
SELECT country.Name AS Country, city.Name AS Capital
FROM country
         JOIN city ON country.Capital = city.ID;

-- 6. Измените запрос 4 таким образом, чтобы выводилось население в столице. 
SELECT country.Name AS Country, city.Name AS Capital, city.Population AS CapitalPopulation
FROM country
         JOIN city ON country.Capital = city.ID
WHERE country.Name = 'South Africa';

-- 7. Напишите запрос, который возвращает название столицы United States
SELECT city.Name AS Capital
FROM country
         JOIN city ON country.Capital = city.ID
WHERE country.Name = 'United States';

-- 8. Используя базу hr_data.sql, вывести имя, фамилию и город сотрудника. 
SELECT hre.first_name, hre.last_name, loc.city AS City
FROM hr.employees hre
         JOIN hr.departments dep ON hre.department_id = dep.department_id
         JOIN hr.locations loc ON dep.location_id = loc.location_id;

-- 9. Используя базу hr_data.sql, вывести города и соответствующие городам страны.

SELECT loc.city AS City, ctry.country_name AS Country
FROM hr.locations loc
         JOIN hr.countries ctry ON loc.country_id = ctry.country_id;
