#1. Вывести сегодняшнюю дату в формате: день недели, число, месяц, год
SELECT
    CONCAT(
        CASE DATE_FORMAT(CURRENT_DATE, '%W')
            WHEN 'Monday' THEN 'Понедельник'
            WHEN 'Tuesday' THEN 'Вторник'
            WHEN 'Wednesday' THEN 'Среда'
            WHEN 'Thursday' THEN 'Четверг'
            WHEN 'Friday' THEN 'Пятница'
            WHEN 'Saturday' THEN 'Суббота'
            WHEN 'Sunday' THEN 'Воскресенье'
        END,
        ', ',
        DAY(CURRENT_DATE),
        ' ',
        CASE MONTH(CURRENT_DATE)
            WHEN 1 THEN 'января'
            WHEN 2 THEN 'февраля'
            WHEN 3 THEN 'марта'
            WHEN 4 THEN 'апреля'
            WHEN 5 THEN 'мая'
            WHEN 6 THEN 'июня'
            WHEN 7 THEN 'июля'
            WHEN 8 THEN 'августа'
            WHEN 9 THEN 'сентября'
            WHEN 10 THEN 'октября'
            WHEN 11 THEN 'ноября'
            WHEN 12 THEN 'декабря'
        END,
        ' ',
        YEAR(CURRENT_DATE)
    ) AS 'Сегодняшняя дата';

#2. Вывести на какой день недели приходится 1 января 2024 года
SELECT
    CASE DATE_FORMAT('2024-01-01', '%W')
        WHEN 'Monday' THEN 'Понедельник'
        WHEN 'Tuesday' THEN 'Вторник'
        WHEN 'Wednesday' THEN 'Среда'
        WHEN 'Thursday' THEN 'Четверг'
        WHEN 'Friday' THEN 'Пятница'
        WHEN 'Saturday' THEN 'Суббота'
        WHEN 'Sunday' THEN 'Воскресенье'
    END AS 'День недели 1 января 2024';

#3. Вывести, на какой день недели приходится число, через 10 дней после сегодня
SELECT
    CASE DATE_FORMAT(DATE_ADD(CURRENT_DATE, INTERVAL 10 DAY), '%W')
        WHEN 'Monday' THEN 'Понедельник'
        WHEN 'Tuesday' THEN 'Вторник'
        WHEN 'Wednesday' THEN 'Среда'
        WHEN 'Thursday' THEN 'Четверг'
        WHEN 'Friday' THEN 'Пятница'
        WHEN 'Saturday' THEN 'Суббота'
        WHEN 'Sunday' THEN 'Воскресенье'
    END AS 'День недели через 10 дней';

#4. Вывести дату, которая будет через 10 дней после последнего дня текущего месяца
SELECT DATE_ADD(
    LAST_DAY(CURRENT_DATE),
    INTERVAL 10 DAY
) AS 'Дата через 10 дней после конца месяца';

#5. Вывести день недели даты из предыдущей задачи
SELECT
    CASE DATE_FORMAT(
        DATE_ADD(
            LAST_DAY(CURRENT_DATE),
            INTERVAL 10 DAY
        ),
        '%W'
    )
        WHEN 'Monday' THEN 'Понедельник'
        WHEN 'Tuesday' THEN 'Вторник'
        WHEN 'Wednesday' THEN 'Среда'
        WHEN 'Thursday' THEN 'Четверг'
        WHEN 'Friday' THEN 'Пятница'
        WHEN 'Saturday' THEN 'Суббота'
        WHEN 'Sunday' THEN 'Воскресенье'
    END AS 'День недели даты из задачи 4';

#6. Вывести название месяца, который будет через 5 месяцев после текущего
SELECT
    CASE MONTH(DATE_ADD(CURRENT_DATE, INTERVAL 5 MONTH))
        WHEN 1 THEN 'Январь'
        WHEN 2 THEN 'Февраль'
        WHEN 3 THEN 'Март'
        WHEN 4 THEN 'Апрель'
        WHEN 5 THEN 'Май'
        WHEN 6 THEN 'Июнь'
        WHEN 7 THEN 'Июль'
        WHEN 8 THEN 'Август'
        WHEN 9 THEN 'Сентябрь'
        WHEN 10 THEN 'Октябрь'
        WHEN 11 THEN 'Ноябрь'
        WHEN 12 THEN 'Декабрь'
    END AS 'Месяц через 5 месяцев';

#9. Вывести количество дней, которые работают сотрудники с момента найма
SELECT
    employee_id,
    last_name,
    first_name,
    hire_date,
    DATEDIFF(CURRENT_DATE, hire_date) AS 'Дней работы'
FROM employees;

#10. Вывести количество лет, которые проработал каждый сотрудник
SELECT
    employee_id,
    last_name,
    first_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE) AS 'Лет работы'
FROM employees;