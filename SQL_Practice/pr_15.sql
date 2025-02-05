# World: Выведите название страны с кодом IND как “Индия”
select if(Code = 'IND', 'Индия', `Name`) as `new_name`
from world.country
where Code = 'IND';

# HR: Найти всех сотрудников, чья фамилия начинается на букву L
select *
from hr.employees
where last_name LIKE 'L%';

# HR: Найти среднюю зарплату тех сотрудников, которые зарабатывают меньше 10000. С использованием IF
select avg(if(salary < 10000, salary, NULL))
from hr.employees;

# World: Выведите список городов Индии так, чтобы название страны рядом с названием города, было по-русски
select ci.Name, if(co.Code = 'IND', 'Индия', ci.`Name`) as `new_name`
from world.country co, world.city ci
where co.Code = ci.CountryCode
AND co.Code = 'IND';

select ci.Name, if(co.Code = 'IND', 'Индия', ci.`Name`) as `new_name`
from world.country co
join world.city ci ON co.Code = ci.CountryCode
order by new_name desc;


/*
t1
asd asd
asd asd
t2
пусто

right join:
1. Определяет что главная таблица справа t2
2. Выводит все записи из правой таблицы t2 и присоединяет таблицу t1, все ее записи, где совпадает условие после ON
3. Но в правой таблице ничего нет поэтому не к чему джоинить записи таблицы t1

Результат:
пусто

left join:
1. Определяет что главная таблица слева t1
2. Выводит все записи из левой таблицы t1 и присоединяет таблицу t2, все ее записи, где совпадает условие после ON
3. Но в правой таблице ничего нет поэтому к записям таблицы присоединяется просто NULL
Результат:
asd asd NULL NULL
asd asd NULL NULL


inner join
1. НЕ определяет главную таблицу
2. Выводит ТОЛЬКО записи из двух таблиц все ее записи, где совпадает условие после ON
3. Строк которые совпали нет, поэтому ничего не вывелось
Результат:
пусто
*/