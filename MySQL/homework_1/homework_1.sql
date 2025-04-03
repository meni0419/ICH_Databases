-- 1) Написать запрос, возвращающий всех сотрудников, c job_id = IT_PROG. (Не подглядывая в классный конспект с решением, но подглядывая в схему базы данных https://github.com/it-career-hub/MySQL_databases/blob/main/hr_data.sql)
SELECT e.first_name, e.last_name, e.job_id  
FROM `employees` e 
WHERE e.job_id = 'IT_PROG';

-- 2) Изменить запрос так, чтобы вывести всех сотрудников с job_id равной AD_VP?
SELECT e.first_name, e.last_name, e.job_id  
FROM `employees` e 
WHERE e.job_id = 'AD_VP';

-- 3) Выполнить эти два запроса: SELECT * from HR.EMPLOYEES where job_id = 'IT_PROG' и SELECT * from HR.EMPLOYEES where job_id = 'AD_VP'
SELECT e.first_name, e.last_name, e.job_id 
FROM `employees` e 
WHERE e.job_id = 'IT_PROG'
OR e.job_id = 'AD_VP';

-- 4. Воспроизвести самостоятельно следующие запросы:
-- 4.1.Найдите сотрудников, с зп от 10 000 до 20 000 (включая концы)
SELECT e.first_name, e.last_name, e.salary 
FROM `employees` e 
WHERE e.salary BETWEEN '10000' AND '20000';
-- 4.2. Найдите сотрудников не из 60, 30 и 100 департамента
SELECT e.first_name, e.last_name, e.department_id 
FROM `employees` e 
WHERE e.department_id NOT IN (60,30,100);
-- 4.3. Найдите сотрудников у которых есть две буквы ll подряд в середине имени
SELECT e.first_name, e.last_name
FROM `employees` e 
WHERE e.first_name LIKE '%ll%';
-- 4.4. Найдите сотрудников, у которых фамилия кончается на a
SELECT e.first_name, e.last_name
FROM `employees` e 
WHERE e.last_name LIKE '%a';


-- 5) Найти всех сотрудников с зарплатой выше 10000
SELECT e.first_name, e.last_name, e.salary 
FROM `employees` e 
WHERE e.salary > '10000';

-- 6) Найти всех сотрудников, с зарплатой выше 10000 и чья фамилия начинается на букву L
SELECT e.first_name, e.last_name, e.salary 
FROM `employees` e 
WHERE e.salary > '10000'
AND e.last_name LIKE 'L%';

/*
 * 7. Предсказать результат запроса:

SELECT * FROM employees WHERE salary > 10000 OR salary <= 10000;

**Результат**: Этот запрос вернет все строки из таблицы `employees`, так как любое значение зарплаты будет либо больше 10000, либо меньше или равно 10000.


8. Различие в 1 предложении:

SELECT * FROM employees WHERE salary > 10000 OR salary < 10000;

**Различие**: Этот запрос также вернет все строки, так как любая зарплата будет либо больше, либо меньше 10000, но не включает зарплаты, равные 10000, что в конечном итоге тоже охватывает все возможные значения зарплаты.


9. Предсказать результат запроса:

SELECT * FROM employees WHERE salary > 10000 AND salary < 5000;

**Результат**: Этот запрос не вернет ни одной строки, так как невозможно, чтобы значение зарплаты одновременно было больше 10000 и меньше 5000.


 */