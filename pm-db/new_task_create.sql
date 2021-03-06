CREATE TABLE `task` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firm_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `filing_type` smallint(6) UNSIGNED NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `staff_in_charge` bigint(20) UNSIGNED NOT NULL,
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
  PRIMARY KEY (`id`),
  KEY `fk272d85d1f71582` (`firm_id`),
  KEY `fk272d859af5a7e2` (`customer_id`),
  KEY `fk272d85d1f71532` (`status`),
  KEY `fk272d85d1f71565` (`partice_id`),
  KEY `fkc8aab77ea6e16f70` (`client_staff_in_charge`),
  KEY `fkc8aab77e72401be4` (`staff_in_charge`),
  KEY `fk272d85d1f71542` (`filing_type`),
  KEY `fk_client_practice_info` (`tax_info_date_rule_id`),
  CONSTRAINT `fk272d859af5a7e2` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk272d85d1f71532` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk272d85d1f71542` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk272d85d1f71565` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk272d85d1f71582` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_client_practice_info` FOREIGN KEY (`tax_info_date_rule_id`) REFERENCES `tax_info_due_date_rule` (`id`),
  CONSTRAINT `fk_status_type` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk_task_is_client_staff_in_charge_fk` FOREIGN KEY (`client_staff_in_charge`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_customer` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_filing_type` FOREIGN KEY (`filing_type`) REFERENCES `tax_info_filing_type` (`id`),
  CONSTRAINT `fk_task_is_for_a_firm_party` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_practice_name` FOREIGN KEY (`partice_id`) REFERENCES `tax_application_practice_type` (`id`),
  CONSTRAINT `fk_task_is_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

