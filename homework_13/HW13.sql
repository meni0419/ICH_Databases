CREATE DATABASE taxi_service;
USE taxi_service;

CREATE TABLE Clients
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(50),
    last_name    VARCHAR(50),
    phone_number VARCHAR(15),
    address      VARCHAR(255),
    reg_date     DATE
);

CREATE TABLE Drivers
(
    id                 INT PRIMARY KEY AUTO_INCREMENT,
    first_name         VARCHAR(50),
    last_name          VARCHAR(50),
    license_number     VARCHAR(20),
    issue_license_date DATE
);

CREATE TABLE Autos
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    model_name      VARCHAR(50),
    production_year INT,
    color           VARCHAR(30),
    country         VARCHAR(50),
    class           VARCHAR(30)
);

CREATE TABLE Schedule
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT,
    begin     DATETIME,
    end       DATETIME,
    auto_id   INT,
    FOREIGN KEY (driver_id) REFERENCES Drivers (id),
    FOREIGN KEY (auto_id) REFERENCES Autos (id)
);

CREATE TABLE Orders
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    date_time DATETIME,
    status    VARCHAR(20),
    client_id INT,
    driver_id INT,
    departure VARCHAR(255),
    arrival   VARCHAR(255),
    FOREIGN KEY (client_id) REFERENCES Clients (id),
    FOREIGN KEY (driver_id) REFERENCES Drivers (id)
);
