-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: homework_3
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-0ubuntu0.24.04.1

-- SQL Script for creating database and table, with data

-- Create database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS `homework_3`;
USE `homework_3`;

-- Drop table if it already exists
DROP TABLE IF EXISTS `weather`;

-- Create table `weather`
CREATE TABLE `weather` (
  `city` varchar(50) DEFAULT NULL,
  `forecast_date` date DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `min_temp` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert data into the `weather` table
INSERT INTO `weather` VALUES
('Paris','2023-08-29',26,0),
('Paris','2025-01-01',8.2,0),
('London','2025-01-02',15.4,0),
('Kyiv','2025-01-01',10.3,0);

-- Dump completed on 2025-01-12 20:23:56
