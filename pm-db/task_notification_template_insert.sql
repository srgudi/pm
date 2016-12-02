USE `chiguru2`;

insert into `task_notification_template`(`id`,`subject`,`body`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`,`additional_emailId`) values (1,'Practice Management: Task Reminder for %s of %s','Dear %s,
The %s has %s due on %s.',1,'2011-03-19 19:40:39','system',null,null,1,'savitrisp@gmail.com;srgudi@yahoo.com');
insert into `task_notification_template`(`id`,`subject`,`body`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`,`additional_emailId`) values (2,'Practice Management: Task Reminder for %s of %s','Dear %s, 
The %s has %s due on %s.',1,'2011-03-19 19:30:07','system',null,null,2,'savitrisp@gmail.com;srgudi@yahoo.com');
;


// run these queries to obtain templates for resetPassword & forgotPassword modules.
UPDATE chiguru2.task_notification_template 
SET id = 16 , subject = '%s  Welcome to PracticeManagement', body = 'Dear %s,

Your account has been successfully created .
User Name - %s.
To Set Your Password  please click the following Link- %s.
please change the password after first log in for a secure transaction.

Regards
PM-Team.', active_flag = 1,
create_date = '2011-09-06 18:46:22', create_user_id = 'system',
last_update_user_id = 'apoorvada@yahoo.com', last_update_date =
'2011-09-09 16:35:58', version = 4, additional_emailId =
'apoorvada@yahoo.com' 
WHERE id = 16;

UPDATE chiguru2.task_notification_template 
SET id = 17 , subject = '%s did you forget your password', body = 'Dear %s,

Please Set a new Password  by clicking the following Link- %s.
It seems you have forgotten your  password.

Regards
PM-Team.', active_flag = 1,
create_date = '2011-10-10 13:09:30', create_user_id = 'apoorvada@yahoo.com',
last_update_user_id = 'apoorvada@yahoo.com', last_update_date =
'2011-10-10 13:09:30', version = 4, additional_emailId =
'apoorvada@yahoo.com' 
WHERE id = 17;


---------------------  Insert Query to get template for sending mails to Filing Deadline and Installments Deadline-----------

insert into `task_notification_template`(`id`,`subject`,`body`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`,`additional_emailId`) values (18,'Practice Management: Task Reminder for %s of %s','Dear %s,

This is a friendly reminder that you have the following return due for Filing on (Filing Deadline): 
Type of Return: %s
Filing Due date: %s
Return Status: %s

Please review the information below and get back to us as soon as possible. 
It is important that the filing is done on time to avoid any penalties and or interest.

If you have any questions, please do not hesitate to contact us.

Yours sincerely,
%s
%s
%s
%s
%s %s
%s %s
%s
%s',1,'2011-12-04 15:54:36','sagar_bannikal_098@yahoo.com','sagar_bannikal_098@yahoo.com','2011-12-04 15:54:36',4,'sagar_bannikal_098@yahoo.com');

insert into `task_notification_template`(`id`,`subject`,`body`,`active_flag`,`create_date`,`create_user_id`,`last_update_user_id`,`last_update_date`,`version`,`additional_emailId`) values (19,'Practice Management: Task Reminder for %s of %s','Dear %s,

This is a friendly reminder that you have the following Installments due: 
Type of Return: %s
Installment Amount: %s
Payment Date: %s

Please pay the above amounts on or before the payment date to avoid paying penalties and interest. 

If you have any questions, please do not hesitate to contact us.

Yours sincerely,
%s
%s
%s
%s
%s %s
%s %s
%s
%s',1,'2011-12-04 15:56:09','sagar_bannikal_098@yahoo.com','sagar_bannikal_098@yahoo.com','2011-12-04 15:56:09',3,'sagar_bannikal_098@yahoo.com');
;


---------------------  Update Query to get template for sending mails to Filing Deadline and Installments Deadline-----------

UPDATE chiguru2.task_notification_template 
SET body = 'Dear %s,

This is a friendly reminder that you have the following return due for filing on (Filing Deadline): 
Type of Return: %s
Filing Due date: %s
Return Status: %s

Please review the information below and get back to us as soon as possible. 
It is important that the filing is done on time to avoid any penalties and or interest.

If you have any questions, please do not hesitate to contact us.

Yours sincerely,
%s
%s
%s
%s
%s %s
%s %s
%s
%s'
WHERE id=18;

UPDATE chiguru2.task_notification_template 
SET body = 'Dear %s,

This is a friendly reminder that you have the following installments due: 
Type of Return: %s
Installment Amount: %s
Payment Date: %s

Please pay the above amounts on or before the payment date to avoid paying penalties and interest. 

If you have any questions, please do not hesitate to contact us.

Yours sincerely,
%s
%s
%s
%s
%s %s
%s %s
%s
%s'
WHERE id=19;

---------------------









