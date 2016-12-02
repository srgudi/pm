USE `chiguru2`;

;


INSERT INTO chiguru2.task(id,practice_client_info_id,firm_id,customer_id,status,comments,create_user_id,create_date,last_update_user_id,last_update_date,due_date,task_note,version) VALUES (1,1,284,12,1,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-25 01:01:01',null,0)
, (2,2,285,16,2,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-10 01:01:01',null,0)
, (3,2,284,18,1,'comments','system','2010-12-24 12:12:59','system','2010-12-24 12:12:59','2011-01-30 00:00:00','dfsdf',0);




ALTER TABLE task
 ADD payment_type INT(20) AFTER task_type,
 ADD amount_paid INT(40),
 ADD chq_no VARCHAR(30),
 ADD ack_no VARCHAR(30),
 ADD paid_date DATE;


CREATE TABLE `payment_type` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


insert into `payment_type`(`id`,`type`) values (1,'Cheque');
insert into `payment_type`(`id`,`type`) values (2,'E- Filing');
insert into `payment_type`(`id`,`type`) values (3,'Cash');

