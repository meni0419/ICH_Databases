-- 1. Подключиться к базе данных hr
USE hr;

-- 2. Вывести список region_id, total_countries,
--    где total_countries - количество стран в таблице.
--    Подсказка: работаем с таблицей countries, 
--    использовать оконную функцию over() и суммировать count(country_id).
select DISTINCT c.region_id                    r_id,
                r.region_name                  r_name,
                count(c.country_id) over () as total_countries
from countries c
         join regions r ON r.region_id = c.region_id
order by r.region_name;


-- 3. Изменить запрос 2 таким образом, чтобы для каждого region_id 
--    выводилось количество стран в этом регионе.
--    Подсказка: добавить partition by region_id в over().
select c.region_id                                                                 r_id,
       r.region_name                                                               r_name,
       c.country_name                                                              c_name,
       count(c.country_id) over (partition by c.region_id order by c.region_id) as total_countries
from countries c
         join regions r ON r.region_id = c.region_id
order by total_countries DESC;

-- 4. Работа с таблицей departments.
--    Написать запрос, который выводит location_id, department_name, dept_total, 
--    где dept_total - количество департаментов в location_id.
select location_id, department_name, count(department_id) over (partition by location_id) as dept_total
from departments
order by dept_total;

-- 5. Изменить запрос 3 таким образом, чтобы выводились названия городов, 
--    соответствующих location_id. 
select d.location_id,
       l.city,
       d.department_name,
       count(d.department_id) over (partition by d.location_id) as dept_total
from departments d
         join locations l ON l.location_id = d.location_id
order by dept_total;

-- 6. Работа с таблицей employees.
--    Вывести manager_id, last_name, total_manager_salary,
--    где total_manager_salary - общая зарплата подчиненных каждого менеджера (manager_id).
select DISTINCT e.manager_id, e2.last_name, sum(e.salary) over (partition by e.manager_id) as total_manager_salary
from employees e
         join (select * from employees) e2 ON e2.employee_id = e.manager_id;