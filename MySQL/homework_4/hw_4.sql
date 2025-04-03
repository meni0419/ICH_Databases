# 1. Создать базу данных онлайн-магазина из двух таблиц: заказчики (Customer) и заказы (Orders).
#create database if not exists online_shop_MM091224;

create table if not exists Customers
(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique customer ID
    first_name  VARCHAR(50)  NOT NULL,                 -- Customer's first name
    last_name   VARCHAR(50)  NOT NULL,                 -- Customer's last name
    email       VARCHAR(100) NOT NULL UNIQUE,          -- Customer's email
    phone       VARCHAR(15),                           -- Customer's phone number
    address     TEXT,                                  -- Customer's address
    city        VARCHAR(50),                           -- City of residence
    state       VARCHAR(50),                           -- State or region
    postal_code VARCHAR(15),                           -- Postal/ZIP code
    country     VARCHAR(50) DEFAULT 'USA',             -- Default country
    created_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP, -- Account creation date
    updated_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP                    -- Last update timestamp
);

# 4. К таблице Customer добавить поле last_modified, которое содержит дату последнего
# изменения данных заказчика. Установить его значение в now.
CREATE TABLE `Orders`
(
    `order_id`         int PRIMARY KEY                                                 NOT NULL AUTO_INCREMENT,
    `customer_id`      int                                                             NOT NULL,
    `order_name`       varchar(100)                                                             DEFAULT NULL,
    `order_date`       timestamp                                                       NULL     DEFAULT CURRENT_TIMESTAMP,
    `status`           enum ('Pending','Processing','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
    `total_amount`     decimal(10, 2)                                                  NOT NULL,
    `shipping_address` text                                                            NOT NULL,
    `payment_method`   enum ('Credit Card','PayPal','Cash on Delivery')                NOT NULL,
    `updated_at`       timestamp                                                       NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `discounter_price` decimal(10, 2)                                                           DEFAULT NULL,
    KEY `customer_id` (`customer_id`),
    CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE CASCADE
);


-- Create the Goods table
CREATE TABLE Goods
(
    goods_id       INT AUTO_INCREMENT PRIMARY KEY,                                 -- Unique ID for each good
    name           VARCHAR(100)   NOT NULL,                                        -- Name of the product
    description    TEXT,                                                           -- Description of the product
    price          DECIMAL(10, 2) NOT NULL,                                        -- Price of the product
    stock_quantity INT            NOT NULL,                                        -- Stock quantity available
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                            -- Timestamp when the record was created
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Timestamp when the record was last updated
);


# 2. Заполнить таблицу тестовыми данными: 3-5 заказчиков и с десяток ордеров так,
# чтобы у всех заказчиков было разное количество заказов.
-- Insert 15 customers into the `Customers` table
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, postal_code, country)
VALUES ('John', 'Doe', 'john.doe@gmail.com', '1234567890', '123 Main St', 'New York', 'NY', '10001', 'USA'),
       ('Jane', 'Smith', 'jane.smith@gmail.com', '2345678901', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA'),
       ('Michael', 'Brown', 'michael.brown@example.com', '3456789012', '789 Maple Dr', 'Chicago', 'IL', '60601', 'USA'),
       ('Emily', 'Davis', 'emily.davis@example.com', '4567890123', '321 Pine Rd', 'Houston', 'TX', '77001', 'USA'),
       ('Chris', 'Wilson', 'chris.wilson@example.com', '5678901234', '654 Birch Ln', 'Phoenix', 'AZ', '85001', 'USA'),
       ('Anna', 'Taylor', 'anna.taylor@example.com', '6789012345', '987 Cedar St', 'Philadelphia', 'PA', '19101',
        'USA'),
       ('David', 'Anderson', 'david.anderson@example.com', '7890123456', '123 Willow Way', 'San Antonio', 'TX', '78201',
        'USA'),
       ('Sophia', 'Martinez', 'sophia.martinez@example.com', '8901234567', '456 Spruce Rd', 'San Diego', 'CA', '92101',
        'USA'),
       ('James', 'Lee', 'james.lee@gmail.com', '9012345678', '789 Elm St', 'Dallas', 'TX', '75201', 'USA'),
       ('Olivia', 'Hernandez', 'olivia.hernandez@example.com', '0123456789', '321 Ash Ave', 'San Jose', 'CA', '95101',
        'USA'),
       ('Daniel', 'Lopez', 'daniel.lopez@example.com', '1123456789', '654 Sycamore Blvd', 'Austin', 'TX', '73301',
        'USA'),
       ('Isabella', 'Gonzalez', 'isabella.gonzalez@gmail.com', '2234567890', '987 Palm Ct', 'Jacksonville', 'FL',
        '32099', 'USA'),
       ('Matthew', 'Clark', 'matthew.clark@example.com', '3345678901', '123 Cherry St', 'San Francisco', 'CA', '94101',
        'USA'),
       ('Emma', 'Walker', 'emma.walker@gmail.com', '4456789012', '456 Fir Loop', 'Columbus', 'OH', '43004', 'USA'),
       ('Ethan', 'Hall', 'ethan.hall@example.com', '5567890123', '789 Beech Ln', 'Charlotte', 'NC', '28201', 'USA');

-- Insert 50 orders into the `Orders` table using random customer IDs and values
INSERT INTO Orders (customer_id, order_date, status, total_amount, shipping_address, payment_method)
VALUES (1, '2023-10-01 10:00:00', 'Pending', 120.50, '123 Main St, New York, NY, 10001', 'Credit Card'),
       (2, '2023-10-02 12:30:00', 'Processing', 50.75, '456 Oak Ave, Los Angeles, CA, 90001', 'PayPal'),
       (3, '2023-10-03 15:45:00', 'Shipped', 250.80, '789 Maple Dr, Chicago, IL, 60601', 'Cash on Delivery'),
       (4, '2023-10-04 18:00:00', 'Cancelled', 75.00, '321 Pine Rd, Houston, TX, 77001', 'Credit Card'),
       (5, '2023-10-05 09:15:00', 'Delivered', 500.00, '654 Birch Ln, Phoenix, AZ, 85001', 'Credit Card'),
       (6, '2023-10-06 10:30:00', 'Pending', 120.00, '987 Cedar St, Philadelphia, PA, 19101', 'PayPal'),
       (7, '2023-10-07 12:45:00', 'Processing', 225.40, '123 Willow Way, San Antonio, TX, 78201', 'Cash on Delivery'),
       (8, '2023-10-08 14:20:00', 'Shipped', 90.00, '456 Spruce Rd, San Diego, CA, 92101', 'Credit Card'),
       (9, '2023-10-09 16:50:00', 'Delivered', 180.20, '789 Elm St, Dallas, TX, 75201', 'PayPal'),
       (10, '2023-10-10 18:10:00', 'Pending', 99.99, '321 Ash Ave, San Jose, CA, 95101', 'Credit Card'),
       (11, '2023-10-11 08:30:00', 'Processing', 199.49, '654 Sycamore Blvd, Austin, TX, 73301', 'Cash on Delivery'),
       (12, '2023-10-12 10:50:00', 'Cancelled', 49.80, '987 Palm Ct, Jacksonville, FL, 32099', 'PayPal'),
       (13, '2023-10-13 13:20:00', 'Shipped', 310.99, '123 Cherry St, San Francisco, CA, 94101', 'Credit Card'),
       (14, '2023-10-14 15:30:00', 'Delivered', 420.00, '456 Fir Loop, Columbus, OH, 43004', 'Credit Card'),
       (15, '2023-10-15 09:00:00', 'Pending', 89.50, '789 Beech Ln, Charlotte, NC, 28201', 'PayPal'),
       (15, '2023-10-15 09:10:00', 'Delivered', 129.99, '789 Beech Ln, Charlotte, NC, 28201', 'Credit Card'),
       (1, '2023-10-16 11:25:00', 'Processing', 200.00, '123 Main St, New York, NY, 10001', 'PayPal'),
       (2, '2023-10-17 12:00:00', 'Shipped', 299.99, '456 Oak Ave, Los Angeles, CA, 90001', 'Credit Card'),
       (3, '2023-10-18 14:30:00', 'Delivered', 400.00, '789 Maple Dr, Chicago, IL, 60601', 'Cash on Delivery'),
       (4, '2023-10-19 16:00:00', 'Cancelled', 75.75, '321 Pine Rd, Houston, TX, 77001', 'Credit Card'),
       (5, '2023-10-20 08:00:00', 'Pending', 120.50, '654 Birch Ln, Phoenix, AZ, 85001', 'PayPal'),
       (6, '2023-10-21 09:15:00', 'Shipped', 50.00, '987 Cedar St, Philadelphia, PA, 19101', 'Credit Card'),
       (7, '2023-10-22 10:30:00', 'Delivered', 180.00, '123 Willow Way, San Antonio, TX, 78201', 'Cash on Delivery'),
       (8, '2023-10-23 11:00:00', 'Shipped', 220.75, '456 Spruce Rd, San Diego, CA, 92101', 'PayPal'),
       (9, '2023-10-24 15:20:00', 'Processing', 140.50, '789 Elm St, Dallas, TX, 75201', 'Credit Card'),
       (10, '2023-10-25 17:45:00', 'Cancelled', 99.99, '321 Ash Ave, San Jose, CA, 95101', 'Credit Card'),
       (11, '2023-10-26 12:30:00', 'Pending', 75.25, '654 Sycamore Blvd, Austin, TX, 73301', 'Cash on Delivery'),
       (12, '2023-10-27 16:40:00', 'Shipped', 310.00, '987 Palm Ct, Jacksonville, FL, 32099', 'PayPal'),
       (13, '2023-10-28 08:50:00', 'Processing', 170.60, '123 Cherry St, San Francisco, CA, 94101', 'Credit Card'),
       (14, '2023-10-29 09:15:00', 'Delivered', 199.99, '456 Fir Loop, Columbus, OH, 43004', 'Cash on Delivery'),
       (15, '2023-10-30 13:00:00', 'Processing', 89.75, '789 Beech Ln, Charlotte, NC, 28201', 'PayPal'),
       (1, '2023-10-31 14:10:00', 'Pending', 129.99, '123 Main St, New York, NY, 10001', 'Credit Card'),
       (2, '2023-11-01 15:30:00', 'Delivered', 150.00, '456 Oak Ave, Los Angeles, CA, 90001', 'PayPal'),
       (3, '2023-11-02 10:00:00', 'Shipped', 75.99, '789 Maple Dr, Chicago, IL, 60601', 'Cash on Delivery'),
       (4, '2023-11-03 18:00:00', 'Cancelled', 50.00, '321 Pine Rd, Houston, TX, 77001', 'Credit Card'),
       (5, '2023-11-04 08:20:00', 'Processing', 410.50, '654 Birch Ln, Phoenix, AZ, 85001', 'Cash on Delivery'),
       (6, '2023-11-05 09:45:00', 'Shipped', 275.00, '987 Cedar St, Philadelphia, PA, 19101', 'PayPal'),
       (7, '2023-11-06 14:10:00', 'Delivered', 180.00, '123 Willow Way, San Antonio, TX, 78201', 'Credit Card'),
       (8, '2023-11-07 12:40:00', 'Processing', 220.25, '456 Spruce Rd, San Diego, CA, 92101', 'Cash on Delivery'),
       (9, '2023-11-08 17:20:00', 'Delivered', 140.75, '789 Elm St, Dallas, TX, 75201', 'Credit Card'),
       (10, '2023-11-09 13:30:00', 'Processing', 310.60, '321 Ash Ave, San Jose, CA, 95101', 'PayPal'),
       (11, '2023-11-10 11:50:00', 'Delivered', 220.00, '654 Sycamore Blvd, Austin, TX, 73301', 'Credit Card'),
       (12, '2023-11-11 15:10:00', 'Cancelled', 100.00, '987 Palm Ct, Jacksonville, FL, 32099', 'Cash on Delivery');

# 5. Добавить к таблице Order поле discounter_price, которое содержит скидочную
# стоимость заказа. Выставить значение этого поля для всех заказов на 10% меньше,
# чем оригинальная стоимость заказа.
alter table Orders
    add column discounter_price DECIMAL(10, 2);

update Orders
set discounter_price = total_amount * 0.9;

# 1. Вывести все заказы, отсортированные по убыванию по стоимости
select *
from Orders
order by total_amount DESC;

# 2. Вывести всех заказчиков, у которых почта зарегистрирована на gmail.com
select *
from Customers
where email like '%gmail.com';

# 3. Вывести заказы, добавив дополнительный вычисляемый столбец status, который
# вычисляется по стоимости заказа и имеет три значения: low, middle, high.
select *,
       case
           when total_amount < 100 then 'low'
           when total_amount < 300 then 'middle'
           else 'high'
           end as status
from Orders
order by total_amount DESC;

# 4. Вывести заказчиков по убыванию рейтинга.
alter table Customers
    add column rate decimal(10, 2);

UPDATE Customers C
    LEFT JOIN Orders O ON C.customer_id = O.customer_id
SET C.rate = CASE
                 WHEN O.total_amount < 100 THEN 1 + (RAND() * 2.9) -- Random value between 1 and 3.9
                 WHEN O.total_amount < 300 THEN 4 + (RAND() * 2.9) -- Random value between 4 and 6.9
                 ELSE 7 + (RAND() * 3) -- Random value between 7 and 10
    END;

select *
from Customers
order by rate DESC;

# 5. Вывести всех заказчиков из города на ваш выбор.
select *
from Customers
where city IN ('San Francisco', 'Dallas', 'Los Angeles', 'Houston')
order by rate DESC;

# 6. Написать запрос, который вернет самый часто продаваемый товар.
alter table Orders
    add column order_name varchar(100) after customer_id;

UPDATE Orders O
SET O.order_name = CASE
                       WHEN O.total_amount < 100 THEN 'Bicycle'
                       WHEN O.total_amount < 300 THEN 'Car'
                       ELSE 'Plane'
    END;

SELECT order_name, COUNT(order_name) AS frequency
FROM Orders
GROUP BY order_name
ORDER BY frequency DESC
LIMIT 1;

# 7. Вывести список заказов с максимальной скидкой.
update Orders
set discounter_price = total_amount * (1 - (rand() * 50) / 100);

update Orders
set discounter_price = total_amount / 2
where goods_id = 3;

select order_id, total_amount, discounter_price, round((100 - (discounter_price * 100 / total_amount)), 2) AS `% discount`
from Orders order by `% discount` desc ;

SELECT order_name,
       total_amount,
       discounter_price,
       round((100 - (discounter_price * 100 / total_amount)), 2) AS `% discount`
FROM Orders
WHERE round((100 - (discounter_price * 100 / total_amount)), 2) =
      (SELECT MAX(round((100 - (discounter_price * 100 / total_amount)), 2))
       FROM Orders);

SELECT order_name,
       total_amount,
       discounter_price,
       ROUND((100 - (discounter_price * 100 / total_amount)), 2) AS `% discount`
FROM Orders
HAVING `% discount` = (
    SELECT MAX(ROUND((100 - (discounter_price * 100 / total_amount)), 2))
    FROM Orders
);

WITH DiscountedOrders AS (
    SELECT order_name,
           total_amount,
           discounter_price,
           ROUND((100 - (discounter_price * 100 / total_amount)), 2) AS `% discount`
    FROM Orders
)
SELECT order_name,
       total_amount,
       discounter_price,
       `% discount`
FROM DiscountedOrders
WHERE `% discount` = (SELECT MAX(`% discount`) FROM DiscountedOrders);

#8. Ответьте в 1 предложении: как вы определите скидку?
-- От 100 отнять (скидочную цену * 100 и поделить на полную стоимость)
-- например 100 - (90 * 100 / 100) = 10% или 1 - (скидочная(90) * 100% / полная(100) / 100%) = 0.1
#9. Ответьте в 1 предложении: может ли это быть разница между нормальной ценой и скидочной ценой?
-- Нет, так мы узнаем на сколько меньше стала стоимость, но не размер скидки, на скидку 10% будет разная сумма скидки

# 10. Написать запрос, который выведет все заказы с дополнительным столбцом процент_скидки,
# который содержит разницу в процентах между нормальной и скидочной ценой?
SELECT order_name,
       total_amount,
       discounter_price,
       round((100 - (discounter_price * 100 / total_amount)), 2) AS `процент_скидки`
FROM Orders
ORDER BY `процент_скидки` DESC;

# Удалим пользователя и все его заказы
delete
FROM Customers
where customer_id = 4;

select *
from Orders;

-- Add foreign key constraint
ALTER TABLE Orders
    ADD COLUMN goods_id INT NOT NULL AFTER customer_id; -- Add `goods_id` as a foreign key

ALTER TABLE Orders
    ADD CONSTRAINT `Orders_ibfk_goods`
        FOREIGN KEY (`goods_id`) REFERENCES `Goods` (`goods_id`) ON DELETE CASCADE;

-- Inserting individual order names from Orders into the Goods table with random descriptions and values
INSERT INTO Goods (name, description, price, stock_quantity)
SELECT DISTINCT order_name,
                CASE
                    WHEN order_name = 'Bicycle' THEN 'A two-wheel high-performance bicycle built for long rides.'
                    WHEN order_name = 'Car' THEN 'A compact family car with excellent fuel efficiency.'
                    WHEN order_name = 'Plane' THEN 'A private jet for luxurious travel experiences.'
                    ELSE 'Miscellaneous Item'
                    END                       AS product_description,
                ROUND(50 + (RAND() * 500), 2) AS price,         -- Random price between 50 and 550
                FLOOR(5 + (RAND() * 95))      AS stock_quantity -- Random stock between 5 and 100
FROM Orders
group by order_name;

select *
from Goods;
select *
from Orders;

-- Adding a few more unique products directly to the Goods table
INSERT INTO Goods (name, description, price, stock_quantity)
VALUES ('Smartphone', 'A high-performance smartphone with the latest AI processor.', 699.99, 50),
       ('Laptop', 'A powerful laptop with 16GB RAM and 1TB SSD storage.', 999.99, 20),
       ('Smart Watch', 'A sleek and modern smartwatch with numerous health tracking features.', 299.49, 30),
       ('Headphones', 'Wireless noise-cancelling headphones with a long battery life.', 199.95, 60),
       ('Gaming Console', 'The latest gaming console with ultra-HD realism.', 499.99, 40),
       ('Electric Scooter', 'An eco-friendly electric scooter with a 50-mile range.', 799.00, 10);

#update Orders set order_id = CASE when
update Orders O
    LEFT JOIN Goods G on O.order_name = G.name
set O.goods_id = G.goods_id;


-- add the foreign key with cascade options
ALTER TABLE Orders
    ADD CONSTRAINT Orders_ibfk_order_name FOREIGN KEY (order_name) REFERENCES Goods (name)
        ON UPDATE CASCADE ON DELETE RESTRICT;

alter table Customers
    drop updated_at,
    drop last_modified;

ALTER TABLE Customers
    ADD COLUMN last_modified DATE DEFAULT (CURRENT_DATE());

ALTER TABLE Customers
    change last_modified updated_at datetime DEFAULT NOW();

update Customers
set updated_at = date_format(updated_at, '%Y-%m-%d') + interval time_format(current_time, '%H:%i:%s') hour_second;


select *
FROM Customers;