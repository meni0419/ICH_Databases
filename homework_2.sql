# 1. вывести список всех сотрудников
SELECT e.first_name, e.last_name FROM employees e;

/* 2. Найти поле с зарплатой сотрудника:
 * employees.salary
 */

/* 3. Используя операторы case/when/end, изменить запрос так, 
 * чтобы результатом был только один столбец, назовите его SALARY_GROUP 
 * и оно будет принимать значение 1 если зп сотрудника больше 10000 и значение 0, если меньше
 */
SELECT
	CASE
		WHEN e.salary > 10000
			THEN 1
		ELSE 0
	END SALARY_GROUP
FROM employees e;

/* 4. Ответить одним предложением: почему выводится только один столбец?
 * Потому что после SELECT у нас перечислен только 1 столбец SALARY_GROUP
 */

# 5. Изменить запрос, так, чтобы вывелось два столбца: имя сотрудника и новое поле SALARY_GROUP.
SELECT
	e.first_name as 'Имя сотрудника',
	CASE
		WHEN e.salary > 10000 
			THEN 1 
		ELSE 0
	END SALARY_GROUP
FROM employees e;

# 6. Вывести среднюю зарплату для департаментов с номерами 60, 90 и 100 используя составное условие.
SELECT
	AVG(
		CASE
			WHEN e.department_id = 60
				THEN e.salary
		END) as 'avg_department_id = 60',
	AVG(
		CASE
			WHEN e.department_id = 90
				THEN e.salary
		END) as 'avg_department_id = 90',
	AVG(
		CASE
			WHEN e.department_id = 100
				THEN e.salary
		END) as 'avg_department_id = 100'
FROM employees e;

SELECT 
	avg(
		CASE
			WHEN department_id = 60 or department_id = 90 or department_id = 100
				THEN salary 
			ELSE null
		END) as avg_dp60_90_100
FROM employees;

# 7. Разделить уровни (level) сотрудников на junior < 10000,10000<mid<15000, senior>15000 в зависимости от их зарплаты. Вывести список сотрудников (first_name, last_name, level).
SELECT 
	e.first_name, e.last_name,
	CASE 
		when e.salary < 10000
			then 'junior'
		when e.salary between 10000 and 15000
			then 'mid'
		when e.salary > 15000
			then 'senior'
	END as 'level',
	e.salary
FROM employees e;

# 8. Посмотреть содержимое таблицы jobs. Написать запрос c использованием оператора case/when/end, который возвращает 2 столбца: job_id, payer_rank, где столбец payer_rank формируется по правилу: если максимальная зарплата больше 10000, то “high_payer”, если меньше, то “low payer”. 
SELECT 
	j.job_id,
	CASE 
		when j.max_salary > 10000
			then 'high payer'
		else 'low payer'
	END as payer_rank
FROM jobs j; 

# 9. Переписать этот запрос с использованием оператора IF.
SELECT 
	j.job_id,
	IF (j.max_salary > 10000, 'high payer', 'low payer') as payer_rank 
FROM jobs j; 

# 10. Поменять предыдущий запрос так, чтобы выводилось 3 столбца, к двум существующим добавьте max_salary и отсортировать результат по убыванию
SELECT 
	j.job_id,
	IF (j.max_salary > 10000, 'high payer', 'low payer') as payer_rank,
	j.max_salary 
FROM jobs j 
ORDER BY j.max_salary DESC;