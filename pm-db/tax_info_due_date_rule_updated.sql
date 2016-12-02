--------- New 'tax_info_due_date_rule' table used while testing/run Scheduling  ------------------- 

CREATE TABLE `tax_info_due_date_rule` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `due_day` int(11) DEFAULT NULL,
  `due_month` int(11) DEFAULT NULL,
  `practice_info_id` bigint(20) UNSIGNED NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(50) NOT NULL,
  `last_update_user_id` varchar(50) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `scheduling_rule` varchar(50) DEFAULT NULL,
  `filing_type` smallint(3) UNSIGNED DEFAULT NULL,
  `generated_task_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `due_date_rule_is_for_practice_info` (`practice_info_id`),
  KEY `due_date_rule_is_for_filing_type` (`filing_type`),
  CONSTRAINT `due_date_rule_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `due_date_rule_is_for_practice_info` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

---------------------------------------------------End ---------------

CREATE TABLE `tax_info_due_date_rule` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `due_day` int(11) DEFAULT NULL,
  `due_month` int(11) DEFAULT NULL,
  `practice_info_id` bigint(20) UNSIGNED NOT NULL,
  `active_flag` bit(1) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_user_id` varchar(25) NOT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `scheduling_rule` varchar(50) DEFAULT NULL,
  `filing_type` smallint(3) UNSIGNED DEFAULT NULL,
  `generated_task_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `due_date_rule_is_for_practice_info` (`practice_info_id`),
  KEY `due_date_rule_is_for_filing_type` (`filing_type`),
  CONSTRAINT `due_date_rule_is_for_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `due_date_rule_is_for_practice_info` FOREIGN KEY (`practice_info_id`) REFERENCES `tax_client_practice_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

