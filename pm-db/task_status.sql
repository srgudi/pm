
------------------ Latest Updated insert queries used while testing/run Scheduling ---------- 
USE `chiguru2`;

insert into `task_status`(`id`,`status`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`) values (1,'completed',1,'2010-12-20 12:12:49','system','system','2010-12-20 12:12:49',0);
insert into `task_status`(`id`,`status`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`) values (2,'waiting',1,'2010-12-24 12:12:49','system','system','2010-12-24 12:12:49',0);
insert into `task_status`(`id`,`status`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`) values (3,'new',1,'2010-12-20 12:12:49','system','system','2010-12-20 12:12:49',0);
;

----------------------------------------------------------------------------------------end-----



USE `chiguru2`;

;


INSERT INTO chiguru2.task_status(id,status,active_flag,create_date,create_user_id,last_update_user_id,last_update_date,version) VALUES (1,'completed',1,'2010-12-20 12:12:49','system','system','2010-12-20 12:12:49',0)
, (2,'waiting',1,'2010-12-24 12:12:49','system','system','2010-12-24 12:12:49',0);

