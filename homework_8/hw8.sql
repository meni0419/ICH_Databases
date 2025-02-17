-- 1. Подключитесь к базе данных Students (которая находится на удаленном сервере). 
-- (здесь предполагается, что вы используете подходящую утилиту подключения, например, команду в вашем CLI или инструмент, такой как PgAdmin, MySQL Workbench и т.д.)

-- 2. Найдите самого старшего студента
SELECT id   AS student_id,
       name AS student_name,
       age
FROM Students
ORDER BY age DESC
LIMIT 1;

-- 3. Найдите самого старшего преподавателя
SELECT id   AS teacher_id,
       name AS teacher_name,
       age
FROM Teachers
ORDER BY age DESC
LIMIT 1;

-- 4. Выведите список преподавателей с количеством компетенций у каждого
SELECT teachers.id                                  AS teacher_id,
       teachers.name                                AS teacher_name,
       COUNT(teachers2competencies.competencies_id) AS competency_count
FROM Teachers teachers
         LEFT JOIN
     Teachers2Competencies teachers2competencies
     ON
         teachers.id = teachers2competencies.teacher_id
GROUP BY teachers.id;

-- 5. Выведите список курсов с количеством студентов в каждом
SELECT courses.id                         AS course_id,
       courses.title                      AS course_name,
       COUNT(students2courses.student_id) AS student_count
FROM Courses courses
         LEFT JOIN
     Students2Courses students2courses
     ON
         courses.id = students2courses.course_id
GROUP BY courses.id;

-- 6. Выведите список студентов с количеством курсов, посещаемых каждым студентом
SELECT students.id                       AS student_id,
       students.name                     AS student_name,
       COUNT(students2courses.course_id) AS course_count
FROM Students students
         LEFT JOIN
     Students2Courses students2courses
     ON
         students.id = students2courses.student_id
GROUP BY students.id;