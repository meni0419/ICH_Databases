create table if not exists world.citizen as (select *
                                             from world_boro_5.citizen);

select *
from employees
where department_id = 90;

select sum(employees.salary)
from employees
where salary > 10000;

select *
from employees
where salary > 5000
order by salary;
