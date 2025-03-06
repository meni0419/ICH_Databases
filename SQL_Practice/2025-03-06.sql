# Показать все департаменты в которых работают больше 30ти сотрудников
select d.department_name, count(e.employee_id) cnt
from employees e
         left join departments d on d.department_id = e.department_id
group by e.department_id
having cnt > 30;


-- Получить список department_id в котором работают работники нескольких (>1) job_id
select d.department_name, count(DISTINCT e.job_id) cnt
from employees e
         left join departments d on d.department_id = e.department_id
group by e.department_id
having cnt > 1;

-- Получить список manager_id у которых количество подчиненных больше 5 и сумма всех зарплат его подчиненных больше 50000
select e.manager_id, count(e.employee_id) cnt, sum(salary) sm
from employees e
group by e.manager_id
having cnt > 5
   and sm > 50000;


-- Получить список manager_id у которых средняя зарплата всех его подчиненных находится в промежутке от 6000 до 9000
-- и которые не получают бонусы (commission_pct пустой)
select e.manager_id, AVG(salary) sm
from employees e
where e.commission_pct is NULL
   OR e.commission_pct = 0
group by e.manager_id
having sm BETWEEN 6000 AND 9000;

-- Получить список регионов и количество сотрудников в каждом регионе
select r.region_name, count(e.employee_id) as count_emp
from regions r
         left join countries c on r.region_id = c.region_id
         left join locations l on c.country_id = l.country_id
         left join departments d on l.location_id = d.location_id
         left join employees e on d.department_id = e.department_id
group by r.region_name;

-- Показать всех менеджеров которые имеют в подчинении больше 6ти сотрудников
select e.manager_id, em.first_name, em.last_name, count(e.employee_id) cnt
from employees e
         left join employees em ON e.manager_id = em.employee_id
group by e.manager_id
having cnt > 6;

# Найдите отделы со средней зарплатой выше 75% от самой высокой средней зарплаты в отделе.
# max= 19333.3333
with t2 as (select avg(salary) av
            from employees
            group by department_id)

select department_id, avg(salary) avg_s
from employees
group by department_id
having avg_s > (select MAX(av)
                from t2) * 0.75;

# больше чем средняя зп в их отделе

with t2 as (
  select department_id, ROUND(avg(salary), 2) as avg_s_d
  from employees
  group by department_id
)
select e.employee_id emp, e.salary s, '>', t2.avg_s_d avg
from employees e
join t2 on e.department_id = t2.department_id
where e.salary > t2.avg_s_d
group by e.department_id, e.salary;
