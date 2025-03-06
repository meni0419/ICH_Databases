# Напишите SQL-запрос для анализа средней стоимости покупок, совершенных в марте, и определите,
# какие продавцы имеют самую высокую и самую низкую среднюю стоимость покупок в этом месяце.
# Обязательно выведите имя продавца.

WITH seller_avg_sales AS (SELECT s.SELL_ID,
                                 se.SNAME,
                                 AVG(s.AMT)                             AS avg_sale_amount,
                                 RANK() OVER (ORDER BY AVG(s.AMT) DESC) AS high_rank,
                                 RANK() OVER (ORDER BY AVG(s.AMT) ASC)  AS low_rank
                          FROM ORDERS s
                                   JOIN
                               SELLERS se ON s.SELL_ID = se.SELL_ID
                          WHERE MONTH(s.ODATE) = 3
                          GROUP BY s.SELL_ID, se.SNAME)

SELECT SNAME,
       avg_sale_amount,
       CASE
           WHEN high_rank = 1 THEN 'Самая высокая средняя стоимость'
           WHEN low_rank = 1 THEN 'Самая низкая средняя стоимость'
           END AS rank_description
FROM seller_avg_sales
WHERE high_rank = 1
   OR low_rank = 1
ORDER BY avg_sale_amount DESC;

# Напишите SQL-запрос для анализа покупок, совершенных во вторник, и предоставьте информацию о каждом заказе,
# включая сумму, дату, имя покупателя и имя продавца.

select c.CNAME, se.SNAME, o.AMT, o.ODATE, DATE_FORMAT(o.ODATE, '%W')
from ORDERS o
         join SELLERS se ON se.SELL_ID = o.SELL_ID
         join CUSTOMERS c ON c.CUST_ID = o.CUST_ID
where WEEKDAY(o.ODATE) = 1;

# Определить, сколько покупок было совершено в каждый месяц. Отсортировать строки в порядке возрастания количества покупок.
# Вывести два поля - номер месяца и количество покупок

SELECT DATE_FORMAT(ODATE, '%M') `month`, COUNT(*) order_count
FROM ORDERS
GROUP BY `month`
ORDER BY order_count;

# Вывести количество заказов по дням недели.

SELECT DATE_FORMAT(ODATE, '%W') `month`, COUNT(*) order_count
FROM ORDERS
GROUP BY `month`
ORDER BY order_count DESC;

# Необходимо определить, в какой месяц было совершено больше всего покупок.
# Вывести два поля - номер месяца и количество покупок.

SELECT MONTH(ODATE) AS month_number,
       COUNT(*)     AS purchase_count
FROM ORDERS
GROUP BY MONTH(ODATE)
ORDER BY purchase_count DESC
LIMIT 1;

WITH MA AS (SELECT EXTRACT(MONTH FROM O.ODATE) AS `MONTH`,
                   COUNT(O.ORDER_ID)           AS ORDERS_AMOUNT
            FROM ORDERS O
            GROUP BY `MONTH`)
SELECT MA.`MONTH`, MA.ORDERS_AMOUNT
FROM MA
WHERE MA.ORDERS_AMOUNT = (SELECT MAX(MA.ORDERS_AMOUNT) FROM MA);

SELECT
    MONTH(ODATE) AS month_number,
    COUNT(*) AS purchase_count
FROM
    ORDERS
GROUP BY
    MONTH(ODATE)
HAVING
    COUNT(*) = (
        SELECT COUNT(*)
        FROM ORDERS
        GROUP BY MONTH(ODATE)
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
ORDER BY
    month_number;

# 1. Вывести сегодняшнюю дату в формате: день недели, число, месяц, год.
select DATE_FORMAT(NOW(), '%W, %d %M %Y') as `date`

# Вывести на какой день недели приходится 1 января 2024 года.
select DATE_FORMAT('2024-01-01', '%W, %d %M %Y') as `date`;
select DAYNAME('2024-01-01') as day_name;
SELECT CASE WEEKDAY('2024-01-01')
           WHEN 0 THEN 'Понедельник'
           WHEN 1 THEN 'Вторник'
           WHEN 2 THEN 'Среда'
           WHEN 3 THEN 'Четверг'
           WHEN 4 THEN 'Пятница'
           WHEN 5 THEN 'Суббота'
           WHEN 6 THEN 'Воскресенье'
           END AS day_name;

# 2. Вывести, на какой день недели приходится число, через 10 дней после.
SELECT DATE_FORMAT(NOW() + INTERVAL 10 DAY, '%W');

# 3. Вывести дату, которая будет через 10 дней после последнего дня текущего месяца.
SELECT DATE_FORMAT(LAST_DAY(NOW()) + INTERVAL 10 DAY, '%W, %d %M %Y');

# Вывести день недели даты из предыдущей задачи.
SELECT DATE_FORMAT(LAST_DAY(NOW()) + INTERVAL 10 DAY, '%W, %d %M %Y');

# Вывести название месяца, который будет через 5 месяцев после текущего.
SELECT DATE_FORMAT(NOW() + INTERVAL 5 MONTH, '%W, %d %M %Y');
