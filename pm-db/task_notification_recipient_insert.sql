USE `chiguru2`;

insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (1,1,'client','bcc',1,1,'2011-03-19 19:42:22','system',null,null);
insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (2,1,'partner','cc',0,null,null,null,null,null);
insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (3,1,'employee','to',1,1,'2011-03-19 19:45:36','system',null,null);
insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (4,2,'client','bcc',0,null,null,null,null,null);
insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (5,2,'partner','cc',0,null,null,null,null,null);
insert into `task_notification_recipient`(`notification_type`,`template_id`,`recipient`,`email_type`,`version`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`) values (6,2,'employee','to',0,null,null,null,null,null);
;

