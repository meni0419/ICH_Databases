# Выведите названия фильмов с названием категории
select title, length
from film
order by length DESC
limit 10;

# Выведите количество фильмов по категориям
select c.name, count(*) as cnt_film
from film_category fc
         join sakila.category c on fc.category_id = c.category_id
group by c.name;

# Выведите категории, в которых больше 20 фильмов
select c.name, count(*) as cnt_film
from film_category fc
         join sakila.category c on fc.category_id = c.category_id
group by c.name
having cnt_film > 65;

# Выведите названия фильмов, названия категорий и среднюю продолжительность фильма в каждой категории. Использовать оконные функции
select f.title, c.name, AVG(f.length) OVER (PARTITION BY c.name) avg_len
from film f
         join sakila.film_category fc on f.film_id = fc.film_id
         join sakila.category c on c.category_id = fc.category_id;

# Измените предыдущий запрос так, чтобы помимо названия фильма и категории, выводился также ранг по длине фильма.
select f.title,
       c.name,
       AVG(f.length) OVER (PARTITION BY c.name)                  avg_len,
       dense_rank() over (PARTITION BY c.name order by f.length) len_rank
from film f
         join sakila.film_category fc on f.film_id = fc.film_id
         join sakila.category c on c.category_id = fc.category_id;

# найти 3 клиента в каждом городе с наибольшим количеством аренд
WITH RankedRentals AS (SELECT c.customer_id,
                              c.first_name,
                              c.last_name,
                              ci.city,
                              COUNT(r.rental_id)                                                  AS rent_count,
                              RANK() OVER (PARTITION BY ci.city ORDER BY COUNT(r.rental_id) DESC) AS rent_rank
                       FROM sakila.customer c
                                JOIN sakila.address a ON c.address_id = a.address_id
                                JOIN sakila.city ci ON a.city_id = ci.city_id
                                JOIN sakila.rental r ON c.customer_id = r.customer_id
                       GROUP BY c.customer_id, c.first_name, c.last_name, ci.city),
     CitiesWithThreeCustomers AS (SELECT city
                                  FROM RankedRentals
                                  WHERE rent_rank <= 3
                                  GROUP BY city
                                  HAVING COUNT(*) = 2)
SELECT rr.first_name, rr.last_name, rr.city, rr.rent_count
FROM RankedRentals rr
         JOIN CitiesWithThreeCustomers ctc ON rr.city = ctc.city
WHERE rr.rent_rank <= 3
ORDER BY rr.city, rr.rent_rank;

# Для каждого города рассчитайте ежемесячную выручку и процентный рост по сравнению с предыдущим месяцем
select c.city,
       DATE_FORMAT(p.payment_date, '%Y-%m-%d')                                                                     as date_f,
       SUM(p.amount)                                                                                               as sum_p,
       ROUND((SUM(p.amount) -
              LAG(SUM(p.amount)) OVER (PARTITION BY c.city ORDER BY DATE_FORMAT(p.payment_date, '%Y-%m'))) /
             LAG(SUM(p.amount)) OVER (PARTITION BY c.city ORDER BY DATE_FORMAT(p.payment_date, '%Y-%m')) * 100,
             2)                                                                                                    as lag_sum_p
from city c
         join sakila.address a on c.city_id = a.city_id
         join sakila.customer c2 on a.address_id = c2.address_id
         join sakila.payment p on c2.customer_id = p.customer_id
group by c.city, date_f;

-- Работаем с базой данных sakila (fiction movies database).

-- 1. Выведите количество фильмов в таблице film.
select count(*)
from film;

-- 2. Выведите список категорий фильмов.
select name
from category;

-- 3. Выведите все фильмы в категории на ваше усмотрение, например, все комедии (Comedy).
SELECT f.title, c.name
FROM film f
         JOIN film_category fc ON f.film_id = fc.film_id
         JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy';

-- 4. Выведите список всех актёров с количеством фильмов в которых снимался каждый.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as films_count
FROM actor a
         LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY films_count DESC;

-- 5. Выведите список языков и количество фильмов на каждом языке.
SELECT l.name, COUNT(f.film_id) as films_count
FROM language l
         LEFT JOIN film f ON l.language_id = f.language_id
GROUP BY l.name;

-- 6. Выведите имя актёра, который снялся в самом большом количестве фильмов.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as films_count
FROM actor a
         JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY films_count DESC
LIMIT 1;

-- 7. Выведите актёров, которые снялись более, чем в 5 фильмах.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as films_count
FROM actor a
         JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING films_count > 5
ORDER BY films_count DESC;

-- 8. Выведите список актёров по их рангу в зависимости от количества фильмов
SELECT a.first_name,
       a.last_name,
       COUNT(fa.film_id)                                   as films_count,
       DENSE_RANK() OVER (ORDER BY COUNT(fa.film_id) DESC) as actor_rank
FROM actor a
         JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;