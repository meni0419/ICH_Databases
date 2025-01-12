/* 1. Создать таблицу `weather` с тремя полями:
   - название города (`city`)
   - дата (`forecast_date`)
   - температура в эту дату (`temperature`)*/

CREATE TABLE weather
(
    city          VARCHAR(50),
    forecast_date DATE,
    temperature   FLOAT
);

# 2. Вывести содержимое таблицы.

select *
from weather;

/*3. Добавить данные в таблицу, используя запрос `INSERT`:
   - “29 августа 2023 года в Берлине было 30 градусов”*/

INSERT INTO weather (city, forecast_date, temperature)
VALUES ('Berlin', '2023-08-29', 30);


#4. Добавить еще 3 записи в таблицу (произвольную погоду в разных городах в разные дни).
INSERT INTO weather (city, forecast_date, temperature)
VALUES ('Paris', '2025-01-01', 8.2),
       ('London', '2025-01-02', 15.4),
       ('Kyiv', '2025-01-01', 10.3);

# 5. Написать запрос, который возвращает содержимое таблицы.

select *
from weather;

# 6. Изменить данные в таблице о температуре в Берлине с 30 на 26 градусов.

update weather
set temperature = 26
where city = 'Berlin'
  and forecast_date = '2023-08-29';

# 7. Поменять во всей таблице название города на Paris для записей, где температура выше 25 градусов.

update weather
set city = 'Paris'
where temperature > 25;

# 8. Добавить к таблице `weather` дополнительный столбец `min_temp` типа `integer`.

alter table weather
    add column (min_temp int(3));

# 9. Используя команду `update`, установить значение поля `min_temp` в 0 для всех записей в таблице.

update weather
set min_temp = 0;