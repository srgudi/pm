UPDATE task_notification_template 
SET  subject = 'PRACTICE MANAGEMENT : We Have Paid the tax already..',
body = '<html><p>Dear %s,<br/><br/>We have received a tax reminder mail.<br/>We have filed the taxes before hand (%s - %s).Thank you for your <br/>concern.If you have any questions, please do not hesitate<br/> to  contact us.<br/> <br/>Yours sincerely,<br/>%s<br/>Email : %s<br/>Phone : %s<br/></p></html>' ,
active_flag = true
WHERE id = 4;

UPDATE task_notification_template 
SET  subject = 'PRACTICE MANAGEMENT : You Have a tax Due Soon..',
body = '<html><p>Dear %s,<br/><br/>This is a friendly reminder mail to remind you that your tax due date is nearing (%s - %s).<br/>If you have already filed you tax then ignore this mail else please do so on time<br/>to avoid any penalties and or interest.If you have any questions, please do not<br/>hesitate to  contact us.<br/><br/>Yours sincerely,<br/>%s<br/>Email : %s<br/>Phone : %s<br/></p></html>' ,
active_flag = true
WHERE id = 3;


UPDATE task_notification_template 
SET subject = 'PRACTICE MANAGEMENT - Tax Filing Accomplished', body = '<html><p>Dear %s,<br/><br/>The filing process of %s which was due on %s has been completed.<br/>Thank you for your co-operation for the same.Looking forward for<br/>your interest in future.Do contact us if you have any<br/> queries about the same.<br/><br/>Yours sincerely,<br/>%S<br/>Email : %s<br/>Phone : %s<br/></p></html>', active_flag = true
WHERE id = 5;


UPDATE task_notification_template 
SET body = '<html><p>Dear %s,<br/><br/>Your account has been successfully created .<br/>User Name - %s.<br/>To Set Your Password  please click the following Link- %s.<br/>please change the password after first log in for a secure transaction.<br/><br/>Regards<br/>PM-Team.<br/></p></html>'
WHERE id = 16;

UPDATE task_notification_template 
SET body = '<html><p>Dear %s,<br/><br/>Please Set a new Password  by clicking the following Link- %s.<br/>It seems you have forgotten your  password.<br/><br/>Regards<br/>PM-Team.<br/></p></html>'
WHERE id = 17;

UPDATE task_notification_template 
SET body = '<html><p>Dear %s,<br/><br/>This is a friendly reminder that you have the following return due for filing on (Filing Deadline):<br/>Type of Return: %s<br/>Filing Due date: %s<br/>Return Status: %s<br/><br/>Please review the information below and get back to us as soon as possible.<br/> It is important that the filing is done on time to avoid any penalties and or interest.<br/><br/>If you have any questions, please do not hesitate to  contact us.<br/> <br/>Yours sincerely,<br/>%s<br/>%s<br/>%s<br/>%s <br/>%s %s<br/>%s %s<br/>%s<br/></p></html>'
WHERE id = 18;

UPDATE task_notification_template 
SET body = '<html><p>Dear %s, <br/><br/>This is a friendly reminder that you have the following installments due: <br/>Type of Return: %s <br/>Installment Amount: %s <br/>Payment Date: %s <br/><br/>Please pay the above amounts on or before the payment date to avoid paying penalties and interest.<br/> <br/>If you have any questions, please do not hesitate to contact us.<br/><br/>Yours sincerely, <br/>%s <br/>%s <br/>%s <br/>%s <br/>%s %s <br/>%s %s <br/>%s <br/>%s<br/>%s<br/></p></html>'
WHERE id = 19;