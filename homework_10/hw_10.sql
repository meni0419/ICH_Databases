# 1. Подключиться к базе данных world
# 2. Вывести население в каждой стране. Результат содержит два поля: CountryCode, sum(Population). Запрос по таблице city.
select CountryCode, sum(Population) sum_p
from city
group by CountryCode
order by sum_p DESC;

# 3. Изменить запрос выше так, чтобы выводились только страны с населением более 3 млн человек.
select CountryCode, sum(Population) sum_p
from city
group by CountryCode
having sum_p > 3000000
order by sum_p DESC;

# 4. Сколько всего записей в результате?
with sum_population as (select CountryCode, sum(Population) sum_p
                        from city
                        group by CountryCode
                        having sum_p > 3000000
                        order by sum_p DESC)
select count(*)
from sum_population;

# 5. Поменять запрос выше так, чтобы в результате вместо кода страны выводилось ее название. Подсказка: нужен join таблиц city и country по полю CountryCode.
select co.Name, sum(c.Population) sum_p
from city c
         join country co ON co.Code = c.CountryCode
group by CountryCode
having sum_p > 3000000
order by sum_p DESC;

# 6. Вывести количество городов в каждой стране (CountryCode, amount of cities). Подсказка: запрос по таблице city и группировка по CountryCode.
select CountryCode, count(*) `amount of cities`
from city
group by CountryCode
order by `amount of cities` DESC ;

# 7. Поменять запрос так, чтобы вместо кодов стран, было названия стран.
select co.Name, count(*) `amount of cities`
from city c
         join country co ON co.Code = c.CountryCode
group by c.CountryCode
order by `amount of cities` DESC;

# 8. Поменять запрос так, чтобы выводилось среднее количество городов в стране.
with amount_c as (select co.Name, count(*) `amount of cities`
from city c
         join country co ON co.Code = c.CountryCode
group by c.CountryCode
order by `amount of cities` DESC)
select avg(amount_c.`amount of cities`) `average of cities` from amount_c;
