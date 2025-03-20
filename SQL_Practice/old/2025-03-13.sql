# Вывести список сервисных классов со средней стоимостью билета в каждом классе.
select DISTINCT service_class, AVG(price) OVER (partition by service_class) avg_class
from tickets;

# Вывести список сервисных классов со средней ценой в каждой классе и ранком каждого класса в зависимости от
# средней цены в сервисном классе.
select service_class, AVG(price) OVER (partition by service_class) avg_class, RANK() over (ORDER BY AVG(price))
from tickets
group by service_class;

# Вывести количество билетов для каждой поездки.
SELECT t.service_class,
       AVG(t.price)                             avg_classprice,
       RANK() OVER (ORDER BY AVG(t.price) DESC) class_rank
FROM tickets t
GROUP BY t.service_class;

# Вывести топ 2 поездок (trips) по их средней стоимости. Поездка может состоять из нескольких перелетов
# (поэтому на каждую поездку может приходиться больше одного билета)
WITH avg_prices AS (SELECT trip_id,
                           AVG(price) OVER (PARTITION BY trip_id) AS avg_pr
                    FROM tickets),
     ranked_tickets AS (SELECT trip_id,
                               avg_pr,
                               RANK() OVER (ORDER BY avg_pr DESC) AS rank_t
                        FROM avg_prices)
SELECT trip_id, avg_pr, rank_t
FROM ranked_tickets
WHERE rank_t <= 2;

select *
from (select trip_id,
             count(id)                                    count_id,
             AVG(price)                                   AVG_price,
             dense_RANK() OVER (ORDER BY AVG(price) DESC) class_rank
      from tickets
      group by trip_id) as sel
where class_rank < 3;

-- Рассчитать среднее количество заказов на одного покупателя в каждом городе
with c_cnt_order as (select CUST_ID, count(*) cnt from ORDERS group by CUST_ID)
SELECT DISTINCT AVG(c_cnt_order.cnt) over (partition by c.CITY) cnt_o, c.CITY
FROM CUSTOMERS c
         join c_cnt_order ON c_cnt_order.CUST_ID = c.CUST_ID;

