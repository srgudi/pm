
---------------->>> How to make primary key Auto-Increment
Step 1: (Drop Foreign Key 'fk_party_is_in_jurisdiction' In Party Table)
		ALTER TABLE chiguru2.party DROP FOREIGN KEY fk_party_is_in_jurisdiction;

Step 2: (Drop Coulm 'juridisction' From Party Table) --> Not necessary
		ALTER TABLE chiguru2.party DROP juridisction;

Step 3: (Apply AUTO-INCREMENT to Jurisdiction Table)
         ALTER TABLE chiguru2.jurisdiction CHANGE id id MEDIUMINT(8) AUTO_INCREMENT NOT NULL;

Step 4: (Now Add colum 'juridisction' Into Party Table)
		ALTER TABLE chiguru2.party ADD juridisction MEDIUMINT(8) AFTER language;

Step 5: (Apply Foreign Key to colum 'juridisction' In Party Table)
		ALTER TABLE chiguru2.party ADD CONSTRAINT fk_party_is_in_jurisdiction FOREIGN KEY (juridisction) 
		REFERENCES chiguru2.jurisdiction (id) ON UPDATE RESTRICT ON DELETE RESTRICT;

---------------->>> End


// Just run following sql query without dropping `jurisdiction`  

ALTER TABLE chiguru2.jurisdiction
 ADD timezone tinyint(4) UNSIGNED DEFAULT NULL AFTER state_code;

 
ALTER TABLE chiguru2.jurisdiction
 ADD CONSTRAINT fk_jurisdiction_is_in_timezone 
FOREIGN KEY (timezone) 
REFERENCES chiguru2.timezone (id) ON UPDATE RESTRICT ON DELETE RESTRICT;


UPDATE chiguru2.jurisdiction SET timezone = 1;



INSERT INTO chiguru2.jurisdiction(id,country,state,county,city,active_flag,create_date,create_user_id,last_update_user_id,last_update_date,version,country_code,state_code,timezone) VALUES (1,'usa','va','fairfax','fairfax',1,null,'system',null,null,1,null,null,3)
, (2,'usa','va','fairfax','falls church',1,null,null,null,null,1,null,null,3)
, (3,'canada','bc','','vancuar',1,null,'system',null,null,1,null,null,5)
, (4,'canada','mo','fairfax','toronto',1,null,null,null,null,1,null,null,3);



//Full script for jurisdiction. (No auto increment)

CREATE TABLE `jurisdiction` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `active_flag` bit(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` varchar(25) DEFAULT NULL,
  `last_update_user_id` varchar(30) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `country_code` bigint(20) UNSIGNED DEFAULT NULL,
  `state_code` bigint(20) UNSIGNED DEFAULT NULL,
  `timezone` tinyint(4) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_jurisdiction_is_in_timezone` (`timezone`),
  CONSTRAINT `fk_jurisdiction_is_in_timezone` FOREIGN KEY (`timezone`) REFERENCES `timezone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
