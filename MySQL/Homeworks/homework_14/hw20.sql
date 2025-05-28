# Работаем с базой данных sakila.
# 1. Вывести названия фильмов с расшифровкой рейтинга для каждого. Рейтинги описаны здесь https://en.wikipedia.org/wiki/Motion_Picture_Association_film_rating_system. В таблице film хранятся годы рейтингов. Нужно воспользоваться оператором case, чтобы определить для каждого кода условие, по которому будет выводиться его развернутое описание (1 предложение).
SELECT title,
       rating,
       case
           when rating = 'PG' then 'Parental Guidance Suggested'
           when rating = 'G' then 'General Audiences'
           when rating = 'NC-17' then 'Adults Only'
           when rating = 'PG-13' then 'Parents Strongly Cautioned'
           when rating = 'R' then 'Restricted'
           end
from film;

# 2. Выведите количество фильмов в каждой категории рейтинга. Используем group by.
select c.name, count(*) cnt_f
from film
         join sakila.film_category fc on film.film_id = fc.film_id
         join sakila.category c on c.category_id = fc.category_id
group by c.category_id
order by cnt_f desc;

# 3. Используя оконные функции и partition by, выведите список названий фильмов, рейтинг и количество фильмов в каждом рейтинге. Объясните, чем отличаются результаты предыдущего запроса и запроса в этой задаче.
select title, rating, count(*) over (partition by rating)
from film;
# Отличие в том, что мы не используем группировку, а прибавляем агрегированное значение по группе к каждой строке, поэтому можно вывести все названия фильмов. Группировка выводит только одну строку по каждой группе

# 4. Изучите таблицы payment и customer. Выведите список всех платежей с указанием имени и фамилии каждого заказчика, датой платежа и суммой.
select c.first_name, c.last_name, p.amount, p.payment_date
from payment p
         left join sakila.customer c on c.customer_id = p.customer_id;

# 5. Поменяйте предыдущий запрос так, чтобы дата выводилась в формате “число, название месяца, год” (без времени).
select c.first_name, c.last_name, p.amount, DATE_FORMAT(p.payment_date, '%d, %M, %Y')
from payment p
         left join sakila.customer c on c.customer_id = p.customer_id;
