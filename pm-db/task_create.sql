CREATE TABLE `task` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `practice_client_info_id` bigint(20) UNSIGNED NOT NULL,
  `firm_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `create_user_id` varchar(30) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `task_note` varchar(4000) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk272d85d1f71582` (`firm_id`),
  KEY `fk272d859af5a7e2` (`customer_id`),
  KEY `fk272d85d1f71532` (`status`),
  KEY `fk_client_practice_info` (`practice_client_info_id`),
  CONSTRAINT `fk272d859af5a7e2` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk272d85d1f71532` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk272d85d1f71582` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_client_practice_info` FOREIGN KEY (`practice_client_info_id`) REFERENCES `tax_client_practice_info` (`id`),
  CONSTRAINT `fk_status_type` FOREIGN KEY (`status`) REFERENCES `task_status` (`id`),
  CONSTRAINT `fk_task_is_for_a_customer` FOREIGN KEY (`customer_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_task_is_for_a_firm_party` FOREIGN KEY (`firm_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


------------------------------------------- Here are the stepwise Query need to be excuted in your local Data Base
-- 1) creating new colum with name "tax_firm_practice_type_id"
ALTER TABLE chiguru2.task
ADD tax_firm_practice_type_id BIGINT UNSIGNED AFTER filing_title;

-- 2) this Query to create Foreign Key from "tax_firm_practice_type_id" to table "tax_firm_practice_type"
ALTER TABLE chiguru2.task
ADD CONSTRAINT fk_task_is_practice_type FOREIGN KEY (tax_firm_practice_type_id) 
REFERENCES chiguru2.tax_firm_practice_type (id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- 3) this Query to drop Foreign Key value fk_client_practice_info 
ALTER TABLE chiguru2.task DROP FOREIGN KEY fk_client_practice_info;                      

-- 4) This Query is change colume "practice_client_info_id" from NOTNULL to NULLABLE 
ALTER TABLE chiguru2.task CHANGE practice_client_info_id practice_client_info_id BIGINT(20) UNSIGNED;   

-- 5) This Query is to assign back Forgign Key "practice_client_info_id" with new CONSTRAINT value as "fk_client_practice_info_pk"
ALTER TABLE chiguru2.task ADD CONSTRAINT fk_client_practice_info_pk FOREIGN KEY (practice_client_info_id) 
REFERENCES chiguru2.tax_client_practice_info (id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- 6) This Query is used to Drop Forgeign Key "fk_client_tax_info" releted to colum "tax_info_date_rule_id"
ALTER TABLE chiguru2.task DROP FOREIGN KEY fk_client_tax_info;    

-- 7) This Query is change colume "tax_info_date_rule_id" from NOTNULL to NULLABLE 
ALTER TABLE chiguru2.task CHANGE tax_info_date_rule_id tax_info_date_rule_id BIGINT(20) UNSIGNED;     
 
-- 8) This Query is to assign back Forgign Key "tax_info_date_rule_id" with new CONSTRAINT value as "fk_client_tax_info"
ALTER TABLE chiguru2.task ADD CONSTRAINT fk_client_tax_info FOREIGN KEY (tax_info_date_rule_id) 
REFERENCES chiguru2.tax_info_due_date_rule (id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- 9) This Query create new coulm by name "task_type", with Default value as "SCHEDULED"
ALTER TABLE chiguru2.task ADD task_type VARCHAR(20) DEFAULT 'SCHEDULED' AFTER tax_firm_practice_type_id;











