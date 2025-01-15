# создать БД
CREATE DATABASE `091224ptm-MaksymM`;

# удалить таблицу
drop table if exists toys1;

# создать таблицу
create table if not exists toys1
(
    toy_id   int          not null auto_increment primary key,
    toy_name varchar(100) null,
    weight   int          null
);

# вывести данные таблицы
select *
from toys1;

# добавить товары
INSERT INTO toys1 (toy_name, weight)
VALUES ('Велосипед', 15),
       ('Самокат', 24),
       ('Конструктор', 2),
       ('Кукла', 1),
       ('Мяч', 3),
       ('Велосипед', 16),
       ('Самокат', 55),
       ('Игровая приставка', 5),
       ('Железная дорога', 12),
       ('Пазлы', 1);

# truncate table
truncate table toys1;

# CREATE TABLE goods
CREATE TABLE IF NOT EXISTS goods
(
    id       INT NOT NULL AUTO_INCREMENT,
    title    VARCHAR(50),
    quantity INT,
    PRIMARY KEY (id)
);

# вывести goods
select *
from goods;

# добавить записи в goods
INSERT INTO goods (title, quantity)
VALUES ('Хлеб', 50),
       ('Молоко', 30),
       ('Яйца', 40),
       ('Апельсины', 25),
       ('Яблоки', 35),
       ('Макароны', 20),
       ('Сахар', 15),
       ('Масло', 10),
       ('Кофе', 5),
       ('Чай', 8);

# добавить поле in_stock
alter table goods
    add column in_stock varchar(1) default 'Y';

# добавить поле price
alter table goods
    add column price int default 0;

# удалить поле из таблицы
ALTER TABLE goods
    DROP COLUMN in_stock;

#update goods
update goods
set in_stock = 'N'
where title = 'Кофе';

UPDATE goods
SET price = 20
WHERE title = 'Хлеб';
UPDATE goods
SET price = 15
WHERE title = 'Молоко';
UPDATE goods
SET price = 10
WHERE title = 'Яйца';
UPDATE goods
SET price = 25
WHERE title = 'Апельсины';
UPDATE goods
SET price = 30
WHERE title = 'Яблоки';
UPDATE goods
SET price = 8
WHERE title = 'Макароны';
UPDATE goods
SET price = 5
WHERE title = 'Сахар';
UPDATE goods
SET price = 12
WHERE title = 'Масло';
UPDATE goods
SET price = 18
WHERE title = 'Кофе';
UPDATE goods
SET price = 7
WHERE title = 'Чай';

# create view
create view v_overprice as
select *
from goods
where price > 20;

select *
from v_overprice;

# modify type column
alter table goods
    modify price numeric(8, 2);

alter table goods
    modify price int;

