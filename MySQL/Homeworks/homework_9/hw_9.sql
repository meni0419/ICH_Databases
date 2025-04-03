-- 1. Вывести текущую дату и время.
SELECT NOW();

-- 2. Вывести текущий год и месяц
SELECT DATE_FORMAT(CURRENT_DATE, '%Y %M') 'год и месяц';

-- 3. Вывести текущее время
SELECT CURRENT_TIME;

-- 4. Вывести название текущего дня недели
SELECT
    CASE DATE_FORMAT(CURRENT_DATE, '%W')
        WHEN 'Monday' THEN 'Понедельник'
        WHEN 'Tuesday' THEN 'Вторник'
        WHEN 'Wednesday' THEN 'Среда'
        WHEN 'Thursday' THEN 'Четверг'
        WHEN 'Friday' THEN 'Пятница'
        WHEN 'Saturday' THEN 'Суббота'
        WHEN 'Sunday' THEN 'Воскресенье'
    END as 'День недели';

-- 5. Вывести номер текущего месяца
SELECT EXTRACT(MONTH FROM CURRENT_DATE) 'номер текущего месяца';

-- 6. Вывести номер дня в дате “2020-03-18”
SELECT EXTRACT(DAY FROM '2020-03-18') `номер дня`;

-- 7. Подключиться к базе данных shop (которая находится на удаленном сервере).
-- 8. Определить какие из покупок были совершены апреле (4-й месяц)
SELECT *
FROM ORDERS
WHERE EXTRACT(MONTH FROM ODATE) = 4;

-- 9. Определить количество покупок в 2022-м году
SELECT COUNT(*) order_count
FROM ORDERS
WHERE EXTRACT(YEAR FROM ODATE) = 2022;

-- 10. Определить, сколько покупок было совершено в каждый день. 
-- Отсортировать строки в порядке возрастания количества покупок. 
-- Вывести два поля - дату и количество покупок
SELECT ODATE, COUNT(*) order_count
FROM ORDERS
GROUP BY ODATE
ORDER BY order_count ASC;

-- 11. Определить среднюю стоимость покупок в апреле
SELECT 'April' month, AVG(AMT) average_april_cost
FROM ORDERS
WHERE EXTRACT(MONTH FROM ODATE) = 4;