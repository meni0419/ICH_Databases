create database if not exists lesson_triggers;


CREATE TABLE employees
(
    employee_id   INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50)         NOT NULL,
    last_name     VARCHAR(50)         NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone_number  VARCHAR(15),
    hire_date     DATE                NOT NULL,
    job_id        VARCHAR(10)         NOT NULL,
    hourly_pay    DECIMAL(10, 2)      NOT NULL,
    manager_id    INT,
    department_id INT
);


INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, hourly_pay, manager_id,
                       department_id)
VALUES ('SYSTEM', 'SYSTEM', 'noreply@example.com', '1110001112', '1970-01-01', 'FIN000', 0.00, 0, 0),
       ('John', 'Doe', 'john.doe@example.com', '1234567890', '2023-01-15', 'DEV001', 40.50, 101, 10),
       ('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '2022-12-01', 'HR002', 30.00, 102, 20),
       ('James', 'Brown', 'james.brown@example.com', '5551234567', '2023-03-20', 'FIN003', 35.75, 103, 30),
       ('Emily', 'Davis', 'emily.davis@example.com', '5559876543', '2021-07-05', 'DEV001', 42.00, 101, 10),
       ('Michael', 'Johnson', 'mike.johnson@example.com', '4445556667', '2023-02-17', 'ENG004', 50.25, 104, 40),
       ('Sarah', 'Wilson', 'sarah.wilson@example.com', '3332221110', '2022-06-30', 'HR002', 29.50, 102, 20),
       ('Chris', 'Taylor', 'chris.taylor@example.com', '6661113334', '2020-05-12', 'DEV001', 38.90, 101, 10),
       ('Laura', 'Martinez', 'laura.martinez@example.com', '1231231234', '2019-11-18', 'FIN003', 36.00, 103, 30),
       ('David', 'Lee', 'david.lee@example.com', '1112223334', '2021-08-23', 'ENG004', 47.80, 104, 40),
       ('Sofia', 'Anderson', 'sofia.anderson@example.com', '5556781234', '2021-03-15', 'HR002', 31.25, 102, 20),
       ('Robert', 'Clark', 'robert.clark@example.com', '7897897890', '2018-10-10', 'FIN003', 37.50, 103, 30),
       ('Emma', 'Walker', 'emma.walker@example.com', '9879879876', '2020-02-20', 'DEV001', 43.10, 101, 10),
       ('Daniel', 'Young', 'daniel.young@example.com', '2342342345', '2017-09-09', 'ENG004', 52.35, 104, 40),
       ('Sophia', 'Hall', 'sophia.hall@example.com', '3334445556', '2023-05-01', 'HR002', 30.80, 102, 20),
       ('Oliver', 'King', 'oliver.king@example.com', '4564564567', '2021-06-14', 'DEV001', 39.00, 101, 10),
       ('Mia', 'Lopez', 'mia.lopez@example.com', '2223334445', '2022-09-01', 'FIN003', 34.25, 103, 30),
       ('Ethan', 'Harris', 'ethan.harris@example.com', '7778889990', '2020-12-25', 'ENG004', 48.00, 104, 40),
       ('Isabella', 'White', 'isabella.white@example.com', '6665554443', '2019-07-17', 'HR002', 32.00, 102, 20),
       ('Matthew', 'Turner', 'matthew.turner@example.com', '8887776665', '2018-08-08', 'DEV001', 41.20, 101, 10),
       ('Olivia', 'Scott', 'olivia.scott@example.com', '9990001112', '2023-10-06', 'FIN003', 38.50, 103, 30);

alter table employees
    add column salary decimal(10, 2) after hourly_pay;

update employees
set salary = hourly_pay * 2080;

create trigger hourly_pay_update
    before update
    on employees
    for each row
    set new.salary = new.hourly_pay * 2080;

update employees
set hourly_pay = hourly_pay + 10
where employee_id = 1;


CREATE TABLE expenses
(
    expense_id   INT PRIMARY KEY AUTO_INCREMENT,
    employee_id  INT            NOT NULL,
    expense_date DATE           NOT NULL,
    amount       DECIMAL(10, 2) NOT NULL,
    description  VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE
);

truncate expenses;

INSERT INTO expenses (employee_id, expense_date, amount, description)
VALUES (1, '2023-10-01', 150.00, 'Office Supplies'),
       (2, '2023-09-30', 200.00, 'Team Lunch'),
       (3, '2023-09-28', 300.00, 'Travel Reimbursement'),
       (4, '2023-09-25', 50.00, 'Snacks for Meeting'),
       (5, '2023-09-22', 400.00, 'Conference Tickets'),
       (6, '2023-09-20', 100.00, 'Cab Fare'),
       (7, '2023-09-18', 120.00, 'Hotel Booking'),
       (8, '2023-09-15', 80.00, 'Stationery'),
       (9, '2023-09-10', 250.00, 'Client Entertainment'),
       (10, '2025-01-31', 180.00, 'Salary');

update expenses
set amount = (select sum(employees.salary) from employees where description = 'Salary')
where description = 'Salary';

create trigger after_delete_emp_trigger
    after delete
    on employees
    for each row
    update expenses
    set amount = amount - old.salary
    where description = 'Salary';

delete
from employees
where employee_id = 5;

select *
from employees
order by salary desc;

select *
from expenses
order by amount desc;