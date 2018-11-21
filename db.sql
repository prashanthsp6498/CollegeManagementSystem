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
  `usn` varchar(40) DEFAULT NULL,
  `subject_name` varchar(80) DEFAULT NULL,
  `total_present` int(11) DEFAULT NULL,
  `total_class` int(11) DEFAULT NULL,
  KEY `subject_name` (`subject_name`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`subject_name`) REFERENCES `subjects` (`subject_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES ('4mn16cs031','DotNet',19,20),('4mn16cs032','DotNet',15,20),('4mn17is001','DotNet',20,20);
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
  `usn` varchar(90) DEFAULT NULL,
  `subject_name` varchar(90) DEFAULT NULL,
  `internal1` int(11) DEFAULT NULL,
  `internal2` int(11) DEFAULT NULL,
  `internal3` int(11) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
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
INSERT INTO `marks` VALUES ('4mn16cs031','DotNet',15,15,15,1),('4mn16cs031','dbms',20,20,20,1),('4mn17is001','DotNet',10,10,10,6);
/*!40000 ALTER TABLE `marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usn` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
  `phone` int(15) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`usn`),
  UNIQUE KEY `id` (`id`),
  KEY `department` (`department`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`dep_name`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'4mn16cs001','Bill gate',5,81239,'cse','bill@gmail.com','bill','male'),(3,'4mn16cs003','akash',5,8844,'cse','akash@gmail.com','akash','male'),(1,'4mn16cs031','Prashanth S P',1,45,'cse','prashanth.sp98@gmail.com','asdf','male'),(5,'4mn16cs032','Punith',5,554455,'cse','punith@gmail.com','4mn16cs032','male'),(4,'4mn16cs040','Sudharshan',5,56622,'cse','sudharshan@gmail.com','4mn16cs040','male'),(6,'4mn17is001','srivathsa',6,4545,'ise','ads@gmail.com','asdf','male');
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empid` varchar(80) NOT NULL,
  `name` varchar(90) DEFAULT NULL,
  `phone` int(15) DEFAULT NULL,
  `department` varchar(90) DEFAULT NULL,
  `email` varchar(90) DEFAULT NULL,
  `password` varchar(90) DEFAULT NULL,
  `gender` varchar(90) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`empid`),
  UNIQUE KEY `id` (`id`),
  KEY `department` (`department`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`dep_name`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'adf','adf',55,'cse','prashanth.sp98@gmail.com','asdf','male',5000);
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

-- Dump completed on 2018-11-21 14:30:40
