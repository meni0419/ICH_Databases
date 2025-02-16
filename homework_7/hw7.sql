-- Подключитесь к базе данных hr (которая находится на удаленном сервере).

USE hr;

-- Выведите количество сотрудников в базе
SELECT COUNT(*) AS employees_count
FROM employees;

-- Выведите количество департаментов (отделов) в базе
SELECT COUNT(*) AS departments_count
FROM departments;

-- Подключитесь к базе данных World (которая находится на удаленном сервере).

USE world;

-- Выведите среднее население в городах Индии (таблица city, код Индии - IND)
SELECT AVG(Population) AS average_population
FROM city
WHERE CountryCode = 'IND';

-- Выведите минимальное население в индийском городе и максимальное.
SELECT MIN(Population) AS min_population, MAX(Population) AS max_population
FROM city
WHERE CountryCode = 'IND';

-- Выведите самую большую площадь территории.
SELECT MAX(SurfaceArea) AS largest_surface_area
FROM country;

-- Выведите среднюю продолжительность жизни по странам.
SELECT AVG(LifeExpectancy) AS average_life_expectancy
FROM country;

-- Найдите самый населенный город (подсказка: использовать подзапросы)
SELECT Name AS most_populated_city, Population
FROM city
WHERE Population = (SELECT MAX(Population) FROM city);