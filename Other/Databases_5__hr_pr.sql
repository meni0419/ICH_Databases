/* Вывести сотрудников, чьи имена начинаются на букву D и отсортировать их в алфавитном порядке по фамилии
Посмотрите на таблицу jobs. Напишите запрос, который возвращает job_id и max_salary. 
Отсортируйте выборку по убыванию - максимальные зарплаты выводятся первыми. 
Добавьте в выборке дополнительный столбец rank, который имеет два значения: 
high и low и вычисляется по правилам high>10000, low <=10000. 
Отсортируйте выборку по возрастанию этого нового поля rank. 
Напишите этот запрос с использованием условного оператора case/when/end и IF.*/

SELECT
	COUNT(DISTINCT department_id),
	CASE 
		WHEN salary > 10000 THEN 1
		ELSE 0
	END AS dep_more_10k
FROM
	employees
WHERE
	salary > 10000
	;

SELECT
	DISTINCT d.department_name
FROM
	employees e,
	departments d
WHERE
	e.department_id = d.department_id
	AND e.first_name > 10000
	;

# sum with case
SELECT
	avg(CASE 
			when salary < 10000 then salary
			else NULL
	END) as sum_zp_10k
FROM
	employees;


# avg with if
SELECT
	avg(
		if (salary < 10000, salary, NULL)
		) as sum_zp_10k
FROM
	employees;

# avg with where
SELECT
	avg(salary) as sum_zp_10k
FROM
	employees
WHERE
	employees.salary < 10000;

# sum with where
SELECT
	sum(salary) as sum_zp_10k
FROM
	employees
WHERE
	employees.salary >10000;

# sum with if
SELECT
	sum(
		if (salary > 10000, salary, 0)
		) as sum_zp_10k
FROM
	employees;

# sum with case
SELECT
	sum(CASE 
			when salary > 10000 then salary
			else 0
	END) as sum_zp_10k
FROM
	employees;


# variant if
SELECT
	first_name,
	salary, 
	case 
		when salary > 10000 then 1
		else 0
	end AS SALARY_GROUP
FROM
	employees;

# variant if
SELECT
	first_name,
	salary,
	if (salary > 10000, 1, 0) AS SALARY_GROUP
FROM
	employees;

