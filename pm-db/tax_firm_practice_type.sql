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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
