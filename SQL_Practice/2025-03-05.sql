-- Измените запрос так, чтобы вместо айди клиентов выводились их имена (join с таблицей clients).
SELECT c.name,
COUNT(t.id)
FROM tickets t
JOIN clients c
ON t.client_id = c.id
GROUP BY c.name
HAVING COUNT(t.id) > 2;

# 1. Выведите среднюю стоимость билетов в каждом сервисном классе.
select ROUND(avg(price), 2), service_class from tickets
group by service_class;

# 2. Выведите список самых популярных аэропортов отправления (trips departures).

SELECT departure
FROM trips
GROUP BY departure
HAVING COUNT(*) = (select MAX(c.c_trip) from (select departure, COUNT(*) as c_trip from trips
group by departure) c);

# 3. Выведите самого молодого клиента.
SELECT * FROM clients
WHERE age = (SELECT MIN(age) AS youngest
FROM clients);

# 4. Выведите имена клиентов, код аэропорта отправления и прибытия (выборка из tickets и join с clients и с trips).


# 5. Выведите имена клиентов, чьи поездки (trips) были отменены.
select c.name, t.id, tt.trip_code
from tickets t
right join clients c on t.client_id = c.id
right join trips tt on t.travel_id = tt.id
where tt.status = 'Cancelled';

-- Сколько сотрудников имена которых начинается с одной и той же буквы? Сортировать по количеству.
-- Показывать только те где количество больше 1
select SUBSTRING(first_name, 1, 1) f_initials
, count(*) c_f_initials from employees
group by f_initials
having c_f_initials > 1
order by c_f_initials DESC;



-- Получить репорт сколько сотрудников приняли на работу в каждый день недели. Сортировать по количеству
-- Получить репорт сколько сотрудников приняли на работу по годам. Сортировать по количеству
select YEAR(e.hire_date) `year`, count(employee_id) from employees e
group by `year`;
