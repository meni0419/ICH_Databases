-- Вычислить процентное соотношение числа заказов для каждого покупателя к общему числу заказов в его городе
select c.CNAME,
       count(o.AMT) over (PARTITION BY o.CUST_ID) cnt_cust,
       COUNT(o.AMT) over (partition by c.CITY)    cnt,
       ROUND(count(o.AMT) OVER (PARTITION BY o.CUST_ID) / COUNT(o.AMT) over (partition by c.CITY) * 100,
             2) AS                                REL_cnt_city,
       c.CITY
from ORDERS o
         left join CUSTOMERS c ON c.CUST_ID = o.CUST_ID;

-- Определить топ-3 самых активных покупателей в каждом городе на основе суммы их заказов
WITH sum_cust AS (SELECT c.CNAME,
                         c.CITY,
                         SUM(o.AMT)                                                 AS total_amount,
                         RANK() OVER (PARTITION BY c.CITY ORDER BY SUM(o.AMT) DESC) AS r_cust
                  FROM ORDERS o
                           JOIN CUSTOMERS c ON c.CUST_ID = o.CUST_ID
                  GROUP BY c.CUST_ID, c.CNAME, c.CITY)
SELECT CNAME,
       CITY,
       total_amount,
       r_cust
FROM sum_cust
WHERE r_cust = 1;


-- Ранжировать продавцов по количеству сделок в каждом городе
select s.SNAME,
       count(*),
       s.CITY,
       RANK() over (partition by s.CITY ORDER BY count(o.ORDER_ID) DESC) r_c
from SELLERS s
         left join ORDERS o on s.SELL_ID = o.SELL_ID
group by s.SELL_ID;

-- Найдите 10 самых высокооплачиваемых сотрудников и ранжируйте их с помощью RANK(). Если у нескольких сотрудников одинаковая зарплата, они должны получить одинаковый ранг.
WITH ranked_employees AS (SELECT first_name,
                                 last_name,
                                 salary,
                                 RANK() OVER (ORDER BY salary DESC) AS salary_rank
                          FROM employees)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 10;


-- Для каждого отдела ранжируйте сотрудников по зарплате в порядке убывания.
select e.first_name                                                  name,
       e.last_name                                                   last,
       e.salary,
       e.department_id                                               d_id,
       rank() over (partition by department_id order by salary DESC) r_e
from employees e
order by department_id, r_e;

-- Для каждого отдела рассчитайте промежуточную сумму зарплат сотрудников в порядке даты найма.
select e.first_name                                                          name,
       e.last_name                                                           last,
       e.salary,
       e.department_id                                                       d_id,
       e.hire_date,
       sum(salary) over (partition by department_id order by hire_date DESC) s_s
from employees e
order by department_id, s_s;

-- Для каждого сотрудника рассчитайте процентный вклад его зарплаты в общую зарплату его отдела.
select e.first_name name,
       e.last_name  last,
       e.salary,
       e.department_id,
       ROUND(salary / sum(salary) over (partition by department_id) * 100, 2) s_d
from employees e
order by department_id, s_d;


-- Рассчитайте разницу между зарплатой сотрудника и самой высокой зарплатой в его отделе.
