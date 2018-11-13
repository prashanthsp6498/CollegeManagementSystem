-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: collegeManagementSystem
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `usn` varchar(50) DEFAULT NULL,
  `subject_name` varchar(30) DEFAULT NULL,
  `total_present` int(11) DEFAULT NULL,
  `total_class` int(11) DEFAULT NULL,
  KEY `usn` (`usn`),
  KEY `subject_name` (`subject_name`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`usn`) REFERENCES `student` (`usn`) ON DELETE CASCADE,
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`subject_name`) REFERENCES `subjects` (`subject_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES ('4mn16cs001','computer networks',1,2),('4mn16cs001','dbms',1,2),('4mn16cs001','management',1,2),('4mn16cs001','oo modeling and design',1,2),('4mn16cs001','DotNet',1,2),('4mn16cs001','finite automata',1,2),('4mn16cs001','computer networks lab',1,2),('4mn16cs001','dbms lab',1,2),('4mn16cs002','computer networks',NULL,NULL),('4mn16cs002','dbms',NULL,NULL),('4mn16cs002','management',NULL,NULL),('4mn16cs002','oo modeling and design',NULL,NULL),('4mn16cs002','DotNet',NULL,NULL),('4mn16cs002','finite automata',NULL,NULL),('4mn16cs002','computer networks lab',NULL,NULL),('4mn16cs002','dbms lab',NULL,NULL),('4mn16cs003','computer networks',NULL,NULL),('4mn16cs003','dbms',NULL,NULL),('4mn16cs003','management',NULL,NULL),('4mn16cs003','oo modeling and design',NULL,NULL),('4mn16cs003','DotNet',NULL,NULL),('4mn16cs003','finite automata',NULL,NULL),('4mn16cs003','computer networks lab',NULL,NULL),('4mn16cs003','dbms lab',NULL,NULL),('4mn16cs004','computer networks',NULL,NULL),('4mn16cs004','dbms',NULL,NULL),('4mn16cs004','management',NULL,NULL),('4mn16cs004','oo modeling and design',NULL,NULL),('4mn16cs004','DotNet',NULL,NULL),('4mn16cs004','finite automata',NULL,NULL),('4mn16cs004','computer networks lab',NULL,NULL),('4mn16cs004','dbms lab',NULL,NULL),('4mn16cs031','computer networks',20,20),('4mn16cs031','dbms',25,26),('4mn16cs031','management',20,21),('4mn16cs031','oo modeling and design',19,20),('4mn16cs031','DotNet',25,25),('4mn16cs031','finite automata',20,21),('4mn16cs031','computer networks lab',19,21),('4mn16cs031','dbms lab',15,15);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dep_name` varchar(30) NOT NULL,
  PRIMARY KEY (`dep_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('civil'),('cse'),('ece'),('ise'),('mech');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marks`
--

DROP TABLE IF EXISTS `marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marks` (
  `usn` varchar(30) DEFAULT NULL,
  `subject_name` varchar(30) DEFAULT NULL,
  `internal1` int(10) DEFAULT NULL,
  `internal2` int(10) DEFAULT NULL,
  `internal3` int(10) DEFAULT NULL,
  KEY `usn` (`usn`),
  KEY `subject_name` (`subject_name`),
  CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`usn`) REFERENCES `student` (`usn`) ON DELETE CASCADE,
  CONSTRAINT `marks_ibfk_2` FOREIGN KEY (`subject_name`) REFERENCES `subjects` (`subject_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marks`
--

LOCK TABLES `marks` WRITE;
/*!40000 ALTER TABLE `marks` DISABLE KEYS */;
INSERT INTO `marks` VALUES ('4mn16cs031','finite automata',20,20,20),('4mn16cs002','finite automata',19,18,17),('4mn16cs031','computer networks',20,20,20);
/*!40000 ALTER TABLE `marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `usn` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`usn`),
  KEY `department` (`department`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`dep_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('444asdf','dafjf',8845,8845,'cse','asdf@gmail.com','aawseddrf','M'),('4mn16cs001','Akshay',5,99558844,'cse','akshay@gmail.com','akshay','m'),('4mn16cs002','Abhi',5,98548844,'cse','abhi@gmail.com','abhi','m'),('4mn16cs003','Abhilash',5,78148844,'ise','abhilash@gmail.com','abhilash','m'),('4mn16cs004','Akhila',5,78147844,'ece','akhila@gmail.com','akhila','f'),('4mn16cs031','Prashanth S P',884455,884455,'cse','prashanth.sp98@gmail.com','asswa','M');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `subject_name` varchar(40) NOT NULL,
  `dep_name` varchar(30) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
  PRIMARY KEY (`subject_name`),
  KEY `dep_name` (`dep_name`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`dep_name`) REFERENCES `department` (`dep_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES ('algorithms lab','cse',4),('analysis and design of algorithms','cse',4),('computer networks','cse',5),('computer networks lab','cse',5),('data communication','cse',4),('dbms','cse',5),('dbms lab','cse',5),('DotNet','cse',5),('finite automata','cse',5),('m4','cse',4),('management','cse',5),('microprocessor and controller','cse',4),('microprocessor lab','cse',4),('object oriented concepts','cse',4),('oo modeling and design','cse',5),('software engineering','cse',4);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `empid` varchar(30) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `phone` int(30) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `department` (`department`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`dep_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('asdf456','elon musk',47558,'cse','elon@gmail.com','asdfghjk','M');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-13 16:05:19
