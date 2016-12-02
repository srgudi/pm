--------- New 'task' table used while testing/run Scheduling  ------------------- 

CREATE TABLE `task` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `practice_client_info_id` bigint(20) UNSIGNED NOT NULL,
  `firm_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `filing_type` smallint(6) UNSIGNED NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `staff_in_charge` bigint(20) UNSIGNED NOT NULL,
  `partner_in_charge` bigint(20) UNSIGNED NOT NULL,
  `client_staff_in_charge` bigint(20) UNSIGNED DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `task_note` varchar(4000) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `actual_completion_date` timestamp NULL DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `partice_id` bigint(20) UNSIGNED NOT NULL,
  `tax_info_date_rule_id` bigint(20) UNSIGNED NOT NULL,
  `filing_title` varchar(30) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;



-------------------------------------------------------end----------------------

CREATE TABLE `task` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `practice_client_info_id` bigint(20) UNSIGNED NOT NULL,
  `firm_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
	`filing_type` smallint(6) UNSIGNED NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `task_note` varchar(4000) DEFAULT NULL,
  `actual_completion_date` date NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk272d85d1f71582` (`firm_id`),
  KEY `fk272d859af5a7e2` (`customer_id`),
  KEY `fk272d85d1f71532` (`status`),
	KEY `fk272d85d1f71542` (`filing_type`),	
  KEY `fk_client_practice_info` (`practice_client_info_id`),
  CONSTRAINT `fk272d859af5a7e2` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk272d85d1f71532` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk272d85d1f71582` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
	CONSTRAINT `fk272d85d1f71542` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk_client_practice_info` FOREIGN KEY (`practice_client_info_id`) REFERENCES `tax_client_practice_info` (`id`),
  CONSTRAINT `fk_status_type` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk_task_is_for_a_customer` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_firm_party` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
	CONSTRAINT `fk_task_is_for_a_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;



INSERT INTO chiguru2.task(id,practice_client_info_id,firm_id,customer_id,status,filing_type,comments,create_user_id,create_date,last_update_user_id,last_update_date,due_date,task_note,version) 
VALUES (1,1,256,12,1,1,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-18 01:01:01',null,0);
INSERT INTO chiguru2.task(id,practice_client_info_id,firm_id,customer_id,status,filing_type,comments,create_user_id,create_date,last_update_user_id,last_update_date,due_date,task_note,version) 
VALUES (2,2,257,16,2,2,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-20 01:01:01',null,0);
INSERT INTO chiguru2.task(id,practice_client_info_id,firm_id,customer_id,status,filing_type,comments,create_user_id,create_date,last_update_user_id,last_update_date,due_date,task_note,version) 
VALUES (3,2,256,18,2,1,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-17 00:00:00','dfsdf',0);

