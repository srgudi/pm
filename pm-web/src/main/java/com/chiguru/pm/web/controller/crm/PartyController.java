package com.chiguru.pm.web.controller.crm;



import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import java.beans.PropertyEditorSupport;
import java.io.Serializable;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;


@Controller
public class PartyController extends BaseController{
    private static final Long PASSWORD_RESET_TEMPLATE_NUMBER = new Long(5);
	private Logger logger = org.slf4j.LoggerFactory.getLogger(PartyController.class);
    
    @ModelAttribute
    public Party initializeModel(Long id, Long clientId, Integer relationType,Long newfirmId,
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
        /*if (servletPath.equals("/appadmin/adminFirmEmployee.do") & id != null) {
        	firmId = newfirmId ;
        }*/
        
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
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);

        if ((id != null)) {
            party = crmManager.getPartyById(id);
            PartySite newsite = crmManager.getPartySiteByNewPartyId(id);
            System.out.println("id is notnull");
            System.out.println("party values are :"+party);
            site = newsite;
        } else {
            party = new Party();
            if (servletPath.equals("/firmadmin/manageFirmStaff.do")) {
            	site = party.getDefaultPartySite();
            }
            else if (servletPath.equals("/appadmin/adminFirmModule.do")) {
            	site = party.getDefaultPartySite();
            }else if (servletPath.equals("/mobileadmin/mobileAdminFirmModule.do")) {
            	site = party.getDefaultPartySite();
            }
            else if (servletPath.equals("/appadmin/adminFirmEmployee.do")) {
            	site = party.getDefaultPartySite();
            }else if (servletPath.equals("/mobileadmin/mobileAdminFirmEmployee.do")) {
            	site = party.getDefaultPartySite();
            }
            else if(servletPath.equals("/mobilefirmadmin/manageFirmStaffMobile.do")){
            	site = party.getDefaultPartySite();
            }
            else{
            Party newparty = crmManager.getPartyById(clientId);
             site = newparty.getDefaultPartySite();
            }
//            site.setCreateUserId("system");

            PointOfContact contact = site.getDefaultPointOfContact();
//            contact.setCreateUserId("system");
        }

        //PartySite site = party.getDefaultPartySite();
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
            /*phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                    origPhoneList, "defaultPointOfContact.phoneList", request);*/
        }

        return phonesToBeDeletedList;
    }

    @RequestMapping(value = "/client/clientOfficersAndShareHolders.do", method = RequestMethod.POST)
    public String saveofficerAndShareholder(HttpServletRequest request,Long id,
        Long clientId,@Valid Party party, ModelMap model,
        SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Officers And Shareholders Save!");
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
        if(result.hasErrors()) {
			this.getAllShareholders(request, model, party, clientId);
        	return null;
        }
        //		Long firmId = PMUtil.getFirmIdFromSession(request);
        Person person = party.getPerson();
        Party clientParty = crmManager.getPartyById(clientId);
        PointOfContact pointOfContact;
        pointOfContact = crmManager.getpointOfContactByNewPartyId(id);
        List<PointOfContact> pointOfContactList = new ArrayList();
        pointOfContactList.add(pointOfContact);
        clientParty.setPointOfContactList(pointOfContactList);
        pointOfContact = crmManager.getpointOfContactByNewPartyId(clientId);
        List<PointOfContact> newPointOfContactList = new ArrayList();
        newPointOfContactList.add(pointOfContact);
        party.setPointOfContactList(newPointOfContactList);
        // if person is a staff then, associate party and person by id
        if ((person != null) && (person.getId() != null)) {
        	party.setId(person.getId());
        }

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        // OrganizationType clientOrgType =
        // PMUtil.getClientOrganizationType(crmManager);
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
                crmManager);
        RelationshipType shareholderRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_SHAREHOLDER.getId(),
                crmManager);

        phonesToBeRemoved = new ArrayList<PhoneCommunication>(); //To stop list of all PhoneCommunication of staffParty getting HARD DELETE from DB.

        saveParty(clientParty, party, staffPartyType, null,
            shareholderRelationType, personType, phonesToBeRemoved, null, clientId);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?clientId=" +
            request.getParameter("clientId") + "&id=" + party.getId() +
            "&saveSuccess=true";
        ;

        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/mobileclient/mobileClientOfficersAndShareHolders.do", method = RequestMethod.POST)
    public String saveMobileofficerAndShareholder(HttpServletRequest request,Long id,
        Long clientId,@Valid Party party, ModelMap model,
        SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Officers And Shareholders Save!");
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
        if(result.hasErrors()) {
			this.getAllShareholders(request, model, party, clientId);
        	return null;
        }
        //		Long firmId = PMUtil.getFirmIdFromSession(request);
        Person person = party.getPerson();
        Party clientParty = crmManager.getPartyById(clientId);
        PointOfContact pointOfContact;
        pointOfContact = crmManager.getpointOfContactByNewPartyId(id);
        List<PointOfContact> pointOfContactList = new ArrayList();
        pointOfContactList.add(pointOfContact);
        clientParty.setPointOfContactList(pointOfContactList);
        pointOfContact = crmManager.getpointOfContactByNewPartyId(clientId);
        List<PointOfContact> newPointOfContactList = new ArrayList();
        newPointOfContactList.add(pointOfContact);
        party.setPointOfContactList(newPointOfContactList);
        // if person is a staff then, associate party and person by id
        if ((person != null) && (person.getId() != null)) {
        	party.setId(person.getId());
        }

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        // OrganizationType clientOrgType =
        // PMUtil.getClientOrganizationType(crmManager);
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
                crmManager);
        RelationshipType shareholderRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_SHAREHOLDER.getId(),
                crmManager);

        phonesToBeRemoved = new ArrayList<PhoneCommunication>(); //To stop list of all PhoneCommunication of staffParty getting HARD DELETE from DB.

        saveParty(clientParty, party, staffPartyType, null,
            shareholderRelationType, personType, phonesToBeRemoved, null, clientId);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?clientId=" +
            request.getParameter("clientId") + "&id=" + party.getId() +
            "&saveSuccess=true";
        ;

        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    
    @RequestMapping(value = "/client/clientStaff.do", method = RequestMethod.POST)
    
    public String saveClientStaff(HttpServletRequest request, Long clientId,ModelMap model,
       Party newparty,  SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Staff Save!");
       /* if(result.hasErrors()) {
			this.getClientStaff(request, model, staffParty, clientId,clientPartyName);
        	return null;
        }*/
        
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.newparty");
        Party firmParty = crmManager.getPartyById(clientId);

        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        // OrganizationType clientOrgType =
        // PMUtil.getClientOrganizationType(crmManager);
        PersonType personType = PMUtil.getPersonTypeById(PersonType.PERSON_TYPE_STAFF.getId(),
                crmManager);
        RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),
                crmManager);

        //default staff is giving HOME address
        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
        newparty.getDefaultPartySite().setPartySiteType(partySiteType);
        if(newparty.getId() == null){
	        String userName = newparty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
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
	            this.getFirmStaff(request, model, newparty);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }

        saveParty(firmParty, newparty, staffPartyType, null,staffRelationType, personType, phonesToBeRemoved,"ROLE_STAFF", clientId);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + newparty.getId() +
            "&clientId=" + clientId + "&saveSuccess=true";

        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/client/clientDetail_old.do", method = RequestMethod.POST)
    public String saveClient(HttpServletRequest request, 
    	@Valid @ModelAttribute("clientParty")Party clientParty,BindingResult result, SessionStatus status, ModelMap model,
        List<PhoneCommunication> phonesToBeRemoved, Long clientId) {
        logger.info("Client Module Save!");

//        if(result.hasErrors()) {
//        	this.getClient(request, model, clientParty, clientId);
//        	return null;
//        }
        
        HttpSession session = request.getSession(false);
        PartyDTO firm = (PartyDTO) session.getAttribute("firm");
        Long firmId = (firm != null) ? firm.getId() : null;
        Party firmParty = crmManager.getPartyById(firmId);
        
        PartyType clientPartyType = PMUtil.getPartyOrganizationType(crmManager);
        OrganizationType clientOrgType = PMUtil.getClientOrganizationType(crmManager);
        RelationshipType clientRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(),
                crmManager);
        saveParty(firmParty, clientParty, clientPartyType, clientOrgType,
            clientRelationType, null, phonesToBeRemoved, null, clientId);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?clientId=" + clientParty.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

    //Added By Savitri
    @RequestMapping(value = "/appadmin/adminFirmModule.do", method = RequestMethod.POST)
    public String saveFirm(HttpServletRequest request, ModelMap model,
    		@Valid Party party, SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Module Save!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
        if(result.hasErrors()) {
            this.getFirm(request, model, party, firmId);
            return null;
      }
        
        Party firmParty = crmManager.getPartyById(firmId);
        //bug no 511
        String id = request.getParameter("id");
       // Long idval = Long.parseLong(id);
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
        saveManageFirm(firmParty, party, firmPartyType, firmOrgType,
            null, null, phonesToBeRemoved, listOfAdminCodes);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + party.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

    private PartyRelationship saveParty(Party mainParty, Party relatedParty,
        PartyType relatedPartyType, OrganizationType relatedOrgType,
        RelationshipType relationshipType, PersonType personType,
        List<PhoneCommunication> phonesToBeRemoved, String role, Long clientId) {
//        relatedParty.setCreateUserId("system");

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
            if(partySite == null){
            	 partySite = crmManager.getPartySiteById(relatedParty.getId());
            }
            if(partySite != null){
            	System.out.println("test");	
            
            address.setPartySite(partySite);
            partySites.add(partySite);
            }
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

        String encryptedPassword = EncryptionUtil.getInstance().encrypt("password");
        PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
                relatedParty, role, relationshipType, encryptedPassword, null, clientId);
        crmManager.deletePhoneCommunication(phonesToBeRemoved);

        return rel;
    }

    @RequestMapping(value = "/mobileadmin/mobileAdminFirmModule.do", method = RequestMethod.POST)
    public String saveMobileFirm(HttpServletRequest request, ModelMap model,
    		@Valid Party party, SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Client Module Save!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
        if(result.hasErrors()) {
            this.getFirm(request, model, party, firmId);
            return null;
      }
        
        Party firmParty = crmManager.getPartyById(firmId);
        //bug no 511
        String id = request.getParameter("id");
       // Long idval = Long.parseLong(id);
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
        saveManageFirm(firmParty, party, firmPartyType, firmOrgType,
            null, null, phonesToBeRemoved, listOfAdminCodes);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + party.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
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
            if(partySite == null){
              	 partySite = crmManager.getPartySiteById(relatedParty.getId());
            }
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
    @RequestMapping(value = "/client/checkEmployeeExists.do", method = RequestMethod.GET)
	 @ResponseBody
	 public boolean checkEmployeeExists(Long id){
		 return taskModuleDao.checkEntityExists(id, PointOfContact.class);
	 }
    
    @RequestMapping(value = "/client/clientStaff.do", method = RequestMethod.GET)
    public String getClientStaff(HttpServletRequest request, ModelMap model,
        Party party, Long clientId, String clientPartyName) {
        logger.info("/client/clientStaff.do!");

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

        /*List<PersonType> allPersonTypeSet = crmManager.getPersonTypeList();
        
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
        }*/
        return "clientStaff.tilesView";
    }
    
   
    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/clientOfficersAndShareHolders.do", method = RequestMethod.GET)
    public String getAllShareholders(HttpServletRequest request, ModelMap model,
    		@ModelAttribute ("party")Party party, Long clientId) {
        logger.info("clientOfficersAndShareHolders.do!");
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
        
        //cached is not applied to staffListByClientId. Since it was not showing list of newly created clientStaff. Ticket No:360 is fixed.
//        List<KeyValue> staffListByClientId = PMUtil.getCachedDropdownPartyList(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
        List<KeyValue> staffListByClientId = crmManager.getPartyDropdownListForRelationship(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
        model.addAttribute("staffListByClientId", staffListByClientId);
        
        return "clientOfficersAndShareHolders.tilesView";
    }
    							
    @RequestMapping(value = "/mobileclient/mobileClientOfficersAndShareHolders.do", method = RequestMethod.GET)
    public String getMobileAllShareholders(HttpServletRequest request, ModelMap model,
    		@ModelAttribute ("party")Party party, Long clientId) {
        logger.info("clientOfficersAndShareHolders.do!");
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
        
        //cached is not applied to staffListByClientId. Since it was not showing list of newly created clientStaff. Ticket No:360 is fixed.
//        List<KeyValue> staffListByClientId = PMUtil.getCachedDropdownPartyList(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
        List<KeyValue> staffListByClientId = crmManager.getPartyDropdownListForRelationship(clientId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
        model.addAttribute("staffListByClientId", staffListByClientId);
        
        return "mobileclientOfficersAndShareHolders.tilesView";
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

    private void setDataForUI(HttpServletRequest request, ModelMap model,
            Party party,Long firmId) {
            model.addAttribute("party", party);
            setReferenceData(model);

            /*Long firmId = PMUtil.getFirmIdFromSession(request);*/
            setPartnerData(firmId, model);

            setStaffData(firmId, model);

            party.getDefaultPartySite().getDefaultPointOfContact()
                 .populateAllCommunications();

            Address address = party.getDefaultPartySite().getAddress();
            List countryCodeSet = PMUtil.getCachedDropdownCodesList((long) 298, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);

            model.addAttribute("countryCodeSet", countryCodeSet);
            if ((address != null) && (address.getCountryCode() != null)) {
            	List stateSet = PMUtil.getCachedDropdownCodesList((long) 298, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
                model.addAttribute("statesSet", stateSet);
            }
            
            List titleCodeList = PMUtil.getCachedDropdownCodesList(firmId, CodeType.FIRM_STAFF_TITLE_CODE.getId(), codesManager, null);
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
   public String saveFirmStaff(HttpServletRequest request, ModelMap model,Party newparty,
    		 Long clientId,SessionStatus status,List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Firm Staff Save!");
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.newparty");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        
        if(newparty.getId() == null){
	        String userName = newparty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
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
	            this.getFirmStaff(request, model, newparty);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        
        newparty = savePerson(request, firmId, clientId, newparty, result, status, phonesToBeRemoved);
        String baseURL = request.getParameter("baseURL");
        String returnURL = request.getParameter("baseURL");
        if(newparty != null){
        if(newparty.getNewStat() == null){
        	newparty.setNewStat(0);
        		returnURL = baseURL + "?id=" + newparty.getPerson().getParty().id+"&saveSuccess=true";
         }
         if(newparty.getNewStat() == 1)
         {
         baseURL = request.getParameter("baseURL");
         if(newparty.getPerson().getParty().id != null){
         returnURL = baseURL + "?id=" + newparty.getPerson().getParty().id +
            "&saveSuccess=true";
         }
         }
        }
        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/firmadmin/manageFirmStaff.do", method = RequestMethod.GET)
    public String getFirmStaff(HttpServletRequest request, ModelMap model,
        Party party) {
        logger.info("firmStaff.do!");
        firmstaffmethod(request, model, party);
        return "manageFirmStaff.tilesView";
    }
    
    @RequestMapping(value = "/mobilefirmadmin/manageFirmStaffMobile.do", method = RequestMethod.GET)
    public String getFirmStaffMobile(HttpServletRequest request, ModelMap model,
        Party party) {
        logger.info("mobilefirmStaff.do!");
        firmstaffmethod(request, model, party);
        return "manageFirmStaffMobile.tilesView";
    }

	private void firmstaffmethod(HttpServletRequest request, ModelMap model,
			Party party) {
		Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

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
	}

    @RequestMapping(value = "/manageFirmPartner.do", method = RequestMethod.POST)
    public String saveFirmPartner(HttpServletRequest request, Long firmId,
        Long clientId, Party staffParty, BindingResult result,
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

        saveParty(firmParty, staffParty, staffPartyType, null,
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
    @RequestMapping(value = "/appadmin/adminFirmModule.do", method = RequestMethod.GET)
    public String getFirm(HttpServletRequest request, ModelMap model,
        Party party, Long firmId) {
        logger.info("Client Module!");
        setDataForUI(request, model, party);
        return "adminFirmModule.tilesView";
    }

    @RequestMapping(value = "/mobileadmin/mobileAdminFirmModule.do", method = RequestMethod.GET)
    public String getMobileFirm(HttpServletRequest request, ModelMap model,
        Party party, Long firmId) {
        logger.info("Client Module!");
        setDataForUI(request, model, party);
        return "mobileAdminFirmModule.tilesView";
    }
    
    @RequestMapping(value = "/appadmin/adminFirmEmployee.do", method = RequestMethod.POST)
    public String saveFirmEmployee(HttpServletRequest request,ModelMap model, Long newfirmId,
        Long clientId, Party employeeParty, SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Firm Employee Save!");
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.employeeParty");
        if(employeeParty.getId() == null){
	        String userName = employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
	        List<Integer> listOfPersonType = new ArrayList<Integer>();
	        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
	        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, newfirmId);
	        
	        boolean isEmailValid = false;
	        for (KeyValue keyValue : eamilList) {
				if(userName.equals(keyValue.value)){
					isEmailValid = true;
				}
			}
	        if(isEmailValid) {
	            this.getFirmEmployee(request, model, employeeParty, newfirmId,newfirmId);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }
        employeeParty = savePerson(request, newfirmId, clientId, employeeParty, result, status, phonesToBeRemoved);

        String baseURL = request.getParameter("baseURL");
        String returnURL = request.getParameter("baseURL");
        if(employeeParty != null){
        if(employeeParty.getNewStat() != null && employeeParty.getNewStat() == 1){
         baseURL = request.getParameter("baseURL");
         if(employeeParty.getPerson().getParty().id != null){
         returnURL = baseURL + "?newfirmId=" +
            request.getParameter("newfirmId") + "&id=" + employeeParty.getPerson().getParty().id +
            "&saveSuccess=true";
         }
        }
        }
        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/mobileadmin/mobileAdminFirmEmployee.do", method = RequestMethod.POST)
    public String saveMobileFirmEmployee(HttpServletRequest request,ModelMap model, Long newfirmId,
        Long clientId, Party employeeParty, SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
        logger.info("Firm Employee Save!");
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.employeeParty");
        if(employeeParty.getId() == null){
	        String userName = employeeParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
	        List<Integer> listOfPersonType = new ArrayList<Integer>();
	        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
	        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
	        List<KeyValue> eamilList = PMUtil.getCachedDropdownEmailList(crmManager, listOfPersonType, newfirmId);
	        
	        boolean isEmailValid = false;
	        for (KeyValue keyValue : eamilList) {
				if(userName.equals(keyValue.value)){
					isEmailValid = true;
				}
			}
	        if(isEmailValid) {
	            this.getFirmEmployee(request, model, employeeParty, newfirmId,newfirmId);
	            model.addAttribute("invalidEmilId", "Given Email Address already exists. Please enter different one");
	            return null;
	        }
        }
        employeeParty = savePerson(request, newfirmId, clientId, employeeParty, result, status, phonesToBeRemoved);

        String baseURL = request.getParameter("baseURL");
        String returnURL = request.getParameter("baseURL");
        if(employeeParty != null){
        if(employeeParty.getNewStat() != null && employeeParty.getNewStat() == 1){
         baseURL = request.getParameter("baseURL");
         if(employeeParty.getPerson().getParty().id != null){
         returnURL = baseURL + "?newfirmId=" +
            request.getParameter("newfirmId") + "&id=" + employeeParty.getPerson().getParty().id +
            "&saveSuccess=true";
         }
        }
        }
        // crmManager.deletePartySiteCommunication(toBeDeletedList);
        return "redirect:" + returnURL;
    }
    
    private Party savePerson(HttpServletRequest request, Long firmId,
			Long clientId, Party employeeParty, BindingResult result,
			SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
    	
    	Party firmParty = crmManager.getPartyById(firmId);
    	
    	PartyType employeePartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        RelationshipType employeeRelationType = new RelationshipType();
        String role= null;
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
			emailService.newSendMailTax("practicem62@gmail.com",username,"","practicem62@gmail.com",sub,body);
			logger.info("Mail sent to user user : " + username);
			returnCode = 1;
		} catch (Exception e) {
			logger.error("Exception for this error is  "
					+ e);
		}
		return returnCode;
	}
    
	
	
	@RequestMapping(value = "/appadmin/adminFirmEmployee.do", method = RequestMethod.GET)
    public String getFirmEmployee(HttpServletRequest request, ModelMap model,
        Party party, Long firmId,Long newfirmId) {
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
        
        return "adminFirmEmployee.tilesView";
    }

	@RequestMapping(value = "/mobileadmin/mobileAdminFirmEmployee.do", method = RequestMethod.GET)
    public String getMobileFirmEmployee(HttpServletRequest request, ModelMap model,
        Party party, Long firmId,Long newfirmId) {
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
        
        return "mobileadminFirmEmployee.tilesView";
    }

    }

