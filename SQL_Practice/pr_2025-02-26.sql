# SELECT e.hire_date
#      , LAST_DAY(e.hire_date) + INTERVAL 1 DAY + INTERVAL 3 MONTH as 'newdate'
# from employees e
# where DATE_FORMAT(LAST_DAY(e.hire_date) + INTERVAL 1 DAY + INTERVAL 3 MONTH, '%d') = '01' WITH MaxHireDate AS (
#     SELECT MAX(hire_date) AS max_hire_date
#     FROM employees
# )


with info as (select DATE_FORMAT(employees.hire_date, '%M') as month, count(employee_id) as num_emp
              from employees
              group by month
              order by num_emp desc)
select month
from info
where num_emp = (select max(num_emp) from info);

-- Количество заказов по месяцам номер месяца + колво заказов

SELECT EXTRACT(MONTH FROM ODATE) `Month`,
COUNT(ORDER_ID) order_cnt
FROM ORDERS o
GROUP BY `Month`;

SELECT *
FROM ORDERS o
where EXTRACT(MONTH FROM ODATE) = 3;

SELECT EXTRACT(YEAR FROM ODATE) `YEAR`,
COUNT(ORDER_ID) order_cnt
FROM ORDERS o
GROUP BY `YEAR`;
