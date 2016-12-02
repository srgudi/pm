---------Insert query for a organisation table only-----------------------
INSERT INTO chiguru2.party(name,active_flag,create_user_id,create_date,last_update_user_id,last_update_date,party_type,version)
   VALUES ('TSS India Pvt. Lmt',true,'superAdmin',CURDATE(),'superAdmin',CURDATE(),1,0);
	 
INSERT INTO chiguru2.organization(party_id,name,legal_name,operating_name,organization_type,last_update_userid,last_update_date,version)
   VALUES (LAST_INSERT_ID(),'TSS','TSS','TSS India Pvt. Lmt',1,'superAdmin',CURDATE(),0);



---------Insert query for a person-----------------------
INSERT INTO chiguru2.party(name,active_flag,create_user_id,create_date,last_update_user_id,last_update_date,party_type,version)
   VALUES ('Super Admin',true,'superAdmin',CURDATE(),'superAdmin',CURDATE(),1,0);
	 
INSERT INTO chiguru2.person(party_id,first_name,last_name,date_of_birth,person_type,version,last_update_user_id,last_update_date,username)
   VALUES (LAST_INSERT_ID(),'Super','Admin','1986-12-12',7,0,'superAdmin',CURDATE(),'superAdmin@tss.com');
	 
INSERT INTO chiguru2.point_of_contact(contact_name,contact_title,party_id,active_flag,version,create_date,create_user_id,last_update_user_id,last_update_date)
   VALUES ('John','SuperAdmin',LAST_INSERT_ID(),true,0,CURDATE(),'superAdmin','superAdmin',CURDATE());
	 
INSERT INTO chiguru2.communication(contact_detail,contact_point_id,communication_type,create_date,create_user_id,last_update_user_id,
               last_update_date,version,active_flag)
   VALUES ('superAdmin@tss.com',LAST_INSERT_ID(),1,CURDATE(),'superAdmin','superAdmin',CURDATE(),0,true);



---------Insert query for a Relationship table only-----------------------
INSERT INTO chiguru2.party_relationship(subject,object,relationship_type,create_date,create_user_id,active_flag,version,last_update_user_id,
               last_update_date)
   VALUES (GET_SUPER_PERSON_ID,GET_SUPER_FIRM_ID,13,CURDATE(),'superAdmin',active_flag,0,'superAdmin',CURDATE());

INSERT INTO chiguru2.users(username,password,enabled,party_relationship_id,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE,users_expiry_date)
   VALUES ('superAdmin@tss.com','5f4dcc3b5aa765d61d8327deb882cf99',1,LAST_INSERT_ID(),'superAdmin',CURDATE(),'superAdmin',CURDATE(),
          CURDATE());


---------Insert query for a authorities table only-----------------------
INSERT INTO chiguru2.authorities (username, authority)
   VALUES ('superAdmin@tss.com', 'ROLE_APP_ADMIN');
   

   
---------Insert query for a CodeType table only-----------------------

INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (1,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
	 
INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (1001,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
	 
INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (1002,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
	 
INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (2,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
	 
INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (1067,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
	 
INSERT   INTO chiguru2.party_code(code_id,party_id,create_date,create_user_id,version,sort_order,last_update_user_id,last_update_date,active_flag)
   VALUES (1068,GET_SUPER_FIRM_ID,CURDATE(),'superAdmin',version,sort_order,'superAdmin',CURDATE(),true);
   
 
   