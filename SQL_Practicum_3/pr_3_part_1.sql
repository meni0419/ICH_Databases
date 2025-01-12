# 1. Добавьте в таблицу goods 4 товара
INSERT INTO goods (title, quantity)
VALUES ('Mountain Bicycle', 10),
       ('Road Bicycle', 15),
       ('Hybrid Bicycle', 8),
       ('BMX Bicycle', 20);

# 2. Увеличьте цену велосипеда на 10000
update goods
set price = price + 10000
where title = 'Electric Bicycle';

# 3. Создать представление для вывода товаров, которые стоят меньше 10000
create view v_goods_price_less_10k as
select *
from goods
where price < 10000;

# 4. Создайте таблицу goods (id, title, quantity)
CREATE TABLE IF NOT EXISTS goods
(
    id       INT NOT NULL AUTO_INCREMENT,
    title    VARCHAR(50),
    quantity INT,
    PRIMARY KEY (id)
);


# 5. Добавьте несколько строк
insert into goods (title, quantity)
values ('Electric Bicycle', 5),
       ('Touring Bicycle', 12),
       ('Folding Bicycle', 7);

# 6. Добавьте поле price (integer) со значением по умолчанию 0
alter table goods
    add column price int default 0;

# 7. Проверьте содержимое таблицы
select *
from goods;

# 8. Измените тип на numeric(8, 2) -- перед изменением типа необходимо очистить поле
update goods set price = NULL;
alter table goods modify price numeric(8,2);

# 9. Измените тип обратно на integer
update goods set price = NULL;
alter table goods modify price int;

# 10. Переименуйте поле на item_price
ALTER TABLE goods RENAME COLUMN price TO item_price;
ALTER TABLE goods CHANGE item_price price numeric(8,2);

# 11. Удалите это поле
alter table goods drop column item_price;