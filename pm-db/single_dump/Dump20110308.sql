CREATE DATABASE  IF NOT EXISTS `chiguru2` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `chiguru2`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: chiguru_test
-- ------------------------------------------------------
-- Server version	5.1.51-community

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
-- Table structure for table `code_type`
--

DROP TABLE IF EXISTS `code_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `application_level_indicator` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `parent_code_type_id` int(11) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk64ae464c75ca944a` (`parent_code_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_type`
--

LOCK TABLES `code_type` WRITE;
/*!40000 ALTER TABLE `code_type` DISABLE KEYS */;
INSERT INTO `code_type` VALUES (1,'country','country code type','\0','2010-03-25 00:00:00','system',NULL,1,NULL,NULL,''),(2,'state','state codes','\0','2010-03-25 00:00:00','system',1,1,NULL,NULL,''),(3,'Form of Business','Form of Business','\0','2010-03-25 00:00:00','system',NULL,1,NULL,NULL,''),(4,'Industry Type','Industry Type','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(5,'job_title','Job Title','\0','2010-03-25 00:00:00','system',NULL,1,NULL,NULL,''),(6,'department','Department','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(7,'account category','Account Category','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(8,'account type','account type','','2010-03-25 00:00:00','gudi',7,0,NULL,NULL,''),(9,'share type','share type','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(10,'Filing Frequency','Filing Frequency','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(11,'Installment Frequency','Installment Frequency','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(12,'Filing Reminder Days','Filing Reminder Days','','2010-12-07 00:00:00','system',NULL,2,NULL,NULL,''),(13,'Installment Reminder Days','Installment Reminder Days','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(17,'firm_staff_title_code','Title used by Firm staff','\0','2011-02-11 16:50:51','system',NULL,1,NULL,NULL,''),(18,'Bank','Bank','\0','2011-02-15 00:00:00','system',NULL,0,'system','2011-02-15 05:00:00',''),(19,'SBI','Bank','\0','2011-02-16 01:49:10','system',18,1,NULL,NULL,'\0'),(20,'country','','\0','2011-02-21 06:56:41','system',2,3,NULL,NULL,''),(21,'SBI','','','2011-02-21 07:35:33','system',1,0,NULL,NULL,''),(22,'@$%%^^@^','','','2011-03-01 01:28:04','system',1,3,NULL,NULL,''),(23,'12345@#$%%','','','2011-03-01 08:59:57','system',4,0,NULL,NULL,''),(24,'12345@#$%%','','','2011-03-02 07:43:37','system',NULL,0,NULL,NULL,''),(25,'@$$@$@','1421421','','2011-03-03 03:54:43','system',NULL,0,NULL,NULL,'');
/*!40000 ALTER TABLE `code_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_of_contact`
--

DROP TABLE IF EXISTS `point_of_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_of_contact` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_title` varchar(50) DEFAULT NULL,
  `web_site_address` varchar(100) DEFAULT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `version` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(50) NOT NULL,
  `last_update_user_id` varchar(50) NOT NULL,
  `last_update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `party_site_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contact_point_is_for_party` (`party_id`),
  KEY `fk_point_of_contact_for_account` (`account_id`),
  KEY `fk_point_of_contact_for_site` (`party_site_id`),
  CONSTRAINT `fk_point_of_contact_for_account` FOREIGN KEY (`account_id`) REFERENCES `party_account` (`id`),
  CONSTRAINT `fk_point_of_contact_for_site` FOREIGN KEY (`party_site_id`) REFERENCES `party_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_of_contact`
--

LOCK TABLES `point_of_contact` WRITE;
/*!40000 ALTER TABLE `point_of_contact` DISABLE KEYS */;
INSERT INTO `point_of_contact` VALUES (3,'Anand','CEO',NULL,318,'',0,'2011-02-17 14:45:20','system','system','2011-02-17 14:45:22',51,NULL),(4,'prasad','assistant manager',NULL,345,'',0,'2011-02-17 14:46:18','system','system','2011-02-17 14:46:21',52,NULL),(5,'ranga','Accountant',NULL,345,'',0,'2011-02-17 14:47:57','system','system','2011-02-17 14:47:59',53,NULL),(6,'AnandSharma','accountant',NULL,318,'',0,'2011-02-17 14:56:41','system','system','2011-02-17 14:56:43',54,NULL),(7,'roy','Bank Manager',NULL,345,'',0,'2011-02-18 05:31:10','system','system','2011-02-18 05:31:12',55,NULL),(8,'som','Advacate',NULL,345,'',0,'2011-02-18 05:40:16','system','system','2011-02-18 05:40:18',56,NULL),(9,'roy','officer',NULL,345,'',0,'2011-02-18 05:42:36','system','system','2011-02-18 05:42:39',57,NULL),(10,'rahul','assistant manager',NULL,345,'',0,'2011-02-18 05:44:27','system','system','2011-02-18 05:44:29',58,NULL),(11,'Anand','CEO',NULL,318,'',0,'2011-02-18 05:57:40','system','system','2011-02-18 05:57:42',59,NULL),(12,'prasad','Bank Manager',NULL,345,'',0,'2011-02-18 07:01:20','system','system','2011-02-18 07:01:23',60,NULL),(13,'roy','assistant manager',NULL,345,'',0,'2011-02-18 07:11:17','system','system','2011-02-18 07:11:20',61,NULL),(14,'ranga','Accountant',NULL,345,'',0,'2011-02-18 07:24:02','system','system','2011-02-18 07:24:05',62,NULL),(15,'ranga','Advacate',NULL,345,'',1,'2011-02-18 07:27:32','system','system','2011-02-18 07:29:58',63,NULL),(16,'ranga','Bank Manager',NULL,345,'',0,'2011-02-18 07:35:26','system','system','2011-02-18 07:35:28',64,NULL),(17,'ranga','Bank Manager',NULL,345,'',2,'2011-02-18 07:39:05','system','system','2011-02-18 07:44:46',65,NULL),(18,'rahul','Advacate',NULL,345,'',0,'2011-02-18 07:50:34','system','system','2011-02-18 07:50:37',66,NULL),(19,'rahul','Bank Manager',NULL,345,'',1,'2011-02-18 07:52:24','system','system','2011-02-18 07:53:09',67,NULL),(20,'prasad','Advacate',NULL,345,'',0,'2011-02-18 07:57:31','system','system','2011-02-18 07:57:33',68,NULL),(21,'ranga','assistant manager',NULL,345,'',1,'2011-02-21 06:13:18','system','system','2011-02-21 06:25:58',69,NULL),(22,'prasad','Bank Manager',NULL,345,'',0,'2011-02-21 07:07:54','system','system','2011-02-21 07:08:00',70,NULL),(23,'prasad','Accountant',NULL,345,'',0,'2011-02-21 07:21:46','system','system','2011-02-21 07:21:50',71,NULL),(24,'sudeep','Bank Manager',NULL,345,'',1,'2011-02-21 07:24:16','system','system','2011-02-21 07:25:15',72,NULL),(25,'som','officer',NULL,345,'',0,'2011-02-21 07:26:24','system','system','2011-02-21 07:26:28',73,NULL),(26,'veeresh','loyer',NULL,345,'',0,'2011-02-21 07:28:19','system','system','2011-02-21 07:28:23',74,NULL),(27,'prasad','Bank Manager',NULL,345,'',0,'2011-02-21 07:45:07','system','system','2011-02-21 07:45:11',75,NULL),(28,'prasad','Advacate',NULL,345,'',0,'2011-02-21 08:00:59','system','system','2011-02-21 08:01:06',76,NULL),(29,'roy','Accountant',NULL,345,'',0,'2011-02-21 08:04:31','system','system','2011-02-21 08:04:36',77,NULL),(30,'123@#$dfd','124@#$fdd',NULL,345,'',0,'2011-02-23 13:27:49','system','system','2011-02-23 13:27:50',78,NULL),(31,'1234567890','846432131',NULL,345,'',0,'2011-02-24 13:30:29','system','system','2011-02-24 13:30:30',79,NULL),(32,'1234566','124@#$fdd',NULL,345,'',0,'2011-02-25 05:09:23','system','system','2011-02-25 05:09:24',80,NULL),(33,'124578754','@#$%^&',NULL,345,'',0,'2011-02-25 05:25:49','system','system','2011-02-25 05:25:50',81,NULL),(34,'John Abraham','Manager',NULL,404,'',3,'2011-02-26 23:17:22','system','system','2011-02-26 23:30:27',82,NULL),(36,'John Abraham','Manager',NULL,404,'',5,'2011-02-27 03:06:36','system','system','2011-02-27 05:31:45',84,NULL),(37,'Harsha','TEAM LEADER',NULL,404,'',2,'2011-02-27 06:08:47','system','system','2011-02-27 06:11:18',85,NULL),(40,'123@#$dfd','`1234567',NULL,345,'',1,'2011-03-01 12:27:33','system','system','2011-03-01 12:30:34',88,NULL),(42,'123@#$dfd','`1234567',NULL,345,'',2,'2011-03-01 13:06:14','system','system','2011-03-01 13:06:58',90,NULL),(44,'124354','5352523',NULL,345,'',0,'2011-03-01 13:08:23','system','system','2011-03-01 13:08:27',92,NULL),(48,'','',NULL,415,'',0,'2011-03-01 13:41:25','system','system','2011-03-01 13:41:29',NULL,228),(50,'Harsha','CEO',NULL,404,'',1,'2011-03-01 13:52:17','system','system','2011-03-01 14:00:48',NULL,216),(52,'','',NULL,416,'',1,'2011-03-01 13:53:42','system','system','2011-03-01 13:56:38',NULL,229),(53,'','',NULL,417,'',0,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',NULL,230),(55,'Accenture','Accenture',NULL,419,'',1,'2011-03-01 14:06:09','system','system','2011-03-01 14:12:11',NULL,232),(56,'','',NULL,420,'',0,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',NULL,233),(57,'','',NULL,421,'',0,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',NULL,234),(58,'Sagar Best','Sagar Best',NULL,300,'',0,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',NULL,98),(59,NULL,NULL,NULL,347,'',0,'2011-03-02 04:59:19','system','system','2011-03-02 04:59:21',NULL,146),(61,'','',NULL,423,'',0,'2011-03-02 06:06:35','system','system','2011-03-02 06:06:38',NULL,236),(64,NULL,NULL,NULL,345,'',0,'2011-03-02 12:56:21','system','system','2011-03-02 12:56:23',NULL,143),(67,'prasad','Accountant',NULL,345,'',0,'2011-03-04 06:15:28','system','system','2011-03-04 06:15:29',96,NULL),(68,'roy','Advacate',NULL,345,'',0,'2011-03-04 11:56:40','system','system','2011-03-04 11:56:44',97,NULL),(69,'roy','Advacate',NULL,345,'',2,'2011-03-04 11:56:43','system','system','2011-03-04 12:09:18',98,NULL),(70,NULL,NULL,NULL,348,'',0,'2011-03-08 09:28:50','system','system','2011-03-08 09:28:52',NULL,147),(71,NULL,NULL,NULL,372,'',0,'2011-03-08 09:35:23','system','system','2011-03-08 09:35:24',NULL,176),(72,NULL,NULL,NULL,373,'',0,'2011-03-08 09:36:30','system','system','2011-03-08 09:36:31',NULL,177),(73,NULL,NULL,NULL,424,'',0,'2011-03-08 12:22:20','system','system','2011-03-08 12:22:23',NULL,237),(74,'paru patil','paru patil',NULL,425,'',5,'2011-03-08 13:07:57','system','system','2011-03-08 13:17:09',NULL,238),(75,'raju sanglad','raju sanglad',NULL,426,'',3,'2011-03-08 13:26:51','system','system','2011-03-08 13:28:30',NULL,239),(76,'','',NULL,427,'',0,'2011-03-08 13:57:59','system','system','2011-03-08 13:58:04',NULL,240),(77,'prasad','Bank Manager',NULL,424,'',4,'2011-03-08 14:18:00','system','system','2011-03-08 14:20:13',NULL,241);
/*!40000 ALTER TABLE `point_of_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communication`
--

DROP TABLE IF EXISTS `communication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communication` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contact_detail` varchar(50) NOT NULL,
  `contact_point_id` bigint(20) unsigned NOT NULL,
  `communication_type` smallint(20) unsigned NOT NULL,
  `best_time_to_contact` varchar(50) DEFAULT NULL,
  `preferred_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(50) NOT NULL,
  `last_update_user_id` varchar(50) NOT NULL,
  `last_update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(11) NOT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `sub_type` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comm_is_for_contact_point` (`contact_point_id`),
  KEY `fk_comm_has_comm_type` (`communication_type`),
  CONSTRAINT `fk_comm_has_comm_type` FOREIGN KEY (`communication_type`) REFERENCES `communication_type` (`id`),
  CONSTRAINT `fk_comm_is_for_contact_point` FOREIGN KEY (`contact_point_id`) REFERENCES `point_of_contact` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communication`
--

LOCK TABLES `communication` WRITE;
/*!40000 ALTER TABLE `communication` DISABLE KEYS */;
INSERT INTO `communication` VALUES (1,'24342',3,3,NULL,NULL,'2011-02-17 14:45:20','system','system','2011-02-17 14:45:22',0,'',NULL),(2,'sagar@yahhooo.com',3,1,NULL,NULL,'2011-02-17 14:45:22','system','system','2011-02-17 14:45:22',0,'',NULL),(3,'24',3,2,NULL,NULL,'2011-02-17 14:45:22','system','system','2011-02-17 14:45:22',0,'',NULL),(4,'www.sagar.com',3,7,NULL,NULL,'2011-02-17 14:45:22','system','system','2011-02-17 14:45:22',0,'',NULL),(5,'414143534',4,3,NULL,NULL,'2011-02-17 14:46:18','system','system','2011-02-17 14:46:21',0,'',NULL),(6,'prasad@gmail.com',4,1,NULL,NULL,'2011-02-17 14:46:21','system','system','2011-02-17 14:46:21',0,'',NULL),(7,'',4,2,NULL,NULL,'2011-02-17 14:46:21','system','system','2011-02-17 14:46:21',0,'',NULL),(8,'www.gmail.com',4,7,NULL,NULL,'2011-02-17 14:46:21','system','system','2011-02-17 14:46:21',0,'',NULL),(9,'414143534',5,3,NULL,NULL,'2011-02-17 14:47:57','system','system','2011-02-17 14:47:59',0,'',NULL),(10,'ranga#gmail.com',5,1,NULL,NULL,'2011-02-17 14:47:59','system','system','2011-02-17 14:47:59',0,'',NULL),(11,'124563',5,2,NULL,NULL,'2011-02-17 14:47:59','system','system','2011-02-17 14:47:59',0,'',NULL),(12,'www.gmail.com',5,7,NULL,NULL,'2011-02-17 14:47:59','system','system','2011-02-17 14:47:59',0,'',NULL),(13,'24342',6,3,NULL,NULL,'2011-02-17 14:56:41','system','system','2011-02-17 14:56:43',0,'',NULL),(14,'anada@gmai.com',6,1,NULL,NULL,'2011-02-17 14:56:43','system','system','2011-02-17 14:56:43',0,'',NULL),(15,'34445',6,2,NULL,NULL,'2011-02-17 14:56:43','system','system','2011-02-17 14:56:43',0,'',NULL),(16,'www.test.com',6,7,NULL,NULL,'2011-02-17 14:56:43','system','system','2011-02-17 14:56:43',0,'',NULL),(17,'24569873',7,3,NULL,NULL,'2011-02-18 05:31:10','system','system','2011-02-18 05:31:12',0,'',NULL),(18,'roy@gmail.com',7,1,NULL,NULL,'2011-02-18 05:31:12','system','system','2011-02-18 05:31:12',0,'',NULL),(19,'147856',7,2,NULL,NULL,'2011-02-18 05:31:12','system','system','2011-02-18 05:31:12',0,'',NULL),(20,'www.gmail.com',7,7,NULL,NULL,'2011-02-18 05:31:12','system','system','2011-02-18 05:31:12',0,'',NULL),(21,'4785693',8,3,NULL,NULL,'2011-02-18 05:40:16','system','system','2011-02-18 05:40:18',0,'',NULL),(22,'som@gmail.com',8,1,NULL,NULL,'2011-02-18 05:40:18','system','system','2011-02-18 05:40:18',0,'',NULL),(23,'41257878',8,2,NULL,NULL,'2011-02-18 05:40:18','system','system','2011-02-18 05:40:18',0,'',NULL),(24,'www.gmail.com',8,7,NULL,NULL,'2011-02-18 05:40:18','system','system','2011-02-18 05:40:18',0,'',NULL),(25,'414143534',9,3,NULL,NULL,'2011-02-18 05:42:36','system','system','2011-02-18 05:42:39',0,'',NULL),(26,'roy@gmail.com',9,1,NULL,NULL,'2011-02-18 05:42:39','system','system','2011-02-18 05:42:39',0,'',NULL),(27,'',9,2,NULL,NULL,'2011-02-18 05:42:39','system','system','2011-02-18 05:42:39',0,'',NULL),(28,'www.gmail.com',9,7,NULL,NULL,'2011-02-18 05:42:39','system','system','2011-02-18 05:42:39',0,'',NULL),(29,'4785693',10,3,NULL,NULL,'2011-02-18 05:44:27','system','system','2011-02-18 05:44:29',0,'',NULL),(30,'rahhul@yahoo.com',10,1,NULL,NULL,'2011-02-18 05:44:29','system','system','2011-02-18 05:44:29',0,'',NULL),(31,'',10,2,NULL,NULL,'2011-02-18 05:44:29','system','system','2011-02-18 05:44:29',0,'',NULL),(32,'www.gmail.com',10,7,NULL,NULL,'2011-02-18 05:44:29','system','system','2011-02-18 05:44:29',0,'',NULL),(33,'24342',11,3,NULL,NULL,'2011-02-18 05:57:40','system','system','2011-02-18 05:57:42',0,'',NULL),(34,'sagar@yahhooo.com',11,1,NULL,NULL,'2011-02-18 05:57:42','system','system','2011-02-18 05:57:42',0,'',NULL),(35,'34445',11,2,NULL,NULL,'2011-02-18 05:57:42','system','system','2011-02-18 05:57:42',0,'',NULL),(36,'www.sagar.com',11,7,NULL,NULL,'2011-02-18 05:57:42','system','system','2011-02-18 05:57:42',0,'',NULL),(37,'414143534',12,3,NULL,NULL,'2011-02-18 07:01:20','system','system','2011-02-18 07:01:23',0,'',NULL),(38,'prasad#gmail.com',12,1,NULL,NULL,'2011-02-18 07:01:23','system','system','2011-02-18 07:01:23',0,'',NULL),(39,'33533353',12,2,NULL,NULL,'2011-02-18 07:01:23','system','system','2011-02-18 07:01:23',0,'',NULL),(40,'www.gmail.com',12,7,NULL,NULL,'2011-02-18 07:01:23','system','system','2011-02-18 07:01:23',0,'',NULL),(41,'',13,3,NULL,NULL,'2011-02-18 07:11:17','system','system','2011-02-18 07:11:20',0,'',NULL),(42,'',13,1,NULL,NULL,'2011-02-18 07:11:20','system','system','2011-02-18 07:11:20',0,'',NULL),(43,'',13,2,NULL,NULL,'2011-02-18 07:11:20','system','system','2011-02-18 07:11:20',0,'',NULL),(44,'',13,7,NULL,NULL,'2011-02-18 07:11:20','system','system','2011-02-18 07:11:20',0,'',NULL),(45,'',14,3,NULL,NULL,'2011-02-18 07:24:02','system','system','2011-02-18 07:24:05',0,'',NULL),(46,'',14,1,NULL,NULL,'2011-02-18 07:24:05','system','system','2011-02-18 07:24:05',0,'',NULL),(47,'',14,2,NULL,NULL,'2011-02-18 07:24:05','system','system','2011-02-18 07:24:05',0,'',NULL),(48,'',14,7,NULL,NULL,'2011-02-18 07:24:05','system','system','2011-02-18 07:24:05',0,'',NULL),(49,'414143534',15,3,NULL,NULL,'2011-02-18 07:27:32','system','system','2011-02-18 07:29:58',1,'',NULL),(50,'ranga#gmail.com',15,1,NULL,NULL,'2011-02-18 07:27:35','system','system','2011-02-18 07:29:58',1,'',NULL),(51,'14247',15,2,NULL,NULL,'2011-02-18 07:27:35','system','system','2011-02-18 07:29:58',1,'',NULL),(52,'www.gmail.com',15,7,NULL,NULL,'2011-02-18 07:27:35','system','system','2011-02-18 07:29:58',1,'',NULL),(53,'',16,3,NULL,NULL,'2011-02-18 07:35:26','system','system','2011-02-18 07:35:28',0,'',NULL),(54,'',16,1,NULL,NULL,'2011-02-18 07:35:28','system','system','2011-02-18 07:35:28',0,'',NULL),(55,'',16,2,NULL,NULL,'2011-02-18 07:35:28','system','system','2011-02-18 07:35:28',0,'',NULL),(56,'',16,7,NULL,NULL,'2011-02-18 07:35:28','system','system','2011-02-18 07:35:28',0,'',NULL),(57,'',17,3,NULL,NULL,'2011-02-18 07:39:05','system','system','2011-02-18 07:44:46',2,'',NULL),(58,'',17,1,NULL,NULL,'2011-02-18 07:39:07','system','system','2011-02-18 07:44:46',2,'',NULL),(59,'',17,2,NULL,NULL,'2011-02-18 07:39:07','system','system','2011-02-18 07:44:46',2,'',NULL),(60,'',17,7,NULL,NULL,'2011-02-18 07:39:07','system','system','2011-02-18 07:44:46',2,'',NULL),(61,'24569873',18,3,NULL,NULL,'2011-02-18 07:50:34','system','system','2011-02-18 07:50:37',0,'',NULL),(62,'rahhul@yahoo.com',18,1,NULL,NULL,'2011-02-18 07:50:37','system','system','2011-02-18 07:50:37',0,'',NULL),(63,'124563',18,2,NULL,NULL,'2011-02-18 07:50:37','system','system','2011-02-18 07:50:37',0,'',NULL),(64,'www.yhoo.com',18,7,NULL,NULL,'2011-02-18 07:50:37','system','system','2011-02-18 07:50:37',0,'',NULL),(65,'',19,3,NULL,NULL,'2011-02-18 07:52:24','system','system','2011-02-18 07:53:09',1,'',NULL),(66,'',19,1,NULL,NULL,'2011-02-18 07:52:26','system','system','2011-02-18 07:53:09',1,'',NULL),(67,'14545',19,2,NULL,NULL,'2011-02-18 07:52:26','system','system','2011-02-18 07:53:09',1,'',NULL),(68,'',19,7,NULL,NULL,'2011-02-18 07:52:26','system','system','2011-02-18 07:53:09',1,'',NULL),(69,'',20,3,NULL,NULL,'2011-02-18 07:57:31','system','system','2011-02-18 07:57:33',0,'',NULL),(70,'',20,1,NULL,NULL,'2011-02-18 07:57:33','system','system','2011-02-18 07:57:33',0,'',NULL),(71,'',20,2,NULL,NULL,'2011-02-18 07:57:33','system','system','2011-02-18 07:57:33',0,'',NULL),(72,'',20,7,NULL,NULL,'2011-02-18 07:57:33','system','system','2011-02-18 07:57:33',0,'',NULL),(73,'',21,3,NULL,NULL,'2011-02-21 06:13:19','system','system','2011-02-21 06:25:58',1,'',NULL),(74,'ranga#gmail.com',21,1,NULL,NULL,'2011-02-21 06:13:21','system','system','2011-02-21 06:25:58',1,'',NULL),(75,'',21,2,NULL,NULL,'2011-02-21 06:13:21','system','system','2011-02-21 06:25:58',1,'',NULL),(76,'',21,7,NULL,NULL,'2011-02-21 06:13:21','system','system','2011-02-21 06:25:58',1,'',NULL),(77,'414143534',22,3,NULL,NULL,'2011-02-21 07:07:54','system','system','2011-02-21 07:08:00',0,'',NULL),(78,'prasad@gmail.com',22,1,NULL,NULL,'2011-02-21 07:08:00','system','system','2011-02-21 07:08:00',0,'',NULL),(79,'124563',22,2,NULL,NULL,'2011-02-21 07:08:00','system','system','2011-02-21 07:08:00',0,'',NULL),(80,'www.yahoo.com',22,7,NULL,NULL,'2011-02-21 07:08:00','system','system','2011-02-21 07:08:00',0,'',NULL),(81,'',23,3,NULL,NULL,'2011-02-21 07:21:46','system','system','2011-02-21 07:21:50',0,'',NULL),(82,'',23,1,NULL,NULL,'2011-02-21 07:21:50','system','system','2011-02-21 07:21:50',0,'',NULL),(83,'',23,2,NULL,NULL,'2011-02-21 07:21:50','system','system','2011-02-21 07:21:50',0,'',NULL),(84,'',23,7,NULL,NULL,'2011-02-21 07:21:50','system','system','2011-02-21 07:21:50',0,'',NULL),(85,'45789658',24,3,NULL,NULL,'2011-02-21 07:24:17','system','system','2011-02-21 07:25:15',1,'',NULL),(86,'sandeep@gmail.com',24,1,NULL,NULL,'2011-02-21 07:24:21','system','system','2011-02-21 07:25:15',1,'',NULL),(87,'21457892',24,2,NULL,NULL,'2011-02-21 07:24:21','system','system','2011-02-21 07:25:15',1,'',NULL),(88,'www.gmail.com',24,7,NULL,NULL,'2011-02-21 07:24:21','system','system','2011-02-21 07:25:15',1,'',NULL),(89,'',25,3,NULL,NULL,'2011-02-21 07:26:24','system','system','2011-02-21 07:26:28',0,'',NULL),(90,'',25,1,NULL,NULL,'2011-02-21 07:26:28','system','system','2011-02-21 07:26:28',0,'',NULL),(91,'',25,2,NULL,NULL,'2011-02-21 07:26:28','system','system','2011-02-21 07:26:28',0,'',NULL),(92,'',25,7,NULL,NULL,'2011-02-21 07:26:28','system','system','2011-02-21 07:26:28',0,'',NULL),(93,'',26,3,NULL,NULL,'2011-02-21 07:28:19','system','system','2011-02-21 07:28:23',0,'',NULL),(94,'',26,1,NULL,NULL,'2011-02-21 07:28:23','system','system','2011-02-21 07:28:23',0,'',NULL),(95,'',26,2,NULL,NULL,'2011-02-21 07:28:23','system','system','2011-02-21 07:28:23',0,'',NULL),(96,'',26,7,NULL,NULL,'2011-02-21 07:28:23','system','system','2011-02-21 07:28:23',0,'',NULL),(97,'',27,3,NULL,NULL,'2011-02-21 07:45:07','system','system','2011-02-21 07:45:11',0,'',NULL),(98,'',27,1,NULL,NULL,'2011-02-21 07:45:11','system','system','2011-02-21 07:45:11',0,'',NULL),(99,'',27,2,NULL,NULL,'2011-02-21 07:45:11','system','system','2011-02-21 07:45:11',0,'',NULL),(100,'',27,7,NULL,NULL,'2011-02-21 07:45:11','system','system','2011-02-21 07:45:11',0,'',NULL),(101,'',28,3,NULL,NULL,'2011-02-21 08:00:59','system','system','2011-02-21 08:01:06',0,'',NULL),(102,'',28,1,NULL,NULL,'2011-02-21 08:01:06','system','system','2011-02-21 08:01:06',0,'',NULL),(103,'',28,2,NULL,NULL,'2011-02-21 08:01:06','system','system','2011-02-21 08:01:06',0,'',NULL),(104,'',28,7,NULL,NULL,'2011-02-21 08:01:06','system','system','2011-02-21 08:01:06',0,'',NULL),(105,'',29,3,NULL,NULL,'2011-02-21 08:04:31','system','system','2011-02-21 08:04:36',0,'',NULL),(106,'',29,1,NULL,NULL,'2011-02-21 08:04:36','system','system','2011-02-21 08:04:36',0,'',NULL),(107,'',29,2,NULL,NULL,'2011-02-21 08:04:36','system','system','2011-02-21 08:04:36',0,'',NULL),(108,'',29,7,NULL,NULL,'2011-02-21 08:04:36','system','system','2011-02-21 08:04:36',0,'',NULL),(109,'',30,3,NULL,NULL,'2011-02-23 13:27:49','system','system','2011-02-23 13:27:50',0,'',NULL),(110,'',30,1,NULL,NULL,'2011-02-23 13:27:50','system','system','2011-02-23 13:27:50',0,'',NULL),(111,'',30,2,NULL,NULL,'2011-02-23 13:27:50','system','system','2011-02-23 13:27:50',0,'',NULL),(112,'',30,7,NULL,NULL,'2011-02-23 13:27:50','system','system','2011-02-23 13:27:50',0,'',NULL),(113,'2451247856314',31,3,NULL,NULL,'2011-02-24 13:30:29','system','system','2011-02-24 13:30:30',0,'',NULL),(114,'2418419',31,1,NULL,NULL,'2011-02-24 13:30:30','system','system','2011-02-24 13:30:30',0,'',NULL),(115,'1243645',31,2,NULL,NULL,'2011-02-24 13:30:30','system','system','2011-02-24 13:30:30',0,'',NULL),(116,'2314368760',31,7,NULL,NULL,'2011-02-24 13:30:30','system','system','2011-02-24 13:30:30',0,'',NULL),(117,'dsgfhgfjfj',32,3,NULL,NULL,'2011-02-25 05:09:23','system','system','2011-02-25 05:09:24',0,'',NULL),(118,'21726526718',32,1,NULL,NULL,'2011-02-25 05:09:24','system','system','2011-02-25 05:09:24',0,'',NULL),(119,'agffgjfj',32,2,NULL,NULL,'2011-02-25 05:09:24','system','system','2011-02-25 05:09:24',0,'',NULL),(120,'as123@#$%',32,7,NULL,NULL,'2011-02-25 05:09:24','system','system','2011-02-25 05:09:24',0,'',NULL),(121,'fzhfzhrtes',33,3,NULL,NULL,'2011-02-25 05:25:49','system','system','2011-02-25 05:25:50',0,'',NULL),(122,'1245W#$%',33,1,NULL,NULL,'2011-02-25 05:25:50','system','system','2011-02-25 05:25:50',0,'',NULL),(123,'fggfgfg',33,2,NULL,NULL,'2011-02-25 05:25:50','system','system','2011-02-25 05:25:50',0,'',NULL),(124,'143564677',33,7,NULL,NULL,'2011-02-25 05:25:50','system','system','2011-02-25 05:25:50',0,'',NULL),(125,'703-111-1234',34,3,NULL,NULL,'2011-02-26 23:17:22','system','system','2011-02-26 23:30:27',3,'',NULL),(126,'john@citi.com,301-123-45678',34,1,NULL,NULL,'2011-02-26 23:17:23','system','system','2011-02-26 23:30:27',3,'',NULL),(127,'999-1234',34,2,NULL,NULL,'2011-02-26 23:17:23','system','system','2011-02-26 23:30:27',3,'',NULL),(128,'www.citi.com',34,7,NULL,NULL,'2011-02-26 23:17:23','system','system','2011-02-26 23:30:27',3,'',NULL),(129,'raja@raja.com',36,1,NULL,NULL,'2011-02-27 03:06:38','system','system','2011-02-27 05:31:45',5,'',NULL),(130,'1-888-999-1234',36,2,NULL,NULL,'2011-02-27 03:06:38','system','system','2011-02-27 05:31:45',5,'',NULL),(131,'703-111-1234',36,3,NULL,NULL,'2011-02-27 03:06:38','system','system','2011-02-27 05:31:45',5,'',3),(132,'www.boi.com',36,7,NULL,NULL,'2011-02-27 03:06:38','system','system','2011-02-27 05:31:45',5,'',NULL),(133,'703-222-2345',36,3,NULL,NULL,'2011-02-27 03:34:09','system','system','2011-02-27 05:31:45',4,'',5),(135,'301-222-3456',36,3,NULL,NULL,'2011-02-27 05:31:45','system','system','2011-02-27 05:31:45',0,'',4),(136,'harsh@gmail.com',37,1,NULL,NULL,'2011-02-27 06:08:49','system','system','2011-02-27 06:11:18',2,'',NULL),(137,'2222',37,2,NULL,NULL,'2011-02-27 06:08:49','system','system','2011-02-27 06:11:18',2,'',NULL),(138,'2222',37,3,NULL,NULL,'2011-02-27 06:08:49','system','system','2011-02-27 06:11:18',2,'',3),(140,'www.iAutomobile.com',37,7,NULL,NULL,'2011-02-27 06:08:49','system','system','2011-02-27 06:11:18',2,'',NULL),(145,'1234567',40,1,NULL,NULL,'2011-03-01 12:27:35','system','system','2011-03-01 12:30:34',1,'',NULL),(146,'sdfghjk',40,2,NULL,NULL,'2011-03-01 12:27:35','system','system','2011-03-01 12:30:34',1,'',NULL),(147,'sdfvgbhnjmk,',40,3,NULL,NULL,'2011-03-01 12:27:35','system','system','2011-03-01 12:30:34',1,'',3),(148,'##%#%#%#%',40,7,NULL,NULL,'2011-03-01 12:27:35','system','system','2011-03-01 12:30:34',1,'',NULL),(151,'21435678',42,1,NULL,NULL,'2011-03-01 13:06:15','system','system','2011-03-01 13:06:58',2,'',NULL),(152,'nlnkkjhgfd',42,2,NULL,NULL,'2011-03-01 13:06:15','system','system','2011-03-01 13:06:58',2,'',NULL),(153,'qertwtwet',42,3,NULL,NULL,'2011-03-01 13:06:15','system','system','2011-03-01 13:06:58',2,'',3),(154,'2144325345',42,7,NULL,NULL,'2011-03-01 13:06:15','system','system','2011-03-01 13:06:58',2,'',NULL),(157,'14325425',44,1,NULL,NULL,'2011-03-01 13:08:27','system','system','2011-03-01 13:08:27',0,'',NULL),(158,'53532',44,2,NULL,NULL,'2011-03-01 13:08:27','system','system','2011-03-01 13:08:27',0,'',NULL),(159,'',44,3,NULL,NULL,'2011-03-01 13:08:27','system','system','2011-03-01 13:08:27',0,'',3),(160,'355',44,7,NULL,NULL,'2011-03-01 13:08:27','system','system','2011-03-01 13:08:27',0,'',NULL),(167,'34244345',48,1,NULL,NULL,'2011-03-01 13:41:25','system','system','2011-03-01 13:41:29',0,'',NULL),(168,'121133',48,2,NULL,NULL,'2011-03-01 13:41:25','system','system','2011-03-01 13:41:29',0,'',NULL),(169,'afasdfdf',48,3,NULL,NULL,'2011-03-01 13:41:25','system','system','2011-03-01 13:41:29',0,'',3),(170,'www.default.com',48,7,NULL,NULL,'2011-03-01 13:41:25','system','system','2011-03-01 13:41:29',0,'',NULL),(175,'tanveer@gamil.om',52,1,NULL,NULL,'2011-03-01 13:53:42','system','system','2011-03-01 13:56:38',1,'',NULL),(176,'2222',52,2,NULL,NULL,'2011-03-01 13:53:42','system','system','2011-03-01 13:56:38',1,'',NULL),(177,'2222',52,3,NULL,NULL,'2011-03-01 13:53:43','system','system','2011-03-01 13:53:46',0,'',3),(178,'2222',52,3,NULL,NULL,'2011-03-01 13:53:43','system','system','2011-03-01 13:53:46',0,'',4),(179,'www.default.com',52,7,NULL,NULL,'2011-03-01 13:53:43','system','system','2011-03-01 13:56:38',1,'',NULL),(182,'harsh@gmail.com',50,1,NULL,NULL,'2011-03-01 14:00:47','system','system','2011-03-01 14:00:48',0,'',NULL),(183,'2222',50,2,NULL,NULL,'2011-03-01 14:00:47','system','system','2011-03-01 14:00:48',0,'',NULL),(184,'2222',50,3,NULL,NULL,'2011-03-01 14:00:48','system','system','2011-03-01 14:00:48',0,'',3),(185,'www.saiAutomobile.com',50,7,NULL,NULL,'2011-03-01 14:00:47','system','system','2011-03-01 14:00:48',0,'',NULL),(186,'tanveer@gamil.om',53,1,NULL,NULL,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',0,'',NULL),(187,'2222',53,2,NULL,NULL,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',0,'',NULL),(188,'2222',53,3,NULL,NULL,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',0,'',3),(189,'2222',53,3,NULL,NULL,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',0,'',4),(190,'www.default.com',53,7,NULL,NULL,'2011-03-01 14:02:16','system','system','2011-03-01 14:02:20',0,'',NULL),(193,'accenture@gmail.com',55,1,NULL,NULL,'2011-03-01 14:06:09','system','system','2011-03-01 14:12:11',1,'',NULL),(194,'2222',55,2,NULL,NULL,'2011-03-01 14:06:09','system','system','2011-03-01 14:12:11',1,'',NULL),(195,'2222',55,3,NULL,NULL,'2011-03-01 14:06:09','system','system','2011-03-01 14:12:11',1,'',4),(196,'www.default.com',55,7,NULL,NULL,'2011-03-01 14:06:09','system','system','2011-03-01 14:12:11',1,'',NULL),(197,'tanveer@gamil.om',56,1,NULL,NULL,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',0,'',NULL),(198,'2222',56,2,NULL,NULL,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',0,'',NULL),(199,'2222',56,3,NULL,NULL,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',0,'',3),(200,'2222',56,3,NULL,NULL,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',0,'',4),(201,'www.default.com',56,7,NULL,NULL,'2011-03-01 14:07:54','system','system','2011-03-01 14:07:58',0,'',NULL),(202,'2222',55,3,NULL,NULL,'2011-03-01 14:12:07','system','system','2011-03-01 14:12:11',0,'',3),(203,'preety@gmail.com',57,1,NULL,NULL,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',0,'',NULL),(204,'4444',57,2,NULL,NULL,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',0,'',NULL),(205,'4444',57,3,NULL,NULL,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',0,'',3),(206,'4444',57,3,NULL,NULL,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',0,'',4),(207,'www.default.com',57,7,NULL,NULL,'2011-03-02 03:57:09','system','system','2011-03-02 03:57:13',0,'',NULL),(208,'sagar@gmail.com',58,1,NULL,NULL,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',0,'',NULL),(209,'5555',58,2,NULL,NULL,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',0,'',NULL),(210,'5555',58,3,NULL,NULL,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',0,'',3),(211,'5555',58,3,NULL,NULL,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',0,'',4),(212,'www.default.com',58,7,NULL,NULL,'2011-03-02 04:09:08','system','system','2011-03-02 04:09:10',0,'',NULL),(215,'143435535',61,1,NULL,NULL,'2011-03-02 06:06:35','system','system','2011-03-02 06:06:38',0,'',NULL),(216,'535532535',61,2,NULL,NULL,'2011-03-02 06:06:35','system','system','2011-03-02 06:06:38',0,'',NULL),(217,'asaffs',61,3,NULL,NULL,'2011-03-02 06:06:35','system','system','2011-03-02 06:06:38',0,'',3),(218,'www.default.com',61,7,NULL,NULL,'2011-03-02 06:06:35','system','system','2011-03-02 06:06:38',0,'',NULL),(227,'aad@d.Com',67,1,NULL,NULL,'2011-03-04 06:15:29','system','system','2011-03-04 06:15:29',0,'',NULL),(228,'53532',67,2,NULL,NULL,'2011-03-04 06:15:29','system','system','2011-03-04 06:15:29',0,'',NULL),(229,'245474557',67,3,NULL,NULL,'2011-03-04 06:15:29','system','system','2011-03-04 06:15:29',0,'',3),(230,'www.sf.com',67,7,NULL,NULL,'2011-03-04 06:15:29','system','system','2011-03-04 06:15:29',0,'',NULL),(231,'aad@d.Com',68,1,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 11:56:44',0,'',NULL),(232,'53532',68,2,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 11:56:44',0,'',NULL),(233,'245474557',68,3,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 11:56:44',0,'',3),(234,'www.sf.com',68,7,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 11:56:44',0,'',NULL),(235,'aad@d.Com',69,1,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 12:09:18',2,'',NULL),(236,'53532',69,2,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 12:09:18',2,'',NULL),(237,'245474557',69,3,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 12:09:18',2,'',3),(238,'www.sf.com',69,7,NULL,NULL,'2011-03-04 11:56:44','system','system','2011-03-04 12:09:18',2,'',NULL),(239,'aa@rt.com',74,1,NULL,NULL,'2011-03-08 13:07:57','system','system','2011-03-08 13:17:09',5,'',NULL),(240,'123-234-1234',74,2,NULL,NULL,'2011-03-08 13:07:57','system','system','2011-03-08 13:17:09',5,'',NULL),(241,'322-221-2121',74,3,NULL,NULL,'2011-03-08 13:07:57','system','system','2011-03-08 13:17:09',5,'',3),(242,'www.default.com',74,7,NULL,NULL,'2011-03-08 13:07:57','system','system','2011-03-08 13:17:09',5,'',NULL),(243,'123-132-2332',74,3,NULL,NULL,'2011-03-08 13:16:10','system','system','2011-03-08 13:17:09',1,'',4),(244,'aa@rt.com',75,1,NULL,NULL,'2011-03-08 13:26:51','system','system','2011-03-08 13:28:30',3,'',NULL),(245,'123-234-1234',75,2,NULL,NULL,'2011-03-08 13:26:51','system','system','2011-03-08 13:28:30',3,'',NULL),(246,'124-444-2141',75,3,NULL,NULL,'2011-03-08 13:26:51','system','system','2011-03-08 13:28:30',3,'',3),(248,'www.default.com',75,7,NULL,NULL,'2011-03-08 13:26:51','system','system','2011-03-08 13:28:30',3,'',NULL),(249,'433-322-2424',75,3,NULL,NULL,'2011-03-08 13:28:28','system','system','2011-03-08 13:28:30',0,'',4),(250,'aa@rt.com',76,1,NULL,NULL,'2011-03-08 13:57:59','system','system','2011-03-08 13:58:04',0,'',NULL),(251,'123-234-1234',76,2,NULL,NULL,'2011-03-08 13:57:59','system','system','2011-03-08 13:58:04',0,'',NULL),(252,'124-444-2141',76,3,NULL,NULL,'2011-03-08 13:57:59','system','system','2011-03-08 13:58:04',0,'',3),(253,'www.default.com',76,7,NULL,NULL,'2011-03-08 13:57:59','system','system','2011-03-08 13:58:04',0,'',NULL),(254,'aad@d.Com',77,1,NULL,NULL,'2011-03-08 14:18:00','system','system','2011-03-08 14:20:13',4,'',NULL),(255,'112-231-2424',77,2,NULL,NULL,'2011-03-08 14:18:00','system','system','2011-03-08 14:20:13',4,'',NULL),(256,'123-333-2345',77,3,NULL,NULL,'2011-03-08 14:18:00','system','system','2011-03-08 14:20:13',4,'',3),(257,'123afff@bfb.com',77,7,NULL,NULL,'2011-03-08 14:18:00','system','system','2011-03-08 14:20:13',4,'',NULL),(259,'333-124-1343',77,3,NULL,NULL,'2011-03-08 14:20:13','system','system','2011-03-08 14:20:13',0,'',4);
/*!40000 ALTER TABLE `communication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jurisdiction`
--

DROP TABLE IF EXISTS `jurisdiction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurisdiction` (
  `id` mediumint(8) unsigned NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(25) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `country_code` bigint(20) unsigned DEFAULT NULL,
  `state_code` bigint(20) unsigned DEFAULT NULL,
  `timezone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurisdiction`
--

LOCK TABLES `jurisdiction` WRITE;
/*!40000 ALTER TABLE `jurisdiction` DISABLE KEYS */;
INSERT INTO `jurisdiction` VALUES (1,'usa','va','fairfax','fairfax','',NULL,NULL,NULL,NULL,0,NULL,NULL,1),(2,'usa','va','fairfax','falls church','',NULL,NULL,NULL,NULL,0,NULL,NULL,1),(3,'canada','bc',NULL,'vancuar','',NULL,NULL,NULL,NULL,0,NULL,NULL,2),(4,'canada','mo','vo','toronto','',NULL,'system',NULL,NULL,1,NULL,NULL,1),(5,'India','karnataka','India','Bangalore','','2011-02-02 14:46:25','system',NULL,NULL,0,NULL,NULL,2),(6,'canada','co','vo','toronto','','2011-02-02 14:52:26','system',NULL,NULL,0,NULL,NULL,3),(7,'canada','sa','usa','bangalore','','2011-02-16 06:45:49','system',NULL,NULL,0,NULL,NULL,2),(8,'america','uas','america','canada','','2011-02-16 10:55:33','system',NULL,NULL,0,NULL,NULL,3),(9,'america','uas','america','canada','','2011-02-16 11:03:01','system',NULL,NULL,0,NULL,NULL,3),(10,'India','Karnataka','Canada','bangalore','','2011-02-21 11:31:21','system',NULL,NULL,1,NULL,NULL,3),(11,'America','sa','usa','canada','','2011-02-21 11:37:27','system',NULL,NULL,0,NULL,NULL,2),(12,'USA','va','america','canada','','2011-02-21 11:39:15','system',NULL,NULL,0,NULL,NULL,6),(13,'India','Karnataka','RanNgagar','bangalore','','2011-02-22 12:08:29','system',NULL,NULL,0,NULL,NULL,1),(14,'EQWE!#!$!1','@#$$$$$','','','','2011-03-01 05:12:59','system',NULL,NULL,11,NULL,NULL,4),(15,'canada','@#$$$$$','@$@$gfdgd134','134SD#!2@#','','2011-03-02 07:44:53','system',NULL,NULL,0,NULL,NULL,3);
/*!40000 ALTER TABLE `jurisdiction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_type`
--

DROP TABLE IF EXISTS `person_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_type` (
  `id` tinyint(3) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_type`
--

LOCK TABLES `person_type` WRITE;
/*!40000 ALTER TABLE `person_type` DISABLE KEYS */;
INSERT INTO `person_type` VALUES (1,'STAFF','','2010-06-22 08:21:14','system','system',0,'2010-06-22 08:00:00'),(2,'PARTNER','','2010-06-22 08:21:59','system','system',0,'2010-06-22 08:00:00'),(3,'INSURANCE_AGENT','','2010-06-22 08:23:03','system','system',0,'2010-06-22 08:00:00'),(4,'LAWYER','','2010-06-22 08:23:52','system','system',0,'2010-06-22 08:00:00'),(5,'SHAREHOLDER','','2010-06-22 08:24:45','system','system',0,'2010-06-22 08:00:00'),(6,'BANK_EMPLOYEE','','2010-07-15 04:18:12','system','system',0,'2010-06-22 08:00:00');
/*!40000 ALTER TABLE `person_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filing_reminder`
--

DROP TABLE IF EXISTS `filing_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filing_reminder` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tax_practice_info_id` bigint(20) unsigned NOT NULL,
  `reminder_day` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filing_reminder`
--

LOCK TABLES `filing_reminder` WRITE;
/*!40000 ALTER TABLE `filing_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `filing_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_relationship`
--

DROP TABLE IF EXISTS `party_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_relationship` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` bigint(20) unsigned NOT NULL,
  `object` bigint(20) unsigned NOT NULL,
  `relationship_name` varchar(255) DEFAULT NULL,
  `relationship_type` tinyint(3) unsigned NOT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk28add711e26427d4` (`subject`),
  KEY `fk28add711abcbbce1` (`object`),
  KEY `fk_party_relationship_has_type` (`relationship_type`),
  CONSTRAINT `fk_party_relationship_has_type` FOREIGN KEY (`relationship_type`) REFERENCES `relationship_type` (`id`),
  CONSTRAINT `fk_party_relationship_is_for_object` FOREIGN KEY (`object`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_party_relationship_is_for_subject_party` FOREIGN KEY (`subject`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_relationship`
--

LOCK TABLES `party_relationship` WRITE;
/*!40000 ALTER TABLE `party_relationship` DISABLE KEYS */;
INSERT INTO `party_relationship` VALUES (142,299,298,NULL,1,'2011-02-02 06:54:42','system','',0,NULL,NULL),(143,300,298,NULL,3,'2011-02-02 06:56:59','system','',0,NULL,NULL),(144,301,298,NULL,3,'2011-02-03 03:55:22','system','',0,NULL,NULL),(145,302,298,NULL,9,'2011-02-03 03:56:36','system','',0,NULL,NULL),(146,307,306,NULL,2,'2011-02-04 01:29:10','system','',0,NULL,NULL),(147,309,308,NULL,2,'2011-02-04 02:55:56','system','',0,NULL,NULL),(148,311,310,NULL,2,'2011-02-04 03:01:56','system','',0,NULL,NULL),(149,313,312,NULL,2,'2011-02-04 03:05:12','system','',0,NULL,NULL),(150,315,314,NULL,2,'2011-02-04 03:08:39','system','',0,NULL,NULL),(151,317,316,NULL,2,'2011-02-04 03:12:25','system','',0,NULL,NULL),(152,318,314,NULL,1,'2011-02-08 02:46:51','system','',0,NULL,NULL),(154,320,310,NULL,1,'2011-02-08 05:26:25','system','',0,NULL,NULL),(155,321,310,NULL,1,'2011-02-08 05:28:19','system','',0,NULL,NULL),(156,322,320,NULL,3,'2011-02-08 05:51:44','system','',0,NULL,NULL),(157,322,320,NULL,7,'2011-02-08 05:56:36','system','',0,NULL,NULL),(158,323,303,NULL,3,'2011-02-08 14:38:57','system','',0,NULL,NULL),(159,324,310,NULL,2,'2011-02-09 02:54:18','system','',0,NULL,NULL),(160,325,310,NULL,2,'2011-02-09 02:54:19','system','',0,NULL,NULL),(161,326,310,NULL,2,'2011-02-09 02:54:19','system','',0,NULL,NULL),(162,327,310,NULL,9,'2011-02-09 03:34:43','system','',0,NULL,NULL),(163,328,310,NULL,9,'2011-02-09 03:35:26','system','',0,NULL,NULL),(164,329,310,NULL,9,'2011-02-09 03:39:44','system','',0,NULL,NULL),(165,330,314,NULL,9,'2011-02-09 04:03:40','system','',0,NULL,NULL),(166,331,310,NULL,11,'2011-02-09 05:11:41','system','',0,NULL,NULL),(167,333,332,NULL,2,'2011-02-09 06:55:42','system','',0,NULL,NULL),(168,334,332,NULL,1,'2011-02-09 06:58:06','system','',0,NULL,NULL),(169,335,334,NULL,3,'2011-02-09 07:03:58','system','',0,NULL,NULL),(170,336,332,NULL,3,'2011-02-09 07:04:55','system','',0,NULL,NULL),(171,337,299,NULL,3,'2011-02-10 06:41:03','system','',0,NULL,NULL),(172,338,318,NULL,3,'2011-02-10 06:47:57','system','',0,NULL,NULL),(173,339,314,NULL,3,'2011-02-10 06:49:47','system','',0,NULL,NULL),(174,340,314,NULL,9,'2011-02-13 00:40:25','system','',0,NULL,NULL),(175,338,318,NULL,7,'2011-02-14 11:57:36','system','',0,NULL,NULL),(176,341,314,NULL,12,'2011-02-14 12:02:38','system','',0,NULL,NULL),(177,342,310,NULL,3,'2011-02-15 04:46:34','system','',0,NULL,NULL),(178,344,343,NULL,2,'2011-02-15 07:00:12','system','',0,NULL,NULL),(179,345,343,NULL,1,'2011-02-15 07:40:17','system','',0,NULL,NULL),(180,346,345,NULL,3,'2011-02-15 07:49:58','system','',0,NULL,NULL),(181,346,345,NULL,7,'2011-02-15 07:52:46','system','',0,NULL,NULL),(182,347,345,NULL,3,'2011-02-15 08:20:48','system','',0,NULL,NULL),(183,348,345,NULL,3,'2011-02-15 09:09:33','system','',0,NULL,NULL),(184,348,345,NULL,7,'2011-02-15 09:15:45','system','',0,NULL,NULL),(185,347,345,NULL,7,'2011-02-15 10:12:31','system','',0,NULL,NULL),(186,349,343,NULL,9,'2011-02-15 10:14:28','system','',0,NULL,NULL),(187,350,343,NULL,9,'2011-02-15 10:14:52','system','',0,NULL,NULL),(188,351,343,NULL,12,'2011-02-15 10:30:57','system','',0,NULL,NULL),(189,352,343,NULL,12,'2011-02-15 10:31:18','system','',0,NULL,NULL),(190,353,343,NULL,10,'2011-02-15 10:39:19','system','',0,NULL,NULL),(191,354,343,NULL,11,'2011-02-15 10:56:51','system','',0,NULL,NULL),(192,355,343,NULL,3,'2011-02-15 11:39:25','system','',0,NULL,NULL),(193,357,332,NULL,1,'2011-02-16 04:11:47','system','',0,NULL,NULL),(194,358,357,NULL,3,'2011-02-16 04:13:20','system','',0,NULL,NULL),(195,359,332,NULL,3,'2011-02-16 04:34:42','system','',0,NULL,NULL),(196,362,361,NULL,3,'2011-02-16 06:14:14','system','',0,NULL,NULL),(197,363,298,NULL,3,'2011-02-16 06:20:01','system','',0,NULL,NULL),(198,364,298,NULL,3,'2011-02-16 06:21:39','system','',0,NULL,NULL),(199,365,298,NULL,2,'2011-02-16 06:33:54','system','',0,NULL,NULL),(200,366,298,NULL,3,'2011-02-16 06:44:00','system','',0,NULL,NULL),(201,367,343,NULL,1,'2011-02-16 09:55:52','system','',0,NULL,NULL),(202,368,367,NULL,3,'2011-02-16 10:01:44','system','',0,NULL,NULL),(203,368,367,NULL,7,'2011-02-16 10:03:13','system','',0,NULL,NULL),(204,369,367,NULL,3,'2011-02-16 10:06:32','system','',0,NULL,NULL),(205,369,367,NULL,7,'2011-02-16 10:07:23','system','',0,NULL,NULL),(206,371,345,NULL,3,'2011-02-16 13:28:46','system','',0,NULL,NULL),(207,371,345,NULL,7,'2011-02-17 07:12:19','system','',0,NULL,NULL),(208,372,345,NULL,3,'2011-02-17 07:26:26','system','',0,NULL,NULL),(209,373,345,NULL,3,'2011-02-17 11:16:30','system','',0,NULL,NULL),(210,374,343,NULL,3,'2011-02-17 12:54:15','system','',0,NULL,NULL),(211,375,343,NULL,3,'2011-02-17 13:11:45','system','',0,NULL,NULL),(212,376,343,NULL,3,'2011-02-18 06:31:22','system','',0,NULL,NULL),(213,379,378,NULL,2,'2011-02-18 12:18:01','system','',0,NULL,NULL),(214,380,343,NULL,1,'2011-02-19 06:26:16','system','',0,NULL,NULL),(215,381,345,NULL,3,'2011-02-19 07:17:04','system','',0,NULL,NULL),(216,382,343,NULL,1,'2011-02-19 08:01:41','system','',0,NULL,NULL),(217,383,343,NULL,3,'2011-02-21 08:47:06','system','',0,NULL,NULL),(218,384,343,NULL,2,'2011-02-21 08:53:56','system','',0,NULL,NULL),(219,385,343,NULL,3,'2011-02-21 09:03:57','system','',0,NULL,NULL),(220,386,303,NULL,3,'2011-02-21 09:58:20','system','',0,NULL,NULL),(221,387,303,NULL,3,'2011-02-21 09:59:28','system','',0,NULL,NULL),(222,390,389,NULL,3,'2011-02-21 10:28:46','system','',0,NULL,NULL),(223,391,389,NULL,3,'2011-02-21 10:30:22','system','',0,NULL,NULL),(224,392,298,NULL,3,'2011-02-21 10:34:34','system','',0,NULL,NULL),(225,393,298,NULL,3,'2011-02-21 10:57:45','system','',0,NULL,NULL),(226,394,298,NULL,3,'2011-02-21 11:22:01','system','',0,NULL,NULL),(227,395,298,NULL,3,'2011-02-21 11:23:41','system','',0,NULL,NULL),(228,396,298,NULL,3,'2011-02-21 11:24:47','system','',0,NULL,NULL),(229,397,343,NULL,1,'2011-02-22 12:22:50','system','',0,NULL,NULL),(230,398,345,NULL,3,'2011-02-23 12:39:59','system','',0,NULL,NULL),(231,399,345,NULL,3,'2011-02-23 13:15:14','system','',0,NULL,NULL),(232,400,343,NULL,1,'2011-02-24 06:38:44','system','',0,NULL,NULL),(233,401,343,NULL,1,'2011-02-24 09:50:48','system','',0,NULL,NULL),(234,402,345,NULL,3,'2011-02-24 11:18:20','system','',0,NULL,NULL),(235,403,314,NULL,3,'2011-02-25 05:27:50','system','',0,NULL,NULL),(236,404,314,NULL,1,'2011-02-26 23:15:03','system','',0,NULL,NULL),(237,405,343,NULL,3,'2011-02-27 07:21:45','system','',0,NULL,NULL),(238,406,343,NULL,3,'2011-02-28 13:06:50','system','',0,NULL,NULL),(239,411,343,NULL,1,'2011-03-01 06:54:06','system','',0,NULL,NULL),(240,415,343,NULL,3,'2011-03-01 13:41:29','system','',0,NULL,NULL),(241,416,404,NULL,3,'2011-03-01 13:53:46','system','',0,NULL,NULL),(242,416,404,NULL,7,'2011-03-01 13:56:38','system','',0,NULL,NULL),(243,417,314,NULL,3,'2011-03-01 14:02:20','system','',0,NULL,NULL),(244,420,419,NULL,3,'2011-03-01 14:07:58','system','',0,NULL,NULL),(245,421,419,NULL,3,'2011-03-02 03:57:13','system','',0,NULL,NULL),(246,423,345,NULL,3,'2011-03-02 06:06:39','system','',0,NULL,NULL),(247,372,345,NULL,7,'2011-03-08 09:35:24','system','',0,NULL,NULL),(248,373,345,NULL,7,'2011-03-08 09:36:31','system','',0,NULL,NULL),(249,424,343,NULL,1,'2011-03-08 12:22:23','system','',0,NULL,NULL),(250,425,345,NULL,3,'2011-03-08 13:08:03','system','',0,NULL,NULL),(251,426,424,NULL,3,'2011-03-08 13:26:59','system','',0,NULL,NULL),(252,427,424,NULL,3,'2011-03-08 13:58:04','system','',0,NULL,NULL);
/*!40000 ALTER TABLE `party_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `id` tinyint(3) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'client','','2010-06-13 08:33:56','system',NULL,NULL,0),(2,'partner','','2010-06-13 08:34:01','system',NULL,NULL,0),(3,'employee','','2010-06-13 08:34:05','system',NULL,NULL,0),(4,'bank','','2010-06-13 00:00:00','system',NULL,NULL,0),(5,'lawyer','','2010-06-13 08:34:15','system',NULL,NULL,0),(6,'insurance agency','','2010-06-13 08:34:20','system',NULL,NULL,0),(7,'shareholder','','2010-06-13 08:34:25','system',NULL,NULL,0),(8,'client transfer agent','','2010-06-13 08:34:30','system',NULL,NULL,0),(9,'main bank','','2010-09-14 08:08:01','system','system','2010-09-14 16:08:11',0),(10,'Insurance Firm','','2010-09-14 08:08:01','system','system','2010-09-14 16:08:11',0),(11,'Tranfer Agent Firm','','2010-09-14 08:08:01','system','system','2010-09-14 16:08:11',0),(12,'Main Law Firm','','2010-10-09 09:35:29','system','system','2010-10-09 17:35:44',0);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezone`
--

DROP TABLE IF EXISTS `timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timezone` (
  `id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `global_timezone_name` varchar(50) DEFAULT NULL,
  `gmt_deviation_hours` float DEFAULT NULL,
  `dst_flag` bit(1) DEFAULT NULL,
  `dst_begin_month` smallint(6) DEFAULT NULL,
  `dst_begin_day` smallint(6) DEFAULT NULL,
  `dst_begin_day_of_week` smallint(6) DEFAULT NULL,
  `dst_begin_hour` smallint(6) DEFAULT NULL,
  `dst_end_month` smallint(6) DEFAULT NULL,
  `dst_end_day` smallint(6) DEFAULT NULL,
  `dst_end_day_of_week` smallint(6) DEFAULT NULL,
  `dst_end_hour` smallint(6) DEFAULT NULL,
  `dst_std_cd` varchar(5) DEFAULT NULL,
  `dst_savings_cd` varchar(5) DEFAULT NULL,
  `create_user_id` varchar(25) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(25) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezone`
--

LOCK TABLES `timezone` WRITE;
/*!40000 ALTER TABLE `timezone` DISABLE KEYS */;
INSERT INTO `timezone` VALUES (1,'Eastern Time(US & Canada)',-5,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(2,'Pacific Time (US & Canada)',-8,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(3,'Atlantic Time (Canada)',-4,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(4,'Newfoundland Time (Canada)',-4,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(5,'Central Time (US & Canada)',-6,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(6,'Mountain Time (US & Canada)',-7,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'\0',0),(7,'USA',5,'',1,1,1,5,6,7,7,12,'14522','12434','system','2011-02-23 07:55:23',NULL,NULL,'',3),(8,'USA',5,'',1,1,2,12,6,7,7,12,'','','system','2011-02-23 08:12:03',NULL,NULL,'',2),(9,'@$@%@%#@%',24,'',24,132,245,124,1245,1245,253,452,'','','system','2011-03-01 06:12:03',NULL,NULL,'',0);
/*!40000 ALTER TABLE `timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_application_practice_type`
--

DROP TABLE IF EXISTS `tax_application_practice_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_application_practice_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `application_level` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_application_practice_type`
--

LOCK TABLES `tax_application_practice_type` WRITE;
/*!40000 ALTER TABLE `tax_application_practice_type` DISABLE KEYS */;
INSERT INTO `tax_application_practice_type` VALUES (1,'Corp Taxes','Corp Taxes','','2011-02-09 00:58:35','system',NULL,NULL,0,NULL),(2,'VA Tax','Taxes in VA','','2011-02-09 01:56:38','system',NULL,NULL,0,NULL),(3,'Karantaka Tax','Karnataka Tax','','2011-02-09 02:28:57','system',NULL,NULL,0,NULL),(4,'Corporate Income Tax','T2 - Corporate Income Tax','','2011-02-09 22:39:16','system',NULL,NULL,0,NULL),(5,'HST Return','HST Return - BN#012345678','','2011-02-09 22:40:04','system',NULL,NULL,0,NULL),(6,'Financial Statements - Interim','Financial Statements','','2011-02-09 22:40:42','system',NULL,NULL,0,NULL),(7,'T1 - Personal Income Taxes John','Personal Income Tax ','','2011-02-09 22:55:06','system',NULL,NULL,0,NULL),(8,'Sales Tax','Sales Tax','','2011-02-15 01:09:23','system',NULL,NULL,0,NULL),(9,'Accountant','Accountant','','2011-02-15 06:17:45','system',NULL,NULL,0,NULL),(10,'cashier','callect money','','2011-02-15 07:02:12','system',NULL,NULL,0,NULL),(11,'clerk','Secondary Division','','2011-02-16 04:32:44','system',NULL,NULL,0,NULL),(12,'Manager','Bank Manager','','2011-02-16 07:53:06','system',NULL,NULL,0,NULL),(13,'cashier','Bank Manager','','2011-02-17 08:41:18','system',NULL,NULL,0,NULL),(14,'santhosh','Accountant','','2011-02-17 08:46:28','system',NULL,NULL,0,NULL),(15,'ramu','Assistant Manager','','2011-02-18 01:32:58','system',NULL,NULL,0,NULL),(16,'Anand','Bank Manager','','2011-02-21 03:58:54','system',NULL,NULL,0,NULL),(17,'Anand','','','2011-02-21 04:27:11','system',NULL,NULL,0,NULL),(18,'sanjay','','','2011-02-21 07:56:34','system',NULL,NULL,0,NULL),(19,'Ada@$@$124','','','2011-02-28 08:14:45','system',NULL,NULL,0,NULL),(20,'Ada@$@$124','','','2011-03-01 08:56:00','system',NULL,NULL,0,NULL),(21,'Ada@$@$124','','','2011-03-02 02:12:21','system',NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `tax_application_practice_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code`
--

DROP TABLE IF EXISTS `code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code` (
  `id` bigint(20) unsigned NOT NULL,
  `short_name` varchar(50) NOT NULL,
  `long_description` varchar(100) NOT NULL,
  `code_type_id` int(11) unsigned NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(30) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `application_level_indicator` bit(1) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `parent_code_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fK_code_belongs_to_code_type` (`code_type_id`),
  KEY `fK_code_related_to_code` (`parent_code_id`),
  CONSTRAINT `fK_code_belongs_to_code_type` FOREIGN KEY (`code_type_id`) REFERENCES `code_type` (`id`),
  CONSTRAINT `fK_code_related_to_code` FOREIGN KEY (`parent_code_id`) REFERENCES `code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code`
--

LOCK TABLES `code` WRITE;
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
INSERT INTO `code` VALUES (1,'USA','United States of America',1,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(2,'CANADA','Canada',1,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(101,'CEO','Chief Executive Officer',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(102,'CFO','Chief Finance Officer',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(103,'Director','Director',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(104,'VP','Vice President',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(105,'President','President',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(106,'Manager','Manager',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(107,'Accountant','Accountant',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(108,'Supervisor','Supervisor',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(109,'Sales Representative','Sales Representative',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(110,'Bank Teller','Bank Teller',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(111,'Bank Manager','Bank Manager',5,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(201,'Accounts','Accounts',6,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(202,'HR','Human Resources',6,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(203,'Sales','Sales',6,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(204,'Finance','Finance',6,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(205,'Front Office','Front Office',6,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(401,'Agriculture','Agriculture',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(402,'Automotive','Automotive',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(403,'Chemicals','Chemicals',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(404,'Construction','Construction',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(405,'Consumer Goods & Services','Consumer Goods & Services',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(406,'Defense & Aerospace','Defense & Aerospace',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(407,'Energy','Energy',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(408,'Financial Services','Financial Services',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(409,'Firearms & Explosives','Firearms & Explosives',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(410,'Food & Beverage','Food & Beverage',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(411,'Health Care','Health Care',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(412,'Mining & Drilling','Mining & Drilling',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(413,'Pharmaceuticals & Biotechology','Pharmaceuticals & Biotechology',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(414,'Printing & Publishing','Printing & Publishing',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(415,'Real Estate','Real Estate',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(416,'Telecommunications','Telecommunications',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(417,'Transportation & Logistics','Transportation & Logistics',4,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(418,'Law','Law',4,0,'2010-10-09 17:04:09','system',1,'','system',NULL,NULL,''),(500,'Incorporated','Incorporated',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(501,'ULC','ULC',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(502,'UFP','UFP',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(503,'Trust','Trust',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(504,'LLC','LLC',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(505,'Partnership','Partnership',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(506,'Proprietorship','Proprietorship',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(507,'Other','Other',3,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',NULL,''),(700,'Bank Account','Bank Account',7,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',NULL,''),(701,'Insurance Policy Account','Insurance Policy Account',7,0,'2010-07-16 07:49:15','system',2,'','system','2010-06-22 18:38:01',NULL,''),(702,'Transfer Agency Account','Transfer Agency Account',7,0,'2010-10-09 04:39:23','system',1,'','system',NULL,NULL,''),(703,'Law Firm Account','Law Firm Account',7,0,'2010-10-10 05:42:42','system',2,'','system','2010-10-10 05:42:33',NULL,''),(800,'Checking','Checking',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',700,''),(801,'Savings','Savings',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',700,''),(802,'Investment','Investment',8,0,'2010-09-24 07:35:47','system',3,'','system','2010-06-22 18:38:01',700,''),(803,'Term Deposits','Term Deposits',8,0,'2010-09-24 07:36:10','system',4,'','system','2010-06-22 18:38:01',700,''),(804,'Other','Other',8,0,'2010-09-24 07:36:34','system',5,'','system','2010-06-22 18:38:01',700,''),(805,'Credit','Credit',8,0,'2010-09-24 07:36:10','system',4,'','system','2010-06-22 18:38:01',700,''),(806,'Mortgage','Mortgage',8,0,'2010-09-24 07:36:10','system',4,'','system','2010-06-22 18:38:01',700,''),(821,'Whole Life Innsurance','Whole Life Insurance',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',701,''),(822,'Term Life Innsurance','Term Life Insurance',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',701,''),(851,'Admiralty and Maritime','Admiralty and Maritime',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(852,'Adoption','Adoption',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(853,'ADR','ADR',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(854,'Asbestos:Mesothelioma','AdmiralAsbestos:Mesotheliomaty and Maritime',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(855,'Aviation Law','Aviation Law',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(856,'Bankruptcy','Bankruptcy',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(857,'Business Law','Business Law',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(858,'Controlled Substance','Controlled Substance',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(859,'Car Accident','Car Accident',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(860,'Catastrophic Injuries','Catastrophic Injuries',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(861,'Child Custody','Child Custody',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(862,'Children Rights','Children Rights',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(863,'Collaborative Law','Collaborative Law',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(864,'Consumer','Consumer',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(865,'Credit Card Fraud','Credit Card Fraud',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(866,'Criminal Defense','Criminal Defense',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(867,'Criminal Law','Criminal Law',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(868,'Divorce','Divorce',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(869,'Discrimination','Discrimination',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(870,'Domestic Violence','Domestic Violence',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(871,'Drug Charges','Drug Charges',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(872,'DUI - DWI','DUI - DWI',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(873,'Employment','Employment',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(874,'Estate & Trust','Estate & Trust',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(875,'Family','Family',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(876,'Foreclosure','Foreclosure',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(877,'Immigration','Immigration',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(878,'Intellectual Property','Intellectual Property',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(879,'Litigation','Litigation',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(880,'Medical Malpractice','Medical Malpractice',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(881,'Motor Vehicle','Motor Vehicle',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(882,'Personal Injury','Personal Injury',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(883,'Patent','Patent',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(884,'Real Estate','Real Estate',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(885,'Slip and Fall','Slip and Fall',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(886,'Taxation','Taxation',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(887,'Trade','Trade',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(888,'Trademark','Trademark',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(889,'Transportation','Transportation',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(890,'Truck Accident','Truck Accident',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(891,'Visas','Visas',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(892,'White Collar Crime','White Collar Crime',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(893,'Workplace Safety','Workplace Safety',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(894,'Worker Compensation','Worker Compensation',8,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',703,''),(1001,'AK','Alaska',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:44:16',1,''),(1002,'AL','Alabama',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:50:09',1,''),(1003,'AS','American Samoa',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 17:50:50',1,''),(1004,'AS','American Samoa',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:00:03',1,''),(1005,'AZ','Arizona',2,0,'2010-07-16 07:49:15','system',4,'','system','2010-06-22 18:00:03',1,''),(1006,'AR','Arkansas',2,0,'2010-07-16 07:49:15','system',5,'','system','2010-06-22 18:00:03',1,''),(1007,'CA','California',2,0,'2010-07-16 07:49:15','system',6,'','system','2010-06-22 18:00:03',1,''),(1008,'CO','Colorado',2,0,'2010-07-16 07:49:15','system',7,'','system','2010-06-22 18:00:03',1,''),(1009,'CT','Connecticut',2,0,'2010-07-16 07:49:15','system',8,'','system','2010-06-22 18:00:03',1,''),(1010,'DE','Delaware',2,0,'2010-07-16 07:49:15','system',9,'','system','2010-06-22 18:00:03',1,''),(1011,'DC','District of Columbia',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1012,'FM','Federated code of Micronesia',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1013,'FL','Florida',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1014,'GA','Georgia',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1015,'GU','Guam',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1016,'HI','Hawaii',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1017,'ID','Idaho',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1018,'IL','Illinois',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1019,'IN','Indiana',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1020,'IA','Iowa',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1021,'KS','Kansas',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1022,'KY','Kentucky',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1023,'LA','Louisiana',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1024,'ME','Maine',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1025,'MH','Marshall Islands',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1026,'MD','Maryland',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1027,'MA','Massachusetts',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1028,'MI','Michigan',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1029,'MN','Minnesota',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1030,'MS','Mississippi',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1031,'MO','Missouri',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1032,'MT','Montana',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1033,'NE','Nebraska',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1034,'NV','Nevada',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1035,'NH','New Hampshire',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1036,'NJ','New Jersey',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1037,'NM','New Mexico',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1038,'NY','New York',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1039,'NC','North Carolina',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1040,'ND','North Dakota',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1041,'MP','Northern Mariana Islands',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1042,'OH','Ohio',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1043,'OK','Oklahoma',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1044,'OR','Oregon',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1045,'PW','Palau',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1046,'PA','Pennsylvania',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1047,'PR','Puerto Rico',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1048,'RI','Rhode Island',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1049,'SC','South Carolina',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1050,'SD','South Dakota',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1051,'TN','Tennessee',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1052,'TX','Texas',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1053,'UT','Utah',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1054,'VT','Vermont',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1055,'VI','Virgin Islands',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1056,'VA','Virginia',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1057,'WA','Washington',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1058,'WV','West Virginia',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1059,'WI','Wisconsin',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1060,'WY','Wyoming',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1061,'AE','Armed Forces Africa',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1062,'AA','Armed Forces Americas (except Canada)',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1063,'AE','Armed Forces Canada',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1064,'AE','Armed Forces Europe',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1065,'AE','Armed Forces Middle East',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1066,'AP','Armed Forces Pacific',2,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:00:03',1,''),(1067,'AB','Alberta',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1068,'BC','British Columbia',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1069,'MB','Manitoba',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1070,'NB','New Brunswick',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1071,'NL','Newfoundland and Labrador',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1072,'NT','Northwest Territories',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1073,'NS','Nova Scotia',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1074,'NU','Nunavut',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1075,'ON','Ontario',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1076,'PE','Prince Edward Island',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1077,'QC','Québec',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1078,'SK','Saskatchewan',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1079,'YT','Yukon Territory',2,0,'2010-07-16 07:49:15','system',3,'','system','2010-06-22 18:38:01',2,''),(1200,'Ordinary Shares','Ordinary Shares',9,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',NULL,''),(1201,'Preferred Shares','Preferred Shares',9,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',NULL,''),(1202,'Other','Other',9,0,'2010-07-16 07:49:15','system',1,'','system','2010-06-22 18:38:01',NULL,''),(1300,'Yearly','Yearly',10,0,'2010-12-07 10:00:00','system',1,'','system','2010-12-07 10:00:00',NULL,''),(1301,'Semi Yearly','Semi Yearly',10,0,'2010-12-07 10:00:00','system',2,'',NULL,NULL,NULL,''),(1302,'Quarterly','Quarterly',10,0,'2010-12-07 10:00:00','system',3,'',NULL,NULL,NULL,''),(1303,'Monthly','Monthly',10,0,'2010-12-07 10:00:00','system',4,'',NULL,NULL,NULL,''),(1351,'1','1',12,0,'2010-12-07 22:00:00','system',1,'','system','2010-12-07 22:00:00',NULL,''),(1352,'3','3',12,0,'2010-12-07 22:00:00','system',2,'',NULL,NULL,NULL,''),(1353,'7','7',12,0,'2010-12-07 22:00:00','system',3,'',NULL,NULL,NULL,''),(1354,'15','15',12,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1355,'30','30',12,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1356,'60','60',12,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1357,'90','90',12,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1400,'Yearly','Yearly',11,0,'2010-12-07 22:00:00','system',1,'','system','2010-12-07 22:00:00',NULL,''),(1401,'Semi Yearly','Semi Yearly',11,0,'2010-12-07 22:00:00','system',2,'',NULL,NULL,NULL,''),(1402,'Quarterly','Quarterly',11,0,'2010-12-07 22:00:00','system',3,'',NULL,NULL,NULL,''),(1403,'Monthly','Monthly',11,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1451,'1','1',13,0,'2010-12-07 22:00:00','system',1,'','system','2010-12-07 22:00:00',NULL,''),(1452,'3','3',13,0,'2010-12-07 22:00:00','system',2,'',NULL,NULL,NULL,''),(1453,'7','7',13,0,'2010-12-07 22:00:00','system',3,'',NULL,NULL,NULL,''),(1454,'15','15',13,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1455,'30','30',13,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1456,'60','60',13,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1457,'90','90',13,0,'2010-12-07 22:00:00','system',4,'',NULL,NULL,NULL,''),(1458,'India','India',1,3,'2011-02-04 01:25:02','system',3,'\0',NULL,'2011-02-09 04:32:58',NULL,''),(1459,'Karnataka','Karnataka',2,0,'2011-02-04 01:25:42','system',1,'',NULL,NULL,1458,''),(1460,'Maharashtra','Maharashtra',2,0,'2011-02-04 01:26:14','system',2,'',NULL,NULL,1458,''),(1461,'Japan','Japan',1,2,'2011-02-04 01:27:45','system',3,'\0',NULL,'2011-02-09 04:33:06',NULL,''),(1462,'Africa','Africa',1,1,'2011-02-09 04:16:08','system',1,'\0',NULL,NULL,NULL,''),(1463,'Cape Town','Cape Town',2,3,'2011-02-09 04:17:41','system',1,'\0',NULL,NULL,1462,''),(1464,'Sri Lanka','Sri Lanka',1,0,'2011-02-09 04:24:10','system',1,'\0',NULL,NULL,NULL,''),(1465,'Colombo','Colombo',2,0,'2011-02-09 04:24:36','system',1,'\0',NULL,NULL,1464,''),(1466,'Denmark','Euro',1,0,'2011-02-09 05:17:55','system',1,'\0',NULL,NULL,NULL,''),(1467,'Danish','Danish',2,0,'2011-02-09 05:19:16','system',1,'\0',NULL,NULL,1466,''),(1468,'LLP','Limited Liability Partnership',3,0,'2011-02-09 05:27:45','system',1,'\0',NULL,NULL,NULL,''),(1469,'Junior Accountant','Junior Accountant',5,1,'2011-02-10 04:06:56','system',1,'\0',NULL,NULL,NULL,''),(1470,'Bookkeeper','Bookkeeper',5,1,'2011-02-10 04:07:43','system',1,'\0',NULL,NULL,NULL,''),(1471,'Senior Accountant','Senior Accountant',5,0,'2011-02-10 04:09:29','system',1,'\0',NULL,NULL,NULL,''),(1472,'Managing Partner','Managing Partner',17,0,'2011-02-12 06:02:15','system',1,'',NULL,NULL,NULL,''),(1473,'Tax Partner','Tax Partner',17,0,'2011-02-12 06:02:41','system',2,'',NULL,NULL,NULL,''),(1474,'General Partner','General Partner',17,0,'2011-02-12 06:03:07','system',3,'',NULL,NULL,NULL,''),(1475,'Limited Partner','Limited Partner',17,0,'2011-02-12 06:03:34','system',5,'',NULL,NULL,NULL,''),(1476,'Junior Accountant','Junior Accountant',17,0,'2011-02-12 06:03:56','system',6,'',NULL,NULL,NULL,''),(1477,'Office manager','Office manager',17,0,'2011-02-12 06:04:32','system',7,'',NULL,NULL,NULL,''),(1478,'Intermediate Accountant','Intermediate Accountant',17,0,'2011-02-12 06:04:50','system',8,'',NULL,NULL,NULL,''),(1479,'Senior Accountant','Senior Accountant',17,0,'2011-02-12 06:05:19','system',9,'',NULL,NULL,NULL,''),(1480,'Administration','Administration',17,0,'2011-02-12 06:05:41','system',10,'',NULL,NULL,NULL,''),(1481,'Bank of America','Bank of America',18,0,'2011-02-15 06:55:10','system',1,'',NULL,NULL,NULL,''),(1482,'Citibank','Citibank',18,0,'2011-02-15 06:55:42','system',2,'',NULL,NULL,NULL,''),(1483,'SunTrust Bank','SunTrust Bank',18,0,'2011-02-15 06:56:14','system',3,'',NULL,NULL,NULL,''),(1484,'Royal Bank of Canada','Royal Bank of Canada',18,0,'2011-02-15 06:56:50','system',4,'',NULL,NULL,NULL,''),(1485,'Bagladesh','Bagladesh',1,0,'2011-02-15 12:10:47','system',1,'\0',NULL,NULL,NULL,''),(1486,'Dhaka','Dhaka',2,0,'2011-02-15 12:12:41','system',1,'\0',NULL,NULL,1485,''),(1487,'america','america',1,0,'2011-02-16 06:53:28','system',3,'',NULL,NULL,NULL,''),(1488,'BM','Bank Manager',5,0,'2011-02-16 07:00:28','system',2,'',NULL,NULL,NULL,''),(1489,'bangalore','a city',2,0,'2011-02-16 09:34:08','system',1,'\0',NULL,NULL,NULL,''),(1490,'Americe','country',1,0,'2011-02-16 13:07:17','system',3,'',NULL,NULL,NULL,''),(1491,'sanjay','',2,1,'2011-02-17 13:48:11','system',1,'\0',NULL,NULL,NULL,''),(1492,'BM','Bank Manager',8,0,'2011-02-18 06:40:32','system',3,'',NULL,NULL,701,''),(1493,'Bagladesh','',1,0,'2011-02-18 08:10:31','system',1,'\0',NULL,NULL,NULL,''),(1494,'sanjay','Dhaka',5,0,'2011-02-18 08:34:36','system',1,'\0',NULL,NULL,NULL,''),(1495,'ravi','',1,0,'2011-02-21 09:00:00','system',1,'\0',NULL,NULL,NULL,''),(1496,'ravi','',1,0,'2011-02-21 09:28:43','system',1,'\0',NULL,NULL,NULL,''),(1497,'USA','from usa',4,0,'2011-02-21 11:59:36','system',3,'',NULL,NULL,NULL,''),(1498,'andrapradesh','Bank Manager',5,0,'2011-02-21 12:33:05','system',2,'',NULL,NULL,NULL,''),(1499,'america','Bank Manager',1,2,'2011-02-21 12:36:35','system',2,'',NULL,NULL,NULL,''),(1500,'andrapradesh','from usa',2,0,'2011-02-22 12:09:49','system',2,'',NULL,NULL,2,''),(1501,'132@#sa','',1,0,'2011-02-28 13:21:59','system',1,'\0',NULL,NULL,NULL,''),(1502,'@$@%@%@','1343565',3,1,'2011-03-01 06:33:40','system',255,'',NULL,NULL,NULL,''),(1503,'@%%#%#%','24435325',17,2,'2011-03-01 13:56:41','system',1,'\0',NULL,NULL,NULL,''),(1504,'@$@%@%@','1343565',3,0,'2011-03-01 14:00:33','system',1245245422,'',NULL,NULL,NULL,''),(1505,'@$@%@%@','1343565',5,0,'2011-03-01 14:09:48','system',1245245422,'\0',NULL,NULL,NULL,'\0'),(1506,'@%%#%#%','',17,0,'2011-03-02 07:12:51','system',1,'\0',NULL,NULL,NULL,''),(1507,'@$@$@$','24213432',2,0,'2011-03-03 09:13:02','system',4354324,'',NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_info_due_date_rule`
--

DROP TABLE IF EXISTS `tax_info_due_date_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_info_due_date_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `due_day` int(11) DEFAULT NULL,
  `due_month` int(11) DEFAULT NULL,
  `practice_info_id` bigint(20) unsigned NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `scheduling_rule` varchar(50) DEFAULT NULL,
  `filing_type` smallint(3) unsigned DEFAULT NULL,
  `generated_task_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `due_date_rule_is_for_practice_info` (`practice_info_id`),
  KEY `due_date_rule_is_for_filing_type` (`filing_type`),
  CONSTRAINT `due_date_rule_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `due_date_rule_is_for_practice_info` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_due_date_rule`
--

LOCK TABLES `tax_info_due_date_rule` WRITE;
/*!40000 ALTER TABLE `tax_info_due_date_rule` DISABLE KEYS */;
INSERT INTO `tax_info_due_date_rule` VALUES (1,1,1,2,'','2011-02-09 02:18:19','system','system','2011-02-09 07:18:21',2,NULL,2,'2012-02-01'),(2,1,0,2,'','2011-02-09 02:18:19','system','system','2011-02-09 07:18:21',2,NULL,1,'2012-01-01'),(3,15,1,3,'','2011-02-09 02:30:34','system','system','2011-02-09 07:30:36',2,NULL,2,'2012-02-15'),(4,10,0,3,'','2011-02-09 02:30:34','system','system','2011-02-09 07:30:36',2,NULL,1,'2012-01-10'),(5,10,9,3,'','2011-02-09 02:30:36','system','system','2011-02-09 07:30:36',1,NULL,NULL,'2011-10-10'),(6,15,10,3,'','2011-02-09 02:30:36','system','system','2011-02-09 07:30:36',1,NULL,NULL,'2011-11-15'),(7,-1,-1,4,'','2011-02-10 01:50:18','system','system','2011-02-14 06:50:00',3,NULL,2,'2011-11-29'),(8,-1,-1,4,'','2011-02-10 01:50:18','system','system','2011-02-14 06:50:00',3,NULL,1,'2011-11-29'),(9,10,3,5,'','2011-02-15 00:53:11','system','system','2011-02-16 03:41:41',2,NULL,2,'2011-04-10'),(10,10,2,5,'','2011-02-15 00:53:11','system','system','2011-02-16 03:41:41',2,NULL,1,'2011-03-10'),(11,-1,-1,6,'','2011-02-15 01:10:04','system','system','2011-02-15 06:10:06',2,NULL,2,'2011-11-29'),(12,-1,-1,6,'','2011-02-15 01:10:04','system','system','2011-02-15 06:10:06',2,NULL,1,'2011-11-29'),(13,2,-1,7,'','2011-02-15 07:03:48','system','system','2011-02-15 12:03:49',2,NULL,2,'2011-12-02'),(14,3,1,7,'','2011-02-15 07:03:48','system','system','2011-02-15 12:03:49',2,NULL,1,'2012-02-03'),(15,8,3,8,'','2011-02-15 07:07:15','system','system','2011-02-15 12:08:00',2,NULL,2,'2011-04-08'),(16,10,1,8,'','2011-02-15 07:07:15','system','system','2011-02-15 12:08:00',3,NULL,1,'2012-02-10'),(17,15,2,9,'','2011-02-15 22:40:21','system','system','2011-02-16 03:40:22',1,NULL,2,'2011-03-15'),(18,28,1,9,'','2011-02-15 22:40:21','system','system','2011-02-16 03:40:22',1,NULL,1,'2011-02-28'),(19,10,6,10,'','2011-02-15 23:14:42','system','system','2011-02-16 04:14:43',1,NULL,2,'2011-07-10'),(20,15,3,10,'','2011-02-15 23:14:42','system','system','2011-02-16 04:14:43',1,NULL,1,'2011-04-15'),(21,15,10,10,'','2011-02-15 23:14:43','system','system','2011-02-16 04:14:43',1,NULL,NULL,'2011-11-15'),(22,15,4,11,'','2011-02-15 23:17:56','system','system','2011-02-16 04:17:58',1,NULL,2,'2011-05-15'),(23,28,1,11,'','2011-02-15 23:17:56','system','system','2011-02-16 04:17:58',1,NULL,1,'2011-02-28'),(28,4,2,14,'','2011-02-17 09:01:14','system','system','2011-02-17 14:01:15',1,NULL,1,'2011-03-04'),(29,NULL,NULL,14,'','2011-02-17 09:01:14','system','system','2011-02-17 14:01:15',1,NULL,1,'2011-02-23'),(32,1,0,16,'','2011-02-19 09:36:32','system','system','2011-02-19 14:39:15',2,NULL,2,'2011-01-01'),(33,1,0,16,'','2011-02-19 09:36:32','system','system','2011-02-19 14:39:15',2,NULL,1,'2011-01-01'),(34,30,0,16,'','2011-02-19 09:39:15','system','system','2011-02-19 14:39:15',0,NULL,NULL,NULL),(35,31,0,16,'','2011-02-19 09:39:15','system','system','2011-02-19 14:39:15',0,NULL,NULL,NULL),(41,12,0,22,'','2011-02-21 01:53:07','system','system','2011-02-23 03:06:49',11,NULL,1,'2011-01-12'),(42,14,0,22,'','2011-02-21 01:53:07','system','system','2011-02-23 03:06:49',11,NULL,2,'2011-01-14'),(55,6,7,22,'','2011-02-22 22:06:49','system','system','2011-02-23 03:06:49',1,NULL,1,'2011-08-06'),(56,18,11,22,'','2011-02-22 22:06:49','system','system','2011-02-23 03:06:49',1,NULL,2,'2011-12-18'),(57,1,0,25,'','2011-02-23 00:10:12','system','system','2011-02-23 05:10:12',1,NULL,1,'2011-01-01'),(58,2,1,25,'','2011-02-23 00:10:12','system','system','2011-02-23 05:10:12',1,NULL,2,'2011-02-02'),(59,4,0,26,'','2011-02-23 21:38:26','system','system','2011-02-24 02:38:26',0,NULL,1,NULL),(60,4,1,26,'','2011-02-23 21:38:26','system','system','2011-02-24 02:38:26',0,NULL,1,NULL),(61,11,6,26,'','2011-02-23 21:38:26','system','system','2011-02-24 02:38:26',0,NULL,2,NULL),(62,16,8,26,'','2011-02-23 21:38:26','system','system','2011-02-24 02:38:26',0,NULL,2,NULL),(63,1,0,27,'','2011-03-08 08:39:26','system','system','2011-03-08 13:39:26',0,NULL,1,NULL),(64,4,0,27,'','2011-03-08 08:39:26','system','system','2011-03-08 13:39:26',0,NULL,2,NULL);
/*!40000 ALTER TABLE `tax_info_due_date_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_type`
--

DROP TABLE IF EXISTS `party_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_type` (
  `id` tinyint(3) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_type`
--

LOCK TABLES `party_type` WRITE;
/*!40000 ALTER TABLE `party_type` DISABLE KEYS */;
INSERT INTO `party_type` VALUES (1,'person','','2010-06-17 06:32:44','system','system','2010-06-17 06:32:54',0),(2,'organization','','2010-06-17 06:32:44','system','system','2010-06-17 06:32:54',0);
/*!40000 ALTER TABLE `party_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_site_type`
--

DROP TABLE IF EXISTS `party_site_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_site_type` (
  `id` smallint(6) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  `default_flag` bit(1) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_site_type`
--

LOCK TABLES `party_site_type` WRITE;
/*!40000 ALTER TABLE `party_site_type` DISABLE KEYS */;
INSERT INTO `party_site_type` VALUES (1,'MAIN OFFICE','Office Address','2010-08-06 06:09:18','system','system','2010-08-06 06:09:33',0,'',''),(2,'BRANCH OFFICE','Branch Office','2010-08-06 06:09:18','system','system','2010-08-06 06:09:18',0,'\0',''),(3,'HOME','Home','2010-08-06 06:09:18','system','system','2010-08-06 06:09:18',0,'\0',''),(4,'SALES OFFICE','Sales Office Address','2010-08-06 06:09:18','system','system','2010-08-06 06:09:33',0,'\0',''),(5,'FACTORY SITE','Factory Site Address','2010-08-06 06:09:18','system','system','2010-08-06 06:09:33',0,'\0',''),(6,'FRANCHISE OFFICE','Franchise Office Address','2010-08-06 06:09:18','system','system','2010-08-06 06:09:33',0,'\0',''),(7,'CUSTOMER SERVICE OFFICE','Customer Service Address','2010-08-06 06:09:18','system','system','2010-08-06 06:09:33',0,'\0',''),(8,'AGENCY OFFICE','Agency Office','2010-08-06 06:09:18','system','system','2010-08-06 06:09:18',0,'\0','');
/*!40000 ALTER TABLE `party_site_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_site`
--

DROP TABLE IF EXISTS `party_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_site` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address_id` bigint(20) unsigned NOT NULL,
  `party_site_type` smallint(6) unsigned NOT NULL,
  `party_id` bigint(20) unsigned NOT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `identifying_address_flag` bit(1) DEFAULT NULL,
  `timezone_id` mediumint(9) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_title` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk3b4039206ebf151a` (`address_id`),
  KEY `fk3b4039204b78cfda` (`party_id`),
  KEY `fk_party_site_is_for_party_site_type` (`party_site_type`),
  CONSTRAINT `fk_address_for_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `fk_address_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_party_site_is_for_party_site_type` FOREIGN KEY (`party_site_type`) REFERENCES `party_site_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_site`
--

LOCK TABLES `party_site` WRITE;
/*!40000 ALTER TABLE `party_site` DISABLE KEYS */;
INSERT INTO `party_site` VALUES (97,157,1,298,'',NULL,NULL,1,NULL,NULL,'2011-02-02 06:40:43','system','Sai Tax Consultants','Sai Tax Consultants','Sai Tax Consultants'),(98,158,3,300,'',NULL,NULL,2,NULL,NULL,'2011-02-02 06:56:59','system','Sagar','Best','Sagar Best'),(99,159,3,301,'',NULL,NULL,1,NULL,NULL,'2011-02-03 03:55:21','system','Ady','Vashisth','Ady Vashisth'),(100,160,1,302,'',NULL,NULL,0,NULL,NULL,'2011-02-03 03:59:38','system','John Peterson','Manager','St Lous Office,'),(101,161,2,302,'',NULL,NULL,0,NULL,NULL,'2011-02-03 04:09:00','system','John Peterson','Manager','Rt 28 Branch,'),(102,162,1,303,'',NULL,NULL,1,NULL,NULL,'2011-02-03 18:02:00','system','sadsaasdsa','sadsaasdsa','sadsaasdsa'),(103,163,1,304,'',NULL,NULL,0,NULL,NULL,'2011-02-03 18:02:01','system','sadsaasdsa','sadsaasdsa','sadsaasdsa'),(104,164,1,305,'',NULL,NULL,0,NULL,NULL,'2011-02-03 18:03:51','system','Savitri','Savitri','Savitri'),(105,165,4,299,'',NULL,NULL,4,NULL,NULL,'2011-02-04 01:12:59','system','John Peterson','Manager','St Lous Office,'),(106,166,1,306,'',NULL,NULL,0,NULL,NULL,'2011-02-04 01:24:06','system','Wali Assoiciates','Wali Assoiciates','Wali Assoiciates'),(107,167,3,307,'',NULL,NULL,0,NULL,NULL,'2011-02-04 01:29:09','system','Gangadhar','Wali','Gangadhar Wali'),(108,168,1,308,'',NULL,NULL,0,NULL,NULL,'2011-02-04 02:51:40','system','Transforce Financial Serices','Transforce Financial Serices','Transforce Financial Serices'),(109,169,3,309,'',NULL,NULL,0,NULL,NULL,'2011-02-04 02:55:55','system','JP','Bangalore','JP Bangalore'),(110,170,1,310,'',NULL,NULL,0,NULL,NULL,'2011-02-04 02:59:48','system','Delves Freer Anderson Raniga Caine','Delves Freer Anderson Raniga Caine','Delves Freer Anderson Raniga Caine'),(111,171,3,311,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:01:55','system','Rajesh','Raniga','Rajesh Raniga'),(112,172,1,312,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:03:48','system','Aditya Finances','Aditya Finances','Aditya Finances'),(113,173,3,313,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:05:11','system','Aditya','Vashisth','Aditya Vashisth'),(114,174,1,314,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:07:03','system','Bannikal Brothers','Bannikal Brothers','Bannikal Brothers'),(115,175,3,315,'',NULL,NULL,1,NULL,NULL,'2011-02-04 03:08:38','system','Sagar','Bannikal','Sagar Bannikal'),(116,176,1,316,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:10:53','system','Savitri Tax Consultants','Savitri Tax Consultants','Savitri Tax Consultants'),(117,177,3,317,'',NULL,NULL,0,NULL,NULL,'2011-02-04 03:12:23','system','Savitri','Panchamanavar','Savitri Panchamanavar'),(118,178,1,318,'',NULL,NULL,4,NULL,NULL,'2011-02-08 02:46:49','system','peter','Manager','St.Philos'),(120,180,1,320,'',NULL,NULL,1,NULL,NULL,'2011-02-08 05:26:24','system',NULL,NULL,NULL),(121,181,1,321,'',NULL,NULL,0,NULL,NULL,'2011-02-08 05:28:18','system',NULL,NULL,NULL),(122,182,3,322,'',NULL,NULL,1,NULL,NULL,'2011-02-08 05:51:41','system','Sue','Treen','Sue Treen'),(123,183,4,320,'',NULL,NULL,0,NULL,NULL,'2011-02-08 06:06:19','system','Elias Don','Bookkeeper','Sales,'),(124,184,3,323,'',NULL,NULL,0,NULL,NULL,'2011-02-08 14:38:56','system','Rohit','K','Rohit K'),(125,185,3,324,'',NULL,NULL,0,NULL,NULL,'2011-02-09 02:54:15','system','Rajesh','Raniga','Rajesh Raniga'),(126,186,3,325,'',NULL,NULL,0,NULL,NULL,'2011-02-09 02:54:16','system','Rajesh','Raniga','Rajesh Raniga'),(127,187,3,326,'',NULL,NULL,0,NULL,NULL,'2011-02-09 02:54:16','system','Rajesh','Raniga','Rajesh Raniga'),(128,188,2,330,'',NULL,NULL,0,NULL,NULL,'2011-02-09 04:20:17','system','Dhaksha','Manager','Banglore'),(129,189,2,327,'',NULL,NULL,0,NULL,NULL,'2011-02-09 04:56:30','system','Yadvinder','Loan manager','Surrey'),(130,190,1,332,'',NULL,NULL,0,NULL,NULL,'2011-02-09 06:43:57','system','Gudi Karakoona','Gudi Karakoona','Gudi Karakoona'),(131,191,3,333,'',NULL,NULL,0,NULL,NULL,'2011-02-09 06:55:40','system','Shrinivas','Gudi','Shrinivas Gudi'),(132,192,1,334,'',NULL,NULL,0,NULL,NULL,'2011-02-09 06:58:04','system',NULL,NULL,NULL),(133,193,3,335,'',NULL,NULL,0,NULL,NULL,'2011-02-09 07:03:56','system','Narayana','Murthy','Narayana Murthy'),(134,194,3,336,'',NULL,NULL,0,NULL,NULL,'2011-02-09 07:04:53','system','Ady','Sharma','Ady Sharma'),(135,195,3,337,'',NULL,NULL,0,NULL,NULL,'2011-02-10 06:41:01','system','Roshan','Reddy','Roshan Reddy'),(136,196,3,338,'',NULL,NULL,1,NULL,NULL,'2011-02-10 06:47:56','system','Rajeshker','Reddy','Rajeshker Reddy'),(137,197,3,339,'',NULL,NULL,0,NULL,NULL,'2011-02-10 06:49:46','system','Prashanth','Keni','Prashanth Keni'),(138,198,2,340,'',NULL,NULL,0,NULL,NULL,'2011-02-13 00:42:26','system','Sharma','manager','rt 28 branch'),(139,199,2,341,'',NULL,NULL,0,NULL,NULL,'2011-02-14 12:04:26','system','Richand','Manager','Blank Rome HO'),(140,200,3,342,'',NULL,NULL,0,NULL,NULL,'2011-02-15 04:46:31','system','John','Mahony','John Mahony'),(141,201,1,343,'',NULL,NULL,0,NULL,NULL,'2011-02-15 06:56:12','system','Patil Enterprises','Patil Enterprises','Patil Enterprises'),(142,202,3,344,'',NULL,NULL,0,NULL,NULL,'2011-02-15 07:00:03','system','Anand','Patil','Anand Patil'),(143,203,1,345,'',NULL,NULL,13,NULL,NULL,'2011-02-15 07:40:12','system',NULL,NULL,NULL),(144,204,3,346,'',NULL,NULL,6,NULL,NULL,'2011-02-15 07:49:51','system','raju','','raju '),(145,205,1,345,'',NULL,NULL,0,NULL,NULL,'2011-02-15 07:59:25','system','sales manager','manager','paris'),(146,208,3,347,'',NULL,NULL,3,NULL,NULL,'2011-02-15 08:20:44','system','sandeep','patil','sandeep patil'),(147,209,3,348,'',NULL,NULL,4,NULL,NULL,'2011-02-15 09:09:30','system','madival','sanglad','madival sanglad'),(148,210,2,345,'',NULL,NULL,0,NULL,NULL,'2011-02-15 09:41:05','system','basu','sales Manager','Richmond Circle'),(149,211,2,349,'',NULL,NULL,1,NULL,NULL,'2011-02-15 10:26:28','system','jaggu','cleark','Ram Nagar'),(150,212,2,351,'',NULL,NULL,3,NULL,NULL,'2011-02-15 10:34:23','system','shahi','supervoiser','SBI'),(151,213,8,353,'',NULL,NULL,0,NULL,NULL,'2011-02-15 10:41:52','system','uday','casheir','SBM'),(152,214,1,353,'',NULL,NULL,0,NULL,NULL,'2011-02-15 10:53:33','system','manju','Accountant','SBM'),(153,215,8,354,'',NULL,NULL,1,NULL,NULL,'2011-02-15 10:59:37','system','sanjay','casheir','SBI'),(154,216,3,355,'',NULL,NULL,1,NULL,NULL,'2011-02-15 11:39:23','system','ajay','gouda','ajay gouda'),(155,217,2,350,'',NULL,NULL,0,NULL,NULL,'2011-02-15 12:25:40','system','Raghu','Acoountant','Basaveshwar Nagar'),(156,221,1,357,'',NULL,NULL,0,NULL,NULL,'2011-02-16 04:11:43','system',NULL,NULL,NULL),(157,222,3,358,'',NULL,NULL,0,NULL,NULL,'2011-02-16 04:13:17','system','Ram','Kumar','Ram Kumar'),(158,223,3,359,'',NULL,NULL,0,NULL,NULL,'2011-02-16 04:34:38','system','Vasu','Murthy','Vasu Murthy'),(159,224,1,360,'',NULL,NULL,6,NULL,NULL,'2011-02-16 05:37:15','system','Shree Enterprises','Shree Enterprises','Shree Enterprises'),(160,225,1,361,'',NULL,NULL,1,NULL,NULL,'2011-02-16 06:09:02','system','anand Association','anand Association','anand Association'),(161,226,3,362,'',NULL,NULL,0,NULL,NULL,'2011-02-16 06:14:10','system','deepu','Rajputh','deepu Rajputh'),(162,227,3,363,'',NULL,NULL,0,NULL,NULL,'2011-02-16 06:19:57','system','deepu','Rajputh','deepu Rajputh'),(163,228,3,364,'',NULL,NULL,0,NULL,NULL,'2011-02-16 06:21:26','system','deepu','Rajputh','deepu Rajputh'),(164,229,3,365,'',NULL,NULL,1,NULL,NULL,'2011-02-16 06:33:50','system','anil','patil','anil patil'),(165,230,3,366,'',NULL,NULL,0,NULL,NULL,'2011-02-16 06:43:56','system','manju','sanglad','manju sanglad'),(166,233,2,350,'',NULL,NULL,0,NULL,NULL,'2011-02-16 09:28:22','system','manju','Accountant','Basaveshwar Nagar'),(167,234,1,367,'',NULL,NULL,0,NULL,NULL,'2011-02-16 09:55:49','system',NULL,NULL,NULL),(168,235,3,368,'',NULL,NULL,1,NULL,NULL,'2011-02-16 10:01:39','system','veeresh','Talloli','veeresh Talloli'),(169,236,3,369,'',NULL,NULL,1,NULL,NULL,'2011-02-16 10:06:29','system','rajesh','pandith','rajesh pandith'),(170,237,7,367,'',NULL,NULL,2,NULL,NULL,'2011-02-16 10:11:09','system','Srikanth','sales Manager','Basavana Gudi'),(171,239,1,370,'',NULL,NULL,0,NULL,NULL,'2011-02-16 13:19:54','system','patil\'s Association','patil\'s Association','patil\'s Association'),(172,240,3,371,'',NULL,NULL,1,NULL,NULL,'2011-02-16 13:28:43','system','basu','pujer','basu pujer'),(173,241,5,345,'',NULL,NULL,0,NULL,NULL,'2011-02-16 13:32:25','system','ramesh','supervisor','manjunath nagar'),(174,243,2,350,'',NULL,NULL,0,NULL,NULL,'2011-02-16 13:45:21','system','anand','manager','Basaveshwar Nagar'),(175,254,6,345,'',NULL,NULL,0,NULL,NULL,'2011-02-17 06:23:58','system','santhosh','manager','Hubli'),(176,257,3,372,'',NULL,NULL,6,NULL,NULL,'2011-02-17 07:26:19','system','Bhanu','','Bhanu '),(177,258,3,373,'',NULL,NULL,2,NULL,NULL,'2011-02-17 11:16:25','system','ganesh','','ganesh '),(178,259,4,345,'',NULL,NULL,1,NULL,NULL,'2011-02-17 11:45:54','system','santhosh','casheir','Basaveshwar Nagar'),(179,260,5,345,'',NULL,NULL,0,NULL,NULL,'2011-02-17 11:59:04','system','sourabh','Accountant','Shree Ram pur'),(180,262,3,374,'',NULL,NULL,0,NULL,NULL,'2011-02-17 12:54:10','system','Bhanu','','Bhanu '),(181,263,3,375,'',NULL,NULL,0,NULL,NULL,'2011-02-17 13:11:39','system','raju','sanglad','raju sanglad'),(182,285,3,376,'',NULL,NULL,0,NULL,NULL,'2011-02-18 06:31:16','system','roy','Rajputh','roy Rajputh'),(183,286,1,377,'',NULL,NULL,0,NULL,NULL,'2011-02-18 06:39:02','system','sandeep Association','sandeep Association','sandeep Association'),(184,296,1,378,'',NULL,NULL,0,NULL,NULL,'2011-02-18 12:15:54','system','Sadeep','Sadeep','Sadeep'),(185,297,3,379,'',NULL,NULL,0,NULL,NULL,'2011-02-18 12:17:55','system','raju','sanglad','raju sanglad'),(186,298,1,380,'',NULL,NULL,2,NULL,NULL,'2011-02-19 06:26:08','system',NULL,NULL,NULL),(187,299,3,381,'',NULL,NULL,0,NULL,NULL,'2011-02-19 07:16:55','system','raju','','raju '),(188,300,1,382,'',NULL,NULL,0,NULL,NULL,'2011-02-19 08:01:32','system',NULL,NULL,NULL),(189,301,4,345,'',NULL,NULL,1,NULL,NULL,'2011-02-19 13:26:38','system','sourabh','manager','Basaveshwar Nagar'),(190,302,8,345,'',NULL,NULL,0,NULL,NULL,'2011-02-21 05:20:23','system','balu','sales Manager','Jayanagar'),(191,303,8,345,'',NULL,NULL,0,NULL,NULL,'2011-02-21 06:04:23','system','raju','sales Manager','Jayanagar'),(192,313,3,383,'',NULL,NULL,0,NULL,NULL,'2011-02-21 08:46:55','system','sagar','patil','sagar patil'),(193,314,3,384,'',NULL,NULL,2,NULL,NULL,'2011-02-21 08:53:47','system','sandeep','','sandeep '),(194,315,3,385,'',NULL,NULL,1,NULL,NULL,'2011-02-21 09:03:42','system','madival','','madival '),(195,316,3,386,'',NULL,NULL,0,NULL,NULL,'2011-02-21 09:58:12','system','sandeep','sanglad','sandeep sanglad'),(196,317,3,387,'',NULL,NULL,1,NULL,NULL,'2011-02-21 09:59:21','system','sandeep','sanglad','sandeep sanglad'),(197,318,1,388,'',NULL,NULL,0,NULL,NULL,'2011-02-21 10:05:02','system','anand','anand','anand'),(198,319,1,389,'',NULL,NULL,0,NULL,NULL,'2011-02-21 10:05:12','system','anand','anand','anand'),(199,320,3,390,'',NULL,NULL,0,NULL,NULL,'2011-02-21 10:28:39','system','raju','','raju '),(200,321,3,391,'',NULL,NULL,1,NULL,NULL,'2011-02-21 10:30:16','system','raju','','raju '),(201,322,3,392,'',NULL,NULL,0,NULL,NULL,'2011-02-21 10:34:27','system','raju','Rajputh','raju Rajputh'),(202,323,3,393,'',NULL,NULL,0,NULL,NULL,'2011-02-21 10:57:38','system','sandeep','','sandeep '),(203,324,3,394,'',NULL,NULL,0,NULL,NULL,'2011-02-21 11:21:54','system','sandeep','patil','sandeep patil'),(204,325,3,395,'',NULL,NULL,0,NULL,NULL,'2011-02-21 11:23:34','system','sandeep','patil','sandeep patil'),(205,326,3,396,'',NULL,NULL,1,NULL,NULL,'2011-02-21 11:24:39','system','sandeep','patil','sandeep patil'),(206,327,1,397,'',NULL,NULL,3,NULL,NULL,'2011-02-22 12:22:48','system',NULL,NULL,NULL),(207,328,3,398,'',NULL,NULL,0,NULL,NULL,'2011-02-23 12:39:56','system','madival','','madival '),(208,329,2,345,'',NULL,NULL,3,NULL,NULL,'2011-02-23 13:07:18','system','raju','14563454','SBI'),(209,330,3,345,'',NULL,NULL,0,NULL,NULL,'2011-02-23 13:11:21','system','14214342','14@#$%1211','12345@#$%%'),(210,331,3,399,'',NULL,NULL,0,NULL,NULL,'2011-02-23 13:15:11','system','145@#$%ada','ds@#$1452','145@#$%ada ds@#$1452'),(211,333,1,400,'',NULL,NULL,0,NULL,NULL,'2011-02-24 06:38:39','system',NULL,NULL,NULL),(212,334,1,401,'',NULL,NULL,0,NULL,NULL,'2011-02-24 09:50:45','system',NULL,NULL,NULL),(213,335,3,402,'',NULL,NULL,1,NULL,NULL,'2011-02-24 11:18:17','system','145@#$%ada','@$@$dff123','145@#$%ada @$@$dff123'),(214,336,2,345,'',NULL,NULL,0,NULL,NULL,'2011-02-24 12:59:08','system','@#$sdsfd4435','123sfdg#@$%','12345@#$%%'),(215,340,3,403,'',NULL,NULL,0,NULL,NULL,'2011-02-25 05:27:47','system','Shanti','k','Shanti k'),(216,341,1,404,'',NULL,NULL,2,NULL,NULL,'2011-02-26 23:15:00','system',NULL,NULL,'Kamal Nagar'),(217,346,3,405,'',NULL,NULL,0,NULL,NULL,'2011-02-27 07:21:41','system','44543@$@fg','1324SFS@$45','44543@$@fg 1324SFS@$45'),(218,347,3,406,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:06:47','system','1317asd@#$','@$@$dff123','1317asd@#$ @$@$dff123'),(219,348,1,407,'',NULL,NULL,3,NULL,NULL,'2011-02-28 14:21:27','system','13@$$@','13@$$@','13@$$@'),(220,349,1,408,'',NULL,NULL,8,NULL,NULL,'2011-02-28 14:25:21','system','467@#$saj','467@#$saj','467@#$saj'),(221,350,1,409,'',NULL,NULL,1,NULL,NULL,'2011-02-28 15:05:14','system','467@#$saj','467@#$saj','467@#$saj'),(222,351,1,410,'',NULL,NULL,3,NULL,NULL,'2011-03-01 05:11:17','system','135466','135466','135466'),(223,352,1,411,'',NULL,NULL,0,NULL,NULL,'2011-03-01 06:54:01','system',NULL,NULL,NULL),(224,355,2,345,'',NULL,NULL,1,NULL,NULL,'2011-03-01 12:18:32','system','13235435','3425$#$#$%','@$%%^^@^'),(228,364,3,415,'',NULL,NULL,0,NULL,NULL,'2011-03-01 13:41:25','system','133413413','1313131','133413413 1313131'),(229,367,3,416,'',NULL,NULL,0,NULL,NULL,'2011-03-01 13:53:42','system','Tanveer','k','Tanveer k'),(230,368,3,417,'',NULL,NULL,0,NULL,NULL,'2011-03-01 14:02:16','system','Shanti','','Shanti '),(232,370,1,419,'',NULL,NULL,0,NULL,NULL,'2011-03-01 14:06:09','system','Accenture','Accenture','Accenture'),(233,371,3,420,'',NULL,NULL,0,NULL,NULL,'2011-03-01 14:07:54','system','Shanti','','Shanti '),(234,372,3,421,'',NULL,NULL,0,NULL,NULL,'2011-03-02 03:57:09','system','Preety','','Preety '),(236,374,3,423,'',NULL,NULL,0,NULL,NULL,'2011-03-02 06:06:35','system','1317asd@#$','@$@$dff123','1317asd@#$ @$@$dff123'),(237,382,1,424,'',NULL,NULL,0,NULL,NULL,'2011-03-08 12:22:20','system',NULL,NULL,NULL),(238,383,3,425,'',NULL,NULL,0,NULL,NULL,'2011-03-08 13:07:57','system','paru','patil','paru patil'),(239,384,3,426,'',NULL,NULL,0,NULL,NULL,'2011-03-08 13:26:51','system','raju','sanglad','raju sanglad'),(240,385,3,427,'',NULL,NULL,0,NULL,NULL,'2011-03-08 13:57:59','system','sandeep','Rajputh','sandeep Rajputh'),(241,386,2,424,'',NULL,NULL,0,NULL,NULL,'2011-03-08 14:18:00','system',NULL,NULL,'Basaveshwar Nagar');
/*!40000 ALTER TABLE `party_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party` (
  `party_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `party_type_cd` varchar(25) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `juridisction` mediumint(8) unsigned DEFAULT NULL,
  `timezone` tinyint(4) unsigned DEFAULT NULL,
  `memo` text,
  `party_type` tinyint(3) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `language` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fk_party_is_for_party_type` (`party_type`),
  KEY `fk_party_has_language` (`language`),
  KEY `fk_party_is_in_timezone` (`timezone`),
  KEY `fk_party_is_in_jurisdiction` (`juridisction`),
  CONSTRAINT `fk_party_has_language` FOREIGN KEY (`language`) REFERENCES `language` (`id`),
  CONSTRAINT `fk_party_has_party_type` FOREIGN KEY (`party_type`) REFERENCES `party_type` (`id`),
  CONSTRAINT `fk_party_is_in_jurisdiction` FOREIGN KEY (`juridisction`) REFERENCES `jurisdiction` (`id`),
  CONSTRAINT `fk_party_is_in_timezone` FOREIGN KEY (`timezone`) REFERENCES `timezone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=428 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (298,'Sai Tax Consultants',NULL,'\0',NULL,NULL,'system','2011-02-02 06:40:43',NULL,'2011-02-03 18:07:13',NULL,NULL,NULL,2,2,NULL),(299,'John Deere',NULL,'',NULL,NULL,'system','2011-02-02 06:54:41',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(300,'Sagar Best',NULL,'',NULL,NULL,'system','2011-02-02 06:56:59',NULL,NULL,NULL,NULL,NULL,1,2,NULL),(301,'Ady Vashisth',NULL,'',NULL,NULL,'system','2011-02-03 03:55:21',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(302,'Bank of America',NULL,'',NULL,NULL,'system','2011-02-03 03:56:36',NULL,NULL,NULL,NULL,NULL,2,2,NULL),(303,'sadsaasdsa',NULL,'\0',NULL,NULL,'system','2011-02-03 18:02:00',NULL,'2011-02-03 18:05:06',NULL,NULL,NULL,2,2,NULL),(304,'sadsaasdsa',NULL,'\0',NULL,NULL,'system','2011-02-03 18:02:01',NULL,'2011-02-03 18:06:56',NULL,NULL,NULL,2,1,NULL),(305,'Savitri',NULL,'',NULL,NULL,'system','2011-02-03 18:03:51',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(306,'Wali Assoiciates',NULL,'',NULL,NULL,'system','2011-02-04 01:24:06',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(307,'Gangadhar Wali',NULL,'',NULL,NULL,'system','2011-02-04 01:29:09',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(308,'Transforce Financial Serices',NULL,'',NULL,NULL,'system','2011-02-04 02:51:40',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(309,'JP Bangalore',NULL,'',NULL,NULL,'system','2011-02-04 02:55:55',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(310,'Delves Freer Anderson Raniga Caine',NULL,'',NULL,NULL,'system','2011-02-04 02:59:48',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(311,'Rajesh Raniga',NULL,'',NULL,NULL,'system','2011-02-04 03:01:55',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(312,'Aditya Finances',NULL,'',NULL,NULL,'system','2011-02-04 03:03:48',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(313,'Aditya Vashisth',NULL,'',NULL,NULL,'system','2011-02-04 03:05:11',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(314,'Bannikal Brothers',NULL,'',NULL,NULL,'system','2011-02-04 03:07:03',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(315,'Sagar Bannikal',NULL,'',NULL,NULL,'system','2011-02-04 03:08:38',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(316,'Savitri Tax Consultants',NULL,'',NULL,NULL,'system','2011-02-04 03:10:53',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(317,'Savitri Panchamanavar',NULL,'',NULL,NULL,'system','2011-02-04 03:12:23',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(318,'test',NULL,'\0',NULL,NULL,'system','2011-02-08 02:46:49',NULL,'2011-02-23 05:25:22',NULL,NULL,NULL,2,1,NULL),(320,'ABC Parts',NULL,'',NULL,NULL,'system','2011-02-08 05:26:24',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(321,'ABC Parts',NULL,'',NULL,NULL,'system','2011-02-08 05:28:18',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(322,'Sue Treen',NULL,'',NULL,NULL,'system','2011-02-08 05:51:41',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(323,'Rohit K',NULL,'',NULL,NULL,'system','2011-02-08 14:38:56',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(324,'Rajesh Raniga',NULL,'',NULL,NULL,'system','2011-02-09 02:54:15',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(325,'Rajesh Raniga',NULL,'',NULL,NULL,'system','2011-02-09 02:54:16',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(326,'Rajesh Raniga',NULL,'',NULL,NULL,'system','2011-02-09 02:54:16',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(327,'Royal Bank of Canada (RBC)',NULL,'',NULL,NULL,'system','2011-02-09 03:34:43',NULL,NULL,NULL,NULL,NULL,2,2,NULL),(328,NULL,NULL,'',NULL,NULL,'system','2011-02-09 03:35:25',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(329,'Vancity Savings Credit Union',NULL,'',NULL,NULL,'system','2011-02-09 03:39:43',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(330,'ICICI',NULL,'',NULL,NULL,'system','2011-02-09 04:03:40',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(331,'Compuserve',NULL,'',NULL,NULL,'system','2011-02-09 05:11:41',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(332,'Gudi Karakoona',NULL,'',NULL,NULL,'system','2011-02-09 06:43:57',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(333,'Shrinivas Gudi',NULL,'',NULL,NULL,'system','2011-02-09 06:55:40',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(334,'Infosys',NULL,'',NULL,NULL,'system','2011-02-09 06:58:04',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(335,'Narayana Murthy',NULL,'',NULL,NULL,'system','2011-02-09 07:03:56',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(336,'Ady Sharma',NULL,'',NULL,NULL,'system','2011-02-09 07:04:53',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(337,'Roshan Reddy',NULL,'',NULL,NULL,'system','2011-02-10 06:41:01',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(338,'Rajeshker Reddy',NULL,'',NULL,NULL,'system','2011-02-10 06:47:56',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(339,'Prashanth Keni',NULL,'',NULL,NULL,'system','2011-02-10 06:49:46',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(340,'Citibank',NULL,'',NULL,NULL,'system','2011-02-13 00:40:24',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(341,'Blank Rome',NULL,'',NULL,NULL,'system','2011-02-14 12:02:36',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(342,'John Mahony',NULL,'',NULL,NULL,'system','2011-02-15 04:46:31',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(343,'Patil Enterprises',NULL,'',NULL,NULL,'system','2011-02-15 06:56:12',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(344,'Anand Patil',NULL,'',NULL,NULL,'system','2011-02-15 07:00:03',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(345,'sanju',NULL,'',NULL,NULL,'system','2011-02-15 07:40:12',NULL,NULL,NULL,NULL,NULL,2,13,NULL),(346,'raju ',NULL,'',NULL,NULL,'system','2011-02-15 07:49:51',NULL,NULL,NULL,NULL,NULL,1,6,NULL),(347,'sandeep patil',NULL,'',NULL,NULL,'system','2011-02-15 08:20:44',NULL,NULL,NULL,NULL,NULL,1,3,NULL),(348,'madival sanglad',NULL,'',NULL,NULL,'system','2011-02-15 09:09:30',NULL,NULL,NULL,NULL,NULL,1,4,NULL),(349,'SBI',NULL,'',NULL,NULL,'system','2011-02-15 10:14:27',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(350,'SBM',NULL,'',NULL,NULL,'system','2011-02-15 10:14:50',NULL,NULL,NULL,NULL,NULL,2,3,NULL),(351,'shankar',NULL,'',NULL,NULL,'system','2011-02-15 10:30:56',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(352,'uday',NULL,'',NULL,NULL,'system','2011-02-15 10:31:17',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(353,'life time Insurance',NULL,'',NULL,NULL,'system','2011-02-15 10:39:17',NULL,NULL,NULL,NULL,NULL,2,2,NULL),(354,'guru',NULL,'',NULL,NULL,'system','2011-02-15 10:56:50',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(355,'ajay gouda',NULL,'',NULL,NULL,'system','2011-02-15 11:39:23',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(356,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(357,'TCS',NULL,'',NULL,NULL,'system','2011-02-16 04:11:43',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(358,'Ram Kumar',NULL,'',NULL,NULL,'system','2011-02-16 04:13:17',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(359,'Vasu Murthy',NULL,'',NULL,NULL,'system','2011-02-16 04:34:38',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(360,'Shree Enterprises',NULL,'',NULL,NULL,'system','2011-02-16 05:37:15',NULL,NULL,NULL,NULL,NULL,2,6,NULL),(361,'anand Association',NULL,'',NULL,NULL,'system','2011-02-16 06:09:02',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(362,'deepu Rajputh',NULL,'',NULL,NULL,'system','2011-02-16 06:14:10',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(363,'deepu Rajputh',NULL,'',NULL,NULL,'system','2011-02-16 06:19:57',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(364,'deepu Rajputh',NULL,'',NULL,NULL,'system','2011-02-16 06:21:26',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(365,'anil patil',NULL,'',NULL,NULL,'system','2011-02-16 06:33:50',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(366,'manju sanglad',NULL,'',NULL,NULL,'system','2011-02-16 06:43:56',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(367,'Tavalon',NULL,'',NULL,NULL,'system','2011-02-16 09:55:49',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(368,'veeresh Talloli',NULL,'',NULL,NULL,'system','2011-02-16 10:01:39',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(369,'rajesh pandith',NULL,'',NULL,NULL,'system','2011-02-16 10:06:29',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(370,'patil\'s Association',NULL,'',NULL,NULL,'system','2011-02-16 13:19:54',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(371,'basu pujer',NULL,'',NULL,NULL,'system','2011-02-16 13:28:43',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(372,'Bhanu ',NULL,'',NULL,NULL,'system','2011-02-17 07:26:19',NULL,NULL,NULL,NULL,NULL,1,6,NULL),(373,'ganesh ',NULL,'',NULL,NULL,'system','2011-02-17 11:16:25',NULL,NULL,NULL,NULL,NULL,1,2,NULL),(374,'Bhanu ',NULL,'',NULL,NULL,'system','2011-02-17 12:54:10',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(375,'raju sanglad',NULL,'',NULL,NULL,'system','2011-02-17 13:11:39',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(376,'roy Rajputh',NULL,'',NULL,NULL,'system','2011-02-18 06:31:16',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(377,'sandeep Association',NULL,'',NULL,NULL,'system','2011-02-18 06:39:02',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(378,'Sadeep',NULL,'',NULL,NULL,'system','2011-02-18 12:15:54',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(379,'raju sanglad',NULL,'',NULL,NULL,'system','2011-02-18 12:17:55',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(380,'sandeep pvt Lmt',NULL,'',NULL,NULL,'system','2011-02-19 06:26:08',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(381,'raju ',NULL,'',NULL,NULL,'system','2011-02-19 07:16:55',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(382,'anand pvt Lmt',NULL,'',NULL,NULL,'system','2011-02-19 08:01:32',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(383,'sagar patil',NULL,'',NULL,NULL,'system','2011-02-21 08:46:55',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(384,'sandeep ',NULL,'',NULL,NULL,'system','2011-02-21 08:53:47',NULL,NULL,NULL,NULL,NULL,1,2,NULL),(385,'madival ',NULL,'',NULL,NULL,'system','2011-02-21 09:03:42',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(386,'sandeep sanglad',NULL,'',NULL,NULL,'system','2011-02-21 09:58:12',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(387,'sandeep sanglad',NULL,'',NULL,NULL,'system','2011-02-21 09:59:21',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(388,'anand',NULL,'',NULL,NULL,'system','2011-02-21 10:05:02',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(389,'anand',NULL,'',NULL,NULL,'system','2011-02-21 10:05:12',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(390,'raju ',NULL,'',NULL,NULL,'system','2011-02-21 10:28:39',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(391,'raju ',NULL,'',NULL,NULL,'system','2011-02-21 10:30:16',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(392,'raju Rajputh',NULL,'',NULL,NULL,'system','2011-02-21 10:34:27',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(393,'sandeep ',NULL,'',NULL,NULL,'system','2011-02-21 10:57:38',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(394,'sandeep patil',NULL,'',NULL,NULL,'system','2011-02-21 11:21:54',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(395,'sandeep patil',NULL,'',NULL,NULL,'system','2011-02-21 11:23:34',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(396,'sandeep patil',NULL,'',NULL,NULL,'system','2011-02-21 11:24:39',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(397,'anand pvt Lmt',NULL,'',NULL,NULL,'system','2011-02-22 12:22:48',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(398,'madival ',NULL,'',NULL,NULL,'system','2011-02-23 12:39:56',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(399,'145@#$%ada ds@#$1452',NULL,'',NULL,NULL,'system','2011-02-23 13:15:11',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(400,'ds4536@#@',NULL,'',NULL,NULL,'system','2011-02-24 06:38:39',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(401,'#$%asa124',NULL,'',NULL,NULL,'system','2011-02-24 09:50:45',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(402,'145@#$%ada @$@$dff123',NULL,'',NULL,NULL,'system','2011-02-24 11:18:17',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(403,'Shanti k',NULL,'',NULL,NULL,'system','2011-02-25 05:27:47',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(404,'Sai Automobiles',NULL,'',NULL,NULL,'system','2011-02-26 23:15:00',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(405,'44543@$@fg 1324SFS@$45',NULL,'',NULL,NULL,'system','2011-02-27 07:21:41',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(406,'1317asd@#$ @$@$dff123',NULL,'',NULL,NULL,'system','2011-02-28 13:06:47',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(407,'13@$$@',NULL,'',NULL,NULL,'system','2011-02-28 14:21:27',NULL,NULL,NULL,NULL,NULL,2,3,NULL),(408,'467@#$saj',NULL,'',NULL,NULL,'system','2011-02-28 14:25:21',NULL,NULL,NULL,NULL,NULL,2,8,NULL),(409,'467@#$saj',NULL,'',NULL,NULL,'system','2011-02-28 15:05:14',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(410,'135466',NULL,'',NULL,NULL,'system','2011-03-01 05:11:17',NULL,NULL,NULL,NULL,NULL,2,3,NULL),(411,'ds4536@#@',NULL,'',NULL,NULL,'system','2011-03-01 06:54:01',NULL,NULL,NULL,NULL,NULL,2,0,NULL),(415,'133413413 1313131',NULL,'',NULL,NULL,'system','2011-03-01 13:41:25',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(416,'Tanveer k',NULL,'',NULL,NULL,'system','2011-03-01 13:53:42',NULL,NULL,NULL,NULL,NULL,1,1,NULL),(417,'Shanti ',NULL,'',NULL,NULL,'system','2011-03-01 14:02:16',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(419,'Accenture',NULL,'',NULL,NULL,'system','2011-03-01 14:06:09',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(420,'Shanti ',NULL,'',NULL,NULL,'system','2011-03-01 14:07:54',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(421,'Preety ',NULL,'',NULL,NULL,'system','2011-03-02 03:57:09',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(423,'1317asd@#$ @$@$dff123',NULL,'',NULL,NULL,'system','2011-03-02 06:06:35',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(424,'pooja Associates',NULL,'',NULL,NULL,'system','2011-03-08 12:22:20',NULL,NULL,NULL,NULL,NULL,2,1,NULL),(425,'paru patil',NULL,'',NULL,NULL,'system','2011-03-08 13:07:57',NULL,NULL,NULL,NULL,NULL,1,5,NULL),(426,'raju sanglad',NULL,'',NULL,NULL,'system','2011-03-08 13:26:51',NULL,NULL,NULL,NULL,NULL,1,3,NULL),(427,'sandeep Rajputh',NULL,'',NULL,NULL,'system','2011-03-08 13:57:59',NULL,NULL,NULL,NULL,NULL,1,0,NULL);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_info_reminder`
--

DROP TABLE IF EXISTS `tax_info_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_info_reminder` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reminder_day` smallint(6) DEFAULT NULL,
  `filing_type` smallint(11) unsigned DEFAULT NULL,
  `practice_info_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `reminder_is_for_practice` (`practice_info_id`),
  KEY `reminder_is_for_filing_type` (`filing_type`),
  CONSTRAINT `reminder_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `reminder_is_for_practice` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_reminder`
--

LOCK TABLES `tax_info_reminder` WRITE;
/*!40000 ALTER TABLE `tax_info_reminder` DISABLE KEYS */;
INSERT INTO `tax_info_reminder` VALUES (1,7,2,27,'','2011-03-08 08:39:26','system','system','2011-03-08 13:39:26',0),(2,30,2,27,'','2011-03-08 08:39:26','system','system','2011-03-08 13:39:26',0);
/*!40000 ALTER TABLE `tax_info_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `party_relationship_id` int(11) NOT NULL,
  `CREATED_BY` varchar(50) NOT NULL,
  `CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) NOT NULL,
  `UPDATED_DATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `username` (`username`),
  KEY `username_2` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin@firm.com','admin',1,143,'','2011-02-03 05:00:00','','2011-02-03 05:00:00'),('guest','admin',1,0,'','0000-00-00 00:00:00','','0000-00-00 00:00:00'),('vishnu_sharma@yahoo.com','password',1,138,'system','2011-01-31 10:00:00','system','2011-01-31 10:00:00'),('krishna@iscon.com','password',1,140,'system','2011-01-31 10:00:00','system','2011-01-31 10:00:00'),('james@chase.com','password',1,141,'system','2011-01-31 10:00:00','system','2011-01-31 10:00:00'),('sagar@sgar.com','password',1,143,'system','2011-02-02 05:00:00','system','2011-02-02 05:00:00'),('ady@yahoo.com','password',1,170,'system','2011-02-02 05:00:00','system','2011-02-02 05:00:00'),('bvbwali@yahoo.com','password',1,146,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('jp1@telus.net','password',1,147,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('rraniga@uniserve.com','password',1,148,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('adityavashisht@yahoo.com','password',1,149,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('sagar_bannikal_098@yahoo.com','password',1,150,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('savitrisp@gmail.com','password',1,151,'system','2011-02-03 05:00:00','system','2011-02-03 05:00:00'),('rohit@yahoo.com','password',1,158,'system','2011-02-08 05:00:00','system','2011-02-08 05:00:00'),('srgudi@yahoo.com','password',1,167,'system','2011-02-09 05:00:00','system','2011-02-09 05:00:00'),('patil.anand677@gmail.com','password',1,178,'system','2011-02-15 05:00:00','system','2011-02-15 05:00:00'),('prashanth@gmail.com','password',1,173,'system','2011-02-15 05:00:00','system','2011-02-15 05:00:00'),('deepu@yahoo.com','password',1,196,'system','2011-02-16 05:00:00','system','2011-02-16 05:00:00'),('anil$@gmail.com','password',1,199,'system','2011-02-16 05:00:00','system','2011-02-16 05:00:00'),('manju@gmail.com','password',1,200,'system','2011-02-16 05:00:00','system','2011-02-16 05:00:00'),('raju@gmail.com','password',1,213,'system','2011-02-18 05:00:00','system','2011-02-18 05:00:00'),('sandeep@gmail.com','password',1,221,'system','2011-02-21 05:00:00','system','2011-02-21 05:00:00'),('deepu#yahoo.com','password',1,223,'system','2011-02-21 05:00:00','system','2011-02-21 05:00:00'),('deepu1@yahoo.com','password',1,228,'system','2011-02-21 05:00:00','system','2011-02-21 05:00:00'),('tanveer@gamil.om','password',1,244,'system','2011-03-01 05:00:00','system','2011-03-01 05:00:00'),('preety@gmail.com','password',1,245,'system','2011-03-01 05:00:00','system','2011-03-01 05:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communication_type`
--

DROP TABLE IF EXISTS `communication_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communication_type` (
  `id` smallint(6) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  `phone_indicator` bit(1) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communication_type`
--

LOCK TABLES `communication_type` WRITE;
/*!40000 ALTER TABLE `communication_type` DISABLE KEYS */;
INSERT INTO `communication_type` VALUES (1,'Email','Email Address','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'\0',''),(2,'Fax','Fax','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'\0',''),(3,'Office','Office Phone','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'',''),(4,'Home','Home Phone','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'',''),(5,'Mobile','Mobile Phone','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'',''),(6,'Other','Other Phone','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'',''),(7,'Web Site','Web Site URL -1','2010-07-16 10:04:45','system','system','2010-07-16 10:04:57',0,'\0','');
/*!40000 ALTER TABLE `communication_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_account`
--

DROP TABLE IF EXISTS `party_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_account` (
  `party_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `account_number` varchar(50) NOT NULL,
  `account_type` bigint(20) unsigned DEFAULT NULL,
  `party_site_id` bigint(20) unsigned DEFAULT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `active_flag` bit(1) NOT NULL,
  `create_user_id` varchar(25) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `terms` varchar(2000) DEFAULT NULL,
  `account_category` bigint(20) unsigned DEFAULT NULL,
  `account_entity_name` varchar(50) DEFAULT NULL,
  `address_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkeea0f2df3f2a9147` (`party_id`),
  KEY `fkeea0f2df6dd29fe7` (`party_site_id`),
  CONSTRAINT `fk_party_account_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_party_relationship_account_is_for_a_site` FOREIGN KEY (`party_site_id`) REFERENCES `party_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_account`
--

LOCK TABLES `party_account` WRITE;
/*!40000 ALTER TABLE `party_account` DISABLE KEYS */;
INSERT INTO `party_account` VALUES (299,'999884567',800,101,8,'','system','2011-02-03 04:10:35',0,NULL,NULL,'Direct Deposit account',700,NULL,NULL),(318,'15',804,128,9,'','system','2011-02-09 04:21:03',0,NULL,NULL,'testing',700,NULL,NULL),(318,'6778899999',853,139,10,'','system','2011-02-14 12:05:03',0,NULL,NULL,'testing',703,NULL,NULL),(318,'1222',803,NULL,11,'','system','2011-02-15 08:12:58',0,NULL,NULL,'1111',700,'Bank of America',206),(318,'1222',803,NULL,12,'','system','2011-02-15 08:20:30',0,NULL,NULL,'1111',700,'Something else',207),(345,'647895462365',801,149,13,'','system','2011-02-15 10:28:22',0,NULL,NULL,'',700,NULL,NULL),(345,'974856712355',857,150,14,'','system','2011-02-15 10:36:44',0,NULL,NULL,'',703,NULL,NULL),(345,'1245',822,151,15,'','system','2011-02-15 10:54:49',0,NULL,NULL,'',701,NULL,NULL),(345,'235685858',NULL,153,16,'','system','2011-02-15 11:09:46',0,NULL,NULL,'',702,NULL,NULL),(345,'1452669896=876',802,155,17,'','system','2011-02-15 12:27:02',0,NULL,NULL,'',700,NULL,NULL),(345,'12455+=458878',802,155,18,'','system','2011-02-15 12:29:22',0,NULL,NULL,'',700,NULL,NULL),(318,'234567',803,NULL,19,'','system','2011-02-15 13:41:29',0,NULL,NULL,'345678',700,'ICIICI Bank',218),(318,'999884567',801,NULL,20,'','system','2011-02-15 13:47:25',0,NULL,NULL,'23455',700,'HDBC',219),(318,'6778899999',804,NULL,51,'','system','2011-02-17 14:45:20',0,NULL,NULL,'te',700,'Bank Of India',276),(345,'9745556898989',801,NULL,52,'','system','2011-02-17 14:46:18',0,NULL,NULL,'',700,'Karnataka Bank',277),(345,'45488799966',852,NULL,53,'','system','2011-02-17 14:47:57',0,NULL,NULL,'',703,'Karnataka Bank',278),(318,'456',802,NULL,54,'','system','2011-02-17 14:56:41',0,NULL,NULL,'testing',700,'Punjab',279),(345,'0047896547000',805,NULL,55,'','system','2011-02-18 05:31:10',0,NULL,NULL,'',700,'SBM',280),(345,'12457896454',864,NULL,56,'','system','2011-02-18 05:40:16',0,NULL,NULL,'',703,'SBM',281),(345,'1234',822,NULL,57,'','system','2011-02-18 05:42:36',0,NULL,NULL,'',701,'credit',282),(345,'45488799966',NULL,NULL,58,'','system','2011-02-18 05:44:27',0,NULL,NULL,'',702,'ravi',283),(318,'15',804,NULL,59,'','system','2011-02-18 05:57:40',0,NULL,NULL,'testing',700,'City Bank',284),(345,'1458525=+214',806,NULL,60,'','system','2011-02-18 07:01:20',0,NULL,NULL,'',700,'SBM',287),(345,'45488799966',801,NULL,61,'','system','2011-02-18 07:11:17',0,NULL,NULL,'',700,'credit',288),(345,'9745556898989',802,NULL,62,'','system','2011-02-18 07:24:02',0,NULL,NULL,'',700,'credit',289),(345,'4785+=469999',857,NULL,63,'','system','2011-02-18 07:27:32',1,NULL,NULL,'',703,'sbi',290),(345,'45488799966',852,NULL,64,'','system','2011-02-18 07:35:26',0,NULL,NULL,'',703,'credit',291),(345,'qrwerwerw',1492,NULL,65,'','system','2011-02-18 07:39:05',2,NULL,NULL,'',701,'Karnataka Bank',292),(345,'4785469999',821,NULL,66,'','system','2011-02-18 07:50:34',0,NULL,NULL,'',701,'SBM',293),(345,'97455#=56898989',NULL,NULL,67,'','system','2011-02-18 07:52:24',1,NULL,NULL,'',702,'ravi',294),(345,'147856977',NULL,NULL,68,'','system','2011-02-18 07:57:31',0,NULL,NULL,'',702,'shankar',295),(345,'45488799966',801,NULL,69,'','system','2011-02-21 06:13:18',0,NULL,NULL,'',700,'SBM',304),(345,'4785469999',852,NULL,70,'','system','2011-02-21 07:07:54',0,NULL,NULL,'',703,'Karnataka Bank',305),(345,'4785469999',1492,NULL,71,'','system','2011-02-21 07:21:46',0,NULL,NULL,'',701,'SBM',306),(345,'454887#=99966',821,NULL,72,'','system','2011-02-21 07:24:16',1,NULL,NULL,'',701,'sbi',307),(345,'45488799966',NULL,NULL,73,'','system','2011-02-21 07:26:24',0,NULL,NULL,'',702,'santhosh',308),(345,'454887#=99966',NULL,NULL,74,'','system','2011-02-21 07:28:19',0,NULL,NULL,'',702,'mallu',309),(345,'454887#=99966',855,NULL,75,'','system','2011-02-21 07:45:07',0,NULL,NULL,'',703,'Karnataka Bank',310),(345,'454887#=99966',822,NULL,76,'','system','2011-02-21 08:00:59',0,NULL,NULL,'',701,'Karnataka Bank',311),(345,'454887#=99966',NULL,NULL,77,'','system','2011-02-21 08:04:31',0,NULL,NULL,'',702,'Karnataka Bank',312),(345,'asgghjl',NULL,NULL,78,'','system','2011-02-23 13:27:49',0,NULL,NULL,'',702,'125555@#$%',332),(345,'asdgfhjkl',803,NULL,79,'','system','2011-02-24 13:30:29',0,NULL,NULL,'',700,'1234566789',337),(345,'dggfhhgjkg',801,NULL,80,'','system','2011-02-25 05:09:23',0,NULL,NULL,'',700,'123sda@#$%',338),(345,'adghs@$@$',851,NULL,81,'','system','2011-02-25 05:25:49',0,NULL,NULL,'',703,'@#$asda124',339),(404,'3456789',803,NULL,82,'','system','2011-02-26 23:17:22',0,NULL,NULL,'None',700,'Citi Bank',342),(404,'1234567',801,NULL,84,'','system','2011-02-27 03:06:36',0,NULL,NULL,'none',700,'Bank of India',344),(404,'234',803,NULL,85,'','system','2011-02-27 06:08:47',0,NULL,NULL,'testing',700,'SBI',345),(345,'@$^Z46',856,NULL,88,'','system','2011-03-01 12:27:33',1,NULL,NULL,'',703,'#$%$^%%^',356),(345,'asdfghjk',822,NULL,90,'','system','2011-03-01 13:06:14',0,NULL,NULL,'',701,'123456',358),(345,'454887#=99966',854,NULL,92,'','system','2011-03-01 13:08:23',0,NULL,NULL,'',703,'125555@#$%',360),(345,'133253256',801,NULL,96,'','system','2011-03-04 06:15:28',0,NULL,NULL,'',700,'rerewt',379),(345,'45488799966',804,NULL,97,'','system','2011-03-04 11:56:40',0,NULL,NULL,'',700,'Karnataka Bank',380),(345,'45488799966',801,NULL,98,'','system','2011-03-04 11:56:43',1,NULL,NULL,'',700,'Karnataka Bank',381);
/*!40000 ALTER TABLE `party_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_code`
--

DROP TABLE IF EXISTS `party_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_id` bigint(20) unsigned NOT NULL,
  `party_id` bigint(20) unsigned NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(30) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk3b3907c64b78cfda` (`party_id`),
  KEY `fk3b3907c6384382ba` (`code_id`),
  CONSTRAINT `fk3b3907c64b78cfda` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_party_cd_is_a_code` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  CONSTRAINT `fk_party_cd_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_code`
--

LOCK TABLES `party_code` WRITE;
/*!40000 ALTER TABLE `party_code` DISABLE KEYS */;
INSERT INTO `party_code` VALUES (1,1462,314,'2011-02-08 23:16:08','system',0,1,NULL,NULL,''),(2,1463,314,'2011-02-08 23:17:41','system',0,2,NULL,NULL,''),(3,1464,314,'2011-02-08 23:24:10','system',0,2,NULL,NULL,''),(4,1465,314,'2011-02-08 23:24:36','system',0,3,NULL,NULL,''),(5,1466,310,'2011-02-09 00:17:55','system',0,1,NULL,NULL,''),(6,1467,310,'2011-02-09 00:19:16','system',0,1,NULL,NULL,''),(7,1468,310,'2011-02-09 00:27:45','system',0,1,NULL,NULL,''),(8,1469,310,'2011-02-09 23:06:56','system',0,1,NULL,NULL,''),(9,1470,310,'2011-02-09 23:07:43','system',0,1,NULL,NULL,''),(10,1471,310,'2011-02-09 23:09:29','system',0,1,NULL,NULL,''),(11,1485,343,'2011-02-15 07:10:47','system',0,2,NULL,NULL,''),(12,1486,343,'2011-02-15 07:12:41','system',0,3,NULL,NULL,''),(13,1489,343,'2011-02-16 04:34:08','system',0,2,NULL,NULL,''),(14,1491,343,'2011-02-17 08:48:11','system',0,2,NULL,NULL,''),(15,1493,343,'2011-02-18 03:10:31','system',0,3,NULL,NULL,''),(16,1494,343,'2011-02-18 03:34:36','system',0,2,NULL,NULL,''),(17,1495,343,'2011-02-21 04:00:00','system',0,3,NULL,NULL,''),(18,1496,343,'2011-02-21 04:28:43','system',0,3,NULL,NULL,''),(19,1501,343,'2011-02-28 08:21:59','system',0,2,NULL,NULL,''),(20,1503,343,'2011-03-01 08:56:41','system',1,1245245422,NULL,NULL,''),(21,1506,343,'2011-03-02 02:12:51','system',0,1245245422,NULL,NULL,'');
/*!40000 ALTER TABLE `party_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_site_communication`
--

DROP TABLE IF EXISTS `party_site_communication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_site_communication` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `communication_type` smallint(6) unsigned NOT NULL,
  `party_site_id` bigint(20) unsigned DEFAULT NULL,
  `contact_detail` varchar(255) DEFAULT NULL,
  `best_time_to_contact` varchar(100) DEFAULT NULL,
  `preferred_flag` bit(1) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) NOT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_title` varchar(50) DEFAULT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `sub_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkeeac7ad76dd29fe7` (`party_site_id`),
  KEY `fk_party_site_communication_for_communication_type` (`communication_type`),
  KEY `fk_party_site_communication_is_for_party` (`party_id`),
  CONSTRAINT `fk_party_site_communication_for_communication_type` FOREIGN KEY (`communication_type`) REFERENCES `communication_type` (`id`),
  CONSTRAINT `fk_party_site_communication_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_party_site_communication_is_for_party_site` FOREIGN KEY (`party_site_id`) REFERENCES `party_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=741 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_site_communication`
--

LOCK TABLES `party_site_communication` WRITE;
/*!40000 ALTER TABLE `party_site_communication` DISABLE KEYS */;
INSERT INTO `party_site_communication` VALUES (249,3,97,'7031111234',NULL,NULL,0,'','2011-02-02 06:40:43','system',NULL,'system',NULL,NULL,NULL,NULL),(250,1,97,'sai@tax.com',NULL,NULL,0,'','2011-02-02 06:40:43','system',NULL,'system',NULL,NULL,NULL,NULL),(251,2,97,'18889991234',NULL,NULL,0,'','2011-02-02 06:40:43','system',NULL,'system',NULL,NULL,NULL,NULL),(252,7,97,'www.default.com',NULL,NULL,0,'','2011-02-02 06:40:43','system',NULL,'system',NULL,NULL,NULL,NULL),(253,3,98,'7031111234',NULL,NULL,0,'','2011-02-02 06:56:59','system',NULL,'system',NULL,NULL,NULL,NULL),(254,1,98,'sagar@sgar.com',NULL,NULL,0,'','2011-02-02 06:56:59','system',NULL,'system',NULL,NULL,NULL,NULL),(255,2,98,'18889991234',NULL,NULL,0,'','2011-02-02 06:56:59','system',NULL,'system',NULL,NULL,NULL,NULL),(256,7,98,'www.default.com',NULL,NULL,0,'','2011-02-02 06:56:59','system',NULL,'system',NULL,NULL,NULL,NULL),(257,3,99,'7031111234',NULL,NULL,0,'','2011-02-03 03:55:21','system',NULL,'system',NULL,NULL,NULL,NULL),(258,1,99,'ady@yahoo.com',NULL,NULL,0,'','2011-02-03 03:55:21','system',NULL,'system',NULL,NULL,NULL,NULL),(259,2,99,'1112345678',NULL,NULL,0,'','2011-02-03 03:55:21','system',NULL,'system',NULL,NULL,NULL,NULL),(260,7,99,'www.default.com',NULL,NULL,0,'','2011-02-03 03:55:21','system',NULL,'system',NULL,NULL,NULL,NULL),(261,3,100,'7031112345',NULL,NULL,0,'','2011-02-03 03:59:38','system',NULL,'system',NULL,NULL,NULL,NULL),(262,1,100,'john@boa.com',NULL,NULL,0,'','2011-02-03 03:59:38','system',NULL,'system',NULL,NULL,NULL,NULL),(263,2,100,'1112345678',NULL,NULL,0,'','2011-02-03 03:59:38','system',NULL,'system',NULL,NULL,NULL,NULL),(264,7,100,'www.boa.com',NULL,NULL,0,'','2011-02-03 03:59:38','system',NULL,'system',NULL,NULL,NULL,NULL),(265,3,101,'7031112345',NULL,NULL,0,'','2011-02-03 04:09:00','system',NULL,'system',NULL,NULL,NULL,NULL),(266,1,101,'john@boa.com',NULL,NULL,0,'','2011-02-03 04:09:00','system',NULL,'system',NULL,NULL,NULL,NULL),(267,2,101,'1112345678',NULL,NULL,0,'','2011-02-03 04:09:00','system',NULL,'system',NULL,NULL,NULL,NULL),(268,7,101,'www.boa.com',NULL,NULL,0,'','2011-02-03 04:09:00','system',NULL,'system',NULL,NULL,NULL,NULL),(269,4,102,'87897',NULL,NULL,0,'','2011-02-03 18:02:00','system',NULL,'system',NULL,NULL,NULL,NULL),(270,1,102,'dsad@nv.com',NULL,NULL,0,'','2011-02-03 18:02:00','system',NULL,'system',NULL,NULL,NULL,NULL),(271,2,102,'jk',NULL,NULL,0,'','2011-02-03 18:02:00','system',NULL,'system',NULL,NULL,NULL,NULL),(272,7,102,'www.default.com',NULL,NULL,0,'','2011-02-03 18:02:00','system',NULL,'system',NULL,NULL,NULL,NULL),(273,4,103,'87897',NULL,NULL,0,'','2011-02-03 18:02:01','system',NULL,'system',NULL,NULL,NULL,NULL),(274,1,103,'dsad@nv.com',NULL,NULL,0,'','2011-02-03 18:02:01','system',NULL,'system',NULL,NULL,NULL,NULL),(275,2,103,'jk',NULL,NULL,0,'','2011-02-03 18:02:01','system',NULL,'system',NULL,NULL,NULL,NULL),(276,7,103,'www.default.com',NULL,NULL,0,'','2011-02-03 18:02:01','system',NULL,'system',NULL,NULL,NULL,NULL),(277,3,104,'888',NULL,NULL,0,'','2011-02-03 18:03:52','system',NULL,'system',NULL,NULL,NULL,NULL),(278,1,104,'7677@gmail.com',NULL,NULL,0,'','2011-02-03 18:03:52','system',NULL,'system',NULL,NULL,NULL,NULL),(279,2,104,'87897978978',NULL,NULL,0,'','2011-02-03 18:03:52','system',NULL,'system',NULL,NULL,NULL,NULL),(280,7,104,'www.default.com',NULL,NULL,0,'','2011-02-03 18:03:52','system',NULL,'system',NULL,NULL,NULL,NULL),(281,3,102,'',NULL,NULL,0,'','2011-02-03 18:05:39','system',NULL,'system',NULL,NULL,NULL,NULL),(286,5,106,'9972344799',NULL,NULL,0,'','2011-02-04 01:24:06','system',NULL,'system',NULL,NULL,NULL,NULL),(287,1,106,'bvbwali@yahoo.com',NULL,NULL,0,'','2011-02-04 01:24:06','system',NULL,'system',NULL,NULL,NULL,NULL),(288,2,106,'998812345',NULL,NULL,0,'','2011-02-04 01:24:06','system',NULL,'system',NULL,NULL,NULL,NULL),(289,7,106,'www.default.com',NULL,NULL,0,'','2011-02-04 01:24:06','system',NULL,'system',NULL,NULL,NULL,NULL),(290,5,107,'9972344799',NULL,NULL,0,'','2011-02-04 01:29:09','system',NULL,'system',NULL,NULL,NULL,NULL),(291,1,107,'bvbwali@yahoo.com',NULL,NULL,0,'','2011-02-04 01:29:09','system',NULL,'system',NULL,NULL,NULL,NULL),(292,2,107,'8812345',NULL,NULL,0,'','2011-02-04 01:29:09','system',NULL,'system',NULL,NULL,NULL,NULL),(293,7,107,'www.default.com',NULL,NULL,0,'','2011-02-04 01:29:09','system',NULL,'system',NULL,NULL,NULL,NULL),(294,3,108,'7031111234',NULL,NULL,0,'','2011-02-04 02:51:40','system',NULL,'system',NULL,NULL,NULL,NULL),(295,1,108,'taxman@tf.com',NULL,NULL,0,'','2011-02-04 02:51:40','system',NULL,'system',NULL,NULL,NULL,NULL),(296,2,108,'1112345678',NULL,NULL,0,'','2011-02-04 02:51:40','system',NULL,'system',NULL,NULL,NULL,NULL),(297,7,108,'www.default.com',NULL,NULL,0,'','2011-02-04 02:51:40','system',NULL,'system',NULL,NULL,NULL,NULL),(298,5,109,'6045917103',NULL,NULL,0,'','2011-02-04 02:55:55','system',NULL,'system',NULL,NULL,NULL,NULL),(299,1,109,'jp1@telus.net',NULL,NULL,0,'','2011-02-04 02:55:55','system',NULL,'system',NULL,NULL,NULL,NULL),(300,2,109,'1112345678',NULL,NULL,0,'','2011-02-04 02:55:55','system',NULL,'system',NULL,NULL,NULL,NULL),(301,7,109,'www.default.com',NULL,NULL,0,'','2011-02-04 02:55:55','system',NULL,'system',NULL,NULL,NULL,NULL),(302,3,110,'6045888377',NULL,NULL,0,'','2011-02-04 02:59:48','system',NULL,'system',NULL,NULL,NULL,NULL),(303,1,110,'rraniga@uniserve.com',NULL,NULL,0,'','2011-02-04 02:59:48','system',NULL,'system',NULL,NULL,NULL,NULL),(304,2,110,'604-588-1187',NULL,NULL,0,'','2011-02-04 02:59:48','system',NULL,'system',NULL,NULL,NULL,NULL),(305,7,110,'www.default.com',NULL,NULL,0,'','2011-02-04 02:59:48','system',NULL,'system',NULL,NULL,NULL,NULL),(306,3,111,'6045888377',NULL,NULL,0,'','2011-02-04 03:01:55','system',NULL,'system',NULL,NULL,NULL,NULL),(307,1,111,'rraniga@uniserve.com',NULL,NULL,0,'','2011-02-04 03:01:55','system',NULL,'system',NULL,NULL,NULL,NULL),(308,2,111,'604-588-1187',NULL,NULL,0,'','2011-02-04 03:01:55','system',NULL,'system',NULL,NULL,NULL,NULL),(309,7,111,'www.default.com',NULL,NULL,0,'','2011-02-04 03:01:55','system',NULL,'system',NULL,NULL,NULL,NULL),(310,3,112,'7031111234',NULL,NULL,0,'','2011-02-04 03:03:48','system',NULL,'system',NULL,NULL,NULL,NULL),(311,1,112,'adityavashisht@yahoo.com',NULL,NULL,0,'','2011-02-04 03:03:48','system',NULL,'system',NULL,NULL,NULL,NULL),(312,2,112,'1112345678',NULL,NULL,0,'','2011-02-04 03:03:48','system',NULL,'system',NULL,NULL,NULL,NULL),(313,7,112,'www.default.com',NULL,NULL,0,'','2011-02-04 03:03:48','system',NULL,'system',NULL,NULL,NULL,NULL),(314,3,113,'7031111234',NULL,NULL,0,'','2011-02-04 03:05:11','system',NULL,'system',NULL,NULL,NULL,NULL),(315,1,113,'adityavashisht@yahoo.com',NULL,NULL,0,'','2011-02-04 03:05:11','system',NULL,'system',NULL,NULL,NULL,NULL),(316,2,113,'1112345678',NULL,NULL,0,'','2011-02-04 03:05:11','system',NULL,'system',NULL,NULL,NULL,NULL),(317,7,113,'www.default.com',NULL,NULL,0,'','2011-02-04 03:05:11','system',NULL,'system',NULL,NULL,NULL,NULL),(318,3,114,'6045888377',NULL,NULL,0,'','2011-02-04 03:07:03','system',NULL,'system',NULL,NULL,NULL,NULL),(319,1,114,'sagar_bannikal_098@yahoo.com',NULL,NULL,0,'','2011-02-04 03:07:03','system',NULL,'system',NULL,NULL,NULL,NULL),(320,2,114,'1112345678',NULL,NULL,0,'','2011-02-04 03:07:03','system',NULL,'system',NULL,NULL,NULL,NULL),(321,7,114,'www.default.com',NULL,NULL,0,'','2011-02-04 03:07:03','system',NULL,'system',NULL,NULL,NULL,NULL),(322,3,115,'7031111234',NULL,NULL,0,'','2011-02-04 03:08:38','system',NULL,'system',NULL,NULL,NULL,NULL),(323,1,115,'sagar_bannikal_098@yahoo.com',NULL,NULL,0,'','2011-02-04 03:08:38','system',NULL,'system',NULL,NULL,NULL,NULL),(324,2,115,'1112345678',NULL,NULL,0,'','2011-02-04 03:08:38','system',NULL,'system',NULL,NULL,NULL,NULL),(325,7,115,'www.default.com',NULL,NULL,0,'','2011-02-04 03:08:38','system',NULL,'system',NULL,NULL,NULL,NULL),(326,3,116,'7031111234',NULL,NULL,0,'','2011-02-04 03:10:53','system',NULL,'system',NULL,NULL,NULL,NULL),(327,1,116,'savitrisp@gmail.com',NULL,NULL,0,'','2011-02-04 03:10:53','system',NULL,'system',NULL,NULL,NULL,NULL),(328,2,116,'1112345678',NULL,NULL,0,'','2011-02-04 03:10:53','system',NULL,'system',NULL,NULL,NULL,NULL),(329,7,116,'www.default.com',NULL,NULL,0,'','2011-02-04 03:10:53','system',NULL,'system',NULL,NULL,NULL,NULL),(330,3,117,'7031111234',NULL,NULL,0,'','2011-02-04 03:12:24','system',NULL,'system',NULL,NULL,NULL,NULL),(331,1,117,'savitrisp@gmail.com',NULL,NULL,0,'','2011-02-04 03:12:24','system',NULL,'system',NULL,NULL,NULL,NULL),(332,2,117,'1112345678',NULL,NULL,0,'','2011-02-04 03:12:24','system',NULL,'system',NULL,NULL,NULL,NULL),(333,7,117,'www.default.com',NULL,NULL,0,'','2011-02-04 03:12:24','system',NULL,'system',NULL,NULL,NULL,NULL),(338,3,123,'250-778-5899',NULL,NULL,0,'','2011-02-08 06:06:19','system',NULL,'system',NULL,NULL,NULL,NULL),(339,1,123,'ed@don.com',NULL,NULL,0,'','2011-02-08 06:06:19','system',NULL,'system',NULL,NULL,NULL,NULL),(340,2,123,'2507789658',NULL,NULL,0,'','2011-02-08 06:06:19','system',NULL,'system',NULL,NULL,NULL,NULL),(341,7,123,'www.hero.com',NULL,NULL,0,'','2011-02-08 06:06:19','system',NULL,'system',NULL,NULL,NULL,NULL),(342,3,123,'250-778-5897',NULL,NULL,0,'','2011-02-08 06:06:19','system',NULL,'system',NULL,NULL,NULL,NULL),(343,3,124,'9916899999',NULL,NULL,0,'','2011-02-08 14:38:56','system',NULL,'system',NULL,NULL,NULL,NULL),(344,1,124,'rohit@yahoo.com',NULL,NULL,0,'','2011-02-08 14:38:56','system',NULL,'system',NULL,NULL,NULL,NULL),(345,2,124,'4543534534',NULL,NULL,0,'','2011-02-08 14:38:56','system',NULL,'system',NULL,NULL,NULL,NULL),(346,7,124,'www.default.com',NULL,NULL,0,'','2011-02-08 14:38:56','system',NULL,'system',NULL,NULL,NULL,NULL),(347,3,125,'604-588-1187',NULL,NULL,0,'','2011-02-09 02:54:15','system',NULL,'system',NULL,NULL,NULL,NULL),(348,1,125,'raniga@dfarc.com',NULL,NULL,0,'','2011-02-09 02:54:15','system',NULL,'system',NULL,NULL,NULL,NULL),(349,2,125,'604-588-8377',NULL,NULL,0,'','2011-02-09 02:54:15','system',NULL,'system',NULL,NULL,NULL,NULL),(350,7,125,'www.default.com',NULL,NULL,0,'','2011-02-09 02:54:15','system',NULL,'system',NULL,NULL,NULL,NULL),(351,3,126,'604-588-1187',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(352,1,126,'raniga@dfarc.com',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(353,2,126,'604-588-8377',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(354,7,126,'www.default.com',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(355,3,127,'604-588-1187',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(356,1,127,'raniga@dfarc.com',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(357,2,127,'604-588-8377',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(358,7,127,'www.default.com',NULL,NULL,0,'','2011-02-09 02:54:16','system',NULL,'system',NULL,NULL,NULL,NULL),(359,3,128,'8002345678',NULL,NULL,0,'','2011-02-09 04:20:18','system',NULL,'system',NULL,NULL,NULL,NULL),(360,1,128,'icici@gmail.com',NULL,NULL,0,'','2011-02-09 04:20:18','system',NULL,'system',NULL,NULL,NULL,NULL),(361,2,128,'18002345678',NULL,NULL,0,'','2011-02-09 04:20:18','system',NULL,'system',NULL,NULL,NULL,NULL),(362,7,128,'www.icici.com',NULL,NULL,0,'','2011-02-09 04:20:18','system',NULL,'system',NULL,NULL,NULL,NULL),(363,3,129,'604-588-8369',NULL,NULL,0,'','2011-02-09 04:56:30','system',NULL,'system',NULL,NULL,NULL,NULL),(364,1,129,'yad@rbc.ca',NULL,NULL,0,'','2011-02-09 04:56:30','system',NULL,'system',NULL,NULL,NULL,NULL),(365,2,129,'604-1123589',NULL,NULL,0,'','2011-02-09 04:56:30','system',NULL,'system',NULL,NULL,NULL,NULL),(366,7,129,'www.rbc.ca',NULL,NULL,0,'','2011-02-09 04:56:30','system',NULL,'system',NULL,NULL,NULL,NULL),(367,3,130,'7031111234',NULL,NULL,0,'','2011-02-09 06:43:57','system',NULL,'system',NULL,NULL,NULL,NULL),(368,1,130,'srgudi@yahoo.com',NULL,NULL,0,'','2011-02-09 06:43:58','system',NULL,'system',NULL,NULL,NULL,NULL),(369,2,130,'1112345678',NULL,NULL,0,'','2011-02-09 06:43:58','system',NULL,'system',NULL,NULL,NULL,NULL),(370,7,130,'www.default.com',NULL,NULL,0,'','2011-02-09 06:43:58','system',NULL,'system',NULL,NULL,NULL,NULL),(371,3,131,'7031111234',NULL,NULL,0,'','2011-02-09 06:55:41','system',NULL,'system',NULL,NULL,NULL,NULL),(372,1,131,'srgudi@yahoo.com',NULL,NULL,0,'','2011-02-09 06:55:41','system',NULL,'system',NULL,NULL,NULL,NULL),(373,2,131,'1112345678',NULL,NULL,0,'','2011-02-09 06:55:41','system',NULL,'system',NULL,NULL,NULL,NULL),(374,7,131,'www.default.com',NULL,NULL,0,'','2011-02-09 06:55:41','system',NULL,'system',NULL,NULL,NULL,NULL),(375,3,133,'7031111234',NULL,NULL,0,'','2011-02-09 07:03:56','system',NULL,'system',NULL,NULL,NULL,NULL),(376,1,133,'ram_sharma@yahoo.com',NULL,NULL,0,'','2011-02-09 07:03:56','system',NULL,'system',NULL,NULL,NULL,NULL),(377,2,133,'1112345678',NULL,NULL,0,'','2011-02-09 07:03:56','system',NULL,'system',NULL,NULL,NULL,NULL),(378,7,133,'www.default.com',NULL,NULL,0,'','2011-02-09 07:03:56','system',NULL,'system',NULL,NULL,NULL,NULL),(379,3,134,'7031111234',NULL,NULL,0,'','2011-02-09 07:04:53','system',NULL,'system',NULL,NULL,NULL,NULL),(380,1,134,'ady@yahoo.com',NULL,NULL,0,'','2011-02-09 07:04:53','system',NULL,'system',NULL,NULL,NULL,NULL),(381,2,134,'1112345678',NULL,NULL,0,'','2011-02-09 07:04:53','system',NULL,'system',NULL,NULL,NULL,NULL),(382,7,134,'www.default.com',NULL,NULL,0,'','2011-02-09 07:04:53','system',NULL,'system',NULL,NULL,NULL,NULL),(383,3,135,'9916899999',NULL,NULL,0,'','2011-02-10 06:41:01','system',NULL,'system',NULL,NULL,NULL,NULL),(384,1,135,'roshan@gmail.com',NULL,NULL,0,'','2011-02-10 06:41:01','system',NULL,'system',NULL,NULL,NULL,NULL),(385,2,135,'4543534534',NULL,NULL,0,'','2011-02-10 06:41:01','system',NULL,'system',NULL,NULL,NULL,NULL),(386,7,135,'www.default.com',NULL,NULL,0,'','2011-02-10 06:41:01','system',NULL,'system',NULL,NULL,NULL,NULL),(391,3,137,'9916899999',NULL,NULL,0,'','2011-02-10 06:49:47','system',NULL,'system',NULL,NULL,NULL,NULL),(392,1,137,'prashanth@gmail.com',NULL,NULL,0,'','2011-02-10 06:49:47','system',NULL,'system',NULL,NULL,NULL,NULL),(393,2,137,'4543534534',NULL,NULL,0,'','2011-02-10 06:49:47','system',NULL,'system',NULL,NULL,NULL,NULL),(394,7,137,'www.default.com',NULL,NULL,0,'','2011-02-10 06:49:47','system',NULL,'system',NULL,NULL,NULL,NULL),(395,3,138,'188885556667',NULL,NULL,0,'','2011-02-13 00:42:26','system',NULL,'system',NULL,NULL,NULL,NULL),(396,1,138,'sarma@citi.com',NULL,NULL,0,'','2011-02-13 00:42:26','system',NULL,'system',NULL,NULL,NULL,NULL),(397,2,138,'8889991234',NULL,NULL,0,'','2011-02-13 00:42:26','system',NULL,'system',NULL,NULL,NULL,NULL),(398,7,138,'www.citi.com',NULL,NULL,0,'','2011-02-13 00:42:26','system',NULL,'system',NULL,NULL,NULL,NULL),(399,1,118,'test@gmial.com',NULL,NULL,0,'','2011-02-14 12:00:14','system',NULL,'system',NULL,NULL,NULL,NULL),(400,2,118,'12345678',NULL,NULL,0,'','2011-02-14 12:00:14','system',NULL,'system',NULL,NULL,NULL,NULL),(401,7,118,'www.test.com',NULL,NULL,0,'','2011-02-14 12:00:14','system',NULL,'system',NULL,NULL,NULL,NULL),(402,3,118,'9916891168',NULL,NULL,0,'','2011-02-14 12:00:14','system',NULL,'system',NULL,NULL,NULL,NULL),(403,3,139,'',NULL,NULL,0,'','2011-02-14 12:04:26','system',NULL,'system',NULL,NULL,NULL,NULL),(404,1,139,'',NULL,NULL,0,'','2011-02-14 12:04:26','system',NULL,'system',NULL,NULL,NULL,NULL),(405,2,139,'',NULL,NULL,0,'','2011-02-14 12:04:26','system',NULL,'system',NULL,NULL,NULL,NULL),(406,7,139,'',NULL,NULL,0,'','2011-02-14 12:04:26','system',NULL,'system',NULL,NULL,NULL,NULL),(407,3,140,'6045897896',NULL,NULL,0,'','2011-02-15 04:46:31','system',NULL,'system',NULL,NULL,NULL,NULL),(408,1,140,'johnmahony@dfarc.com',NULL,NULL,0,'','2011-02-15 04:46:31','system',NULL,'system',NULL,NULL,NULL,NULL),(409,2,140,'6045889658',NULL,NULL,0,'','2011-02-15 04:46:31','system',NULL,'system',NULL,NULL,NULL,NULL),(410,7,140,'www.default.com',NULL,NULL,0,'','2011-02-15 04:46:31','system',NULL,'system',NULL,NULL,NULL,NULL),(411,3,141,'9916899168',NULL,NULL,0,'','2011-02-15 06:56:13','system',NULL,'system',NULL,NULL,NULL,NULL),(412,1,141,'patil_enterprises@gmail.com',NULL,NULL,0,'','2011-02-15 06:56:13','system',NULL,'system',NULL,NULL,NULL,NULL),(413,2,141,'4566645',NULL,NULL,0,'','2011-02-15 06:56:13','system',NULL,'system',NULL,NULL,NULL,NULL),(414,7,141,'www.default.com',NULL,NULL,0,'','2011-02-15 06:56:13','system',NULL,'system',NULL,NULL,NULL,NULL),(415,3,142,'9916899168',NULL,NULL,0,'','2011-02-15 07:00:04','system',NULL,'system',NULL,NULL,NULL,NULL),(416,1,142,'patil.anand677@gmail.com',NULL,NULL,0,'','2011-02-15 07:00:04','system',NULL,'system',NULL,NULL,NULL,NULL),(417,2,142,'4566645',NULL,NULL,0,'','2011-02-15 07:00:04','system',NULL,'system',NULL,NULL,NULL,NULL),(418,7,142,'www.default.com',NULL,NULL,0,'','2011-02-15 07:00:04','system',NULL,'system',NULL,NULL,NULL,NULL),(419,3,144,'9745863251=+5466',NULL,NULL,1,'','2011-02-15 07:49:52','system',NULL,'system',NULL,NULL,NULL,NULL),(420,1,144,'raju@gmail.com',NULL,NULL,0,'','2011-02-15 07:49:52','system',NULL,'system',NULL,NULL,NULL,NULL),(421,2,144,'124563',NULL,NULL,0,'','2011-02-15 07:49:52','system',NULL,'system',NULL,NULL,NULL,NULL),(422,7,144,'www.default.com',NULL,NULL,0,'','2011-02-15 07:49:52','system',NULL,'system',NULL,NULL,NULL,NULL),(423,3,145,'9874569842',NULL,NULL,0,'','2011-02-15 07:59:25','system',NULL,'system',NULL,NULL,NULL,NULL),(424,1,145,'raju@gmail.com',NULL,NULL,0,'','2011-02-15 07:59:25','system',NULL,'system',NULL,NULL,NULL,NULL),(425,2,145,'145233',NULL,NULL,0,'','2011-02-15 07:59:25','system',NULL,'system',NULL,NULL,NULL,NULL),(426,7,145,'raju@gmail.com',NULL,NULL,0,'','2011-02-15 07:59:25','system',NULL,'system',NULL,NULL,NULL,NULL),(427,3,146,'9743147781',NULL,NULL,0,'','2011-02-15 08:20:45','system',NULL,'system',NULL,NULL,NULL,NULL),(428,1,146,'sandeep@gmail.com',NULL,NULL,0,'','2011-02-15 08:20:45','system',NULL,'system',NULL,NULL,NULL,NULL),(429,2,146,'1478954',NULL,NULL,0,'','2011-02-15 08:20:45','system',NULL,'system',NULL,NULL,NULL,NULL),(430,7,146,'www.default.com',NULL,NULL,0,'','2011-02-15 08:20:45','system',NULL,'system',NULL,NULL,NULL,NULL),(431,3,147,'97485965445878888',NULL,NULL,0,'','2011-02-15 09:09:31','system',NULL,'system',NULL,NULL,NULL,NULL),(432,1,147,'madival@gmail.com',NULL,NULL,0,'','2011-02-15 09:09:31','system',NULL,'system',NULL,NULL,NULL,NULL),(433,2,147,'1457869',NULL,NULL,0,'','2011-02-15 09:09:31','system',NULL,'system',NULL,NULL,NULL,NULL),(434,7,147,'www.default.com',NULL,NULL,0,'','2011-02-15 09:09:31','system',NULL,'system',NULL,NULL,NULL,NULL),(435,3,148,'97457964566546554',NULL,NULL,0,'','2011-02-15 09:41:05','system',NULL,'system',NULL,NULL,NULL,NULL),(436,1,148,'basu@yahoo.com',NULL,NULL,0,'','2011-02-15 09:41:05','system',NULL,'system',NULL,NULL,NULL,NULL),(437,2,148,'1245789',NULL,NULL,0,'','2011-02-15 09:41:05','system',NULL,'system',NULL,NULL,NULL,NULL),(438,7,148,'www.sales.co.in',NULL,NULL,0,'','2011-02-15 09:41:05','system',NULL,'system',NULL,NULL,NULL,NULL),(439,3,149,'97485642369',NULL,NULL,0,'','2011-02-15 10:26:28','system',NULL,'system',NULL,NULL,NULL,NULL),(440,1,149,'jaggu@yahoo.com',NULL,NULL,0,'','2011-02-15 10:26:28','system',NULL,'system',NULL,NULL,NULL,NULL),(441,2,149,'415789665',NULL,NULL,1,'','2011-02-15 10:26:28','system',NULL,'system',NULL,NULL,NULL,NULL),(442,7,149,'www.sbi.com',NULL,NULL,0,'','2011-02-15 10:26:28','system',NULL,'system',NULL,NULL,NULL,NULL),(443,3,150,'9874589658',NULL,NULL,0,'','2011-02-15 10:34:24','system',NULL,'system',NULL,NULL,NULL,NULL),(444,1,150,'shahi@rediffmail.com',NULL,NULL,0,'','2011-02-15 10:34:24','system',NULL,'system',NULL,NULL,NULL,NULL),(445,2,150,'47859647',NULL,NULL,2,'','2011-02-15 10:34:24','system',NULL,'system',NULL,NULL,NULL,NULL),(446,7,150,'www.rediffmail.com',NULL,NULL,0,'','2011-02-15 10:34:24','system',NULL,'system',NULL,NULL,NULL,NULL),(447,3,151,'6748945632',NULL,NULL,0,'','2011-02-15 10:41:53','system',NULL,'system',NULL,NULL,NULL,NULL),(448,1,151,'uday@gmail.com',NULL,NULL,0,'','2011-02-15 10:41:53','system',NULL,'system',NULL,NULL,NULL,NULL),(449,2,151,'97458796156',NULL,NULL,0,'','2011-02-15 10:41:53','system',NULL,'system',NULL,NULL,NULL,NULL),(450,7,151,'www.gmail.com',NULL,NULL,0,'','2011-02-15 10:41:53','system',NULL,'system',NULL,NULL,NULL,NULL),(451,5,152,'9748568975',NULL,NULL,0,'','2011-02-15 10:53:33','system',NULL,'system',NULL,NULL,NULL,NULL),(452,1,152,'manju@gmail.com',NULL,NULL,0,'','2011-02-15 10:53:33','system',NULL,'system',NULL,NULL,NULL,NULL),(453,2,152,'47859647',NULL,NULL,0,'','2011-02-15 10:53:33','system',NULL,'system',NULL,NULL,NULL,NULL),(454,7,152,'www.gmail.com',NULL,NULL,0,'','2011-02-15 10:53:33','system',NULL,'system',NULL,NULL,NULL,NULL),(455,3,153,'21457879',NULL,NULL,0,'','2011-02-15 10:59:37','system',NULL,'system',NULL,NULL,NULL,NULL),(456,1,153,'sanjyay@yahoo.com',NULL,NULL,0,'','2011-02-15 10:59:37','system',NULL,'system',NULL,NULL,NULL,NULL),(457,2,153,'4789654',NULL,NULL,0,'','2011-02-15 10:59:37','system',NULL,'system',NULL,NULL,NULL,NULL),(458,7,153,'www.yahoo.com',NULL,NULL,0,'','2011-02-15 10:59:37','system',NULL,'system',NULL,NULL,NULL,NULL),(459,5,154,'9874589652',NULL,NULL,0,'','2011-02-15 11:39:23','system',NULL,'system',NULL,NULL,NULL,NULL),(460,1,154,'ajay@yahoo.com',NULL,NULL,0,'','2011-02-15 11:39:23','system',NULL,'system',NULL,NULL,NULL,NULL),(461,2,154,'64789544',NULL,NULL,0,'','2011-02-15 11:39:23','system',NULL,'system',NULL,NULL,NULL,NULL),(462,7,154,'www.default.com',NULL,NULL,0,'','2011-02-15 11:39:23','system',NULL,'system',NULL,NULL,NULL,NULL),(463,3,155,'558796122',NULL,NULL,0,'','2011-02-15 12:25:40','system',NULL,'system',NULL,NULL,NULL,NULL),(464,1,155,'Raghu@gmail.com',NULL,NULL,0,'','2011-02-15 12:25:40','system',NULL,'system',NULL,NULL,NULL,NULL),(465,2,155,'1478586',NULL,NULL,0,'','2011-02-15 12:25:40','system',NULL,'system',NULL,NULL,NULL,NULL),(466,7,155,'www.gmail.com',NULL,NULL,0,'','2011-02-15 12:25:40','system',NULL,'system',NULL,NULL,NULL,NULL),(467,3,157,'7031111234',NULL,NULL,0,'','2011-02-16 04:13:17','system',NULL,'system',NULL,NULL,NULL,NULL),(468,1,157,'ram_kumar@gudi.com',NULL,NULL,0,'','2011-02-16 04:13:17','system',NULL,'system',NULL,NULL,NULL,NULL),(469,2,157,'1-888-999-1234',NULL,NULL,0,'','2011-02-16 04:13:17','system',NULL,'system',NULL,NULL,NULL,NULL),(470,7,157,'www.default.com',NULL,NULL,0,'','2011-02-16 04:13:17','system',NULL,'system',NULL,NULL,NULL,NULL),(471,3,158,'18889901241',NULL,NULL,0,'','2011-02-16 04:34:38','system',NULL,'system',NULL,NULL,NULL,NULL),(472,1,158,'vasu@yahoo.com',NULL,NULL,0,'','2011-02-16 04:34:38','system',NULL,'system',NULL,NULL,NULL,NULL),(473,2,158,'1112345678',NULL,NULL,0,'','2011-02-16 04:34:38','system',NULL,'system',NULL,NULL,NULL,NULL),(474,7,158,'www.default.com',NULL,NULL,0,'','2011-02-16 04:34:38','system',NULL,'system',NULL,NULL,NULL,NULL),(475,5,159,'9745865897142545868876868',NULL,NULL,1,'','2011-02-16 05:37:15','system',NULL,'system',NULL,NULL,NULL,NULL),(476,1,159,'shree_@enterprises.com',NULL,NULL,1,'','2011-02-16 05:37:15','system',NULL,'system',NULL,NULL,NULL,NULL),(477,2,159,'1245788245788752742542572727',NULL,NULL,1,'','2011-02-16 05:37:15','system',NULL,'system',NULL,NULL,NULL,NULL),(478,7,159,'www.default.com',NULL,NULL,0,'','2011-02-16 05:37:15','system',NULL,'system',NULL,NULL,NULL,NULL),(480,4,160,'54789652',NULL,NULL,0,'','2011-02-16 06:09:02','system',NULL,'system',NULL,NULL,NULL,NULL),(481,1,160,'anand@yahoo.com',NULL,NULL,0,'','2011-02-16 06:09:02','system',NULL,'system',NULL,NULL,NULL,NULL),(482,2,160,'',NULL,NULL,0,'','2011-02-16 06:09:02','system',NULL,'system',NULL,NULL,NULL,NULL),(483,7,160,'www.default.com',NULL,NULL,0,'','2011-02-16 06:09:02','system',NULL,'system',NULL,NULL,NULL,NULL),(484,3,160,'24578569',NULL,NULL,0,'','2011-02-16 06:10:38','system',NULL,'system',NULL,NULL,NULL,NULL),(485,5,161,'98745689522',NULL,NULL,0,'','2011-02-16 06:14:11','system',NULL,'system',NULL,NULL,NULL,NULL),(486,1,161,'deepu@yahoo.com',NULL,NULL,0,'','2011-02-16 06:14:11','system',NULL,'system',NULL,NULL,NULL,NULL),(487,2,161,'',NULL,NULL,0,'','2011-02-16 06:14:11','system',NULL,'system',NULL,NULL,NULL,NULL),(488,7,161,'www.default.com',NULL,NULL,0,'','2011-02-16 06:14:11','system',NULL,'system',NULL,NULL,NULL,NULL),(489,3,162,'9745863251',NULL,NULL,0,'','2011-02-16 06:19:57','system',NULL,'system',NULL,NULL,NULL,NULL),(490,1,162,'deepu@yahoo.com',NULL,NULL,0,'','2011-02-16 06:19:57','system',NULL,'system',NULL,NULL,NULL,NULL),(491,2,162,'',NULL,NULL,0,'','2011-02-16 06:19:57','system',NULL,'system',NULL,NULL,NULL,NULL),(492,7,162,'www.default.com',NULL,NULL,0,'','2011-02-16 06:19:57','system',NULL,'system',NULL,NULL,NULL,NULL),(493,3,163,'9745863251',NULL,NULL,0,'','2011-02-16 06:21:27','system',NULL,'system',NULL,NULL,NULL,NULL),(494,1,163,'deepu@yahoo.com',NULL,NULL,0,'','2011-02-16 06:21:27','system',NULL,'system',NULL,NULL,NULL,NULL),(495,2,163,'',NULL,NULL,0,'','2011-02-16 06:21:27','system',NULL,'system',NULL,NULL,NULL,NULL),(496,7,163,'www.default.com',NULL,NULL,0,'','2011-02-16 06:21:27','system',NULL,'system',NULL,NULL,NULL,NULL),(497,3,164,'245896647',NULL,NULL,0,'','2011-02-16 06:33:50','system',NULL,'system',NULL,NULL,NULL,NULL),(498,1,164,'anil#@gmail.com',NULL,NULL,1,'','2011-02-16 06:33:50','system',NULL,'system',NULL,NULL,NULL,NULL),(499,2,164,'14526546',NULL,NULL,0,'','2011-02-16 06:33:50','system',NULL,'system',NULL,NULL,NULL,NULL),(500,7,164,'www.default.com',NULL,NULL,0,'','2011-02-16 06:33:50','system',NULL,'system',NULL,NULL,NULL,NULL),(501,5,165,'98745879255',NULL,NULL,0,'','2011-02-16 06:43:56','system',NULL,'system',NULL,NULL,NULL,NULL),(502,1,165,'manju@gmail.com',NULL,NULL,0,'','2011-02-16 06:43:56','system',NULL,'system',NULL,NULL,NULL,NULL),(503,2,165,'1457896',NULL,NULL,0,'','2011-02-16 06:43:56','system',NULL,'system',NULL,NULL,NULL,NULL),(504,7,165,'www.default.com',NULL,NULL,0,'','2011-02-16 06:43:56','system',NULL,'system',NULL,NULL,NULL,NULL),(505,5,166,'9874569842',NULL,NULL,0,'','2011-02-16 09:28:22','system',NULL,'system',NULL,NULL,NULL,NULL),(506,1,166,'manju@gmail.com',NULL,NULL,0,'','2011-02-16 09:28:22','system',NULL,'system',NULL,NULL,NULL,NULL),(507,2,166,'145233',NULL,NULL,0,'','2011-02-16 09:28:22','system',NULL,'system',NULL,NULL,NULL,NULL),(508,7,166,'www.gmail.com',NULL,NULL,0,'','2011-02-16 09:28:22','system',NULL,'system',NULL,NULL,NULL,NULL),(509,5,168,'9784565478',NULL,NULL,0,'','2011-02-16 10:01:39','system',NULL,'system',NULL,NULL,NULL,NULL),(510,1,168,'veeresh@gmail.com',NULL,NULL,0,'','2011-02-16 10:01:39','system',NULL,'system',NULL,NULL,NULL,NULL),(511,2,168,'145623',NULL,NULL,0,'','2011-02-16 10:01:39','system',NULL,'system',NULL,NULL,NULL,NULL),(512,7,168,'www.default.com',NULL,NULL,0,'','2011-02-16 10:01:39','system',NULL,'system',NULL,NULL,NULL,NULL),(513,3,169,'6478955454',NULL,NULL,0,'','2011-02-16 10:06:29','system',NULL,'system',NULL,NULL,NULL,NULL),(514,1,169,'rajesh@yahoo.com',NULL,NULL,0,'','2011-02-16 10:06:29','system',NULL,'system',NULL,NULL,NULL,NULL),(515,2,169,'478965',NULL,NULL,0,'','2011-02-16 10:06:29','system',NULL,'system',NULL,NULL,NULL,NULL),(516,7,169,'www.default.com',NULL,NULL,0,'','2011-02-16 10:06:29','system',NULL,'system',NULL,NULL,NULL,NULL),(517,5,170,'9874569842',NULL,NULL,1,'','2011-02-16 10:11:10','system',NULL,'system',NULL,NULL,NULL,NULL),(518,1,170,'srikanth*gmail.com',NULL,NULL,1,'','2011-02-16 10:11:10','system',NULL,'system',NULL,NULL,NULL,NULL),(519,2,170,'47896',NULL,NULL,0,'','2011-02-16 10:11:10','system',NULL,'system',NULL,NULL,NULL,NULL),(520,7,170,'www.gmail.com',NULL,NULL,0,'','2011-02-16 10:11:10','system',NULL,'system',NULL,NULL,NULL,NULL),(521,3,171,'32565656565',NULL,NULL,0,'','2011-02-16 13:19:54','system',NULL,'system',NULL,NULL,NULL,NULL),(522,1,171,'patil@association.com',NULL,NULL,0,'','2011-02-16 13:19:54','system',NULL,'system',NULL,NULL,NULL,NULL),(523,2,171,'648965',NULL,NULL,0,'','2011-02-16 13:19:54','system',NULL,'system',NULL,NULL,NULL,NULL),(524,7,171,'www.default.com',NULL,NULL,0,'','2011-02-16 13:19:54','system',NULL,'system',NULL,NULL,NULL,NULL),(525,3,172,'568522222',NULL,NULL,0,'','2011-02-16 13:28:43','system',NULL,'system',NULL,NULL,NULL,NULL),(526,1,172,'basu@yahoo.com',NULL,NULL,0,'','2011-02-16 13:28:43','system',NULL,'system',NULL,NULL,NULL,NULL),(527,2,172,'478569',NULL,NULL,0,'','2011-02-16 13:28:43','system',NULL,'system',NULL,NULL,NULL,NULL),(528,7,172,'www.default.com',NULL,NULL,0,'','2011-02-16 13:28:43','system',NULL,'system',NULL,NULL,NULL,NULL),(529,3,173,'354535451',NULL,NULL,0,'','2011-02-16 13:32:25','system',NULL,'system',NULL,NULL,NULL,NULL),(530,1,173,'ramesh@gmail.com',NULL,NULL,0,'','2011-02-16 13:32:25','system',NULL,'system',NULL,NULL,NULL,NULL),(531,2,173,'478566',NULL,NULL,0,'','2011-02-16 13:32:25','system',NULL,'system',NULL,NULL,NULL,NULL),(532,7,173,'www.gmail.com',NULL,NULL,0,'','2011-02-16 13:32:25','system',NULL,'system',NULL,NULL,NULL,NULL),(533,3,154,'',NULL,NULL,0,'','2011-02-16 13:38:48','system',NULL,'system',NULL,NULL,NULL,NULL),(534,3,174,'24587854',NULL,NULL,0,'','2011-02-16 13:45:21','system',NULL,'system',NULL,NULL,NULL,NULL),(535,1,174,'anand@yahoo.com',NULL,NULL,0,'','2011-02-16 13:45:21','system',NULL,'system',NULL,NULL,NULL,NULL),(536,2,174,'2145789',NULL,NULL,0,'','2011-02-16 13:45:21','system',NULL,'system',NULL,NULL,NULL,NULL),(537,7,174,'www.yahoo.com',NULL,NULL,0,'','2011-02-16 13:45:21','system',NULL,'system',NULL,NULL,NULL,NULL),(538,3,175,'254789666',NULL,NULL,0,'','2011-02-17 06:23:58','system',NULL,'system',NULL,NULL,NULL,NULL),(539,1,175,'santhosh#yahoo.com',NULL,NULL,0,'','2011-02-17 06:23:58','system',NULL,'system',NULL,NULL,NULL,NULL),(540,2,175,'1245879',NULL,NULL,0,'','2011-02-17 06:23:58','system',NULL,'system',NULL,NULL,NULL,NULL),(541,7,175,'www.yahoo.com',NULL,NULL,0,'','2011-02-17 06:23:58','system',NULL,'system',NULL,NULL,NULL,NULL),(542,4,175,'45789633',NULL,NULL,0,'','2011-02-17 06:23:58','system',NULL,'system',NULL,NULL,NULL,NULL),(543,4,176,'36987456859',NULL,NULL,1,'','2011-02-17 07:26:21','system',NULL,'system',NULL,NULL,NULL,NULL),(544,1,176,'Bhanu@yahoo.com',NULL,NULL,0,'','2011-02-17 07:26:21','system',NULL,'system',NULL,NULL,NULL,NULL),(545,2,176,'',NULL,NULL,0,'','2011-02-17 07:26:21','system',NULL,'system',NULL,NULL,NULL,NULL),(546,7,176,'www.default.com',NULL,NULL,0,'','2011-02-17 07:26:21','system',NULL,'system',NULL,NULL,NULL,NULL),(549,3,177,'12324345',NULL,NULL,0,'','2011-02-17 11:16:25','system',NULL,'system',NULL,NULL,NULL,NULL),(550,1,177,'ganesh#gmail.com',NULL,NULL,0,'','2011-02-17 11:16:25','system',NULL,'system',NULL,NULL,NULL,NULL),(551,2,177,'',NULL,NULL,0,'','2011-02-17 11:16:25','system',NULL,'system',NULL,NULL,NULL,NULL),(552,7,177,'www.default.com',NULL,NULL,0,'','2011-02-17 11:16:25','system',NULL,'system',NULL,NULL,NULL,NULL),(553,3,178,'9874569842',NULL,NULL,0,'','2011-02-17 11:45:54','system',NULL,'system',NULL,NULL,NULL,NULL),(554,1,178,'santhosh#yahoo.com',NULL,NULL,0,'','2011-02-17 11:45:54','system',NULL,'system',NULL,NULL,NULL,NULL),(555,2,178,'1245879',NULL,NULL,0,'','2011-02-17 11:45:54','system',NULL,'system',NULL,NULL,NULL,NULL),(556,7,178,'www.yahoo.com',NULL,NULL,0,'','2011-02-17 11:45:54','system',NULL,'system',NULL,NULL,NULL,NULL),(557,3,179,'214551',NULL,NULL,0,'','2011-02-17 11:59:04','system',NULL,'system',NULL,NULL,NULL,NULL),(558,1,179,'sourabh@yahoo.com',NULL,NULL,0,'','2011-02-17 11:59:04','system',NULL,'system',NULL,NULL,NULL,NULL),(559,2,179,'1425',NULL,NULL,0,'','2011-02-17 11:59:04','system',NULL,'system',NULL,NULL,NULL,NULL),(560,7,179,'www.yahoo.com',NULL,NULL,0,'','2011-02-17 11:59:04','system',NULL,'system',NULL,NULL,NULL,NULL),(561,3,180,'9745863251',NULL,NULL,0,'','2011-02-17 12:54:10','system',NULL,'system',NULL,NULL,NULL,NULL),(562,1,180,'Bhanu#yahoo.com',NULL,NULL,0,'','2011-02-17 12:54:10','system',NULL,'system',NULL,NULL,NULL,NULL),(563,2,180,'',NULL,NULL,0,'','2011-02-17 12:54:10','system',NULL,'system',NULL,NULL,NULL,NULL),(564,7,180,'www.default.com',NULL,NULL,0,'','2011-02-17 12:54:10','system',NULL,'system',NULL,NULL,NULL,NULL),(565,3,181,'6542255',NULL,NULL,0,'','2011-02-17 13:11:41','system',NULL,'system',NULL,NULL,NULL,NULL),(566,1,181,'raju@gmail.com',NULL,NULL,0,'','2011-02-17 13:11:41','system',NULL,'system',NULL,NULL,NULL,NULL),(567,2,181,'478569',NULL,NULL,0,'','2011-02-17 13:11:41','system',NULL,'system',NULL,NULL,NULL,NULL),(568,7,181,'www.default.com',NULL,NULL,0,'','2011-02-17 13:11:41','system',NULL,'system',NULL,NULL,NULL,NULL),(569,3,182,'6542255',NULL,NULL,0,'','2011-02-18 06:31:17','system',NULL,'system',NULL,NULL,NULL,NULL),(570,1,182,'roy@gmail.com',NULL,NULL,0,'','2011-02-18 06:31:17','system',NULL,'system',NULL,NULL,NULL,NULL),(571,2,182,'14578',NULL,NULL,0,'','2011-02-18 06:31:17','system',NULL,'system',NULL,NULL,NULL,NULL),(572,7,182,'www.default.com',NULL,NULL,0,'','2011-02-18 06:31:17','system',NULL,'system',NULL,NULL,NULL,NULL),(573,3,183,'45247896',NULL,NULL,0,'','2011-02-18 06:39:03','system',NULL,'system',NULL,NULL,NULL,NULL),(574,1,183,'sandeep@yahoo.com',NULL,NULL,0,'','2011-02-18 06:39:03','system',NULL,'system',NULL,NULL,NULL,NULL),(575,2,183,'478599',NULL,NULL,0,'','2011-02-18 06:39:03','system',NULL,'system',NULL,NULL,NULL,NULL),(576,7,183,'www.default.com',NULL,NULL,0,'','2011-02-18 06:39:03','system',NULL,'system',NULL,NULL,NULL,NULL),(577,3,184,'9745863251',NULL,NULL,0,'','2011-02-18 12:15:54','system',NULL,'system',NULL,NULL,NULL,NULL),(578,1,184,'sandeep@gmail.com',NULL,NULL,0,'','2011-02-18 12:15:54','system',NULL,'system',NULL,NULL,NULL,NULL),(579,2,184,'1245788',NULL,NULL,0,'','2011-02-18 12:15:54','system',NULL,'system',NULL,NULL,NULL,NULL),(580,7,184,'www.default.com',NULL,NULL,0,'','2011-02-18 12:15:54','system',NULL,'system',NULL,NULL,NULL,NULL),(581,3,185,'145632',NULL,NULL,0,'','2011-02-18 12:17:55','system',NULL,'system',NULL,NULL,NULL,NULL),(582,1,185,'raju@gmail.com',NULL,NULL,0,'','2011-02-18 12:17:55','system',NULL,'system',NULL,NULL,NULL,NULL),(583,2,185,'124563',NULL,NULL,0,'','2011-02-18 12:17:55','system',NULL,'system',NULL,NULL,NULL,NULL),(584,7,185,'www.default.com',NULL,NULL,0,'','2011-02-18 12:17:55','system',NULL,'system',NULL,NULL,NULL,NULL),(585,3,187,'6542255',NULL,NULL,0,'','2011-02-19 07:16:55','system',NULL,'system',NULL,NULL,NULL,NULL),(586,1,187,'raju#gmail.com',NULL,NULL,0,'','2011-02-19 07:16:55','system',NULL,'system',NULL,NULL,NULL,NULL),(587,2,187,'',NULL,NULL,0,'','2011-02-19 07:16:55','system',NULL,'system',NULL,NULL,NULL,NULL),(588,7,187,'www.default.com',NULL,NULL,0,'','2011-02-19 07:16:55','system',NULL,'system',NULL,NULL,NULL,NULL),(589,4,144,'97845696333',NULL,NULL,0,'','2011-02-19 07:21:32','system',NULL,'system',NULL,NULL,NULL,NULL),(590,3,189,'214551',NULL,NULL,1,'','2011-02-19 13:26:38','system',NULL,'system',NULL,NULL,NULL,NULL),(591,1,189,'sourabh@yahoo.com',NULL,NULL,1,'','2011-02-19 13:26:38','system',NULL,'system',NULL,NULL,NULL,NULL),(592,2,189,'1245879',NULL,NULL,1,'','2011-02-19 13:26:38','system',NULL,'system',NULL,NULL,NULL,NULL),(593,7,189,'www.yahoo.com',NULL,NULL,1,'','2011-02-19 13:26:38','system',NULL,'system',NULL,NULL,NULL,NULL),(594,3,190,'',NULL,NULL,0,'','2011-02-21 05:20:23','system',NULL,'system',NULL,NULL,NULL,NULL),(595,1,190,'',NULL,NULL,0,'','2011-02-21 05:20:23','system',NULL,'system',NULL,NULL,NULL,NULL),(596,2,190,'',NULL,NULL,0,'','2011-02-21 05:20:23','system',NULL,'system',NULL,NULL,NULL,NULL),(597,7,190,'',NULL,NULL,0,'','2011-02-21 05:20:23','system',NULL,'system',NULL,NULL,NULL,NULL),(598,3,191,'',NULL,NULL,0,'','2011-02-21 06:04:24','system',NULL,'system',NULL,NULL,NULL,NULL),(599,1,191,'',NULL,NULL,0,'','2011-02-21 06:04:24','system',NULL,'system',NULL,NULL,NULL,NULL),(600,2,191,'',NULL,NULL,0,'','2011-02-21 06:04:24','system',NULL,'system',NULL,NULL,NULL,NULL),(601,7,191,'',NULL,NULL,0,'','2011-02-21 06:04:24','system',NULL,'system',NULL,NULL,NULL,NULL),(602,3,192,'',NULL,NULL,0,'','2011-02-21 08:46:56','system',NULL,'system',NULL,NULL,NULL,NULL),(603,1,192,'',NULL,NULL,0,'','2011-02-21 08:46:56','system',NULL,'system',NULL,NULL,NULL,NULL),(604,2,192,'',NULL,NULL,0,'','2011-02-21 08:46:56','system',NULL,'system',NULL,NULL,NULL,NULL),(605,7,192,'www.default.com',NULL,NULL,0,'','2011-02-21 08:46:56','system',NULL,'system',NULL,NULL,NULL,NULL),(606,3,193,'',NULL,NULL,0,'','2011-02-21 08:53:47','system',NULL,'system',NULL,NULL,NULL,NULL),(607,1,193,'sandeep&gmail.com',NULL,NULL,1,'','2011-02-21 08:53:47','system',NULL,'system',NULL,NULL,NULL,NULL),(608,2,193,'',NULL,NULL,0,'','2011-02-21 08:53:47','system',NULL,'system',NULL,NULL,NULL,NULL),(609,7,193,'www.default.com',NULL,NULL,0,'','2011-02-21 08:53:47','system',NULL,'system',NULL,NULL,NULL,NULL),(610,3,194,'',NULL,NULL,0,'','2011-02-21 09:03:43','system',NULL,'system',NULL,NULL,NULL,NULL),(611,1,194,'',NULL,NULL,0,'','2011-02-21 09:03:43','system',NULL,'system',NULL,NULL,NULL,NULL),(612,2,194,'',NULL,NULL,0,'','2011-02-21 09:03:43','system',NULL,'system',NULL,NULL,NULL,NULL),(613,7,194,'www.default.com',NULL,NULL,0,'','2011-02-21 09:03:43','system',NULL,'system',NULL,NULL,NULL,NULL),(614,3,195,'',NULL,NULL,0,'','2011-02-21 09:58:12','system',NULL,'system',NULL,NULL,NULL,NULL),(615,1,195,'',NULL,NULL,0,'','2011-02-21 09:58:12','system',NULL,'system',NULL,NULL,NULL,NULL),(616,2,195,'',NULL,NULL,0,'','2011-02-21 09:58:12','system',NULL,'system',NULL,NULL,NULL,NULL),(617,7,195,'www.default.com',NULL,NULL,0,'','2011-02-21 09:58:12','system',NULL,'system',NULL,NULL,NULL,NULL),(618,3,196,'',NULL,NULL,0,'','2011-02-21 09:59:21','system',NULL,'system',NULL,NULL,NULL,NULL),(619,1,196,'',NULL,NULL,1,'','2011-02-21 09:59:21','system',NULL,'system',NULL,NULL,NULL,NULL),(620,2,196,'',NULL,NULL,0,'','2011-02-21 09:59:21','system',NULL,'system',NULL,NULL,NULL,NULL),(621,7,196,'www.default.com',NULL,NULL,0,'','2011-02-21 09:59:21','system',NULL,'system',NULL,NULL,NULL,NULL),(622,3,197,'6542255',NULL,NULL,0,'','2011-02-21 10:05:02','system',NULL,'system',NULL,NULL,NULL,NULL),(623,1,197,'anand@gmail.com',NULL,NULL,0,'','2011-02-21 10:05:02','system',NULL,'system',NULL,NULL,NULL,NULL),(624,2,197,'',NULL,NULL,0,'','2011-02-21 10:05:02','system',NULL,'system',NULL,NULL,NULL,NULL),(625,7,197,'www.default.com',NULL,NULL,0,'','2011-02-21 10:05:02','system',NULL,'system',NULL,NULL,NULL,NULL),(626,3,198,'6542255',NULL,NULL,0,'','2011-02-21 10:05:13','system',NULL,'system',NULL,NULL,NULL,NULL),(627,1,198,'anand@gmail.com',NULL,NULL,0,'','2011-02-21 10:05:13','system',NULL,'system',NULL,NULL,NULL,NULL),(628,2,198,'',NULL,NULL,0,'','2011-02-21 10:05:13','system',NULL,'system',NULL,NULL,NULL,NULL),(629,7,198,'www.default.com',NULL,NULL,0,'','2011-02-21 10:05:13','system',NULL,'system',NULL,NULL,NULL,NULL),(630,3,199,'',NULL,NULL,0,'','2011-02-21 10:28:39','system',NULL,'system',NULL,NULL,NULL,NULL),(631,1,199,'',NULL,NULL,0,'','2011-02-21 10:28:39','system',NULL,'system',NULL,NULL,NULL,NULL),(632,2,199,'',NULL,NULL,0,'','2011-02-21 10:28:39','system',NULL,'system',NULL,NULL,NULL,NULL),(633,7,199,'www.default.com',NULL,NULL,0,'','2011-02-21 10:28:39','system',NULL,'system',NULL,NULL,NULL,NULL),(634,3,200,'',NULL,NULL,0,'','2011-02-21 10:30:16','system',NULL,'system',NULL,NULL,NULL,NULL),(635,1,200,'',NULL,NULL,1,'','2011-02-21 10:30:16','system',NULL,'system',NULL,NULL,NULL,NULL),(636,2,200,'',NULL,NULL,0,'','2011-02-21 10:30:16','system',NULL,'system',NULL,NULL,NULL,NULL),(637,7,200,'www.default.com',NULL,NULL,0,'','2011-02-21 10:30:16','system',NULL,'system',NULL,NULL,NULL,NULL),(638,3,201,'',NULL,NULL,0,'','2011-02-21 10:34:27','system',NULL,'system',NULL,NULL,NULL,NULL),(639,1,201,'',NULL,NULL,0,'','2011-02-21 10:34:27','system',NULL,'system',NULL,NULL,NULL,NULL),(640,2,201,'',NULL,NULL,0,'','2011-02-21 10:34:27','system',NULL,'system',NULL,NULL,NULL,NULL),(641,7,201,'www.default.com',NULL,NULL,0,'','2011-02-21 10:34:27','system',NULL,'system',NULL,NULL,NULL,NULL),(642,3,202,'',NULL,NULL,0,'','2011-02-21 10:57:39','system',NULL,'system',NULL,NULL,NULL,NULL),(643,1,202,'',NULL,NULL,0,'','2011-02-21 10:57:39','system',NULL,'system',NULL,NULL,NULL,NULL),(644,2,202,'',NULL,NULL,0,'','2011-02-21 10:57:39','system',NULL,'system',NULL,NULL,NULL,NULL),(645,7,202,'www.default.com',NULL,NULL,0,'','2011-02-21 10:57:39','system',NULL,'system',NULL,NULL,NULL,NULL),(646,3,203,'',NULL,NULL,0,'','2011-02-21 11:21:54','system',NULL,'system',NULL,NULL,NULL,NULL),(647,1,203,'',NULL,NULL,0,'','2011-02-21 11:21:54','system',NULL,'system',NULL,NULL,NULL,NULL),(648,2,203,'',NULL,NULL,0,'','2011-02-21 11:21:54','system',NULL,'system',NULL,NULL,NULL,NULL),(649,7,203,'www.default.com',NULL,NULL,0,'','2011-02-21 11:21:54','system',NULL,'system',NULL,NULL,NULL,NULL),(650,3,204,'',NULL,NULL,0,'','2011-02-21 11:23:34','system',NULL,'system',NULL,NULL,NULL,NULL),(651,1,204,'deepu@yahoo.com',NULL,NULL,0,'','2011-02-21 11:23:34','system',NULL,'system',NULL,NULL,NULL,NULL),(652,2,204,'',NULL,NULL,0,'','2011-02-21 11:23:34','system',NULL,'system',NULL,NULL,NULL,NULL),(653,7,204,'www.default.com',NULL,NULL,0,'','2011-02-21 11:23:34','system',NULL,'system',NULL,NULL,NULL,NULL),(654,3,205,'',NULL,NULL,0,'','2011-02-21 11:24:40','system',NULL,'system',NULL,NULL,NULL,NULL),(655,1,205,'deepu1#yahoo.com',NULL,NULL,1,'','2011-02-21 11:24:40','system',NULL,'system',NULL,NULL,NULL,NULL),(656,2,205,'',NULL,NULL,0,'','2011-02-21 11:24:40','system',NULL,'system',NULL,NULL,NULL,NULL),(657,7,205,'www.default.com',NULL,NULL,0,'','2011-02-21 11:24:40','system',NULL,'system',NULL,NULL,NULL,NULL),(658,3,207,'',NULL,NULL,0,'','2011-02-23 12:39:56','system',NULL,'system',NULL,NULL,NULL,NULL),(659,1,207,'',NULL,NULL,0,'','2011-02-23 12:39:56','system',NULL,'system',NULL,NULL,NULL,NULL),(660,2,207,'',NULL,NULL,0,'','2011-02-23 12:39:56','system',NULL,'system',NULL,NULL,NULL,NULL),(661,7,207,'www.default.com',NULL,NULL,0,'','2011-02-23 12:39:56','system',NULL,'system',NULL,NULL,NULL,NULL),(662,3,208,'',NULL,NULL,0,'','2011-02-23 13:07:18','system',NULL,'system',NULL,NULL,NULL,NULL),(663,1,208,'raju@gmail.com',NULL,NULL,0,'','2011-02-23 13:07:18','system',NULL,'system',NULL,NULL,NULL,NULL),(664,2,208,'1245879',NULL,NULL,0,'','2011-02-23 13:07:18','system',NULL,'system',NULL,NULL,NULL,NULL),(665,7,208,'',NULL,NULL,0,'','2011-02-23 13:07:18','system',NULL,'system',NULL,NULL,NULL,NULL),(666,3,209,'',NULL,NULL,0,'','2011-02-23 13:11:21','system',NULL,'system',NULL,NULL,NULL,NULL),(667,1,209,'',NULL,NULL,0,'','2011-02-23 13:11:21','system',NULL,'system',NULL,NULL,NULL,NULL),(668,2,209,'',NULL,NULL,0,'','2011-02-23 13:11:21','system',NULL,'system',NULL,NULL,NULL,NULL),(669,7,209,'',NULL,NULL,0,'','2011-02-23 13:11:21','system',NULL,'system',NULL,NULL,NULL,NULL),(670,3,210,'',NULL,NULL,0,'','2011-02-23 13:15:11','system',NULL,'system',NULL,NULL,NULL,NULL),(671,1,210,'',NULL,NULL,0,'','2011-02-23 13:15:11','system',NULL,'system',NULL,NULL,NULL,NULL),(672,2,210,'',NULL,NULL,0,'','2011-02-23 13:15:11','system',NULL,'system',NULL,NULL,NULL,NULL),(673,7,210,'www.default.com',NULL,NULL,0,'','2011-02-23 13:15:11','system',NULL,'system',NULL,NULL,NULL,NULL),(674,3,213,'adffgfghh',NULL,NULL,1,'','2011-02-24 11:18:17','system',NULL,'system',NULL,NULL,NULL,NULL),(675,1,213,'12455$@@$',NULL,NULL,1,'','2011-02-24 11:18:17','system',NULL,'system',NULL,NULL,NULL,NULL),(676,2,213,'',NULL,NULL,0,'','2011-02-24 11:18:17','system',NULL,'system',NULL,NULL,NULL,NULL),(677,7,213,'www.default.com',NULL,NULL,0,'','2011-02-24 11:18:17','system',NULL,'system',NULL,NULL,NULL,NULL),(678,3,214,'affghjkhh',NULL,NULL,0,'','2011-02-24 12:59:08','system',NULL,'system',NULL,NULL,NULL,NULL),(679,1,214,'4441135456',NULL,NULL,0,'','2011-02-24 12:59:08','system',NULL,'system',NULL,NULL,NULL,NULL),(680,2,214,'gdsgfdhgfhjhj',NULL,NULL,0,'','2011-02-24 12:59:08','system',NULL,'system',NULL,NULL,NULL,NULL),(681,7,214,'125saa@#$',NULL,NULL,0,'','2011-02-24 12:59:08','system',NULL,'system',NULL,NULL,NULL,NULL),(682,3,215,'2345',NULL,NULL,0,'','2011-02-25 05:27:47','system',NULL,'system',NULL,NULL,NULL,NULL),(683,1,215,'shanti@gamil.com',NULL,NULL,0,'','2011-02-25 05:27:47','system',NULL,'system',NULL,NULL,NULL,NULL),(684,2,215,'123',NULL,NULL,0,'','2011-02-25 05:27:47','system',NULL,'system',NULL,NULL,NULL,NULL),(685,7,215,'www.default.com',NULL,NULL,0,'','2011-02-25 05:27:47','system',NULL,'system',NULL,NULL,NULL,NULL),(686,5,216,NULL,NULL,NULL,0,'','2011-02-26 23:15:00','system','2011-02-26 23:15:00','system',NULL,NULL,NULL,NULL),(687,1,216,NULL,NULL,NULL,0,'','2011-02-26 23:15:00','system','2011-02-26 23:15:00','system',NULL,NULL,NULL,NULL),(688,2,216,NULL,NULL,NULL,0,'','2011-02-26 23:15:00','system','2011-02-26 23:15:00','system',NULL,NULL,NULL,NULL),(689,7,216,NULL,NULL,NULL,0,'','2011-02-26 23:15:00','system','2011-02-26 23:15:00','system',NULL,NULL,NULL,NULL),(690,5,217,'gdsgdgfd',NULL,NULL,0,'','2011-02-27 07:21:41','system','2011-02-27 07:21:41','system',NULL,NULL,NULL,-1),(691,1,217,'1324345465',NULL,NULL,0,'','2011-02-27 07:21:41','system','2011-02-27 07:21:41','system',NULL,NULL,NULL,NULL),(692,2,217,'sgsgffdf',NULL,NULL,0,'','2011-02-27 07:21:41','system','2011-02-27 07:21:41','system',NULL,NULL,NULL,NULL),(693,7,217,'www.default.com',NULL,NULL,0,'','2011-02-27 07:21:41','system','2011-02-27 07:21:41','system',NULL,NULL,NULL,NULL),(694,5,218,'fhdfhdh',NULL,NULL,0,'','2011-02-28 13:06:47','system','2011-02-28 13:06:47','system',NULL,NULL,NULL,-1),(695,1,218,'1245344',NULL,NULL,0,'','2011-02-28 13:06:47','system','2011-02-28 13:06:47','system',NULL,NULL,NULL,NULL),(696,2,218,'ghhghk',NULL,NULL,0,'','2011-02-28 13:06:47','system','2011-02-28 13:06:47','system',NULL,NULL,NULL,NULL),(697,7,218,'www.default.com',NULL,NULL,0,'','2011-02-28 13:06:47','system','2011-02-28 13:06:47','system',NULL,NULL,NULL,NULL),(698,5,219,'fgfhfghfgd',NULL,NULL,3,'','2011-02-28 14:21:27','system','2011-02-28 14:21:27','system',NULL,NULL,NULL,3),(699,1,219,'124435652',NULL,NULL,0,'','2011-02-28 14:21:27','system','2011-02-28 14:21:27','system',NULL,NULL,NULL,NULL),(700,2,219,'ggfsghfghf',NULL,NULL,0,'','2011-02-28 14:21:27','system','2011-02-28 14:21:27','system',NULL,NULL,NULL,NULL),(701,7,219,'www.default.com',NULL,NULL,0,'','2011-02-28 14:21:27','system','2011-02-28 14:21:27','system',NULL,NULL,NULL,NULL),(706,5,220,'fgfgagtrgr',NULL,NULL,4,'','2011-02-28 14:29:20','system','2011-02-28 14:29:20','system',NULL,NULL,NULL,3),(707,1,NULL,'',NULL,NULL,0,'','2011-02-28 14:29:20','system',NULL,'system',NULL,NULL,NULL,NULL),(708,2,NULL,'',NULL,NULL,0,'','2011-02-28 14:29:20','system',NULL,'system',NULL,NULL,NULL,NULL),(709,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-28 14:29:20','system',NULL,'system',NULL,NULL,NULL,NULL),(710,1,NULL,'',NULL,NULL,0,'','2011-02-28 14:29:53','system',NULL,'system',NULL,NULL,NULL,NULL),(711,2,NULL,'',NULL,NULL,0,'','2011-02-28 14:29:53','system',NULL,'system',NULL,NULL,NULL,NULL),(712,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-28 14:29:53','system',NULL,'system',NULL,NULL,NULL,NULL),(713,1,NULL,'13243253425',NULL,NULL,0,'','2011-02-28 14:31:00','system',NULL,'system',NULL,NULL,NULL,NULL),(714,2,NULL,'',NULL,NULL,0,'','2011-02-28 14:31:00','system',NULL,'system',NULL,NULL,NULL,NULL),(715,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-28 14:31:00','system',NULL,'system',NULL,NULL,NULL,NULL),(716,1,NULL,'13243253425',NULL,NULL,0,'','2011-02-28 14:32:58','system',NULL,'system',NULL,NULL,NULL,NULL),(717,2,NULL,'',NULL,NULL,0,'','2011-02-28 14:32:58','system',NULL,'system',NULL,NULL,NULL,NULL),(718,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-28 14:32:58','system',NULL,'system',NULL,NULL,NULL,NULL),(719,1,NULL,'13243253425',NULL,NULL,0,'','2011-02-28 14:33:33','system',NULL,'system',NULL,NULL,NULL,NULL),(720,2,NULL,'',NULL,NULL,0,'','2011-02-28 14:33:33','system',NULL,'system',NULL,NULL,NULL,NULL),(721,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-28 14:33:33','system',NULL,'system',NULL,NULL,NULL,NULL),(722,5,221,'fgfhfghfgd',NULL,NULL,1,'','2011-02-28 15:05:14','system','2011-02-28 15:05:14','system',NULL,NULL,NULL,3),(723,1,221,'1324345465',NULL,NULL,0,'','2011-02-28 15:05:14','system','2011-02-28 15:05:14','system',NULL,NULL,NULL,NULL),(724,2,221,'sgsgffdf',NULL,NULL,0,'','2011-02-28 15:05:14','system','2011-02-28 15:05:14','system',NULL,NULL,NULL,NULL),(725,7,221,'www.default.com',NULL,NULL,0,'','2011-02-28 15:05:14','system','2011-02-28 15:05:14','system',NULL,NULL,NULL,NULL),(726,5,222,'@$%%#%#',NULL,NULL,3,'','2011-03-01 05:11:17','system','2011-03-01 05:11:17','system',NULL,NULL,NULL,3),(727,1,222,'134243254325',NULL,NULL,0,'','2011-03-01 05:11:17','system','2011-03-01 05:11:17','system',NULL,NULL,NULL,NULL),(728,2,222,'gfgfgfhh',NULL,NULL,0,'','2011-03-01 05:11:17','system','2011-03-01 05:11:17','system',NULL,NULL,NULL,NULL),(729,7,222,'www.default.com',NULL,NULL,0,'','2011-03-01 05:11:17','system','2011-03-01 05:11:17','system',NULL,NULL,NULL,NULL),(730,5,223,NULL,NULL,NULL,0,'','2011-03-01 06:54:01','system','2011-03-01 06:54:01','system',NULL,NULL,NULL,NULL),(731,1,223,NULL,NULL,NULL,0,'','2011-03-01 06:54:01','system','2011-03-01 06:54:01','system',NULL,NULL,NULL,NULL),(732,2,223,NULL,NULL,NULL,0,'','2011-03-01 06:54:01','system','2011-03-01 06:54:01','system',NULL,NULL,NULL,NULL),(733,7,223,NULL,NULL,NULL,0,'','2011-03-01 06:54:01','system','2011-03-01 06:54:01','system',NULL,NULL,NULL,NULL),(734,3,224,'asdfgjk',NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(735,1,224,'12345',NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(736,2,224,'awsedrftghj',NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(737,7,224,'2345678',NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(738,1,NULL,NULL,NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(739,2,NULL,NULL,NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL),(740,7,NULL,NULL,NULL,NULL,0,'','2011-03-01 12:18:32','system',NULL,'system',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `party_site_communication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(100) DEFAULT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `country_code` bigint(20) unsigned DEFAULT NULL,
  `state_code` bigint(20) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_address_has_country_code` (`country_code`),
  KEY `fk_address_has_state_code` (`state_code`),
  CONSTRAINT `fk_address_has_country_code` FOREIGN KEY (`country_code`) REFERENCES `code` (`id`),
  CONSTRAINT `fk_address_has_state_code` FOREIGN KEY (`state_code`) REFERENCES `code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (157,'34 Anderson ln','test 45678','Toronto',NULL,'100456',NULL,NULL,NULL,0,'','2011-02-02 06:40:43','system',2,00000000000000001069),(158,'34 Anderson ln','test 45678','Toronto',NULL,'100456',NULL,NULL,NULL,0,'','2011-02-02 06:56:59','system',1,00000000000000001063),(159,'1234 test','Elden Street','Sterling',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-03 03:55:21','system',1,00000000000000001066),(160,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-03 03:59:38','system',1,00000000000000001061),(161,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-03 04:09:00','system',1,00000000000000001061),(162,'kmnknY*&y','kjnk*Y(]','rwrer',NULL,'vcxvxcv',NULL,NULL,NULL,0,'','2011-02-03 18:02:00','system',1,00000000000000001005),(163,'kmnknY*&y','kjnk*Y(]','rwrer',NULL,'vcxvxcv',NULL,NULL,NULL,0,'','2011-02-03 18:02:01','system',1,00000000000000001005),(164,'%^%%^%^4','$^%$%^$%^$%$','%^$%^$%$',NULL,'^^^^',NULL,NULL,NULL,0,'','2011-02-03 18:03:52','system',1,00000000000000001066),(165,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-04 01:12:59','system',1,00000000000000001059),(166,'27, 2nd Cross, 3rd Main','Basaveshware Nagar','Falls Church',NULL,'22042',NULL,NULL,NULL,0,'','2011-02-04 01:24:06','system',1,00000000000000001056),(167,'27, 2nd Cross, 3rd Main','Basaveshware Nagar','Falls Church',NULL,'22042',NULL,NULL,NULL,0,'','2011-02-04 01:29:09','system',1458,00000000000000001459),(168,'1234 test','Elden Street','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-04 02:51:40','system',2,00000000000000001068),(169,'456 jones dr','Elden Street','Surray',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-04 02:55:55','system',2,00000000000000001068),(170,'200 - 10193 152A Street','','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-04 02:59:48','system',2,00000000000000001068),(171,'200 - 10193 152A Street','','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-04 03:01:55','system',2,00000000000000001068),(172,'94 Sharma Ln','Elden Street','St Loius',NULL,'45789',NULL,NULL,NULL,0,'','2011-02-04 03:03:48','system',1,00000000000000001024),(173,'1234 test','Elden Street','St Loius',NULL,'45789',NULL,NULL,NULL,0,'','2011-02-04 03:05:11','system',1,00000000000000001024),(174,'3rd Main, 4th Cross,','Rajaji Nagar','Bangalore',NULL,'560032',NULL,NULL,NULL,0,'','2011-02-04 03:07:03','system',1458,00000000000000001459),(175,'3rd Main, 4th Cross, T Section','Rajaji Nagar','Bangalore',NULL,'560032',NULL,NULL,NULL,1,'','2011-02-04 03:08:38','system',1,00000000000000001062),(176,'5th Cross, 4th Main','Basaveshwara Nagar','Bangalore',NULL,'560032',NULL,NULL,NULL,0,'','2011-02-04 03:10:53','system',1458,00000000000000001459),(177,'3rd Main, 4th Cross,','Basaveshwara Nagar','Bangalore',NULL,'560032',NULL,NULL,NULL,0,'','2011-02-04 03:12:23','system',1458,00000000000000001459),(178,'Louis tower','','Romeo',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-08 02:46:49','system',1,00000000000000001062),(180,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-08 05:26:24','system',2,00000000000000001068),(181,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-08 05:28:18','system',2,00000000000000001068),(182,'1325 153A Street','Suite348','Coquitlam',NULL,'V3E W4R',NULL,NULL,NULL,0,'','2011-02-08 05:51:42','system',2,00000000000000001068),(183,'234 Frogger Street','Suite 200','Vancouver',NULL,'',NULL,NULL,NULL,0,'','2011-02-08 06:06:19','system',2,00000000000000001068),(184,'Richmond circle','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 14:38:56','system',1,00000000000000001066),(185,'1235 - 152 A Street','Suite 200','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-09 02:54:15','system',2,00000000000000001068),(186,'1235 - 152 A Street','Suite 200','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-09 02:54:16','system',2,00000000000000001068),(187,'1235 - 152 A Street','Suite 200','Surrey',NULL,'V3R 4H6',NULL,NULL,NULL,0,'','2011-02-09 02:54:16','system',2,00000000000000001068),(188,'Basaveshvar Nagar','3rd cross','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-09 04:20:17','system',1,00000000000000001062),(189,'123 main Street','Suite 200','Surrey',NULL,'V3R 5W7',NULL,NULL,NULL,0,'','2011-02-09 04:56:30','system',2,00000000000000001068),(190,'1234 test','Basaveshwara Nagar','Sterling',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-09 06:43:57','system',1,00000000000000001063),(191,'1234 test','Basaveshwara Nagar','Sterling',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-09 06:55:40','system',1,00000000000000001066),(192,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-09 06:58:04','system',1,00000000000000001066),(193,'1234 test','Basaveshwara Nagar','Bangalore',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-09 07:03:56','system',1,00000000000000001065),(194,'1234 test','Basaveshwara Nagar','Bangalore',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-09 07:04:53','system',1,00000000000000001065),(195,'roshan nagar','','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-10 06:41:01','system',1,00000000000000001061),(196,'guru nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-10 06:47:56','system',1,00000000000000001061),(197,'Sataynarayana Pet','3main','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-10 06:49:46','system',1464,00000000000000001465),(198,'1234 some dr','','Herndon',NULL,'22042',NULL,NULL,NULL,0,'','2011-02-13 00:42:26','system',1,00000000000000001056),(199,'Blank Rome','','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-14 12:04:26','system',2,00000000000000001067),(200,'102 - 10256 main Street','','Vancouver',NULL,'V3X 3G9',NULL,NULL,NULL,0,'','2011-02-15 04:46:31','system',2,00000000000000001068),(201,'Patil Nagar','','Cape Town',NULL,'554187',NULL,NULL,NULL,0,'','2011-02-15 06:56:12','system',1462,00000000000000001463),(202,'Patil Nagar','','Cape Town',NULL,'554187',NULL,NULL,NULL,0,'','2011-02-15 07:00:03','system',1462,00000000000000001463),(203,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-15 07:40:12','system',1,00000000000000001001),(204,'asfghjhkhk','','us',NULL,'1478965',NULL,NULL,NULL,0,'','2011-02-15 07:49:51','system',1,00000000000000001066),(205,'Rajaji Nagar','','US',NULL,'12458',NULL,NULL,NULL,0,'','2011-02-15 07:59:25','system',2,00000000000000001071),(206,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-15 08:13:00','system',1,NULL),(207,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-15 08:20:32','system',1,NULL),(208,'7th Cross','Basaveshvar Nagar','canada',NULL,'1452366',NULL,NULL,NULL,0,'','2011-02-15 08:20:44','system',2,00000000000000001071),(209,'sanglad colony','','srilanka',NULL,'1425773',NULL,NULL,NULL,0,'','2011-02-15 09:09:30','system',1,00000000000000001064),(210,'santhinagar','','Bangalore',NULL,'4578966',NULL,NULL,NULL,0,'','2011-02-15 09:41:05','system',2,00000000000000001070),(211,'Ram Nagar','','Dhadar',NULL,'1478965',NULL,NULL,NULL,0,'','2011-02-15 10:26:28','system',1,00000000000000001063),(212,'Dodaballapur','','Bangalore',NULL,'178963357',NULL,NULL,NULL,0,'','2011-02-15 10:34:23','system',2,00000000000000001077),(213,'BDA Complex','','as',NULL,'7845896',NULL,NULL,NULL,0,'','2011-02-15 10:41:52','system',2,00000000000000001068),(214,'ganga Nagar','','noida',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-15 10:53:33','system',1,00000000000000001057),(215,'sanjay nagar','','chandigad',NULL,'2456889',NULL,NULL,NULL,0,'','2011-02-15 10:59:37','system',2,00000000000000001067),(216,'malleshwaram','','gurghav',NULL,'145788',NULL,NULL,NULL,0,'','2011-02-15 11:39:23','system',1,00000000000000001063),(217,'Nadini Layout','','Canada',NULL,'32145544',NULL,NULL,NULL,0,'','2011-02-15 12:25:40','system',1,00000000000000001059),(218,'1234 kinsale pl','234','St Louis',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-15 13:41:31','system',1,00000000000000001056),(219,'1234 kinsale pl','234','Sterlng',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-15 13:47:27','system',1,00000000000000001056),(221,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-16 04:11:43','system',1,00000000000000001062),(222,'1234 test','Basaveshwara Nagar','Bangalore',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-16 04:13:17','system',1,00000000000000001066),(223,'1234 test','Basaveshwara Nagar','Sterling',NULL,'20105',NULL,NULL,NULL,0,'','2011-02-16 04:34:38','system',1,00000000000000001063),(224,'jayanagar','','Bagladesh',NULL,'1456358936',NULL,NULL,NULL,1,'','2011-02-16 05:37:15','system',2,00000000000000001067),(225,'Koramangala','','kalkatha',NULL,'142563',NULL,NULL,NULL,0,'','2011-02-16 06:09:02','system',1485,00000000000000001486),(226,'Rajputh Nagar','','Cape Town',NULL,'dggggsgs',NULL,NULL,NULL,0,'','2011-02-16 06:14:10','system',1,00000000000000001002),(227,'Koramangala','','Sriranga ',NULL,'1245775',NULL,NULL,NULL,0,'','2011-02-16 06:19:57','system',1485,00000000000000001486),(228,'Koramangala','','Sriranga ',NULL,'1245775',NULL,NULL,NULL,0,'','2011-02-16 06:21:26','system',2,00000000000000001072),(229,'Basavanagudi','','Dharwad',NULL,'2456',NULL,NULL,NULL,0,'','2011-02-16 06:33:50','system',2,00000000000000001067),(230,'jayanagar','','Bagladesh',NULL,'147895',NULL,NULL,NULL,0,'','2011-02-16 06:43:56','system',1,00000000000000001062),(233,'Rajaji Nagar','','Bangalore',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-16 09:28:22','system',2,00000000000000001074),(234,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-16 09:55:49','system',2,00000000000000001072),(235,'raj mohan roy','7th croos','orisa',NULL,'1478569',NULL,NULL,NULL,0,'','2011-02-16 10:01:39','system',2,00000000000000001071),(236,'Rajathgiri','8th cross','Dharwad',NULL,'478963',NULL,NULL,NULL,0,'','2011-02-16 10:06:29','system',1,00000000000000001002),(237,'9th main','Vasanth Nagar','Ramadurga',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-16 10:11:09','system',1485,00000000000000001486),(239,'raj mohan roy','','Bagladesh',NULL,'14523',NULL,NULL,NULL,0,'','2011-02-16 13:19:54','system',1,00000000000000001057),(240,'Rajathgiri','','Bagladesh',NULL,'14552',NULL,NULL,NULL,0,'','2011-02-16 13:28:43','system',1,00000000000000001003),(241,'maruthi nagar','','hydrabad',NULL,'1452',NULL,NULL,NULL,0,'','2011-02-16 13:32:25','system',2,00000000000000001070),(243,'Richmond Circle','','hydrabad',NULL,'478569',NULL,NULL,NULL,0,'','2011-02-16 13:45:21','system',2,00000000000000001079),(254,'shubas Nagar','','goa',NULL,'145236',NULL,NULL,NULL,0,'','2011-02-17 06:23:58','system',2,00000000000000001068),(257,'Bagalkoti Nagar','','Hydrabad',NULL,'554187',NULL,NULL,NULL,0,'','2011-02-17 07:26:19','system',2,00000000000000001070),(258,'Koramangala','','Sriranga',NULL,'1454',NULL,NULL,NULL,0,'','2011-02-17 11:16:25','system',1,00000000000000001004),(259,'shubas Nagar','','Bangalore',NULL,'1478878',NULL,NULL,NULL,0,'','2011-02-17 11:45:54','system',1,00000000000000001066),(260,'Gayithri Nagar','','Belgaum',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-17 11:59:04','system',2,00000000000000001070),(262,'Bagalkoti Nagar','','Cape Town',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-17 12:54:10','system',2,00000000000000001070),(263,'jayanagar','','Dharwad',NULL,'45222',NULL,NULL,NULL,0,'','2011-02-17 13:11:39','system',2,00000000000000001072),(276,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-17 14:45:22','system',2,00000000000000001072),(277,'Richmond Circle','','Belgaum',NULL,'12458',NULL,NULL,NULL,0,'','2011-02-17 14:46:21','system',2,00000000000000001070),(278,'Richmond Circle','','goa',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-17 14:47:58','system',2,00000000000000001070),(279,'Louis tower','in','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-17 14:56:42','system',2,00000000000000001070),(280,'Bommanahalli','','Yalahanka',NULL,'145365',NULL,NULL,NULL,0,'','2011-02-18 05:31:12','system',1,00000000000000001061),(281,'shubas Nagar','','Bangalore',NULL,'147859',NULL,NULL,NULL,0,'','2011-02-18 05:40:18','system',2,00000000000000001070),(282,'Rajaji Nagar','','Dhadar',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-18 05:42:39','system',1,00000000000000001066),(283,'Gayithri Nagar','','Belgaum',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-18 05:44:29','system',2,00000000000000001070),(284,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-18 05:57:42','system',2,00000000000000001071),(285,'jayanagar','','Dharwad',NULL,'14539',NULL,NULL,NULL,0,'','2011-02-18 06:31:16','system',1,00000000000000001066),(286,'raj mohan roy','','Sriranga',NULL,'12455',NULL,NULL,NULL,0,'','2011-02-18 06:39:02','system',1,00000000000000001060),(287,'Gayithri Nagar','','goa',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-18 07:01:23','system',2,00000000000000001071),(288,'Richmond Circle','','paris',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-18 07:11:19','system',2,00000000000000001069),(289,'shubas Nagar','','Bangalore',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-18 07:24:04','system',2,00000000000000001069),(290,'shubas Nagar','','goa',NULL,'1478687',NULL,NULL,NULL,1,'','2011-02-18 07:27:34','system',1,00000000000000001061),(291,'shubas Nagar','','Dhadar',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-18 07:35:28','system',1,00000000000000001066),(292,'Richmond Circle','','Belgaum',NULL,'1478687',NULL,NULL,NULL,2,'','2011-02-18 07:39:07','system',1,00000000000000001066),(293,'Gayithri Nagar','','goa',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-18 07:50:37','system',2,00000000000000001071),(294,'Bommanahalli','','Ramadurga',NULL,'12458',NULL,NULL,NULL,1,'','2011-02-18 07:52:26','system',1,00000000000000001066),(295,'Gayithri Nagar','','Ramadurga',NULL,'1478878',NULL,NULL,NULL,0,'','2011-02-18 07:57:33','system',1,00000000000000001004),(296,'jayanagar','8th cross','Bagladesh',NULL,'1454',NULL,NULL,NULL,0,'','2011-02-18 12:15:54','system',2,00000000000000001070),(297,'jayanagar','7th croos','Hydrabad',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-18 12:17:55','system',2,00000000000000001069),(298,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-19 06:26:08','system',2,00000000000000001068),(299,'jayanagar','','Hydrabad',NULL,'1454',NULL,NULL,NULL,0,'','2011-02-19 07:16:55','system',2,00000000000000001070),(300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-19 08:01:32','system',1,00000000000000001066),(301,'Rajaji Nagar','Vasanth Nagar','Bangalore',NULL,'12458',NULL,NULL,NULL,1,'','2011-02-19 13:26:38','system',1,00000000000000001006),(302,'Richmond Circle','','goa',NULL,'1478878',NULL,NULL,NULL,0,'','2011-02-21 05:20:23','system',2,00000000000000001069),(303,'shubas Nagar','','Dhadar',NULL,'12458',NULL,NULL,NULL,0,'','2011-02-21 06:04:23','system',2,00000000000000001069),(304,'Richmond Circle','','Bangalore',NULL,'14253',NULL,NULL,NULL,1,'','2011-02-21 06:13:21','system',2,00000000000000001070),(305,'Richmond Circle','','Dhadar',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-21 07:08:00','system',2,00000000000000001069),(306,'shubas Nagar','','paris',NULL,'1478878',NULL,NULL,NULL,0,'','2011-02-21 07:21:50','system',2,00000000000000001070),(307,'Gayithri Nagar','','Bangalore',NULL,'121245432',NULL,NULL,NULL,1,'','2011-02-21 07:24:21','system',2,00000000000000001071),(308,'Richmond Circle','','paris',NULL,'12458',NULL,NULL,NULL,0,'','2011-02-21 07:26:28','system',2,00000000000000001071),(309,'Bommanahalli','','Belgaum',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-21 07:28:23','system',2,00000000000000001070),(310,'Rajaji Nagar','','Bangalore',NULL,'12458',NULL,NULL,NULL,0,'','2011-02-21 07:45:10','system',1,00000000000000001070),(311,'shubas Nagar','','Belgaum',NULL,'14253',NULL,NULL,NULL,0,'','2011-02-21 08:01:05','system',1,00000000000000001003),(312,'Richmond Circle','Vasanth Nagar','paris',NULL,'121245432',NULL,NULL,NULL,0,'','2011-02-21 08:04:35','system',1,00000000000000001003),(313,'jayanagar','','Hydrabad',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-21 08:46:55','system',1,00000000000000001005),(314,'Bagalkoti Nagar','','Hydrabad',NULL,'12455+=1452',NULL,NULL,NULL,1,'','2011-02-21 08:53:47','system',1,00000000000000001003),(315,'Bagalkoti Nagar','','Hydrabad',NULL,'1245775+=1455',NULL,NULL,NULL,0,'','2011-02-21 09:03:42','system',1,00000000000000001061),(316,'jayanagar','','Bagladesh',NULL,'12455',NULL,NULL,NULL,0,'','2011-02-21 09:58:12','system',2,00000000000000001070),(317,'jayanagar','','Bagladesh',NULL,'12455',NULL,NULL,NULL,0,'','2011-02-21 09:59:21','system',1,00000000000000001003),(318,'Bagalkoti Nagar','','Bagladesh',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-21 10:05:02','system',1,00000000000000001005),(319,'Bagalkoti Nagar','','Bagladesh',NULL,'fghftyu236',NULL,NULL,NULL,0,'','2011-02-21 10:05:12','system',1,00000000000000001005),(320,'Bagalkoti Nagar','','Bagladesh',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-21 10:28:39','system',1,00000000000000001002),(321,'Bagalkoti Nagar','','Bagladesh',NULL,'455655sddd',NULL,NULL,NULL,1,'','2011-02-21 10:30:16','system',2,00000000000000001069),(322,'jayanagar','','Sriranga',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-21 10:34:27','system',2,00000000000000001070),(323,'jayanagar','','Bagladesh',NULL,'21124456hghhd',NULL,NULL,NULL,0,'','2011-02-21 10:57:38','system',2,00000000000000001072),(324,'jayanagar','','Hydrabad',NULL,'3535353',NULL,NULL,NULL,0,'','2011-02-21 11:21:54','system',2,00000000000000001079),(325,'jayanagar','','Hydrabad',NULL,'3535353',NULL,NULL,NULL,0,'','2011-02-21 11:23:34','system',1,00000000000000001066),(326,'jayanagar','','Hydrabad',NULL,'3535353',NULL,NULL,NULL,0,'','2011-02-21 11:24:39','system',2,00000000000000001070),(327,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-22 12:22:48','system',1,00000000000000001066),(328,'jayanagar','','Bagladesh',NULL,'455655',NULL,NULL,NULL,0,'','2011-02-23 12:39:56','system',2,00000000000000001069),(329,'15464','','56',NULL,'fiyifyi',NULL,NULL,NULL,2,'','2011-02-23 13:07:18','system',1,00000000000000001001),(330,'123@#$5hjhj','','1432@#$145',NULL,'dsafasf',NULL,NULL,NULL,0,'','2011-02-23 13:11:21','system',2,00000000000000001077),(331,'as145@#$','','@#%%^asd4415',NULL,'aasa@#$1245',NULL,NULL,NULL,0,'','2011-02-23 13:15:11','system',1,00000000000000001006),(332,'as123@#%','','124@#$%',NULL,'dsga',NULL,NULL,NULL,0,'','2011-02-23 13:27:50','system',1,00000000000000001007),(333,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-24 06:38:39','system',2,00000000000000001069),(334,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-24 09:50:45','system',1,00000000000000001066),(335,'da@$$1252','','123678',NULL,'dadd@$@$124',NULL,NULL,NULL,0,'','2011-02-24 11:18:17','system',2,00000000000000001073),(336,'123@#$5hjhj','','1432@#$145',NULL,'afghjk1234',NULL,NULL,NULL,0,'','2011-02-24 12:59:08','system',2,00000000000000001074),(337,'12345678','','6543789034',NULL,'ffffffffgh',NULL,NULL,NULL,0,'','2011-02-24 13:30:30','system',1,00000000000000001008),(338,'@#$adhd123','','1432@#$145',NULL,'sf@$@@1454',NULL,NULL,NULL,0,'','2011-02-25 05:09:24','system',1,00000000000000001006),(339,'14524566','','@$$%&*#@',NULL,'@#$%^%$#@',NULL,NULL,NULL,0,'','2011-02-25 05:25:50','system',2,00000000000000001069),(340,'john nagar','cross','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-25 05:27:47','system',1,00000000000000001063),(341,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,1,'','2011-02-26 23:15:00','system',1,00000000000000001056),(342,'45678 Citi dr','','Sterlng',NULL,'22042',NULL,NULL,NULL,0,'','2011-02-26 23:17:23','system',1,00000000000000001056),(344,'1234 kinsale pl','','Sterlng',NULL,'20105',NULL,NULL,NULL,2,'','2011-02-27 03:06:37','system',1,00000000000000001066),(345,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-02-27 06:08:48','system',2,00000000000000001072),(346,'as324$@$@','','$@$$@$@@%',NULL,'fdsdsgsgds',NULL,NULL,NULL,0,'','2011-02-27 07:21:41','system',2,00000000000000001070),(347,'1256@#$','','124563',NULL,'@#$^%^$%^',NULL,NULL,NULL,0,'','2011-02-28 13:06:47','system',1,00000000000000001007),(348,'13@$@xxnx','','123435552',NULL,'$@#@#$asf12',NULL,NULL,NULL,0,'','2011-02-28 14:21:27','system',2,00000000000000001069),(349,'da@$$1252','','123678',NULL,'dadd@$@$124',NULL,NULL,NULL,0,'','2011-02-28 14:25:21','system',2,00000000000000001071),(350,'da@$$1252','','123678',NULL,'113dd@$$',NULL,NULL,NULL,0,'','2011-02-28 15:05:14','system',2,00000000000000001067),(351,'1244325436','441235535','424231453215',NULL,'@$@$$@',NULL,NULL,NULL,0,'','2011-03-01 05:11:17','system',2,00000000000000001069),(352,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-01 06:54:01','system',2,00000000000000001070),(355,'`123456789','','123456',NULL,'sdfghjk',NULL,NULL,NULL,1,'','2011-03-01 12:18:32','system',2,00000000000000001073),(356,'123@#$5hjhj','','1435435456',NULL,'swdfghjk',NULL,NULL,NULL,1,'','2011-03-01 12:27:35','system',2,00000000000000001069),(358,'14335','','345678',NULL,'asdfghjk',NULL,NULL,NULL,0,'','2011-03-01 13:06:15','system',1,00000000000000001057),(360,'123@#$5hjhj','','11243445',NULL,'szdfxfcgvbnm',NULL,NULL,NULL,0,'','2011-03-01 13:08:27','system',1,00000000000000001066),(364,'32324325','','554677756',NULL,'sdfgvhbjn',NULL,NULL,NULL,0,'','2011-03-01 13:41:25','system',2,00000000000000001076),(367,'kamal nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 13:53:42','system',2,00000000000000001070),(368,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 14:02:16','system',2,00000000000000001070),(370,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 14:06:09','system',1,00000000000000001066),(371,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 14:07:54','system',2,00000000000000001070),(372,'priya nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-02 03:57:09','system',2,00000000000000001071),(374,'#%#%#%','','%#%#%',NULL,'fdhfghh',NULL,NULL,NULL,0,'','2011-03-02 06:06:35','system',1,00000000000000001006),(379,'Rajaji Nagar','','Dhadar',NULL,'121245432',NULL,NULL,NULL,0,'','2011-03-04 06:15:29','system',2,00000000000000001067),(380,'Richmond Circle','','Bangalore',NULL,'121245432',NULL,NULL,NULL,0,'','2011-03-04 11:56:44','system',1,00000000000000001004),(381,'Richmond Circle','','Bangalore',NULL,'121245432',NULL,NULL,NULL,0,'','2011-03-04 11:56:44','system',1,00000000000000001004),(382,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-08 12:22:20','system',1,00000000000000001062),(383,'da@$$1252','12424','Bagladesh',NULL,'ADAD124',NULL,NULL,NULL,3,'','2011-03-08 13:07:57','system',1,00000000000000001007),(384,'da@$$1252','','Bagladesh',NULL,'sdfgvhbjn',NULL,NULL,NULL,0,'','2011-03-08 13:26:51','system',1,00000000000000001008),(385,'da@$$1252','','Hydrabad',NULL,'asda1241',NULL,NULL,NULL,0,'','2011-03-08 13:57:59','system',2,00000000000000001076),(386,'123@#$5hjhj','','Bangalore',NULL,'vcx2134',NULL,NULL,NULL,0,'','2011-03-08 14:18:00','system',1,00000000000000001005);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(255) NOT NULL,
  `authority` varchar(255) NOT NULL,
  UNIQUE KEY `index ix_auth_username` (`username`,`authority`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES ('adityavashisht@yahoo.com','ROLE_FIRM_PARTNER'),('admin@firm.com','ROLE_PARTY'),('admin@firm.com','ROLE_STAFF'),('ady@yahoo.com','ROLE_STAFF'),('anil$@gmail.com','ROLE_FIRM_PARTNER'),('bvbwali@yahoo.com','ROLE_FIRM_PARTNER'),('deepu#yahoo.com','ROLE_STAFF'),('deepu1@yahoo.com','ROLE_STAFF'),('deepu@yahoo.com','ROLE_STAFF'),('guest','ROLE_USER'),('james@chase.com','ROLE_STAFF'),('jp1@telus.net','ROLE_FIRM_PARTNER'),('manju@gmail.com','ROLE_STAFF'),('patil.anand677@gmail.com','ROLE_FIRM_PARTNER'),('prashanth@gmail.com','ROLE_STAFF'),('preety@gmail.com','ROLE_STAFF'),('raju@gmail.com','ROLE_FIRM_PARTNER'),('rohit@yahoo.com','ROLE_STAFF'),('rraniga@uniserve.com','ROLE_FIRM_PARTNER'),('sagar@sgar.com','ROLE_STAFF'),('sagar_bannikal_098@yahoo.com','ROLE_FIRM_PARTNER'),('sandeep@gmail.com','ROLE_STAFF'),('savitrisp@gmail.com','ROLE_FIRM_PARTNER'),('srgudi@yahoo.com','ROLE_FIRM_PARTNER'),('tanveer@gamil.om','ROLE_STAFF');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_info_filing_type`
--

DROP TABLE IF EXISTS `tax_info_filing_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_info_filing_type` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_filing_type`
--

LOCK TABLES `tax_info_filing_type` WRITE;
/*!40000 ALTER TABLE `tax_info_filing_type` DISABLE KEYS */;
INSERT INTO `tax_info_filing_type` VALUES (1,'Tax Filing','Tax Filing Type','','2010-12-20 00:00:00','SYSTEM','SYSTEM','2010-12-20 10:00:00',0),(2,'Installment Filing','Installment Filing Type','','2010-12-20 00:00:00','SYSTEM','SYSTEM','2010-12-20 10:00:00',0);
/*!40000 ALTER TABLE `tax_info_filing_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_communication`
--

DROP TABLE IF EXISTS `party_communication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_communication` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `communication_type` varchar(25) NOT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `contact_detail` varchar(255) DEFAULT NULL,
  `best_time_to_contact` varchar(100) DEFAULT NULL,
  `preferred_flag` bit(1) DEFAULT NULL,
  `party_relattionship_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk932d89fd4b78cfda` (`party_id`),
  CONSTRAINT `fk_party_communication_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_communication`
--

LOCK TABLES `party_communication` WRITE;
/*!40000 ALTER TABLE `party_communication` DISABLE KEYS */;
/*!40000 ALTER TABLE `party_communication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `practice_client_info_id` bigint(20) unsigned NOT NULL,
  `firm_id` bigint(20) unsigned NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `filing_type` smallint(6) unsigned NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `staff_in_charge` bigint(20) unsigned NOT NULL,
  `client_staff_in_charge` bigint(20) unsigned DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `task_note` varchar(4000) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `actual_completion_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `partice_id` bigint(20) unsigned NOT NULL,
  `tax_info_date_rule_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk272d85d1f71582` (`firm_id`),
  KEY `fk272d859af5a7e2` (`customer_id`),
  KEY `fk272d85d1f71532` (`status`),
  KEY `fk272d85d1f71565` (`partice_id`),
  KEY `fkc8aab77ea6e16f70` (`client_staff_in_charge`),
  KEY `fkc8aab77e72401be4` (`staff_in_charge`),
  KEY `fk272d85d1f71542` (`filing_type`),
  KEY `fk_client_practice_info` (`practice_client_info_id`),
  CONSTRAINT `fk272d859af5a7e2` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk272d85d1f71532` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk272d85d1f71542` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk272d85d1f71565` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk272d85d1f71582` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_client_practice_info` FOREIGN KEY (`practice_client_info_id`) REFERENCES `tax_client_practice_info` (`id`),
  CONSTRAINT `fk_status_type` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk_task_is_client_staff_in_charge_fk` FOREIGN KEY (`client_staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_customer` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk_task_is_for_a_firm_party` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_practice_name` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk_task_is_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (4,14,343,345,3,2,NULL,NULL,355,347,'2011-02-23 05:57:42',NULL,NULL,'2011-02-23 05:00:00',NULL,0,NULL,'',9,29),(5,16,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-01-01 05:00:00',NULL,0,NULL,'',1,32),(6,16,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-01-01 05:00:00',NULL,0,NULL,'',1,33),(7,22,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-01-12 05:00:00',NULL,0,NULL,'',1,41),(8,22,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-01-14 05:00:00',NULL,0,NULL,'',1,42),(9,22,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-08-06 04:00:00',NULL,0,NULL,'',1,55),(10,22,314,318,3,2,NULL,NULL,339,338,'2011-02-23 05:57:42',NULL,NULL,'2011-12-18 05:00:00',NULL,0,NULL,'',1,56),(11,25,310,320,3,2,NULL,NULL,342,322,'2011-02-23 05:57:42',NULL,NULL,'2011-01-01 05:00:00',NULL,0,NULL,'',4,57),(12,25,310,320,3,2,NULL,NULL,342,322,'2011-02-23 05:57:42',NULL,NULL,'2011-02-02 05:00:00',NULL,0,NULL,'',4,58);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `id` tinyint(4) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `language_code` varchar(25) DEFAULT NULL,
  `utf8_date_language` varchar(50) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_user_id` varchar(25) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'english','eng','en_us',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_client_practice_info`
--

DROP TABLE IF EXISTS `tax_client_practice_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_client_practice_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tax_firm_practice_type` bigint(20) unsigned NOT NULL,
  `client` bigint(20) unsigned NOT NULL,
  `jurisdiction` bigint(20) NOT NULL,
  `filing_frequency` bigint(20) unsigned NOT NULL,
  `filing_date_reminder` bit(1) NOT NULL,
  `instalment_frequency` bigint(20) unsigned NOT NULL,
  `instalment_reminder` bit(1) NOT NULL,
  `preparer_notes` varchar(4000) DEFAULT NULL,
  `firm_id` bigint(20) unsigned NOT NULL,
  `internal_memo` varchar(4000) DEFAULT NULL,
  `staff_in_charge` bigint(20) unsigned NOT NULL,
  `client_staff_in_charge` bigint(20) unsigned DEFAULT NULL,
  `filing_date_rule` varchar(50) DEFAULT NULL,
  `instalment_date_rule` varchar(50) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `active_flag` bit(1) NOT NULL,
  `partice_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_practice_is_for_a_firm_fk` (`firm_id`),
  KEY `tax_practice_is_for_a_client` (`client`),
  KEY `fkc8aab77ea6e16f70` (`client_staff_in_charge`),
  KEY `fkc8aab77e72401be4` (`staff_in_charge`),
  KEY `client_tax_practice_for_firm_practice_type` (`tax_firm_practice_type`),
  CONSTRAINT `client_tax_practice_for_firm_practice_type` FOREIGN KEY (`tax_firm_practice_type`) REFERENCES `tax_firm_practice_type` (`id`),
  CONSTRAINT `tax_practice_client_staff_in_charge_fk` FOREIGN KEY (`client_staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `tax_practice_is_for_a_client` FOREIGN KEY (`client`) REFERENCES `party` (`party_id`),
  CONSTRAINT `tax_practice_is_for_a_firm_fk` FOREIGN KEY (`firm_id`) REFERENCES `organization` (`party_id`),
  CONSTRAINT `tax_practice_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_client_practice_info`
--

LOCK TABLES `tax_client_practice_info` WRITE;
/*!40000 ALTER TABLE `tax_client_practice_info` DISABLE KEYS */;
INSERT INTO `tax_client_practice_info` VALUES (2,2,334,1,1300,'\0',1400,'\0','somehtng',332,NULL,333,335,NULL,NULL,NULL,'2011-02-09 07:18:16',NULL,NULL,0,'',NULL),(3,3,334,4,1301,'\0',1401,'\0','test',332,NULL,333,335,NULL,NULL,NULL,'2011-02-09 07:30:34',NULL,NULL,0,'',NULL),(4,1,318,2,1300,'\0',1400,'\0','',332,NULL,339,338,NULL,NULL,NULL,'2011-02-10 06:50:18',NULL,NULL,1,'',NULL),(5,1,318,1,1300,'\0',1400,'\0','',314,NULL,339,338,NULL,NULL,NULL,'2011-02-15 05:53:11',NULL,NULL,0,'',NULL),(6,8,318,1,1300,'\0',1400,'\0','',314,NULL,339,338,NULL,NULL,NULL,'2011-02-15 06:10:03',NULL,NULL,0,'',NULL),(7,10,345,2,1300,'',1400,'\0','',343,NULL,355,347,NULL,NULL,NULL,'2011-02-15 12:03:47',NULL,NULL,0,'',NULL),(8,9,345,2,1300,'',1401,'\0','',343,NULL,355,346,NULL,NULL,NULL,'2011-02-15 12:07:14',NULL,NULL,1,'',NULL),(9,1,318,4,1300,'\0',1400,'\0','tet',314,NULL,339,338,NULL,NULL,NULL,'2011-02-16 03:40:19',NULL,NULL,0,'',NULL),(10,2,357,1,1301,'\0',1400,'\0',' notes',332,NULL,336,358,NULL,NULL,NULL,'2011-02-16 04:14:40',NULL,NULL,0,'',NULL),(11,3,357,5,1300,'\0',1400,'\0','tst',332,NULL,336,358,NULL,NULL,NULL,'2011-02-16 04:17:55',NULL,NULL,0,'',NULL),(14,9,345,3,1300,'\0',1400,'\0','',343,NULL,355,347,NULL,NULL,NULL,'2011-02-17 14:01:13',NULL,NULL,0,'',NULL),(16,1,318,1,1301,'\0',1401,'\0','DOne',314,NULL,339,338,NULL,NULL,NULL,'2011-02-19 14:36:29',NULL,NULL,1,'',NULL),(22,1,318,5,1301,'\0',1401,'\0','test',314,NULL,339,338,NULL,NULL,NULL,'2011-02-21 06:53:06',NULL,NULL,10,'',NULL),(25,4,320,4,1300,'\0',1400,'\0','test',310,NULL,342,322,NULL,NULL,NULL,'2011-02-23 05:10:08',NULL,NULL,0,'',NULL),(26,4,320,6,1301,'\0',1401,'\0','test',310,NULL,342,322,NULL,NULL,NULL,'2011-02-24 02:38:23',NULL,NULL,0,'',NULL),(27,1,404,1,1300,'\0',1400,'','test',314,NULL,339,416,NULL,NULL,NULL,'2011-03-08 13:39:21',NULL,NULL,0,'',NULL);
/*!40000 ALTER TABLE `tax_client_practice_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_type`
--

DROP TABLE IF EXISTS `organization_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_type` (
  `id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_type`
--

LOCK TABLES `organization_type` WRITE;
/*!40000 ALTER TABLE `organization_type` DISABLE KEYS */;
INSERT INTO `organization_type` VALUES (1,'FIRM','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0),(2,'CLIENT','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0),(3,'BANK','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0),(4,'INSURANCE','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0),(5,'LAW_FIRM','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0),(6,'TRANSFER AGENT','','2010-06-17 21:11:13','system','system','2010-06-18 05:11:23',0);
/*!40000 ALTER TABLE `organization_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `party_id` bigint(20) unsigned NOT NULL,
  `first_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(60) DEFAULT NULL,
  `middle_name` varchar(60) DEFAULT NULL,
  `person_identification_number` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `person_type` tinyint(3) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fk8c768f554b78cfda` (`party_id`),
  KEY `fk_person_has_a_type` (`person_type`),
  KEY `pk_person_is_of_person_type` (`person_type`),
  CONSTRAINT `fk_person_is_a_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `pk_person_is_of_person_type` FOREIGN KEY (`person_type`) REFERENCES `person_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (300,'Sagar','Best',NULL,NULL,'2000-01-01',1,0,NULL,NULL),(301,'Ady','Vashisth',NULL,NULL,'2011-02-04',1,0,NULL,NULL),(307,'Gangadhar','Wali',NULL,NULL,'2000-01-01',2,0,NULL,NULL),(309,'JP','Bangalore',NULL,NULL,'1980-01-01',2,0,NULL,NULL),(311,'Rajesh','Raniga',NULL,NULL,'1980-01-01',2,0,NULL,NULL),(313,'Aditya','Vashisth',NULL,NULL,'1980-01-01',2,0,NULL,NULL),(315,'Sagar','Bannikal',NULL,NULL,'1980-01-01',2,0,NULL,NULL),(317,'Savitri','Panchamanavar',NULL,NULL,'1989-01-01',2,0,NULL,NULL),(322,'Sue','Treen',NULL,NULL,'2001-02-01',1,0,NULL,NULL),(323,'Rohit','K',NULL,NULL,'2011-02-04',1,0,NULL,NULL),(324,'Rajesh','Raniga',NULL,NULL,'2011-02-02',2,0,NULL,NULL),(325,'Rajesh','Raniga',NULL,NULL,'2011-02-02',2,0,NULL,NULL),(326,'Rajesh','Raniga',NULL,NULL,'2011-02-02',2,0,NULL,NULL),(333,'Shrinivas','Gudi',NULL,NULL,'1980-01-01',2,0,NULL,NULL),(335,'Narayana','Murthy',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(336,'Ady','Sharma',NULL,NULL,'2011-02-01',1,0,NULL,NULL),(337,'Roshan','Reddy',NULL,NULL,'1998-05-06',1,0,NULL,NULL),(338,'Rajeshker','Reddy',NULL,NULL,'2011-02-14',1,0,NULL,NULL),(339,'Prashanth','Keni',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(342,'John','Mahony',NULL,NULL,'2011-02-17',1,0,NULL,NULL),(344,'Anand','Patil',NULL,NULL,'2011-06-01',2,0,NULL,NULL),(346,'raju','',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(347,'sandeep','patil',NULL,NULL,'2011-03-02',1,0,NULL,NULL),(348,'madival','sanglad',NULL,NULL,'2011-03-11',1,0,NULL,NULL),(355,'ajay','gouda',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(358,'Ram','Kumar',NULL,NULL,'1971-02-10',1,0,NULL,NULL),(359,'Vasu','Murthy',NULL,NULL,'1974-02-13',1,0,NULL,NULL),(362,'deepu','Rajputh',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(363,'deepu','Rajputh',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(364,'deepu','Rajputh',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(365,'anil','patil',NULL,NULL,'2011-02-07',2,0,NULL,NULL),(366,'manju','sanglad',NULL,NULL,'2011-02-07',1,0,NULL,NULL),(368,'veeresh','Talloli',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(369,'rajesh','pandith',NULL,NULL,'2011-02-11',1,0,NULL,NULL),(371,'basu','pujer',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(372,'Bhanu','',NULL,NULL,'2011-03-10',1,0,NULL,NULL),(373,'ganesh','',NULL,NULL,'2011-03-10',1,0,NULL,NULL),(374,'Bhanu','',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(375,'raju','sanglad',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(376,'roy','Rajputh',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(379,'raju','sanglad',NULL,NULL,'2011-02-03',2,0,NULL,NULL),(381,'raju','',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(383,'sagar','patil',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(384,'sandeep','',NULL,NULL,'2011-02-02',2,0,NULL,NULL),(385,'madival','',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(386,'sandeep','sanglad',NULL,NULL,'2011-02-01',1,0,NULL,NULL),(387,'sandeep','sanglad',NULL,NULL,'2011-02-12',1,0,NULL,NULL),(390,'raju','',NULL,NULL,'2011-02-09',1,0,NULL,NULL),(391,'raju','',NULL,NULL,'2011-02-09',1,0,NULL,NULL),(392,'raju','Rajputh',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(393,'sandeep','',NULL,NULL,'2011-02-02',1,0,NULL,NULL),(394,'sandeep','patil',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(395,'sandeep','patil',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(396,'sandeep','patil',NULL,NULL,'2011-02-10',1,0,NULL,NULL),(398,'madival','',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(399,'145@#$%ada','ds@#$1452',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(402,'145@#$%ada','@$@$dff123',NULL,NULL,'2011-02-08',1,0,NULL,NULL),(403,'Shanti','k',NULL,NULL,'2011-02-16',1,0,NULL,NULL),(405,'44543@$@fg','1324SFS@$45',NULL,NULL,'2011-02-01',1,0,NULL,NULL),(406,'1317asd@#$','@$@$dff123',NULL,NULL,'2011-02-03',1,0,NULL,NULL),(415,'133413413','1313131',NULL,NULL,'2011-03-09',1,0,NULL,NULL),(416,'Tanveer','k',NULL,NULL,'2011-01-01',1,0,NULL,NULL),(417,'Shanti','',NULL,NULL,'2011-02-08',1,0,NULL,NULL),(420,'Shanti','',NULL,NULL,'2011-03-08',1,0,NULL,NULL),(421,'Preety','',NULL,NULL,'2011-02-08',1,0,NULL,NULL),(423,'1317asd@#$','@$@$dff123',NULL,NULL,'2011-03-16',1,0,NULL,NULL),(425,'paru','patil',NULL,NULL,'2011-03-18',1,0,NULL,NULL),(426,'raju','sanglad',NULL,NULL,'2011-03-10',1,0,NULL,NULL),(427,'sandeep','Rajputh',NULL,NULL,'2011-03-18',1,0,NULL,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_details`
--

DROP TABLE IF EXISTS `person_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_title` varchar(100) DEFAULT NULL,
  `job_title_code` bigint(20) unsigned DEFAULT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  `department_code` bigint(20) unsigned DEFAULT NULL,
  `no_of_shares_owned` bigint(20) DEFAULT NULL,
  `annual_compensation` varchar(25) DEFAULT NULL,
  `comittee` varchar(25) DEFAULT NULL,
  `is_director` bit(1) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `type_of_share` bigint(20) unsigned DEFAULT NULL,
  `is_staff` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_details_is_for_person` (`party_id`),
  KEY `fk_person_details_has_job_title_code` (`job_title_code`),
  KEY `fk_person_details_has_department_code` (`department_code`),
  CONSTRAINT `fk_person_details_has_department_code` FOREIGN KEY (`department_code`) REFERENCES `code` (`id`),
  CONSTRAINT `fk_person_details_has_job_title_code` FOREIGN KEY (`job_title_code`) REFERENCES `code` (`id`),
  CONSTRAINT `fk_person_details_is_for_person` FOREIGN KEY (`party_id`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_details`
--

LOCK TABLES `person_details` WRITE;
/*!40000 ALTER TABLE `person_details` DISABLE KEYS */;
INSERT INTO `person_details` VALUES (31,NULL,1474,NULL,NULL,NULL,'10000000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-02 06:56:59',300,'',NULL,NULL),(32,NULL,101,NULL,NULL,NULL,'1000000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-03 03:55:21',301,'',NULL,NULL),(33,NULL,101,NULL,NULL,NULL,'10000000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-04 01:29:09',307,'',NULL,NULL),(34,NULL,101,NULL,NULL,NULL,'1000000000','Management',NULL,0,NULL,NULL,NULL,'2011-02-04 02:55:55',309,'',NULL,NULL),(35,NULL,101,NULL,NULL,NULL,'1000000000','Management',NULL,0,NULL,NULL,NULL,'2011-02-04 03:01:55',311,'',NULL,NULL),(36,NULL,101,NULL,NULL,NULL,'1000000000','Management',NULL,0,NULL,NULL,NULL,'2011-02-04 03:05:11',313,'',NULL,NULL),(37,NULL,103,NULL,NULL,NULL,'1000000','Accounting',NULL,0,NULL,NULL,NULL,'2011-02-04 03:08:38',315,'',NULL,NULL),(38,NULL,103,NULL,NULL,NULL,'1000000','Accounting',NULL,0,NULL,NULL,NULL,'2011-02-04 03:12:23',317,'',NULL,NULL),(39,NULL,106,NULL,NULL,200000,'1000000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-08 05:51:42',322,'',1200,''),(40,NULL,104,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-08 14:38:56',323,'',NULL,NULL),(41,NULL,107,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-09 02:54:15',324,'',NULL,NULL),(42,NULL,107,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-09 02:54:16',325,'',NULL,NULL),(43,NULL,107,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-09 02:54:16',326,'',NULL,NULL),(44,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-09 06:55:40',333,'',NULL,NULL),(45,NULL,103,NULL,NULL,NULL,'1000000','audit',NULL,0,NULL,NULL,NULL,'2011-02-09 07:03:56',335,'',NULL,NULL),(46,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-09 07:04:53',336,'',NULL,NULL),(47,NULL,107,NULL,NULL,NULL,'200000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-10 06:41:01',337,'',NULL,NULL),(48,NULL,102,NULL,NULL,200,'200000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-10 06:47:56',338,'',1200,''),(49,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-10 06:49:46',339,'',NULL,NULL),(50,NULL,1476,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-15 04:46:31',342,'',NULL,NULL),(51,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-15 07:00:03',344,'',NULL,NULL),(52,NULL,106,NULL,NULL,2,'50000','456344',NULL,5,NULL,NULL,NULL,'2011-02-15 07:49:52',346,'',1200,''),(53,NULL,107,NULL,NULL,124,'50000','patil Enterprises',NULL,3,NULL,NULL,NULL,'2011-02-15 08:20:45',347,'',1201,''),(54,NULL,108,NULL,NULL,23125156,'45000','sales',NULL,4,NULL,NULL,NULL,'2011-02-15 09:09:30',348,'',1201,''),(55,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-15 11:39:23',355,'',NULL,NULL),(56,NULL,103,NULL,NULL,NULL,'1000000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-16 04:13:17',358,'',NULL,NULL),(57,NULL,1475,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 04:34:38',359,'',NULL,NULL),(58,NULL,110,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 06:14:10',362,'',NULL,NULL),(59,NULL,110,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 06:19:57',363,'',NULL,NULL),(60,NULL,110,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 06:21:26',364,'',NULL,NULL),(61,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 06:33:50',365,'',NULL,NULL),(62,NULL,107,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-16 06:43:56',366,'',NULL,NULL),(63,NULL,111,NULL,NULL,5,'500000','SBI Group',NULL,1,NULL,NULL,NULL,'2011-02-16 10:01:39',368,'',1201,''),(64,NULL,107,NULL,NULL,3,'200000','Accountant',NULL,1,NULL,NULL,NULL,'2011-02-16 10:06:29',369,'',1200,''),(65,NULL,108,NULL,NULL,2,'75000','group manager',NULL,1,NULL,NULL,NULL,'2011-02-16 13:28:43',371,'',1200,''),(66,NULL,103,NULL,NULL,23125156,'200000','Accountant',NULL,1,NULL,NULL,NULL,'2011-02-17 07:26:19',372,'',1202,''),(67,NULL,1488,NULL,NULL,124,'50000','banking group',NULL,1,NULL,NULL,NULL,'2011-02-17 11:16:25',373,'',1200,''),(68,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-17 12:54:10',374,'',NULL,NULL),(69,NULL,1477,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-17 13:11:41',375,'',NULL,NULL),(70,NULL,1474,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-18 06:31:17',376,'',NULL,NULL),(71,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-18 12:17:55',379,'',NULL,NULL),(72,NULL,102,NULL,NULL,NULL,'50000','group manager',NULL,0,NULL,NULL,NULL,'2011-02-19 07:16:55',381,'',NULL,NULL),(73,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 08:46:56',383,'',NULL,NULL),(74,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 08:53:47',384,'',NULL,NULL),(75,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 09:03:42',385,'',NULL,NULL),(76,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 09:58:12',386,'',NULL,NULL),(77,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 09:59:21',387,'',NULL,NULL),(78,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 10:28:39',390,'',NULL,NULL),(79,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 10:30:16',391,'',NULL,NULL),(80,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 10:34:27',392,'',NULL,NULL),(81,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 10:57:39',393,'',NULL,NULL),(82,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 11:21:54',394,'',NULL,NULL),(83,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 11:23:34',395,'',NULL,NULL),(84,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-21 11:24:40',396,'',NULL,NULL),(85,NULL,101,NULL,NULL,NULL,'50000','Accountant',NULL,0,NULL,NULL,NULL,'2011-02-23 12:39:56',398,'',NULL,NULL),(86,NULL,102,NULL,NULL,NULL,'14255','sd#$#$1254',NULL,0,NULL,NULL,NULL,'2011-02-23 13:15:11',399,'',NULL,NULL),(87,NULL,102,NULL,NULL,NULL,'1244','sa131@$@',NULL,0,NULL,NULL,NULL,'2011-02-24 11:18:17',402,'',NULL,NULL),(88,NULL,1472,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-25 05:27:47',403,'',NULL,NULL),(89,NULL,1472,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-27 07:21:41',405,'',NULL,NULL),(90,NULL,1475,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 13:06:47',406,'',NULL,NULL),(91,NULL,1474,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-03-01 13:41:25',415,'',NULL,NULL),(92,NULL,101,NULL,NULL,22,'20000','audit',NULL,1,NULL,NULL,NULL,'2011-03-01 13:53:43',416,'',1201,''),(93,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-03-01 14:02:16',417,'',NULL,NULL),(94,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-03-01 14:07:54',420,'',NULL,NULL),(95,NULL,104,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-03-02 03:57:09',421,'',NULL,NULL),(96,NULL,103,NULL,NULL,NULL,'313','sd#$#$1254',NULL,0,NULL,NULL,NULL,'2011-03-02 06:06:35',423,'',NULL,NULL),(97,NULL,106,NULL,NULL,NULL,'124','Accountant',NULL,0,NULL,NULL,NULL,'2011-03-08 13:07:57',425,'',NULL,NULL),(98,NULL,105,NULL,NULL,NULL,'75000','Accountant',NULL,0,NULL,NULL,NULL,'2011-03-08 13:26:51',426,'',NULL,NULL),(99,NULL,102,NULL,NULL,NULL,'145233','Accountant',NULL,0,NULL,NULL,NULL,'2011-03-08 13:57:59',427,'',NULL,NULL);
/*!40000 ALTER TABLE `person_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_preferences`
--

DROP TABLE IF EXISTS `organization_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_preferences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `party_id` bigint(20) unsigned NOT NULL,
  `preference_type` varchar(25) DEFAULT NULL,
  `preference_value` varchar(100) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkae4171cc4b78cfda` (`party_id`),
  CONSTRAINT `fk_organization_preference_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_preferences`
--

LOCK TABLES `organization_preferences` WRITE;
/*!40000 ALTER TABLE `organization_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `party_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `legal_name` varchar(100) DEFAULT NULL,
  `operating_name` varchar(100) DEFAULT NULL,
  `form_of_business` bigint(20) unsigned DEFAULT NULL,
  `business_identification_number` varchar(50) DEFAULT NULL,
  `incorporation_date` date DEFAULT NULL,
  `incorporation_number` varchar(50) DEFAULT NULL,
  `industry_type` bigint(20) unsigned DEFAULT NULL,
  `industry_subtype` bigint(20) unsigned DEFAULT NULL,
  `authorized_capital` varchar(4000) DEFAULT NULL,
  `issued_captial` varchar(4000) DEFAULT NULL,
  `organization_type` tinyint(3) unsigned DEFAULT NULL,
  `last_update_userid` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `in_charge_person` bigint(20) unsigned DEFAULT NULL,
  `year_end_date` date DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fkd063d5334b78cfda` (`party_id`),
  KEY `fk_organization_is_for_type` (`organization_type`),
  KEY `fk_incharge_person_is_a_person` (`in_charge_person`),
  KEY `fk_organization_form_of_business_is_a_code` (`form_of_business`),
  KEY `fk_organization_industry_type` (`industry_type`),
  KEY `fk_organization_industry_subtype_is_code` (`industry_subtype`),
  CONSTRAINT `fk_incharge_person_is_a_person` FOREIGN KEY (`in_charge_person`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_organization_form_of_business_is_a_code` FOREIGN KEY (`form_of_business`) REFERENCES `code` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_subtype_is_code` FOREIGN KEY (`industry_subtype`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_type` FOREIGN KEY (`industry_type`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_is_a_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_organization_is_for_type` FOREIGN KEY (`organization_type`) REFERENCES `organization_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (298,NULL,'Sai Tax Consultants','Sai Tax Consultants',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(299,'John Deere','John','John Deere',500,'4567890','2011-02-01','4567890',401,NULL,'','',2,NULL,NULL,0,NULL,NULL),(302,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(303,NULL,'sadsaasdsa','sadsaasdsa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(304,NULL,'sadsaasdsa','sadsaasdsa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(305,NULL,'Savitri','Savitri',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(306,NULL,'Wali Assoiciates','Wali Assoiciates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(308,NULL,'Transforce Financial Serices','Transforce Financial Serices',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(310,NULL,'Delves Freer Anderson Raniga Caine','Delves Freer Anderson Raniga Caine',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(312,NULL,'Aditya Finances','Aditya Finances',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(314,NULL,'Bannikal Brothers','Bannikal Brothers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(316,NULL,'Savitri Tax Consultants','Savitri Tax Consultants',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(318,'test','test1','test',503,'5666','2011-02-09','99999',405,NULL,'99','gg',2,NULL,NULL,0,NULL,'2011-02-09'),(320,'ABC Parts','ABC Rentals Inc.','ABC Parts',500,'123456789RP0001','2008-02-06','BC123859',402,NULL,'100 Class A Common Voting Shares Without par value','50 Class A Voting Shares @ $2 each',2,NULL,NULL,0,NULL,NULL),(321,'ABC Parts','ABC Ent.','ABC Parts',500,'123456789RP0001','2011-02-05','BC12359',402,NULL,'100Class','550 Class',2,NULL,NULL,0,NULL,NULL),(327,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(328,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(329,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(330,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(331,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,0,NULL,NULL),(332,NULL,'Gudi Karakoona','Gudi Karakoona',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(334,'Infosys','Infosys Corp','Infosys',500,'5666','2011-02-09','99999',402,NULL,'1234','45678',2,NULL,NULL,0,NULL,NULL),(340,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(341,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,0,NULL,NULL),(343,NULL,'Patil Enterprises','Patil Enterprises',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(345,'sanju','sanju pvt ltd','sanju',501,'123545@3#577ererj','2011-02-02','123545#45$qqwr',411,NULL,'djjjhjhjhjh','hdjhjjdd',2,NULL,NULL,0,NULL,'2011-02-02'),(349,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(350,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,0,NULL,NULL),(351,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,0,NULL,NULL),(352,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,0,NULL,NULL),(353,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,4,NULL,NULL,0,NULL,NULL),(354,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,0,NULL,NULL),(357,'TCS','TCS','TCS',504,'5666','1995-02-09','99999',404,NULL,'45567','0988',2,NULL,NULL,0,NULL,'1974-02-15'),(360,NULL,'Shree Enterprises','Shree Enterprises',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(361,NULL,'anand Association','anand Association',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(367,'Tavalon','Tavalon India pvt lmt','Tavalon',505,'123456','2011-02-03','112233',411,NULL,'','',2,NULL,NULL,0,NULL,'2011-02-09'),(370,NULL,'patil\'s Association','patil\'s Association',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(377,NULL,'sandeep Association','sandeep Association',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(378,NULL,'Sadeep','Sadeep',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(380,'sandeep pvt Lmt','Sadeep','sandeep pvt Lmt',504,'1245636','2011-02-10','1478569',405,NULL,'','',2,NULL,NULL,0,NULL,'2011-05-10'),(382,'anand pvt Lmt','anand','anand pvt Lmt',503,'1245636','2011-02-03','1478569',404,NULL,'','',2,NULL,NULL,0,NULL,'2011-02-02'),(388,NULL,'anand','anand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(389,NULL,'anand','anand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(397,'anand pvt Lmt','anand1211','anand pvt Lmt',503,'','2011-02-04','',417,NULL,'','',2,NULL,NULL,0,NULL,'2011-02-02'),(400,'ds4536@#@','467@#$saj','ds4536@#@',502,'145@@sdsdf','2011-02-02','14#$%gfgc',402,NULL,'','',2,NULL,NULL,0,NULL,'2011-02-02'),(401,'#$%asa124','124@#$safs','#$%asa124',500,'fdsg124$#$','2011-02-02','14$#$#gfd',405,NULL,'','',2,NULL,NULL,0,NULL,'2011-02-14'),(404,'Sai Automobiles','Sai Automobiles','Sai Automobiles',504,'5666','2011-02-08','99999',402,NULL,'1223445','677899',2,NULL,NULL,0,NULL,'2011-02-09'),(407,NULL,'13@$$@','13@$$@',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(408,NULL,'467@#$saj','467@#$saj',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(409,NULL,'467@#$saj','467@#$saj',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(410,NULL,'135466','135466',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(411,'ds4536@#@','467@#$saj','ds4536@#@',500,'145@@sdsdf','2011-03-11','14#$%gfgc',403,NULL,'','',2,NULL,NULL,0,NULL,'2011-03-24'),(419,NULL,'Accenture','Accenture',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,0,NULL,NULL),(424,'pooja Associates','pooja','pooja Associates',502,'fdfs','2011-03-10','fdfs',410,NULL,'','',2,NULL,NULL,0,NULL,'2011-03-16');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_status`
--

DROP TABLE IF EXISTS `task_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_status` (
  `id` tinyint(3) unsigned NOT NULL,
  `status` varchar(50) NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_status`
--

LOCK TABLES `task_status` WRITE;
/*!40000 ALTER TABLE `task_status` DISABLE KEYS */;
INSERT INTO `task_status` VALUES (1,'Completed','','2010-12-20 22:12:49','system','system','2010-12-20 22:12:49',0),(2,'Awaiting Client Response','','2010-12-24 22:12:49','system','system','2010-12-24 22:12:49',0),(3,'New','','2011-01-22 10:00:00','system','system','2011-01-22 10:00:00',0);
/*!40000 ALTER TABLE `task_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_firm_practice_type`
--

DROP TABLE IF EXISTS `tax_firm_practice_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_firm_practice_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `practice_id` bigint(20) unsigned NOT NULL,
  `firm_id` bigint(20) unsigned NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_appl_prctc_typ` (`practice_id`),
  KEY `fk_organization` (`firm_id`),
  CONSTRAINT `fk_appl_prctc_typ` FOREIGN KEY (`practice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk_organization` FOREIGN KEY (`firm_id`) REFERENCES `organization` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_firm_practice_type`
--

LOCK TABLES `tax_firm_practice_type` WRITE;
/*!40000 ALTER TABLE `tax_firm_practice_type` DISABLE KEYS */;
INSERT INTO `tax_firm_practice_type` VALUES (1,1,314,'','2011-02-09 00:58:35','system',NULL,NULL,0),(2,2,332,'','2011-02-09 01:56:38','system',NULL,NULL,0),(3,3,332,'','2011-02-09 02:28:57','system',NULL,NULL,0),(4,4,310,'','2011-02-09 22:39:16','system',NULL,NULL,0),(5,5,310,'','2011-02-09 22:40:04','system',NULL,NULL,0),(6,6,310,'','2011-02-09 22:40:42','system',NULL,NULL,0),(7,7,310,'','2011-02-09 22:55:06','system',NULL,NULL,0),(8,8,314,'','2011-02-15 01:09:23','system',NULL,NULL,0),(9,9,343,'','2011-02-15 06:17:45','system',NULL,NULL,0),(10,10,343,'','2011-02-15 07:02:12','system',NULL,NULL,0),(11,11,343,'','2011-02-16 04:32:44','system',NULL,NULL,0),(12,12,343,'','2011-02-16 07:53:06','system',NULL,NULL,0),(13,13,343,'','2011-02-17 08:41:18','system',NULL,NULL,0),(14,14,343,'','2011-02-17 08:46:28','system',NULL,NULL,0),(15,15,343,'','2011-02-18 01:32:58','system',NULL,NULL,0),(16,16,343,'','2011-02-21 03:58:54','system',NULL,NULL,0),(17,17,343,'','2011-02-21 04:27:11','system',NULL,NULL,0),(18,18,343,'','2011-02-21 07:56:34','system',NULL,NULL,0),(19,19,343,'','2011-02-28 08:14:45','system',NULL,NULL,0),(20,20,343,'','2011-03-01 08:56:00','system',NULL,NULL,0),(21,21,343,'','2011-03-02 02:12:21','system',NULL,NULL,0);
/*!40000 ALTER TABLE `tax_firm_practice_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-08 21:48:32
