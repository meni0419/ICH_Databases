# 1. Написать запрос с помощью UNION, который выводит список названий всех городов и стран с их населением.
# Итоговая выборка должна содержать два столбца: Name, Population.

select c.Name, c.Population
from city c
union
select cn.Name, cn.Population
from country cn
order by Name;

# 3. Посмотреть на таблицы в базе world и объяснить ограничения нескольких столбцов - ответить 1 предложением
-- В таблице city поля не могут быть null, и поле CountryCode связано по foreign key с таблицей country поле Code,
-- соответственно пока есть записи с кодом страны в city эту страну нельзя удалить из country

# 4. Далее работаем на локальном сервере. Создать новую таблицу citizen, которая содержит следующие поля:
# уникальное автоинкрементное, номер соц страхования, имя, фамилию и емейл.

create database if not exists homeworks;

create table citizen
(
    citizen_id int auto_increment primary key, -- уникальное автоинкрементное
    ssn        varchar(20)  not null,          -- номер соц страхования
    first_name varchar(50)  not null,          -- имя
    last_name  varchar(50)  not null,          -- фамилия
    email      varchar(100) not null           -- емейл
);

# 5. На вашем локальном сервере в любой базе создать таблицу без ограничений (любую, можно взять с урока).

create table sample_table
(
    id          int,
    name        varchar(50),
    description text
);

# 6. Добавить в таблицу 5 значений. Добавить 3 человека с одинаковыми именами и 2 человека без lastname
alter table citizen
    modify last_name varchar(50) null;

insert into citizen (ssn, first_name, last_name, email)
values ('123-45-6789', 'John', null, 'john1@example.com'),             -- 1-й человек без фамилии
       ('987-65-4321', 'John', null, 'john2@example.com'),             -- 2-й человек без фамилии
       ('111-22-3333', 'Mike', 'Smith', 'mike.smith@example.com'),     -- Mike Smith - уникальное имя и фамилия
       ('444-55-6666', 'Mike', 'Johnson', 'mike.johnson@example.com'), -- Mike Johnson
       ('777-88-9999', 'Mike', 'Smith', 'mike.duplicate@example.com');
-- повтор имен и фамилий

# 7. Использовать оператор alter table … modify , чтобы добавить ограничение not null на поле firstname и lastname.
update citizen
set last_name = 'unknown'
where last_name is NULL;
alter table citizen
    modify first_name varchar(50) not null,
    modify last_name varchar(50) not null;


# 8. Добавить ограничение unique для пары firstname\lastname.

update citizen c1
set last_name = if((select count(c2.last_name)
                    from citizen c2
                    where c2.last_name = c1.last_name) > 1,
                   concat(last_name, citizen_id),
                   last_name);

alter table citizen
    add constraint unique_firstname_lastname unique (first_name, last_name);

# 9. Удалить таблицу из базы и пересоздать ее, модифицировав запрос add table так,
# чтобы он учитывал ограничения (см примеры из класса).
drop table if exists citizen;

create table if not exists citizen
(
    citizen_id int auto_increment primary key, -- уникальное автоинкрементное
    ssn        varchar(20)  not null,          -- номер соц страхования
    first_name varchar(50)  not null,          -- имя
    last_name  varchar(50)  not null,          -- фамилия
    email      varchar(100) not null,          -- емейл
    unique key unique_first_and_last_names (first_name, last_name)
);


# 10. Добавить правильные и неправильные данные (нарушающие и не нарушающие ограничения).


-- Правильные данные (не нарушают ограничения)
insert into citizen (ssn, first_name, last_name, email)
values ('123-89-4567', 'Alice', 'Wonderland', 'alice@example.com'), -- Уникальные имя и фамилия
       ('456-12-7890', 'Bob', 'Builder', 'bob@example.com');
-- Уникальные имя и фамилия

-- Неправильные данные (нарушают ограничения)
-- Повторение уникальных firstname и lastname
insert into citizen (ssn, first_name, last_name, email)
values ('789-01-2345', 'Alice', 'Wonderland', 'duplicate.alice@example.com');
-- Нарушает UNIQUE (first_name, last_name)

-- Попытка вставить NULL в поля, которые не допускают NULL
insert into citizen (ssn, first_name, last_name, email)
values ('111-11-1111', NULL, 'Johnson', 'null.firstname@example.com'), -- Нарушает NOT NULL на поле first_name
       ('222-22-2222', 'Eve', NULL, 'null.lastname@example.com'); -- Нарушает NOT NULL на поле last_name
