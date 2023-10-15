-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: hospitals
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departments` (
  `department_id` int NOT NULL,
  `hospital_id` int DEFAULT NULL,
  `department_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `Hospitals` (`hospital_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` VALUES (1,1,'内科','内科'),(2,1,'外科','外科'),(3,1,'妇产科','妇产科'),(4,2,'骨科','骨科'),(5,2,'儿科','儿科'),(6,2,'内科','内科');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctors`
--

DROP TABLE IF EXISTS `Doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctors` (
  `doctor_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `doctor_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `Departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctors`
--

LOCK TABLES `Doctors` WRITE;
/*!40000 ALTER TABLE `Doctors` DISABLE KEYS */;
INSERT INTO `Doctors` VALUES (1,1,'张三'),(2,1,'李四'),(3,2,'王五'),(4,3,'赵六');
/*!40000 ALTER TABLE `Doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hospitals`
--

DROP TABLE IF EXISTS `Hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hospitals` (
  `hospital_id` int NOT NULL,
  `hospital_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospitals`
--

LOCK TABLES `Hospitals` WRITE;
/*!40000 ALTER TABLE `Hospitals` DISABLE KEYS */;
INSERT INTO `Hospitals` VALUES (1,'西安交通大学第一附属医院'),(2,'陕西省人民医院'),(3,'西安市中心医院'),(4,'西安交通大学第二附属医院'),(5,'西安交通大学第三附属医院');
/*!40000 ALTER TABLE `Hospitals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-15 17:30:02
