--------- New 'tax_info_reminder' table used while testing/run Scheduling  ------------------- 

CREATE TABLE `tax_info_reminder` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reminder_day` smallint(6) DEFAULT NULL,
  `filing_type` smallint(11) UNSIGNED DEFAULT NULL,
  `practice_info_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(50) NOT NULL,
  `last_update_user_id` varchar(50) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `reminder_day_code` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminder_is_for_practice` (`practice_info_id`),
  KEY `reminder_is_for_filing_type` (`filing_type`),
  CONSTRAINT `reminder_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `reminder_is_for_practice` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

---------------------------------End-----------

CREATE TABLE `tax_info_reminder` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reminder_day` smallint(6) DEFAULT NULL,
  `filing_type` smallint(11) UNSIGNED DEFAULT NULL,
  `practice_info_id` bigint(20) UNSIGNED DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

