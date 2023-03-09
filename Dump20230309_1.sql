-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db0217
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
-- Table structure for table `goodsinfo`
--

DROP TABLE IF EXISTS `goodsinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goodsinfo` (
  `goodscd` char(5) NOT NULL,
  `goodsname` varchar(20) NOT NULL,
  `unitcd` char(2) DEFAULT NULL,
  `unitprice` decimal(5,0) unsigned DEFAULT '0',
  `state` enum('Y','N') DEFAULT 'Y',
  `insdtm` datetime DEFAULT NULL,
  `moddtm` datetime DEFAULT NULL,
  PRIMARY KEY (`goodscd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goodsinfo`
--

LOCK TABLES `goodsinfo` WRITE;
/*!40000 ALTER TABLE `goodsinfo` DISABLE KEYS */;
INSERT INTO `goodsinfo` VALUES ('GDS01','노트','01',2000,'Y','2022-03-01 14:42:44',NULL),('GDS02','연필','02',100,'Y','2022-03-01 14:43:17',NULL),('GDS03','복사지','03',5000,'Y','2022-03-01 14:43:47',NULL),('GDS04','볼펜','02',500,'Y','2022-03-01 14:44:13',NULL),('GDS05','네임펜','02',1000,'Y','2022-03-01 14:44:30',NULL),('GDS06','크레파스','02',1500,'Y','2022-03-01 14:45:30',NULL);
/*!40000 ALTER TABLE `goodsinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j`
--

DROP TABLE IF EXISTS `j`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `j` (
  `jno` varchar(5) NOT NULL,
  `jname` varchar(10) DEFAULT NULL,
  `city` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`jno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j`
--

LOCK TABLES `j` WRITE;
/*!40000 ALTER TABLE `j` DISABLE KEYS */;
INSERT INTO `j` VALUES ('J1','PRJ1','LONDON'),('J2','PRJ2','CHINA'),('J3','PRJ3','CHINA'),('J4','PRJ4','INDIA');
/*!40000 ALTER TABLE `j` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `memid` varchar(10) NOT NULL,
  `memname` varchar(20) NOT NULL,
  `passwd` varchar(128) DEFAULT NULL,
  `passwdmdt` datetime DEFAULT NULL,
  `jumin` varchar(64) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `jobcd` char(1) DEFAULT NULL,
  `mileage` decimal(7,0) unsigned DEFAULT '0',
  `stat` enum('Y','N') DEFAULT 'Y',
  `enterdtm` datetime DEFAULT NULL,
  `leavedtm` datetime DEFAULT NULL,
  PRIMARY KEY (`memid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES ('hong1','홍길동',NULL,NULL,NULL,'인천 동구 송림동','2000-05-08','2',500,'Y','2022-03-01 14:10:27',NULL),('hong2','홍길동',NULL,NULL,NULL,'서울 강남구 신사동','1990-01-05','9',1000,'Y','2022-03-01 14:11:50',NULL),('kim1','김갑수',NULL,NULL,NULL,'인천 연수구 연수동','2003-07-01','1',0,'Y','2022-03-01 14:12:39',NULL),('park','박기자',NULL,NULL,NULL,'경기 부천시','2002-09-30','3',0,'Y','2022-03-01 14:13:16',NULL),('seo','서갑돌',NULL,NULL,NULL,'인천 동구','1998-03-10','1',0,'Y','2022-03-01 14:08:41',NULL),('Taeh','태현',NULL,NULL,NULL,'경기 수원시','2002-10-15','4',0,'Y','2022-03-01 14:15:10',NULL);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `p`
--

DROP TABLE IF EXISTS `p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p` (
  `pno` varchar(5) NOT NULL,
  `pname` varchar(10) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `city` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `p`
--

LOCK TABLES `p` WRITE;
/*!40000 ALTER TABLE `p` DISABLE KEYS */;
INSERT INTO `p` VALUES ('P1','PARTA','RED',45,'NEW YORK'),('P2','PARTB','WHITE',4,'LONDON'),('P3','PARTC','GREY',24,'CHINA'),('P4','PARTD','CYCAN',16,'CHINA'),('P5','PARTE','BLACK',58,'NEW YORK');
/*!40000 ALTER TABLE `p` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s`
--

DROP TABLE IF EXISTS `s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s` (
  `sno` varchar(5) NOT NULL,
  `sname` varchar(15) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `city` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s`
--

LOCK TABLES `s` WRITE;
/*!40000 ALTER TABLE `s` DISABLE KEYS */;
INSERT INTO `s` VALUES ('S1','KRUNAL',10,'LONDON'),('S2','RAMESH',5,'INDIA'),('S3','VIVEK',4,'LONDON'),('S4','VIMAL',3,'JAPAN'),('S5','HEMAL',10,'KORIA'),('S6','RAJU',2,'CHINA'),('S7','VINU',3,'CHINA');
/*!40000 ALTER TABLE `s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spj`
--

DROP TABLE IF EXISTS `spj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spj` (
  `sno` varchar(5) NOT NULL,
  `pno` varchar(5) NOT NULL,
  `jno` varchar(5) NOT NULL,
  `qty` int DEFAULT NULL,
  PRIMARY KEY (`sno`,`pno`,`jno`),
  KEY `fk_spj_p_idx` (`pno`),
  KEY `fk_spj_j1_idx` (`jno`),
  CONSTRAINT `fk_spj_j1` FOREIGN KEY (`jno`) REFERENCES `j` (`jno`),
  CONSTRAINT `fk_spj_p` FOREIGN KEY (`pno`) REFERENCES `p` (`pno`),
  CONSTRAINT `fk_spj_s1` FOREIGN KEY (`sno`) REFERENCES `s` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spj`
--

LOCK TABLES `spj` WRITE;
/*!40000 ALTER TABLE `spj` DISABLE KEYS */;
INSERT INTO `spj` VALUES ('S1','P2','J1',300),('S1','P2','J2',800),('S1','P3','J4',75),('S3','P4','J3',115),('S4','P2','J4',130);
/*!40000 ALTER TABLE `spj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db0217'
--

--
-- Dumping routines for database 'db0217'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-09 14:31:36
