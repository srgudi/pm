package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
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

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.CommunicationType;
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
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.dto.TaskDTO;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;

@Controller
public class MobileStaffController extends BaseController {
	 @Autowired
	    private TaskModuleManager taskModuleManager;
	   
	@ModelAttribute
    public Party initializeModel(Long id, Long clientId, Integer relationType,
        HttpServletRequest request) {
        //	org.springframework.security.core.context.SecurityContext context = org.springframework.security.core.context.SecurityContextHolder.getContext();
        //	PMUser user = (PMUser)context.getAuthentication().getPrincipal();
        //PartyRelationship relashiship = crmManager.getPartyRelationshipById(user.getPartyRelationshipId());
        //Party firm = relashiship.getPartyByObject();
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
        
        if (servletPath.equals("/mobileclient/mobileClientDetail.do")) {
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
            party = new Party();

            PartySite site = party.getDefaultPartySite();
//            site.setCreateUserId("system");

            PointOfContact contact = site.getDefaultPointOfContact();
//            contact.setCreateUserId("system");
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
	
	 private void populateReturnMapWithPageDatails(Map retMap, List entityList,
		        Page page) {
		        retMap.put("rows", entityList);

		        if (page != null) {
		            retMap.put("page", page.getCurrentPage());
		            retMap.put("total", page.getTotalPages());
		            retMap.put("records", page.getCount());
		        }
		    }
	 
	 private void setReferenceData(ModelMap model) {
	        List industryCodeSet = codesManager.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
	        List formOfBusinessTypeSet = codesManager.getCodesByCodeType(CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId());
	        List titleCodeList = codesManager.getCodesByCodeType(CodeType.JOB_TITLE_CODE_TYPE.getId());
	        List<PartySiteType> partySiteTypeCodeSet = crmManager.getPartySiteTypes();
	        List yesNoList = new ArrayList();
	        KeyValue valueYes = new KeyValue("true", "Yes");
	        KeyValue valueNo = new KeyValue("false", "No");
	        yesNoList.add(valueYes);
	        yesNoList.add(valueNo);

	        // yesNoList.add(Boolean.FALSE);
	        List<CommunicationType> communicationTypeSet = crmManager.getCommunicationTypes(true);
	       
	        model.addAttribute("phoneCommunicationTypeSet", communicationTypeSet);
	        model.addAttribute("partySiteTypeCodeSet", partySiteTypeCodeSet);
	        model.addAttribute("yesNoList", yesNoList);
	        model.addAttribute("titleCodeList", titleCodeList);
	        model.addAttribute("industryCodeSet", industryCodeSet);
	        model.addAttribute("formOfBusinessCodeSet", formOfBusinessTypeSet);
	        model.addAttribute("phoneCommunicationTypeSet",
	            PMConstants.PHONE_TYPE_LIST);
	        
	      
	    }
	 
	 private void setPartnerData(Long partyId, ModelMap model) {
	        List<Party> partnerList = crmManager.getRelatedPartiesById(partyId,
	                RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
	        model.addAttribute("partnerList", partnerList);
	    }
	 
	 private void setStaffData(Long partyId, ModelMap model) {
	        /*List<Party> staffList = crmManager.getRelatedPartiesById(partyId,
	                RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
	        model.addAttribute("staffList", staffList);*/
	        List<KeyValue> staffList = PMUtil.getCachedDropdownPartyList(partyId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(), 
	        		crmManager);
	      
	        model.addAttribute("staffList", staffList);
	    }
	 private void setDataForUI(HttpServletRequest request, ModelMap model,
		        Party party) {
		        model.addAttribute("party", party);
		        setReferenceData(model);

		        Long firmId = PMUtil.getFirmIdFromSession(request);
		        setPartnerData(firmId, model);

		        setStaffData(firmId, model);

		        party.getDefaultPartySite().getDefaultPointOfContact()
		             .populateAllCommunications();

		        Address address = party.getDefaultPartySite().getAddress();

		        if ((address != null) && (address.getCountryCode() != null)) {
		        	List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
		            model.addAttribute("statesSet", stateSet);
		        }

		        List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);

		        model.addAttribute("countryCodeSet", countryCodeSet);
		        
		        List titleCodeList = PMUtil.getCachedDropdownCodesList(firmId, CodeType.JOB_TITLE_CODE_TYPE.getId(), codesManager, null);
		        model.addAttribute("titleCodeList", titleCodeList);
		        PMUtil.showStatusMessage(request, model);
		    }
	 @RequestMapping(value = "/mobileclient/mobilecStaff.do", method = RequestMethod.GET)
	 public String mobilecStaff(HttpServletRequest request,ModelMap model){
		 return "mobilecStaff.tilesview";
	 }
	 
	/*@RequestMapping(value = "/mobileclient/mobileclientStaff.do", method = RequestMethod.GET)
    public String mobileClientStaffList(HttpServletRequest request, ModelMap model,Party party,Long clientId,String clientPartyName) {
	 
	 Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (clientId == null) {
            HttpServletRequest httpReq = (HttpServletRequest) request;
            HttpSession session = httpReq.getSession(false);
            session.setAttribute("clientPartyName", "");
        }

        model.addAttribute("clientPartyName", clientPartyName);
        setDataForUI(request, model, party);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

      for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }
       
        return "mobileClientStaff.tilesView";
    }*/

	 /*@RequestMapping(value = "/mobileclient/mobileclientStaff.do", method = RequestMethod.POST)
	    public String savemobileClientStaff(HttpServletRequest request, Long clientId,ModelMap model,
	        Party staffParty, BindingResult result, SessionStatus status,
	        ArrayList<PhoneCommunication> phonesToBeRemoved) {
	        //logger.info("Client Staff Save!");
	        if(result.hasErrors()) {
				this.getClientStaff(request, model, staffParty, clientId,clientPartyName);
	        	return null;
	        }
	        Party firmParty = crmManager.getPartyById(clientId);

	        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
	                crmManager);

	        // OrganizationType clientOrgType =
	        // PMUtil.getClientOrganizationType(crmManager);
	        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
	                crmManager);
	        RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),
	                crmManager);

	        //default staff is giving HOME address
	        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
	        staffParty.getDefaultPartySite().setPartySiteType(partySiteType);
	        if(staffParty.getId() == null){
		        String userName = staffParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
		        List<Integer> listOfPersonType = new ArrayList<Integer>();
		        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
		        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
		        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
		        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, clientId);
		        
		        boolean isEmailValid = false;
		        for (KeyValue keyValue : eamilList) {
					if(userName.equals(keyValue.value)){
						isEmailValid = true;
					}
				}
		        
		        if(isEmailValid) {
		            this.getFirmStaff(request, model, staffParty);
		            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
		            return null;
		        }
	        }

	        saveMobileStaff(firmParty, staffParty, staffPartyType, null,staffRelationType, personType, phonesToBeRemoved,"ROLE_CLIENT_STAFF", clientId);

	        String baseURL = request.getParameter("baseURL");
	        String returnURL = baseURL + "?id=" + staffParty.getId() +
	            "&clientId=" + clientId + "&saveSuccess=true";

	        // crmManager.deletePartySiteCommunication(toBeDeletedList);
	        return "redirect:" + returnURL;
	    }*/
	 
	 private PartyRelationship saveMobileStaff(Party mainParty, Party relatedParty,
		        PartyType relatedPartyType, OrganizationType relatedOrgType,
		        RelationshipType relationshipType, PersonType personType,
		        ArrayList<PhoneCommunication> phonesToBeRemoved, String role, Long clientId) {
//		        relatedParty.setCreateUserId("system");

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
//		                pointOfContact.setCreateUserId("system");
		                pointOfContact.setLastUpdateDate(new Date());
//		                pointOfContact.setLastUpdateUserId("system");
		                pointOfContact.setActiveFlag(true);
		                setPointOfContact(pointOfContact);
		            }
		        }

		        String encryptedPassword = EncryptionUtil.getInstance().encrypt("password");
		        PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
		                relatedParty, role, relationshipType, encryptedPassword, null, clientId);
		        crmManager.deletePhoneCommunication(phonesToBeRemoved);

		        return rel;
		    }
	
	 @RequestMapping(value = "/mobiledashboard/mobiledashboard.do", method = RequestMethod.GET)
	    public String getListOfTasks(HttpServletRequest request, ModelMap model) {	
		 Long firmId = PMUtil.getFirmIdFromSession(request);
	        
	        List taskStatusList = new ArrayList();
	        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
	        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
	        List taskStatusForWaiting = new ArrayList();
	        taskStatusForWaiting.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
	        HttpSession session = request.getSession(false);
			PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
	        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
	        String userRole = grantedAuthorityImpls.get(0).toString();
	        
	        model.addAttribute("missedDeadLines", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.MISSED_DEADLINE,taskStatusList));
	        model.addAttribute("dueForToday", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.TODAY_DEADLINE,taskStatusList));
	        model.addAttribute("dueForWeek", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.SEVEN_DAY_RANGE,taskStatusList));
	        model.addAttribute("dueForMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.THIRTY_DAY_RANGE,taskStatusList));
	        model.addAttribute("dueForTwoMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.SIXTY_DAY_RANGE,taskStatusList));
	        model.addAttribute("dueForThreeMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.NINETY_DAY_RANGE,taskStatusList));
	        model.addAttribute("filesWaitingForClientReply", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.WAITING_STATUS,taskStatusForWaiting));
	        model.addAttribute("firmId",firmId);
	        
		 return "mobiledashboard.tilesView";
		 	 }
	 @RequestMapping(value = "/mobiledashboard/filesDueTodayList1.do", method = RequestMethod.GET)
	    public @ResponseBody
	    Map getfilesDueTodayList(HttpServletRequest request) {
	        Map retMap = new HashMap();
	        Page page = PMUtil.populatePageObject(request);
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        String strDueCount = request.getParameter("count");
	        
	        List taskStatusList = new ArrayList();
	        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
	        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
	        List taskStatusForWaiting = new ArrayList();
	        taskStatusForWaiting.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
	        HttpSession session = request.getSession(false);
			PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
	        String userRole = grantedAuthorityImpls.get(0).toString();
			
			if(strDueCount != null){
				if(strDueCount.equalsIgnoreCase("0")){
					retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.MISSED_DEADLINE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("1")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("2")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.SEVEN_DAY_RANGE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("3")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.THIRTY_DAY_RANGE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("4")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.SIXTY_DAY_RANGE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("5")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.NINETY_DAY_RANGE, taskStatusList);
		        }else if(strDueCount.equalsIgnoreCase("6")){
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.WAITING_STATUS, taskStatusForWaiting);
		        }else{
		        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
		        }
	        }else{
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
	        }
	        
	        return retMap;
	    }

		private Map getTaskList(Page page, Long firmId, Long userProfileId, String userRole,
				int pmConstants, List taskStatusList) {
			Map retMap = new HashMap();
			Long count = taskModuleManager.getTaskListCount(firmId, userProfileId, userRole, pmConstants,taskStatusList);
	        List<TaskDTO> taskList =taskModuleManager.getTaskLists(firmId, userProfileId, userRole, pmConstants ,taskStatusList, count);
	        populateReturnMapWithPageDatails(retMap, taskList, page);
			return retMap;
		}
	
}