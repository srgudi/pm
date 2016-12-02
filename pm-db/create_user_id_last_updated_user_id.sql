
------------------ for Address table -------------- 
ALTER TABLE chiguru2.address
CHANGE last_update_user_id last_update_user_id VARCHAR(50),
CHANGE create_user_id create_user_id VARCHAR(50);

------------------ for Code  table -------------- 
ALTER TABLE chiguru2.code
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for CodeType  table -------------- 
ALTER TABLE chiguru2.code_type
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for CommunicationType  table -------------- 
ALTER TABLE chiguru2.communication_type
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for Jurisdiction  table -------------- 
ALTER TABLE chiguru2.jurisdiction
 CHANGE last_update_user_id last_update_user_id VARCHAR(50),
 CHANGE create_user_id create_user_id VARCHAR(50);

------------------ for language  table -------------- 
ALTER TABLE chiguru2.language
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for filing_reminder  table -------------------------- 
--------- there are no create_user_Id and last_user_update_Id-----------

------------------ for organization  table -------------------------- 
ALTER TABLE chiguru2.organization
 CHANGE last_update_userid last_update_userid VARCHAR(50);

------------------ for organization_preferences  table -------------------------- 
ALTER TABLE chiguru2.organization_preferences
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for organization_type  table -------------------------- 
ALTER TABLE chiguru2.organization_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party  table -------------------------- 
ALTER TABLE chiguru2.party
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party_account  table -------------------------- 
ALTER TABLE chiguru2.party_account
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party_code  table -------------------------- 
ALTER TABLE chiguru2.party_code
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party_communication  table ---------------- 
--------- there are no create_user_Id and last_user_update_Id------

------------------ for party_relationship  table ------------------- 
ALTER TABLE chiguru2.party_relationship
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party_site  table --------------------------
ALTER TABLE chiguru2.party_site
 CHANGE last_update_user_id last_update_user_id VARCHAR(50),
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL;


------------------ for party_site_communication  table -------------
ALTER TABLE chiguru2.party_site_communication
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for party_site_type  table --------------------------
ALTER TABLE chiguru2.party_site_type
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);


------------------ for party_type  table --------------------------
ALTER TABLE chiguru2.party_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for person  table --------------------------
ALTER TABLE chiguru2.person
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);


------------------ for person_details  table --------------------------
ALTER TABLE chiguru2.person_details
 CHANGE last_update_user_id last_update_user_id VARCHAR(50),
 CHANGE create_user_id create_user_id VARCHAR(50);


------------------ for person_type  table --------------------------
ALTER TABLE chiguru2.person_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for point_of_contact  table --------------------------
ALTER TABLE chiguru2.point_of_contact
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for relationship_type  table --------------------------
ALTER TABLE chiguru2.relationship_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for task  table --------------------------
ALTER TABLE chiguru2.task
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for task_notification  table --------------------------
--------- there are no create_user_Id and last_user_update_Id------

------------------ for task_notification_recipient  table --------------------------
ALTER TABLE chiguru2.task_notification_recipient
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for task_notification_template  table --------------------------
ALTER TABLE chiguru2.task_notification_template
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for task_status  table --------------------------
ALTER TABLE chiguru2.task_status
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for tax_application_practice_type  table --------------------------
ALTER TABLE chiguru2.tax_application_practice_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for tax_client_practice_info  table --------------------------
ALTER TABLE chiguru2.tax_client_practice_info
 CHANGE create_user_id create_user_id VARCHAR(50),
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for tax_firm_practice_type  table --------------------------
ALTER TABLE chiguru2.tax_firm_practice_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for tax_info_due_date_rule  table ---------------------------------------
---------  create_user_Id and last_user_update_Id  are already having varchar value 50------

------------------ for tax_info_filing_type  table --------------------------
ALTER TABLE chiguru2.tax_info_filing_type
 CHANGE create_user_id create_user_id VARCHAR(50) NOT NULL,
 CHANGE last_update_user_id last_update_user_id VARCHAR(50);

------------------ for task_notification_template  table --------------------------



------------------ for task_notification_template  table --------------------------