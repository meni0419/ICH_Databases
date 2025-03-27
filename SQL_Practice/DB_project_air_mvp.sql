CREATE DATABASE air_transportation;
USE air_transportation;

CREATE TABLE Airliners
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100),
    model    VARCHAR(50),
    capacity INT
);

CREATE TABLE Airports
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(100),
    city    VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE Personnel
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(100),
    position     VARCHAR(50),
    contact_info VARCHAR(255)
);

CREATE TABLE Crew
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE Crew_Personnel
(
    crew_id      INT,
    personnel_id INT,
    PRIMARY KEY (crew_id, personnel_id),
    FOREIGN KEY (crew_id) REFERENCES Crew (id),
    FOREIGN KEY (personnel_id) REFERENCES Personnel (id)
);

CREATE TABLE Trips
(
    id                     INT PRIMARY KEY AUTO_INCREMENT,
    airliner_id            INT,
    origin_airport_id      INT,
    destination_airport_id INT,
    departure_time         DATETIME,
    arrival_time           DATETIME,
    crew_id                INT,
    FOREIGN KEY (airliner_id) REFERENCES Airliners (id),
    FOREIGN KEY (origin_airport_id) REFERENCES Airports (id),
    FOREIGN KEY (destination_airport_id) REFERENCES Airports (id),
    FOREIGN KEY (crew_id) REFERENCES Crew (id)
);

CREATE TABLE Clients
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100),
    email           VARCHAR(100),
    phone           VARCHAR(15),
    passport_number VARCHAR(20)
);

CREATE TABLE Tickets
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    trip_id     INT,
    client_id   INT,
    seat_number VARCHAR(10),
    price       DECIMAL(10, 2),
    FOREIGN KEY (trip_id) REFERENCES Trips (id),
    FOREIGN KEY (client_id) REFERENCES Clients (id)
);

CREATE TABLE Feedback
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT UNIQUE,
    rating    INT,
    comments  TEXT,
    FOREIGN KEY (ticket_id) REFERENCES Tickets (id)
);

CREATE TABLE Repairs
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    airliner_id INT,
    repair_date DATE,
    description TEXT,
    cost        DECIMAL(10, 2),
    FOREIGN KEY (airliner_id) REFERENCES Airliners (id)
);

INSERT INTO Airliners (name, model, capacity)
VALUES ('Boeing 747', '747-8', 410),
       ('Airbus A320', 'A320-200', 180),
       ('Embraer E190', 'E190', 100);

INSERT INTO Airports (name, city, country)
VALUES ('JFK Airport', 'New York', 'USA'),
       ('Heathrow', 'London', 'UK'),
       ('Narita Airport', 'Tokyo', 'Japan');

INSERT INTO Personnel (name, position, contact_info)
VALUES ('John Smith', 'Pilot', 'john.smith@example.com'),
       ('Anna Johnson', 'Flight Attendant', 'anna.johnson@example.com'),
       ('Mark Brown', 'Technician', 'mark.brown@example.com');

INSERT INTO Crew (name)
VALUES ('Crew Alpha'),
       ('Crew Beta');

INSERT INTO Crew_Personnel (crew_id, personnel_id)
VALUES (1, 1), -- John Smith в Crew Alpha
       (1, 2), -- Anna Johnson в Crew Alpha
       (2, 3); -- Mark Brown в Crew Beta

INSERT INTO Trips (airliner_id, origin_airport_id, destination_airport_id, departure_time, arrival_time, crew_id)
VALUES (1, 1, 2, '2025-04-01 10:00', '2025-04-01 18:00', 1), -- Рейс из JFK в Heathrow с Crew Alpha
       (2, 2, 3, '2025-04-02 12:00', '2025-04-02 22:00', 2); -- Рейс из Heathrow в Narita с Crew Beta

INSERT INTO Clients (name, email, phone, passport_number)
VALUES ('Alice Green', 'alice.green@example.com', '+123456789', 'AB1234567'),
       ('Bob White', 'bob.white@example.com', '+987654321', 'CD7654321');

INSERT INTO Tickets (trip_id, client_id, seat_number, price)
VALUES (1, 1, '12A', 500.00), -- Alice Green на рейс 1
       (1, 2, '12B', 500.00), -- Bob White на рейс 1
       (2, 1, '1A', 1500.00); -- Alice Green на рейс 2

INSERT INTO Feedback (ticket_id, rating, comments)
VALUES (1, 5, 'Great service!'),
       (2, 4, 'Comfortable flight.'),
       (3, 5, 'Excellent experience!');

INSERT INTO Repairs (airliner_id, repair_date, description, cost)
VALUES (1, '2025-03-15', 'Engine maintenance', 10000.00),
       (2, '2025-03-20', 'Wing inspection', 7000.00);

INSERT INTO Trips (airliner_id, origin_airport_id, destination_airport_id, departure_time, arrival_time, crew_id)
VALUES (1, 1, 3, '2025-04-03 14:00', '2025-04-04 02:00', 1), -- Рейс из JFK в Narita с Crew Alpha
       (3, 2, 1, '2025-04-05 08:00', '2025-04-05 16:00', 2), -- Рейс из Heathrow в JFK с Crew Beta
       (2, 3, 2, '2025-04-06 10:00', '2025-04-06 20:00', 1), -- Рейс из Narita в Heathrow с Crew Alpha
       (1, 2, 3, '2025-04-07 18:00', '2025-04-08 05:00', 2); -- Рейс из Heathrow в Narita с Crew Beta

INSERT INTO Tickets (trip_id, client_id, seat_number, price)
VALUES
-- Рейс 1
(1, 1, '14C', 500.00),
(1, 2, '14D', 500.00),
(1, 1, '15A', 600.00),
-- Рейс 2
(2, 2, '2A', 1500.00),
(2, 1, '2B', 1500.00),
-- Рейс 3
(3, 1, '1C', 800.00),
(3, 2, '1D', 800.00),
(3, 1, '2E', 850.00),
-- Рейс 4
(4, 2, '3A', 1000.00),
(4, 1, '3B', 1000.00),
(4, 2, '4C', 1200.00),
-- Рейс 5
(5, 1, '5A', 750.00),
(5, 2, '5B', 750.00),
(5, 1, '6C', 800.00),
-- Рейс 6
(6, 2, '7A', 900.00),
(6, 1, '7B', 900.00),
(6, 2, '8C', 950.00);
