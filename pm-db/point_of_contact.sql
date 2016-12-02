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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

