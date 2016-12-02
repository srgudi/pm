package com.chiguru.pm.web.controller.tax;

import com.chiguru.pm.core.common.utilities.EmailService;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.tax.dao.TaskModuleDao;
import com.chiguru.pm.tax.domain.PaymentType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.domain.ReminderRule;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import java.beans.PropertyEditorSupport;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.util.regex.*;   
import java.sql.Timestamp;

@Controller
public class TaskModuleController {
	
	private static final Long STAFF_REMINDER_TEMPLATE_NUMBER = new Long(1);
	private static final Long CLIENT_REMINDER_TEMPLATE_NUMBER = new Long(2);
	private static final Long TASK_COMPLETED_REMINDER_TEMPLATE_NUMBER = new Long(3);
	private static final Long NEW_ADHOC_REMINDER_TEMPLATE_NUMBER = new Long(4);
	
    private Logger logger = org.slf4j.LoggerFactory.getLogger(TaskModuleController.class);
    @Autowired
    private CRMManager crmManager;
    @Autowired
    private CodesManager codesManager;
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    protected TaskModuleDao taskModuleDao;
    @Autowired
    protected EmailService emailService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Long.class, "myLong",
            new CustomNumberEditor(Long.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
                }
            });

        binder.registerCustomEditor(List.class, "taxInfoReminders",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    String reminders = (String) element;

                    //Integer dueDay = dueDate[0];
                    //Integer dueMonth = dueDate[1];
                    ReminderRule reminder = new ReminderRule();

                    //reminder.setReminderDay(reminders[0]);
                    //taxDueDate.setDueMonth(dueMonth);
                    return reminder;
                }
            });

        binder.registerCustomEditor(Integer.class, "myInt",
            new CustomNumberEditor(Integer.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
                }
            });

        binder.registerCustomEditor(Code.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(codesManager.getCodeById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        Code code = (Code) getValue();

                        return code.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(TaxInfoFilingType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taxModuleManager.getTaxInfoFilingType(
                                Integer.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        TaxInfoFilingType type = (TaxInfoFilingType) getValue();

                        return type.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(Party.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPartyById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Party party = (Party) getValue();

                        if ((party != null) && (party.getId() != null)) {
                            retValue = party.getId().toString();
                        }
                    }

                    return retValue;
                }
            });
        binder.registerCustomEditor(Person.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPersonById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Person person = (Person) getValue();

                        if ((person != null) && (person.getId() != null)) {
                            retValue = person.getId().toString();
                        }
                    }

                    return retValue;
                }
            });

        binder.registerCustomEditor(Jurisdiction.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getJurisdictionById(Long.valueOf(
                                    text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Jurisdiction jurisdiction = (Jurisdiction) getValue();

                        if ((jurisdiction != null) &&
                                (jurisdiction.getId() != null)) {
                            retValue = jurisdiction.getId().toString();
                        }
                    }

                    return retValue;
                }
            });
        
        /*binder.registerCustomEditor(TaskStatus.class,
                new PropertyEditorSupport() {
                    @Override
                    public void setAsText(String text)
                        throws IllegalArgumentException {
                        if ("null".equals(text) || "-1".equals(text) ||
                                "".equals(text)) {
                            setValue(null);
                        } else {
                            setValue(taxModuleManager.getStatusById(Integer.valueOf(text)));
                        }
                    }

                    public String getAsText() {
                        String retValue = null;

                        if (getValue() != null) {
                        	TaskStatus status = (TaskStatus) getValue();

                            if ((status != null) &&
                                    (status.getId() != null)) {
                                retValue = status.getId().toString();
                            }
                        }

                        return retValue;
                    }
                });*/

        binder.registerCustomEditor(TaskStatus.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taxModuleManager.getStatusById(Integer.valueOf(
                                    text)));
                       
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        TaskStatus code = (TaskStatus) getValue();

                        return code.getId().toString();
                    } else {
                        return null;
                    }
                }
            });
        
        binder.registerCustomEditor(PracticeType.class,
                new PropertyEditorSupport() {
                    @Override
                    public void setAsText(String text)
                        throws IllegalArgumentException {
                        if ("null".equals(text) || "-1".equals(text) ||
                                "".equals(text)) {
                            setValue(null);
                        } else {
                            setValue(taxModuleManager.getPracticeTypeById(Long.valueOf(text)));
                        }
                    }

                    public String getAsText() {
                        String retValue = null;

                        if (getValue() != null) {
                        	PracticeType practiceType = (PracticeType) getValue();

                            if ((practiceType != null) && (practiceType.getId() != null)) {
                                retValue = practiceType.getId().toString();
                            }
                        }

                        return retValue;
                    }
                });

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute("task")
    public Task initializeModel(Long taskId, Long id, Long clientId,
        HttpServletRequest request) {
        Task task = null;
        
        String entityKey = request.getParameter("entityKey");
        if(StringUtils.hasText(entityKey)){
        	/*taskId = TextEncryptUtil.decryptToLong(entityKey);*/
        	taskId = Long.parseLong(entityKey);
        }

        if (taskId == null) {
            task = new Task();
            task.setTaskType("ADHOC");
        } else {
            task = taxModuleManager.getTaskById(taskId);
            /*task.setEntityKey(TextEncryptUtil.encryptForLong(taskId));*/
            task.setEntityKey(taskId.toString());
            Party newparty;
            newparty = crmManager.getPartyById(task.getClientStaffInCharge());
            task.setClientStaffInChargeName((newparty.getName()));
            newparty = crmManager.getPartyById(task.getPartnerInCharge());
            task.setPartnerInChargeName((newparty.getName()));
            newparty = crmManager.getPartyById(task.getStaffInCharge());
            task.setStaffInChargeName((newparty.getName()));
        }

        return task;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = {"/task/taskModule.do","/mobiletask/mobileTaskmodule.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveTask(HttpServletRequest request, Long taskId, Task task,
        BindingResult result, SessionStatus status) {
         logger.info("Client Module Save!");
         
         Long firmId = PMUtil.getFirmIdFromSession(request);
         HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"entityKey\":");
		 String taskStatus = task.getStatus().getStatusName();
		 String taskType = task.getTaskType();
		 
		 Party client = task.getClient();
		 Party staff = crmManager.getPartyById(task.getStaffInCharge());
		 Party partner = crmManager.getPartyById(task.getPartnerInCharge());
		 Party clientStaff = crmManager.getPartyById(task.getClientStaffInCharge());
		 Organization clientOrg = client.getOrganization();
		 String staffPhone = null,clientMail = null,clientPhone = null,partnerMail = null;
		 String staffEmail="";
		 
		 if(!clientStaff.getDefaultPartySite().getDefaultPointOfContact().getEmailList().isEmpty()){
			 clientMail = clientStaff.getDefaultPartySite().getDefaultPointOfContact().getEmailList().get(0).getContactDetail();
		 }
		
		 if(!clientStaff.getDefaultPartySite().getDefaultPointOfContact().getPhoneList().isEmpty()){
			 clientPhone = clientStaff.getDefaultPartySite().getDefaultPointOfContact().getPhoneList().get(0).getContactDetail();
		 }
		 
		 
		 if(!staff.getDefaultPartySite().getDefaultPointOfContact().getPhoneList().isEmpty()){
			 staffPhone = staff.getDefaultPartySite().getDefaultPointOfContact().getPhoneList().get(0).getContactDetail();
		 }
		 
		 if(!staff.getDefaultPartySite().getDefaultPointOfContact().getEmailList().isEmpty()){
			 staffEmail = staff.getDefaultPartySite().getDefaultPointOfContact().getEmailList().get(0).getContactDetail();
		 }
		 
		 if(!partner.getDefaultPointOfContact().getEmailList().isEmpty()){
			 partnerMail = partner.getDefaultPointOfContact().getEmailList().get(0).getContactDetail();
		 }
		 
		 Boolean mailDelivery = false;
		 
		 if(taskStatus != null){
			 
			 TaskNotificationTemplate taskNotificationTemplate=null;
			 String sub = null,body = null,cc,to = null;
			 cc = nullHandler(partner.getDefaultPointOfContact().getEmailList().get(0).getContactDetail());
			
			 
			 if(taskStatus.equalsIgnoreCase("Awaiting Client Response")){
				 
			     taskNotificationTemplate = taskModuleDao.getTaskNotificationTemplate(STAFF_REMINDER_TEMPLATE_NUMBER);
				 sub = String.format(taskNotificationTemplate.getSubject());
				 body = String.format(taskNotificationTemplate.getBodyText(),nullHandler(client.getName()),nullHandler(task.getPracticeId().getName()),task.getDueDate(),
						 nullHandler(staff.getName()),nullHandler(staff.getPerson().getUserName())
						 ,nullHandler(staffPhone));
				 to = nullHandler(clientMail);

				 mailDelivery = mailSend(responseHeaders, responseText, sub, body, cc, to);
				 
			 }else if(taskStatus.equalsIgnoreCase("Processed")){
				 
				 taskNotificationTemplate = taskModuleDao.getTaskNotificationTemplate(CLIENT_REMINDER_TEMPLATE_NUMBER);
				 sub = String.format(taskNotificationTemplate.getSubject());
				 body = String.format(taskNotificationTemplate.getBodyText(),nullHandler(staff.getName()),nullHandler(task.getPracticeId().getName()),task.getDueDate(),
						 nullHandler(clientOrg.getLegalName()),nullHandler(clientMail),nullHandler(clientPhone));
				 to = nullHandler(staff.getPerson().getUserName());

				 mailDelivery = mailSend(responseHeaders, responseText, sub, body, cc, to);
				 
			 }else if(taskStatus.equalsIgnoreCase("Completed")){
				 
				 taskNotificationTemplate = taskModuleDao.getTaskNotificationTemplate(TASK_COMPLETED_REMINDER_TEMPLATE_NUMBER);
				 sub = String.format(taskNotificationTemplate.getSubject());
				 body = String.format(taskNotificationTemplate.getBodyText(),nullHandler(client.getName()),nullHandler(task.getPracticeId().getName()),task.getDueDate(),
						 nullHandler(staff.getName()),nullHandler(staffEmail),nullHandler(staffPhone));
				 to = nullHandler(clientMail);

				 mailDelivery = mailSend(responseHeaders, responseText, sub, body, cc, to);
				 
			 }else if(taskStatus.equalsIgnoreCase("New")){
				 if(taskType.equalsIgnoreCase("ADHOC"))
				 {
					 taskNotificationTemplate = taskModuleDao.getTaskNotificationTemplate(NEW_ADHOC_REMINDER_TEMPLATE_NUMBER);
					 sub = String.format(taskNotificationTemplate.getSubject(),clientOrg.getLegalName(),task.getPracticeId().getName());
					 body = String.format(taskNotificationTemplate.getBodyText(),nullHandler(clientStaff.getName()),nullHandler(task.getPracticeId().getName()),task.getDueDate(),
							 nullHandler(staff.getName()),nullHandler(staff.getPerson().getUserName()),
							 nullHandler(staffPhone));
					 to = nullHandler(clientMail);
					 mailDelivery = mailSend(responseHeaders, responseText, sub, body, cc, to);
					 
				 }
				 else if(taskType.equalsIgnoreCase("SCHEDULED"))
				 {
					 //mail need not be sent for this condition.
					 mailDelivery = true;
				 }
				 
			 }
			 
			 
		 }
		 
		 if(mailDelivery == false){
			 responseText.append("\""+-2+"\"}");
			 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
		 }

        if(task.getId() == null){
        	task.setFirm(crmManager.getOrganizationById(firmId));
        	//System.out.println("filing type:" + TaxInfoFilingType.TAX_FILING_TYPE.getId());
        	if(task.getFilingType() == 1){
            	task.setFilingTitle("Tax Filing Type");
            }else{
            	task.setFilingTitle("Installment Filing Type");
            }
        }
        
        task = generateTaskNote(task);
              try{
        	          taxModuleManager.saveTask(task);
			          /*responseText.append("\""+TextEncryptUtil.encryptForLong(task.getId())+"\"}");*/
        	          responseText.append("\""+task.getId()+"\"}");
				 	  logger.info("TaskModule SAVED ****** "+task.getId());
	               
	           }catch(Exception e){
	          logger.error("Exception occurred during save for Task Module "+ task.getId() +e.getMessage());
	          responseText.append("\""+-1+"\"}");
	          
	         }
		 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
		
    }



    private Boolean mailSend(HttpHeaders responseHeaders,
			StringBuffer responseText, String sub, String body, String cc,
			String to) {
    	Boolean mailStatus = false;
		try {
			emailService.newSendMailTax("practicem62@gmail.com", to, cc, "practicem62@gmail.com", sub, body);
			mailStatus = true;
		  } catch (Exception e) {
			e.printStackTrace();
		}
		return mailStatus;
	}

    
    private String nullHandler(String val1){
    	String duplicateVal = " ";
    	if(val1 == null){
    		val1 = duplicateVal;
    	}
		return val1;
    }


	@RequestMapping(value = {"/task/taskModule.do","/mobiletask/mobileTaskmodule.do"}, method = RequestMethod.GET)
    public String getTaskModule(HttpServletRequest request, @ModelAttribute("task")Task task,
        Long taskId, Long clientId, ModelMap model) {
        logger.info("Client Module!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        Page page = PMUtil.populatePageObject(request);
        
        setDataForUI(request, model, task, firmId, page);
        
       // String taskNote = task.getTaskNote();
        String taskNote = "";
        List<String> list = new ArrayList<String>();
        taskNote = generateFormattedTaskNote(task,list,taskNote);
        model.addAttribute("taskNote", taskNote);
        String servletPath = request.getServletPath();
        if (servletPath.equals("/task/taskModule.do")) {
           return "taskModule.tilesView";
        }else{
           return "mobileTaskModule.tilesView";
        }
    }
    
    
    @RequestMapping(value = "/task/demoTaskModule.do", method = RequestMethod.GET)
    public String getDemoTaskModule(HttpServletRequest request, Task task,  
        Long taskId, Long clientId, ModelMap model) {
        logger.info("Client Module!");
        
        Long firmId = PMUtil.getFirmIdFromSession(request);
        Page page = PMUtil.populatePageObject(request);
        setDataForUI(request, model, task, firmId, page);
        return "demoTaskModule.tilesView";
//        return "task/demoTask";
    }

    @RequestMapping(value = "/calendar.do", method = RequestMethod.POST)
    public void getCalendarModule(HttpServletRequest request, Task task,
        Long taskId, Long firmId, Long clientId, ModelMap model) {
        logger.info("Calendar Module!");
    }

//    @RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	@RequestMapping(value = {"/calendar/calendar.do","/calendar/calendarMobile.do"}, method = RequestMethod.GET)
    public String saveCalendarModule(HttpServletRequest request, Task task,
        Long taskId, Long clientId, ModelMap model) {
        logger.info("Calendar Module!");
        //Long firmId = PMUtil.getFirmIdFromSession(request);
        String servletPath = request.getServletPath();
        if (servletPath.equals("/calendar/calendar.do")) {
          return "calendar.tilesView";
        }else {
          return "calendarMobile.tilesView";
        }
    }

    private void setDataForUI(HttpServletRequest request, ModelMap model,
        Task task, Long firmId, Page page) {
    	String userRole = null;
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	     List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
	      userRole = grantedAuthorityImpls.get(0).toString();
        if (TaxInfoFilingType.TAX_FILING_TYPE.getId().equals(task.getFilingType())){
            task.getPracticeId().setDescription("Tax Filing Type");
        } else if(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId().equals(task.getFilingType())){
            task.getPracticeId().setDescription("Installment Filing Type");
        }
        if(task.getClient() != null){
        	List<KeyValue> clientStaffList = PMUtil.getCachedDropdownPartyList(task.getClient().getId(), RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),crmManager);
        	model.put("clientStaffList",clientStaffList);
        }
        
        List<KeyValue> staffList = PMUtil.getCachedDropdownPartyList(firmId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
        model.put("staffList", staffList);
        
        List<KeyValue> partnerList = PMUtil.getCachedDropdownPartyList(firmId, RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),crmManager);
        model.put("partnerList", partnerList);
        
        List<TaskStatus> statusList = taxModuleManager.getTaskStatusList();
        model.addAttribute("statusCodeList", statusList);
        
        List<PaymentType> paymentTypeList = taxModuleManager.getPaymentTypeList();
        model.addAttribute("paymentTypeList", paymentTypeList);
        
        if(task.getId() == null){
        	List<Party> partyListFromDB = crmManager.getRelatedPartiesById(firmId,RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(), page);
        	model.put("clientList",partyListFromDB);
        	for (TaskStatus taskStatus : statusList) {
        		if(taskStatus.getId() == 3){
        			task.setStatus(taskStatus);
        		}
        	}
//        	setReferenceData(model);
        	List<TaxInfoFilingType> listOfAllFilingType = new ArrayList<TaxInfoFilingType>();
            listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId()));
            listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId()));
            
            List<PracticeType> listOfAllPracticeType = taxModuleManager.getPractTypesByFirmId(firmId);

            model.put("filingTypeList",listOfAllFilingType);
            model.put("taxTypeList",listOfAllPracticeType );
        }
        PMUtil.showStatusMessage(request, model);
    }

    /*private void setReferenceData(ModelMap model) {
        
        List<TaxInfoFilingType> listOfAllFilingType = new ArrayList<TaxInfoFilingType>();
        listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId()));
        listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId()));
        
        List<PracticeType> listOfAllPracticeType = taxModuleManager.getPracticeType();

        model.put("filingTypeList",listOfAllFilingType);
        model.put("taxTypeList",listOfAllPracticeType );
    }*/

    /*private List<Party> getStaffData(Long partyId) {
        return crmManager.getRelatedPartiesById(partyId,
            RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId());
    }

    private List<Party> getStaffChargeData(Long partyId) {
        List<RelationshipType> listOfRelationshipType = new ArrayList<RelationshipType>();
        listOfRelationshipType.add(RelationshipType.RELATIONSHIP_TYPE_STAFF);
        listOfRelationshipType.add(RelationshipType.RELATIONSHIP_TYPE_PARTNER);

        return crmManager.getRelatedPartiesById(partyId, listOfRelationshipType);
    }

    private List<Party> getStaffInChargeData(Long partyId) {
        return crmManager.getRelatedPartiesById(partyId,
            RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
    }

    private List<Party> getPartnerInChargeData(Long partyId) {
        return crmManager.getRelatedPartiesById(partyId,
            RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
    }*/
    
    
    private Task generateTaskNote(Task task){
    	Timestamp ts = new Timestamp(System.currentTimeMillis());
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        if((!task.getPreviousStaff().isEmpty())&&(!task.getPreviousStaff().equals("-1"))){
        	Long id = Long.parseLong(task.getPreviousStaff());
        	String previousStaffName = taxModuleManager.getFirmStaffName(id);
        	String assignedTo = taxModuleManager.getFirmStaffName(task.getStaffInCharge());
        	String changedAssigne = dateFormat.format(ts)+" "+"Assigned from"+" "+" "+previousStaffName+" "+"to"+" "+assignedTo;
        	if(task.getTaskNote() == null){
        		// task.setTaskNote(changedAssigne+"<br/>");
        		task.setTaskNote(changedAssigne);
        	}else{
        	//task.setTaskNote(changedAssigne+"<br/>"+task.getTaskNote());
        		task.setTaskNote(changedAssigne+task.getTaskNote());
        	}
        }
       if (!task.getTaskNoteWithOutTimeStamp().isEmpty()){
        String noteWithTimeStamp = dateFormat.format(ts)+" "+task.getTaskNoteWithOutTimeStamp();
        System.out.println(noteWithTimeStamp);
        if(task.getTaskNote() == null){
      	 // task.setTaskNote(noteWithTimeStamp+"<br/>");
        	task.setTaskNote(noteWithTimeStamp);
        }else{
       // task.setTaskNote(noteWithTimeStamp+"<br/>"+task.getTaskNote());
        	 task.setTaskNote(noteWithTimeStamp+task.getTaskNote());
        }
  }
       return task;
   }
    

	private String generateFormattedTaskNote(Task task,List<String> list,String taskNote){
	 String dateData = null;
        if (task.getTaskNote()!= null){
            dateData = task.getTaskNote();
            String datePatt = "[0-1]\\d/[0-3]\\d/[1-2]\\d{3}[ ][0-1]\\d[:][0-5]\\d[:][0-5]\\d[ ]"; 
           Pattern datePattern = Pattern.compile(datePatt);
            Matcher matchDate = datePattern.matcher(dateData); 
            int i =1;
           // taskNote = dateData;
            while (matchDate.find()){
              	String[] parts = dateData.split(datePatt);
              	String beforeFirstDot = parts[i];
              	String finalString = matchDate.group()+"&nbsp;&nbsp;&nbsp;"+beforeFirstDot;
              	list.add(finalString);
              	i++;
              }
             for (String s : list)
            {
          	   taskNote += s + "<br/>";
          	}
        }     
        return taskNote;
}
    
   
}