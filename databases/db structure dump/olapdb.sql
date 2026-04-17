-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hotelsedsmgolap
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dw_dim_city`
--

DROP TABLE IF EXISTS `dw_dim_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_city` (
  `city_id` int NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `country_id` (`country_id`),
  KEY `idx_dw_dim_city_lookup` (`city_id`),
  CONSTRAINT `dw_dim_city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `dw_dim_country` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_country`
--

DROP TABLE IF EXISTS `dw_dim_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_country` (
  `country_id` int NOT NULL,
  `country_name` varchar(100) NOT NULL,
  PRIMARY KEY (`country_id`),
  KEY `idx_dw_dim_country_lookup` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_customer`
--

DROP TABLE IF EXISTS `dw_dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_customer` (
  `customer_id` int NOT NULL,
  `full_name` varchar(201) DEFAULT NULL,
  `city_id` int NOT NULL,
  `age_group` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `city_id` (`city_id`),
  KEY `idx_dw_dim_customer_lookup` (`customer_id`),
  CONSTRAINT `dw_dim_customer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `dw_dim_city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_employee`
--

DROP TABLE IF EXISTS `dw_dim_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_employee` (
  `employee_id` int NOT NULL,
  `full_name` varchar(201) DEFAULT NULL,
  `hotel_id` int NOT NULL,
  `hire_year` int NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `idx_dw_dim_employee_lookup` (`employee_id`),
  CONSTRAINT `dw_dim_employee_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `dw_dim_hotel` (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_hotel`
--

DROP TABLE IF EXISTS `dw_dim_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_hotel` (
  `hotel_id` int NOT NULL,
  `hotel_name` varchar(200) NOT NULL,
  `stars` int NOT NULL,
  `city_id` int NOT NULL,
  PRIMARY KEY (`hotel_id`),
  KEY `city_id` (`city_id`),
  KEY `idx_dw_dim_hotel_lookup` (`hotel_id`),
  CONSTRAINT `dw_dim_hotel_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `dw_dim_city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_payment_type`
--

DROP TABLE IF EXISTS `dw_dim_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_payment_type` (
  `payment_type_id` int NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_type_id`),
  KEY `idx_dw_dim_payment_type_lookup` (`payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_room`
--

DROP TABLE IF EXISTS `dw_dim_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_room` (
  `room_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `room_type` varchar(100) NOT NULL,
  `capacity` int NOT NULL,
  `price_per_night` double NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `idx_dw_dim_room_lookup` (`room_id`),
  CONSTRAINT `dw_dim_room_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `dw_dim_hotel` (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_dim_time`
--

DROP TABLE IF EXISTS `dw_dim_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_dim_time` (
  `time_id` int NOT NULL,
  `full_date` date NOT NULL,
  `day` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `quarter` int NOT NULL,
  `day_of_week` tinytext,
  PRIMARY KEY (`time_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_fact_reservation`
--

DROP TABLE IF EXISTS `dw_fact_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_fact_reservation` (
  `reservation_id` int NOT NULL,
  `time_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `room_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `payment_type_id` int DEFAULT NULL,
  `num_nights` int NOT NULL,
  `total_price` double NOT NULL,
  `payment_amount` double NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `time_id` (`time_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `room_id` (`room_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `payment_type_id` (`payment_type_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_1` FOREIGN KEY (`time_id`) REFERENCES `dw_dim_time` (`time_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `dw_dim_hotel` (`hotel_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_3` FOREIGN KEY (`room_id`) REFERENCES `dw_dim_room` (`room_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `dw_dim_customer` (`customer_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `dw_dim_employee` (`employee_id`),
  CONSTRAINT `dw_fact_reservation_ibfk_6` FOREIGN KEY (`payment_type_id`) REFERENCES `dw_dim_payment_type` (`payment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dw_fact_review`
--

DROP TABLE IF EXISTS `dw_fact_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dw_fact_review` (
  `review_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `time_id` int NOT NULL,
  `rating` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `customer_id` (`customer_id`),
  KEY `time_id` (`time_id`),
  CONSTRAINT `dw_fact_review_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `dw_dim_hotel` (`hotel_id`),
  CONSTRAINT `dw_fact_review_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `dw_dim_customer` (`customer_id`),
  CONSTRAINT `dw_fact_review_ibfk_3` FOREIGN KEY (`time_id`) REFERENCES `dw_dim_time` (`time_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 18:59:27
