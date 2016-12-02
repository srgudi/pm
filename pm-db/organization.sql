//Please execute the following queries

ALTER TABLE organization
 ADD email_address VARCHAR(100);


ALTER TABLE organization
 ADD contact_number VARCHAR(100);


---------------------------------------------------------------
//Again "year_end_date" colume Is changed From Date to Varchar. Please run the below script
ALTER TABLE chiguru2.organization
CHANGE year_end_date year_end_date VARCHAR(20);

---------------------------------------------------------------

//Dropping year_end_date colume From organization Table.
ALTER TABLE chiguru2.organization
 DROP FOREIGN KEY fk_incharge_person_is_a_person,
 DROP FOREIGN KEY fk_organization_form_of_business_is_a_code,
 DROP FOREIGN KEY fk_organization_industry_subtype_is_code,
 DROP FOREIGN KEY fk_organization_industry_type,
 DROP FOREIGN KEY fk_organization_is_a_party,
 DROP FOREIGN KEY fk_organization_is_for_type,
 DROP FOREIGN KEY fk_organization_subtype_is_type,
 DROP year_end_date;
ALTER TABLE chiguru2.organization
 ADD CONSTRAINT fk_incharge_person_is_a_person FOREIGN KEY (in_charge_person) REFERENCES chiguru2.person (party_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_form_of_business_is_a_code FOREIGN KEY (form_of_business) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
 ADD CONSTRAINT fk_organization_industry_subtype_is_code FOREIGN KEY (industry_subtype) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_industry_type FOREIGN KEY (industry_type) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_is_a_party FOREIGN KEY (party_id) REFERENCES chiguru2.party (party_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_is_for_type FOREIGN KEY (organization_type) REFERENCES chiguru2.organization_type (id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_subtype_is_type FOREIGN KEY (organization_subtype) REFERENCES chiguru2.organization_type (id) ON UPDATE RESTRICT ON DELETE RESTRICT;


//Adding new colume year_end_date From organization Table As Data.
ALTER TABLE chiguru2.organization
 DROP FOREIGN KEY fk_incharge_person_is_a_person,
 DROP FOREIGN KEY fk_organization_form_of_business_is_a_code,
 DROP FOREIGN KEY fk_organization_industry_subtype_is_code,
 DROP FOREIGN KEY fk_organization_industry_type,
 DROP FOREIGN KEY fk_organization_is_a_party,
 DROP FOREIGN KEY fk_organization_is_for_type,
 DROP FOREIGN KEY fk_organization_subtype_is_type,
 ADD year_end_date DATE AFTER in_charge_person;
ALTER TABLE chiguru2.organization
 ADD CONSTRAINT fk_incharge_person_is_a_person FOREIGN KEY (in_charge_person) REFERENCES chiguru2.person (party_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_form_of_business_is_a_code FOREIGN KEY (form_of_business) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
 ADD CONSTRAINT fk_organization_industry_subtype_is_code FOREIGN KEY (industry_subtype) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_industry_type FOREIGN KEY (industry_type) REFERENCES chiguru2.code (id) ON UPDATE NO ACTION ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_is_a_party FOREIGN KEY (party_id) REFERENCES chiguru2.party (party_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_is_for_type FOREIGN KEY (organization_type) REFERENCES chiguru2.organization_type (id) ON UPDATE RESTRICT ON DELETE RESTRICT,
 ADD CONSTRAINT fk_organization_subtype_is_type FOREIGN KEY (organization_subtype) REFERENCES chiguru2.organization_type (id) ON UPDATE RESTRICT ON DELETE RESTRICT;

 
 
//Lastest Organization sql script.
CREATE TABLE `organization` (
  `party_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `legal_name` varchar(100) DEFAULT NULL,
  `operating_name` varchar(100) DEFAULT NULL,
  `form_of_business` bigint(20) UNSIGNED DEFAULT NULL,
  `business_identification_number` varchar(50) DEFAULT NULL,
  `incorporation_date` date DEFAULT NULL,
  `incorporation_number` varchar(50) DEFAULT NULL,
  `industry_type` bigint(20) UNSIGNED DEFAULT NULL,
  `industry_subtype` bigint(20) UNSIGNED DEFAULT NULL,
  `authorized_capital` varchar(4000) DEFAULT NULL,
  `issued_captial` varchar(4000) DEFAULT NULL,
  `organization_type` tinyint(3) UNSIGNED DEFAULT NULL,
  `organization_subtype` tinyint(3) UNSIGNED DEFAULT NULL,
  `last_update_userid` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `in_charge_person` bigint(20) UNSIGNED DEFAULT NULL,
  `year_end_date` date DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `fkd063d5334b78cfda` (`party_id`),
  KEY `fk_organization_is_for_type` (`organization_type`),
  KEY `fk_incharge_person_is_a_person` (`in_charge_person`),
  KEY `fk_organization_form_of_business_is_a_code` (`form_of_business`),
  KEY `fk_organization_industry_type` (`industry_type`),
  KEY `fk_organization_industry_subtype_is_code` (`industry_subtype`),
  KEY `fk_organization_subtype_is_type` (`organization_subtype`),
  CONSTRAINT `fk_incharge_person_is_a_person` FOREIGN KEY (`in_charge_person`) REFERENCES `person` (`party_id`),
  CONSTRAINT `fk_organization_form_of_business_is_a_code` FOREIGN KEY (`form_of_business`) REFERENCES `code` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_subtype_is_code` FOREIGN KEY (`industry_subtype`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_industry_type` FOREIGN KEY (`industry_type`) REFERENCES `code` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_is_a_party` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `fk_organization_is_for_type` FOREIGN KEY (`organization_type`) REFERENCES `organization_type` (`id`),
  CONSTRAINT `fk_organization_subtype_is_type` FOREIGN KEY (`organization_subtype`) REFERENCES `organization_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
