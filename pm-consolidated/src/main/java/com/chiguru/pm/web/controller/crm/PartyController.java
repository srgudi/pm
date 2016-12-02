package com.chiguru.pm.web.controller.crm;



import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyCode;
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
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class PartyController extends BaseController{
    private static final Long PASSWORD_RESET_TEMPLATE_NUMBER = new Long(5);
	private Logger logger = org.slf4j.LoggerFactory.getLogger(PartyController.class);
    
	@ModelAttribute("party")
    public Party initializeModel(Long id, Long clientId, Integer relationType,
    		 HttpServletRequest request,Long newfirmId,Long sessionfirmId) {
    	
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        
        String servletPath = request.getServletPath();

        if (servletPath.equals("/appadmin/adminFirmEmployee.do") || servletPath.equals("/mobileadmin/mobileAdminFirmEmployee.do")) {
        	firmId = sessionfirmId;
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
        PartySite site;

        HttpSession session1 = request.getSession();
        if(servletPath.equals("/client/clientStaff.do") || servletPath.equals("/mobileclient/mobileclientStaff.do") || servletPath.equals("/client/clientOfficersAndShareHolders.do")||servletPath.equals("/mobileclient/mobileClientOfficersAndShareHolders.do") ){
        		clientId = (Long) session1.getAttribute("clientId");
        		
        		if(clientId == null){
        			throw new RuntimeException("client Id can not be empty");
        		}
        }
    
        session1.setAttribute("officeEditId", null);  
        
        if ((id != null)) {
        	 if (servletPath.equals("/client/clientOfficersAndShareHolders.do")|| servletPath.equals("/client/clientOfficersAndShareHoldersCol.do") || servletPath.equals("/mobileclient/mobileClientOfficersAndShareHolders.do")) {
    			 session1.setAttribute("officeEditId", id);  
    		 }
            party = crmManager.getPartyById(id);
            PartySite newsite = crmManager.getPartySiteByNewPartyId(id);
            System.out.println("id is notnull");
            System.out.println("party values are :"+party);
            site = newsite;
        } else {
            party = new Party();
            if (servletPath.equals("/firmadmin/manageFirmStaff.do") || servletPath.equals("/mobilefirmadmin/manageFirmStaffMobile.do")) {
            	site = party.getDefaultPartySite();
            }/*else if (servletPath.equals("/mobilefirmadmin/manageFirmStaffMobile.do")) {
            	site = party.getDefaultPartySite();
            }*/else if (servletPath.equals("/firmadmin/manageFirmStaffColor.do")) {
            	site = party.getDefaultPartySite();
            }
            else if (servletPath.equals("/appadmin/adminFirmModule.do")||servletPath.equals("/mobileadmin/mobileAdminFirmModule.do")) {
            	site = party.getDefaultPartySite();
            }
            else if (servletPath.equals("/appadmin/adminFirmEmployee.do")) {
            	site = party.getDefaultPartySite();
            }
            else if (servletPath.equals("/mobileadmin/mobileAdminFirmEmployee.do")) {
            	site = party.getDefaultPartySite();
            }
            else{
            Party newparty = crmManager.getPartyById(clientId);
             site = newparty.getDefaultPartySite();
            }

            PointOfContact contact = site.getDefaultPointOfContact();

        }
        PointOfContact pointOfContact = site.getDefaultPointOfContact();
        
        if(pointOfContact == null){
        	pointOfContact = crmManager.getpointOfContactByNewPartyId(id);
        }
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

    @ModelAttribute
    public List<PhoneCommunication> initializeModelForDeletes(Party party,
        HttpServletRequest request) {
        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        if (request.getMethod().equals("POST")) {
            List<PhoneCommunication> origPhoneList = party.getDefaultPartySite()
                                                          .getDefaultPointOfContact()
                                                          .getPhoneList();
            phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                    origPhoneList, "defaultPointOfContact.phoneList", request);
        }

        return phonesToBeDeletedList;
    }

    @RequestMapping(value = {"/client/clientOfficersAndShareHolders.do","/mobileclient/mobileClientOfficersAndShareHolders.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveofficerAndShareholder(HttpServletRequest request,
        Long clientId,Party staffParty,ModelMap model,
        SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Officers And Shareholders Save!");
        HttpSession session = request.getSession();
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"clientId\":");
        clientId = (Long) session.getAttribute("clientId");
       
        Person person = staffParty.getPerson();

        if ((person != null) && (person.getId() != null)) {
            staffParty.setId(person.getId());
        }

        Party clientParty = crmManager.getPartyById(clientId);

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
                crmManager);
        RelationshipType shareholderRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_SHAREHOLDER.getId(),
                crmManager);

		try{
        	saveParty(request,clientParty, staffParty, staffPartyType, null,
                    shareholderRelationType, personType, phonesToBeRemoved, null, clientId);
                  logger.info("clientOfficersAndShareHolders saved "+ staffParty.getName());
                  responseText.append("\""+staffParty.getId()+"\"}");
                  
              }catch(Exception e){
             logger.error("Exception occurred during save for client staff "+ staffParty.getName()+e.getMessage());
             responseText.append("\""+-1+"\"}");
             
            }
	 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = "/firmadmin/firmListPage.do", method = RequestMethod.GET)
    public String firmStaffList(HttpServletRequest request, ModelMap model,@ModelAttribute ("party")Party party) {
		logger.info("Get firm staff List!");
		model.addAttribute("party", party);
		return "firmadmin/firmStaffList";
	}
    
    @RequestMapping(value = {"/client/clientStaff.do","/mobileclient/mobileclientStaff.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveClientStaff(HttpServletRequest request, Long clientId,ModelMap model,
    	Party sParty, SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
    	 HttpHeaders responseHeaders = new HttpHeaders();
         responseHeaders.setContentType(MediaType.TEXT_HTML);
 		 StringBuffer responseText = new StringBuffer("{\"clientId\":");
 		 Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("Client Staff Save!");
        /*if(result.hasErrors()) {
			this.getClientStaff(request, model, staffParty, clientId,clientPartyName);
        	return null;
        }*/
        
         Party firmParty = crmManager.getPartyById(clientId);

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        // OrganizationType clientOrgType =
        // PMUtil.getClientOrganizationType(crmManager);
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_CLIENT_STAFF.getId(),
                crmManager);
        RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),
                crmManager);
        //default staff is giving HOME address
        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
        sParty.getDefaultPartySite().setPartySiteType(partySiteType);
        /*if(sParty.getId() == null){
	        String userName = sParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
	        List<Integer> listOfPersonType = new ArrayList<Integer>();
	        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_CLIENT_STAFF.getId());
	       List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, clientId);
	        
	        boolean isEmailValid = false;
	        for (KeyValue keyValue : eamilList) {
				if(userName.equals(keyValue.value)){
					isEmailValid = true;
				}
			}
	        
	        if(isEmailValid) {
	            this.getFirmStaff(request, model, sParty);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }*/
        try{
        	savePerson(request, firmId, clientId, sParty,status, phonesToBeRemoved); 


                  logger.info("clientStaff saved  "+ sParty.getName());
                  responseText.append("\""+sParty.getId()+"\"}");
                  
              }catch(Exception e){
             logger.error("Exception occurred during save for client staff "+ sParty.getName() +e.getMessage());
             responseText.append("\""+-1+"\"}");
             
            }
	 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = "/client/clientDetail_old.do", method = RequestMethod.POST)
    public String saveClient(HttpServletRequest request, Party clientParty,
         SessionStatus status, ModelMap model,
        List<PhoneCommunication> phonesToBeRemoved, Long clientId) {
        logger.info("Client Module Save!");
        HttpSession session = request.getSession(false);
        PartyDTO firm = (PartyDTO) session.getAttribute("firm");
        Long firmId = (firm != null) ? firm.getId() : null;
        Party firmParty = crmManager.getPartyById(firmId);
        
        PartyType clientPartyType = PMUtil.getPartyOrganizationType(crmManager);
        OrganizationType clientOrgType = PMUtil.getClientOrganizationType(crmManager);
        RelationshipType clientRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(),
                crmManager);
        saveParty(request,firmParty, clientParty, clientPartyType, clientOrgType,
            clientRelationType, null, phonesToBeRemoved, null, clientId);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?clientId=" + clientParty.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

    //Added By Savitri
    @RequestMapping(value = {"/appadmin/adminFirmModule.do","/mobileadmin/mobileAdminFirmModule.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveFirm(HttpServletRequest request, ModelMap model,
    		@ModelAttribute ("party")Party party,SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Module Save!");
        long l=party.getDefaultPartySite().getAddress().getCountryCode();
        HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"partyId\":");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
       if(result.hasErrors()) {
            this.getFirm(request, model, party, firmId);
            return null;
       }
        
        Party firmParty = crmManager.getPartyById(firmId);
        //bug no 511
        String id = request.getParameter("id");
        
        if(id == ""){
        String firmname = party.getOrganization().getLegalName();
        List<KeyValue> firmList = PMUtil.getFirmNameList(crmManager);
        boolean isFirmValid = false;
        for (KeyValue keyValue : firmList) {
			if(firmname.equals(keyValue.value)){
				isFirmValid = true;
			}
		}
        
        if(isFirmValid) {
            this.getFirmStaff(request, model, party);
            model.addAttribute("invalidEmilId", "Given Firm Name already exists. Please enter different one");
            return null;
        }
        }
        PartyType firmPartyType = PMUtil.getPartyOrganizationType(crmManager);
        OrganizationType firmOrgType = PMUtil.getFirmOrganizationType(crmManager);
        
        List<Code> listOfAdminCodes = new ArrayList<Code>();
        if(party.getId() == null){
        	listOfAdminCodes = codesManager.getListOfAdminCodes();
        }
        String emailId = party.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
        List<Integer> listOfPersonType = new ArrayList<Integer>();
        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, (long) 0);
        
        boolean isEmailValid = false;
        if(id==""){
        for (KeyValue keyValue : eamilList) {
			if(emailId.equals(keyValue.value)){
				isEmailValid = true;
			}
		}
        
        if(isEmailValid) {
            this.getFirmStaff(request, model, party);
            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
            return null;
        }
        }
        try{
        saveManageFirm(firmParty, party, firmPartyType, firmOrgType,
            null, null, phonesToBeRemoved, listOfAdminCodes);
           responseText.append("\""+party.getId()+"\"}");
	 	  logger.info("SAVED ****** "+party.getId());
          }catch (Exception e) {
      	 logger.error("Exception occurred during save of Firm ");
           responseText.append("\"-1\"}");
          }
 	 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
  }
       
   

    private PartyRelationship saveParty(HttpServletRequest request, Party mainParty, Party relatedParty,
        PartyType relatedPartyType, OrganizationType relatedOrgType,
        RelationshipType relationshipType, PersonType personType,
        List<PhoneCommunication> phonesToBeRemoved, String role, Long clientId) {
//        relatedParty.setCreateUserId("system");
    	if(role == "ROLE_STAFF"){
    	personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
                crmManager);
    	}
        relatedParty.setPartyType(relatedPartyType);
        if(role == "ROLE_CLIENT_STAFF"){
        	personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_CLIENT_STAFF.getId(),
            crmManager);
        }
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
//                pointOfContact.setCreateUserId("system");
                pointOfContact.setLastUpdateDate(new Date());
//                pointOfContact.setLastUpdateUserId("system");
                pointOfContact.setActiveFlag(true);
                setPointOfContact(pointOfContact);
            }
        }

        //String encryptedPassword = EncryptionUtil.getInstance().encrypt("password");
        HttpSession session = request.getSession();
        String encryptedPassword = (String) session.getAttribute("userPasswordkey");
        PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
                relatedParty, role, relationshipType, encryptedPassword, null, clientId);
        crmManager.deletePhoneCommunication(phonesToBeRemoved);

        return rel;
    }

    //Added By Savitri
    private void saveManageFirm(Party mainParty, Party relatedParty,
        PartyType relatedPartyType, OrganizationType relatedOrgType,
        RelationshipType relationshipType, PersonType personType,
        List<PhoneCommunication> phonesToBeRemoved, List<Code> listOfAdminCodes) {
        relatedParty.setCreateUserId("system");

        relatedParty.setPartyType(relatedPartyType);

        if (relatedOrgType != null) {
            Organization org = relatedParty.getOrganization();
            org.setOperatingName(org.getLegalName());
            relatedParty.setName(org.getLegalName());
            org.setOrganizationType(relatedOrgType);
            org.setParty(relatedParty);

            PartySite partySite = relatedParty.getPartySites().get(0);
            partySite.setContactName(org.getLegalName());
            partySite.setContactTitle(org.getLegalName());
            partySite.setName(org.getLegalName());
            partySite.setPartySiteType(crmManager.getPartySiteTypeById(
                    PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));

            Address address = partySite.getAddress();

            if (address != null) {
                Set<PartySite> partySites = new HashSet<PartySite>();
                partySites.add(partySite);
                address.setPartySite(partySite);
                //partySite.setAddress(address);
                partySite.setParty(relatedParty);
            } else {
                address = new Address();
                address.setCity(relatedParty.getDefaultPartySite().getAddress()
                                            .getCity());
                address.setCountryCode(relatedParty.getDefaultPartySite()
                                                   .getAddress().getCountryCode());
                address.setAddressLine1(relatedParty.getDefaultPartySite()
                                                    .getAddress()
                                                    .getAddressLine1());
                address.setAddressLine2(relatedParty.getDefaultPartySite()
                                                    .getAddress()
                                                    .getAddressLine2());
                address.setStateCode(relatedParty.getDefaultPartySite()
                                                 .getAddress().getStateCode());
                address.setPostalCode(relatedParty.getDefaultPartySite()
                                                  .getAddress().getPostalCode());

                Set<PartySite> partySites = new HashSet<PartySite>();
                partySites.add(partySite);
                address.setPartySite(partySite);
                //partySite.setAddress(address);
                partySite.setParty(relatedParty);
            }

            List<PartySite> list = new ArrayList<PartySite>();
            list.add(partySite);
            relatedParty.setPartySites(list);
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
            //partySite.setAddress(address);
            partySite.setParty(relatedParty);

            List<PartySite> list = new ArrayList<PartySite>();
            list.add(partySite);
            relatedParty.setPartySites(list);
        }

        if (relatedParty != null) {
            List<PointOfContact> listOfPointOfContact = relatedParty.getDefaultPartySite()
                                                                    .getPointOfContactList();

            for (PointOfContact pointOfContact : listOfPointOfContact) {
//                pointOfContact.setCreateUserId("system");
                pointOfContact.setLastUpdateDate(new Date());
//                pointOfContact.setLastUpdateUserId("system");
                pointOfContact.setActiveFlag(true);
                setPointOfContact(pointOfContact);
            }
        }

        crmManager.createPartyAndRelationship(mainParty, relatedParty,
                null, relationshipType, "", listOfAdminCodes, null);
        crmManager.deletePhoneCommunication(phonesToBeRemoved);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/clientDetail_old.do", method = RequestMethod.GET)
    public String getClient(HttpServletRequest request, ModelMap model,
        Party party, Long clientId) {
        logger.info("Client Module!");

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if ((clientId != null) &&
                (session.getAttribute("inValidClientId") == null)) {
            Party clientParty = crmManager.getPartyById(clientId);
            session.setAttribute("clientPartyName", clientParty.getName());
            Long firmPracticeId = taxModuleManager.getDefaultFirmPracticeIdByFirmId(firmId);
            session.setAttribute("firmPracticeId", firmPracticeId);
        } else {
            session.setAttribute("clientPartyName", "");
        }

        /*Party clientParty = crmManager.getPartyById(clientId);
        model.addAttribute("clientPartyName", clientParty.getName());*/
        setDataForUI(request, model, party);

        return "clientDetail.tilesView";
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    
    @RequestMapping(value = {"/client/clientStaff.do","/mobileclient/mobileclientStaff.do"}, method = RequestMethod.GET)
    public String getClientStaff(HttpServletRequest request, ModelMap model,
    	@ModelAttribute ("party") Party party, Long clientId, String clientPartyName) {
    	 HttpSession session1 = request.getSession();
        logger.info("/client/clientStaff.do!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
       clientId = (Long) session1.getAttribute("clientId");
        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (clientId == null) {
            HttpServletRequest httpReq = (HttpServletRequest) request;
            HttpSession session = httpReq.getSession(false);
            session.setAttribute("clientPartyName", "");
        }

        ResourceBundle res = ResourceBundle.getBundle("messages_hi");
		String lang = (String) session1.getAttribute("lang");
		if(lang == "sp"){
			res = ResourceBundle.getBundle("messages_sp");
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

        List<PersonType> allPersonTypeSet = crmManager.getPersonTypeList();
        
        List<PersonType> personTypeSet =  new ArrayList();
        for (PersonType personType : allPersonTypeSet) {
                if((personType.equals(PersonType.PERSON_TYPE_STAFF))){
                        personTypeSet.add(personType);
                }else if((personType.equals(PersonType.PERSON_TYPE_PARTNER))){
                        personTypeSet.add(personType);
                }else if((personType.equals(PersonType.PERSON_TYPE_FIRM_ADMIN))){
                        personTypeSet.add(personType);
                }
        model.addAttribute("personTypeSet", personTypeSet);
        }
        //return "clientStaff.tilesView";
        if(request.getRequestURI().contains("/mobileclient/mobileclientStaff.do")){
        	return "mobileClientStaff.tilesView";
        }else{
        return "client/clientStaff";
        }
    }
    
    @RequestMapping(value = "/client/clientStaffColor.do", method = RequestMethod.GET)
    public String getClientStaffColor(HttpServletRequest request, ModelMap model,
        Party party, Long clientId, String clientPartyName) {
    	 HttpSession session1 = request.getSession();
        logger.info("/client/clientStaff.do!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
       clientId = (Long) session1.getAttribute("clientId");
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

        return "clientStaffColor.tilesView";
    }

	/**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = {"/client/clientOfficersAndShareHolders.do","/mobileclient/mobileClientOfficersAndShareHolders.do"}, method = RequestMethod.GET)
    public String getShareholders(HttpServletRequest request, ModelMap model,
    		@ModelAttribute ("party")Party party, Long clientId,String clientPartyName) {
        logger.info("clientOfficersAndShareHolders.do!");
        
        HttpSession session1 = request.getSession();
        clientId = (Long) session1.getAttribute("clientId");
        Long editId = (Long) session1.getAttribute("officeEditId");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        setDataForUI(request, model, party);
//        setStaffData(clientId, model);
        String servletPath = request.getServletPath();
        if (clientId == null) {
        	session1.setAttribute("clientPartyName", "");
        }
        
        List sharesTypes = PMUtil.getCachedDropdownCodesList(firmId, CodeType.SHARE_CODE_TYPE.getId(), codesManager, null);
        model.addAttribute("sharesTypes", sharesTypes);
        
        //cached is not applied to staffListByClientId. Since it was not showing list of newly created clientStaff. Ticket No:360 is fixed.
//        List<KeyValue> staffListByClientId = PMUtil.getCachedDropdownPartyList(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
        
        List<KeyValue> staffListByClientId = new ArrayList();
        
        if(editId != null){
        	staffListByClientId = crmManager.getPartyDropdownListForOfficersEdit(clientId, RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId());
        	session1.setAttribute("officeEditId", null);  
        }else{
        	
           staffListByClientId = crmManager.getPartyDropdownListForRelationship(clientId, RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId());
           session1.setAttribute("officeEditId", null); 
           
        }
        model.addAttribute("staffListByClientId", staffListByClientId);
        if(servletPath.equals("/mobileclient/mobileClientOfficersAndShareHolders.do")){
        	return "mobileclientOfficersAndShareHolders.tilesView";
        }else{
        return "client/clientOfficersAndShareHolders";
        }
    }

    @RequestMapping(value = "/client/clientOfficersAndShareHoldersCol.do", method = RequestMethod.GET)
    public String getShareholdersCol(HttpServletRequest request, ModelMap model,
    		@ModelAttribute ("party")Party party, Long clientId) {
        logger.info("clientOfficersAndShareHolders.do!");
        
        HttpSession session1 = request.getSession();
        clientId = (Long) session1.getAttribute("clientId");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        setDataForUI(request, model, party);
//        setStaffData(clientId, model);

        if (clientId == null) {
            HttpServletRequest httpReq = (HttpServletRequest) request;
            HttpSession session = httpReq.getSession(false);
            session.setAttribute("clientPartyName", "");
        }
        
        List sharesTypes = PMUtil.getCachedDropdownCodesList(firmId, CodeType.SHARE_CODE_TYPE.getId(), codesManager, null);
        model.addAttribute("sharesTypes", sharesTypes);
        ResourceBundle res = ResourceBundle.getBundle("messages_hi");
		String lang = (String) session1.getAttribute("lang");
		if(lang == "sp"){
			res = ResourceBundle.getBundle("messages_sp");
		}
        
        //cached is not applied to staffListByClientId. Since it was not showing list of newly created clientStaff. Ticket No:360 is fixed.
//        List<KeyValue> staffListByClientId = PMUtil.getCachedDropdownPartyList(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
        List<KeyValue> staffListByClientId = crmManager.getPartyDropdownListForRelationship(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
        model.addAttribute("staffListByClientId", staffListByClientId);
        
        return "client/clientOfficersAndShareHoldersCol";
    }
    @RequestMapping(value = "/mobileclient/mobileOfficersAndShareHolders.do", method = RequestMethod.GET)
    public String getMobileOffShareholders(HttpServletRequest request, ModelMap model){
    	return "mobileOffAndShareHolders.tilesView";
    }
  
    
    private void setDataForUI(HttpServletRequest request, ModelMap model,
        Party party) {
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

    private void setDataForUI(HttpServletRequest request, ModelMap model,
            Party party,Long firmId) {
    	
            model.addAttribute("party", party);
            setReferenceData(model);

            /*Long firmId = PMUtil.getFirmIdFromSession(request);*/
            setPartnerData(firmId, model);

            setStaffData(firmId, model);

            party.getDefaultPartySite().getDefaultPointOfContact()
                 .populateAllCommunications();
            firmId = PMUtil.getFirmIdFromSession(request);
            Address address = party.getDefaultPartySite().getAddress();
            List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);

            model.addAttribute("countryCodeSet", countryCodeSet);
            if ((address != null) && (address.getCountryCode() != null)) {
            	List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
                model.addAttribute("statesSet", stateSet);
            }
            
            List titleCodeList = PMUtil.getCachedDropdownCodesList(firmId, CodeType.JOB_TITLE_CODE_TYPE.getId(), codesManager, null);
            model.addAttribute("titleCodeList", titleCodeList);
            PMUtil.showStatusMessage(request, model);
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

    /*private PartySiteCommunication getPartySiteCommunicationForType(
                    int communicationType, PartySite site) {
            return new PartySiteCommunication(
                            crmManager.getCommunicationTypeById(communicationType), site);
    }*/

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "manageBank.do", method = RequestMethod.GET)
    public void manageBank(HttpServletRequest request, ModelMap model,
        Party party) {
        logger.info("Manage Bank Module!");
        setDataForUI(request, model, party);
    }

   @RequestMapping(value = {"/firmadmin/manageFirmStaff.do","/mobilefirmadmin/manageFirmStaffMobile.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveFirmStaff(HttpServletRequest request, ModelMap model,Party party,
     		 Long clientId,SessionStatus status,List<PhoneCommunication> phonesToBeRemoved) {
         logger.info("Firm Staff Save!");
         //BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.newparty");
         HttpSession session = request.getSession();
         HttpHeaders responseHeaders = new HttpHeaders();
         responseHeaders.setContentType(MediaType.TEXT_HTML);
 		 StringBuffer responseText = new StringBuffer("{\"id\":");
         Long firmId = PMUtil.getFirmIdFromSession(request);
         String userName = null;
         if(party.getId() == null){
 	        PointOfContact poc = party.getPartySites().get(0).getPointOfContactList().get(0);
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
 	            this.getFirmStaff(request, model, party);
 	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
 	            return null;
 	        }
         }

         if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                 (firmId == null)) {
             throw new RuntimeException("firmId can not be empty");
         }
         try{
        	 party = savePerson(request, firmId, clientId, party,status, phonesToBeRemoved); 
        	  responseText.append("\""+party.getId()+"\"}");
    	 	  logger.info("ManageFirmStaff SAVED ****** "+party.getId());
         
         }catch(Exception e){
             logger.error("Exception occurred during save of firm staff " +e.getMessage());
             responseText.append("\"-1\"}");

            }
         return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
     }

    @RequestMapping(value="/firmadmin/firmStaffList.do", method=RequestMethod.GET)
	public String mainFirmAdmin(HttpServletRequest request,ModelMap model,Party party){
    	System.out.println("Hello people");
    	model.addAttribute("party", party);
		return "firmadmin/firmStaffList";
	}
    
    @RequestMapping(value="/firmadmin/taxTypeList.do", method=RequestMethod.GET)
	public String taxTypelist(HttpServletRequest request,ModelMap model){
		return "firmadmin/taxTypeList";
	}
    
    @RequestMapping(value="/firmadmin/firmCodeList.do", method=RequestMethod.GET)
	public String codelist(HttpServletRequest request,ModelMap model){
		return "firmadmin/firmCodeList";
	}
    
    @RequestMapping(value = {"/firmadmin/manageFirmStaff.do","/mobilefirmadmin/manageFirmStaffMobile.do"}, method = RequestMethod.GET)
    public String getFirmStaff(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("party") Party value) {
        logger.info("firmStaff.do!");
        System.out.println("firmStaff Values"+value.getName());
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, value);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }

        List<PersonType> allPersonTypeSet = crmManager.getPersonTypeList();
        List<PersonType> personTypeSet = new ArrayList();
        for (PersonType personType : allPersonTypeSet) {
            if ((personType.equals(PersonType.PERSON_TYPE_STAFF))) {
                personTypeSet.add(personType);
            } else if ((personType.equals(PersonType.PERSON_TYPE_PARTNER))) {
                personTypeSet.add(personType);
            }
            /*else if ((personType.equals(PersonType.PERSON_TYPE_FIRM_ADMIN))) {
                personTypeSet.add(personType);
            }*/

            model.addAttribute("personTypeSet", personTypeSet);
        }

        //List titleList = codesManager.getCodesByCodeTypeForAdminStaff(CodeType.FIRM_STAFF_TITLE_CODE.getId());
       /* List<PartyCode> titleList = codesManager.getPartyCodeByFirmId(CodeType.FIRM_STAFF_TITLE_CODE.getId(), firmId);
        model.addAttribute("titleList", titleList);*/
        String servletPath = request.getServletPath();

        if (servletPath.equals("/firmadmin/manageFirmStaff.do")) {
           return "firmadmin/manageFirmStaff";
        }else{
           return "manageFirmStaffMobile.tilesView";
        }
    }

    @RequestMapping(value = "/firmadmin/manageFirmStaffColor.do", method = RequestMethod.GET)
    public String getFirmStaffColor(HttpServletRequest request, ModelMap model,
        Party value) {
        logger.info("firmStaff.do!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, value);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }

        List<PersonType> allPersonTypeSet = crmManager.getPersonTypeList();
        List<PersonType> personTypeSet = new ArrayList();
        for (PersonType personType : allPersonTypeSet) {
            if ((personType.equals(PersonType.PERSON_TYPE_STAFF))) {
                personTypeSet.add(personType);
            } else if ((personType.equals(PersonType.PERSON_TYPE_PARTNER))) {
                personTypeSet.add(personType);
            }
            /*else if ((personType.equals(PersonType.PERSON_TYPE_FIRM_ADMIN))) {
                personTypeSet.add(personType);
            }*/

            model.addAttribute("personTypeSet", personTypeSet);
        }

        List titleList = codesManager.getCodesByCodeTypeForAdminStaff(CodeType.FIRM_STAFF_TITLE_CODE.getId());
        model.addAttribute("titleList", titleList);
        return "manageFirmStaff.tilesView";
    }
    
    @RequestMapping(value = "/manageFirmPartner.do", method = RequestMethod.POST)
    public String saveFirmPartner(HttpServletRequest request, Long firmId,
        Long clientId, Party staffParty,
        SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Firm Partner Save!");

        Party firmParty = crmManager.getPartyById(firmId);

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);
        
        /*if(result.hasErrors()) {
        	
			this.getFirmStaff(request, model, party);
        	return null;
        }*/
        //OrganizationType clientOrgType = PMUtil.getClientOrganizationType(crmManager);
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_PARTNER.getId(),
                crmManager);
        RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),
                crmManager);

        saveParty(request,firmParty, staffParty, staffPartyType, null,
            staffRelationType, personType, phonesToBeRemoved, null, clientId);

        //crmManager.savePartySite(staffParty.getDefaultPartySite());
        //crmManager.deletePartySiteCommunication(toBeDeletedList);
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?firmId=" +
            request.getParameter("firmId") + "&id=" + staffParty.getId() +
            "&relationType=2";

        //crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/manageFirmPartner.do", method = RequestMethod.GET)
    public void getFirmPartner(HttpServletRequest request, ModelMap model,
        Party party, Long firmId) {
        logger.info("firmStaff.do!");
        setDataForUI(request, model, party);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }
    }

    //Added By Savitri
    @RequestMapping(value = {"/appadmin/adminFirmModule.do","/mobileadmin/mobileAdminFirmModule.do"}, method = RequestMethod.GET)
    public String getFirm(HttpServletRequest request, ModelMap model, @ModelAttribute("party")Party party, Long firmId) {
        logger.info("Client Module!");
        setDataForUI(request, model, party);
        
        String servletPath=request.getServletPath();
        if(servletPath.equals("/appadmin/adminFirmModule.do")){
        	return "appadmin/adminFirmModule";
        }else{
        	return "mobileAdminFirmModule.tilesView";
        }
    }

    @RequestMapping(value = {"/appadmin/adminFirmEmployee.do","/mobileadmin/mobileAdminFirmEmployee.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveFirmEmployee(HttpServletRequest request,ModelMap model, Long firmId,
        Long clientId, Party employeeParty, 
        SessionStatus status, List<PhoneCommunication> phonesToBeRemoved,Long newfirmId) {
        logger.info("Firm Employee Save!");
        if(firmId == null){
        	firmId = PMUtil.getFirmIdFromSession(request);
        }
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"id\":");
       // firmId = PMUtil.getFirmIdFromSession(request);
		 if(clientId == null){
		   HttpSession session = request.getSession();
		   clientId =  (Long) session.getAttribute("sessionfirmId");
		 }
        if(employeeParty.getId() == null){
	        String userName = employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
	        List<Integer> listOfPersonType = new ArrayList<Integer>();
	        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
	        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, firmId);
	        
	        boolean isEmailValid = false;
	        for (KeyValue keyValue : eamilList) {
				if(userName.equals(keyValue.value)){
					isEmailValid = true;
				}
			}
	        if(isEmailValid) {
	            this.getFirmEmployee(request, model, employeeParty,firmId, newfirmId);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }
        
        try{
        	employeeParty = savePerson(request, firmId, clientId, employeeParty, status, phonesToBeRemoved);
        	responseText.append("\""+employeeParty.getId()+"\"}");
     	 	  logger.info("Admin FirmEmployee SAVED ****** "+employeeParty.getId());
        }catch(Exception e){
            logger.error("Exception occurred during save of firm staff " +e.getMessage());
            responseText.append("\"-1\"}");

           }
        
        return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK);
       
    }

    private Party saveNewPerson(HttpServletRequest request, Long firmId,
			Long clientId, Party employeeParty,
			SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
    	
    	Party firmParty = crmManager.getPartyById(firmId);
    	
    	PartyType employeePartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);
    	PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_CLIENT_STAFF.getId(),
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
        }else if (PersonType.PERSON_TYPE_CLIENT_STAFF.equals(personType)) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),
                    crmManager);
            role = "ROLE_CLIENT_STAFF";
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
                if(employeeParty.getId() == null){
	                if(employeeParty.getName() != null){
	                  currentStatus = sendPasswordResetLink(request,employeeParty.getName(), username, encryptedUserResetPasswordKey,firmParty.getName());
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
		              currentStatus = sendPasswordResetLink(request,FullName, username, encryptedUserResetPasswordKey,firmParty.getName());
		            }
                }else{
                	currentStatus = 1;
                }
            if(currentStatus == 1){
            	 PartyRelationship relationship = saveParty(request,firmParty, employeeParty,
                         employeePartyType, null, employeeRelationType,
                         employeeParty.getPerson().getPersonType(), phonesToBeRemoved, role, clientId);
            	         employeeParty.setNewStat(currentStatus);
            }
            else{
            	employeeParty.setNewStat(currentStatus);
            }
            }
        }
		
        return employeeParty;
	}
    private Party savePerson(HttpServletRequest request, Long firmId,
			Long clientId, Party employeeParty, 
			SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
    	
    	Party firmParty = crmManager.getPartyById(firmId);
    	Party clientParty = null;
    	PartyType employeePartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);
    	PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_CLIENT_STAFF.getId(),
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
        }else if (PersonType.PERSON_TYPE_CLIENT_STAFF.equals(personType)) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),
                    crmManager);
            role = "ROLE_CLIENT_STAFF";
            clientParty = crmManager.getPartyById(clientId);
        }
        if(employeeParty.getId() == null){
        	employeeParty.getPerson().setUserName(employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail());
        }
        }
        //default staff is giving HOME address
        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
        employeeParty.getDefaultPartySite().setPartySiteType(partySiteType);
        PartyRelationship relationship;

        if (role != null) {
            
            Random randomGenerator = new Random();
            int randomInt = randomGenerator.nextInt(1000);
            String userResetPasswordKey = String.valueOf(randomInt);
            String encryptedUserResetPasswordKey = EncryptionUtil.getInstance().encrypt(userResetPasswordKey); 
            HttpSession session = request.getSession();
            session.setAttribute("userPasswordkey", encryptedUserResetPasswordKey);
            String username = employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
            if(username!=null){
            //crmManager.savePassword(username,encryptedUserResetPasswordKey);
            int currentStatus = 0;
            Person newPerson = new Person();
            newPerson = employeeParty.getPerson();
            if(employeeParty.getId() == null){
	            if(employeeParty.getName() != null){
	              currentStatus = sendPasswordResetLink(request,employeeParty.getName(), username, encryptedUserResetPasswordKey,firmParty.getName());
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
	                 if(role == "ROLE_CLIENT_STAFF"){
	                	 currentStatus = sendPasswordResetLink(request,FullName, username, encryptedUserResetPasswordKey,clientParty.getName()); 
	                 }else{
	                	 currentStatus = sendPasswordResetLink(request,FullName, username, encryptedUserResetPasswordKey,firmParty.getName());
	                 }
	            }
            }else{
            	currentStatus = 1;
            }
            if(currentStatus == 1){
            	if(role=="ROLE_CLIENT_STAFF"){
            		relationship = saveParty(request,clientParty, employeeParty,employeePartyType, null, employeeRelationType,employeeParty.getPerson().getPersonType(), phonesToBeRemoved, role, clientId);
            	}else{
            	 relationship = saveParty(request,firmParty, employeeParty,
                         employeePartyType, null, employeeRelationType,
                         employeeParty.getPerson().getPersonType(), phonesToBeRemoved, role, clientId);
            	         
            	}
            	employeeParty.setNewStat(currentStatus);
            }
            else{
            	employeeParty.setNewStat(currentStatus);
            }
            }
        }
		
        return employeeParty;
	}

	public int sendPasswordResetLink(HttpServletRequest request,String name, String username,
			String userResetPasswordKey, String Firm) {
		String sub;
		String body;
		ResourceBundle bundle = ResourceBundle.getBundle("pm");
		String hostName = bundle.getString("APP_HOST");
		String portName = bundle.getString("APP_PORT");
		String urlName = bundle.getString("PWD_URL");
		String mobileurlname = bundle.getString("MOB_PWD_URL");
		if (request.getRequestURI().contains("/mobileadmin/mobileAdminFirmEmployee.do") || request.getRequestURI().contains("/mobilefirmadmin/manageFirmStaffMobile.do")){
			urlName = mobileurlname;
		}
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
    
	
	
	@RequestMapping(value = {"/appadmin/adminFirmEmployee.do","/mobileadmin/mobileAdminFirmEmployee.do"}, method = RequestMethod.GET)
    public String getFirmEmployee(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("party")Party party, Long firmId,Long newfirmId) {
        logger.info("firmEmployee.do!");
        setDataForUI(request, model, party,newfirmId);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }

        List<PersonType> allPersonTypeSet = crmManager.getPersonTypeList();

        List<PersonType> personTypeSet = new ArrayList();

        for (PersonType personType : allPersonTypeSet) {
            if ((personType.equals(PersonType.PERSON_TYPE_STAFF))) {
                personTypeSet.add(personType);
            } else if ((personType.equals(PersonType.PERSON_TYPE_PARTNER))) {
                personTypeSet.add(personType);
            } else if ((personType.equals(PersonType.PERSON_TYPE_FIRM_ADMIN))) {
                personTypeSet.add(personType);
            }

            model.addAttribute("personTypeSet", personTypeSet);
       }
       
        if(request.getRequestURI().contains("/appadmin/adminFirmEmployee.do")){
           return "appadmin/adminFirmEmployee";
        }else{
           return "mobileadminFirmEmployee.tilesView";
        }
      }

    }

