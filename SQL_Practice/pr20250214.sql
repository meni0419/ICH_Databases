select count(*) from country c
where c.GovernmentForm = 'Republic';

# вывести все формы правления с количеством стран в которых она присутствует
select GovernmentForm
from (select GovernmentForm, count(`Name`) c_name from country
group by GovernmentForm) c_gf
where c_gf.c_name = (select MAX(t1.c_name) from (select GovernmentForm, count(`Name`) c_name from country
group by GovernmentForm) t1);

#вывести города где население больше чем среднее население по всем городам
select c.Name, c.Population from city c
where c.Population > (select AVG(c2.Population) from city c2)
order by c.Population;

-- Выведите одним запросом общее количество департаментов (отделов) в базе, кол департаментов где есть сотрудники
# и кол департаментов где нет сотрудников (на выходе три столбца и одна строчка)

select count(DISTINCT d.department_id) 'all_dep',
       count(DISTINCT if (e.department_id is not null, d.department_id, null)) 'have',
       count(if (e.department_id is null, d.department_id, null)) 'not_have' from departments d
left join employees e ON e.department_id = d.department_id;