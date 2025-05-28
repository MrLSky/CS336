-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircrafts` (
  `AircraftID` int NOT NULL,
  `AirlineID` char(2) DEFAULT NULL,
  `Plane_type` varchar(50) DEFAULT NULL,
  `Seat_capacity` int DEFAULT NULL,
  `Seating_types` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AircraftID`),
  KEY `AirlineID` (`AirlineID`),
  CONSTRAINT `aircrafts_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `airlines` (`AirlineID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircrafts`
--

LOCK TABLES `aircrafts` WRITE;
/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` VALUES (200,'AA','B737',160,'Economy,Business'),(1031,'UA','747',364,'Frst, Bus, Econ');
/*!40000 ALTER TABLE `aircrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airlines`
--

DROP TABLE IF EXISTS `airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airlines` (
  `AirlineID` char(2) NOT NULL,
  `Airline_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AirlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airlines`
--

LOCK TABLES `airlines` WRITE;
/*!40000 ALTER TABLE `airlines` DISABLE KEYS */;
INSERT INTO `airlines` VALUES ('AA','American Airlines'),('UA','United Airlines');
/*!40000 ALTER TABLE `airlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `Airport_code` char(3) NOT NULL,
  `Airport_name` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Airport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('ATL','Atlanta Int','Atlanta','GA','USA'),('JFK','John F Kennedy Intl','New York','NY','USA'),('PHL','Philadelphia Int','Philadelphia','PA','USA');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `answerID` int NOT NULL AUTO_INCREMENT,
  `questionID` int NOT NULL,
  `repID` int NOT NULL,
  `body` text NOT NULL,
  `date_posted` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`answerID`),
  KEY `questionID` (`questionID`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`questionID`) REFERENCES `questions` (`questionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_num` varchar(10) NOT NULL,
  `AirlineID` char(2) DEFAULT NULL,
  `AircraftID` int DEFAULT NULL,
  `departs_from` char(3) DEFAULT NULL,
  `avail_seats` varchar(350) DEFAULT NULL,
  `depart_date` datetime DEFAULT NULL,
  `arrives_at` char(3) DEFAULT NULL,
  `arrives_date` datetime DEFAULT NULL,
  `stopOver_num` int DEFAULT NULL,
  `stopover_locations` varchar(200) DEFAULT NULL,
  `stopover_datetimes` varchar(200) DEFAULT NULL,
  `international` tinyint(1) DEFAULT NULL,
  `trip_cost` float DEFAULT NULL,
  `carry_baggage_fee` float DEFAULT NULL,
  `check_baggage_fee` float DEFAULT NULL,
  PRIMARY KEY (`flight_num`),
  KEY `AirlineID` (`AirlineID`),
  KEY `AircraftID` (`AircraftID`),
  KEY `departs_from` (`departs_from`),
  KEY `arrives_at` (`arrives_at`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `airlines` (`AirlineID`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`AircraftID`) REFERENCES `aircrafts` (`AircraftID`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`departs_from`) REFERENCES `airports` (`Airport_code`),
  CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`arrives_at`) REFERENCES `airports` (`Airport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES ('5566','UA',1031,'PHL','360','2025-05-18 22:15:00','ATL','2025-05-22 12:15:00',0,'0','0',0,1050,25,50);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_history`
--

DROP TABLE IF EXISTS `login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `attempt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint(1) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_history`
--

LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
INSERT INTO `login_history` VALUES (1,'McCoyFarms','2025-05-10 14:07:14',1,'0:0:0:0:0:0:0:1'),(2,'McCoyFarms','2025-05-10 14:08:33',1,'0:0:0:0:0:0:0:1'),(3,'admin','2025-05-10 23:15:40',1,'0:0:0:0:0:0:0:1'),(4,'McCoyFarms','2025-05-10 23:16:24',1,'0:0:0:0:0:0:0:1'),(5,'McCoyFarms','2025-05-10 23:17:53',1,'0:0:0:0:0:0:0:1'),(6,'McCoyFarms','2025-05-10 23:18:50',1,'0:0:0:0:0:0:0:1'),(7,'McCoyFarms','2025-05-10 23:19:44',1,'0:0:0:0:0:0:0:1'),(8,'admin','2025-05-10 23:20:04',1,'0:0:0:0:0:0:0:1'),(9,'admin','2025-05-10 23:35:24',1,'0:0:0:0:0:0:0:1'),(10,'admin','2025-05-10 23:41:04',1,'0:0:0:0:0:0:0:1'),(11,'McCoyFarms','2025-05-10 23:45:44',1,'127.0.0.1'),(12,'McCoyFarms','2025-05-10 23:46:16',1,'127.0.0.1'),(13,'admin','2025-05-10 23:46:29',1,'127.0.0.1'),(14,'admin','2025-05-10 23:47:00',1,'0:0:0:0:0:0:0:1'),(15,'admin','2025-05-10 23:53:05',1,'0:0:0:0:0:0:0:1'),(16,'admin','2025-05-11 01:35:52',1,'127.0.0.1'),(17,'admin','2025-05-11 01:42:54',1,'0:0:0:0:0:0:0:1'),(18,'admin','2025-05-11 01:43:20',1,'0:0:0:0:0:0:0:1'),(19,'Rep','2025-05-11 02:33:15',1,'0:0:0:0:0:0:0:1'),(20,'Rep','2025-05-11 02:52:56',1,'0:0:0:0:0:0:0:1'),(21,'admin','2025-05-11 02:53:07',1,'0:0:0:0:0:0:0:1'),(22,'admin','2025-05-11 03:40:57',1,'0:0:0:0:0:0:0:1'),(23,'admin','2025-05-11 04:01:50',1,'0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payinfo`
--

DROP TABLE IF EXISTS `payinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payinfo` (
  `userID` int NOT NULL,
  `card_num` varchar(19) NOT NULL,
  `exp_date` date DEFAULT NULL,
  `security_code` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`card_num`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `payinfo_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payinfo`
--

LOCK TABLES `payinfo` WRITE;
/*!40000 ALTER TABLE `payinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `payinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `questionID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `body` text NOT NULL,
  `date_posted` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`questionID`),
  KEY `userID` (`userID`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (12345,'Samuel','A','McCoy','2008-05-18','McCoy@GeoCities.com','1619 Ta-Nehisi Dr, Baltimore, MD, 21201','555-123-9876'),(12346,'admin',NULL,NULL,NULL,'admin@portal.com','earth','555-1212'),(12347,'Representative','n','nothing','2025-05-10','rep@portal.com','nothing','5551234567');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `userID` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `permissions` int DEFAULT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `user_login_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES (12345,'McCoyFarms','password','McCoy@GeoCities.com','2025-04-14 20:38:25',0),(12346,'admin','password','admin@portal.com','2025-05-10 00:00:00',2),(12347,'Rep','password','rep@portal.com','2025-05-10 22:54:40',1);
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userflightbookings`
--

DROP TABLE IF EXISTS `userflightbookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userflightbookings` (
  `unique_bookID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `flight_num` varchar(10) NOT NULL,
  `seat_num` varchar(3) DEFAULT NULL,
  `seat_class` varchar(20) DEFAULT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `paid_cost` float DEFAULT NULL,
  PRIMARY KEY (`unique_bookID`,`userID`,`flight_num`),
  KEY `userID` (`userID`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `userflightbookings_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `userflightbookings_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flights` (`flight_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98766 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userflightbookings`
--

LOCK TABLES `userflightbookings` WRITE;
/*!40000 ALTER TABLE `userflightbookings` DISABLE KEYS */;
INSERT INTO `userflightbookings` VALUES (98765,12345,'5566','B23','Economy','2025-05-10 23:27:30',1125);
/*!40000 ALTER TABLE `userflightbookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waiting_list`
--

DROP TABLE IF EXISTS `waiting_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiting_list` (
  `waitID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `flight_num` varchar(10) NOT NULL,
  `request_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`waitID`),
  KEY `userID` (`userID`),
  KEY `flight_num` (`flight_num`),
  CONSTRAINT `waiting_list_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `waiting_list_ibfk_2` FOREIGN KEY (`flight_num`) REFERENCES `flights` (`flight_num`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiting_list`
--

LOCK TABLES `waiting_list` WRITE;
/*!40000 ALTER TABLE `waiting_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `waiting_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-11  0:18:20
