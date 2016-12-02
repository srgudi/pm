CREATE TABLE `task_notification` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `notification_date` date NOT NULL,
  `sent_to` varchar(200) DEFAULT NULL,
  `sent_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

