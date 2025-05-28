CREATE DATABASE  IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336project`;
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

-- disable safe-update mode for this session
SET SQL_SAFE_UPDATES = 0;


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
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
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
INSERT INTO `user` VALUES (12345,'Samuel','A','McCoy','2008-05-18','McCoy@GeoCities.com','1619 Ta-Nehisi Dr, Baltimore, MD, 21201','555-123-9876');
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
  permissions INT         NOT NULL DEFAULT 0,
  PRIMARY KEY (`userID`),
  CONSTRAINT `user_login_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--


-- 1) Customer (permissions = 0)
INSERT IGNORE INTO `user_login`
  (userID, username,   password,    email,                   date_created,        permissions)
VALUES
  (12345,  'McCoyFarms','password',  'McCoy@GeoCities.com',   '2025-04-14 20:38:25', 0);

-- 2) Representative (permissions = 1)
INSERT IGNORE INTO `user_login`
  (userID, username,   password,    email,                   date_created,        permissions)
VALUES
  (23456,  'AliceRep',  'repPass123','alice.rep@example.com','2025-05-08 09:00:00', 1);

-- 3) Administrator (permissions = 2)
INSERT IGNORE INTO `user_login`
  (userID, username,   password,    email,                   date_created,        permissions)
VALUES
  (34567,  'BobAdmin',  'adminPass!','bob.admin@example.com','2025-05-08 09:05:00', 2);




-- ------------------------------------------------------
-- Table structure for table `login_history`
-- ------------------------------------------------------

DROP TABLE IF EXISTS `login_history`;
CREATE TABLE `login_history` (
  `id`            INT AUTO_INCREMENT PRIMARY KEY,
  `username`      VARCHAR(50)    NOT NULL,
  `attempt_time`  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `success`       BOOLEAN        NOT NULL,
  `ip_address`    VARCHAR(45)    NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `login_history`
LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `userflightbookings`
--

DROP TABLE IF EXISTS `userflightbookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userflightbookings` (
  `unique_bookID` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userflightbookings`
--

LOCK TABLES `userflightbookings` WRITE;
/*!40000 ALTER TABLE `userflightbookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `userflightbookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-14 21:40:20

-- 1. New tables: Questions/Answers & Waiting List
--------------------------------------------------
CREATE TABLE IF NOT EXISTS questions (
  questionID      INT AUTO_INCREMENT PRIMARY KEY,
  userID          INT NOT NULL,
  title           VARCHAR(200) NOT NULL,
  body            TEXT NOT NULL,
  date_posted     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userID) REFERENCES `user`(userID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS answers (
  answerID        INT AUTO_INCREMENT PRIMARY KEY,
  questionID      INT NOT NULL,
  repID           INT NOT NULL,
  body            TEXT NOT NULL,
  date_posted     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS waiting_list (
  waitID          INT AUTO_INCREMENT PRIMARY KEY,
  userID          INT NOT NULL,
  flight_num      VARCHAR(10) NOT NULL,
  request_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userID)     REFERENCES `user`(userID)        ON DELETE CASCADE,
  FOREIGN KEY (flight_num) REFERENCES flights(flight_num) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 2. Flight‐search procedures
--------------------------------------------------
DELIMITER $$

-- 2.1 One‐way on exact date
DROP PROCEDURE IF EXISTS search_oneway$$

CREATE PROCEDURE search_oneway (
  IN ori    CHAR(3),
  IN dest   CHAR(3),
  IN d      DATE,
  IN sortBy VARCHAR(20)   -- 'price','depart','arrive','duration'
)
BEGIN
  SELECT
    f.flight_num,
    a.Airline_name,
    dep.City   AS depart_city,
    arr.City   AS arrive_city,
    f.depart_date,
    f.arrives_date,
    f.stopOver_num,
    f.trip_cost
  FROM flights f
    JOIN airlines a ON f.AirlineID = a.AirlineID
    JOIN airports dep ON f.departs_from = dep.Airport_code
    JOIN airports arr ON f.arrives_at   = arr.Airport_code
  WHERE f.departs_from = ori
    AND f.arrives_at   = dest
    AND DATE(f.depart_date) = d
  ORDER BY
    CASE WHEN sortBy='price'    THEN f.trip_cost    END,
    CASE WHEN sortBy='depart'   THEN f.depart_date  END,
    CASE WHEN sortBy='arrive'   THEN f.arrives_date END,
    CASE WHEN sortBy='duration' THEN TIMESTAMPDIFF(MINUTE,f.depart_date,f.arrives_date) END;
END$$

-- 2.2 Round‐trip on exact dates
DROP PROCEDURE IF EXISTS search_roundtrip$$

CREATE PROCEDURE search_roundtrip (
  IN ori    CHAR(3), IN dest CHAR(3),
  IN d1     DATE,    IN d2   DATE,
  IN sortBy VARCHAR(20)
)
BEGIN
  -- outbound
  CALL search_oneway(ori,dest,d1,sortBy);
  -- return
  CALL search_oneway(dest,ori,d2,sortBy);
END$$

-- 2.3 Flexible ±3 days

DROP PROCEDURE IF EXISTS search_flexible$$

CREATE PROCEDURE search_flexible (
  IN ori    CHAR(3),
  IN dest   CHAR(3),
  IN d      DATE,
  IN sortBy VARCHAR(20)
)
BEGIN
  SELECT
    f.*
  FROM flights f
  WHERE f.departs_from = ori
    AND f.arrives_at   = dest
    AND DATE(f.depart_date)
        BETWEEN DATE_SUB(d,INTERVAL 3 DAY)
            AND DATE_ADD(d,INTERVAL 3 DAY)
  ORDER BY
    CASE WHEN sortBy='price'    THEN f.trip_cost    END,
    CASE WHEN sortBy='depart'   THEN f.depart_date  END,
    CASE WHEN sortBy='arrive'   THEN f.arrives_date END;
END$$

DELIMITER ;

-- 3. Customer Q&A

-- Browse all Q&A
-- SELECT q.*, a.* FROM questions q LEFT JOIN answers a ON q.questionID=a.questionID;

-- Search Qs by keyword
-- SELECT * FROM questions WHERE title LIKE '%keyword%' OR body LIKE '%keyword%';

-- Post a question
-- INSERT INTO questions(userID,title,body) VALUES(123,'How to ...','I want to know ...');

-- Post an answer
-- INSERT INTO answers(questionID,repID,body) VALUES(456, 1,'Sure, you can ...');

-- 4. Reservations & Waiting list

-- Make reservation (buy ticket)

ALTER TABLE userflightbookings
  MODIFY COLUMN unique_bookID INT NOT NULL AUTO_INCREMENT;


INSERT IGNORE INTO airlines (AirlineID, Airline_name)
VALUES ('AA', 'American Airlines');


INSERT IGNORE INTO aircrafts
  (AircraftID, AirlineID, Plane_type, Seat_capacity, Seating_types)
VALUES
  (200, 'AA', 'B737', 160, 'Economy,Business');


INSERT IGNORE INTO airports
  (Airport_code, Airport_name, City, State, Country)
VALUES
  ('JFK','John F Kennedy Intl','New York','NY','USA'),
  ('LAX','Los Angeles Intl','Los Angeles','CA','USA');

INSERT INTO flights
  (flight_num, AirlineID, AircraftID, departs_from, avail_seats,
   depart_date, arrives_at, arrives_date,
   stopOver_num, international, trip_cost, carry_baggage_fee, check_baggage_fee)
VALUES
  ('AA101','AA',200,'JFK','…', '2025-06-01 08:00:00',
   'LAX','2025-06-01 11:00:00',0,0,300.00,25.00,30.00);





INSERT INTO userflightbookings
  (unique_bookID,userID,flight_num,seat_num,seat_class,purchase_date,paid_cost)
VALUES
  (NULL, 12345, 'AA101', '12A','Business', NOW(), 499.99);

-- If full, join waiting list instead
INSERT INTO waiting_list (userID, flight_num) VALUES(12345,'AA101');

-- View past reservations
SELECT 
  ub.*,
  f.depart_date,
  f.arrives_date
FROM userflightbookings ub
  JOIN flights f 
    ON ub.flight_num = f.flight_num
WHERE ub.userID = 12345
  AND f.depart_date < NOW();

-- View upcoming reservations 
SELECT 
  ub.*,
  f.depart_date,
  f.arrives_date
FROM userflightbookings ub
  JOIN flights f 
    ON ub.flight_num = f.flight_num
WHERE ub.userID = 12345
  AND f.depart_date >= NOW();

-- Cancel (only biz/first class)
DELETE FROM userflightbookings
WHERE unique_bookID=789 AND seat_class IN('Business','First');

-- Alert waiting‐list when seat frees up
-- Example: after cancel, do:
-- INSERT INTO userflightbookings(...) SELECT userID, flight_num,... FROM waiting_list WHERE flight_num='AA101' LIMIT 1;
-- DELETE FROM waiting_list WHERE waitID=thatID;

-- 5. Admin reports
--------------------------------------------------
-- 5.1 Monthly sales: month/year → revenue
SELECT
  YEAR(purchase_date) AS yr,
  MONTH(purchase_date) AS mth,
  SUM(paid_cost)       AS revenue
FROM userflightbookings
GROUP BY YEAR(purchase_date), MONTH(purchase_date);


-- 5.2 Reservations by flight or customer
-- By flight:
SELECT ub.*, u.first_name, u.last_name
FROM userflightbookings ub
  JOIN `user` u   ON ub.userID     = u.userID
WHERE ub.flight_num = 'AA101';

-- By customer:
SELECT ub.*, 
       f.flight_num,
       f.depart_date,
       f.arrives_date
FROM userflightbookings ub
  JOIN `user`   u ON ub.userID     = u.userID
  JOIN flights  f ON ub.flight_num = f.flight_num
WHERE u.last_name = 'McCoy';


-- 5.3 Revenue summary
-- By flight:
SELECT flight_num, SUM(paid_cost) AS rev
FROM userflightbookings
GROUP BY flight_num;
-- By airline:
SELECT a.Airline_name, SUM(ub.paid_cost) AS rev
FROM userflightbookings ub
  JOIN flights f    ON ub.flight_num=f.flight_num
  JOIN airlines a   ON f.AirlineID=a.AirlineID
GROUP BY a.Airline_name;
-- By customer:
SELECT u.userID, CONCAT(u.first_name,' ',u.last_name) AS name, SUM(ub.paid_cost) AS rev
FROM userflightbookings ub
  JOIN `user` u ON ub.userID=u.userID
GROUP BY ub.userID;

-- Top customer by revenue
SELECT name, rev FROM (
  SELECT CONCAT(u.first_name,' ',u.last_name) AS name,
         SUM(ub.paid_cost) AS rev
  FROM userflightbookings ub
    JOIN `user` u ON ub.userID=u.userID
  GROUP BY ub.userID
) t
ORDER BY rev DESC
LIMIT 1;

-- Most active flights (tickets sold)
SELECT flight_num, COUNT(*) AS tickets_sold
FROM userflightbookings
GROUP BY flight_num
ORDER BY tickets_sold DESC
LIMIT 10;

-- 6. Customer-Rep tasks
--------------------------------------------------
-- Make or edit reservation on behalf:
-- INSERT ... (as above) or
UPDATE userflightbookings
SET seat_num='14C', seat_class='Economy'
WHERE unique_bookID=789;

-- Manage aircrafts/airports/flights (CRUD):
-- Example Add aircraft (ignore if already there):
INSERT IGNORE INTO aircrafts
  (AircraftID,AirlineID,Plane_type,Seat_capacity,Seating_types)
VALUES
  (200,'AA','B737',160,'Economy,Business');

-- Update flight:
UPDATE flights SET trip_cost=399.99 WHERE flight_num='AA101';
-- Delete airport:
DELETE FROM flights
 WHERE departs_from = 'LAX'
    OR arrives_at   = 'LAX';

DELETE FROM airports WHERE Airport_code='LAX';

-- Retrieve waiting‐list for a flight:
SELECT w.*, u.first_name,u.last_name
FROM waiting_list w
  JOIN `user` u ON w.userID=u.userID
WHERE w.flight_num='AA101'
ORDER BY request_time;

-- List all flights for a given airport:
SELECT *
FROM flights
WHERE departs_from='JFK' OR arrives_at='JFK';

-- Reply to a user question:
-- INSERT INTO answers(questionID, repID, body) VALUES(456, 2, 'Here is my reply...');


-- DEMO DATA FOR VIDEO: airports, airlines, aircrafts & flights

-- 1) airports
INSERT IGNORE INTO airports (Airport_code, Airport_name, City, State, Country)
VALUES
  ('ORD','Chicago O''Hare Intl','Chicago','IL','USA'),
  ('SFO','San Francisco Intl','San Francisco','CA','USA'),
  ('MIA','Miami Intl','Miami','FL','USA');

-- 2) airlines
INSERT IGNORE INTO airlines (AirlineID, Airline_name)
VALUES
  ('DL','Delta Airlines'),
  ('UA','United Airlines');

-- 3) Matching aircraft for them
INSERT IGNORE INTO aircrafts (AircraftID, AirlineID, Plane_type, Seat_capacity, Seating_types)
VALUES
  (201,'DL','A320',150,'Economy,Business'),
  (301,'UA','B737-900',160,'Economy,First');

-- 4) Three demo flights—JFK↔LAX (AA), ORD→SFO (DL), MIA→JFK (UA)
INSERT IGNORE INTO flights
  (flight_num,AirlineID,AircraftID,departs_from,avail_seats,
   depart_date,arrives_at,arrives_date,
   stopOver_num,international,trip_cost,carry_baggage_fee,check_baggage_fee)
VALUES
  ('AA102','AA',200,'LAX','160','2025-06-02 12:00:00','JFK','2025-06-02 20:00:00',0,0,320.00,25.00,30.00),
  ('DL200','DL',201,'ORD','150','2025-06-01 07:00:00','SFO','2025-06-01 09:30:00',0,0,330.00,30.00,35.00),
  ('UA300','UA',301,'MIA','160','2025-06-02 14:00:00','JFK','2025-06-02 18:30:00',0,0,280.00,25.00,30.00);



