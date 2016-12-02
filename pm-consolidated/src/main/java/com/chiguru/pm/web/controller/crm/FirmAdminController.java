package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.Set;

import com.chiguru.pm.core.common.utilities.EmailService;
import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonDetails;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.tax.dao.TaskModuleDao;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.util.AutoPopulatingList;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class FirmAdminController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(FirmAdminController.class);
    private CRMManager crmManager;
    @Autowired
    protected EmailService emailService;
    @Autowired
    protected TaskModuleDao taskModuleDao;
   
    @Autowired
    public FirmAdminController(CRMManager crmManager) {
        this.crmManager = crmManager;
    }
    private static final Long PASSWORD_RESET_TEMPLATE_NUMBER = new Long(5);
    
    @ModelAttribute
    public Party initializeModel(Long id, Long clientId, Integer relationType,
    		 HttpServletRequest request) {
    	//PropertyChangeSupport changeSupport = new PropertyChangeSupport(this);
    	
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        //removed relationType=1 from Link in clientList.jsp
        String servletPath = request.getServletPath();

        if (servletPath.equals("/client/clientDetail.do")) {
            id = clientId;
        }

        if (RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId()
                                                         .equals(relationType)) {
            id = clientId;
        } else if (RelationshipType.RELATIONSHIP_TYPE_SHAREHOLDER.getId()
                                                                     .equals(relationType)) {
            if (request.getParameter("person") != null) {
                id = Long.valueOf(request.getParameter("person"));
            }
        }

        Party party;

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);

        if ((id != null) && (session.getAttribute("inValidClientId") == null)) {
            party = crmManager.getPartyById(id);

            PartySite site = party.getDefaultPartySite();
        } else {
        	/*if (!request.getMethod().equals("POST")) {*/
        	party = new Party();
        	 /*if (request.getMethod().equals("POST")) {
                party = staffParty;
        	 }*/
            PartySite site = party.getDefaultPartySite();
//            site.setCreateUserId("system");

            PointOfContact contact = site.getDefaultPointOfContact();
//            contact.setCreateUserId("system");
        	/*}*//*else{
        		party = (Party) request.getAttribute("party");
        	}*/
        }
        
        PartySite site = party.getDefaultPartySite();
        PointOfContact pointOfContact = site.getDefaultPointOfContact();
        List phoneList = new AutoPopulatingList(PhoneCommunication.class);
        phoneList.addAll(pointOfContact.getPhoneList());

        List emailList = new AutoPopulatingList(EmailCommunication.class);
        emailList.addAll(pointOfContact.getEmailList());

        List webURLList = new AutoPopulatingList(WebCommunication.class);
        webURLList.addAll(pointOfContact.getWebUrlList());

        List faxList = new AutoPopulatingList(FaxCommunication.class);
        faxList.addAll(pointOfContact.getFaxList());

        site.getDefaultPointOfContact().setPhoneList(phoneList);
        site.getDefaultPointOfContact().setFaxList(faxList);
        site.getDefaultPointOfContact().setEmailList(emailList);
        site.getDefaultPointOfContact().setWebUrlList(webURLList);

        return party;
    }

   
   

        // no longer annotated as model attribute
        // adds the attribute to the model if it does not exist
        protected List<Party> getNumbers(ModelMap model) {
            List<Party> numbers = (List<Party>) model.get("party");
            if (numbers == null) {
                numbers = Arrays.asList(new Party());
                model.addAttribute("numbers", numbers);
            }
            return numbers;
        }

    
    
    /*@RequestMapping(value = "/firmadmin/manageFirmStaff.do", method = RequestMethod.POST)
    @ResponseBody
    public String saveFirmStaff(HttpServletRequest request, ModelMap model,Party newparty, BindingResult bindingResult,
     		 Long clientId,SessionStatus status) {
         logger.info("Firm Staff Save!");
         BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.newparty");
         Long firmId = PMUtil.getFirmIdFromSession(request);
         String userName = null;
         //Party party = new Party();
         //newparty.set(0, getNumbers(model).get(0));
         if(newparty.getId() == null){
 	        PointOfContact poc = newparty.getPartySites().get(0).getPointOfContactList().get(0);
 	        if(poc != null){
 	        	EmailCommunication emailval = poc.getEmailList().get(0);
 	        	if(emailval != null){
 	        		 userName = emailval.getContactDetail();
 	        	}
 	        }
 	        List<Integer> listOfPersonType = new ArrayList<Integer>();
 	        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
 	        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
 	        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
 	        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, firmId);
 	        
 	        boolean isEmailValid = false;
 	        if(userName != null){
 	        for (KeyValue keyValue : eamilList) {
 				if(userName.equals(keyValue.value)){
 					isEmailValid = true;
 				}
 			}
 	        }
 	        if(isEmailValid) {
 	            //this.getFirmStaff(request, model, newparty);
 	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
 	            return null;
 	        }
         }

         if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                 (firmId == null)) {
             throw new RuntimeException("firmId can not be empty");
         }
         
         saveNewPerson(request, firmId, clientId, newparty,result, status);
         String baseURL = "manageFirmStaff.do";
         String returnURL = request.getParameter("baseURL");
         if(newparty != null){
         if(newparty.getNewStat() == null){
        	 newparty.setNewStat(0);
         		returnURL = baseURL +"?saveSuccess=true";
          }
          if(newparty.getNewStat() == 1)
          {
          baseURL = request.getParameter("baseURL");
          if(newparty.getPerson().getParty().id != null){
          returnURL = baseURL +
             "?saveSuccess=true";
          }
          }
         }
         // crmManager.deletePartySiteCommunication(toBeDeletedList);
         return "redirect:" + returnURL;
     }*/
    
    private Party saveNewPerson(HttpServletRequest request, Long firmId,
			Long clientId, Party employeeParty, BindingResult result,
			SessionStatus status) {
    	
    	Party firmParty = crmManager.getPartyById(firmId);
    	
    	PartyType employeePartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        RelationshipType employeeRelationType = new RelationshipType();
        String role= null;
        if(employeeParty.getPerson() != null){
        if (PersonType.PERSON_TYPE_STAFF.equals(employeeParty.getPerson()
                                                                 .getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),
                    crmManager);
            role = "ROLE_STAFF";
        } else if (PersonType.PERSON_TYPE_PARTNER.equals(
                    employeeParty.getPerson().getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),
                    crmManager);
            role = "ROLE_FIRM_PARTNER";
        } else if (PersonType.PERSON_TYPE_FIRM_ADMIN.equals(
                    employeeParty.getPerson().getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_LAW_ADMIN.getId(),
                    crmManager);
            role = "ROLE_FIRM_ADMIN";
        }
        if(employeeParty.getId() == null){
        	employeeParty.getPerson().setUserName(employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail());
        }
        }
        //default staff is giving HOME address
        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
        employeeParty.getDefaultPartySite().setPartySiteType(partySiteType);


        if (role != null) {
            String[] roles = { role };
            Random randomGenerator = new Random();
            int randomInt = randomGenerator.nextInt(1000);
            String userResetPasswordKey = String.valueOf(randomInt);
            String encryptedUserResetPasswordKey = EncryptionUtil.getInstance().encrypt(userResetPasswordKey); 
            //PMUser user = PMUser.constructPMUserForPartyConroller(employeeParty.getUserName(), "", false, relationship.getId(), roles, encryptedUserResetPasswordKey);
             //PMUser user = PMUser.defaultInstance(employeeParty.getUserName(),
              //      "", false, relationship.getId(), roles);
            PMUser user = PMUser.constructPMUserForResetPassword(employeeParty.getUserName(), encryptedUserResetPasswordKey, roles);
            user.setCreatedBy("system");
            String username = employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
            if(username!=null){
            
            user.setUsersKey(encryptedUserResetPasswordKey);
            Date date = new Date();
            Calendar cal = Calendar.getInstance();  
            cal.setTime(date); 
            cal.add(Calendar.DATE,7); 
            date = cal.getTime(); 
            java.sql.Date sqlDate = new java.sql.Date(date.getTime()); 
            user.setUsersExpiryDate(sqlDate);
            //userService.createNewUser(user, roles);
            int currentStatus = 0;
            Person newPerson = new Person();
            newPerson = employeeParty.getPerson();
            if(employeeParty.getName() != null){
              currentStatus = sendPasswordResetLink(employeeParty.getName(), username, encryptedUserResetPasswordKey,firmParty.getName());
            }else if(newPerson != null){
            	String FullName = "Client";
            	String firstName = employeeParty.getPerson().getFirstName();
            	String lastName = employeeParty.getPerson().getLastName();
            	if(firstName != null){
                   FullName = firstName;
            	}
                 if(lastName != null){
            	  FullName = FullName+" "+lastName;
                }
              currentStatus = sendPasswordResetLink(FullName, username, encryptedUserResetPasswordKey,firmParty.getName());
            }
            if(currentStatus == 1){
            	 PartyRelationship relationship = saveParty(firmParty, employeeParty,
                         employeePartyType, null, employeeRelationType,
                         employeeParty.getPerson().getPersonType(), role, clientId);
            	         employeeParty.setNewStat(currentStatus);
            }
            else{
            	employeeParty.setNewStat(currentStatus);
            }
            }
        }
		
        return employeeParty;
	}
    
    public int sendPasswordResetLink(String name, String username,
			String userResetPasswordKey, String Firm) {
		String sub;
		String body;
		ResourceBundle bundle = ResourceBundle.getBundle("pm");
		String hostName = bundle.getString("APP_HOST");
		String portName = bundle.getString("APP_PORT");
		String urlName = bundle.getString("PWD_URL");
		String passwordURL = hostName+":"+portName+urlName+"?userName="+username+"&userResetPasswordKey="+userResetPasswordKey;
		TaskNotificationTemplate taskNotificationTemplate=null;
		if(username!=null){
		    taskNotificationTemplate=taskModuleDao.getTaskNotificationTemplate(PASSWORD_RESET_TEMPLATE_NUMBER);
		}
		sub=String.format(taskNotificationTemplate.getSubject(), name);
		body=String.format(taskNotificationTemplate.getBodyText(), name,username, passwordURL);
		
		int returnCode = -1;
		try {
			//emailService.sendMail("practicem62@gmail.com",username,cc,"practicem62@gmail.com",sub,body);
			emailService.newSendMailTax("practicem62@gmail.com",username,"practicem62@gmail.com","practicem62@gmail.com",sub,body);
			logger.info("Mail sent to user user : " + username);
			returnCode = 1;
		} catch (Exception e) {
			logger.error("Exception for this error is  "
					+ e);
		}
		return returnCode;
	}
    
    private PartyRelationship saveParty(Party mainParty, Party relatedParty,
            PartyType relatedPartyType, OrganizationType relatedOrgType,
            RelationshipType relationshipType, PersonType personType, String role, Long clientId) {
//            relatedParty.setCreateUserId("system");

            relatedParty.setPartyType(relatedPartyType);

            if (relatedOrgType != null) {
                Organization org = relatedParty.getOrganization();
                org.setName(org.getOperatingName());
                relatedParty.setName(org.getName());
                org.setOrganizationType(relatedOrgType);
                org.setParty(relatedParty);

                if (relatedParty.getPartySites() == null) {
                    PartySite partySite = relatedParty.getPartySites().get(0);
                    partySite.setPartySiteType(crmManager.getPartySiteTypeById(
                            PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));
                } else {
                    PartySite partySite = relatedParty.getPartySites().get(0);

                    if (partySite.getId() == null) {
                        partySite.setPartySiteType(crmManager.getPartySiteTypeById(
                                PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));
                    }
                }
            } else if (personType != null) {
                Person person = relatedParty.getPerson();
                relatedParty.setName(person.getFirstName() + " " +
                    person.getLastName());
                person.setPersonType(personType);
                person.setParty(relatedParty);

                PersonDetails details = person.getPersonDetails();
                String emailId = relatedParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
                if(emailId != null){
                person.setUserName(emailId);
                }
                details.setPerson(person);

                PartySite partySite = relatedParty.getPartySites().get(0);
                partySite.setContactName(person.getFirstName());
                partySite.setContactTitle(person.getLastName());
                partySite.setName(person.getFirstName() + " " +
                    person.getLastName());

                Address address = partySite.getAddress();
                Set<PartySite> partySites = new HashSet<PartySite>();
                partySites.add(partySite);
                address.setPartySite(partySite);
                partySites.add(partySite);
                if(partySite.getAddress().getCountryCode() == -1)
                {
                 address.setCountryCode(null);
                 address.setStateCode(null);
                }
                partySite.setParty(relatedParty);

                List<PartySite> list = new ArrayList<PartySite>();
                list.add(partySite);
                relatedParty.setPartySites(list);
            }

            if (relatedParty != null) {
                List<PointOfContact> listOfPointOfContact = relatedParty.getDefaultPartySite()
                                                                        .getPointOfContactList();

                for (PointOfContact pointOfContact : listOfPointOfContact) {
//                    pointOfContact.setCreateUserId("system");
                    pointOfContact.setLastUpdateDate(new Date());
//                    pointOfContact.setLastUpdateUserId("system");
                    pointOfContact.setActiveFlag(true);
                    setPointOfContact(pointOfContact);
                }
            }

            String encryptedPassword = EncryptionUtil.getInstance().encrypt("password");
            PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
                    relatedParty, role, relationshipType, encryptedPassword, null, clientId);
            //crmManager.deletePhoneCommunication(phonesToBeRemoved);

            return rel;
        }
    
    protected void setPointOfContact(PointOfContact poc) {
        setPointOfContact(poc, poc.getEmailList());
        setPointOfContact(poc, poc.getFaxList());
        setPointOfContact(poc, poc.getPhoneList());
        setPointOfContact(poc, poc.getWebUrlList());
    }

    protected void setPointOfContact(PointOfContact poc, List commList) {
        for (Iterator it = commList.iterator(); it.hasNext();) {
            Communication communication = (Communication) it.next();
            communication.setCreateUserId(getUserProfileEmailId());

            communication.setLastUpdateDate(new Date());
            communication.setLastUpdateUserId(getUserProfileEmailId());
            communication.setActiveFlag(true);
            communication.setPointOfContact(poc);
        }
    }
    
    public static String getUserProfileEmailId(){
		String emailId = null;
		SecurityContext context = SecurityContextHolder.getContext();
 		PMUser loggedInUser = null;
 		
 		if(context.getAuthentication() == null){
 			emailId = "SYSTEM";
 		}else{
 			emailId = ((PMUser) context.getAuthentication().getPrincipal()).getUsername();
 		}
		return emailId;
	}
}
