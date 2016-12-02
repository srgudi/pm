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
  `reminder_day_code` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminder_is_for_practice` (`practice_info_id`),
  KEY `reminder_is_for_filing_type` (`filing_type`),
  CONSTRAINT `reminder_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `reminder_is_for_practice` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_info_reminder`
--
