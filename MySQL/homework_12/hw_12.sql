# 1. Вывести количество городов для каждой страны.
# Результат должен содержать CountryCode, CityCount (количество городов в стране).
# Поменяйте запрос с использованием джойнов так, чтобы выводилось название страны вместо CountryCode.
select c.CountryCode, co.Name, count(*) c_cnt
from city c
         left join country co ON co.Code = c.CountryCode
group by c.CountryCode;

# 2. Используя оконные функции, вывести список стран с продолжительностью жизнью и средней продолжительностью жизни.
select Name,
       LifeExpectancy,
       ROUND(avg(LifeExpectancy) over (), 2)                        avg_le,
       ROUND(LifeExpectancy / avg(LifeExpectancy) over () * 100, 2) r_avg_le
from country;

# 3. Используя ранжирующие функции, вывести страны по убыванию продолжительности жизни.
select Name,
       LifeExpectancy,
       RANK() over (ORDER BY LifeExpectancy DESC) as `Rank`
from country;

# 4. Используя ранжирующие функции, вывести третью страну с самой высокой продолжительностью жизни.
with derived_table as (select Name, RANK() over (ORDER BY LifeExpectancy DESC) rank_le from country)
select *
from derived_table
where rank_le = 3;