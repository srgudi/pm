CREATE TABLE `tax_client_practice_info` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_firm_practice_type` bigint(20) UNSIGNED NOT NULL,
  `client` bigint(20) UNSIGNED NOT NULL,
  `jurisdiction` bigint(20) NOT NULL,
  `filing_frequency` bigint(20) UNSIGNED NOT NULL,
  `tax_id_number` varchar(50) DEFAULT NULL,
  `filing_date_reminder` bit(1) NOT NULL,
  `instalment_frequency` bigint(20) UNSIGNED NOT NULL,
  `instalment_reminder` bit(1) NOT NULL,
  `preparer_notes` varchar(4000) DEFAULT NULL,
  `firm_id` bigint(20) UNSIGNED DEFAULT NULL,
  `internal_memo` varchar(4000) DEFAULT NULL,
  `staff_in_charge` bigint(20) UNSIGNED NOT NULL,
	`partner_in_charge` bigint(20) UNSIGNED NOT NULL,
  `client_staff_in_charge` bigint(20) UNSIGNED DEFAULT NULL,
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
  CONSTRAINT `tax_practice_staff_in_charge_pk` FOREIGN KEY (`staff_in_charge`) REFERENCES `person` (`party_id`),
	CONSTRAINT `tax_practice_partner_in_charge_pk` FOREIGN KEY (`partner_in_charge`) REFERENCES `person` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

alter table tax_client_practice_info add column partner_in_charge  bigint(20) UNSIGNED DEFAULT NULL;

ALTER TABLE `tax_client_practice_info` 

  ADD CONSTRAINT `tax_practice_partner_in_charge`

  FOREIGN KEY (`partner_in_charge`)

  REFERENCES `person` (`party_id` )

  ON DELETE NO ACTION

  ON UPDATE NO ACTION

, ADD INDEX `tax_practice_partner_in_charge` (`partner_in_charge` ASC, `id` ASC) ;


