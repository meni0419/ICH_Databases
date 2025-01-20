/* 1. Опираясь на условие, записать use cases в блокноте/заметках, отправить в чат.*/

/* 2. Создать таблицу “Расписание” (“Schedule”), которая содержит следующие поля: название
предмета, преподаватель, дата, номер пары (1, 2 или 3).*/
create table if not exists Schedule
(
    subject_name VARCHAR(50),
    teacher      VARCHAR(50),
    date         DATE,
    paar_number  TINYINT
);

/* 3. Добавить в таблицу расписание на неделю (5 дней) для нескольких преподавателей и
предметов: программирование, математика, литература, по 2 пары в день*/
INSERT INTO Schedule (subject_name, teacher, date, paar_number)
VALUES ('Programming', 'Professor Smith', '2025-01-13', 1),
       ('Mathematics', 'Professor Johnson', '2025-01-13', 2),
       ('Literature', 'Professor Brown', '2025-01-14', 1),
       ('Programming', 'Professor Smith', '2025-01-14', 2),
       ('Mathematics', 'Professor Johnson', '2025-01-15', 1),
       ('Literature', 'Professor Brown', '2025-01-15', 2),
       ('Programming', 'Professor Smith', '2025-01-16', 1),
       ('Mathematics', 'Professor Johnson', '2025-01-16', 2),
       ('Literature', 'Professor Brown', '2025-01-17', 1),
       ('Programming', 'Professor Smith', '2025-01-17', 2);


/* 4. Добавить к таблице столбец “время начала” типа строка*/
alter table Schedule
    add column time_start varchar(10);

/* 5. Установить значение “9.30” для всех первых пар в расписании*/
update Schedule
set time_start = '9.30'
where paar_number = 1;

/* 6. Установить значение “11.00” для всех вторых пар в расписании*/
update Schedule
set time_start = '11.00'
where paar_number = 2;

/* 7. Поменять тип поля “время начала” на типа time*/
UPDATE Schedule
SET time_start = STR_TO_DATE(time_start, '%H.%i');

alter table Schedule
    modify time_start time;

alter table Schedule
    modify time_start varchar(10);

/* 8. Вывести содержимое таблицы, отсортированное по дате в порядке возрастания*/
select *
from Schedule
order by date DESC;

/* 9. Поменять все значения “Литература” на “Физкультура”*/
update Schedule
set subject_name = 'Physical Education'
where subject_name = 'Literature';