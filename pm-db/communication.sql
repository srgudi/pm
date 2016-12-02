CREATE TABLE `communication` (
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;