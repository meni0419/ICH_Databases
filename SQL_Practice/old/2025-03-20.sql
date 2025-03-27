# Вывести поездку с третьим по количеству билетов
with rank_t as (select trip_id, count(id) cnt_t, DENSE_RANK() over (ORDER BY count(id) DESC) r_cnt
                from tickets
                group by trip_id
                order by cnt_t DESC)
select *
from rank_t
where r_cnt = 3;

# Вывести список билетов с именами пассажиров, а также названием модели авиалайнера.


# Вывести среднее количество билетов у каждого клиента.
WITH TicketsTable AS
         (SELECT t.client_id,
                 Count(t.id) as avg_tick
          FROM tickets t
          GROUP BY t.client_id)
SELECT ROUND(AVG(avg_tick), 2)
FROM TicketsTable;

-- Напишите запрос для расчёта населения на каждом континенте.
with sum_p as (select CountryCode, co.Name, SUM(ci.Population) s_p
               from city ci
                        left join country co ON ci.CountryCode = co.Code
               group by CountryCode)
select *
from sum_p
;
-- Найдите количество стран в каждом регионе.
select Region, count(code) c_c
from country
group by Region;

select DISTINCT Region, count(code) over (partition by Region)
from country

-- Найдите континенты с средним населением более 50 миллионов человек. Отобразите название континента вместе со средним населением.
select continent, avg(population) as avg_population
from country
group by continent
having avg(population) > 50000000;

-- Перечислите континенты со средней продолжительностью жизни больше 70 лет.
select Continent, AVG(LifeExpectancy) avg_le
from country
group by Continent
having avg_le > 70;

-- Перечислите континенты, где процент стран с английским в качестве официального языка превышает 50%. Отобразите название континента вместе с процентом.
WITH eng_l_co AS (SELECT co.Continent, COUNT(DISTINCT co.Code) AS cnt_co
                  FROM country co
                           JOIN countrylanguage cl ON co.Code = cl.CountryCode
                  WHERE cl.Language = 'English'
                    AND cl.IsOfficial = 'T'
                  GROUP BY co.Continent),
     TotalCountries AS (SELECT Continent, COUNT(*) AS TotalCountryCount
                        FROM country
                        GROUP BY Continent)
SELECT esc.Continent,
       (esc.cnt_co * 100.0 / tc.TotalCountryCount) AS PercentEnglishSpeaking
FROM eng_l_co esc
         JOIN TotalCountries tc ON esc.Continent = tc.Continent
WHERE (esc.cnt_co * 100.0 / tc.TotalCountryCount) > 1;

WITH DataTable as (SELECT DISTINCT c.Continent                        as cont
                                 , c.Name
                                 , if(cl.Language = 'English', 1, 0)  as is_eng
                                 , if(cl.Language != 'English', 1, 0) as is_not_eng
                                 , cl.isOfficial
                   FROM country c
                            left join countrylanguage cl
                                      on cl.CountryCode = c.code
                   where cl.isOfficial = 'T')
select cont
     , sum(is_eng) / sum(1) as main
from DataTable
GROUP BY cont
having main > 0.5;



-- Проранжируйте страны по населению в пределах соответствующих им континентов.
select Continent, Name, Population, RANK() over (partition by Continent ORDER BY Population DESC) r_p
from country;
