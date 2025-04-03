# Найти имена и фамилии сотрудников с максимальной зарплатой в каждом департаменте HR.EMPLOYEES

select emp.first_name, emp.last_name, emp.salary, emp.department_id
from employees emp
         join hr.departments d on emp.department_id = d.department_id
where emp.salary in (select max(inner_emp.salary)
                     from hr.employees inner_emp
                     where inner_emp.department_id = emp.department_id)
order by department_id;

select emp.job_id, count(emp.employee_id)
from employees emp
group by emp.job_id;

select emp.job_id, j.job_title, count(emp.employee_id)
from employees emp
         left join hr.jobs j on emp.job_id = j.job_id
group by emp.job_id;

select e.last_name, e.first_name, count(e.employee_id) as `count`
from employees e
         left join employees e2 ON e2.manager_id = e.employee_id
group by e.first_name, e.last_name;

select e.first_name, e.last_name, e.salary
from employees e
         join (select e2.department_id, avg(e2.salary) as avg_s
                    from employees e2
                    group by e2.department_id) as j_avg_s
                   ON e.department_id = j_avg_s.department_id
where e.salary < j_avg_s.avg_s;