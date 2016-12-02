package com.chiguru.pm.tax.service;

import com.chiguru.pm.core.common.utilities.EmailService;
import com.chiguru.pm.crm.dao.CRMDao;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.dto.BaseTaskDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.dao.TaskModuleDao;
import com.chiguru.pm.tax.domain.BaseTask;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.DueDateRule;
import com.chiguru.pm.tax.domain.FilingDueDateRule;
import com.chiguru.pm.tax.domain.FilingReminderRule;
import com.chiguru.pm.tax.domain.FilingTypeTask;
import com.chiguru.pm.tax.domain.InstallmentDueDateRule;
import com.chiguru.pm.tax.domain.InstallmentReminderRule;
import com.chiguru.pm.tax.domain.InstallmentTypeTask;
import com.chiguru.pm.tax.domain.ReminderRule;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskNotification;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.dto.EventDTO;
import com.chiguru.pm.tax.dto.TaskDTO;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.transaction.AfterTransaction;

import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;


@Service
@ContextConfiguration(locations =  {
    "/mail-config.xml"}
)
public class TaskModuleManagerImpl implements TaskModuleManager {
    private static final String filing_frequency_for_monthly = "1303";
    private static final String installment_frequency_for_monthly = "1403";
	private static final int number_of_months_in_a_year = 11;
	private Logger logger = org.slf4j.LoggerFactory.getLogger(TaskModuleManagerImpl.class);
    @Autowired
    TaskModuleDao taskModuleDao;
    @Autowired
    CRMDao crmDao;
    @Autowired
    EmailService email;
    @Autowired
    CRMManager crmmanager;

    @Override
    public Task getTaskById(Long long1) {
        return taskModuleDao.getTaskById(long1);
    }

    @Override
    public List<Long> getTasksByDueDate(Long page, Date dueDate, Long partyId) {
        List<Long> listLong = new ArrayList<Long>();

        if (page != 0) {
            listLong = taskModuleDao.getTasksByDueDate(dueDate, page, partyId);
        }

        return listLong;
    }

    @Override
    public Long getTasksCountByDueDate(Date dueDate, Long partyId) {
        return taskModuleDao.getTasksCountByDueDate(dueDate, partyId);
    }

    @Override
    @Transactional
    public void generateTasks() {
        logger.info("Generating Task started..!" + new Date());

        Calendar cal = getTodaysCalendar();
        List<BaseTask> taskList = new ArrayList<BaseTask>();
        String frequency = "";

        // first find out the task that need to be generated
        List<DueDateRule> eventDateList = taskModuleDao.getRecurringEvents(cal.getTime());

        for (DueDateRule dateRule : eventDateList) {
            ClientPracticeInfo practiceInfo = null; // dateRule.getClientPracticeInfo();
                                                    // FilingDueDateRule
                                                    // taxInfo=(FilingDueDateRule)getHibernate().get(DueDateRule.class,
                                                    // dateRule.getId());

            if (dateRule instanceof FilingDueDateRule) {
                FilingDueDateRule taxInfo = (FilingDueDateRule) dateRule;
                practiceInfo = taxInfo.getClientPracticeInfo();
                frequency = practiceInfo.getFilingFrequency().toString();
            } else if (dateRule instanceof InstallmentDueDateRule) {
                InstallmentDueDateRule instRule = (InstallmentDueDateRule) dateRule;
                practiceInfo = instRule.getClientPracticeInfo();
                frequency = practiceInfo.getInstalmentFrequency().toString();
            }

            // Task task = new Task();
            // Calendar cal = getTodaysCalendar();
            if (dateRule.getGeneratedTaskDate() != null) {
                // add one year range
                cal = addRecurringRange(cal, Calendar.YEAR, 1);
            }

            if (dateRule.getDueMonth() != null) {
                cal.set(Calendar.MONTH, dateRule.getDueMonth());
            }

            if (dateRule.getDueDay() != null) {
                if (PMConstants.LAST_DAY_OF_THE_MONTH == dateRule.getDueDay()) {
                    cal.set(Calendar.DATE, cal.getMaximum(Calendar.DATE));
                } else {
                    cal.set(Calendar.DATE, dateRule.getDueDay());
                }
            }

           
            Calendar newcal = cal;
            if(frequency.equalsIgnoreCase(filing_frequency_for_monthly) || frequency.equalsIgnoreCase(installment_frequency_for_monthly)){
            	newcal.add(Calendar.MONTH, 0);
            	taskList = prepareTaskList(newcal, practiceInfo, dateRule, taskList);
            	for(int i=0;i<number_of_months_in_a_year;i++){
            		newcal.add(Calendar.MONTH,1);
        			System.out.println("Date after addition of  months"+newcal.getTime());
        			taskList = prepareTaskList(newcal, practiceInfo, dateRule, taskList);
            	}
            }else{
                taskList = prepareTaskList(cal, practiceInfo, dateRule, taskList);
            }
            cal = getTodaysCalendar();
        }

        taskModuleDao.generateTasks(taskList);

        logger.info("End. All Task generated SUCCESSFULLY..!" + new Date());
    }

    private List<BaseTask> prepareTaskList(Calendar cal,
        ClientPracticeInfo practiceInfo, DueDateRule dateRule,
        List<BaseTask> taskList) {
        int taskCount = 1; // default to 1

            if (dateRule.getGeneratedTaskDate() == null) {
                taskCount = 1;
            } else {
                // TODO calcualte the diff of time elapsed since last gen and
                // create those many task
            }
       
        for (int i = 0; i < taskCount; i++) {
            BaseTask task = populateTask(cal, practiceInfo, dateRule);
            logger.info("This is Task "+i+" and its Id="+task.getId());
            taskList.add(task);
        }

        return taskList;
    }

    private BaseTask populateTask(Calendar cal,
        ClientPracticeInfo practiceInfo, DueDateRule dateRule) {
        BaseTask task = null;
        List reminderRuleList = null;
        List reminderRuleListTemp = new ArrayList();

        if (dateRule instanceof FilingDueDateRule) {
            task = new FilingTypeTask();
            task.setClientPracticeInfo(practiceInfo);
            reminderRuleList = practiceInfo.getFilingReminderRules();

            TaxInfoFilingType filing = new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId());

             task.setFilingTitle("Tax Filing Type");
        } else if (dateRule instanceof InstallmentDueDateRule) {
            task = new InstallmentTypeTask();
            task.setClientPracticeInfo(practiceInfo);
            reminderRuleList = practiceInfo.getInstallmentReminderRules();

            TaxInfoFilingType filing = new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId());

             task.setFilingTitle("Installment Filing Type");
        }

        for (Iterator it = reminderRuleList.iterator(); it.hasNext();) {
            if (dateRule instanceof FilingDueDateRule) {
                FilingReminderRule filingRemindRule = (FilingReminderRule) it.next();

                if (filingRemindRule != null) {
                    ReminderRule remindRule = filingRemindRule;

                    remindRule.setReminderDay(Short.valueOf(
                            filingRemindRule.getReminderDayCode().getShortName()));
                    reminderRuleListTemp.add(remindRule);
                }
            } else if (dateRule instanceof InstallmentDueDateRule) {
                InstallmentReminderRule installmentRemindRule = (InstallmentReminderRule) it.next();

                if (installmentRemindRule != null) {
                    ReminderRule remindRule = installmentRemindRule;

                    remindRule.setReminderDay(Short.valueOf(
                            installmentRemindRule.getReminderDayCode()
                                                 .getShortName()));
                    reminderRuleListTemp.add(remindRule);
                }
            }
        }

        task.setDueDate(cal.getTime());              //this is line task is getting assigned with time and later going to save in Notification table.

        task.setClient(practiceInfo.getClient());
        // task.setTaxClientPracticeType(practiceInfo);
        task.setFirm(practiceInfo.getFirm());
        task.setPracticeId(practiceInfo.getFirmPracticeType()
                                       .getTaxApplicationPracticeType());
        dateRule.setGeneratedTaskDate(task.getDueDate());
        //         task.setFilingType(dateRule.getTaxInfoFilingType());
        task.setStatus(taskModuleDao.getTaskStatusById(
                TaskStatus.TASK_STATUS_TYPE_NEW.getId()));
        task.setStaffInCharge(practiceInfo.getStaffInCharge());

        task.setPartnerInCharge(practiceInfo.getPartnerInCharge());
        task.setClientStaffInCharge(practiceInfo.getClientStaffInCharge());
        task.setTaxInfoDueDateRule(dateRule);
        task.setTaskNotificationList(getNotificationList(reminderRuleListTemp,
                task));

        logger.debug(practiceInfo.getClientStaffInCharge().getFirstName() + "" +
            practiceInfo.getFilingDateRule());

        return task;
    }

    private List<TaskNotification> getNotificationList(List reminderRuleList,
        BaseTask task) {
        List<TaskNotification> notificationList = new ArrayList();

        for (Iterator it = reminderRuleList.iterator(); it.hasNext();) {
            ReminderRule reminderRule = (ReminderRule) it.next();

            if (reminderRule != null) {
                TaskNotification notification = prepareNotification(task,
                        reminderRule, task.getDueDate());
                notificationList.add(notification);
            }
        }

        return notificationList;
    }

    private TaskNotification prepareNotification(BaseTask task,
        ReminderRule reminderRule, Date dueDate) {
        TaskNotification notification = new TaskNotification();
        notification.setBaseTask(task);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dueDate);
        cal.add(Calendar.DATE, -reminderRule.getReminderDay());   //Savitri did -reminder 
//        cal.add(Calendar.DATE, +reminderRule.getReminderDay());  //sagar did +reminder

        Date notifcationDate = cal.getTime();
        notification.setNotificationDate(notifcationDate);

        // notification.setBaseTask(task);
        return notification;
    }

    public Calendar getTodaysCalendar() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        return cal;
    }

    public Calendar addRecurringRange(Calendar cal, int field,
        int toBeAddedValue) {
        int current = cal.get(field);
        cal.set(field, current + toBeAddedValue);

        return cal;
    }

    @Transactional(readOnly=false)
    @Override
    public void sendReminders() {
        Date notificationDate = new Date();

        String to = null;
        logger.info("Send Mail started..!" + new Date());

        List<Long> notificationsFromDB = taskModuleDao.getNotificationCountByDate(notificationDate);
        //List<TaskNotification> tempNot=new ArrayList<TaskNotification>();
        int count=0;
        for (int i = 0; i < notificationsFromDB.size(); i++) {
                count++;
            TaskNotification taskNotification = taskModuleDao.getTaskNotificationById(notificationsFromDB.get(i));
            //BaseTask task = taskNotification.getBaseTask();
            Long newTaskId = taskNotification.getId();
            BaseTaskDTO task = taskModuleDao.getBaseTaskById(newTaskId);
           /* EmailCommunication emailId = task.getClientStaffInCharge().getParty().getDefaultPartySite()
                                             .getDefaultPointOfContact()
                                             .getEmailList().get(0);*/
            Long taskId = task.getId();
            Long staffId = task.getStaffId();
            Long clientStaffId = task.getClientStaffId();
            Long partnerId = task.getPartnerId();
            Long firmId = task.getFirmId();
            Person staff = crmDao.getPersonById(staffId);
            Person client = crmDao.getPersonById(clientStaffId);
            Person partner = crmDao.getPersonById(partnerId);
            Party firm = crmDao.getPartyById(firmId);
            Party partnaerfirm = crmDao.getPartyById(partnerId);
            
            to = client.getUserName();
            if(to!=null){
                    String sub;
                    String body;
                    TaskNotificationTemplate taskNotificationTemplate=null;
                    Person partnerInchange = partner;
                    String partnerName = nullHandler(partner.getFirstName());
                    String partnerEmail = nullHandler(partnerInchange.getUserName());
                   
                    //String partnerPhone = nullHandler(partnaerfirm.getDefaultPartySite().getDefaultPointOfContact().getPhoneList().get(0).getContactDetail());
                    String partnerPhone = "";
                    //REPLACE THE ABOVE AFTER FINDING PARTNER PH
                    
                    String firmName = nullHandler(firm.getName());
                	String firmAddressLineOne = nullHandler(firm.getDefaultPartySite().getAddress().getAddressLine1());
                	String firmAddressLineTwo = nullHandler(firm.getDefaultPartySite().getAddress().getAddressLine2());
                	String firmCity = nullHandler(firm.getDefaultPartySite().getAddress().getCity());
                	Code firmState = crmmanager.getCodeById(partnaerfirm.getDefaultPartySite().getAddress().getStateCode());
                    Code firmCountry = crmmanager.getCodeById(partnaerfirm.getDefaultPartySite().getAddress().getCountryCode());
                    String firmPostalCode = nullHandler(firm.getDefaultPartySite().getAddress().getPostalCode());
                    String clientName = nullHandler(client.getFirstName());
                	String Lastname = client.getLastName();
                	if(client.getLastName() != null){
                		clientName = clientName +" "+ Lastname;
                	}
                	Date newDate = task.getDueDate();
            		java.sql.Date sqlDate = new java.sql.Date(newDate.getTime());
            	    System.out.println("utilDate:" + newDate);
            	    System.out.println("sqlDate:" + sqlDate);
            	    DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
            	    String text = df.format(sqlDate);
                	System.out.println("Today's date :"+text);
                    if(task.getFilingTitle().equals("Tax Filing Type")){
                    	taskNotificationTemplate=taskModuleDao.getTaskNotificationTemplate(new Long(7));
                    	sub = String.format(taskNotificationTemplate.getSubject(),
                    			clientName, task.getPracticeId());
                    	body = String.format(taskNotificationTemplate.getBodyText(), clientName,task.getPracticeId(), 
                    			text, task.getNewStatus(), partnerName,partnerEmail,partnerPhone,
                    			firmName,firmAddressLineOne, firmAddressLineTwo, firmCity, firmState.getShortName(), firmCountry.getShortName(), firmPostalCode); 
                    }else{
                    	taskNotificationTemplate=taskModuleDao.getTaskNotificationTemplate(new Long(8));
                    	sub = String.format(taskNotificationTemplate.getSubject(),
                    			clientName, task.getPracticeId());
                    	
                    	body = String.format(taskNotificationTemplate.getBodyText(),clientName, task.getPracticeId(),
                    			"#",text, partnerName,partnerEmail,partnerPhone,
                    			firmName,firmAddressLineOne, firmAddressLineTwo, firmCity, firmState.getShortName(), firmCountry.getShortName(), firmPostalCode); 
                         }
                    StringBuffer cc = new StringBuffer(100);
                    String newStaffId = staff.getUserName();
                    
                   /* if(newStaffId != null){
                        cc.insert(0,newStaffId);
                      }
                      else{
                        cc.insert(0,"practicem62@gmail.com"); 
                      }*/
                    if(newStaffId == null){
                    	cc.insert(0,"practicem62@gmail.com"); 
                    }else{
                    	 cc.insert(0,newStaffId);
                    }
                    String bcc = "apoorvada@yahoo.com";
                    //String adminId = taskNotificationTemplate.getAdminEmailId();
                    if(partnerEmail != null){
                    bcc= partnerEmail;
                    }
                    email.newSendMailTax("practicem62@gmail.com", to,newStaffId,bcc,sub, body);
                    
                    /*taskNotification.setSentDate(notificationDate);
                    taskNotification.setSentTo(to);
                    tempNot.add(taskNotification);*/
                    crmmanager.updateNotification(notificationDate,to,taskId,newTaskId);            
                    logger.info("This is "+i+" and Notification number ="+taskNotification.getId());
            }
        }
        /*for (TaskNotification taskNotification2 : tempNot) {
        	updateNotification(taskNotification2);
		}*/
       
        logger.info("All Mail for the day has been sent SUCCESSFULLY..!"+new Date());
    }
    
    private String nullHandler(String val1){
    	String duplicateVal = "";
    	if(val1 == null){
    		val1 = duplicateVal;
    	}
		return val1;
    }

	private void updateNotification(TaskNotification taskNotification2) {
		taskModuleDao.saveTaskNotification(taskNotification2);	
	}

	@Override
    public TaskNotificationTemplate getTaskNotificationTemplate(Long id) {
        return taskModuleDao.getTaskNotificationTemplate(id);
    }

    @Override
    public List<TaskNotificationTemplate> getTaskNotificationTemplateList() {
        return taskModuleDao.getTaskNotificationTemplateList();
    }

    @Override
    @Transactional
    public void saveTaskNotificationTemplate(
        TaskNotificationTemplate notificationTemplate) {
        taskModuleDao.saveTaskNotificationTemplate(notificationTemplate);
    }

    @Override
    public TaskNotificationRecipient getNotificationRecipient(Long id) {
        return taskModuleDao.getNotificationRecipient(id);
    }

    @Override
    @Transactional
    public void saveTaskNotificationRecipient(
        TaskNotificationRecipient notificationRecipient) {
        taskModuleDao.saveTaskNotificationRecipient(notificationRecipient);
    }

    @Override
    public List<TaskNotificationRecipient> getTaskNotificationRecipientList() {
        return taskModuleDao.getTaskNotificationRecipientList();
    }

	@Override
	public List<Task> getTasksListAssignedForAStaff(Long page, Date dueDate,
			Long partyId) {
		// TODO Auto-generated method stub
		return taskModuleDao.getTasksListAssignedForAStaff(dueDate, page, partyId);
	}

	@Override
	public List<Task> getTasksListForAFirm(Long count, Long mainPartyId) {
		// TODO Auto-generated method stub
		//List<TaskDTO> taskList = taskModuleDao.getTasksDTOListForAFirm(count, mainPartyId);
		return taskModuleDao.getTasksListForAFirm(count, mainPartyId);
		
	}
	@Override
	public List<TaskDTO> getTasksDTOListForAFirm(Long count, Long mainPartyId){
		List<TaskDTO> taskList = taskModuleDao.getTasksDTOListForAFirm(count, mainPartyId);
		return taskList;
	}

	 @Override
	    public Long getTasksCount(Long partyId) {
	        // TODO Auto-generated method stub
	        return taskModuleDao.getTasksCount(partyId);
	    }
	 @Override
	 public Long getTaskCountFromNativeSQL(Long mainPartyId){
		 return taskModuleDao.getTaskCountFromNativeSQL(mainPartyId);
	 }

	@Override
	@Transactional (readOnly=true)
	public Long getTaskListCount(Long firmId, Long userId,String userRole, int dateRangeType,
			List taskStatusList) {
		Date startDate = null;
		Date endDate = null;
		
		if((PMConstants.MISSED_DEADLINE == dateRangeType) || (PMConstants.WAITING_STATUS == dateRangeType)){
			startDate = new Date();
		}else {
			Calendar cal = Calendar.getInstance();
			startDate = cal.getTime();
			cal.add(Calendar.DATE, dateRangeType);
			endDate = cal.getTime();
			
		}
		
		return taskModuleDao.getTaskListCount(firmId, userId, userRole, startDate, endDate, taskStatusList);
	}

	@Override
	public List<TaskDTO> getTaskLists(Long firmId, Long userProfileId,
			String userRole, int dateRangeType, List taskStatusList, Long count) {
		//TODO remove time component of this Date as in PMUTIL or WEBUTIL class
		Date startDate = null;
		Date endDate = null;
		if((PMConstants.MISSED_DEADLINE == dateRangeType) || (PMConstants.WAITING_STATUS == dateRangeType)){
			startDate = new Date();
		}else {
			Calendar cal = Calendar.getInstance();
			startDate = cal.getTime();
			cal.add(Calendar.DATE, dateRangeType);
			endDate = cal.getTime();
		}
		return taskModuleDao.getTaskLists(firmId, userProfileId, userRole, startDate, endDate, taskStatusList, count);
	}

	@Override
	public Long getTaskCountCalender(Long firmId, Long userProfileId,
			String userRole, List taskStatusList) {
		return taskModuleDao.getTaskCountCalender(firmId, userProfileId, userRole, taskStatusList);
	}

	@Override
	public List<EventDTO> getTaskListCalender(Long firmId, Long userProfileId,
			String userRole, List taskStatusList, Long count) {
		return taskModuleDao.getTaskListCalender(firmId, userProfileId, userRole, taskStatusList, count);
	}
	
	@Override
	@Transactional
	public void saveTask(Task task) {
		taskModuleDao.saveTask(task);
	    }
	
	@Override
	public void removeAdhocTaskById(Long id) {
		taskModuleDao.removeAdhocTaskById(id);
	}

	@Override
	public List<TaskDTO> getTasksDTOListForAFirmNew(Long newFirmId) {
		return taskModuleDao.getTasksListForAFirmNew(newFirmId);
	}
	
	@Override
	public List<TaskDTO> getTasksDTOListForAFirm(Page page, Long mainPartyId){
		List<TaskDTO> taskList = taskModuleDao.getTasksDTOListForAFirm(page.getCount(), page.getLimit(), page.getStart(), mainPartyId);
		return taskList;
	}

	public List<TaskDTO> getCliListForDash(Long firmId) {
		return taskModuleDao.getCliListForDash(firmId);
	}

	@Override
	public void deleteTask(boolean activeFlag, Long newId) {
		taskModuleDao.deleteTask(Boolean.FALSE, newId);
		
	}
}
