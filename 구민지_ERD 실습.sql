-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db0309
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `견적서`
--

DROP TABLE IF EXISTS `견적서`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `견적서` (
  `견적서번호` varchar(45) NOT NULL,
  `공급자_등록번호` char(10) NOT NULL,
  `견적날짜` varchar(45) NOT NULL,
  `견적접수지` varchar(45) DEFAULT NULL,
  `담당` varchar(45) DEFAULT NULL,
  `공급가액` int DEFAULT NULL,
  `부가세` int DEFAULT NULL,
  `총계` int DEFAULT NULL,
  `비고` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`견적서번호`),
  KEY `fk_견적서_공급자1_idx` (`공급자_등록번호`),
  CONSTRAINT `fk_견적서_공급자1` FOREIGN KEY (`공급자_등록번호`) REFERENCES `공급자` (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `견적서`
--

LOCK TABLES `견적서` WRITE;
/*!40000 ALTER TABLE `견적서` DISABLE KEYS */;
INSERT INTO `견적서` VALUES ('1','11111','20230309','부산','ㅇㅇㅇ',NULL,NULL,NULL,NULL),('2','11111','20230311','부산','ㅇㅇㅇ',NULL,NULL,NULL,NULL),('3','11112','20230315','부산','ㅇㅇㅇ',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `견적서` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `공급자`
--

DROP TABLE IF EXISTS `공급자`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `공급자` (
  `등록번호` char(10) NOT NULL,
  `상호` char(20) NOT NULL,
  `대표성명` char(20) DEFAULT NULL,
  `사업자주소` varchar(50) DEFAULT NULL,
  `업태` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `종목` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `전화번호` int DEFAULT NULL,
  PRIMARY KEY (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `공급자`
--

LOCK TABLES `공급자` WRITE;
/*!40000 ALTER TABLE `공급자` DISABLE KEYS */;
INSERT INTO `공급자` VALUES ('11111','푸름상회','ㅇㅇㅇ','부산시 해운대구','판매','잡화',1211122),('11112','ㅇㅇ가구점','ㅇㅇㅇ','부산시 해운대구','판매','가구',2335555);
/*!40000 ALTER TABLE `공급자` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `상품`
--

DROP TABLE IF EXISTS `상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `상품` (
  `공급자_등록번호` char(10) NOT NULL,
  `품명` char(10) NOT NULL,
  `규격` varchar(20) DEFAULT NULL,
  `수량` int DEFAULT NULL,
  `단가` int DEFAULT NULL,
  `금액` int DEFAULT NULL,
  PRIMARY KEY (`품명`),
  KEY `fk_상품_공급자_idx` (`공급자_등록번호`),
  CONSTRAINT `fk_상품_공급자` FOREIGN KEY (`공급자_등록번호`) REFERENCES `공급자` (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `상품`
--

LOCK TABLES `상품` WRITE;
/*!40000 ALTER TABLE `상품` DISABLE KEYS */;
INSERT INTO `상품` VALUES ('11111','가방','ㅇㅇㅇ',5,10000,50000),('11111','신발','ㅇㅇㅇ',5,5000,30000),('11112','의자','ㅇㅇㅇ',5,50000,100000);
/*!40000 ALTER TABLE `상품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db0309'
--

--
-- Dumping routines for database 'db0309'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-09 17:33:23
