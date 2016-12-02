-- MySQL dump 10.13  Distrib 5.1.51, for Win32 (ia32)
--
-- Host: localhost    Database: chiguru2
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
  `version` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'suite 200','0193 152a street','surrey','bc','v3r 4h6','canada',NULL,NULL,1,NULL,NULL,'system',NULL,NULL),(2,'suite 500','2567 banking lane','surrey','bc','560079','canada',NULL,NULL,3,'\0',NULL,'system',1,00000000000000001066),(3,'1305 72nd ave','unit 507','surrey','bc','v3r 5h6','canada',NULL,NULL,2,'\0',NULL,'system',2,NULL),(4,'1245 ceo drive','IN','surrey','bc','560079','canada',NULL,NULL,2,'\0',NULL,'system',1,00000000000000001066),(5,'1245 legal drive',NULL,'surrey','bc','v3r 5h6','canada',NULL,NULL,1,NULL,NULL,'system',NULL,NULL),(6,'1245 van bank dr',NULL,'surrey','bc','v3r 5h6','canada',NULL,NULL,1,NULL,NULL,'system',NULL,NULL),(12,'13200 Centerville road','3rd cross','Herndon','VA','20170','USA',NULL,NULL,7,'','2010-06-24 06:03:56','system',1,00000000000000001063),(16,'13200 Centerville road','123456 Karo Kabhie','Herndon','VA','20170','USA',NULL,NULL,8,'','2010-06-24 06:26:20','system',1,00000000000000001056),(49,'3333 bestbuy ln','','Reston',NULL,'20170',NULL,NULL,NULL,2,'','2010-08-30 06:38:01','system',1,00000000000000001065),(72,'one bank st','','Reston',NULL,'20170',NULL,NULL,NULL,0,'','2010-09-11 06:30:29','system',1,NULL),(73,'one bank st','','Reston',NULL,'',NULL,NULL,NULL,0,'','2010-09-13 10:37:50','system',2,NULL),(78,'333 boa ln','','Reston',NULL,'',NULL,NULL,NULL,0,'','2010-09-13 12:52:28','system',1,00000000000000001056),(79,'333 boa ln','','Reston',NULL,'',NULL,NULL,NULL,0,'','2010-09-13 13:04:42','system',1,00000000000000001056),(80,'333 boa ln','some 2nd rd','Reston',NULL,'560079',NULL,NULL,NULL,12,'','2010-09-13 13:10:18','system',1,00000000000000001056),(90,'3333 american drm way','','Reston',NULL,'20170',NULL,NULL,NULL,1,'','2010-09-16 03:19:10','system',1,00000000000000001056),(96,'3333 american drm way','','Reston',NULL,'20170',NULL,NULL,NULL,0,'','2010-09-16 04:14:09','system',1,NULL),(101,'12 Wisonsin Ave','','Washington',NULL,'22100',NULL,NULL,NULL,0,'','2010-09-16 20:36:51','system',1,00000000000000001056),(102,'23 Jeresy Ave','','New York',NULL,'01109',NULL,NULL,NULL,0,'','2010-09-16 20:46:34','system',1,00000000000000001038),(103,'9508 Leafcrest ln','','Herndon',NULL,'22042',NULL,NULL,NULL,0,'','2010-09-18 11:48:26','system',1,00000000000000001056),(104,'2345 Germonrown Rd','','Fairfax',NULL,'22032',NULL,NULL,NULL,0,'','2010-09-18 11:51:05','system',1,00000000000000001056),(105,'23 Vieena Ave','','Mclean',NULL,'22040',NULL,NULL,NULL,0,'','2010-09-20 02:15:56','system',1,00000000000000001056),(106,'9508 Dover ln','','Falls Church',NULL,'22042',NULL,NULL,NULL,0,'','2010-09-20 02:18:03','system',1,00000000000000001056),(112,'9508 Leafcrest ln','','Boulder',NULL,'22042',NULL,NULL,NULL,0,'','2010-09-23 04:37:35','system',1,00000000000000001008),(113,'23 Vieena Ave','','Herndon',NULL,'22040',NULL,NULL,NULL,0,'','2010-09-23 04:39:08','system',1,00000000000000001006),(115,'12 Wisonsin Ave','','Ottava',NULL,'',NULL,NULL,NULL,0,'','2010-09-24 03:28:51','system',2,00000000000000001075),(116,'2345 Fifth Ave','','New York',NULL,'',NULL,NULL,NULL,0,'','2010-09-25 14:25:17','system',2,NULL),(117,'12 Wisonsin Ave','Siute #600','Washington',NULL,'22100',NULL,NULL,NULL,1,'','2010-09-26 11:44:23','system',NULL,NULL),(118,'9508 Leafcrest ln','','Washington',NULL,'22042',NULL,NULL,NULL,0,'','2010-09-29 03:09:39','system',1,00000000000000001063),(119,'12 Wisonsin Ave','','Falls Church',NULL,'20105',NULL,NULL,NULL,0,'','2010-09-30 02:23:28','system',1,00000000000000001056),(120,'12 Wisonsin Ave','','Washington',NULL,'20105',NULL,NULL,NULL,0,'','2010-09-30 04:22:00','system',1,00000000000000001011),(121,'12 Wisonsin Ave','','Ottava',NULL,'12345',NULL,NULL,NULL,0,'','2010-10-07 05:36:24','system',2,00000000000000001069),(122,'45 Insurance Ln','','Toronto',NULL,'01112',NULL,NULL,NULL,0,'','2010-10-08 22:20:34','system',2,00000000000000001077),(123,'67 ING dr','','Vancuoour',NULL,'90673',NULL,NULL,NULL,0,'','2010-10-09 01:08:10','system',2,00000000000000001071),(124,'4567 Romeo IN','','Arlington',NULL,'20140',NULL,NULL,NULL,1,'','2010-10-10 10:28:10','system',1,00000000000000001056),(125,'5501 Backlick rd','','Springfield',NULL,'22151',NULL,NULL,NULL,0,'','2010-10-10 11:01:21','system',1,00000000000000001056),(126,'3rd main','doller colony','Springfield','bc','22151','canada',NULL,NULL,NULL,NULL,NULL,'system',1,00000000000000001056),(128,'kamala $','$ colony','banglore',NULL,'248464',NULL,NULL,NULL,2,'','2010-11-20 13:28:23','system',1,00000000000000001061),(129,'3rd MAIN','doller colony','Bangalore',NULL,'560079',NULL,NULL,NULL,2,'','2010-11-30 08:28:51','system',1,00000000000000001057),(130,'3rd MAIN','doller colony','Bangare',NULL,'560079',NULL,NULL,NULL,6,'','2010-11-30 08:38:19','system',2,00000000000000001072),(132,'Basaveshwar Nagar','doller colony','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2010-12-02 07:34:24','system',1,00000000000000001063),(133,'Basaveshwar Nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2010-12-03 15:23:00','system',1,00000000000000001002),(134,'3rd main','doller colony','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2010-12-21 13:04:57','system',2,00000000000000001078),(136,'4567 Romeo IN','rtrtrtert','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-07 11:57:55','system',1,00000000000000001066),(146,'suite 400','suite 400','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-25 10:34:19','system',2,00000000000000001071),(147,'4567 Romeo IN','rtrtrtert','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-25 10:38:08','system',1,00000000000000001062),(150,'suite 400','Ln','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-25 11:28:10','system',2,00000000000000001068),(154,'9508 Leafcrest ININ','in','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-26 06:09:28','system',2,00000000000000001070),(156,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-01-26 10:15:17','system',1,00000000000000001061),(157,'suite 400','3rd cross','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-28 08:09:51','system',2,00000000000000001070),(158,'','','',NULL,'',NULL,NULL,NULL,0,'','2011-01-28 09:09:03','system',NULL,NULL),(159,'9508 Leafcrest ININ','in','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-28 11:58:31','system',1,00000000000000001061),(162,'Kamal nagar','3rd cross','bangalore',NULL,'560079',NULL,NULL,NULL,1,'','2011-01-29 11:38:33','system',1,00000000000000001061),(163,'Basaveshwar Nagar','Inner','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-29 11:42:34','system',1,00000000000000001062),(164,'','','',NULL,'',NULL,NULL,NULL,0,'','2011-01-29 12:22:32','system',NULL,NULL),(165,'Basaveshwar Nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-29 12:52:23','system',1,00000000000000001004),(166,'Basaveshwar Nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-31 13:09:01','system',1,00000000000000001061),(167,'Basaveshwar Nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-31 13:52:59','system',1,00000000000000001061),(168,'Basaveshwar Nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-01-31 14:08:32','system',1,00000000000000001066),(171,'kiran nagar','doller colony','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-01 04:32:30','system',1,00000000000000001065),(172,'Basaveshwar Nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-01 05:34:14','system',1463,00000000000000001464),(173,'3rd MAIN','cross','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-01 05:38:41','system',1463,00000000000000001464),(174,'krishna','krishna','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-02 04:27:16','system',1463,00000000000000001464),(176,'guru nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-02 08:59:46','system',1,00000000000000001066),(181,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-02 14:26:10','system',1461,00000000000000001462),(182,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-03 07:09:13','system',2,00000000000000001067),(183,'sallu nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-04 13:06:07','system',1,00000000000000001063),(184,'khadeer nagar','4th cross','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-04 13:08:58','system',2,00000000000000001069),(185,'sallu nagar','3rd cross','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-04 13:12:01','system',1,00000000000000001061),(186,'sallu nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-04 13:16:01','system',1,00000000000000001061),(187,'guru nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-05 08:00:11','system',1,00000000000000001058),(188,'punit nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-05 08:10:36','system',1,00000000000000001057),(189,'punit nagar','Shankar Math','Bangalore',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-05 08:11:12','system',1,00000000000000001063),(190,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 12:26:42','system',1463,00000000000000001464),(192,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 12:46:23','system',1,00000000000000001064),(193,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 12:48:10','system',1,00000000000000001057),(194,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 12:50:37','system',2,00000000000000001077),(195,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 12:56:59','system',2,00000000000000001068),(197,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 13:01:49','system',2,00000000000000001074),(198,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-05 13:05:09','system',1461,00000000000000001462),(199,'Rajajinagar','4th block','Bangalore',NULL,'124563',NULL,NULL,NULL,0,'','2011-02-05 13:20:42','system',1463,00000000000000001464),(200,'Basaveshvar Nagar','8th Main','bangalore',NULL,'96',NULL,NULL,NULL,0,'','2011-02-05 13:33:10','system',1463,00000000000000001464),(201,'roshan nagar','4th cross','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 07:38:15','system',2,00000000000000001070),(202,'Vinod Nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 11:53:52','system',2,00000000000000001071),(203,'Amir Nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 12:04:38','system',2,00000000000000001072),(204,'xchanging nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 14:27:31','system',2,00000000000000001072),(205,'arvind nagar','','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-08 14:29:37','system',2,00000000000000001071),(206,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-08 14:32:42','system',1,00000000000000001061),(207,'reddy nagar','','Hydrabad',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-09 12:31:10','system',1,00000000000000001064),(208,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,'admin@firm.com','2011-03-29 09:21:55',2,'','2011-02-11 06:47:30','system',1,00000000000000001061),(209,'shaker nagar','','Bangalore',NULL,'124563',NULL,NULL,NULL,0,'','2011-02-11 07:06:33','system',1,00000000000000001066),(210,'sai nagar','','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-11 09:01:54','system',2,00000000000000001071),(211,'Malli hopital','','bangalore',NULL,'560079',NULL,NULL,NULL,1,'','2011-02-11 12:06:59','system',1,00000000000000001057),(212,'deepak nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-11 12:08:53','system',2,00000000000000001068),(213,'rajendra nagar','','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-11 12:10:42','system',1,00000000000000001063),(214,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-14 06:39:50','system',1,00000000000000001063),(215,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-14 07:17:48','system',2,00000000000000001072),(216,'near Ramiah college','','Bangalore',NULL,'A1B 2C3',NULL,NULL,NULL,1,'','2011-02-14 09:07:01','system',1,00000000000000001064),(217,'guru nagar','','Bangalore',NULL,'A1B 2C3',NULL,NULL,NULL,1,'','2011-02-14 09:08:13','system',1,00000000000000001061),(218,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-02-14 09:09:39','system',1,00000000000000001062),(220,'sallu nagar','3rd cross','bangalore',NULL,'96',NULL,NULL,NULL,0,'','2011-02-15 08:24:25','system',1,NULL),(221,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-15 13:30:47','system',2,00000000000000001070),(222,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-15 13:36:50','system',2,NULL),(223,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-15 13:41:45','system',2,NULL),(224,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-15 13:56:28','system',1,00000000000000001066),(225,'sallu nagar','8th Main','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-15 14:07:00','system',2,00000000000000001068),(229,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,1,'','2011-02-16 10:43:21','system',1,NULL),(230,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-16 10:51:13','system',1,NULL),(231,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,1,'','2011-02-16 12:03:22','system',1,NULL),(232,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,1,'','2011-02-16 12:05:23','system',2,NULL),(233,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,1,'','2011-02-16 12:06:10','system',1461,00000000000000001462),(234,'Louis tower','3rd cross','bangalore',NULL,'96',NULL,NULL,NULL,0,'','2011-02-16 12:11:27','system',2,00000000000000001071),(235,'Louis tower','8th Main','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-16 14:00:32','system',1,00000000000000001062),(236,'','','',NULL,'',NULL,NULL,NULL,0,'','2011-02-17 04:19:06','system',NULL,NULL),(237,'Louis tower','8th Main','Romeo',NULL,'96',NULL,NULL,NULL,1,'','2011-02-17 07:08:14','system',1,NULL),(238,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-17 07:18:07','system',2,00000000000000001071),(239,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-17 07:23:19','system',1,00000000000000001064),(240,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-17 08:13:13','system',1,00000000000000001066),(241,'','','',NULL,'',NULL,NULL,NULL,0,'','2011-02-17 08:14:21','system',NULL,NULL),(242,'','','',NULL,'',NULL,NULL,NULL,0,'','2011-02-17 08:15:12','system',NULL,NULL),(243,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-17 15:16:32','system',1,00000000000000001062),(244,'Louis tower','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-18 05:51:44','system',1,00000000000000001061),(245,'Louis tower','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-18 06:04:35','system',1,00000000000000001066),(246,'guru nagar','cross','Bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-18 14:52:24','system',2,00000000000000001071),(247,'guru nagar','cross','surrey',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-21 06:39:02','system',1,00000000000000001062),(248,'Basaveshvar Nagar','','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-21 07:33:38','system',1,00000000000000001062),(249,'Basaveshvar Nagar','3rd cross','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-21 07:35:52','system',1,00000000000000001061),(250,'Louis tower','','Romeo',NULL,'96',NULL,NULL,NULL,0,'','2011-02-21 07:36:52','system',1,00000000000000001061),(251,'Basaveshvar Nagar','8th Main','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-21 07:37:53','system',1,00000000000000001063),(252,'Basaveshvar Nagar','3rd cross','bangalore',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-21 07:39:11','system',2,00000000000000001070),(253,'Louis tower','3rd cross','Romeo',NULL,'560079',NULL,NULL,NULL,0,'','2011-02-21 07:51:18','system',2,00000000000000001067),(254,'Louis tower','3rd cross','bangalore',NULL,'96',NULL,NULL,NULL,0,'','2011-02-21 08:21:13','system',1,00000000000000001066),(255,'kamal nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-26 09:59:39','system',1,00000000000000001062),(256,'tranfer nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-26 10:22:09','system',1,00000000000000001066),(257,'ramayan nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-26 10:38:07','system',1,00000000000000001004),(258,'sita nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-26 10:45:35','system',2,00000000000000001072),(259,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,NULL,NULL,1,'','2011-02-27 06:25:16','system',1,00000000000000001066),(260,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-02-27 06:44:22','system',1,00000000000000001066),(261,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-02-27 06:44:41','system',2,00000000000000001067),(262,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-02-28 05:39:24','system',2,00000000000000001072),(263,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-02-28 05:40:48','system',2,00000000000000001067),(266,'john nagar','','banglore',NULL,'A1B 2C3',NULL,'admin@firm.com','2011-03-26 06:38:37',2,'','2011-02-28 10:39:28','system',2,00000000000000001067),(268,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 13:32:22','system',1,00000000000000001058),(269,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 13:41:55','system',1,00000000000000001063),(270,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 13:46:50','system',1,00000000000000001002),(271,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 13:49:10','system',2,00000000000000001068),(272,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 13:51:10','system',1,00000000000000001003),(273,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-02-28 14:02:40','system',2,00000000000000001079),(275,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-03-01 05:22:36','system',1,00000000000000001063),(276,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 07:12:20','system',1,00000000000000001061),(277,'shanti nagar','','banglore',NULL,'2345',NULL,NULL,NULL,0,'','2011-03-01 07:39:41','system',2,00000000000000001071),(278,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-01 07:53:28','system',1,00000000000000001062),(279,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-03-01 07:54:19','system',1,00000000000000001061),(280,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-03-01 08:05:53','system',1,00000000000000001062),(281,'3rd main','','Bangolre',NULL,'234',NULL,NULL,NULL,0,'','2011-03-01 08:22:08','system',1,00000000000000001003),(282,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-02 06:24:49','system',1,00000000000000001061),(283,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-02 06:31:58','system',2,00000000000000001067),(284,'shanti nagar','','banglore',NULL,'A1B 2C3',NULL,NULL,NULL,1,'','2011-03-02 07:24:49','system',1,00000000000000001061),(285,'shanti nagar','','banglore',NULL,'A1B 2C3',NULL,NULL,NULL,2,'','2011-03-02 10:45:37','system',2,00000000000000001077),(286,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'','2011-03-07 08:47:46','system',1,00000000000000001063),(287,'shanti nagar','','banglore',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 13:29:29','system',2,00000000000000001074),(288,'john nagar','','banglore',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 13:39:11','system',2,00000000000000001077),(289,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 13:41:47','system',1,00000000000000001058),(290,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 13:48:28','system',1,00000000000000001065),(291,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 14:16:29','system',1,00000000000000001062),(292,'3rd main','','Bangolre',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-15 14:17:25','system',1,00000000000000001057),(293,'shanti nagar','','Bangalore',NULL,'A1B 2C3',NULL,NULL,NULL,0,'','2011-03-22 04:06:39','system',1,00000000000000001061),(294,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'','2011-03-24 05:18:32','Sagar',1,00000000000000001061),(295,NULL,NULL,NULL,NULL,NULL,NULL,'kotragoud','2011-03-24 07:35:11',2,'','2011-03-24 07:32:44','system',1,00000000000000001061),(296,'sachin nagar','','Bangalore',NULL,'A1B 2C3',NULL,'karthik@jlc.com','2011-03-26 07:12:48',2,'','2011-03-26 07:12:31','karthik@jlc.com',1,00000000000000001066);
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
INSERT INTO `authorities` VALUES ('admin@firm.com','ROLE_PARTY'),('admin@firm.com','ROLE_STAFF'),('arvind@gmail.com','ROLE_STAFF'),('dhaksha1@chiguru.com','ROLE_FIRM_ADMIN'),('dhaksha@chiguru.com','ROLE_STAFF'),('druva@yahoo.com','ROLE_FIRM_PARTNER'),('guest','ROLE_USER'),('guru@gmail.com','ROLE_STAFF'),('guru@yahoomail.com','ROLE_STAFF'),('james@chase.com','ROLE_STAFF'),('karthik@jlc.com','ROLE_STAFF'),('krishna@gmail.com','ROLE_STAFF'),('prasad@gmail.com','ROLE_FIRM_PARTNER'),('vinod@yahoo.com','ROLE_FIRM_PARTNER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
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
  `create_user_id` varchar(50) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `application_level_indicator` bit(1) NOT NULL,
  `last_update_user_id` varchar(50) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `parent_code_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fK_code_belongs_to_code_type` (`code_type_id`),
  KEY `fK_code_related_to_code` (`parent_code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code`
--

LOCK TABLES `code` WRITE;
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
INSERT INTO `code` VALUES (1,'USA','United States of AmericA',1,13,'2010-07-16 03:49:15','system',1,'','admin@firm.com','2011-03-28 09:10:31',NULL,''),(2,'CANADA','Canada',1,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(101,'CEO','Chief Executive Officer',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(102,'CFO','Chief Finance Officer',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(103,'Director','Director',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(104,'VP','Vice President',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(105,'President','President',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(106,'Manager','Manager',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(107,'Accountant','Accountant',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(108,'Supervisor','Supervisor',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(109,'Sales Representative','Sales Representative',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(110,'Bank Teller','Bank Teller',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(111,'Bank Manager','Bank Manager',5,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(201,'Accounts','Accounts',6,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(202,'HR','Human Resources',6,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(203,'Sales','Sales',6,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(204,'Finance','Finance',6,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(205,'Front Office','Front Office',6,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(401,'Agriculture','Agriculture',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(402,'Automotive','Automotive',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(403,'Chemicals','Chemicals',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(404,'Construction','Construction',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(405,'Consumer Goods & Services','Consumer Goods & Services',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(406,'Defense & Aerospace','Defense & Aerospace',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(407,'Energy','Energy',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(408,'Financial Services','Financial Services',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(409,'Firearms & Explosives','Firearms & Explosives',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(410,'Food & Beverage','Food & Beverage',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(411,'Health Care','Health Care',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(412,'Mining & Drilling','Mining & Drilling',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(413,'Pharmaceuticals & Biotechology','Pharmaceuticals & Biotechology',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(414,'Printing & Publishing','Printing & Publishing',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(415,'Real Estate','Real Estate',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(416,'Telecommunications','Telecommunications',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(417,'Transportation & Logistics','Transportation & Logistics',4,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(418,'Law','Law',4,0,'2010-10-09 13:04:09','system',1,'','system',NULL,NULL,''),(500,'Incorporated','Incorporated',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(501,'ULC','ULC',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(502,'UFP','UFP',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(503,'Trust','Trust',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(504,'LLC','LLC',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(505,'Partnership','Partnership',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(506,'Proprietorship','Proprietorship',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(507,'Other','Other',3,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',NULL,''),(700,'Bank Account','Bank Account',7,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',NULL,''),(701,'Insurance Policy Account','Insurance Policy Account',7,0,'2010-07-16 03:49:15','system',2,'','system','2010-06-22 14:38:01',NULL,''),(702,'Transfer Agency Account','Transfer Agency Account',7,0,'2010-10-09 00:39:23','system',1,'','system',NULL,NULL,''),(703,'Law Firm Account','Law Firm Account',7,0,'2010-10-10 01:42:42','system',2,'','system','2010-10-10 01:42:33',NULL,''),(800,'Checking','Checking',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',700,''),(801,'Savings','Savings',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',700,''),(802,'Investment','Investment',8,0,'2010-09-24 03:35:47','system',3,'','system','2010-06-22 14:38:01',700,''),(803,'Term Deposits','Term Deposits',8,0,'2010-09-24 03:36:10','system',4,'','system','2010-06-22 14:38:01',700,''),(804,'Other','Other',8,0,'2010-09-24 03:36:34','system',5,'','system','2010-06-22 14:38:01',700,''),(805,'Credit','Credit',8,0,'2010-09-24 03:36:10','system',4,'','system','2010-06-22 14:38:01',700,''),(806,'Mortgage','Mortgage',8,0,'2010-09-24 03:36:10','system',4,'','system','2010-06-22 14:38:01',700,''),(821,'Whole Life Innsurance','Whole Life Insurance',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',701,''),(822,'Term Life Innsurance','Term Life Insurance',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',701,''),(851,'Admiralty and Maritime','Admiralty and Maritime',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(852,'Adoption','Adoption',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(853,'ADR','ADR',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(854,'Asbestos:Mesothelioma','AdmiralAsbestos:Mesotheliomaty and Maritime',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(855,'Aviation Law','Aviation Law',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(856,'Bankruptcy','Bankruptcy',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(857,'Business Law','Business Law',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(858,'Controlled Substance','Controlled Substance',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(859,'Car Accident','Car Accident',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(860,'Catastrophic Injuries','Catastrophic Injuries',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(861,'Child Custody','Child Custody',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(862,'Children Rights','Children Rights',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(863,'Collaborative Law','Collaborative Law',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(864,'Consumer','Consumer',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(865,'Credit Card Fraud','Credit Card Fraud',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(866,'Criminal Defense','Criminal Defense',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(867,'Criminal Law','Criminal Law',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(868,'Divorce','Divorce',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(869,'Discrimination','Discrimination',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(870,'Domestic Violence','Domestic Violence',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(871,'Drug Charges','Drug Charges',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(872,'DUI - DWI','DUI - DWI',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(873,'Employment','Employment',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(874,'Estate & Trust','Estate & Trust',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(875,'Family','Family',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(876,'Foreclosure','Foreclosure',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(877,'Immigration','Immigration',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(878,'Intellectual Property','Intellectual Property',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(879,'Litigation','Litigation',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(880,'Medical Malpractice','Medical Malpractice',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(881,'Motor Vehicle','Motor Vehicle',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(882,'Personal Injury','Personal Injury',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(883,'Patent','Patent',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(884,'Real Estate','Real Estate',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(885,'Slip and Fall','Slip and Fall',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(886,'Taxation','Taxation',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(887,'Trade','Trade',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(888,'Trademark','Trademark',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(889,'Transportation','Transportation',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(890,'Truck Accident','Truck Accident',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(891,'Visas','Visas',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(892,'White Collar Crime','White Collar Crime',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(893,'Workplace Safety','Workplace Safety',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(894,'Worker Compensation','Worker Compensation',8,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',703,''),(1001,'AK','Alaska',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:44:16',1,''),(1002,'AL','Alabama',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:50:09',1,''),(1003,'AS','American Samoa',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 13:50:50',1,''),(1004,'AS','American Samoa',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:00:03',1,''),(1005,'AZ','Arizona',2,0,'2010-07-16 03:49:15','system',4,'','system','2010-06-22 14:00:03',1,''),(1006,'AR','Arkansas',2,0,'2010-07-16 03:49:15','system',5,'','system','2010-06-22 14:00:03',1,''),(1007,'CA','California',2,0,'2010-07-16 03:49:15','system',6,'','system','2010-06-22 14:00:03',1,''),(1008,'CO','Colorado',2,0,'2010-07-16 03:49:15','system',7,'','system','2010-06-22 14:00:03',1,''),(1009,'CT','Connecticut',2,0,'2010-07-16 03:49:15','system',8,'','system','2010-06-22 14:00:03',1,''),(1010,'DE','Delaware',2,8,'2010-07-16 03:49:15','system',9,'','system','2010-06-22 14:00:03',1,''),(1011,'DC','District of Columbia',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1012,'FM','Federated code of Micronesia',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1013,'FL','Florida',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1014,'GA','Georgia',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1015,'GU','Guam',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1016,'HI','Hawaii',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1017,'ID','Idaho',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1018,'IL','Illinois',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1019,'IN','Indiana',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1020,'IA','Iowa',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1021,'KS','Kansas',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1022,'KY','Kentucky',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1023,'LA','Louisiana',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1024,'ME','Maine',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1025,'MH','Marshall Islands',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1026,'MD','Maryland',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1027,'MA','Massachusetts',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1028,'MI','Michigan',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1029,'MN','Minnesota',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1030,'MS','Mississippi',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1031,'MO','Missouri',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1032,'MT','Montana',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1033,'NE','Nebraska',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1034,'NV','Nevada',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1035,'NH','New Hampshire',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1036,'NJ','New Jersey',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1037,'NM','New Mexico',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1038,'NY','New York',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1039,'NC','North Carolina',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1040,'ND','North Dakota',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1041,'MP','Northern Mariana Islands',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1042,'OH','Ohio',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1043,'OK','Oklahoma',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1044,'OR','Oregon',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1045,'PW','Palau',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1046,'PA','Pennsylvania',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1047,'PR','Puerto Rico',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1048,'RI','Rhode Island',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1049,'SC','South Carolina',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1050,'SD','South Dakota',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1051,'TN','Tennessee',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1052,'TX','Texas',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1053,'UT','Utah',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1054,'VT','Vermont',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1055,'VI','Virgin Islands',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1056,'VA','Virginia',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1057,'WA','Washington',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1058,'WV','West Virginia',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1059,'WI','Wisconsin',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1060,'WY','Wyoming',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1061,'AE','Armed Forces Africa',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1062,'AA','Armed Forces Americas (except Canada)',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1063,'AE','Armed Forces Canada',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1064,'AE','Armed Forces Europe',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1065,'AE','Armed Forces Middle East',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1066,'AP','Armed Forces Pacific',2,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:00:03',1,''),(1067,'AB','Alberta',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1068,'BC','British Columbia',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1069,'MB','Manitoba',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1070,'NB','New Brunswick',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1071,'NL','Newfoundland and Labrador',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1072,'NT','Northwest Territories',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1073,'NS','Nova Scotia',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1074,'NU','Nunavut',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1075,'ON','Ontario',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1076,'PE','Prince Edward Island',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1077,'QC','Québec',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1078,'SK','Saskatchewan',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1079,'YT','Yukon Territory',2,0,'2010-07-16 03:49:15','system',3,'','system','2010-06-22 14:38:01',2,''),(1200,'Ordinary Shares','Ordinary Shares',9,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',NULL,''),(1201,'Preferred Shares','Preferred Shares',9,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',NULL,''),(1202,'Other','Other',9,0,'2010-07-16 03:49:15','system',1,'','system','2010-06-22 14:38:01',NULL,''),(1300,'Yearly','Yearly',10,0,'2010-12-06 18:30:00','system',1,'','system','2010-12-06 18:30:00',NULL,''),(1301,'Semi Yearly','Semi Yearly',10,0,'2010-12-06 18:30:00','system',2,'',NULL,NULL,NULL,''),(1302,'Quarterly','Quarterly',10,0,'2010-12-06 18:30:00','system',3,'',NULL,NULL,NULL,''),(1303,'Monthly','Monthly',10,0,'2010-12-06 18:30:00','system',4,'',NULL,NULL,NULL,''),(1351,'1','1',12,0,'2010-12-07 06:30:00','system',1,'','system','2010-12-07 06:30:00',NULL,''),(1352,'3','3',12,0,'2010-12-07 06:30:00','system',2,'',NULL,NULL,NULL,''),(1353,'7','7',12,0,'2010-12-07 06:30:00','system',3,'',NULL,NULL,NULL,''),(1354,'15','15',12,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1355,'30','30',12,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1356,'60','60',12,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1357,'90','90',12,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1400,'Yearly','Yearly',11,0,'2010-12-07 06:30:00','system',1,'','system','2010-12-07 06:30:00',NULL,''),(1401,'Semi Yearly','Semi Yearly',11,0,'2010-12-07 06:30:00','system',2,'',NULL,NULL,NULL,''),(1402,'Quarterly','Quarterly',11,0,'2010-12-07 06:30:00','system',3,'',NULL,NULL,NULL,''),(1403,'Monthly','Monthly',11,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1451,'1','1',13,0,'2010-12-07 06:30:00','system',1,'','system','2010-12-07 06:30:00',NULL,''),(1452,'3','3',13,0,'2010-12-07 06:30:00','system',2,'',NULL,NULL,NULL,''),(1453,'7','7',13,0,'2010-12-07 06:30:00','system',3,'',NULL,NULL,NULL,''),(1454,'15','15',13,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1455,'30','30',13,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1456,'60','60',13,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1457,'90','90',13,0,'2010-12-07 06:30:00','system',4,'',NULL,NULL,NULL,''),(1461,'america','america',1,0,'2011-01-21 13:50:00','system',1,'\0',NULL,NULL,NULL,''),(1462,'nj','nj',2,0,'2011-01-21 13:50:36','system',1,'\0',NULL,NULL,1461,''),(1463,'india','india',1,2,'2011-01-23 07:14:10','system',1,'\0','sue treen','2011-03-22 08:39:21',NULL,''),(1464,'karnataka','Karnataka',2,1,'2011-01-23 07:15:27','system',1,'\0',NULL,NULL,NULL,''),(1465,'Sri Lanka','Sri Lanka',1,0,'2011-02-06 06:59:36','system',1,'\0',NULL,NULL,NULL,''),(1466,'Colombo','Colombo',2,0,'2011-02-06 07:13:25','system',1,'\0',NULL,NULL,1465,''),(1467,'Junior Accountant','Junior Accountant',17,0,'2011-02-14 05:57:22','system',1,'\0',NULL,NULL,NULL,''),(1468,'Managing Partner','Managing Partner',17,0,'2011-02-14 05:58:19','system',3,'',NULL,NULL,NULL,''),(1469,'None','None',11,0,'2011-03-09 14:08:24','system',5,'',NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `code` ENABLE KEYS */;
UNLOCK TABLES;

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
  `version` int(11) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk64ae464c75ca944a` (`parent_code_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_type`
--

LOCK TABLES `code_type` WRITE;
/*!40000 ALTER TABLE `code_type` DISABLE KEYS */;
INSERT INTO `code_type` VALUES (1,'country','country code type','\0','2010-03-25 00:00:00','system',NULL,0,NULL,NULL,''),(2,'state','state codes','\0','2010-03-25 00:00:00','system',1,0,NULL,NULL,''),(3,'Form of Business','Form of Business','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(4,'Industry Type','Industry Type','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(5,'job_title','Job Title','','2010-03-25 00:00:00','system',NULL,0,NULL,NULL,''),(6,'department','Department','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(7,'account category','Account Category','','2010-03-25 00:00:00','gudi',NULL,0,NULL,NULL,''),(8,'account type','account type','','2010-03-25 00:00:00','gudi',7,0,NULL,NULL,''),(9,'share type','share type','','2010-03-25 00:00:00','system',NULL,2,'admin@firm.com','2011-03-28 09:41:43',''),(10,'Filing Frequency','Filing Frequency','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(11,'Installment Frequency','Installment Frequency','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(12,'Filing Reminder Days','Filing Reminder Days','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(13,'Installment Reminder Days','Installment Reminder Days','','2010-12-07 00:00:00','gudi',NULL,0,NULL,NULL,''),(15,'District','District','','2011-01-23 12:43:03','system',2,2,'sue treen','2011-03-22 08:27:26',''),(17,'firm_staff_title_code','Title used by Firm staff','\0','2011-02-11 16:50:51','system',NULL,0,NULL,NULL,'');
/*!40000 ALTER TABLE `code_type` ENABLE KEYS */;
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
  `sub_type` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comm_is_for_contact_point` (`contact_point_id`),
  KEY `fk_comm_has_comm_type` (`communication_type`),
  CONSTRAINT `fk_comm_has_comm_type` FOREIGN KEY (`communication_type`) REFERENCES `communication_type` (`id`),
  CONSTRAINT `fk_comm_is_for_contact_point` FOREIGN KEY (`contact_point_id`) REFERENCES `point_of_contact` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communication`
--

LOCK TABLES `communication` WRITE;
/*!40000 ALTER TABLE `communication` DISABLE KEYS */;
INSERT INTO `communication` VALUES (1,'24342',4,3,NULL,NULL,'2011-02-16 10:43:12','system','system','2011-02-16 10:43:25',0,'',NULL),(2,'sagar@yahhooo.com',4,1,NULL,NULL,'2011-02-16 10:43:21','system','system','2011-02-16 10:43:25',0,'',NULL),(3,'24',4,2,NULL,NULL,'2011-02-16 10:43:21','system','system','2011-02-16 10:43:25',0,'',NULL),(4,'www.sagar.com',4,7,NULL,NULL,'2011-02-16 10:43:21','system','system','2011-02-16 10:43:25',0,'',NULL),(5,'24342',5,3,NULL,NULL,'2011-02-16 10:51:00','system','system','2011-02-16 10:51:17',0,'',NULL),(6,'sagar@yahhooo.com',5,1,NULL,NULL,'2011-02-16 10:51:13','system','system','2011-02-16 10:51:17',0,'',NULL),(7,'24',5,2,NULL,NULL,'2011-02-16 10:51:13','system','system','2011-02-16 10:51:17',0,'',NULL),(8,'www.sagar.com',5,7,NULL,NULL,'2011-02-16 10:51:13','system','system','2011-02-16 10:51:17',0,'',NULL),(9,'24342',6,3,NULL,NULL,'2011-02-16 12:03:18','system','system','2011-02-16 12:03:22',0,'',NULL),(10,'sagar@yahhooo.com',6,1,NULL,NULL,'2011-02-16 12:03:22','system','system','2011-02-16 12:03:22',0,'',NULL),(11,'24',6,2,NULL,NULL,'2011-02-16 12:03:22','system','system','2011-02-16 12:03:22',0,'',NULL),(12,'www.sagar.com',6,7,NULL,NULL,'2011-02-16 12:03:22','system','system','2011-02-16 12:03:22',0,'',NULL),(13,'24342',7,3,NULL,NULL,'2011-02-16 12:05:19','system','system','2011-02-16 12:05:23',0,'',NULL),(14,'sagar@yahhooo.com',7,1,NULL,NULL,'2011-02-16 12:05:23','system','system','2011-02-16 12:05:23',0,'',NULL),(15,'24',7,2,NULL,NULL,'2011-02-16 12:05:23','system','system','2011-02-16 12:05:23',0,'',NULL),(16,'www.sagar.com',7,7,NULL,NULL,'2011-02-16 12:05:23','system','system','2011-02-16 12:05:23',0,'',NULL),(17,'24342',8,4,NULL,NULL,'2011-02-16 12:06:07','system','system','2011-02-16 12:06:10',0,'',NULL),(18,'sagar@yahhooo.com',8,1,NULL,NULL,'2011-02-16 12:06:10','system','system','2011-02-16 12:06:10',0,'',NULL),(19,'24',8,2,NULL,NULL,'2011-02-16 12:06:10','system','system','2011-02-16 12:06:10',0,'',NULL),(20,'www.sagar.com',8,7,NULL,NULL,'2011-02-16 12:06:10','system','system','2011-02-16 12:06:10',0,'',NULL),(21,'24342',9,3,NULL,NULL,'2011-02-16 12:11:06','system','system','2011-02-16 12:11:27',0,'',NULL),(22,'sagar@yahhooo.com',9,1,NULL,NULL,'2011-02-16 12:11:27','system','system','2011-02-16 12:11:27',0,'',NULL),(23,'24',9,2,NULL,NULL,'2011-02-16 12:11:27','system','system','2011-02-16 12:11:27',0,'',NULL),(24,'www.sagar.com',9,7,NULL,NULL,'2011-02-16 12:11:27','system','system','2011-02-16 12:11:27',0,'',NULL),(25,'sagar@gmail.com',10,1,NULL,NULL,'2011-02-16 13:27:17','system','system','2011-02-16 13:27:22',0,'',NULL),(26,'342',10,2,NULL,NULL,'2011-02-16 13:27:17','system','system','2011-02-16 13:27:22',0,'',NULL),(27,'www.adas.com',10,7,NULL,NULL,'2011-02-16 13:27:17','system','system','2011-02-16 13:27:22',0,'',NULL),(28,'2344',10,3,NULL,NULL,'2011-02-16 13:27:17','system','system','2011-02-16 13:27:22',0,'',NULL),(29,'24342',11,3,NULL,NULL,'2011-02-16 14:00:25','system','system','2011-02-16 14:00:33',0,'',NULL),(30,'anada@gmai.com',11,1,NULL,NULL,'2011-02-16 14:00:33','system','system','2011-02-16 14:00:33',0,'',NULL),(31,'34445',11,2,NULL,NULL,'2011-02-16 14:00:33','system','system','2011-02-16 14:00:33',0,'',NULL),(32,'www.sagar.com',11,7,NULL,NULL,'2011-02-16 14:00:33','system','system','2011-02-16 14:00:33',0,'',NULL),(33,'ramesh@gmai.ccom',12,1,NULL,NULL,'2011-02-16 14:04:30','system','system','2011-02-17 08:11:20',3,'',NULL),(34,'342',12,2,NULL,NULL,'2011-02-16 14:04:30','system','system','2011-02-17 08:11:20',3,'',NULL),(35,'www.adas.com',12,7,NULL,NULL,'2011-02-16 14:04:30','system','system','2011-02-17 08:11:20',3,'',NULL),(36,'9916819682',12,3,NULL,NULL,'2011-02-16 14:04:30','system','system','2011-02-17 08:11:20',3,'',NULL),(37,'james@yahoo.com',13,1,NULL,NULL,'2011-02-16 14:06:49','system','system','2011-02-16 14:06:55',0,'',NULL),(38,'656556',13,2,NULL,NULL,'2011-02-16 14:06:49','system','system','2011-02-16 14:06:55',0,'',NULL),(39,'www.james.com',13,7,NULL,NULL,'2011-02-16 14:06:49','system','system','2011-02-16 14:06:55',0,'',NULL),(40,'99889988998',13,3,NULL,NULL,'2011-02-16 14:06:49','system','system','2011-02-16 14:06:55',0,'',NULL),(41,'richard@gmail.com',14,1,NULL,NULL,'2011-02-16 14:09:09','system','system','2011-02-16 14:09:15',0,'',NULL),(42,'6666',14,2,NULL,NULL,'2011-02-16 14:09:09','system','system','2011-02-16 14:09:15',0,'',NULL),(43,'www.richand.com',14,7,NULL,NULL,'2011-02-16 14:09:09','system','system','2011-02-16 14:09:15',0,'',NULL),(44,'99889988998',14,3,NULL,NULL,'2011-02-16 14:09:09','system','system','2011-02-16 14:09:15',0,'',NULL),(45,'karthik@gmail.com',15,1,NULL,NULL,'2011-02-16 14:10:53','system','system','2011-02-16 14:11:00',0,'',NULL),(46,'445445445',15,2,NULL,NULL,'2011-02-16 14:10:53','system','system','2011-02-16 14:11:00',0,'',NULL),(47,'www.karthik.com',15,7,NULL,NULL,'2011-02-16 14:10:53','system','system','2011-02-16 14:11:00',0,'',NULL),(48,'99889988998',15,3,NULL,NULL,'2011-02-16 14:10:53','system','system','2011-02-16 14:11:00',0,'',NULL),(49,'234',16,3,NULL,NULL,'2011-02-17 07:08:11','system','system','2011-02-17 08:11:42',4,'',NULL),(50,'vinod@gmail.com',16,1,NULL,NULL,'2011-02-17 07:08:14','system','system','2011-02-17 08:11:42',4,'',NULL),(51,'234343',16,2,NULL,NULL,'2011-02-17 07:08:14','system','system','2011-02-17 08:11:42',4,'',NULL),(52,'www.test.com',16,7,NULL,NULL,'2011-02-17 07:08:14','system','system','2011-02-17 08:11:42',4,'',NULL),(53,'24342',17,3,NULL,NULL,'2011-02-17 07:18:04','system','system','2011-02-17 07:18:31',0,'',NULL),(54,'sagar@yahhooo.com',17,1,NULL,NULL,'2011-02-17 07:18:07','system','system','2011-02-17 07:18:31',0,'',NULL),(55,'24',17,2,NULL,NULL,'2011-02-17 07:18:07','system','system','2011-02-17 07:18:31',0,'',NULL),(56,'www.sagar.com',17,7,NULL,NULL,'2011-02-17 07:18:07','system','system','2011-02-17 07:18:31',0,'',NULL),(57,'234',18,3,NULL,NULL,'2011-02-17 07:23:16','system','system','2011-02-17 07:23:47',0,'',NULL),(58,'sagar@yahhooo.com',18,1,NULL,NULL,'2011-02-17 07:23:19','system','system','2011-02-17 07:23:47',0,'',NULL),(59,'24',18,2,NULL,NULL,'2011-02-17 07:23:19','system','system','2011-02-17 07:23:47',0,'',NULL),(60,'www.sagar.com',18,7,NULL,NULL,'2011-02-17 07:23:19','system','system','2011-02-17 07:23:47',0,'',NULL),(61,'',19,3,NULL,NULL,'2011-02-17 08:13:10','system','system','2011-02-17 08:13:13',0,'',NULL),(62,'sagar@yahhooo.com',19,1,NULL,NULL,'2011-02-17 08:13:13','system','system','2011-02-17 08:13:13',0,'',NULL),(63,'',19,2,NULL,NULL,'2011-02-17 08:13:13','system','system','2011-02-17 08:13:13',0,'',NULL),(64,'',19,7,NULL,NULL,'2011-02-17 08:13:13','system','system','2011-02-17 08:13:13',0,'',NULL),(65,'',20,3,NULL,NULL,'2011-02-17 08:14:17','system','system','2011-02-17 08:14:21',0,'',NULL),(66,'',20,1,NULL,NULL,'2011-02-17 08:14:21','system','system','2011-02-17 08:14:21',0,'',NULL),(67,'',20,2,NULL,NULL,'2011-02-17 08:14:21','system','system','2011-02-17 08:14:21',0,'',NULL),(68,'',20,7,NULL,NULL,'2011-02-17 08:14:21','system','system','2011-02-17 08:14:21',0,'',NULL),(69,'',21,3,NULL,NULL,'2011-02-17 08:15:09','system','system','2011-02-17 08:15:45',1,'',NULL),(70,'',21,1,NULL,NULL,'2011-02-17 08:15:12','system','system','2011-02-17 08:15:45',1,'',NULL),(71,'',21,2,NULL,NULL,'2011-02-17 08:15:12','system','system','2011-02-17 08:15:45',1,'',NULL),(72,'',21,7,NULL,NULL,'2011-02-17 08:15:12','system','system','2011-02-17 08:15:45',1,'',NULL),(73,'24342',22,3,NULL,NULL,'2011-02-17 15:16:28','system','system','2011-02-17 15:16:32',0,'',NULL),(74,'sagar@yahhooo.com',22,1,NULL,NULL,'2011-02-17 15:16:32','system','system','2011-02-17 15:16:32',0,'',NULL),(75,'',22,2,NULL,NULL,'2011-02-17 15:16:32','system','system','2011-02-17 15:16:32',0,'',NULL),(76,'99889988998',22,7,NULL,NULL,'2011-02-17 15:16:32','system','system','2011-02-17 15:16:32',0,'',NULL),(77,'24342',23,3,NULL,NULL,'2011-02-18 05:51:41','system','system','2011-02-18 05:51:44',0,'',NULL),(78,'sagar@yahhooo.com',23,1,NULL,NULL,'2011-02-18 05:51:44','system','system','2011-02-18 05:51:44',0,'',NULL),(79,'24',23,2,NULL,NULL,'2011-02-18 05:51:44','system','system','2011-02-18 05:51:44',0,'',NULL),(80,'www.sagar.com',23,7,NULL,NULL,'2011-02-18 05:51:44','system','system','2011-02-18 05:51:44',0,'',NULL),(81,'24342',24,3,NULL,NULL,'2011-02-18 06:04:31','system','system','2011-02-18 06:04:35',0,'',NULL),(82,'sagar@yahhooo.com',24,1,NULL,NULL,'2011-02-18 06:04:35','system','system','2011-02-18 06:04:35',0,'',NULL),(83,'34445',24,2,NULL,NULL,'2011-02-18 06:04:35','system','system','2011-02-18 06:04:35',0,'',NULL),(84,'www.sagar.com',24,7,NULL,NULL,'2011-02-18 06:04:35','system','system','2011-02-18 06:04:35',0,'',NULL),(85,'24342',25,3,NULL,NULL,'2011-02-21 08:21:08','system','system','2011-02-21 08:21:13',0,'',NULL),(86,'sagar@yahhooo.com',25,1,NULL,NULL,'2011-02-21 08:21:13','system','system','2011-02-21 08:21:13',0,'',NULL),(87,'24',25,2,NULL,NULL,'2011-02-21 08:21:13','system','system','2011-02-21 08:21:13',0,'',NULL),(88,'www.sagar.com',25,7,NULL,NULL,'2011-02-21 08:21:13','system','system','2011-02-21 08:21:13',0,'',NULL),(89,'harsh@gmail.com',26,1,NULL,NULL,'2011-02-27 06:25:16','system','admin@firm.com','2011-03-28 09:05:39',7,'',NULL),(90,'222-222-2222',26,2,NULL,NULL,'2011-02-27 06:25:16','system','admin@firm.com','2011-03-28 09:06:00',7,'',NULL),(91,'222-222-2222',26,3,NULL,NULL,'2011-02-27 06:25:16','system','admin@firm.com','2011-03-28 09:05:10',7,'',3),(93,'www.iAutomobile.com',26,7,NULL,NULL,'2011-02-27 06:25:16','system','admin@firm.com','2011-03-28 09:05:50',7,'',NULL),(94,'harsh@gmail.com',27,1,NULL,NULL,'2011-02-27 06:44:22','system','system','2011-02-27 06:44:22',0,'',NULL),(95,'2222',27,2,NULL,NULL,'2011-02-27 06:44:22','system','system','2011-02-27 06:44:22',0,'',NULL),(96,'2222',27,3,NULL,NULL,'2011-02-27 06:44:22','system','system','2011-02-27 06:44:22',0,'',-1),(97,'2222',27,3,NULL,NULL,'2011-02-27 06:44:22','system','system','2011-02-27 06:44:22',0,'',-1),(98,'www.iAutomobile.com',27,7,NULL,NULL,'2011-02-27 06:44:22','system','system','2011-02-27 06:44:22',0,'',NULL),(99,'harsh@gmail.com',28,1,NULL,NULL,'2011-02-27 06:44:41','system','system','2011-02-27 06:44:41',0,'',NULL),(100,'2222',28,2,NULL,NULL,'2011-02-27 06:44:41','system','system','2011-02-27 06:44:41',0,'',NULL),(101,'2222',28,3,NULL,NULL,'2011-02-27 06:44:41','system','system','2011-02-27 06:44:41',0,'',3),(102,'2222',28,3,NULL,NULL,'2011-02-27 06:44:41','system','system','2011-02-27 06:44:41',0,'',4),(103,'www.iAutomobile.com',28,7,NULL,NULL,'2011-02-27 06:44:41','system','system','2011-02-27 06:44:41',0,'',NULL),(104,'222-222-2222',26,3,NULL,NULL,'2011-02-28 05:38:27','system','admin@firm.com','2011-03-28 09:05:27',5,'',4),(105,'harsh@gmail.com',29,1,NULL,NULL,'2011-02-28 05:39:24','system','system','2011-02-28 06:52:22',2,'',NULL),(106,'1111',29,2,NULL,NULL,'2011-02-28 05:39:24','system','system','2011-02-28 06:52:22',2,'',NULL),(107,'1111',29,3,NULL,NULL,'2011-02-28 05:39:24','system','system','2011-02-28 06:52:22',2,'',3),(108,'1111',29,3,NULL,NULL,'2011-02-28 05:39:24','system','system','2011-02-28 06:52:22',2,'',5),(109,'www.iAutomobile.com',29,7,NULL,NULL,'2011-02-28 05:39:24','system','system','2011-02-28 06:52:22',2,'',NULL),(110,'harsh@gmail.com',30,1,NULL,NULL,'2011-02-28 05:40:48','system','system','2011-02-28 05:41:12',1,'',NULL),(111,'1111',30,2,NULL,NULL,'2011-02-28 05:40:48','system','system','2011-02-28 05:41:12',1,'',NULL),(112,'1111',30,3,NULL,NULL,'2011-02-28 05:40:48','system','system','2011-02-28 05:41:12',1,'',3),(113,'1111',30,3,NULL,NULL,'2011-02-28 05:40:48','system','system','2011-02-28 05:41:12',1,'',4),(114,'www.iAutomobile.com',30,7,NULL,NULL,'2011-02-28 05:40:48','system','system','2011-02-28 05:41:12',1,'',NULL),(115,'tanveer@gamil.om',32,1,NULL,NULL,'2011-02-28 10:39:28','system','admin@firm.com','2011-03-26 06:49:02',7,'',NULL),(116,'222-222-2222',32,2,NULL,NULL,'2011-02-28 10:39:28','system','admin@firm.com','2011-03-26 06:49:02',7,'',NULL),(117,'222-222-2222',32,3,NULL,NULL,'2011-02-28 10:39:28','system','admin@firm.com','2011-03-26 06:49:02',7,'',3),(118,'www.default.com',32,7,NULL,NULL,'2011-02-28 10:39:28','system','admin@firm.com','2011-03-26 06:49:02',7,'',NULL),(120,'accenture@gmail.com',33,1,NULL,NULL,'2011-02-28 13:32:22','system','system','2011-03-05 11:44:32',5,'',NULL),(121,'123-456-7890',33,2,NULL,NULL,'2011-02-28 13:32:22','system','system','2011-03-05 11:44:32',5,'',NULL),(122,'123-456-7890',33,3,NULL,NULL,'2011-02-28 13:32:22','system','system','2011-03-05 11:44:32',5,'',3),(123,'www.default.com',33,7,NULL,NULL,'2011-02-28 13:32:22','system','system','2011-03-05 11:44:32',5,'',NULL),(125,'123-456-7890',33,3,NULL,NULL,'2011-02-28 13:37:59','system','system','2011-03-05 11:44:32',2,'',4),(126,'flapina@gmail.com',34,1,NULL,NULL,'2011-02-28 13:41:55','system','system','2011-02-28 13:44:46',1,'',NULL),(127,'4444',34,2,NULL,NULL,'2011-02-28 13:41:55','system','system','2011-02-28 13:44:46',1,'',NULL),(128,'4444',34,3,NULL,NULL,'2011-02-28 13:41:56','system','system','2011-02-28 13:44:46',1,'',3),(129,'www.default.com',34,7,NULL,NULL,'2011-02-28 13:41:55','system','system','2011-02-28 13:44:46',1,'',NULL),(130,'preety@gmail.com',35,1,NULL,NULL,'2011-02-28 13:46:50','system','system','2011-02-28 13:47:22',0,'',NULL),(131,'2222',35,2,NULL,NULL,'2011-02-28 13:46:50','system','system','2011-02-28 13:47:22',0,'',NULL),(132,'2222',35,3,NULL,NULL,'2011-02-28 13:46:51','system','system','2011-02-28 13:47:22',0,'',-1),(133,'www.default.com',35,7,NULL,NULL,'2011-02-28 13:46:50','system','system','2011-02-28 13:47:22',0,'',NULL),(134,'preety@gmail.com',36,1,NULL,NULL,'2011-02-28 13:49:10','system','system','2011-02-28 14:04:53',1,'',NULL),(135,'2222',36,2,NULL,NULL,'2011-02-28 13:49:10','system','system','2011-02-28 14:04:53',1,'',NULL),(136,'2222',36,3,NULL,NULL,'2011-02-28 13:49:10','system','system','2011-02-28 14:04:53',1,'',3),(137,'www.default.com',36,7,NULL,NULL,'2011-02-28 13:49:10','system','system','2011-02-28 14:04:53',1,'',NULL),(138,'preety@gmail.com',37,1,NULL,NULL,'2011-02-28 13:51:10','system','system','2011-02-28 14:01:13',2,'',NULL),(139,'2222',37,2,NULL,NULL,'2011-02-28 13:51:10','system','system','2011-02-28 14:01:13',2,'',NULL),(140,'2222',37,3,NULL,NULL,'2011-02-28 13:51:10','system','system','2011-02-28 14:01:13',2,'',3),(141,'www.default.com',37,7,NULL,NULL,'2011-02-28 13:51:10','system','system','2011-02-28 14:01:13',2,'',NULL),(142,'druva@yahoo.com',38,1,NULL,NULL,'2011-02-28 14:02:40','system','system','2011-02-28 14:02:44',0,'',NULL),(143,'2222',38,2,NULL,NULL,'2011-02-28 14:02:40','system','system','2011-02-28 14:02:44',0,'',NULL),(144,'2222',38,3,NULL,NULL,'2011-02-28 14:02:41','system','system','2011-02-28 14:02:44',0,'',3),(145,'www.default.com',38,7,NULL,NULL,'2011-02-28 14:02:40','system','system','2011-02-28 14:02:44',0,'',NULL),(146,'2222',36,3,NULL,NULL,'2011-02-28 14:04:52','system','system','2011-02-28 14:04:53',0,'',4),(147,'harsh@gmail.com',39,1,NULL,NULL,'2011-03-01 05:22:36','system','system','2011-03-01 05:27:36',2,'',NULL),(148,'2222',39,2,NULL,NULL,'2011-03-01 05:22:36','system','system','2011-03-01 05:27:36',2,'',NULL),(149,'2222',39,3,NULL,NULL,'2011-03-01 05:22:36','system','system','2011-03-01 05:27:36',2,'',3),(150,'www.Circuit.com',39,7,NULL,NULL,'2011-03-01 05:22:36','system','system','2011-03-01 05:27:36',2,'',NULL),(151,'harsh@gmail.com',40,1,NULL,NULL,'2011-03-01 05:34:59','system','system','2011-03-01 05:59:28',3,'',NULL),(152,'2222',40,2,NULL,NULL,'2011-03-01 05:34:59','system','system','2011-03-01 05:59:28',3,'',NULL),(153,'2222',40,3,NULL,NULL,'2011-03-01 05:35:00','system','system','2011-03-01 05:59:28',3,'',4),(154,'www.kendule.com',40,7,NULL,NULL,'2011-03-01 05:34:59','system','system','2011-03-01 05:59:28',3,'',NULL),(155,'2222',40,3,NULL,NULL,'2011-03-01 05:59:28','system','system','2011-03-01 05:59:28',0,'',3),(156,'harsh@gmail.com',41,1,NULL,NULL,'2011-03-01 06:07:21','system','system','2011-03-01 06:07:22',0,'',NULL),(157,'2222',41,2,NULL,NULL,'2011-03-01 06:07:21','system','system','2011-03-01 06:07:22',0,'',NULL),(158,'2222',41,3,NULL,NULL,'2011-03-01 06:07:22','system','system','2011-03-01 06:07:22',0,'',3),(159,'2222',41,3,NULL,NULL,'2011-03-01 06:07:22','system','system','2011-03-01 06:07:22',0,'',4),(160,'www.Circuit.com',41,7,NULL,NULL,'2011-03-01 06:07:21','system','system','2011-03-01 06:07:22',0,'',NULL),(161,'harsh@gmail.com',42,1,NULL,NULL,'2011-03-01 06:45:00','system','system','2011-03-01 07:02:29',2,'',NULL),(162,'2222',42,2,NULL,NULL,'2011-03-01 06:45:00','system','system','2011-03-01 07:02:29',2,'',NULL),(165,'www.kendule.com',42,7,NULL,NULL,'2011-03-01 06:45:00','system','system','2011-03-01 07:02:29',2,'',NULL),(166,'2222',42,3,NULL,NULL,'2011-03-01 07:02:29','system','system','2011-03-01 07:02:29',0,'',3),(167,'2222',42,3,NULL,NULL,'2011-03-01 07:02:29','system','system','2011-03-01 07:02:29',0,'',4),(168,'tanveer@gamil.om',43,1,NULL,NULL,'2011-03-01 07:12:20','system','system','2011-03-01 07:19:50',2,'',NULL),(169,'2222',43,2,NULL,NULL,'2011-03-01 07:12:20','system','system','2011-03-01 07:19:50',2,'',NULL),(170,'2222',43,3,NULL,NULL,'2011-03-01 07:12:20','system','system','2011-03-01 07:19:50',2,'',4),(172,'www.default.com',43,7,NULL,NULL,'2011-03-01 07:12:20','system','system','2011-03-01 07:19:50',2,'',NULL),(173,'tanveer@gamil.om',45,1,NULL,NULL,'2011-03-01 07:39:41','system','system','2011-03-01 07:45:18',1,'',NULL),(174,'2222',45,2,NULL,NULL,'2011-03-01 07:39:41','system','system','2011-03-01 07:45:18',1,'',NULL),(175,'2222',45,3,NULL,NULL,'2011-03-01 07:39:41','system','system','2011-03-01 07:39:43',0,'',3),(176,'2222',45,3,NULL,NULL,'2011-03-01 07:39:41','system','system','2011-03-01 07:39:43',0,'',4),(177,'www.default.com',45,7,NULL,NULL,'2011-03-01 07:39:41','system','system','2011-03-01 07:45:18',1,'',NULL),(178,'harsh@gmail.com',47,1,NULL,NULL,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',0,'',NULL),(179,'2222',47,2,NULL,NULL,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',0,'',NULL),(180,'2222',47,3,NULL,NULL,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',0,'',3),(181,'2222',47,3,NULL,NULL,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',0,'',4),(182,'www.iAutomobile.com',47,7,NULL,NULL,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',0,'',NULL),(183,'harsh@gmail.com',48,1,NULL,NULL,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',0,'',NULL),(184,'2222',48,2,NULL,NULL,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',0,'',NULL),(185,'2222',48,3,NULL,NULL,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',0,'',3),(186,'2222',48,3,NULL,NULL,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',0,'',4),(187,'wwwrk.com',48,7,NULL,NULL,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',0,'',NULL),(188,'harsh@gmail.com',49,1,NULL,NULL,'2011-03-01 08:22:08','system','system','2011-03-01 08:22:08',0,'',NULL),(189,'2222',49,2,NULL,NULL,'2011-03-01 08:22:08','system','system','2011-03-01 08:22:08',0,'',NULL),(190,'2222',49,3,NULL,NULL,'2011-03-01 08:22:08','system','system','2011-03-01 08:22:08',0,'',3),(191,'www.Circuit.com',49,7,NULL,NULL,'2011-03-01 08:22:08','system','system','2011-03-01 08:22:08',0,'',NULL),(192,'222-222-2222',32,3,NULL,NULL,'2011-03-01 08:42:10','system','admin@firm.com','2011-03-26 06:49:02',4,'',5),(193,'xchanging@gmail.com',54,1,NULL,NULL,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',1,'',NULL),(194,'222-222-2222',54,2,NULL,NULL,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',1,'',NULL),(195,'222-222-2222',54,3,NULL,NULL,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',1,'',3),(196,'222-222-2222',54,3,NULL,NULL,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',1,'',4),(197,'www.default.com',54,7,NULL,NULL,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',1,'',NULL),(198,'tanveer@gamil.om',55,1,NULL,NULL,'2011-03-02 10:45:37','system','system','2011-03-24 05:49:52',5,'',NULL),(199,'222-222-2222',55,2,NULL,NULL,'2011-03-02 10:45:37','system','system','2011-03-24 05:49:52',5,'',NULL),(200,'222-222-2222',55,3,NULL,NULL,'2011-03-02 10:45:37','system','system','2011-03-24 05:49:52',4,'',3),(201,'www.default.com',55,7,NULL,NULL,'2011-03-02 10:45:37','system','system','2011-03-24 05:49:52',5,'',NULL),(202,'vinay@gmail.com',57,1,NULL,NULL,'2011-03-03 12:24:40','system','system','2011-03-03 12:24:41',0,'',NULL),(203,'234',57,2,NULL,NULL,'2011-03-03 12:24:40','system','system','2011-03-03 12:24:41',0,'',NULL),(204,'9987867',57,3,NULL,NULL,'2011-03-03 12:24:41','system','system','2011-03-03 12:24:41',0,'',3),(205,'www.saiorg.com',57,7,NULL,NULL,'2011-03-03 12:24:40','system','system','2011-03-03 12:24:41',0,'',NULL),(206,'ramkumar@gmail.com',58,1,NULL,NULL,'2011-03-03 12:26:06','system','system','2011-03-03 12:26:07',0,'',NULL),(207,'543634',58,2,NULL,NULL,'2011-03-03 12:26:06','system','system','2011-03-03 12:26:07',0,'',NULL),(208,'9987867',58,3,NULL,NULL,'2011-03-03 12:26:07','system','system','2011-03-03 12:26:07',0,'',4),(209,'www.saiorgdevlopment.com',58,7,NULL,NULL,'2011-03-03 12:26:06','system','system','2011-03-03 12:26:07',0,'',NULL),(210,'guru@guru.com',59,1,NULL,NULL,'2011-03-05 11:34:32','system','system','2011-03-05 11:46:08',2,'',NULL),(211,'222-222-1111',59,2,NULL,NULL,'2011-03-05 11:34:32','system','system','2011-03-05 11:46:08',2,'',NULL),(212,'222-222-2222',59,3,NULL,NULL,'2011-03-05 11:34:32','system','system','2011-03-05 11:46:08',2,'',3),(213,'www.default.com',59,7,NULL,NULL,'2011-03-05 11:34:32','system','system','2011-03-05 11:46:08',2,'',NULL),(214,'jlc@gmail.com',60,1,NULL,NULL,'2011-03-05 11:53:57','system','system','2011-03-15 14:26:37',2,'',NULL),(215,'222-222-1111',60,2,NULL,NULL,'2011-03-05 11:53:57','system','system','2011-03-15 14:26:37',2,'',NULL),(216,'222-222-2222',60,3,NULL,NULL,'2011-03-05 11:53:57','system','system','2011-03-15 14:26:37',2,'',4),(217,'www.default.com',60,7,NULL,NULL,'2011-03-05 11:53:57','system','system','2011-03-15 14:26:37',2,'',NULL),(218,'preety@gmail.com',62,1,NULL,NULL,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',9,'',NULL),(219,'222-222-1111',62,2,NULL,NULL,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',9,'',NULL),(220,'222-222-2222',62,3,NULL,NULL,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',9,'',3),(221,'123-456-7890',62,3,NULL,NULL,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',9,'',4),(222,'www.default.com',62,7,NULL,NULL,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',9,'',NULL),(223,'tanveer@gamil.om',63,1,NULL,NULL,'2011-03-15 13:39:11','system','system','2011-03-16 07:14:58',2,'',NULL),(224,'222-222-1111',63,2,NULL,NULL,'2011-03-15 13:39:11','system','system','2011-03-16 07:14:58',2,'',NULL),(225,'222-222-2222',63,3,NULL,NULL,'2011-03-15 13:39:11','system','system','2011-03-15 13:39:40',1,'',3),(226,'123-456-7890',63,3,NULL,NULL,'2011-03-15 13:39:11','system','system','2011-03-15 13:39:40',1,'',4),(228,'www.default.com',63,7,NULL,NULL,'2011-03-15 13:39:11','system','system','2011-03-16 07:14:58',2,'',NULL),(229,'harsh@gmail.com',64,1,NULL,NULL,'2011-03-15 13:41:47','system','system','2011-03-15 13:42:53',1,'',NULL),(230,'222-222-2222',64,2,NULL,NULL,'2011-03-15 13:41:47','system','system','2011-03-15 13:42:53',1,'',NULL),(231,'222-222-2222',64,3,NULL,NULL,'2011-03-15 13:41:47','system','system','2011-03-15 13:42:53',1,'',3),(234,'www.saiAutomobile.com',64,7,NULL,NULL,'2011-03-15 13:41:47','system','system','2011-03-15 13:42:53',1,'',NULL),(235,'ramkumar@gmail.com',65,1,NULL,NULL,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',10,'',NULL),(236,'222-222-2222',65,2,NULL,NULL,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',10,'',NULL),(237,'222-222-2222',65,3,NULL,NULL,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',10,'',3),(238,'111-111-1111',65,3,NULL,NULL,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',10,'',4),(239,'www.saiAutomobile.com',65,7,NULL,NULL,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',10,'',NULL),(240,'harsh@gmail.com',66,1,NULL,NULL,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',0,'',NULL),(241,'222-222-2222',66,2,NULL,NULL,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',0,'',NULL),(242,'222-222-2222',66,3,NULL,NULL,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',0,'',3),(243,'111-111-1111',66,3,NULL,NULL,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',0,'',4),(244,'www.saiAutomobile.com',66,7,NULL,NULL,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',0,'',NULL),(245,'harsh@gmail.com',67,1,NULL,NULL,'2011-03-15 14:17:25','system','system','2011-03-15 14:17:26',0,'',NULL),(246,'222-222-2222',67,2,NULL,NULL,'2011-03-15 14:17:25','system','system','2011-03-15 14:17:26',0,'',NULL),(247,'222-222-2222',67,3,NULL,NULL,'2011-03-15 14:17:26','system','system','2011-03-15 14:17:26',0,'',3),(248,'111-111-1111',67,3,NULL,NULL,'2011-03-15 14:17:26','system','system','2011-03-15 14:17:26',0,'',4),(249,'www.iAutomobile.com',67,7,NULL,NULL,'2011-03-15 14:17:25','system','system','2011-03-15 14:17:26',0,'',NULL),(250,'123-456-7890',60,3,NULL,NULL,'2011-03-15 14:26:37','system','system','2011-03-15 14:26:37',0,'',3),(251,'karthikkarthik@gmail.com',68,1,NULL,NULL,'2011-03-15 14:28:36','system','system','2011-03-22 05:51:28',1,'',NULL),(252,'222-222-1111',68,2,NULL,NULL,'2011-03-15 14:28:36','system','system','2011-03-22 05:51:28',1,'',NULL),(253,'222-222-2222',68,3,NULL,NULL,'2011-03-15 14:28:36','system','system','2011-03-22 05:51:28',1,'',3),(254,'www.default.com',68,7,NULL,NULL,'2011-03-15 14:28:36','system','system','2011-03-22 05:51:28',1,'',NULL),(255,'neema@gmial.com',69,1,NULL,NULL,'2011-03-22 04:06:39','system','admin@firm.com','2011-03-26 11:03:35',9,'',NULL),(256,'222-222-1111',69,2,NULL,NULL,'2011-03-22 04:06:39','system','admin@firm.com','2011-03-26 11:03:36',9,'',NULL),(257,'222-222-2222',69,3,NULL,NULL,'2011-03-22 04:06:39','system','admin@firm.com','2011-03-26 11:03:35',9,'',3),(258,'www.default.com',69,7,NULL,NULL,'2011-03-22 04:06:39','system','admin@firm.com','2011-03-26 11:03:36',9,'',NULL),(259,'123-456-7890',55,3,NULL,NULL,'2011-03-24 05:49:51','Sagar','system','2011-03-24 05:49:52',1,'',4),(260,'sachin@gmail.com',73,1,NULL,NULL,'2011-03-26 07:12:31','karthik@jlc.com','karthik@jlc.com','2011-03-26 07:12:51',2,'',NULL),(261,'222-222-1111',73,2,NULL,NULL,'2011-03-26 07:12:31','karthik@jlc.com','karthik@jlc.com','2011-03-26 07:12:52',2,'',NULL),(262,'222-222-2222',73,3,NULL,NULL,'2011-03-26 07:12:31','karthik@jlc.com','karthik@jlc.com','2011-03-26 07:12:52',2,'',3),(263,'www.default.com',73,7,NULL,NULL,'2011-03-26 07:12:31','karthik@jlc.com','karthik@jlc.com','2011-03-26 07:12:53',2,'',NULL),(264,'all_is_well@gmail.com',51,1,NULL,NULL,'2011-03-29 09:21:25','system','admin@firm.com','2011-03-29 09:21:56',2,'',NULL),(265,'222-222-2222',51,2,NULL,NULL,'2011-03-29 09:21:25','system','admin@firm.com','2011-03-29 09:21:56',2,'',NULL),(266,'222-222-2222',51,3,NULL,NULL,'2011-03-29 09:21:26','system','admin@firm.com','2011-03-29 09:21:57',2,'',3),(267,'www.iAutomobile.com',51,7,NULL,NULL,'2011-03-29 09:21:25','system','admin@firm.com','2011-03-29 09:21:57',2,'',NULL);
/*!40000 ALTER TABLE `communication` ENABLE KEYS */;
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
INSERT INTO `communication_type` VALUES (1,'Email','Email Address','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'\0',''),(2,'Fax','Fax','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'\0',''),(3,'Office','Office Phone','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'',''),(4,'Home','Home Phone','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'',''),(5,'Mobile','Mobile Phone','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'',''),(6,'Other','Other Phone','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'',''),(7,'Web Site','Web Site URL -1','2010-07-16 06:04:45','system','system','2010-07-16 06:04:57',0,'\0','');
/*!40000 ALTER TABLE `communication_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jurisdiction`
--

DROP TABLE IF EXISTS `jurisdiction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurisdiction` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(100) DEFAULT NULL,
  `last_update_user_id` varchar(100) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `country_code` bigint(20) unsigned DEFAULT NULL,
  `state_code` bigint(20) unsigned DEFAULT NULL,
  `timezone` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_jurisdiction_is_in_timezone` (`timezone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurisdiction`
--

LOCK TABLES `jurisdiction` WRITE;
/*!40000 ALTER TABLE `jurisdiction` DISABLE KEYS */;
INSERT INTO `jurisdiction` VALUES (1,'usa','va','county','fairfax','',NULL,'system',NULL,NULL,4,NULL,NULL,1),(2,'usa','va','county','falls church','',NULL,NULL,NULL,NULL,1,NULL,NULL,1),(3,'canada','bc','county','vancuar','',NULL,'system',NULL,NULL,1,NULL,NULL,1),(4,'canada','mo','county','toronto','\0',NULL,NULL,NULL,'2011-01-27 12:39:54',12,NULL,NULL,1),(5,'INDIA','asd','county','banglore','','2011-02-02 13:55:28','system','admin@firm.com','2011-04-07 05:44:13',34,NULL,NULL,2),(6,'sdffds sommethifnelse','dsfs','sdfsd','sdfsd','','2011-04-07 05:43:28',NULL,'admin@firm.com','2011-04-07 05:43:55',2,NULL,NULL,5);
/*!40000 ALTER TABLE `jurisdiction` ENABLE KEYS */;
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
  `organization_subtype` tinyint(3) unsigned DEFAULT NULL,
  `last_update_userid` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `in_charge_person` bigint(20) unsigned DEFAULT NULL,
  `year_end_date` date DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fkd063d5334b78cfda` (`party_id`),
  KEY `fk_organization_is_for_type` (`organization_type`),
  KEY `fk_incharge_person_is_a_person` (`in_charge_person`),
  KEY `fk_organization_form_of_business_is_a_code` (`form_of_business`),
  KEY `fk_organization_industry_type` (`industry_type`),
  KEY `fk_organization_industry_subtype_is_code` (`industry_subtype`),
  KEY `fk_organization_subtype_is_type` (`organization_subtype`),
  CONSTRAINT `fk_incharge_person_is_a_person` FOREIGN KEY (`in_charge_person`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_organization_form_of_business_is_a_code` FOREIGN KEY (`form_of_business`) REFERENCES `code` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_subtype_is_code` FOREIGN KEY (`industry_subtype`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_type` FOREIGN KEY (`industry_type`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_is_a_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_organization_is_for_type` FOREIGN KEY (`organization_type`) REFERENCES `organization_type` (`id`),
  CONSTRAINT `fk_organization_subtype_is_type` FOREIGN KEY (`organization_subtype`) REFERENCES `organization_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'delves freer anderson raniga caine','delves freer anderson raniga caine',NULL,500,NULL,NULL,NULL,408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),(9,'bank of america','bank of america corp.',NULL,500,NULL,NULL,NULL,408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),(12,'kendule enterprise','kendule enterprise Inc','kendule enterprise',500,'123456789rc0001','2000-01-01','123456',404,NULL,'unlimited class a voting shares with no par value. 1 million class b common non-voting without par value','100 class a common shares at $10 per share. about 500 class b shares at $1 per share',2,NULL,NULL,NULL,0,5,'2000-01-01'),(16,'legacy lawyers','legacy lawyers inc','legacy lawyers',500,'',NULL,'',404,NULL,'','',5,NULL,NULL,NULL,0,NULL,NULL),(19,'bank of van city','bank of van city','bank of van city',500,'',NULL,'',408,NULL,'','',NULL,NULL,NULL,NULL,0,NULL,NULL),(20,'cibc melon','cibc melon','cibc melon',500,'',NULL,'',408,NULL,'','',NULL,NULL,NULL,NULL,0,NULL,NULL),(21,'arhtur insurance agency','arhtur insurance agency','arhtur insurance agency',500,'',NULL,'',408,NULL,'','',NULL,NULL,NULL,NULL,0,NULL,NULL),(22,'Best Buy','Best Buy inc','Best Buy',500,'9000012345','1987-12-12','7890123',406,NULL,'unlimited class a voting shares with no par value. 1 million class b common non-voting without par value','100 class a common shares at $10 per share. about 500 class b shares at $1 per share',2,NULL,NULL,NULL,0,NULL,'1689-12-12'),(60,'H&R Block',NULL,NULL,500,NULL,NULL,NULL,408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),(104,'Sai Org','Saibaba Satsang','Sai Org',500,'9000012345','2008-02-01','6669000',408,NULL,'tasting','tasting',2,NULL,NULL,NULL,0,NULL,NULL),(119,'SunTrust Bank','SunTrust Bank Inc',NULL,500,NULL,NULL,NULL,408,NULL,NULL,NULL,2,NULL,NULL,NULL,0,NULL,NULL),(140,'All Is Well Charity','All Is Well Charity CoRP','All Is Well Charity',500,'345','2011-02-10','657',408,NULL,'All Is Well Charity','All Is Well Charity',2,NULL,NULL,NULL,0,NULL,'2011-02-10'),(146,'Circuit city','Circuit City Inc','Circuit city',504,'CIR-234560','2011-02-09','INC-4567890',405,NULL,'1234','6789',2,NULL,NULL,NULL,0,NULL,'2011-02-09'),(148,'Comp USA','Comp USA Inc','Comp USA',504,'56902345',NULL,'d56789',405,NULL,'grfrewf','fgfd',2,NULL,NULL,NULL,0,NULL,NULL),(149,'RK Development','RK Development Inc','RK Development',500,'789-345-1234','2008-01-01','4567890',415,NULL,'RK development has authorized 1 Billion Dollars','RK Development has issues capital worth of 20 Billion Dollars',2,NULL,NULL,NULL,0,NULL,'2011-03-01'),(150,'Circuit City','Circuit City Inc','Circuit City',500,'CIR-234560','2009-09-30','4567890',401,NULL,'rhnh','hnnh',2,NULL,NULL,NULL,0,NULL,'2011-03-01'),(152,'Capital One','Capital One','Capital One',504,'56902345','2008-01-01','000001',408,NULL,'123334','11111',2,NULL,NULL,NULL,0,NULL,'2011-02-08'),(153,'Bank One','Bank One','Bank One',504,'56902345',NULL,'INC-000001',408,NULL,'123334','11111',2,NULL,NULL,NULL,0,NULL,NULL),(154,'National Furniture','National Furniture','National Furniture',504,'56902345',NULL,'INC-000001',408,NULL,'123334','11111',2,NULL,NULL,NULL,0,NULL,NULL),(156,'Woodlands Restaurant','Woodlands Restaurant','Woodlands Restaurant',501,'CIR-234560','2011-02-09','INC-4567890',410,NULL,'Woodlands Restaurant','Woodlands Restaurant',2,NULL,NULL,NULL,0,NULL,'2011-02-15'),(157,'CVS Pharmacy','CVS Pharmacy Inc','CVS Pharmacy',500,'CIR-234560','2007-09-28','INC-4567890',401,NULL,'rhnh','hnnh',2,NULL,NULL,NULL,0,NULL,NULL),(175,'Bank of America',NULL,'Bank of America',NULL,NULL,NULL,NULL,408,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL),(176,'Bank of America',NULL,'Bank of America',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(186,'Fannie Mae Inc','Fannie Mae','Fannie Mae Inc',504,'67890','2010-09-15','333333',408,NULL,'122222','11111',2,NULL,NULL,NULL,NULL,NULL,NULL),(192,'Fannie Mae Inc','Fannie Mae','Fannie Mae Inc',504,'67890','2010-09-15','9999999',408,NULL,'122222','11111',2,NULL,NULL,NULL,NULL,NULL,NULL),(198,'SunTrust Bank',NULL,'SunTrust Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(199,'BB&T',NULL,'BB&T',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(216,'Capital One Bank',NULL,'Capital One Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(217,'Bank One',NULL,'Bank One',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(218,'Citi Bank',NULL,'Citi Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(219,'Nations Bank',NULL,'Nations Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(220,'Hope Well Bank',NULL,'Hope Well Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(221,'Hope Well Bank',NULL,'Hope Well Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(222,'First VA Bank',NULL,'First VA Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(223,'MD Community Bank',NULL,'MD Community Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(224,'Georgia Commerce Bank',NULL,'Georgia Commerce Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(225,'WV MIners Bank',NULL,'WV MIners Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(226,'WV MIners Bank',NULL,'WV MIners Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(227,'Bank of Newyyork',NULL,'Bank of Newyyork',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(228,'Bank of New England',NULL,'Bank of New England',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(229,'Ram Rahim Bank',NULL,'Ram Rahim Bank',504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(249,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL),(250,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL),(251,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL),(252,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL),(253,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL),(254,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL),(255,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL),(256,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL),(257,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL),(258,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL),(259,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL),(260,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL),(261,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(262,NULL,NULL,NULL,504,NULL,NULL,NULL,418,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL),(263,NULL,'kendule enterprise',NULL,500,'123456789rc0001','2000-01-01','123456',404,NULL,'unlimited class a voting shares with no par value. 1 million class b common non-voting without par value','100 class a common shares at $10 per share. about 500 class b shares at $1 per share',2,NULL,NULL,NULL,NULL,NULL,NULL),(264,NULL,'kendule enterprise ',NULL,500,'123456789rc0001','2000-01-01','123456',404,NULL,'unlimited class a voting shares with no par value. 1 million class b common non-voting without par value','100 class a common shares at $10 per share. about 500 class b shares at $1 per share',2,NULL,NULL,NULL,NULL,NULL,NULL),(269,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(318,'Cluster Ltd','Cluster','Cluster Ltd',501,'4567890','1987-12-12','4567890',403,NULL,'Testing','Testing',2,NULL,NULL,NULL,NULL,NULL,NULL),(320,NULL,'Chiguru Soft Test','Chiguru Soft Test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(350,NULL,'Mindtree',NULL,501,'4567890','2011-02-03','6669000',402,NULL,'Testing','Testing',2,NULL,NULL,NULL,NULL,NULL,NULL),(351,'GOVINDA','GOVINDA','GOVINDA',501,'9000012345','2003-01-01','4567890',402,NULL,'Testing','Testing',2,NULL,NULL,NULL,NULL,NULL,NULL),(352,'Professional Access','Professional Access lmt','Professional Access',501,'9000012345','2011-02-03','4567890',403,NULL,'testing','testing',2,NULL,NULL,NULL,NULL,NULL,NULL),(354,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(358,'anand','sandeep','anand',504,'123456789','2011-02-03','254654',415,NULL,'asdfgh','22222',2,NULL,NULL,NULL,NULL,NULL,NULL),(360,'pradeep','santhosh','pradeep',501,'333333','2011-02-16','333333',411,NULL,'','',2,NULL,NULL,NULL,NULL,NULL,NULL),(361,'pradeep','santhosh','pradeep',501,'124556','2011-02-15','222222',408,NULL,'dfjdgff','jklhjl',2,NULL,NULL,NULL,NULL,NULL,NULL),(362,'pradeep','santhosh','pradeep',502,'1245635','2011-02-10','1111111',410,NULL,'asdfgj','dskjla',2,NULL,NULL,NULL,NULL,NULL,NULL),(363,'rajesh','anand','rajesh',503,'32145','2011-02-07','222222222',412,NULL,'','',2,NULL,NULL,NULL,NULL,NULL,NULL),(365,'rajesh','anand','rajesh',500,'1245635','2011-02-08','4521665',403,NULL,'awertt','khhyyjhf',2,NULL,NULL,NULL,NULL,NULL,NULL),(366,'shankar','manju','shankar',506,'1111111','2011-02-16','2222222',404,NULL,'dfhgjki','dfghfhfh',2,NULL,NULL,NULL,NULL,NULL,NULL),(368,NULL,NULL,NULL,504,NULL,NULL,NULL,408,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(372,NULL,'Xchanging','Xchanging',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(374,'Cambridge','Cambridge pvt ltm','Cambridge',501,'4567890','2011-02-08','6669000',401,NULL,'','',2,NULL,NULL,NULL,NULL,NULL,NULL),(378,'IBM','IBM','IBM',501,'4567890','2011-02-01','4567890',404,NULL,'tesitn','tesitn',2,NULL,NULL,NULL,NULL,NULL,'2011-02-02'),(379,'Quest','Quest','Quest',502,'4567890','2011-02-02','6669000',405,NULL,'testing','testing',2,NULL,NULL,NULL,NULL,NULL,'2011-02-18'),(380,NULL,'JLC soft','JLC soft',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(382,'Infix jlc','Infix jlc','Infix jlc',501,'1245635','2011-02-01','6669000',402,NULL,'testing','testing',2,NULL,NULL,NULL,NULL,NULL,'2011-02-16'),(386,NULL,'Tranfer India','Tranfer India',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(393,NULL,'Accenture','Accenture',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(401,'QSpiders','QSpiders','QSpiders',501,'345','2011-03-02','657',401,NULL,'','',2,NULL,NULL,NULL,NULL,NULL,'2011-03-01'),(402,'Tavlon India','Tavlon India','Tavlon India',500,'345','2011-03-02','657',402,NULL,'Tavlon India','Tavlon India',2,NULL,NULL,NULL,NULL,NULL,'2011-03-02'),(403,NULL,'Xchanging','Xchanging',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(405,'Kumar Brothers','Kumar Brothers','Kumar Brothers',501,'345','2011-03-08','657',403,NULL,'','',2,NULL,NULL,NULL,NULL,NULL,'2011-03-09'),(408,NULL,'Neema Pvt Lmt','Neema Pvt Lmt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(409,'Inception','Inception','Inception',501,'345','2011-03-02','657',403,NULL,'testing','testing',2,NULL,NULL,NULL,NULL,NULL,'2011-03-01'),(410,'Insight Media','Insight Media','Insight Media',502,'345','2011-03-02','657',402,NULL,'testing','testing',2,NULL,NULL,NULL,NULL,NULL,'2011-03-01');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
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
-- Table structure for table `organization_subtype`
--

DROP TABLE IF EXISTS `organization_subtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_subtype` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `organization_type` tinyint(4) unsigned NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SUBTYPE_IS_FOR_ORGANIZATION_TYPE` (`organization_type`),
  CONSTRAINT `FK_SUBTYPE_IS_FOR_ORGANIZATION_TYPE` FOREIGN KEY (`organization_type`) REFERENCES `organization_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_subtype`
--

LOCK TABLES `organization_subtype` WRITE;
/*!40000 ALTER TABLE `organization_subtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_subtype` ENABLE KEYS */;
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
  `parent_type` tinyint(3) unsigned DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_type`
--

LOCK TABLES `organization_type` WRITE;
/*!40000 ALTER TABLE `organization_type` DISABLE KEYS */;
INSERT INTO `organization_type` VALUES (1,'FIRM','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL),(2,'CLIENT','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL),(3,'BANK','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL),(4,'INSURANCE','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL),(5,'LAW_FIRM','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL),(6,'TRANSFER AGENT','','2010-06-17 21:11:13','system','system','2010-06-18 01:11:23',NULL,NULL);
/*!40000 ALTER TABLE `organization_type` ENABLE KEYS */;
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
  `create_user_id` varchar(50) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(50) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `timezone` tinyint(4) unsigned DEFAULT NULL,
  `memo` text,
  `party_type` tinyint(3) unsigned DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `language` tinyint(4) unsigned DEFAULT NULL,
  `juridisction` mediumint(8) DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fk_party_is_for_party_type` (`party_type`),
  KEY `fk_party_has_language` (`language`),
  KEY `fk_party_is_in_timezone` (`timezone`),
  KEY `fk_party_is_in_jurisdiction` (`juridisction`),
  CONSTRAINT `fk_party_is_in_jurisdiction` FOREIGN KEY (`juridisction`) REFERENCES `jurisdiction` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (1,'delves freer anderson raniga caine','tax_firm','','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(2,'Rajesh raniga','person','','1995-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,24,NULL,NULL),(3,'maurice freer','person','\0','1995-01-01',NULL,'system',NULL,'system','2011-02-02 10:55:06',2,NULL,1,3,NULL,NULL),(4,'joan anderson','person','','1995-01-01',NULL,'system',NULL,'system',NULL,2,NULL,2,0,NULL,NULL),(5,'kim caine','person','','1995-01-01',NULL,'system',NULL,'system',NULL,2,NULL,2,0,NULL,NULL),(6,'sue treen','person','','2001-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,2,NULL,NULL),(7,'Jagannath toor','person','','2002-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,35,NULL,NULL),(8,'annette marie','person','','2006-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,1,NULL,NULL),(9,'bank of america','bank','',NULL,NULL,'system',NULL,NULL,NULL,2,NULL,1,0,NULL,NULL),(10,'daniel king','person','','2007-01-01',NULL,'system',NULL,NULL,NULL,2,NULL,2,0,NULL,NULL),(11,'levine samuel','person','','2005-01-01',NULL,'system',NULL,NULL,NULL,2,NULL,2,0,NULL,NULL),(12,'kendule enterprise','client','','2010-01-27',NULL,'system','2011-02-10 08:50:46','system',NULL,2,NULL,2,13,NULL,NULL),(13,'Jonn Spare','person','','2006-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,12,NULL,NULL),(14,'elvin johnson','person','','2006-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,2,NULL,NULL),(15,'steve jobs','person','','2006-01-01',NULL,'system',NULL,'system',NULL,2,NULL,2,0,NULL,NULL),(16,'legacy lawyers','law_firm','','2010-01-27',NULL,'system',NULL,'system',NULL,2,'business law practitioner',1,0,NULL,NULL),(17,'legacy lawyers','law_firm','','2010-01-27',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(18,'neil goda','person','','2005-01-01',NULL,'system',NULL,NULL,NULL,2,'',2,0,NULL,NULL),(19,'bank of van city','bank','','2005-01-01',NULL,'system',NULL,NULL,NULL,2,NULL,2,0,NULL,NULL),(20,'cibc melon','client_transfer_agent','','2005-01-01',NULL,'system',NULL,NULL,NULL,2,NULL,1,0,NULL,NULL),(21,'arhtur insurance agency','insurance_agency','','2005-01-01',NULL,'system',NULL,NULL,NULL,2,NULL,1,0,NULL,NULL),(22,'Best Buy','client','','2010-01-27',NULL,'system','2011-01-29 04:25:08','system','2011-01-29 04:18:27',2,NULL,2,16,NULL,NULL),(60,'H&R Block',NULL,'',NULL,NULL,'system','2010-06-18 03:57:07',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(104,'Sai Org',NULL,'',NULL,NULL,'system','2010-06-21 14:50:06',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(105,'John Wilson',NULL,'',NULL,NULL,'system','2010-06-22 05:13:30',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(109,'John Kennedy',NULL,'\0',NULL,NULL,'system','2010-06-22 20:43:25',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(110,'John Kennedy',NULL,'',NULL,NULL,'system','2010-06-22 20:48:07',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(119,'SunTrust Bank',NULL,'',NULL,NULL,'system','2010-06-24 06:26:20',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(120,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(121,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(122,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(123,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(124,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(125,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(126,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(127,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(128,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(129,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(130,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(131,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(132,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(133,'delves freer anderson raniga caine',NULL,'','2010-01-01',NULL,'system',NULL,'system',NULL,2,NULL,1,0,NULL,NULL),(134,'Sampath Corp',NULL,'',NULL,NULL,'system','2010-06-26 20:23:02',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(140,'All Is Well Charity',NULL,'',NULL,NULL,'system','2010-06-27 07:41:28',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(146,'Circuit city',NULL,'',NULL,NULL,'system','2010-06-27 08:27:03',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(148,'Comp USA',NULL,'',NULL,NULL,'system','2010-06-27 08:43:52',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(149,'RK Development',NULL,'',NULL,NULL,'system','2010-06-27 15:09:33',NULL,NULL,NULL,NULL,2,4,NULL,NULL),(150,'Circuit City',NULL,'',NULL,NULL,'system','2010-06-30 04:30:02',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(152,'Capital One',NULL,'\0',NULL,NULL,'system','2011-02-10 07:53:07',NULL,'2011-02-10 08:00:04',NULL,NULL,2,4,NULL,NULL),(153,'Bank One',NULL,'',NULL,NULL,'system','2010-07-01 02:12:27',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(154,'National Furniture',NULL,'',NULL,NULL,'system','2010-07-01 02:15:56',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(155,'Mohan Pai',NULL,'',NULL,NULL,'system','2010-06-22 20:48:07',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(156,'Woodlands Restaurant',NULL,'',NULL,NULL,'system','2010-07-19 03:25:06','sue treen','2011-03-22 11:53:43',NULL,NULL,2,3,NULL,NULL),(157,'CVS Pharmacy',NULL,'',NULL,NULL,'system','2010-08-23 23:46:38',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(175,'Bank of America',NULL,'',NULL,NULL,'system','2010-09-13 13:04:42',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(176,'Bank of America',NULL,'',NULL,NULL,'system','2010-09-13 13:10:17',NULL,NULL,NULL,NULL,2,9,NULL,NULL),(186,'Fannie Mae Inc',NULL,'',NULL,NULL,'system','2010-09-16 03:19:10',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(192,'Fannie Mae Inc',NULL,'',NULL,NULL,'system','2010-09-16 04:14:05',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(198,'SunTrust Bank',NULL,'',NULL,NULL,'system','2010-09-18 15:08:51',NULL,NULL,NULL,NULL,2,3,NULL,NULL),(199,'BANK OF OTTAVA',NULL,'',NULL,NULL,'system','2010-09-19 19:31:47',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(200,'Bank of DAYA SAGAR',NULL,'',NULL,NULL,'system','2010-09-19 22:03:49',NULL,NULL,NULL,NULL,2,50,NULL,NULL),(216,'Capital One Bank',NULL,'',NULL,NULL,'system','2010-09-20 02:10:25',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(217,'Bank ONE',NULL,'',NULL,NULL,'system','2010-09-20 02:28:31',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(218,'CITI BANK OF CANADA',NULL,'',NULL,NULL,'system','2010-09-20 02:36:07',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(219,'Nations Bank of VA',NULL,'',NULL,NULL,'system','2010-09-20 02:46:07',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(220,'Hope Well Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:03:10',NULL,NULL,NULL,NULL,2,4,NULL,NULL),(221,'All is Well Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:08:50',NULL,NULL,NULL,NULL,2,6,NULL,NULL),(222,'First VA Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:09:13',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(223,'MD Community Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:11:49',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(224,'Georgia Commerce Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:14:02',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(225,'WV MIners Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:18:48',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(226,'WV MIners Bank',NULL,'',NULL,NULL,'system','2010-09-20 03:19:17',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(227,'Bank of Newyyork',NULL,'',NULL,NULL,'system','2010-09-20 03:23:43',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(228,'Bank of New England',NULL,'',NULL,NULL,'system','2010-09-20 03:26:00',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(229,'Ram Rahim Bank',NULL,'',NULL,NULL,'system','2010-09-20 04:50:57',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(242,'Ram Rahim Bank',NULL,'',NULL,NULL,'system','2010-09-23 00:29:22',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(243,'NO MORE BLK PLEASE',NULL,'',NULL,NULL,'system','2010-09-23 01:55:40',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(244,'NO MORE BLK PLS',NULL,'',NULL,NULL,'system','2010-09-23 01:57:22',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(245,'BB&T BANK',NULL,'',NULL,NULL,'system','2010-09-23 02:10:15',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(246,'Fannie Mae Cooperative Bank',NULL,'',NULL,NULL,'system','2010-09-23 03:00:44',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(247,'GOOD WILL BANK',NULL,'',NULL,NULL,'system','2010-09-23 03:04:18',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(248,'GOOD WILL',NULL,'',NULL,NULL,'system','2010-09-23 03:06:53',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(249,'Met Life Insurance',NULL,'',NULL,NULL,'system','2010-09-29 02:00:13',NULL,NULL,NULL,NULL,2,5,NULL,NULL),(250,'American Insurance General',NULL,'',NULL,NULL,'system','2010-09-29 02:41:54',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(251,'cibc melon',NULL,'',NULL,NULL,'system','2010-09-30 01:51:44',NULL,NULL,NULL,NULL,2,4,NULL,NULL),(252,'ING TRUST CORP',NULL,'',NULL,NULL,'system','2010-09-30 04:22:42',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(253,'Test agent Inc',NULL,'',NULL,NULL,'system','2010-09-30 04:26:59',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(254,'International Transfer Agent',NULL,'',NULL,NULL,'system','2010-09-30 04:47:52',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(255,'Nationwide Agent',NULL,'',NULL,NULL,'system','2010-10-09 01:10:22',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(256,'Blank Rome',NULL,'',NULL,NULL,'system','2010-10-09 13:29:28',NULL,NULL,NULL,NULL,2,4,NULL,NULL),(257,'Legacy Laywers LLP',NULL,'',NULL,NULL,'system','2010-10-09 13:37:03',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(258,'Anderson Brothers Law Firm',NULL,'',NULL,NULL,'system','2010-10-09 13:40:11',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(259,'Ameriprise Insurance',NULL,'',NULL,NULL,'system','2010-10-09 14:37:12',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(260,'Pillsbury Winthrop Shaw Pittman LLP',NULL,'',NULL,NULL,'system','2010-10-10 10:36:36',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(261,'Bank of Baoroda',NULL,'',NULL,NULL,'system','2010-10-10 10:49:26',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(262,'Becker, Kellogg & Berry PC',NULL,'',NULL,NULL,'system','2010-10-10 10:52:11',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(263,NULL,NULL,'',NULL,NULL,'system','2010-10-10 17:59:30',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(264,NULL,NULL,'',NULL,NULL,'system','2010-10-10 18:24:44',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(265,'John McMillan',NULL,'',NULL,NULL,'system','2010-10-11 03:51:40',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(266,' ',NULL,'\0',NULL,NULL,'system','2010-10-14 12:00:08',NULL,'2011-02-11 08:59:50',NULL,NULL,1,1,NULL,NULL),(267,'Cris Gale',NULL,'\0',NULL,NULL,'system','2010-10-20 01:10:46',NULL,'2011-02-11 07:02:50',NULL,NULL,1,4,NULL,NULL),(268,NULL,NULL,'',NULL,NULL,'system','2010-11-06 08:24:44',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(269,'NEW BANK',NULL,'',NULL,NULL,'system','2010-11-06 10:44:05',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(272,'Sagar Bannikal',NULL,'\0',NULL,NULL,'system','2010-11-11 14:27:33',NULL,'2011-02-04 05:51:18',NULL,NULL,1,70,NULL,NULL),(313,'Thomas p',NULL,'',NULL,NULL,'system','2010-12-15 06:05:32',NULL,NULL,NULL,NULL,1,7,NULL,NULL),(314,'William Will',NULL,'',NULL,NULL,'system','2011-01-25 10:34:19',NULL,NULL,NULL,NULL,1,3,NULL,NULL),(315,'Pavan Kumar',NULL,'\0',NULL,NULL,'system','2011-01-28 08:09:51',NULL,'2011-02-11 06:50:17',NULL,NULL,1,12,NULL,NULL),(318,'Cluster Ltd',NULL,'',NULL,NULL,'system','2011-01-29 11:25:15',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(319,'Dhaksha walli',NULL,'',NULL,NULL,'system','2011-01-29 11:42:34',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(320,'Chiguru Soft Test',NULL,'\0',NULL,NULL,'system','2011-01-29 12:52:23',NULL,'2011-01-29 13:09:56',NULL,NULL,2,7,NULL,NULL),(334,'Punit ',NULL,'',NULL,NULL,'system','2011-01-31 08:53:34',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(335,'Punit kumar',NULL,'',NULL,NULL,'system','2011-01-31 13:09:01',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(336,'Geeta p',NULL,'',NULL,NULL,'system','2011-01-31 13:52:59',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(337,'Sampath sri',NULL,'',NULL,NULL,'system','2011-01-31 14:08:32',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(340,'Kiran Kumar',NULL,'',NULL,NULL,'system','2011-02-01 04:32:30',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(341,'Guru Kumar',NULL,'',NULL,NULL,'system','2011-02-01 05:34:14',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(342,'Prasad Kumar',NULL,'',NULL,NULL,'system','2011-02-01 05:38:41',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(343,'KRISNA KRISNA',NULL,'',NULL,NULL,'system','2011-02-02 04:27:16',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(345,'Guru Kumar',NULL,'',NULL,NULL,'system','2011-02-02 08:59:46',NULL,NULL,NULL,NULL,1,8,NULL,NULL),(350,NULL,NULL,'\0',NULL,NULL,'system','2011-02-04 14:05:56',NULL,'2011-02-04 14:06:55',NULL,NULL,2,20,NULL,NULL),(351,'GOVINDA',NULL,'',NULL,NULL,'system','2011-02-03 07:09:13',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(352,'Professional Access',NULL,'',NULL,NULL,'system','2011-02-04 13:06:07',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(353,'khadeer basha',NULL,'',NULL,NULL,'system','2011-02-04 13:08:58',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(354,'ICICI',NULL,'',NULL,NULL,'system','2011-02-04 13:14:53',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(355,'Dhaksha Wali',NULL,'',NULL,NULL,'system','2011-02-05 08:00:11',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(356,'Dhaksha Wali',NULL,'',NULL,NULL,'system','2011-02-05 08:10:36',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(357,'Dhaksha Wali',NULL,'',NULL,NULL,'system','2011-02-05 08:11:12',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(358,'anand',NULL,'',NULL,NULL,'system','2011-02-05 12:26:42',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(360,'pradeep',NULL,'',NULL,NULL,'system','2011-02-05 12:46:23',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(361,'pradeep',NULL,'',NULL,NULL,'system','2011-02-05 12:48:10',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(362,'pradeep',NULL,'',NULL,NULL,'system','2011-02-05 12:50:37',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(363,'rajesh',NULL,'',NULL,NULL,'system','2011-02-05 12:56:59',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(365,'rajesh',NULL,'',NULL,NULL,'system','2011-02-05 13:01:49',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(366,'shankar',NULL,'',NULL,NULL,'system','2011-02-05 13:05:09',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(367,'sumanth more',NULL,'',NULL,NULL,'system','2011-02-05 13:20:42',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(368,'Punjab Bank',NULL,'',NULL,NULL,'system','2011-02-08 06:25:42',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(369,'Roshan Kumar',NULL,'\0',NULL,NULL,'system','2011-02-08 07:38:15',NULL,'2011-02-11 07:20:15',NULL,NULL,1,2,NULL,NULL),(370,'Vinod C.V.',NULL,'',NULL,NULL,'system','2011-02-08 11:53:52',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(371,'Amir Khan',NULL,'',NULL,NULL,'system','2011-02-08 12:04:38',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(372,'Xchanging',NULL,'',NULL,NULL,'system','2011-02-08 14:27:31',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(373,'Arvind Kumar',NULL,'',NULL,NULL,'system','2011-02-08 14:29:37',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(374,'Cambridge',NULL,'',NULL,NULL,'system','2011-02-08 14:32:42',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(375,'Shaker Suman',NULL,'\0',NULL,NULL,'system','2011-02-11 07:06:33',NULL,'2011-02-11 07:08:12',NULL,NULL,1,2,NULL,NULL),(376,'Deepak D',NULL,'',NULL,NULL,'system','2011-02-11 12:08:53',NULL,NULL,NULL,NULL,1,22,NULL,NULL),(377,'Rajendra Reddy',NULL,'\0',NULL,NULL,'system','2011-02-11 12:10:42',NULL,'2011-02-11 12:24:09',NULL,NULL,1,3,NULL,NULL),(378,'IBM',NULL,'',NULL,NULL,'system','2011-02-14 06:39:50',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(379,'Quest',NULL,'',NULL,NULL,'system','2011-02-14 07:17:48',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(380,'JLC soft',NULL,'',NULL,NULL,'system','2011-02-14 09:07:01',NULL,NULL,NULL,NULL,2,3,NULL,NULL),(381,'Karthik ',NULL,'',NULL,NULL,'system','2011-02-14 09:08:13',NULL,NULL,NULL,NULL,1,2,NULL,NULL),(382,'Infix jlc',NULL,'',NULL,NULL,'system','2011-02-14 09:09:39',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(383,'Deepak W',NULL,'',NULL,NULL,'system','2011-02-18 14:52:24',NULL,NULL,NULL,NULL,1,10,NULL,NULL),(384,'Deepak D',NULL,'',NULL,NULL,'system','2011-02-21 06:39:02','admin@firm.com','2011-03-29 09:13:27',NULL,NULL,1,5,NULL,NULL),(386,'Tranfer India',NULL,'',NULL,NULL,'system','2011-02-26 10:21:21',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(387,'Ramayana ',NULL,'',NULL,NULL,'system','2011-02-26 10:38:04',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(388,'Sita Priya',NULL,'',NULL,NULL,'system','2011-02-26 10:45:14',NULL,NULL,NULL,NULL,1,2,NULL,NULL),(391,'Tanveer ',NULL,'',NULL,NULL,'system','2011-02-28 10:39:27','admin@firm.com','2011-03-26 06:49:02',NULL,NULL,1,7,NULL,NULL),(393,'Accenture',NULL,'',NULL,NULL,'system','2011-02-28 13:32:22',NULL,NULL,NULL,NULL,2,5,NULL,NULL),(394,'Flapini ',NULL,'',NULL,NULL,'system','2011-02-28 13:41:55',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(395,'Preety ',NULL,'',NULL,NULL,'system','2011-02-28 13:46:50',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(396,'Preety ',NULL,'',NULL,NULL,'system','2011-02-28 13:49:10',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(397,'Preety ',NULL,'',NULL,NULL,'system','2011-02-28 13:51:10',NULL,NULL,NULL,NULL,1,2,NULL,NULL),(398,'Durva ',NULL,'',NULL,NULL,'system','2011-02-28 14:02:40',NULL,NULL,NULL,NULL,1,0,NULL,NULL),(399,'Tanveer William',NULL,'',NULL,NULL,'system','2011-03-01 07:12:20',NULL,NULL,NULL,NULL,1,2,NULL,NULL),(400,'Shanti ',NULL,'',NULL,NULL,'system','2011-03-01 07:39:41',NULL,NULL,NULL,NULL,1,1,NULL,NULL),(401,'QSpiders',NULL,'',NULL,NULL,'system','2011-03-02 06:24:49',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(402,'Tavlon India',NULL,'',NULL,NULL,'system','2011-03-02 06:31:58',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(403,'Xchanging',NULL,'',NULL,NULL,'system','2011-03-02 07:24:49',NULL,NULL,NULL,NULL,2,1,NULL,NULL),(404,'Shanti ',NULL,'',NULL,NULL,'system','2011-03-02 10:45:37',NULL,NULL,NULL,NULL,1,5,NULL,NULL),(405,'Kumar Brothers',NULL,'',NULL,NULL,'system','2011-03-07 08:47:46',NULL,NULL,NULL,NULL,2,0,NULL,NULL),(406,'Preety ',NULL,'',NULL,NULL,'system','2011-03-15 13:29:29','admin@firm.com','2011-04-03 05:11:21',NULL,NULL,1,9,NULL,NULL),(407,'Shanti ',NULL,'',NULL,NULL,'system','2011-03-15 13:39:11',NULL,NULL,NULL,NULL,1,2,NULL,NULL),(408,'Neema Pvt Lmt',NULL,'',NULL,NULL,'system','2011-03-22 04:06:39','admin@firm.com','2011-03-26 11:03:34',NULL,NULL,2,9,NULL,NULL),(409,'Inception',NULL,'',NULL,NULL,'system','2011-03-24 05:18:32',NULL,NULL,NULL,NULL,2,2,NULL,NULL),(410,'Insight Media',NULL,'',NULL,NULL,'system','2011-03-24 07:32:44','kotragoud','2011-03-24 07:35:06',NULL,NULL,2,2,NULL,NULL),(411,'Sachin Tendulkar',NULL,'',NULL,NULL,'karthik@jlc.com','2011-03-26 07:12:31','karthik@jlc.com','2011-03-26 07:12:41',NULL,NULL,1,2,NULL,NULL);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_account`
--

LOCK TABLES `party_account` WRITE;
/*!40000 ALTER TABLE `party_account` DISABLE KEYS */;
INSERT INTO `party_account` VALUES (22,'15',801,NULL,4,'','system','2011-02-16 10:41:24',2,NULL,NULL,'etfd',700,'Bank Of India',229),(22,'15',801,NULL,5,'\0','system','2011-02-16 10:50:52',1,NULL,'2011-02-16 14:25:37','etfd',700,'Bank Of India',230),(22,'6778899999',854,NULL,6,'','system','2011-02-16 12:03:18',1,NULL,NULL,'hgjgh',703,'Bank Of India',231),(22,'15',822,NULL,7,'','system','2011-02-16 12:05:19',1,NULL,NULL,'dfsf',701,'Bank Of India',232),(22,'6778899999',NULL,NULL,8,'','system','2011-02-16 12:06:07',1,NULL,NULL,'dsf',702,'Bank Of India',233),(22,'6778899999',801,NULL,9,'\0','system','2011-02-16 12:11:06',1,NULL,'2011-02-16 14:25:17','uyi',700,'Bank Of India',234),(22,'6778899999',801,NULL,10,'','system','2011-02-16 14:00:24',0,NULL,NULL,'asd',700,'icici',235),(22,'2222',802,NULL,11,'','system','2011-02-17 07:08:11',0,NULL,NULL,'testing',700,'Punjab',237),(22,'6778899999',804,NULL,12,'','system','2011-02-17 07:18:03',0,NULL,NULL,'testing',700,'City Bank',238),(22,'6778899999',803,NULL,13,'','system','2011-02-17 07:23:16',0,NULL,NULL,'fdg',700,'icici',239),(22,'6778899999',NULL,NULL,14,'','system','2011-02-17 08:13:10',0,NULL,NULL,'',702,'City Bank',240),(22,'6778899999',822,NULL,15,'','system','2011-02-17 08:14:17',0,NULL,NULL,'',701,'Punjab5',241),(22,'',NULL,NULL,16,'','system','2011-02-17 08:15:09',1,NULL,NULL,'',703,'Axis',242),(22,'456',804,NULL,17,'','system','2011-02-17 15:16:28',0,NULL,NULL,'tesig',700,'icici',243),(22,'6778899999',801,NULL,18,'','system','2011-02-18 05:51:41',0,NULL,NULL,'testing',700,'Punjab5',244),(22,'6778899999',854,NULL,19,'','system','2011-02-18 06:04:31',0,NULL,NULL,'',703,'Bank Of India',245),(12,'6778899999',803,NULL,20,'','system','2011-02-21 08:21:08',0,NULL,NULL,'',700,'Bank Of India',254),(22,'234',801,NULL,21,'','system','2011-02-27 06:25:15',0,NULL,NULL,'testing',700,'SBI',259),(22,'234',851,NULL,22,'','system','2011-02-27 06:44:21',0,NULL,NULL,'testing',703,'SBI',260),(22,'234',851,NULL,23,'','system','2011-02-27 06:44:40',0,NULL,NULL,'testing',703,'SBI',261),(22,'234',822,NULL,24,'','system','2011-02-28 05:39:23',0,NULL,NULL,'testing',701,'SBI',262),(22,'234',NULL,NULL,25,'','system','2011-02-28 05:40:47',0,NULL,NULL,'testing',702,'SBI',263),(146,'234',801,NULL,26,'','system','2011-03-01 08:22:07',0,NULL,NULL,'testing',700,'SBI',281),(104,'234',804,NULL,27,'','system','2011-03-15 14:16:29',0,NULL,NULL,'testing',700,'SBI',291),(104,'234',NULL,NULL,28,'','system','2011-03-15 14:17:25',0,NULL,NULL,'testnig',702,'SBI',292);
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
  `version` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_code`
--

LOCK TABLES `party_code` WRITE;
/*!40000 ALTER TABLE `party_code` DISABLE KEYS */;
INSERT INTO `party_code` VALUES (14,1461,1,'2011-01-21 19:20:00','system',0,1,NULL,NULL,''),(15,1462,1,'2011-01-21 19:20:36','system',2,1,NULL,'2011-02-04 08:25:35','\0'),(17,1465,320,'2011-02-06 12:29:36','system',0,2,NULL,NULL,''),(18,1466,320,'2011-02-06 12:43:25','system',0,4,NULL,NULL,''),(20,1467,1,'2011-02-14 11:27:22','system',0,2,NULL,NULL,'');
/*!40000 ALTER TABLE `party_code` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_communication`
--

LOCK TABLES `party_communication` WRITE;
/*!40000 ALTER TABLE `party_communication` DISABLE KEYS */;
INSERT INTO `party_communication` VALUES (1,'phone_land_line',2,'604 588-8377','9 am - 5 pm','',NULL),(2,'email_address',2,' raniga@dfarc.com','',NULL,NULL),(3,'phone-1',13,'604-111-1234','9 am - 5 pm','',NULL),(4,'email_address',13,'anderson@kendule.com','9 am - 5 pm','',NULL),(5,'contact-1',16,'604-455-9878','9 am - 5 pm','',16);
/*!40000 ALTER TABLE `party_communication` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk28add711e26427d4` (`subject`),
  KEY `fk28add711abcbbce1` (`object`),
  KEY `fk_party_relationship_has_type` (`relationship_type`),
  CONSTRAINT `fk_party_relationship_has_type` FOREIGN KEY (`relationship_type`) REFERENCES `relationship_type` (`id`),
  CONSTRAINT `fk_party_relationship_is_for_object` FOREIGN KEY (`object`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_party_relationship_is_for_subject_party` FOREIGN KEY (`subject`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_relationship`
--

LOCK TABLES `party_relationship` WRITE;
/*!40000 ALTER TABLE `party_relationship` DISABLE KEYS */;
INSERT INTO `party_relationship` VALUES (1,2,1,'partner of',2,NULL,'system','\0',1,NULL,NULL),(2,3,1,'partner of',2,NULL,'system','\0',1,NULL,NULL),(3,4,1,'partner of',2,NULL,'system',NULL,0,NULL,NULL),(4,5,1,'partner of',2,NULL,'system',NULL,0,NULL,NULL),(5,6,1,'employee of',3,NULL,'system','\0',1,NULL,NULL),(6,7,1,'employee of',3,NULL,'system','\0',1,NULL,NULL),(7,8,1,'employee of',3,NULL,'system','\0',1,NULL,NULL),(8,11,1,'lawyer of',5,NULL,'system',NULL,0,NULL,NULL),(9,9,1,'bank of',4,NULL,'system',NULL,0,NULL,NULL),(10,10,2,'insurance agent of',6,NULL,'system',NULL,0,NULL,NULL),(11,12,1,'client of',1,NULL,'system','\0',1,NULL,NULL),(12,13,12,'employee of',3,NULL,'system','\0',1,NULL,NULL),(13,14,12,'employee of',3,NULL,'system','\0',1,NULL,NULL),(14,15,12,'shareholder of',7,NULL,'system',NULL,0,NULL,NULL),(15,16,12,'lawyer of',5,NULL,'system',NULL,0,NULL,NULL),(16,18,16,'employee of',3,NULL,'system',NULL,0,NULL,NULL),(17,19,12,'banker of',4,NULL,'system',NULL,0,NULL,NULL),(18,20,12,'client transfer agent of',8,NULL,'system',NULL,0,NULL,NULL),(19,21,12,'insurance agent of',6,NULL,'system',NULL,0,NULL,NULL),(20,22,1,'client of',1,NULL,'system','\0',1,NULL,NULL),(28,104,1,NULL,1,'2010-06-21 14:50:06','system','',0,NULL,NULL),(29,105,104,NULL,2,'2010-06-22 05:13:45','system','',0,NULL,NULL),(30,109,1,NULL,2,'2010-06-22 20:43:25','system','',0,NULL,NULL),(31,110,1,NULL,2,'2010-06-22 20:48:07','system','',0,NULL,NULL),(33,119,104,NULL,4,'2010-06-24 06:26:20','system','',0,NULL,NULL),(34,140,1,NULL,1,'2010-06-27 07:41:36','system','',0,NULL,NULL),(36,146,1,NULL,1,'2010-06-27 08:27:16','system','',0,NULL,NULL),(38,148,1,NULL,1,'2010-06-27 08:43:52','system','',0,NULL,NULL),(39,149,1,NULL,1,'2010-06-27 15:09:33','system','',0,NULL,NULL),(40,150,1,NULL,1,'2010-06-30 04:30:05','system','',0,NULL,NULL),(42,152,1,NULL,1,'2010-07-01 02:10:30','system','',0,NULL,NULL),(43,153,1,NULL,1,'2010-07-01 02:12:29','system','',0,NULL,NULL),(44,154,1,NULL,1,'2010-07-01 02:15:56','system','',0,NULL,NULL),(45,156,1,NULL,1,'2010-07-19 03:25:07','system','',0,NULL,NULL),(46,157,1,NULL,1,'2010-08-23 23:46:38','system','',0,NULL,NULL),(51,176,1,NULL,1,'2010-09-14 12:03:52','system','',0,NULL,NULL),(52,176,1,NULL,4,'2010-09-14 12:39:24','system','',0,NULL,NULL),(53,176,1,NULL,9,'2010-09-14 12:42:25','system','',0,NULL,NULL),(56,186,1,NULL,1,'2010-09-16 03:19:42','system','',0,NULL,NULL),(60,198,1,NULL,9,'2010-09-18 15:08:57','system','',0,NULL,NULL),(61,199,1,NULL,9,'2010-09-19 19:31:55','system','',0,NULL,NULL),(62,200,1,NULL,9,'2010-09-19 22:03:49','system','',0,NULL,NULL),(78,216,1,NULL,9,'2010-09-20 02:10:25','system','',0,NULL,NULL),(79,217,1,NULL,9,'2010-09-20 02:28:31','system','',0,NULL,NULL),(80,218,1,NULL,9,'2010-09-20 02:36:07','system','',0,NULL,NULL),(81,219,1,NULL,9,'2010-09-20 02:46:07','system','',0,NULL,NULL),(82,220,1,NULL,9,'2010-09-20 03:03:10','system','',0,NULL,NULL),(83,221,1,NULL,9,'2010-09-20 03:08:50','system','',0,NULL,NULL),(84,222,1,NULL,9,'2010-09-20 03:09:13','system','',0,NULL,NULL),(85,223,1,NULL,9,'2010-09-20 03:11:50','system','',0,NULL,NULL),(86,224,1,NULL,9,'2010-09-20 03:14:02','system','',0,NULL,NULL),(87,225,1,NULL,9,'2010-09-20 03:18:48','system','',0,NULL,NULL),(88,226,1,NULL,9,'2010-09-20 03:19:17','system','',0,NULL,NULL),(89,227,1,NULL,9,'2010-09-20 03:23:44','system','',0,NULL,NULL),(90,228,1,NULL,9,'2010-09-20 03:26:01','system','',0,NULL,NULL),(91,229,1,NULL,9,'2010-09-20 04:50:57','system','',0,NULL,NULL),(104,242,1,NULL,9,'2010-09-23 00:29:22','system','',0,NULL,NULL),(105,243,1,NULL,9,'2010-09-23 01:55:40','system','',0,NULL,NULL),(106,244,1,NULL,9,'2010-09-23 01:57:22','system','',0,NULL,NULL),(107,245,1,NULL,9,'2010-09-23 02:10:15','system','',0,NULL,NULL),(108,246,1,NULL,9,'2010-09-23 03:00:44','system','',0,NULL,NULL),(109,247,1,NULL,9,'2010-09-23 03:04:18','system','',0,NULL,NULL),(110,248,1,NULL,9,'2010-09-23 03:06:53','system','',0,NULL,NULL),(111,249,1,NULL,10,'2010-09-29 02:00:14','system','',0,NULL,NULL),(112,250,1,NULL,10,'2010-09-29 02:41:55','system','',0,NULL,NULL),(113,251,1,NULL,11,'2010-09-30 01:51:45','system','',0,NULL,NULL),(114,252,1,NULL,11,'2010-09-30 04:22:43','system','',0,NULL,NULL),(115,253,1,NULL,11,'2010-09-30 04:27:00','system','',0,NULL,NULL),(116,254,1,NULL,11,'2010-09-30 04:47:53','system','',0,NULL,NULL),(117,255,1,NULL,11,'2010-10-09 01:10:24','system','',0,NULL,NULL),(118,256,1,NULL,12,'2010-10-09 13:29:29','system','',0,NULL,NULL),(119,257,1,NULL,12,'2010-10-09 13:37:04','system','',0,NULL,NULL),(120,258,1,NULL,12,'2010-10-09 13:40:12','system','',0,NULL,NULL),(121,259,1,NULL,10,'2010-10-09 14:37:14','system','',0,NULL,NULL),(122,260,1,NULL,12,'2010-10-10 10:36:37','system','',0,NULL,NULL),(123,261,1,NULL,9,'2010-10-10 10:49:26','system','',0,NULL,NULL),(124,262,1,NULL,12,'2010-10-10 10:52:12','system','',0,NULL,NULL),(125,265,12,NULL,3,'2010-10-11 03:51:41','system','',0,NULL,NULL),(126,266,12,NULL,7,'2010-10-14 12:00:15','system','',0,NULL,NULL),(127,13,12,NULL,7,'2010-10-14 12:52:35','system','',0,NULL,NULL),(128,265,12,NULL,7,'2010-10-19 04:18:41','system','',0,NULL,NULL),(129,267,12,NULL,3,'2010-10-20 01:10:48','system','',0,NULL,NULL),(134,7,7,NULL,3,'2010-11-04 14:34:00','system','',0,NULL,NULL),(135,268,1,NULL,9,'2010-11-06 08:24:47','system','',0,NULL,NULL),(136,269,1,NULL,9,'2010-11-06 10:46:42','system','',0,NULL,NULL),(139,272,1,NULL,3,'2010-11-11 14:27:36','system','',0,NULL,NULL),(176,313,1,NULL,3,'2010-12-15 06:05:37','system','',0,NULL,NULL),(177,7,104,NULL,7,'2011-01-25 10:23:40','system','',0,NULL,NULL),(178,314,104,NULL,3,'2011-01-25 10:34:40','system','',0,NULL,NULL),(179,314,104,NULL,7,'2011-01-25 10:35:27','system','',0,NULL,NULL),(180,267,12,NULL,7,'2011-01-26 13:19:27','system','',0,NULL,NULL),(181,315,22,NULL,3,'2011-01-28 08:09:56','system','',0,NULL,NULL),(182,315,22,NULL,7,'2011-01-28 08:11:18','system','',0,NULL,NULL),(185,318,1,NULL,1,'2011-01-29 11:25:27','system','',0,NULL,NULL),(186,319,318,NULL,3,'2011-01-29 11:42:38','system','',0,NULL,NULL),(187,319,318,NULL,7,'2011-01-29 11:43:09','system','',0,NULL,NULL),(188,335,1,NULL,3,'2011-01-31 13:09:08','system','',0,NULL,NULL),(189,336,1,NULL,2,'2011-01-31 13:53:35','system','',0,NULL,NULL),(190,337,1,NULL,13,'2011-01-31 14:09:03','system','',0,NULL,NULL),(193,340,1,NULL,3,'2011-02-01 04:33:03','system','',0,NULL,NULL),(194,341,1,NULL,3,'2011-02-01 05:34:26','system','',0,NULL,NULL),(195,342,1,NULL,2,'2011-02-01 05:38:54','system','',0,NULL,NULL),(196,343,1,NULL,3,'2011-02-02 04:27:34','system','',0,NULL,NULL),(205,345,320,NULL,3,'2011-02-02 09:00:07','system','',0,NULL,NULL),(209,350,1,NULL,1,'2011-02-02 14:26:19','system','',0,NULL,NULL),(210,351,1,NULL,1,'2011-02-03 07:09:45','system','',0,NULL,NULL),(211,352,320,NULL,1,'2011-02-04 13:06:13','system','',0,NULL,NULL),(212,353,352,NULL,3,'2011-02-04 13:09:04','system','',0,NULL,NULL),(213,353,352,NULL,7,'2011-02-04 13:09:39','system','',0,NULL,NULL),(214,354,320,NULL,9,'2011-02-04 13:14:55','system','',0,NULL,NULL),(215,272,1,NULL,2,'2011-02-05 05:49:47','system','',0,NULL,NULL),(218,356,320,NULL,13,'2011-02-05 08:10:46','system','',0,NULL,NULL),(219,357,320,NULL,13,'2011-02-05 08:11:21','system','',0,NULL,NULL),(220,358,1,NULL,1,'2011-02-05 12:26:47','system','',0,NULL,NULL),(222,360,1,NULL,1,'2011-02-05 12:46:29','system','',0,NULL,NULL),(223,361,1,NULL,1,'2011-02-05 12:48:15','system','',0,NULL,NULL),(224,362,1,NULL,1,'2011-02-05 12:50:42','system','',0,NULL,NULL),(225,363,1,NULL,1,'2011-02-05 12:57:05','system','',0,NULL,NULL),(227,365,1,NULL,1,'2011-02-05 13:01:55','system','',0,NULL,NULL),(228,366,1,NULL,1,'2011-02-05 13:05:14','system','',0,NULL,NULL),(229,367,366,NULL,3,'2011-02-05 13:20:48','system','',0,NULL,NULL),(230,367,366,NULL,7,'2011-02-05 13:26:33','system','',0,NULL,NULL),(231,368,1,NULL,9,'2011-02-08 06:25:45','system','',0,NULL,NULL),(232,369,22,NULL,3,'2011-02-08 07:38:48','system','',0,NULL,NULL),(233,370,320,NULL,2,'2011-02-08 11:54:42','system','',0,NULL,NULL),(234,371,140,NULL,3,'2011-02-08 12:04:46','system','',0,NULL,NULL),(235,373,372,NULL,3,'2011-02-08 14:29:49','system','',0,NULL,NULL),(236,374,372,NULL,1,'2011-02-08 14:32:51','system','',0,NULL,NULL),(237,375,153,NULL,3,'2011-02-11 07:06:40','system','',0,NULL,NULL),(238,375,153,NULL,7,'2011-02-11 07:07:34','system','',0,NULL,NULL),(239,369,22,NULL,7,'2011-02-11 07:18:51','system','',0,NULL,NULL),(240,376,156,NULL,3,'2011-02-11 12:09:03','system','',0,NULL,NULL),(241,377,156,NULL,3,'2011-02-11 12:10:50','system','',0,NULL,NULL),(242,376,156,NULL,7,'2011-02-11 12:11:44','system','',0,NULL,NULL),(243,377,156,NULL,7,'2011-02-11 12:12:43','system','',0,NULL,NULL),(244,378,320,NULL,1,'2011-02-14 06:40:28','system','',0,NULL,NULL),(245,379,320,NULL,1,'2011-02-14 07:17:57','system','',0,NULL,NULL),(246,381,380,NULL,3,'2011-02-14 09:08:23','system','',0,NULL,NULL),(247,382,380,NULL,1,'2011-02-14 09:09:45','system','',0,NULL,NULL),(248,383,1,NULL,3,'2011-02-18 14:52:30','system','',0,NULL,NULL),(249,384,22,NULL,3,'2011-02-21 06:39:09','system','',0,NULL,NULL),(251,387,386,NULL,3,'2011-02-26 10:38:08','system','',0,NULL,NULL),(252,388,150,NULL,3,'2011-02-26 10:46:12','system','',0,NULL,NULL),(253,391,1,NULL,3,'2011-02-28 10:40:02','system','',0,NULL,NULL),(254,394,393,NULL,3,'2011-02-28 13:42:05','system','',0,NULL,NULL),(255,395,393,NULL,2,'2011-02-28 13:47:22','system','',0,NULL,NULL),(256,396,393,NULL,2,'2011-02-28 13:49:16','system','',0,NULL,NULL),(257,397,393,NULL,2,'2011-02-28 13:51:14','system','',0,NULL,NULL),(258,398,393,NULL,2,'2011-02-28 14:02:44','system','',0,NULL,NULL),(259,399,12,NULL,3,'2011-03-01 07:12:22','system','',0,NULL,NULL),(260,400,150,NULL,3,'2011-03-01 07:39:43','system','',0,NULL,NULL),(261,400,150,NULL,7,'2011-03-01 07:45:18','system','',0,NULL,NULL),(262,401,1,NULL,1,'2011-03-02 06:24:51','system','',0,NULL,NULL),(263,402,1,NULL,1,'2011-03-02 06:32:09','system','',0,NULL,NULL),(264,404,22,NULL,3,'2011-03-02 10:45:39','system','',0,NULL,NULL),(265,384,22,NULL,7,'2011-03-03 07:49:12','system','',0,NULL,NULL),(266,405,1,NULL,1,'2011-03-07 08:48:06','system','',0,NULL,NULL),(267,406,1,NULL,3,'2011-03-15 13:29:30','system','',0,NULL,NULL),(268,407,12,NULL,3,'2011-03-15 13:39:12','system','',0,NULL,NULL),(269,407,12,NULL,7,'2011-03-16 07:14:58','system','',0,NULL,NULL),(270,404,22,NULL,7,'2011-03-16 07:24:27','system','',0,NULL,NULL),(271,409,1,NULL,1,'2011-03-24 05:18:34','Sagar','',1,NULL,NULL),(272,410,1,NULL,1,'2011-03-24 07:32:51','system','',2,'kotragoud','2011-03-24 07:35:02'),(273,411,380,NULL,3,'2011-03-26 07:12:31','karthik@jlc.com','',2,'karthik@jlc.com','2011-03-26 07:12:40');
/*!40000 ALTER TABLE `party_relationship` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_site`
--

LOCK TABLES `party_site` WRITE;
/*!40000 ALTER TABLE `party_site` DISABLE KEYS */;
INSERT INTO `party_site` VALUES (2,2,1,12,'','',2,11,NULL,NULL,NULL,'system','praveen','kumar','kendule enterprise'),(3,3,1,7,'','',2,1,NULL,NULL,NULL,'system','','','Head Office'),(4,3,2,5,'','',2,0,NULL,NULL,NULL,'system',NULL,NULL,'Branch Office'),(5,4,3,13,'','',2,10,NULL,NULL,NULL,'system','Jonn','Spare','Jonn Spare'),(6,5,1,16,'','',2,0,NULL,NULL,NULL,'system',NULL,NULL,NULL),(7,6,1,19,'','',2,0,NULL,NULL,NULL,'system',NULL,NULL,NULL),(11,16,1,119,'',NULL,NULL,114,NULL,NULL,'2010-06-24 06:26:20','system','Mohan Pai','Teller Supervisor',NULL),(25,49,1,104,'',NULL,NULL,62,NULL,NULL,'2010-08-30 06:38:01','system','John Wilson','VP Finance','Banglore'),(42,79,1,175,'',NULL,NULL,0,NULL,NULL,'2010-09-13 13:04:42','system','Some one','VP Finance',NULL),(43,80,1,176,'',NULL,NULL,4,NULL,NULL,'2010-09-13 13:10:17','system','James Madison Test','VP Finance','Doller colony'),(53,90,1,186,'',NULL,NULL,2,NULL,NULL,'2010-09-16 03:19:10','system','Shrinivas Gudi','VP','Head Office'),(59,96,1,192,'',NULL,NULL,0,NULL,NULL,'2010-09-16 04:14:05','system','Shrinivas','VP',NULL),(63,101,2,186,'',NULL,NULL,0,NULL,NULL,'2010-09-16 20:36:51','system','James Bond','Sr Manager','Washington DC site'),(64,102,4,186,'',NULL,NULL,1,NULL,NULL,'2010-09-16 20:46:34','system','John Moore','Markering Director','New York Site'),(65,103,2,176,'',NULL,NULL,4,NULL,NULL,'2010-09-18 11:48:26','system','Jones Smith','Manager','Rt 28 Branch,'),(66,104,2,176,'',NULL,NULL,0,NULL,NULL,'2010-09-18 11:51:05','system','John Caravan','Teller','Fairfax Downtown Branch'),(67,105,2,216,'',NULL,NULL,0,NULL,NULL,'2010-09-20 02:15:56','system','Mike Mahoney','Manager','Mclean Main Branch'),(68,106,2,216,'',NULL,NULL,0,NULL,NULL,'2010-09-20 02:18:03','system','John Adams','Teller','Falla churuh Downtown Branch'),(70,112,2,221,'',NULL,NULL,0,NULL,NULL,'2010-09-23 04:37:35','system','James Bond','Sr Manager','Hopewell Edison Branch'),(71,113,2,222,'',NULL,NULL,0,NULL,NULL,'2010-09-23 04:39:08','system','John Adams','Manager','Rt 28 Branch'),(72,115,2,218,'',NULL,NULL,0,NULL,NULL,'2010-09-24 03:28:51','system','John Adams','Manager','OTTAVA BRANCH'),(73,116,2,227,'',NULL,NULL,0,NULL,NULL,'2010-09-25 14:25:17','system','John Moore','Manager','Fiftt Ave Branch'),(74,117,2,176,'\0',NULL,NULL,7,NULL,'2011-02-10 08:41:56','2010-09-26 11:44:23','system','James Bond','Manager','Siute Branch,'),(75,118,1,249,'',NULL,NULL,4,NULL,NULL,'2010-09-29 03:09:39','system','John Adams','Manager','Washington DC site'),(76,119,1,251,'',NULL,NULL,4,NULL,NULL,'2010-09-30 02:23:28','system','Allen Smith','VP','Allenttown Branch'),(77,120,8,251,'\0',NULL,NULL,1,NULL,NULL,'2010-09-30 04:22:00','system','Mike Mallon','Manager','DC Office'),(78,121,8,249,'\0',NULL,NULL,1,NULL,NULL,'2010-10-07 05:36:24','system','Edwin Murphy','Manager','Elden st Office'),(79,122,8,250,'',NULL,NULL,0,NULL,NULL,'2010-10-08 22:20:34','system','George Jr','Sr. Agent','Toronto Office'),(80,123,8,252,'',NULL,NULL,0,NULL,NULL,'2010-10-09 01:08:10','system','James Chase','Superviser','ING Vancuor Office'),(81,124,1,256,'\0',NULL,NULL,11,NULL,NULL,'2010-10-10 10:28:10','system','Joe Guntia','VP','Blank Rome HO'),(82,125,1,262,'',NULL,NULL,0,NULL,NULL,'2010-10-10 11:01:21','system','Bekcer','CEO','Head Office'),(83,125,1,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'system','Bekcer','CEO','Head Office'),(84,12,3,2,'\0',NULL,NULL,32,NULL,NULL,NULL,NULL,'Rajesh','raniga','Rajesh raniga'),(87,129,3,1,'',NULL,NULL,9,NULL,NULL,'2010-11-30 08:28:51','system','Jagannath','toor','Jagannath toor'),(88,130,3,272,'',NULL,NULL,78,NULL,NULL,'2010-11-30 08:38:19','system','Sagar','Bannikal','Sagar Bannikal'),(90,132,3,8,'',NULL,NULL,0,NULL,NULL,'2010-12-02 07:34:24','system','annette marie','annette marie',NULL),(91,133,3,3,'',NULL,NULL,1,NULL,NULL,'2010-12-03 15:23:00','system','maurice','freer','maurice freer'),(92,134,3,313,'',NULL,NULL,4,NULL,NULL,'2010-12-21 13:04:57','system','Thomas','p','Thomas p'),(94,136,8,22,'\0',NULL,NULL,27,NULL,NULL,'2011-01-07 11:57:55','system','Nikil','Kumar','Best Bay Location'),(95,146,3,314,'',NULL,NULL,3,NULL,NULL,'2011-01-25 10:34:19','system','William','Will','William Will'),(96,147,2,104,'',NULL,NULL,3,NULL,NULL,'2011-01-25 10:38:08','system','Sai Kumar','abc','Sai Devepemets'),(97,150,3,267,'',NULL,NULL,2,NULL,NULL,'2011-01-25 11:28:10','system','Cris','Gale','Cris Gale'),(99,154,1,150,'',NULL,NULL,2,NULL,NULL,'2011-01-26 06:09:28','system','Sai Kumar','Manager','Main'),(101,156,1,152,'',NULL,NULL,1,NULL,NULL,'2011-01-26 10:15:17','system',NULL,NULL,NULL),(102,157,3,315,'',NULL,NULL,11,NULL,NULL,'2011-01-28 08:09:51','system','Pavan','Kumar','Pavan Kumar'),(103,158,3,14,'',NULL,NULL,2,NULL,NULL,'2011-01-28 09:09:03','system','elvin','johnson','elvin johnson'),(104,159,2,198,'',NULL,NULL,2,NULL,NULL,'2011-01-28 11:58:31','system','Druva','Manager','JP nagaR,'),(105,162,1,318,'',NULL,NULL,3,NULL,NULL,'2011-01-29 11:38:33','system','Dhaksha','Manager','Rajkumar Road,'),(106,163,3,319,'',NULL,NULL,1,NULL,NULL,'2011-01-29 11:42:34','system','Dhaksha','walli','Dhaksha walli'),(107,164,3,6,'',NULL,NULL,0,NULL,NULL,'2011-01-29 12:22:32','system','sue','treen','sue treen'),(108,165,1,320,'',NULL,NULL,6,NULL,NULL,'2011-01-29 12:52:23','system','Chiguru Soft Test','Chiguru Soft Test','Chiguru Soft Test'),(109,166,3,335,'',NULL,NULL,0,NULL,NULL,'2011-01-31 13:09:01','system','Punit','kumar','Punit kumar'),(110,167,3,336,'',NULL,NULL,0,NULL,NULL,'2011-01-31 13:52:59','system','Geeta','p','Geeta p'),(111,168,3,337,'',NULL,NULL,0,NULL,NULL,'2011-01-31 14:08:32','system','Sampath','sri','Sampath sri'),(114,171,3,340,'',NULL,NULL,0,NULL,NULL,'2011-02-01 04:32:30','system','Kiran','Kumar','Kiran Kumar'),(115,172,3,341,'',NULL,NULL,0,NULL,NULL,'2011-02-01 05:34:14','system','Guru','Kumar','Guru Kumar'),(116,173,3,342,'',NULL,NULL,0,NULL,NULL,'2011-02-01 05:38:41','system','Prasad','Kumar','Prasad Kumar'),(117,174,3,343,'',NULL,NULL,0,NULL,NULL,'2011-02-02 04:27:16','system','KRISNA','KRISNA','KRISNA KRISNA'),(119,176,3,345,'',NULL,NULL,6,NULL,NULL,'2011-02-02 08:59:46','system','Guru','Kumar','Guru Kumar'),(124,181,1,350,'',NULL,NULL,1,NULL,NULL,'2011-02-02 14:26:10','system',NULL,NULL,NULL),(125,182,1,351,'',NULL,NULL,0,NULL,NULL,'2011-02-03 07:09:13','system',NULL,NULL,NULL),(126,183,1,352,'',NULL,NULL,1,NULL,NULL,'2011-02-04 13:06:07','system','Sallu','Manager','Ricmond cirle,'),(127,184,3,353,'',NULL,NULL,1,NULL,NULL,'2011-02-04 13:08:58','system','khadeer','basha','khadeer basha'),(128,185,1,352,'',NULL,NULL,0,NULL,NULL,'2011-02-04 13:12:01','system','Sallu','Manager','Ricmond cirle,'),(129,186,2,354,'',NULL,NULL,2,NULL,NULL,'2011-02-04 13:16:01','system','Sallu','Manager','Richmond circle,'),(130,187,3,355,'',NULL,NULL,0,NULL,NULL,'2011-02-05 08:00:11','system','Dhaksha','Wali','Dhaksha Wali'),(131,188,3,356,'',NULL,NULL,1,NULL,NULL,'2011-02-05 08:10:36','system','Dhaksha','Wali','Dhaksha Wali'),(132,189,3,357,'',NULL,NULL,1,NULL,NULL,'2011-02-05 08:11:12','system','Dhaksha','Wali','Dhaksha Wali'),(133,190,1,358,'',NULL,NULL,0,NULL,NULL,'2011-02-05 12:26:42','system',NULL,NULL,NULL),(135,192,1,360,'',NULL,NULL,0,NULL,NULL,'2011-02-05 12:46:23','system',NULL,NULL,NULL),(136,193,1,361,'',NULL,NULL,0,NULL,NULL,'2011-02-05 12:48:10','system',NULL,NULL,NULL),(137,194,1,362,'',NULL,NULL,0,NULL,NULL,'2011-02-05 12:50:37','system',NULL,NULL,NULL),(138,195,1,363,'',NULL,NULL,0,NULL,NULL,'2011-02-05 12:56:59','system',NULL,NULL,NULL),(140,197,1,365,'',NULL,NULL,0,NULL,NULL,'2011-02-05 13:01:49','system',NULL,NULL,NULL),(141,198,1,366,'',NULL,NULL,0,NULL,NULL,'2011-02-05 13:05:09','system',NULL,NULL,NULL),(142,199,3,367,'',NULL,NULL,1,NULL,NULL,'2011-02-05 13:20:42','system','sumanth','more','sumanth more'),(143,200,4,366,'',NULL,NULL,1,NULL,NULL,'2011-02-05 13:33:10','system','raghu','sales Reprasentative','Basaveshvar nagar'),(144,201,3,369,'',NULL,NULL,1,NULL,NULL,'2011-02-08 07:38:15','system','Roshan','Kumar','Roshan Kumar'),(145,202,3,370,'',NULL,NULL,0,NULL,NULL,'2011-02-08 11:53:52','system','Vinod','C.V.','Vinod C.V.'),(146,203,3,371,'',NULL,NULL,0,NULL,NULL,'2011-02-08 12:04:38','system','Amir','Khan','Amir Khan'),(147,204,1,372,'',NULL,NULL,0,NULL,NULL,'2011-02-08 14:27:31','system','Xchanging','Xchanging','Xchanging'),(148,205,3,373,'',NULL,NULL,0,NULL,NULL,'2011-02-08 14:29:37','system','Arvind','Kumar','Arvind Kumar'),(149,206,1,374,'',NULL,NULL,0,NULL,NULL,'2011-02-08 14:32:42','system',NULL,NULL,NULL),(150,207,1,146,'',NULL,NULL,2,NULL,NULL,'2011-02-09 12:31:10','system','Somsaker','Manager','Cricuit City Hydrabad'),(151,208,1,140,'',NULL,NULL,3,'admin@firm.com','2011-03-29 09:21:52','2011-02-11 06:47:30','system',NULL,NULL,'Sankar MAtt'),(152,209,3,375,'',NULL,NULL,1,NULL,NULL,'2011-02-11 07:06:33','system','Shaker','Suman','Shaker Suman'),(153,210,2,12,'\0',NULL,NULL,1,NULL,'2011-02-11 09:02:10','2011-02-11 09:01:54','system','Sai Kumar','Manager','Banglore'),(154,211,1,156,'',NULL,NULL,3,'sue treen','2011-03-22 11:54:54','2011-02-11 12:06:59','system','Manoj','E','Don Bosko'),(155,212,3,376,'',NULL,NULL,22,NULL,NULL,'2011-02-11 12:08:53','system','Deepak','D','Deepak D'),(156,213,3,377,'',NULL,NULL,1,NULL,NULL,'2011-02-11 12:10:42','system','Rajendra','Reddy','Rajendra Reddy'),(157,214,1,378,'',NULL,NULL,0,NULL,NULL,'2011-02-14 06:39:50','system',NULL,NULL,NULL),(158,215,1,379,'',NULL,NULL,0,NULL,NULL,'2011-02-14 07:17:48','system',NULL,NULL,NULL),(159,216,1,380,'',NULL,NULL,1,NULL,NULL,'2011-02-14 09:07:01','system','JLC soft','JLC soft','JLC soft'),(160,217,3,381,'',NULL,NULL,1,NULL,NULL,'2011-02-14 09:08:13','system','Karthik','','Karthik '),(161,218,1,382,'',NULL,NULL,0,NULL,NULL,'2011-02-14 09:09:39','system',NULL,NULL,NULL),(162,246,3,383,'',NULL,NULL,10,NULL,NULL,'2011-02-18 14:52:24','system','Deepak','W','Deepak W'),(163,247,3,384,'',NULL,NULL,1,NULL,NULL,'2011-02-21 06:39:02','system','Deepak','D','Deepak D'),(164,248,2,12,'',NULL,NULL,0,NULL,NULL,'2011-02-21 07:33:38','system','Sai Kumar','Manager','Banglore'),(165,249,2,12,'',NULL,NULL,0,NULL,NULL,'2011-02-21 07:35:52','system','Sai Kumar','CEO','Blank Rome HO'),(166,250,3,12,'',NULL,NULL,1,NULL,NULL,'2011-02-21 07:36:52','system','Sai Kumar','CEO','Sagar'),(167,251,3,12,'',NULL,NULL,0,NULL,NULL,'2011-02-21 07:37:53','system','Sallu','CEO','Main'),(168,252,4,12,'',NULL,NULL,0,NULL,NULL,'2011-02-21 07:39:11','system','Sai Kumar','Manager','Test'),(169,253,2,12,'',NULL,NULL,0,NULL,NULL,'2011-02-21 07:51:18','system','Somsaker','Manager','Washington DC site'),(171,256,1,386,'',NULL,NULL,2,NULL,NULL,'2011-02-26 10:21:22','system','Tranfer India','Tranfer India','Tranfer India'),(172,257,3,387,'',NULL,NULL,1,NULL,NULL,'2011-02-26 10:38:07','system','Ramayana','','Ramayana '),(173,258,3,388,'',NULL,NULL,2,NULL,NULL,'2011-02-26 10:45:35','system','Sita','Priya','Sita Priya'),(176,266,3,391,'',NULL,NULL,0,NULL,NULL,'2011-02-28 10:39:27','system','Tanveer','','Tanveer '),(178,268,1,393,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:32:22','system','Accenture','Accenture','Accenture'),(179,269,3,394,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:41:55','system','Flapini','','Flapini '),(180,270,3,395,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:46:50','system','Preety','','Preety '),(181,271,3,396,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:49:10','system','Preety','','Preety '),(182,272,3,397,'',NULL,NULL,0,NULL,NULL,'2011-02-28 13:51:10','system','Preety','','Preety '),(183,273,3,398,'',NULL,NULL,0,NULL,NULL,'2011-02-28 14:02:40','system','Durva','','Durva '),(185,275,2,146,'',NULL,NULL,0,NULL,NULL,'2011-03-01 05:22:35','system',NULL,NULL,'Kamal Nagar'),(186,276,3,399,'',NULL,NULL,0,NULL,NULL,'2011-03-01 07:12:20','system','Tanveer','William','Tanveer William'),(187,277,3,400,'',NULL,NULL,0,NULL,NULL,'2011-03-01 07:39:41','system','Shanti','','Shanti '),(188,278,1,149,'',NULL,NULL,0,NULL,NULL,'2011-03-01 07:53:28','system',NULL,NULL,NULL),(189,279,2,149,'',NULL,NULL,0,NULL,NULL,'2011-03-01 07:54:19','system',NULL,NULL,'Kamal Nagar'),(190,280,2,149,'',NULL,NULL,0,NULL,NULL,'2011-03-01 08:05:53','system',NULL,NULL,'Kamal Nagar'),(191,282,1,401,'',NULL,NULL,0,NULL,NULL,'2011-03-02 06:24:49','system',NULL,NULL,NULL),(192,283,1,402,'',NULL,NULL,0,NULL,NULL,'2011-03-02 06:31:58','system',NULL,NULL,NULL),(193,284,1,403,'',NULL,NULL,0,NULL,NULL,'2011-03-02 07:24:49','system','Xchanging','Xchanging','Xchanging'),(194,285,3,404,'',NULL,NULL,1,NULL,NULL,'2011-03-02 10:45:37','system','Shanti','','Shanti '),(195,286,1,405,'',NULL,NULL,0,NULL,NULL,'2011-03-07 08:47:46','system',NULL,NULL,NULL),(196,287,3,406,'',NULL,NULL,0,NULL,NULL,'2011-03-15 13:29:29','system','Preety','','Preety '),(197,288,3,407,'',NULL,NULL,0,NULL,NULL,'2011-03-15 13:39:11','system','Shanti','','Shanti '),(198,289,2,12,'',NULL,NULL,0,NULL,NULL,'2011-03-15 13:41:47','system',NULL,NULL,'Kamal Nagar'),(199,290,2,104,'',NULL,NULL,0,NULL,NULL,'2011-03-15 13:48:28','system',NULL,NULL,'Sai Devepemets'),(200,293,1,408,'',NULL,NULL,0,NULL,NULL,'2011-03-22 04:06:39','system','Neema Pvt Lmt','Neema Pvt Lmt','Neema Pvt Lmt'),(201,294,1,409,'',NULL,NULL,1,NULL,NULL,'2011-03-24 05:18:32','Sagar',NULL,NULL,NULL),(202,295,1,410,'',NULL,NULL,2,'kotragoud','2011-03-24 07:35:07','2011-03-24 07:32:44','system',NULL,NULL,NULL),(203,296,3,411,'',NULL,NULL,2,'karthik@jlc.com','2011-03-26 07:12:41','2011-03-26 07:12:31','karthik@jlc.com','Sachin','Tendulkar','Sachin Tendulkar');
/*!40000 ALTER TABLE `party_site` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) NOT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_title` varchar(50) DEFAULT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `phone_indicator` bit(1) DEFAULT NULL,
  `sub_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkeeac7ad76dd29fe7` (`party_site_id`),
  KEY `fk_party_site_communication_for_communication_type` (`communication_type`),
  KEY `fk_party_site_communication_is_for_party` (`party_id`),
  CONSTRAINT `fk_party_site_communication_for_communication_type` FOREIGN KEY (`communication_type`) REFERENCES `communication_type` (`id`),
  CONSTRAINT `fk_party_site_communication_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_party_site_communication_is_for_party_site` FOREIGN KEY (`party_site_id`) REFERENCES `party_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_site_communication`
--

LOCK TABLES `party_site_communication` WRITE;
/*!40000 ALTER TABLE `party_site_communication` DISABLE KEYS */;
INSERT INTO `party_site_communication` VALUES (76,3,3,'1-888-9867',NULL,NULL,0,'','2010-09-11 06:30:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(77,1,3,'boa@boa.com',NULL,NULL,0,'','2010-09-11 06:30:41','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(80,3,NULL,'1-888-9867',NULL,NULL,0,'','2010-09-13 10:37:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(81,1,NULL,'boa@boa.com',NULL,NULL,0,'','2010-09-13 10:37:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(82,2,NULL,'888-345-4567',NULL,NULL,0,'','2010-09-13 10:37:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(83,7,NULL,'boa.com',NULL,NULL,0,'','2010-09-13 10:37:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(142,3,70,'703-111-1235',NULL,NULL,0,'','2010-09-23 04:37:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(143,1,70,'james@jam.com',NULL,NULL,0,'','2010-09-23 04:37:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(144,2,70,'888-999-1234',NULL,NULL,0,'','2010-09-23 04:37:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(145,7,70,'www.hopewell.com',NULL,NULL,0,'','2010-09-23 04:37:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(146,3,71,'703-222-2346',NULL,NULL,0,'','2010-09-23 04:39:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(147,1,71,'jones_smith@boa.com',NULL,NULL,0,'','2010-09-23 04:39:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(148,2,71,'703-111-1234',NULL,NULL,0,'','2010-09-23 04:39:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(149,7,71,'www.capiltalone.com',NULL,NULL,0,'','2010-09-23 04:39:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(150,3,72,'888-999-1234',NULL,NULL,0,'','2010-09-24 03:28:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(151,1,72,'john_caravan@boa.com',NULL,NULL,0,'','2010-09-24 03:28:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(152,2,72,'703-111-1234',NULL,NULL,0,'','2010-09-24 03:28:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(153,7,72,'www.citi.com',NULL,NULL,0,'','2010-09-24 03:28:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(154,3,73,'703-111-1235',NULL,NULL,0,'','2010-09-25 14:25:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(155,1,73,'jones_smith@boa.com',NULL,NULL,0,'','2010-09-25 14:25:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(156,2,73,'703-111-1234',NULL,NULL,0,'','2010-09-25 14:25:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(157,7,73,'www.bn.com',NULL,NULL,0,'','2010-09-25 14:25:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(158,5,73,'999-123-4567',NULL,NULL,0,'','2010-09-25 14:25:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(159,3,74,'888-999-1234',NULL,NULL,0,'','2010-09-26 11:44:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(160,1,74,'james@jam.com',NULL,NULL,0,'','2010-09-26 11:44:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(161,2,74,'703-111-1234',NULL,NULL,0,'','2010-09-26 11:44:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(162,7,74,'www.james.com',NULL,NULL,0,'','2010-09-26 11:44:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(163,3,75,'703-111-1235',NULL,NULL,0,'','2010-09-29 03:09:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(164,1,75,'jones_smith@metlife.com',NULL,NULL,1,'','2010-09-29 03:09:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(165,2,75,'703-111-1234',NULL,NULL,0,'','2010-09-29 03:09:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(166,7,75,'www.metlife.com',NULL,NULL,1,'','2010-09-29 03:09:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(167,3,76,'703-111-1235',NULL,NULL,0,'','2010-09-30 02:23:28','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(168,1,76,'allen@cibc.com',NULL,NULL,0,'','2010-09-30 02:23:28','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(169,2,76,'888-345-0987',NULL,NULL,0,'','2010-09-30 02:23:28','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(170,7,76,'www.cibc.com',NULL,NULL,0,'','2010-09-30 02:23:28','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(171,3,77,'888-999-1234',NULL,NULL,0,'','2010-09-30 04:22:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(172,1,77,'mm@mellon.com',NULL,NULL,0,'','2010-09-30 04:22:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(173,2,77,'888-999-1234',NULL,NULL,0,'','2010-09-30 04:22:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(174,7,77,'www.capiltalone.com',NULL,NULL,0,'','2010-09-30 04:22:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(175,3,78,'888-999-1234',NULL,NULL,0,'','2010-10-07 05:36:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(176,1,78,'ed@metlife.com',NULL,NULL,0,'','2010-10-07 05:36:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(177,2,78,'888-999-1234',NULL,NULL,0,'','2010-10-07 05:36:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(178,7,78,'www.metlife.com',NULL,NULL,0,'','2010-10-07 05:36:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(179,3,79,'111-456-9078',NULL,NULL,0,'','2010-10-08 22:20:34','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(180,1,79,'george@aig.com',NULL,NULL,0,'','2010-10-08 22:20:34','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(181,2,79,'111-234-4567',NULL,NULL,0,'','2010-10-08 22:20:34','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(182,7,79,'www.aig.com',NULL,NULL,0,'','2010-10-08 22:20:34','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(183,3,80,'888-999-1234',NULL,NULL,0,'','2010-10-09 01:08:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(184,1,80,'james@ing.com',NULL,NULL,0,'','2010-10-09 01:08:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(185,2,80,'111-234-9999',NULL,NULL,0,'','2010-10-09 01:08:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(186,7,80,'ing.com',NULL,NULL,0,'','2010-10-09 01:08:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(187,3,81,'703-999-1234',NULL,NULL,0,'','2010-10-10 10:28:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(188,1,81,'joe_guntia@blank.rmoe.com',NULL,NULL,0,'','2010-10-10 10:28:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(189,2,81,'111-333-2345',NULL,NULL,0,'','2010-10-10 10:28:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(190,7,81,'www.blankromeo.com',NULL,NULL,0,'','2010-10-10 10:28:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(191,3,82,' (703) 256-1300',NULL,NULL,0,'','2010-10-10 11:01:22','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(192,1,82,'becker@becker.com',NULL,NULL,0,'','2010-10-10 11:01:22','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(193,2,82,'703-111-1234',NULL,NULL,0,'','2010-10-10 11:01:22','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(194,7,82,'www.becker.com',NULL,NULL,0,'','2010-10-10 11:01:22','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(207,1,84,'rajesh@gmail.com',NULL,NULL,2,'','2010-11-30 06:14:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(208,2,84,'12456378',NULL,NULL,0,'','2010-11-30 06:14:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(209,7,84,'www.default.com',NULL,NULL,0,'','2010-11-30 06:14:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(210,3,84,'7687687687',NULL,NULL,0,'','2010-11-30 06:14:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(220,4,84,'9988698999',NULL,NULL,1,'','2010-11-30 10:04:51','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(225,1,90,'annette@gmail.com',NULL,NULL,0,'','2010-12-02 07:34:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(226,2,90,'12456378',NULL,NULL,0,'','2010-12-02 07:34:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(227,7,90,'www.default.com',NULL,NULL,0,'','2010-12-02 07:34:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(228,3,90,'4444444',NULL,NULL,0,'','2010-12-02 07:34:24','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(233,1,91,'maurice@gmail.com',NULL,NULL,0,'','2010-12-03 15:23:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(234,2,91,'465878',NULL,NULL,0,'','2010-12-03 15:23:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(235,7,91,'www.default.com',NULL,NULL,0,'','2010-12-03 15:23:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(236,3,91,'1246378987',NULL,NULL,0,'','2010-12-03 15:23:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(237,4,91,'43543543543',NULL,NULL,0,'','2010-12-03 15:23:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(238,1,88,'sagar@gmail.com',NULL,NULL,0,'','2010-12-21 13:01:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(239,2,88,'12451245',NULL,NULL,1,'','2010-12-21 13:01:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(240,7,88,'www.default.com',NULL,NULL,0,'','2010-12-21 13:01:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(241,3,88,'9986599865',NULL,NULL,2,'','2010-12-21 13:01:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(243,1,92,'thomas@gmail.com',NULL,NULL,0,'','2010-12-21 13:04:57','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(244,2,92,'12345678',NULL,NULL,0,'','2010-12-21 13:04:57','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(245,7,92,'www.default.com',NULL,NULL,0,'','2010-12-21 13:04:57','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(246,4,92,'9986512345',NULL,NULL,0,'','2010-12-21 13:04:57','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(248,3,92,'9988698999',NULL,NULL,0,'','2010-12-21 13:55:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(249,4,88,'0806565658',NULL,NULL,2,'','2010-12-28 07:15:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(262,5,96,'3325345452',NULL,NULL,1,'','2011-01-25 10:38:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(263,1,96,'sai@gmail.com',NULL,NULL,0,'','2011-01-25 10:38:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(264,2,96,'2431243',NULL,NULL,0,'','2011-01-25 10:38:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(265,7,96,'www@xyz.com',NULL,NULL,0,'','2011-01-25 10:38:08','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(286,1,25,'Jones@gmail.com',NULL,NULL,0,'','2011-01-26 15:36:56','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(287,2,25,'',NULL,NULL,0,'','2011-01-26 15:36:56','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(288,7,25,'',NULL,NULL,0,'','2011-01-26 15:36:56','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(289,3,25,'1234567890',NULL,NULL,0,'','2011-01-26 15:36:56','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(302,3,96,'',NULL,NULL,0,'','2011-01-28 08:42:37','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(303,1,103,'elvin@rediffmail.com',NULL,NULL,0,'','2011-01-28 09:09:03','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(304,2,103,'',NULL,NULL,0,'','2011-01-28 09:09:03','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(305,7,103,'www.default.com',NULL,NULL,0,'','2011-01-28 09:09:03','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(306,4,103,'9986512345',NULL,NULL,0,'','2011-01-28 09:09:03','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(311,3,104,'8002345678',NULL,NULL,0,'','2011-01-28 11:58:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(312,1,104,'suntrust@gmail.com',NULL,NULL,0,'','2011-01-28 11:58:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(313,2,104,'18002345678',NULL,NULL,0,'','2011-01-28 11:58:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(314,7,104,'suntrust@gmail.com',NULL,NULL,0,'','2011-01-28 11:58:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(323,1,107,'',NULL,NULL,0,'','2011-01-29 12:22:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(324,2,107,'',NULL,NULL,0,'','2011-01-29 12:22:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(325,7,107,'www.default.com',NULL,NULL,0,'','2011-01-29 12:22:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(326,3,107,'',NULL,NULL,0,'','2011-01-29 12:22:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(327,3,108,'4353453453',NULL,NULL,0,'','2011-01-29 12:52:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(328,1,108,'chiguru@gmail.com',NULL,NULL,0,'','2011-01-29 12:52:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(329,2,108,'4543534534',NULL,NULL,0,'','2011-01-29 12:52:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(330,7,108,'www.default.com',NULL,NULL,0,'','2011-01-29 12:52:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(331,1,65,'',NULL,NULL,0,'','2011-01-30 05:27:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(332,2,65,'',NULL,NULL,0,'','2011-01-30 05:27:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(333,7,65,'',NULL,NULL,0,'','2011-01-30 05:27:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(334,3,65,'',NULL,NULL,0,'','2011-01-30 05:27:17','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(335,1,43,'',NULL,NULL,0,'','2011-01-30 05:28:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(336,2,43,'',NULL,NULL,0,'','2011-01-30 05:28:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(337,7,43,'',NULL,NULL,0,'','2011-01-30 05:28:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(338,3,43,'',NULL,NULL,0,'','2011-01-30 05:28:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(343,3,109,'9916899999',NULL,NULL,0,'','2011-01-31 13:09:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(344,1,109,'punit@gmail.com',NULL,NULL,0,'','2011-01-31 13:09:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(345,2,109,'4543534534',NULL,NULL,0,'','2011-01-31 13:09:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(346,7,109,'www.default.com',NULL,NULL,0,'','2011-01-31 13:09:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(347,3,110,'9916899999',NULL,NULL,0,'','2011-01-31 13:53:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(348,1,110,'geeta@gmail.com',NULL,NULL,0,'','2011-01-31 13:53:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(349,2,110,'4543534534',NULL,NULL,0,'','2011-01-31 13:53:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(350,7,110,'www.default.com',NULL,NULL,0,'','2011-01-31 13:53:00','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(351,3,111,'9916899999',NULL,NULL,0,'','2011-01-31 14:08:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(352,1,111,'sampath@gmail.com',NULL,NULL,0,'','2011-01-31 14:08:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(353,2,111,'4543534534',NULL,NULL,0,'','2011-01-31 14:08:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(354,7,111,'www.default.com',NULL,NULL,0,'','2011-01-31 14:08:32','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(355,4,114,'9916899999',NULL,NULL,0,'','2011-02-01 04:32:30','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(356,1,114,'kiran@gmail.com',NULL,NULL,0,'','2011-02-01 04:32:30','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(357,2,114,'0802355422',NULL,NULL,0,'','2011-02-01 04:32:30','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(358,7,114,'www.default.com',NULL,NULL,0,'','2011-02-01 04:32:30','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(359,3,115,'9916899999',NULL,NULL,0,'','2011-02-01 05:34:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(360,1,115,'guru@gmail.com',NULL,NULL,0,'','2011-02-01 05:34:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(361,2,115,'4543534534',NULL,NULL,0,'','2011-02-01 05:34:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(362,7,115,'www.default.com',NULL,NULL,0,'','2011-02-01 05:34:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(363,3,116,'9916899999',NULL,NULL,0,'','2011-02-01 05:38:41','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(364,1,116,'prasad@gmail.com',NULL,NULL,0,'','2011-02-01 05:38:41','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(365,2,116,'0802355422',NULL,NULL,0,'','2011-02-01 05:38:41','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(366,7,116,'www.default.com',NULL,NULL,0,'','2011-02-01 05:38:41','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(367,3,117,'9916899999',NULL,NULL,0,'','2011-02-02 04:27:16','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(368,1,117,'krishna@gmail.com',NULL,NULL,0,'','2011-02-02 04:27:16','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(369,2,117,'4543534534',NULL,NULL,0,'','2011-02-02 04:27:16','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(370,7,117,'www.default.com',NULL,NULL,0,'','2011-02-02 04:27:16','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(375,3,119,'9916899999',NULL,NULL,0,'','2011-02-02 08:59:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(376,1,119,'guru@yahoomail.com',NULL,NULL,0,'','2011-02-02 08:59:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(377,2,119,'4543534534',NULL,NULL,0,'','2011-02-02 08:59:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(378,7,119,'www.default.com',NULL,NULL,0,'','2011-02-02 08:59:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(391,3,128,'8002345678',NULL,NULL,0,'','2011-02-04 13:12:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(392,1,128,'sallu@gmail.com',NULL,NULL,0,'','2011-02-04 13:12:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(393,2,128,'18002345678',NULL,NULL,0,'','2011-02-04 13:12:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(394,7,128,'sallu.gmial.com',NULL,NULL,0,'','2011-02-04 13:12:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(395,1,126,'professional@gmail.com',NULL,NULL,0,'','2011-02-04 13:13:26','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(396,2,126,'12345678',NULL,NULL,0,'','2011-02-04 13:13:26','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(397,7,126,'www.Jones.com',NULL,NULL,0,'','2011-02-04 13:13:26','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(398,3,126,'9916891168',NULL,NULL,0,'','2011-02-04 13:13:26','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(399,3,129,'8002345678',NULL,NULL,0,'','2011-02-04 13:16:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(400,1,129,'sallu@gmail.com',NULL,NULL,0,'','2011-02-04 13:16:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(401,2,129,'18002345678',NULL,NULL,0,'','2011-02-04 13:16:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(402,7,129,'9916891168',NULL,NULL,0,'','2011-02-04 13:16:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(407,3,130,'9916899999',NULL,NULL,0,'','2011-02-05 08:00:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(408,1,130,'dhaksha@chiguru.com',NULL,NULL,0,'','2011-02-05 08:00:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(409,2,130,'4543534534',NULL,NULL,0,'','2011-02-05 08:00:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(410,7,130,'www.default.com',NULL,NULL,0,'','2011-02-05 08:00:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(411,3,131,'9916899999',NULL,NULL,0,'','2011-02-05 08:10:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(412,1,131,'dhaksha34@chiguru.com',NULL,NULL,1,'','2011-02-05 08:10:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(413,2,131,'4543534534',NULL,NULL,0,'','2011-02-05 08:10:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(414,7,131,'www.default.com',NULL,NULL,0,'','2011-02-05 08:10:36','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(415,3,132,'9916899999',NULL,NULL,0,'','2011-02-05 08:11:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(416,1,132,'dhaksha1@chiguru.com',NULL,NULL,0,'','2011-02-05 08:11:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(417,2,132,'4543534534',NULL,NULL,0,'','2011-02-05 08:11:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(418,7,132,'www.default.com',NULL,NULL,0,'','2011-02-05 08:11:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(423,3,143,'2554889',NULL,NULL,1,'','2011-02-05 13:33:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(424,1,143,'raghu@gmail.com',NULL,NULL,0,'','2011-02-05 13:33:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(425,2,143,'124563',NULL,NULL,0,'','2011-02-05 13:33:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(426,7,143,'www.gmail.com',NULL,NULL,0,'','2011-02-05 13:33:10','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(427,3,143,'',NULL,NULL,0,'','2011-02-05 13:34:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(433,3,145,'9916899999',NULL,NULL,0,'','2011-02-08 11:53:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(434,1,145,'vinod@yahoo.com',NULL,NULL,0,'','2011-02-08 11:53:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(435,2,145,'4543534534',NULL,NULL,0,'','2011-02-08 11:53:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(436,7,145,'www.default.com',NULL,NULL,0,'','2011-02-08 11:53:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(437,3,146,'9916899999',NULL,NULL,0,'','2011-02-08 12:04:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(438,1,146,'amir@chiguru.com',NULL,NULL,0,'','2011-02-08 12:04:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(439,2,146,'4543534534',NULL,NULL,0,'','2011-02-08 12:04:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(440,7,146,'www.default.com',NULL,NULL,0,'','2011-02-08 12:04:39','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(445,3,147,'9916899999',NULL,NULL,0,'','2011-02-08 14:27:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(446,1,147,'xchanging@gmail.com',NULL,NULL,0,'','2011-02-08 14:27:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(447,2,147,'4543534534',NULL,NULL,0,'','2011-02-08 14:27:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(448,7,147,'www.default.com',NULL,NULL,0,'','2011-02-08 14:27:31','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(449,3,148,'9916899999',NULL,NULL,0,'','2011-02-08 14:29:37','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(450,1,148,'arvind@gmail.com',NULL,NULL,0,'','2011-02-08 14:29:37','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(451,2,148,'4543534534',NULL,NULL,0,'','2011-02-08 14:29:37','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(452,7,148,'www.default.com',NULL,NULL,0,'','2011-02-08 14:29:37','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(453,1,5,'jonn@gmail.com',NULL,NULL,1,'','2011-02-09 05:35:06','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(454,2,5,'12456378',NULL,NULL,1,'','2011-02-09 05:35:06','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(455,7,5,'www.default.com',NULL,NULL,0,'','2011-02-09 05:35:06','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(456,3,5,'2222222',NULL,NULL,1,'','2011-02-09 05:35:06','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(457,3,153,'',NULL,NULL,0,'','2011-02-11 09:01:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(458,1,153,'saiKumar@gmail.com',NULL,NULL,0,'','2011-02-11 09:01:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(459,2,153,'18002345678',NULL,NULL,0,'','2011-02-11 09:01:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(460,7,153,'',NULL,NULL,0,'','2011-02-11 09:01:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(461,1,150,'circuit@gmail.com',NULL,NULL,0,'','2011-02-11 09:16:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(462,2,150,'',NULL,NULL,0,'','2011-02-11 09:16:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(463,7,150,'',NULL,NULL,0,'','2011-02-11 09:16:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(464,3,150,'1234567890',NULL,NULL,0,'','2011-02-11 09:16:12','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(489,1,154,'woodlands@yahoo.com',NULL,NULL,0,'','2011-02-11 13:18:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(490,2,154,'12345678',NULL,NULL,0,'','2011-02-11 13:18:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(491,7,154,'www.woodlands.com',NULL,NULL,0,'','2011-02-11 13:18:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(492,3,154,'9916891168',NULL,NULL,0,'','2011-02-11 13:18:23','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(497,1,155,'deepak@gmail.com',NULL,NULL,0,'','2011-02-14 07:30:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(498,2,155,'12456378',NULL,NULL,0,'','2011-02-14 07:30:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(499,7,155,'www.default.com',NULL,NULL,0,'','2011-02-14 07:30:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(500,3,155,'7687687687',NULL,NULL,0,'','2011-02-14 07:30:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(501,3,159,'9916899999',NULL,NULL,0,'','2011-02-14 09:07:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(502,1,159,'jlc@gmail.com',NULL,NULL,0,'','2011-02-14 09:07:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(503,2,159,'4543534534',NULL,NULL,0,'','2011-02-14 09:07:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(504,7,159,'www.default.com',NULL,NULL,0,'','2011-02-14 09:07:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(505,3,160,'9916899999',NULL,NULL,0,'','2011-02-14 09:08:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(506,1,160,'karthik@jlc.com',NULL,NULL,0,'','2011-02-14 09:08:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(507,2,160,'4543534534',NULL,NULL,0,'','2011-02-14 09:08:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(508,7,160,'www.default.com',NULL,NULL,0,'','2011-02-14 09:08:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(509,4,155,'9988698745',NULL,NULL,0,'','2011-02-14 14:25:09','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(514,3,163,'9916899999',NULL,NULL,0,'','2011-02-21 06:39:02','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(515,1,163,'guru@gmail.com',NULL,NULL,0,'','2011-02-21 06:39:02','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(516,2,163,'0802355422',NULL,NULL,0,'','2011-02-21 06:39:02','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(517,7,163,'www.default.com',NULL,NULL,0,'','2011-02-21 06:39:02','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(518,3,164,'',NULL,NULL,0,'','2011-02-21 07:33:38','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(519,1,164,'',NULL,NULL,0,'','2011-02-21 07:33:38','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(520,2,164,'',NULL,NULL,0,'','2011-02-21 07:33:38','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(521,7,164,'',NULL,NULL,0,'','2011-02-21 07:33:38','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(522,3,165,'8002345678',NULL,NULL,0,'','2011-02-21 07:35:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(523,1,165,'sai@gmail.com',NULL,NULL,0,'','2011-02-21 07:35:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(524,2,165,'18002345678',NULL,NULL,0,'','2011-02-21 07:35:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(525,7,165,'sallu.gmial.com',NULL,NULL,0,'','2011-02-21 07:35:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(526,3,166,'8002345678',NULL,NULL,0,'','2011-02-21 07:36:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(527,1,166,'sai@gmail.com',NULL,NULL,0,'','2011-02-21 07:36:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(528,2,166,'18002345678',NULL,NULL,0,'','2011-02-21 07:36:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(529,7,166,'www.gmail.com',NULL,NULL,0,'','2011-02-21 07:36:52','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(530,3,167,'8002345678',NULL,NULL,0,'','2011-02-21 07:37:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(531,1,167,'sai@gmail.com',NULL,NULL,0,'','2011-02-21 07:37:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(532,2,167,'18002345678',NULL,NULL,0,'','2011-02-21 07:37:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(533,7,167,'www.icici.com',NULL,NULL,0,'','2011-02-21 07:37:54','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(534,3,168,'8002345678',NULL,NULL,0,'','2011-02-21 07:39:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(535,1,168,'sai@gmail.com',NULL,NULL,0,'','2011-02-21 07:39:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(536,2,168,'18002345678',NULL,NULL,0,'','2011-02-21 07:39:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(537,7,168,'www.icici.com',NULL,NULL,0,'','2011-02-21 07:39:11','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(538,3,169,'8002345678',NULL,NULL,0,'','2011-02-21 07:51:18','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(539,1,169,'sai@gmail.com',NULL,NULL,0,'','2011-02-21 07:51:18','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(540,2,169,'18002345678',NULL,NULL,0,'','2011-02-21 07:51:18','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(541,7,169,'www.icici.com',NULL,NULL,0,'','2011-02-21 07:51:18','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(553,5,171,'2222',NULL,NULL,0,'','2011-02-26 10:21:24','system','2011-02-26 10:21:24','system',NULL,NULL,NULL,NULL,3),(554,5,171,'2222',NULL,NULL,1,'','2011-02-26 10:22:09','system',NULL,'system',NULL,NULL,NULL,NULL,5),(555,5,171,'2222',NULL,NULL,0,'','2011-02-26 10:22:09','system',NULL,'system',NULL,NULL,NULL,NULL,4),(556,1,171,'transfor@gmail.com',NULL,NULL,0,'','2011-02-26 10:21:24','system','2011-02-26 10:21:24','system',NULL,NULL,NULL,NULL,NULL),(557,2,171,'23455',NULL,NULL,0,'','2011-02-26 10:21:24','system','2011-02-26 10:21:24','system',NULL,NULL,NULL,NULL,NULL),(558,7,171,'www.default.com',NULL,NULL,0,'','2011-02-26 10:21:24','system','2011-02-26 10:21:24','system',NULL,NULL,NULL,NULL,NULL),(559,5,172,'1111',NULL,NULL,1,'','2011-02-26 10:38:07','system','2011-02-26 10:38:07','system',NULL,NULL,NULL,NULL,3),(560,5,172,'1111',NULL,NULL,1,'','2011-02-26 10:38:07','system',NULL,'system',NULL,NULL,NULL,NULL,4),(561,1,172,'ramayan@gmail.com',NULL,NULL,0,'','2011-02-26 10:38:07','system','2011-02-26 10:38:07','system',NULL,NULL,NULL,NULL,NULL),(562,2,172,'23455',NULL,NULL,0,'','2011-02-26 10:38:07','system','2011-02-26 10:38:07','system',NULL,NULL,NULL,NULL,NULL),(563,7,172,'www.default.com',NULL,NULL,0,'','2011-02-26 10:38:07','system','2011-02-26 10:38:07','system',NULL,NULL,NULL,NULL,NULL),(571,1,NULL,'deepak',NULL,NULL,0,'','2011-02-26 10:54:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(572,2,NULL,'5555',NULL,NULL,0,'','2011-02-26 10:54:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(573,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 10:54:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(576,1,NULL,'punit@gmail.com',NULL,NULL,0,'','2011-02-26 10:55:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(577,2,NULL,'4543534534',NULL,NULL,0,'','2011-02-26 10:55:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(578,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 10:55:14','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(579,1,NULL,'deepak@gmail.com',NULL,NULL,0,'','2011-02-26 11:02:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(580,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 11:02:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(581,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 11:02:58','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(584,1,NULL,'deepak@gmail.com',NULL,NULL,0,'','2011-02-26 11:04:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(585,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 11:04:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(586,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 11:04:01','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(587,1,NULL,'deepak@gmail.com',NULL,NULL,0,'','2011-02-26 11:18:53','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(588,2,NULL,'6666',NULL,NULL,0,'','2011-02-26 11:18:53','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(589,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 11:18:53','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(590,5,162,'5555',NULL,NULL,0,'','2011-02-26 11:54:04','system','2011-02-26 11:54:04','system',NULL,NULL,NULL,NULL,3),(591,5,162,'5555',NULL,NULL,0,'','2011-02-26 11:54:04','system',NULL,'system',NULL,NULL,NULL,NULL,4),(592,1,NULL,'deepak@gmail.com',NULL,NULL,0,'','2011-02-26 11:54:04','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(593,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 11:54:04','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(594,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 11:54:04','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(595,1,NULL,'deepak@gmail.com',NULL,NULL,0,'','2011-02-26 11:54:42','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(596,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 11:54:42','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(597,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 11:54:42','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(598,1,NULL,'verma@yahoo.com',NULL,NULL,0,'','2011-02-26 12:02:19','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(599,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 12:02:19','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(600,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 12:02:19','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(601,1,NULL,'verma@yahoo.com',NULL,NULL,0,'','2011-02-26 12:05:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(602,2,NULL,'23455',NULL,NULL,0,'','2011-02-26 12:05:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL),(603,7,NULL,'www.default.com',NULL,NULL,0,'','2011-02-26 12:05:46','system',NULL,'system',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `party_site_communication` ENABLE KEYS */;
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
INSERT INTO `party_site_type` VALUES (1,'MAIN OFFICE','Office Address','2010-08-06 02:09:18','system','system','2010-08-06 02:09:33',0,'',''),(2,'BRANCH OFFICE','Branch Office','2010-08-06 02:09:18','system','system','2010-08-06 02:09:18',0,'\0',''),(3,'HOME','Home','2010-08-06 02:09:18','system','system','2010-08-06 02:09:18',0,'\0',''),(4,'SALES OFFICE','Sales Office Address','2010-08-06 02:09:18','system','system','2010-08-06 02:09:33',0,'\0',''),(5,'FACTORY SITE','Factory Site Address','2010-08-06 02:09:18','system','system','2010-08-06 02:09:33',0,'\0',''),(6,'FRANCHISE OFFICE','Franchise Office Address','2010-08-06 02:09:18','system','system','2010-08-06 02:09:33',0,'\0',''),(7,'CUSTOMER SERVICE OFFICE','Customer Service Address','2010-08-06 02:09:18','system','system','2010-08-06 02:09:33',0,'\0',''),(8,'AGENCY OFFICE','Agency Office','2010-08-06 02:09:18','system','system','2010-08-06 02:09:18',0,'\0','');
/*!40000 ALTER TABLE `party_site_type` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_type`
--

LOCK TABLES `party_type` WRITE;
/*!40000 ALTER TABLE `party_type` DISABLE KEYS */;
INSERT INTO `party_type` VALUES (1,'person','','2010-06-17 02:32:44','system','system','2010-06-17 02:32:54',NULL),(2,'organization','','2010-06-17 02:32:44','system','system','2010-06-17 02:32:54',NULL);
/*!40000 ALTER TABLE `party_type` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
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
INSERT INTO `person` VALUES (2,'Rajesh','raniga',NULL,NULL,'1985-03-12',2,0,NULL,NULL),(3,'maurice','freer','l.',NULL,'1984-01-01',2,0,NULL,NULL),(4,'joan','anderson',NULL,NULL,NULL,NULL,0,NULL,NULL),(5,'kim','caine',NULL,NULL,NULL,NULL,0,NULL,NULL),(6,'sue','treen',NULL,NULL,'2010-01-01',1,0,NULL,NULL),(7,'Jagannath','toor',NULL,NULL,'1986-01-01',1,0,NULL,NULL),(8,'annette','marie',NULL,NULL,'1985-03-12',1,0,NULL,NULL),(13,'Jonn','Spare','s','567890-1246','2011-02-10',1,0,NULL,NULL),(14,'elvin','johnson','m','678-890-1246','2009-05-01',1,0,NULL,NULL),(15,'steve','jobs','k','567-890-1246',NULL,NULL,0,NULL,NULL),(18,'neil','goda','n','',NULL,NULL,0,NULL,NULL),(105,'John','Wilson','S',NULL,NULL,2,0,NULL,NULL),(109,'John','Kennedy','S',NULL,NULL,2,0,NULL,NULL),(110,'John','Kennedy','S',NULL,NULL,2,0,NULL,NULL),(155,'Mohan','Pai','S',NULL,NULL,6,0,NULL,NULL),(265,'John','McMillan',NULL,NULL,'1975-04-04',1,NULL,NULL,NULL),(267,'Cris','Gale',NULL,NULL,'2008-09-01',1,NULL,NULL,NULL),(272,'Sagar','Bannikal',NULL,NULL,'1987-12-12',2,NULL,NULL,NULL),(313,'Thomas','p',NULL,NULL,'1985-03-12',1,NULL,NULL,NULL),(314,'William','Will',NULL,NULL,'2008-01-01',1,NULL,NULL,NULL),(315,'Pavan','Kumar',NULL,NULL,'2009-03-01',1,NULL,NULL,NULL),(319,'Dhaksha','walli',NULL,NULL,'1985-03-12',1,NULL,NULL,NULL),(335,'Punit','kumar',NULL,NULL,'1985-03-12',1,NULL,NULL,NULL),(336,'Geeta','p',NULL,NULL,'1985-03-12',7,NULL,NULL,NULL),(337,'Sampath','sri',NULL,NULL,'1985-03-12',7,NULL,NULL,NULL),(340,'Kiran','Kumar',NULL,NULL,'1985-03-12',1,NULL,NULL,NULL),(341,'Guru','Kumar',NULL,NULL,'2001-11-11',1,NULL,NULL,NULL),(342,'Prasad','Kumar',NULL,NULL,'2009-03-01',2,NULL,NULL,NULL),(343,'KRISNA','KRISNA',NULL,NULL,'1985-03-12',1,NULL,NULL,NULL),(345,'Guru','Kumar',NULL,NULL,'2011-02-02',1,NULL,NULL,NULL),(353,'khadeer','basha',NULL,NULL,'2011-02-01',1,NULL,NULL,NULL),(355,'Dhaksha','Wali',NULL,NULL,'2010-02-12',1,NULL,NULL,NULL),(356,'Dhaksha','Wali',NULL,NULL,'2010-02-12',7,NULL,NULL,NULL),(357,'Dhaksha','Wali',NULL,NULL,'2010-02-12',7,NULL,NULL,NULL),(367,'sumanth','more',NULL,NULL,'2011-02-02',1,NULL,NULL,NULL),(369,'Roshan','Kumar',NULL,NULL,'2011-02-10',1,NULL,NULL,NULL),(370,'Vinod','C.V.',NULL,NULL,'2011-02-08',2,NULL,NULL,NULL),(371,'Amir','Khan',NULL,NULL,'2011-02-04',1,NULL,NULL,NULL),(373,'Arvind','Kumar',NULL,NULL,'2011-02-08',1,NULL,NULL,NULL),(375,'Shaker','Suman',NULL,NULL,'2011-02-10',1,NULL,NULL,NULL),(376,'Deepak','D',NULL,NULL,'2011-02-15',1,NULL,NULL,NULL),(377,'Rajendra','Reddy',NULL,NULL,'2011-02-17',1,NULL,NULL,NULL),(381,'Karthik','',NULL,NULL,'2009-03-01',1,NULL,NULL,NULL),(383,'Deepak','W',NULL,NULL,'2011-02-22',1,NULL,NULL,NULL),(384,'Deepak','D',NULL,NULL,'2011-03-03',1,NULL,NULL,NULL),(387,'Ramayana','',NULL,NULL,'2011-02-01',1,NULL,NULL,NULL),(388,'Sita','Priya',NULL,NULL,'2011-02-01',1,NULL,NULL,NULL),(391,'Tanveer','',NULL,NULL,'2011-02-02',1,NULL,NULL,NULL),(394,'Flapini','',NULL,NULL,'2011-02-01',1,NULL,NULL,NULL),(395,'Preety','',NULL,NULL,'2011-02-08',2,NULL,NULL,NULL),(396,'Preety','',NULL,NULL,'2011-02-08',2,NULL,NULL,NULL),(397,'Preety','',NULL,NULL,'2011-02-08',2,NULL,NULL,NULL),(398,'Durva','',NULL,NULL,'2011-02-08',2,NULL,NULL,NULL),(399,'Tanveer','William',NULL,NULL,'2011-03-02',1,NULL,NULL,NULL),(400,'Shanti','',NULL,NULL,'2011-02-08',1,NULL,NULL,NULL),(404,'Shanti','',NULL,NULL,'2011-03-02',1,NULL,NULL,NULL),(406,'Preety','',NULL,NULL,'2011-03-08',1,NULL,NULL,NULL),(407,'Shanti','',NULL,NULL,'2011-02-08',1,NULL,NULL,NULL),(411,'Sachin','Tendulkar',NULL,NULL,'2011-03-01',1,NULL,NULL,NULL);
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
  `version` int(11) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `party_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `type_of_share` bigint(20) DEFAULT NULL,
  `is_staff` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_details_is_for_person` (`party_id`),
  KEY `fk_person_details_has_job_title_code` (`job_title_code`),
  KEY `fk_person_details_has_department_code` (`department_code`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_details`
--

LOCK TABLES `person_details` WRITE;
/*!40000 ALTER TABLE `person_details` DISABLE KEYS */;
INSERT INTO `person_details` VALUES (1,'partner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(2,'partner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(3,'partner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(4,'partner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(5,'manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(6,'staff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(7,'staff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(8,'ceo',NULL,NULL,NULL,100000,'1000000','audit, compensation','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(9,'cfo',NULL,'finance',NULL,10000,'100000','finance','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(10,'',NULL,'',NULL,50000,NULL,'hr','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(12,NULL,NULL,NULL,NULL,2000000,'100000',NULL,'',0,NULL,NULL,'system','2010-06-22 20:43:25',109,'',NULL,''),(13,NULL,102,NULL,204,2000000,'100000',NULL,'',0,NULL,NULL,'system','2010-06-22 20:48:07',110,'',NULL,''),(14,NULL,110,NULL,205,NULL,'',NULL,'\0',0,NULL,NULL,'system','2010-06-22 20:48:07',155,'',NULL,''),(15,NULL,102,NULL,NULL,120000,'120000','Audit','\0',5,NULL,NULL,NULL,'2010-10-11 03:51:40',265,'',1201,''),(16,NULL,107,NULL,NULL,3,'200000','Audit','\0',4,NULL,NULL,NULL,'2010-10-12 02:12:56',13,'',1200,''),(17,NULL,106,NULL,NULL,NULL,'','Taxation','\0',0,NULL,NULL,NULL,'2010-10-12 02:16:04',14,'',NULL,''),(18,NULL,NULL,NULL,NULL,2,'','',NULL,1,NULL,NULL,NULL,'2010-10-20 01:10:46',267,'',1200,''),(19,'106',105,NULL,NULL,2,'2000000','Audit',NULL,18,NULL,NULL,NULL,'2010-10-27 04:07:43',7,'',1200,''),(20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2010-11-07 03:38:25',270,'',NULL,NULL),(23,NULL,105,NULL,NULL,NULL,'200','Audit',NULL,0,NULL,NULL,NULL,'2010-11-10 11:37:05',274,'',NULL,NULL),(26,NULL,105,NULL,NULL,NULL,'200','Audit',NULL,1,NULL,NULL,NULL,'2010-11-10 12:10:24',277,'',NULL,NULL),(27,NULL,105,NULL,NULL,NULL,'2020','audit',NULL,0,NULL,NULL,NULL,'2010-11-10 12:20:06',278,'',NULL,NULL),(28,NULL,104,NULL,NULL,NULL,'20000','Audit',NULL,0,NULL,NULL,NULL,'2010-11-11 11:18:01',270,'',NULL,NULL),(29,NULL,106,NULL,NULL,NULL,'2000','BANNIKAL',NULL,0,NULL,NULL,NULL,'2010-11-11 11:24:33',271,'',NULL,NULL),(30,NULL,105,NULL,NULL,NULL,'5000','Audit',NULL,6,NULL,NULL,NULL,'2010-11-11 14:27:35',272,'',NULL,NULL),(31,NULL,1467,NULL,NULL,NULL,'200000','Audit',NULL,4,NULL,NULL,NULL,'2010-11-30 06:14:46',2,'',NULL,NULL),(32,NULL,NULL,NULL,NULL,NULL,'122222','Audit',NULL,0,NULL,NULL,NULL,'2010-12-02 07:32:38',6,'',NULL,NULL),(33,NULL,NULL,NULL,NULL,NULL,'200000','Audit',NULL,0,NULL,NULL,NULL,'2010-12-02 07:34:24',8,'',NULL,NULL),(34,NULL,NULL,NULL,NULL,NULL,'600000','Audit',NULL,0,NULL,NULL,NULL,'2010-12-03 15:23:00',3,'',NULL,NULL),(71,NULL,108,NULL,NULL,NULL,'200000','Audit',NULL,1,NULL,NULL,NULL,'2010-12-15 06:05:32',313,'',NULL,NULL),(72,NULL,101,NULL,NULL,2,'200000','Audit',NULL,1,NULL,NULL,NULL,'2011-01-25 10:34:19',314,'',1200,''),(73,NULL,105,NULL,NULL,2,'5000','Audit',NULL,1,NULL,NULL,NULL,'2011-01-28 08:09:51',315,'',1200,''),(74,NULL,103,NULL,NULL,2,'30000','Audit',NULL,1,NULL,NULL,NULL,'2011-01-29 11:42:34',319,'',1200,''),(75,NULL,104,NULL,NULL,NULL,'','',NULL,0,NULL,NULL,NULL,'2011-01-31 08:53:40',334,'',NULL,NULL),(76,NULL,107,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-01-31 13:09:01',335,'',NULL,NULL),(77,NULL,104,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-01-31 13:52:59',336,'',NULL,NULL),(78,NULL,102,NULL,NULL,NULL,'9999','Audit',NULL,0,NULL,NULL,NULL,'2011-01-31 14:08:32',337,'',NULL,NULL),(79,NULL,102,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-01 04:32:30',340,'',NULL,NULL),(80,NULL,102,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-01 05:34:14',341,'',NULL,NULL),(81,NULL,104,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-01 05:38:41',342,'',NULL,NULL),(82,NULL,104,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-02 04:27:16',343,'',NULL,NULL),(83,NULL,105,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-02 08:58:07',344,'',NULL,NULL),(84,NULL,105,NULL,NULL,NULL,'30000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-02 08:59:46',345,'',NULL,NULL),(85,NULL,102,NULL,NULL,2,'30000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-04 13:08:58',353,'',1201,''),(86,NULL,101,NULL,NULL,NULL,'600000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-05 08:00:11',355,'',NULL,NULL),(87,NULL,101,NULL,NULL,NULL,'6000000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-05 08:10:36',356,'',NULL,NULL),(88,NULL,101,NULL,NULL,NULL,'6000000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-05 08:11:12',357,'',NULL,NULL),(89,NULL,109,NULL,NULL,3,'150000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-05 13:20:42',367,'',1200,''),(90,NULL,103,NULL,NULL,2,'200000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-08 07:38:15',369,'',1200,''),(91,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-08 11:53:52',370,'',NULL,NULL),(92,NULL,103,NULL,NULL,NULL,'200000','Audit',NULL,0,NULL,NULL,NULL,'2011-02-08 12:04:39',371,'',NULL,NULL),(93,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-08 14:29:37',373,'',NULL,NULL),(94,NULL,104,NULL,NULL,3,'30000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-11 07:06:33',375,'',1200,''),(95,NULL,105,NULL,NULL,500,'30000','Thomas',NULL,5,NULL,NULL,NULL,'2011-02-11 12:08:53',376,'',1201,''),(96,NULL,105,NULL,NULL,2,'200000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-11 12:10:42',377,'',1201,''),(97,NULL,101,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-14 09:08:14',381,'',NULL,NULL),(98,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-18 14:52:24',383,'',NULL,NULL),(99,NULL,101,NULL,NULL,67,'30000','Audit',NULL,1,NULL,NULL,NULL,'2011-02-21 06:39:02',384,'',1200,''),(100,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-26 09:59:39',385,'',NULL,NULL),(101,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-26 10:38:07',387,'',NULL,NULL),(102,NULL,101,NULL,NULL,NULL,'20000','audit',NULL,0,NULL,NULL,NULL,'2011-02-26 10:45:35',388,'',NULL,NULL),(103,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 10:39:28',391,'',NULL,NULL),(104,NULL,103,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 13:41:55',394,'',NULL,NULL),(105,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 13:46:50',395,'',NULL,NULL),(106,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 13:49:10',396,'',NULL,NULL),(107,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 13:51:10',397,'',NULL,NULL),(108,NULL,102,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-02-28 14:02:40',398,'',NULL,NULL),(109,NULL,101,NULL,NULL,NULL,'4444','audit',NULL,0,NULL,NULL,NULL,'2011-03-01 07:12:20',399,'',NULL,NULL),(110,NULL,101,NULL,NULL,22,'4444','audit',NULL,1,NULL,NULL,NULL,'2011-03-01 07:39:41',400,'',1200,''),(111,NULL,102,NULL,NULL,22,'4444','audit',NULL,2,NULL,NULL,NULL,'2011-03-02 10:45:37',404,'',1201,''),(112,NULL,1468,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2011-03-15 13:29:29',406,'',NULL,NULL),(113,NULL,102,NULL,NULL,67,'4444','audit',NULL,1,NULL,NULL,NULL,'2011-03-15 13:39:11',407,'',1200,''),(114,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,2,'karthik@jlc.com','2011-03-26 07:12:54','karthik@jlc.com','2011-03-26 07:12:31',411,'',NULL,NULL);
/*!40000 ALTER TABLE `person_details` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_type`
--

LOCK TABLES `person_type` WRITE;
/*!40000 ALTER TABLE `person_type` DISABLE KEYS */;
INSERT INTO `person_type` VALUES (1,'STAFF','','2010-06-22 04:21:14','system','system',NULL,'2010-06-22 04:00:00'),(2,'PARTNER','','2010-06-22 04:21:59','system','system',NULL,'2010-06-22 04:00:00'),(3,'INSURANCE_AGENT','','2010-06-22 04:23:03','system','system',NULL,'2010-06-22 04:00:00'),(4,'LAWYER','','2010-06-22 04:23:52','system','system',NULL,'2010-06-22 04:00:00'),(5,'SHAREHOLDER','','2010-06-22 04:24:45','system','system',NULL,'2010-06-22 04:00:00'),(6,'BANK_EMPLOYEE','','2010-07-15 00:18:12','system','system',NULL,'2010-06-22 04:00:00'),(7,'FIRM ADMIN','','2011-01-31 15:05:18','system','system',NULL,'2011-01-31 15:05:18');
/*!40000 ALTER TABLE `person_type` ENABLE KEYS */;
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
  CONSTRAINT `fk_contact_point_is_for_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_point_of_contact_for_account` FOREIGN KEY (`account_id`) REFERENCES `party_account` (`id`),
  CONSTRAINT `fk_point_of_contact_for_site` FOREIGN KEY (`party_site_id`) REFERENCES `party_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_of_contact`
--

LOCK TABLES `point_of_contact` WRITE;
/*!40000 ALTER TABLE `point_of_contact` DISABLE KEYS */;
INSERT INTO `point_of_contact` VALUES (4,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 10:43:12','system','system','2011-02-16 10:43:25',NULL,NULL),(5,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 10:51:00','system','system','2011-02-16 10:51:17',NULL,NULL),(6,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 12:03:18','system','system','2011-02-16 12:03:22',NULL,NULL),(7,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 12:05:19','system','system','2011-02-16 12:05:23',NULL,NULL),(8,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 12:06:07','system','system','2011-02-16 12:06:10',NULL,NULL),(9,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 12:11:06','system','system','2011-02-16 12:11:27',NULL,NULL),(10,'Sagar','CEO',NULL,NULL,'',0,'2011-02-16 13:27:17','system','system','2011-02-16 13:27:22',NULL,NULL),(11,'Anand','CEO',NULL,NULL,'',0,'2011-02-16 14:00:25','system','system','2011-02-16 14:00:33',10,NULL),(12,'AnandSharma','CEO',NULL,22,'',3,'2011-02-16 14:04:30','system','system','2011-02-17 08:11:20',4,NULL),(13,'James','staff',NULL,22,'',0,'2011-02-16 14:06:48','system','system','2011-02-16 14:06:55',6,NULL),(14,'Richard','accountant',NULL,22,'',0,'2011-02-16 14:09:09','system','system','2011-02-16 14:09:15',7,NULL),(15,'karthik','accountant',NULL,22,'',0,'2011-02-16 14:10:53','system','system','2011-02-16 14:11:00',8,NULL),(16,'VinodKumar','CEO',NULL,NULL,'',4,'2011-02-17 07:08:11','system','system','2011-02-17 08:11:42',11,NULL),(17,'Karthk','CEO',NULL,NULL,'',0,'2011-02-17 07:18:04','system','system','2011-02-17 07:18:31',12,NULL),(18,'ramu','CEO',NULL,22,'',0,'2011-02-17 07:23:16','system','system','2011-02-17 07:23:47',13,NULL),(19,'H S ramu','CEO',NULL,22,'',0,'2011-02-17 08:13:10','system','system','2011-02-17 08:13:13',14,NULL),(20,'Rudrama','',NULL,22,'',0,'2011-02-17 08:14:17','system','system','2011-02-17 08:14:21',15,NULL),(21,'Krishna','',NULL,22,'',1,'2011-02-17 08:15:09','system','system','2011-02-17 08:15:45',16,NULL),(22,'Anand','accountant',NULL,22,'',0,'2011-02-17 15:16:28','system','system','2011-02-17 15:16:32',17,NULL),(23,'Manju','accountant',NULL,22,'',0,'2011-02-18 05:51:41','system','system','2011-02-18 05:51:44',18,NULL),(24,'Anand','CEO',NULL,22,'',0,'2011-02-18 06:04:31','system','system','2011-02-18 06:04:35',19,NULL),(25,'Sagar','CEO',NULL,12,'',0,'2011-02-21 08:21:08','system','system','2011-02-21 08:21:13',20,NULL),(26,'Harsha','TEAM LEADER',NULL,22,'',7,'2011-02-27 06:25:15','system','admin@firm.com','2011-03-28 09:04:39',21,NULL),(27,'Harsha','CEO',NULL,22,'',0,'2011-02-27 06:44:21','system','system','2011-02-27 06:44:22',22,NULL),(28,'Harsha','CEO',NULL,22,'',0,'2011-02-27 06:44:40','system','system','2011-02-27 06:44:41',23,NULL),(29,'Harsha','TEAM LEADER',NULL,22,'',2,'2011-02-28 05:39:23','system','system','2011-02-28 06:52:22',24,NULL),(30,'Harsha','TEAM LEADER',NULL,22,'',1,'2011-02-28 05:40:47','system','system','2011-02-28 05:41:12',25,NULL),(32,'Tanveer ','Tanveer ',NULL,391,'',7,'2011-02-28 10:39:27','system','admin@firm.com','2011-03-26 06:49:02',NULL,176),(33,'Accenture','Accenture',NULL,393,'',5,'2011-02-28 13:32:22','system','system','2011-03-05 11:44:32',NULL,178),(34,'Flapini ','Flapini ',NULL,394,'',1,'2011-02-28 13:41:55','system','system','2011-02-28 13:44:46',NULL,179),(35,'','',NULL,395,'',0,'2011-02-28 13:46:50','system','system','2011-02-28 13:47:22',NULL,180),(36,'Preety ','Preety ',NULL,396,'',1,'2011-02-28 13:49:10','system','system','2011-02-28 14:04:53',NULL,181),(37,'Preety ','Preety ',NULL,397,'',2,'2011-02-28 13:51:10','system','system','2011-02-28 14:01:13',NULL,182),(38,'','',NULL,398,'',0,'2011-02-28 14:02:40','system','system','2011-02-28 14:02:44',NULL,183),(39,'Harsha','TEAM LEADER',NULL,146,'',2,'2011-03-01 05:22:35','system','system','2011-03-01 05:27:35',NULL,185),(40,'Harsha','CEO',NULL,12,'',3,'2011-03-01 05:34:58','system','system','2011-03-01 05:59:28',NULL,166),(41,'Harsha','CEO',NULL,146,'',0,'2011-03-01 06:07:21','system','system','2011-03-01 06:07:22',NULL,150),(42,'Harsha','CEO',NULL,12,'',2,'2011-03-01 06:45:00','system','system','2011-03-01 07:02:29',NULL,2),(43,'Tanveer William','Tanveer William',NULL,399,'',2,'2011-03-01 07:12:20','system','system','2011-03-01 07:19:50',NULL,186),(44,NULL,NULL,NULL,150,'',2,'2011-03-01 07:38:44','system','admin@firm.com','2011-03-28 13:33:41',NULL,99),(45,'','',NULL,400,'',1,'2011-03-01 07:39:41','system','system','2011-03-01 07:45:18',NULL,187),(46,NULL,NULL,NULL,149,'',0,'2011-03-01 07:53:28','system','system','2011-03-01 07:53:29',NULL,188),(47,'Harsha','CEO',NULL,149,'',0,'2011-03-01 07:54:19','system','system','2011-03-01 07:54:19',NULL,189),(48,'Harsha','CEO',NULL,149,'',0,'2011-03-01 08:05:53','system','system','2011-03-01 08:05:53',NULL,190),(49,'Harsha','CEO',NULL,146,'',0,'2011-03-01 08:22:07','system','system','2011-03-01 08:22:08',26,NULL),(50,NULL,NULL,NULL,22,'',34,'2011-03-01 10:55:17','system','admin@firm.com','2011-03-26 06:08:09',NULL,94),(51,'Sushma','CEO',NULL,140,'',4,'2011-03-02 05:35:19','system','admin@firm.com','2011-03-29 09:21:54',NULL,151),(52,NULL,NULL,NULL,401,'',1,'2011-03-02 06:24:49','system','system','2011-03-02 06:36:10',NULL,191),(53,NULL,NULL,NULL,402,'',0,'2011-03-02 06:31:58','system','system','2011-03-02 06:32:09',NULL,192),(54,'Xchanging','Xchanging',NULL,403,'',1,'2011-03-02 07:24:49','system','system','2011-03-16 08:11:57',NULL,193),(55,'Shanti ','Shanti ',NULL,404,'',5,'2011-03-02 10:45:37','system','system','2011-03-24 05:49:52',NULL,194),(56,NULL,NULL,NULL,384,'',4,'2011-03-03 07:49:11','system','admin@firm.com','2011-03-29 09:13:29',NULL,163),(57,'Vinay','TEAM LEADER',NULL,104,'',0,'2011-03-03 12:24:40','system','system','2011-03-03 12:24:41',NULL,25),(58,'RamKmar','CEO',NULL,104,'',0,'2011-03-03 12:26:06','system','system','2011-03-03 12:26:07',NULL,96),(59,'Guru Kumar','Guru Kumar',NULL,345,'',2,'2011-03-05 11:34:32','system','system','2011-03-05 11:46:08',NULL,119),(60,'JLC soft','JLC soft',NULL,380,'',2,'2011-03-05 11:53:57','system','system','2011-03-15 14:26:37',NULL,159),(61,NULL,NULL,NULL,405,'',0,'2011-03-07 08:47:47','system','system','2011-03-07 08:48:06',NULL,195),(62,'Preety ','Preety ',NULL,406,'',9,'2011-03-15 13:29:29','system','admin@firm.com','2011-04-03 05:11:21',NULL,196),(63,'Shanti ','Shanti ',NULL,407,'',2,'2011-03-15 13:39:11','system','system','2011-03-16 07:14:58',NULL,197),(64,'Harsha','TEAM LEADER',NULL,12,'',1,'2011-03-15 13:41:47','system','system','2011-03-15 13:42:53',NULL,198),(65,'RamKmar','CEO',NULL,104,'',10,'2011-03-15 13:48:28','system','system','2011-03-16 12:28:52',NULL,199),(66,'Harsha','TEAM LEADER',NULL,104,'',0,'2011-03-15 14:16:29','system','system','2011-03-15 14:16:29',27,NULL),(67,'Harsha','TEAM LEADER',NULL,104,'',0,'2011-03-15 14:17:25','system','system','2011-03-15 14:17:26',28,NULL),(68,'Karthik ','Karthik ',NULL,381,'',1,'2011-03-15 14:28:36','system','system','2011-03-22 05:51:28',NULL,160),(69,'Neema Pvt Lmt','Neema Pvt Lmt',NULL,408,'',9,'2011-03-22 04:06:39','system','admin@firm.com','2011-03-26 11:03:34',NULL,200),(70,NULL,NULL,NULL,156,'',3,'2011-03-22 11:37:35','system','admin@firm.com','2011-03-26 14:12:37',NULL,154),(71,NULL,NULL,NULL,409,'',2,'2011-03-24 05:18:32','system','system','2011-03-24 05:41:00',NULL,201),(72,NULL,NULL,NULL,410,'',10,'2011-03-24 07:32:44','system','kotragoud','2011-03-25 04:50:34',NULL,202),(73,'','',NULL,411,'',2,'2011-03-26 07:12:31','karthik@jlc.com','karthik@jlc.com','2011-03-26 07:12:49',NULL,203);
/*!40000 ALTER TABLE `point_of_contact` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'client','','2010-06-13 08:33:56','system',NULL,NULL,NULL),(2,'partner','','2010-06-13 08:34:01','system',NULL,NULL,NULL),(3,'employee','','2010-06-13 08:34:05','system',NULL,NULL,NULL),(4,'bank','','2010-06-13 00:00:00','system',NULL,NULL,NULL),(5,'lawyer','','2010-06-13 08:34:15','system',NULL,NULL,NULL),(6,'insurance agency','','2010-06-13 08:34:20','system',NULL,NULL,NULL),(7,'shareholder','','2010-06-13 08:34:25','system',NULL,NULL,NULL),(8,'client transfer agent','','2010-06-13 08:34:30','system',NULL,NULL,NULL),(9,'main bank','','2010-09-14 08:08:01','system','system','2010-09-14 12:08:11',NULL),(10,'Insurance Firm','','2010-09-14 08:08:01','system','system','2010-09-14 12:08:11',NULL),(11,'Tranfer Agent Firm','','2010-09-14 08:08:01','system','system','2010-09-14 12:08:11',NULL),(12,'Main Law Firm','','2010-10-09 09:35:29','system','system','2010-10-09 13:35:44',0),(13,'Admin','','2011-01-31 19:19:02','system','system',NULL,0);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
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
  `partner_in_charge` bigint(20) unsigned NOT NULL,
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
  `tax_info_date_rule_id` bigint(20) unsigned NOT NULL,
  `filing_title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk272d85d1f71582` (`firm_id`),
  KEY `fk272d859af5a7e2` (`customer_id`),
  KEY `fk272d85d1f71532` (`status`),
  KEY `fk272d85d1f71565` (`partice_id`),
  KEY `fkc8aab77ea6e16f70` (`client_staff_in_charge`),
  KEY `fkc8aab77e72401be4` (`staff_in_charge`),
  KEY `fkc8aab77e72401df8` (`partner_in_charge`),
  KEY `fk272d85d1f71542` (`filing_type`),
  KEY `fk_client_tax_info` (`tax_info_date_rule_id`),
  KEY `fk_client_practice_info` (`practice_client_info_id`),
  CONSTRAINT `fk272d859af5a7e2` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk272d85d1f71532` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk272d85d1f71542` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk272d85d1f71565` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk272d85d1f71582` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_client_practice_info` FOREIGN KEY (`practice_client_info_id`) REFERENCES `tax_client_practice_info` (`id`),
  CONSTRAINT `fk_client_tax_info` FOREIGN KEY (`tax_info_date_rule_id`) REFERENCES `tax_info_due_date_rule` (`id`),
  CONSTRAINT `fk_status_type` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk_task_is_client_staff_in_charge_fk` FOREIGN KEY (`client_staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_customer` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk_task_is_for_a_firm_party` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_practice_name` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk_task_is_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_task_partner_in_charge_pk` FOREIGN KEY (`partner_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_notification`
--

DROP TABLE IF EXISTS `task_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_notification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `notification_date` date NOT NULL,
  `sent_to` varchar(200) DEFAULT NULL,
  `sent_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_notification`
--

LOCK TABLES `task_notification` WRITE;
/*!40000 ALTER TABLE `task_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_notification_recipient`
--

DROP TABLE IF EXISTS `task_notification_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_notification_recipient` (
  `notification_type` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) unsigned DEFAULT NULL,
  `recipient` varchar(30) DEFAULT NULL,
  `email_type` varchar(300) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`notification_type`),
  KEY `fk_task_not_recipient` (`template_id`),
  CONSTRAINT `fk_task_not_recipient` FOREIGN KEY (`template_id`) REFERENCES `task_notification_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_notification_recipient`
--

LOCK TABLES `task_notification_recipient` WRITE;
/*!40000 ALTER TABLE `task_notification_recipient` DISABLE KEYS */;
INSERT INTO `task_notification_recipient` VALUES (1,1,'client','bcc',1,'','2011-03-19 14:12:22','system',NULL,NULL),(2,1,'partner','cc',1,'','2011-03-19 14:49:09','system',NULL,NULL),(3,1,'employee','to',1,'','2011-03-19 14:15:36','system',NULL,NULL),(4,2,'client','bcc',0,NULL,NULL,NULL,NULL,NULL),(5,2,'partner','cc',0,NULL,NULL,NULL,NULL,NULL),(6,2,'employee','to',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `task_notification_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_notification_template`
--

DROP TABLE IF EXISTS `task_notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_notification_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(4000) DEFAULT NULL,
  `body` varchar(4000) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `additional_emailId` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_notification_template`
--

LOCK TABLES `task_notification_template` WRITE;
/*!40000 ALTER TABLE `task_notification_template` DISABLE KEYS */;
INSERT INTO `task_notification_template` VALUES (1,'Practice Management: Task Reminder for %s of %s','Dear %s,\r\nThe %s has %s due on %s.','','2011-03-19 14:10:39','system',NULL,NULL,1,'savitrisp@gmail.com,srgudi@yahoo.com'),(2,'Practice Management: Task Reminder for %s of %s','Dear %s, \r\nThe %s has %s due on %s.','','2011-03-19 14:00:07','system',NULL,NULL,2,'savitrisp@gmail.com,srgudi@yahoo.com');
/*!40000 ALTER TABLE `task_notification_template` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_status`
--

LOCK TABLES `task_status` WRITE;
/*!40000 ALTER TABLE `task_status` DISABLE KEYS */;
INSERT INTO `task_status` VALUES (1,'completed','','2010-12-20 06:42:49','system','system','2010-12-20 06:42:49',0),(2,'waiting','','2010-12-24 06:42:49','system','system','2010-12-24 06:42:49',0);
/*!40000 ALTER TABLE `task_status` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  `application_level` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_application_practice_type`
--

LOCK TABLES `tax_application_practice_type` WRITE;
/*!40000 ALTER TABLE `tax_application_practice_type` DISABLE KEYS */;
INSERT INTO `tax_application_practice_type` VALUES (24,'Sales Tax','Sales Tax','','2010-12-15 11:23:15','system',NULL,NULL,NULL,NULL),(25,'Coperation Tax','Coperation Tax','','2011-01-19 11:35:18','system',NULL,NULL,NULL,NULL),(26,'Income Tax','Income Tax','','2011-02-05 12:03:54','system',NULL,NULL,NULL,NULL),(27,'Commercial Tax','Commercial Tax','','2011-02-08 17:00:10','system',NULL,NULL,NULL,NULL),(28,'Health tax','Health tax','','2011-02-08 19:53:05','system',NULL,NULL,NULL,NULL),(29,'Sales Tax','Sales Tax','','2011-02-08 19:55:12','system',NULL,NULL,NULL,NULL),(30,'Coperation Tax','Coperation Tax','','2011-02-08 20:00:43','system',NULL,NULL,NULL,NULL),(31,'Mutual Tax','Mutual Tax','','2011-03-26 18:26:39','system',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tax_application_practice_type` ENABLE KEYS */;
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
  `tax_id_number` varchar(50) DEFAULT NULL,
  `filing_date_reminder` bit(1) NOT NULL,
  `instalment_frequency` bigint(20) unsigned NOT NULL,
  `instalment_reminder` bit(1) NOT NULL,
  `preparer_notes` varchar(4000) DEFAULT NULL,
  `firm_id` bigint(20) unsigned DEFAULT NULL,
  `internal_memo` varchar(4000) DEFAULT NULL,
  `staff_in_charge` bigint(20) unsigned NOT NULL,
  `partner_in_charge` bigint(20) unsigned NOT NULL,
  `client_staff_in_charge` bigint(20) unsigned DEFAULT NULL,
  `filing_date_rule` varchar(50) DEFAULT NULL,
  `filing_due_day` int(11) DEFAULT NULL,
  `instalment_date_rule` varchar(50) DEFAULT NULL,
  `instalment_due_day` int(11) DEFAULT NULL,
  `filing_due_month` int(11) DEFAULT NULL,
  `instalment_due_month` int(11) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `partice_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_practice_is_for_a_firm_fk` (`firm_id`),
  KEY `tax_practice_is_for_a_client` (`client`),
  KEY `fkc8aab77ea6e16f70` (`client_staff_in_charge`),
  KEY `fkc8aab77e72401be4` (`staff_in_charge`),
  KEY `fkc8aab77e72401cf8` (`partner_in_charge`),
  KEY `client_tax_practice_for_firm_practice_type` (`tax_firm_practice_type`),
  CONSTRAINT `client_tax_practice_for_firm_practice_type` FOREIGN KEY (`tax_firm_practice_type`) REFERENCES `tax_firm_practice_type` (`id`),
  CONSTRAINT `tax_practice_client_staff_in_charge_fk` FOREIGN KEY (`client_staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `tax_practice_is_for_a_client` FOREIGN KEY (`client`) REFERENCES `party` (`party_id`),
  CONSTRAINT `tax_practice_is_for_a_firm_fk` FOREIGN KEY (`firm_id`) REFERENCES `organization` (`party_id`),
  CONSTRAINT `tax_practice_partner_in_charge_pk` FOREIGN KEY (`partner_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `tax_practice_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_client_practice_info`
--

LOCK TABLES `tax_client_practice_info` WRITE;
/*!40000 ALTER TABLE `tax_client_practice_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_client_practice_info` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_appl_prctc_typ` (`practice_id`),
  KEY `fk_organization` (`firm_id`),
  CONSTRAINT `fk_appl_prctc_typ` FOREIGN KEY (`practice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk_organization` FOREIGN KEY (`firm_id`) REFERENCES `organization` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_firm_practice_type`
--

LOCK TABLES `tax_firm_practice_type` WRITE;
/*!40000 ALTER TABLE `tax_firm_practice_type` DISABLE KEYS */;
INSERT INTO `tax_firm_practice_type` VALUES (12,24,1,'','2010-12-15 11:23:15','system',NULL,NULL,0),(13,25,1,'\0','2011-01-19 11:35:18','system',NULL,'2011-02-05 08:30:41',1),(14,26,1,'','2011-02-05 12:03:54','system',NULL,NULL,0),(15,27,1,'','2011-02-08 17:00:10','system',NULL,NULL,0),(16,28,1,'','2011-02-08 19:53:05','system',NULL,NULL,0),(17,29,320,'','2011-02-08 19:55:12','system',NULL,NULL,0),(18,30,372,'','2011-02-08 20:00:43','system',NULL,NULL,0),(19,31,1,'','2011-03-26 18:26:39','system',NULL,NULL,0);
/*!40000 ALTER TABLE `tax_firm_practice_type` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_due_date_rule`
--

LOCK TABLES `tax_info_due_date_rule` WRITE;
/*!40000 ALTER TABLE `tax_info_due_date_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_info_due_date_rule` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_filing_type`
--

LOCK TABLES `tax_info_filing_type` WRITE;
/*!40000 ALTER TABLE `tax_info_filing_type` DISABLE KEYS */;
INSERT INTO `tax_info_filing_type` VALUES (1,'Tax Filing','Tax Filing Type','','2010-12-20 00:00:00','SYSTEM','SYSTEM','2010-12-19 23:30:00',0),(2,'Installment Filing','Installment Filing Type','','2010-12-20 00:00:00','SYSTEM','SYSTEM','2010-12-19 23:30:00',0);
/*!40000 ALTER TABLE `tax_info_filing_type` ENABLE KEYS */;
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
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminder_is_for_practice` (`practice_info_id`),
  KEY `reminder_is_for_filing_type` (`filing_type`),
  CONSTRAINT `reminder_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `reminder_is_for_practice` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_reminder`
--

LOCK TABLES `tax_info_reminder` WRITE;
/*!40000 ALTER TABLE `tax_info_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_info_reminder` ENABLE KEYS */;
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
  `create_user_id` varchar(100) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(100) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezone`
--

LOCK TABLES `timezone` WRITE;
/*!40000 ALTER TABLE `timezone` DISABLE KEYS */;
INSERT INTO `timezone` VALUES (1,'Eastern Time(US & Canada)',-5,'',3,14,1,2,11,24,1,2,'ss','ss','system',NULL,'system',NULL,'',18),(2,'Pacific Time (US & Canada)',-8,'',3,14,1,2,11,24,1,2,'','','system',NULL,'admin@firm.com','2011-03-28 13:37:08','',2),(3,'Atlantic Time (Canada)',-4,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'',1),(4,'Newfoundland Time (Canada)',-4,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'',1),(5,'Central Time (US & Canada)',-6,'',3,14,1,2,11,24,1,2,NULL,NULL,'system',NULL,'system',NULL,'',1),(6,'Mountain Time (US & Canada)',-7,'',3,14,1,2,11,24,1,2,'','','system',NULL,'sue treen',NULL,'\0',3),(7,'West Time',-7,'',3,1,1,2,3,1,1,2,'','','system','2011-03-05 09:43:12','karthik@jlc.com','2011-03-28 08:56:44','',6),(8,'North Time',-7,'',5,5,4,5,5,5,4,5,'','','delves freer anderson raniga caine','2011-03-22 07:30:45','sue treen','2011-03-22 07:30:45','',2),(9,'South Ind',-7,'',4,23,1,4,3,5,1,4,'test','test','system','2011-03-27 12:23:11','admin@firm.com','2011-04-05 13:38:58','',10),(10,'Middle Time',-22,'',4,23,1,4,3,5,1,4,'gf','test','system','2011-04-05 13:41:10','admin@firm.com','2011-04-05 13:41:10','',1),(11,'Sagar',-21,'',0,13,1,4,8,1,4,4,'gf','sdf','system','2011-04-06 04:07:57','admin@firm.com','2011-04-06 05:38:28','',2),(12,'Pavan1947',-22,'',4,2,4,1,3,5,1,4,'gf','sdf','system','2011-04-06 04:13:04','admin@firm.com','2011-04-06 04:44:15','',2);
/*!40000 ALTER TABLE `timezone` ENABLE KEYS */;
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
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
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
INSERT INTO `users` VALUES ('admin@firm.com','admin',1,5,'','0000-00-00 00:00:00','','0000-00-00 00:00:00'),('guest','admin',1,0,'','0000-00-00 00:00:00','','0000-00-00 00:00:00'),('vishnu_sharma@yahoo.com','password',1,138,'system','2011-01-30 18:30:00','system','2011-01-30 18:30:00'),('krishna@iscon.com','password',1,140,'system','2011-01-30 18:30:00','system','2011-01-30 18:30:00'),('james@chase.com','password',1,141,'system','2011-01-30 18:30:00','system','2011-01-30 18:30:00'),('guru@gmail.com','password',1,194,'system','2011-01-31 18:30:00','system','2011-01-31 18:30:00'),('prasad@gmail.com','password',1,195,'system','2011-01-31 18:30:00','system','2011-01-31 18:30:00'),('krishna@gmail.com','password',1,196,'system','2011-02-01 18:30:00','system','2011-02-01 18:30:00'),('guru@yahoomail.com','password',1,205,'system','2011-02-01 18:30:00','system','2011-02-01 18:30:00'),('dhaksha@chiguru.com','password',1,217,'system','2011-02-04 18:30:00','system','2011-02-04 18:30:00'),('dhaksha1@chiguru.com','password',1,219,'system','2011-02-04 18:30:00','system','2011-02-04 18:30:00'),('vinod@yahoo.com','password',1,233,'system','2011-02-07 18:30:00','system','2011-02-07 18:30:00'),('arvind@gmail.com','password',1,235,'system','2011-02-07 18:30:00','system','2011-02-07 18:30:00'),('karthik@jlc.com','password',1,246,'system','2011-02-13 18:30:00','system','2011-02-13 18:30:00'),('druva@yahoo.com','password',1,258,'system','2011-02-27 18:30:00','system','2011-02-27 18:30:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-04-08 17:38:25
