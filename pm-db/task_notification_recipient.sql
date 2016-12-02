CREATE TABLE `task_notification_recipient` (
  `notification_type` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) UNSIGNED DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;