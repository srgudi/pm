package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;


@Controller
public class AjaxController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AjaxController.class);
    private CRMManager crmManager;
    @Autowired
    private CodesManager codesManager;
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    private TaskModuleManager taskModuleManager;

    @Autowired
    public AjaxController(CRMManager crmManager) {
        this.crmManager = crmManager;
    }

    @RequestMapping(value = "/tax/getDays.do", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, List<KeyValue>> getDays(int monthId, HttpServletRequest request) {
    	System.out.println("Hello Apoorva");
        Map<String, List<KeyValue>> retMap = new HashMap();
        List<KeyValue> monthList = new ArrayList();
        	if(monthId == 0 || monthId == 2 || monthId == 4 || monthId == 6 || monthId == 7 || monthId == 9 || monthId == 11){
        		for(Integer i=1 ; i<32 ;i++){
        			 KeyValue keyValue = new KeyValue();
        				String ival = i.toString();
        				keyValue.setKey(ival);
        				keyValue.setValue(ival);
        				monthList.add(keyValue);
					
        		}
        	}else if(monthId == 3 || monthId == 5 || monthId == 8 || monthId == 10 ){
        		for(Integer i=1;i<31;i++){
        			KeyValue keyValue = new KeyValue();
        				String ival = i.toString();
        				keyValue.setKey(ival);
        				keyValue.setValue(ival);
        				monthList.add(keyValue);
					
        		}
        	}else if(monthId == 1){
        		Date d = new Date();
        		Calendar c = Calendar.getInstance();
        		c.setTime(d);
        		int year = c.get(Calendar.YEAR);
				//int year = Calendar.YEAR;
        		int val =((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 ;
        		val++;
        		for(Integer i=1;i<val;i++){
        			KeyValue keyValue = new KeyValue();
        				String ival = i.toString();
        				keyValue.setKey(ival);
        				keyValue.setValue(ival);
        				monthList.add(keyValue);
					
        		}
        		
        	}
    	retMap.put("days", monthList);
       
        return retMap;

    }
    
    @RequestMapping(value = "/getStates.do", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, List<KeyValue>> getStates(Long countryId, HttpServletRequest request) {
    	Long firmId = PMUtil.getFirmIdFromSession(request);
        Map<String, List<KeyValue>> retMap = new HashMap();

        List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, countryId);
    	retMap.put("states", stateSet);
        return retMap;

        // return "sairam";
    }
    
    
    @RequestMapping(value = "/getClientStaffInCharge.do", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, List<KeyValue>> getClientStaffInCharge(Long clientId) {
        Map<String, List<KeyValue>> retMap = new HashMap();

        List<KeyValue> clientStaffList = PMUtil.getClientStafCodeSet(clientId,crmManager);
        retMap.put("clientStaff", clientStaffList);

        return retMap;
    }

    @RequestMapping(value = "/appadmin/getRelativeParentCode.do", method = RequestMethod.POST)
    public @ResponseBody
    Map<String, List<KeyValue>> getRelativeParentCode(Long codeTypeId) {
        Map<String, List<KeyValue>> retMap = new HashMap();
        System.out.println("relative parent code code type id"+codeTypeId);
        List<KeyValue> relativeParentCodeList = PMUtil.getParentCodeList(codeTypeId,
                codesManager);
        if(relativeParentCodeList != null){
        	System.out.println("relative parent list is not empty");
        }
        retMap.put("parentCode", relativeParentCodeList);

        return retMap;
    }

    @RequestMapping(value = "/firmadmin/getRelativeParentCodeWhereAppFalse.do", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, List<KeyValue>> getRelativeParentCodeWhereAppFalse(
        Long codeTypeId) {
        Map<String, List<KeyValue>> retMap = new HashMap();

        List<KeyValue> relativeParentCodeList = PMUtil.getParentCodeListWhereAppFalse(codeTypeId,
                codesManager);
        retMap.put("parentCode", relativeParentCodeList);

        return retMap;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/bank/getPersonDetails.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getPersonDetails(Long id) {
        Map<String, PersonDTO> retMap = new HashMap();
        Party party = null;

        if (id != null) {
            party = crmManager.getPartyById(id);
        } else {
            party = new Party();
        }

        PersonDTO dto = PMUtil.getPersonDTO(party);
        retMap.put("personDetails", dto);

        return retMap;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/getBank.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getBank(Long id) {
        Map<String, PartyDTO> retMap = new HashMap();
        Party party = null;

        if (id != null) {
            party = crmManager.getPartyById(id);
        } else {
            party = new Party();
        }

        PartyDTO dto = PMUtil.getPartyDTO(party);
        retMap.put("bankParty", dto);

        return retMap;
    }

    @RequestMapping(value = "/getPartner.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getPartner(Long id) {
        Map<String, PartyDTO> retMap = new HashMap();
        Party party = null;

        if (id != null) {
            party = crmManager.getPartyById(id);
        } else {
            party = new Party();
        }

        PartyDTO dto = PMUtil.getPartyDTO(party);
        retMap.put("partnerParty", dto);

        return retMap;
    }

    @RequestMapping(value = "/saveTransferAgent.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveTransferAgent(HttpServletRequest request, String name) {
        logger.debug("Inside saveTransferAgent()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Party firmParty = crmManager.getPartyById(firmId);
        Party insParty = null;

        if (id != null) {
            insParty = crmManager.getPartyById(id);
        } else {
            OrganizationType insOrgType = PMUtil.getOrganizationTypeById(OrganizationType.ORGANIZATION_TYPE_TRANSFER_AFENT.getId(),
                    crmManager);
            //TODO remove the hardcodings
            Long bankingFormOfBusiness = Long.valueOf(504);
            Long insIndustry = Long.valueOf(408);
            insParty = prepareOrganizationParty(insOrgType,
                    bankingFormOfBusiness, insIndustry);
        }

        insParty.setName(name);

        RelationshipType insRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM.getId(),
                crmManager);

        saveParty(firmParty, insParty, insRelationType);

        // Map<String, PartyDTO> retMap = new HashMap();
        // retMap.put("bank", PMUtil.getPartyDTO(bankParty));
        return Collections.singletonMap("id", insParty.getId());

        // return retMap;
    }

    @RequestMapping(value = "/saveInsuranceFirm.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveInsuranceFirm(HttpServletRequest request, String name) {
        logger.debug("Inside saveInsuranceFirm()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Party firmParty = crmManager.getPartyById(firmId);
        Party insParty = null;

        if (id != null) {
            insParty = crmManager.getPartyById(id);
        } else {
            OrganizationType insOrgType = PMUtil.getOrganizationTypeById(OrganizationType.ORGANIZATION_TYPE_INSURANCE.getId(),
                    crmManager);
            //TODO remove the hardcodings
            Long bankingFormOfBusiness = Long.valueOf(504);
            Long insIndustry = Long.valueOf(408);
            insParty = prepareOrganizationParty(insOrgType,
                    bankingFormOfBusiness, insIndustry);
        }

        insParty.setName(name);

        RelationshipType insRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM.getId(),
                crmManager);

        saveParty(firmParty, insParty, insRelationType);

        // Map<String, PartyDTO> retMap = new HashMap();
        // retMap.put("bank", PMUtil.getPartyDTO(bankParty));
        return Collections.singletonMap("id", insParty.getId());

        // return retMap;
    }

    @RequestMapping(value = "/saveLawFirm.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveLawFirm(HttpServletRequest request, String name) {
        logger.debug("Inside saveBank()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Party firmParty = crmManager.getPartyById(firmId);
        Party lawFirmParty = null;

        if (id != null) {
            lawFirmParty = crmManager.getPartyById(id);
        } else {
            OrganizationType bankOrganizationType = PMUtil.getOrganizationTypeById(OrganizationType.ORGANIZATION_TYPE_LAW_FIRM.getId(),
                    crmManager);
            //TODO remove the hardcodings
            Long bankingFormOfBusiness = Long.valueOf(504);
            Long lawIndustry = Long.valueOf(418);
            lawFirmParty = prepareOrganizationParty(bankOrganizationType,
                    bankingFormOfBusiness, lawIndustry);
        }

        lawFirmParty.setName(name);

        RelationshipType bankRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM.getId(),
                crmManager);

        saveParty(firmParty, lawFirmParty, bankRelationType);

        // Map<String, PartyDTO> retMap = new HashMap();
        // retMap.put("bank", PMUtil.getPartyDTO(bankParty));
        return Collections.singletonMap("id", lawFirmParty.getId());

        // return retMap;
    }

    @RequestMapping(value = "/bank/saveBank.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveBank(HttpServletRequest request, String name) {
        logger.debug("Inside saveBank()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Party firmParty = crmManager.getPartyById(firmId);
        Party bankParty = null;

        if (id != null) {
            bankParty = crmManager.getPartyById(id);
        } else {
            OrganizationType bankOrganizationType = PMUtil.getBankOrganizationType(crmManager);
            //TODO remove the hardcodings
            Long bankingFormOfBusiness = Long.valueOf(504);
            Long bankingIndustry = Long.valueOf(408);
            bankParty = prepareOrganizationParty(bankOrganizationType,
                    bankingFormOfBusiness, bankingIndustry);
        }

        bankParty.setName(name);

        RelationshipType bankRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK.getId(),
                crmManager);

        saveParty(firmParty, bankParty, bankRelationType);

        // Map<String, PartyDTO> retMap = new HashMap();
        // retMap.put("bank", PMUtil.getPartyDTO(bankParty));
        return Collections.singletonMap("id", bankParty.getId());

        // return retMap;
    }

    @RequestMapping(value = "/appadmin/saveCode.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveCode(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveCode");

        //		Long id = null;
        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            //			id = Long.valueOf(request.getParameter("id"));
            id = Long.valueOf(request.getParameter("id"));
        }

        Code manageCode = crmManager.getCodeById(id);
        manageCode.setActiveFlag(false);
        manageCode.setLastUpdateDate(new Date());
        crmManager.saveCode(manageCode);

//        return Collections.singletonMap("id", manageCodeType.getId());
    }


    @RequestMapping(value = "/appadmin/saveCodeType.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveCodeType(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveTypeCode");

        //		Long id = null;
        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            //			id = Long.valueOf(request.getParameter("id"));
            id = Long.valueOf(request.getParameter("id"));
        }

        CodeType manageCodeType = crmManager.getCodeTypeById(id);
        manageCodeType.setActiveFlag(false);
        manageCodeType.setLastUpdateDate(new Date());
        crmManager.saveCodeType(manageCodeType);

//        return Collections.singletonMap("id", manageCodeType.getId());
    }

    @RequestMapping(value = "/appadmin/saveTaskNotificationRecipient.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveTaskNotificationRecipient(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveTaskNotificationRecipient()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        TaskNotificationRecipient manageTaskNotificationRecipient = taskModuleManager.getNotificationRecipient(id);
        manageTaskNotificationRecipient.setActiveFlag(false);
        manageTaskNotificationRecipient.setLastUpdateDate(new Date());
        taskModuleManager.saveTaskNotificationRecipient(manageTaskNotificationRecipient);

        return Collections.singletonMap("id",
            manageTaskNotificationRecipient.getId());
    }

    @RequestMapping(value = "/appadmin/saveTaskNotificationTemplate.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveTaskNotificationTemplate(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveTaskNotificationTemplate()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        TaskNotificationTemplate manageTaskNotificationTemplate = taskModuleManager.getTaskNotificationTemplate(id);
        manageTaskNotificationTemplate.setActiveFlag(false);
        manageTaskNotificationTemplate.setLastUpdateDate(new Date());
        taskModuleManager.saveTaskNotificationTemplate(manageTaskNotificationTemplate);

        return Collections.singletonMap("id",
            manageTaskNotificationTemplate.getId());
    }

    @RequestMapping(value = "/appadmin/saveJurisdictions.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveJurisdictions(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveJurisdictions()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Jurisdiction manageJurisdiction = crmManager.getJurisdictionById(id);
        manageJurisdiction.setActiveFlag(false);
        manageJurisdiction.setLastUpdateDate(new Date());
        crmManager.saveJurisdiction(manageJurisdiction);

        /*return Collections.singletonMap("id", manageJurisdiction.getId());*/
    }

    @RequestMapping(value = "/appadmin/saveTimezone.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveTimezone(HttpServletRequest request, Long firmId) {
        logger.debug("Inside saveTimezone()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Timezone manageTimezone = crmManager.getTimezoneById(id);
        manageTimezone.setActiveFlag(false);
        manageTimezone.setLastUpdateDate(new Date());
        crmManager.saveTimezone(manageTimezone);

        /*return Collections.singletonMap("id", manageTimezone.getId());*/
    }

    @RequestMapping(value = "/firmadmin/savePartyCode.do", method = RequestMethod.POST)
    public @ResponseBody
    void savePartyCode(HttpServletRequest request) {
        logger.debug("Inside savePartyCode()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        PartyCode partyCode = crmManager.getPartyCodeById(id);
        partyCode.setActiveFlag(false);
        partyCode.setLastUpdateDate(new Date());
        crmManager.savePartyCode(partyCode);

        /*return Collections.singletonMap("id", partyCode.getId());*/
    }

    // sagar: Manager Firm Staff 
    /*@RequestMapping(value = "/saveStaff.do", method = RequestMethod.POST)
    public @ResponseBody
    Map saveStaff(HttpServletRequest request, String firstName,
                    String lastName, String jobTitle, String comittee,
                    Date dateOfBirth, String annualCompensation, Long firmId) {
            logger.debug("Inside saveStaff()");
            Long id = null;
    
            if (request.getParameter("id") != null
                            && !"_empty".equals(request.getParameter("id"))) {
                    id = Long.valueOf(request.getParameter("id"));
            }
    
            Party firmStaffParty = crmManager.getPartyById(id);
            Party staffParty = null;
    
            if (id != null) {
                    staffParty = crmManager.getPartyById(id);
            } else {
                    PersonType staffPersonType = PMUtil
                                    .getPartnerPersonType(crmManager);
                    Code staffingFirmOfBusiness = codesManager.getCodeById(Long
                                    .valueOf(504));
                    Code staffingIndustry = codesManager.getCodeById(Long.valueOf(408));
                    staffParty = preparePersonParty(staffPersonType,
                                    staffingFirmOfBusiness, staffingIndustry);
            }
            Person staffPerson = firmStaffParty.getPerson();
            //staffPerson.setId(id);
            if(staffPerson.getId()==id){
            staffPerson.setFirstName(firstName);
            staffPerson.setLastName(lastName);
            SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy");
            try {
                    staffPerson.setDateOfBirth(sdf.parse(dateOfBirth));
            } catch (ParseException e) {
                    e.printStackTrace();
            }
            staffPerson.setDateOfBirth(dateOfBirth);
    
            //staffPerson.setPersonType(PersonType.PERSON_TYPE_STAFF);
            }
            PersonDetails personDetails = staffPerson.getPersonDetails();
            //PersonDetails personDetails = new PersonDetails();
            //personDetails.setJobTitle(jobTitle);
            personDetails.setAnnualCompensation(annualCompensation);
            personDetails.setComittee(comittee);
    
            personDetails.setPerson(staffPerson);
            staffPerson.setPersonDetails(personDetails);
    
    //                staffParty.setPartyType(PartyType.PARTY_TYPE_PERSON);
            staffParty.setPerson(staffPerson);
            staffParty.setName(firstName+lastName);
            staffPerson.setParty(staffParty);
    
            RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(
                            RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(), crmManager);
    
            saveParty(firmStaffParty, staffParty, staffRelationType);
            return Collections.singletonMap("id", staffParty.getId());
    
    }*/

    /*
     *
     **/

    /*@RequestMapping(value = "/savePartner.do", method = RequestMethod.POST)
    public @ResponseBody
    Map savePartner(HttpServletRequest request, String firstName,
                    String lastName, String jobTitle, String comittee,
                    Date dateOfBirth, String annualCompensation, Long firmId) {
            logger.debug("Inside saveStaff()");
            Long id = null;
    
            if (request.getParameter("id") != null
                            && !"_empty".equals(request.getParameter("id"))) {
                    id = Long.valueOf(request.getParameter("id"));
            }
    
            Party firmStaffParty = crmManager.getPartyById(firmId);
            Party staffParty = null;
    
            if (id != null) {
                    staffParty = crmManager.getPartyById(id);
                    Person staffPerson = staffParty.getPerson();
                    if(staffPerson.getId()==id){
                            staffPerson.setFirstName(firstName);
                            staffPerson.setLastName(lastName);
                            SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy");
                            try {
                                    staffPerson.setDateOfBirth(sdf.parse(dateOfBirth));
                            } catch (ParseException e) {
                                    e.printStackTrace();
                            }
                            staffPerson.setDateOfBirth(dateOfBirth);
    
                            //staffPerson.setPersonType(PersonType.PERSON_TYPE_STAFF);
                            }
                    PersonDetails personDetails = staffPerson.getPersonDetails();
                    //PersonDetails personDetails = new PersonDetails();
                    //personDetails.setJobTitle(jobTitle);
                    if(personDetails!=null){
                    personDetails.setJobTitle(jobTitle);
                    personDetails.setAnnualCompensation(annualCompensation);
                    personDetails.setComittee(comittee);
    
                    personDetails.setPerson(staffPerson);
                    }else{
                            personDetails=new PersonDetails();
                            personDetails.setJobTitle(jobTitle);
                            personDetails.setAnnualCompensation(annualCompensation);
                            personDetails.setComittee(comittee);
                            personDetails.setPerson(staffPerson);
                    }
                    staffPerson.setPersonDetails(personDetails);
    
    //                        staffParty.setPartyType(PartyType.PARTY_TYPE_PERSON);
                    staffParty.setPerson(staffPerson);
                    staffParty.setName(firstName+lastName);
                    staffPerson.setParty(staffParty);
    
                    RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(
                                    RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), crmManager);
    
                    saveParty(firmStaffParty, staffParty, staffRelationType);
                    return Collections.singletonMap("id", staffParty.getId());
    
            } else {
                    PersonType staffPersonType = PMUtil
                                    .getPartnerPersonType(crmManager);
                    Code staffingFirmOfBusiness = codesManager.getCodeById(Long
                                    .valueOf(504));
                    Code staffingIndustry = codesManager.getCodeById(Long.valueOf(408));
                    staffParty = preparePersonParty(staffPersonType,
                                    staffingFirmOfBusiness, staffingIndustry);
                    Person staffPerson = new Person();
                    staffPerson.setId(staffParty.getId());
                    staffPerson.setFirstName(firstName);
                    staffPerson.setLastName(lastName);
                    staffPerson.setDateOfBirth(dateOfBirth);
                    PersonDetails personDetails = new PersonDetails();
                    personDetails.setJobTitle(jobTitle);
                    personDetails.setAnnualCompensation(annualCompensation);
                    personDetails.setComittee(comittee);
                    personDetails.setPerson(staffPerson);
                    staffPerson.setPersonDetails(personDetails);
                    staffParty.setPerson(staffPerson);
                    staffParty.setName(firstName+lastName);
                    staffPerson.setParty(staffParty);
    
                    RelationshipType staffRelationType = PMUtil.getRelationshipTypeById(
                                    RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), crmManager);
    
                    saveParty(firmStaffParty, staffParty, staffRelationType);
                    return Collections.singletonMap("id", staffParty.getId());
            }
    
    
    }*/
    private void saveParty(Party mainParty, Party relatedParty,
        RelationshipType relationshipType) {
        crmManager.createPartyAndRelationship(mainParty, relatedParty,
            "system", relationshipType, "", null, null);
    }

    public Party prepareOrganizationParty(OrganizationType organizationType,
        Long formOfBusiness, Long industryType) {
        Party party = new Party();
        party.setActiveFlag(Boolean.TRUE);
//        party.setCreateUserId("system");

        PartyType orgPartyType = PMUtil.getPartyOrganizationType(crmManager);
        OrganizationType bankOrgType = PMUtil.getBankOrganizationType(crmManager);
        party.setPartyType(orgPartyType);

        Organization org = new Organization();
        org.setOrganizationType(organizationType);
        org.setFormOfBusiness(formOfBusiness);
        org.setIndustryType(industryType);
        org.setParty(party);
        party.setOrganization(org);

        return party;
    }

    /*private Party preparePersonParty(PersonType staffPersonType,
                    Code staffingFirmOfBusiness, Code staffingIndustry) {
    
            Party party = new Party();
            party.setActiveFlag(Boolean.TRUE);
            party.setCreateUserId("system");
            PartyType orgPartyType = PMUtil.getPartyOrganizationType(crmManager);
    //                PersonType staffPersonType = PMUtil.getPartnerPersonType(crmManager);
            party.setPartyType(orgPartyType);
    
            return party;
    }*/
    @RequestMapping(value = "/firmadmin/saveTax.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveTax(HttpServletRequest request, String name, String description,
        Long firmPracticeID) {
        logger.debug("Inside saveTax()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        FirmPracticeType firmPracticeType = taxModuleManager.getFirmPracticeTypeById(id);
        firmPracticeType.setActiveFlag(false);
        firmPracticeType.setLastUpdateDate(new Date());
        taxModuleManager.saveFirmPracticeInfo(firmPracticeType);
    }

    @RequestMapping(value = "/saveLocationList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveLocationList(HttpServletRequest request, Long clientId) {
        logger.debug("Inside saveLocationList()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        PartySite partySite = crmManager.getPartySiteById(id);
        partySite.setActiveFlag(false);
        partySite.setLastUpdateDate(new Date());
        crmManager.savePartySite(partySite);
    }

    @RequestMapping(value = "/saveAccountAjaxList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveAccountAjaxList(HttpServletRequest request, Long clientId) {
        logger.debug("Inside saveAccountAjaxList()");

        Long id = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        PartyAccount account = crmManager.getAccountById(id);
        account.setActiveFlag(false);
        account.setLastUpdateDate(new Date());
        crmManager.savePartyAccount(account, null);
    }

    /*@RequestMapping(value = "/saveMainStaffList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveMainStaffList(HttpServletRequest request, Long firmId) {
            logger.debug("Inside saveAccountAjaxList()");
            Long id = null;
    
            if (request.getParameter("id") != null
                            && !"_empty".equals(request.getParameter("id"))) {
                    id = Long.valueOf(request.getParameter("id"));
            }
    
            Party party = crmManager.getPartyById(id);
            party.setActiveFlag(false);
            crmManager.saveParty(party);
    }*/
    
    
//    here, "saveClientAjaxList.do" is written twice because "delet option was not working for Manage Firm, 
//  only Client Staff was working
    @RequestMapping(value = "/saveClientAjaxList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveClientAjaxList(HttpServletRequest request) {
        logger.debug("Inside saveAccountAjaxList()");

        Long id = null;
        Party relatedParty = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        String oper = String.valueOf(request.getParameter("oper"));
        
        if (oper.equalsIgnoreCase("del")) {
            relatedParty = crmManager.getPartyById(id);
            relatedParty.setActiveFlag(false);
            relatedParty.setLastUpdateDate(new Date());
            crmManager.saveParty(relatedParty);
        } else if (oper.equalsIgnoreCase("edit")) {
            relatedParty = crmManager.getPartyById(id);
            relatedParty.setActiveFlag(true);
            relatedParty.setCreateDate(new Date());
            crmManager.saveParty(relatedParty);
        } else if (oper.equalsIgnoreCase("add")) {
            
        }
        
       
    }
    
    @RequestMapping(value = "/saveoffandSharAjaxList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveOfficersAjaxList(HttpServletRequest request) {
        logger.debug("Inside saveAccountAjaxList()");

        Long id = null;
        Party relatedParty = null;

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        String oper = String.valueOf(request.getParameter("oper"));
        
        if (oper.equalsIgnoreCase("del")) {
        	System.out.println("vvvvvvvvvv");
            relatedParty = crmManager.getPartyById(id);
            relatedParty.getPerson().getPersonDetails().setNoOfSharesOwned(null);
            relatedParty.setLastUpdateDate(new Date());
            crmManager.saveParty(relatedParty);
        } else if (oper.equalsIgnoreCase("edit")) {
            relatedParty = crmManager.getPartyById(id);
            relatedParty.setActiveFlag(true);
            relatedParty.setCreateDate(new Date());
            crmManager.saveParty(relatedParty);
        } else if (oper.equalsIgnoreCase("add")) {
            
        }
        
       
    }
//  here, "saveClientAjaxList.do" is written twice because "delet option was not working for Manage Firm, 
//  only Client Staff was working
   @RequestMapping(value = "/appadmin/saveClientAjaxList.do", method = RequestMethod.POST)
   public @ResponseBody
   void saveAdminClientAjaxList(HttpServletRequest request) {
       logger.debug("Inside saveAccountAjaxList()");

       Long id = null;
       Party relatedParty = null;

       if ((request.getParameter("id") != null) &&
               !"_empty".equals(request.getParameter("id"))) {
           id = Long.valueOf(request.getParameter("id"));
       }
       
       String oper = String.valueOf(request.getParameter("oper"));

       if (oper.equalsIgnoreCase("del")) {
           relatedParty = crmManager.getPartyById(id);
           relatedParty.setActiveFlag(false);
           relatedParty.setLastUpdateDate(new Date());
           crmManager.saveParty(relatedParty);
       } else if (oper.equalsIgnoreCase("edit")) {
           relatedParty = crmManager.getPartyById(id);
           relatedParty.setActiveFlag(true);
           relatedParty.setCreateDate(new Date());
           crmManager.saveParty(relatedParty);
       } 

   }
   
// here, "saveClientAjaxList.do" is written trice because "delet option was not working for Firm Staff, 
// only Client Staff / Manage Firm was working
  @RequestMapping(value = "/firmadmin/saveClientAjaxList.do", method = RequestMethod.POST)
  public @ResponseBody
  void saveFirmAdminAjaxList(HttpServletRequest request) {
      logger.debug("Inside saveAccountAjaxList()");

      Long id = null;
      Party relatedParty = null;

      if ((request.getParameter("id") != null) &&
              !"_empty".equals(request.getParameter("id"))) {
          id = Long.valueOf(request.getParameter("id"));
      }
      
      String oper = String.valueOf(request.getParameter("oper"));

      if (oper.equalsIgnoreCase("del")) {
          relatedParty = crmManager.getPartyById(id);
          relatedParty.setActiveFlag(false);
          relatedParty.setLastUpdateDate(new Date());
          crmManager.saveParty(relatedParty);
      } else if (oper.equalsIgnoreCase("edit")) {
          relatedParty = crmManager.getPartyById(id);
          relatedParty.setActiveFlag(true);
          relatedParty.setCreateDate(new Date());
          crmManager.saveParty(relatedParty);
      } 
  }

    @RequestMapping(value = "/tax/saveTaxModuleList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveTaxModuleList(HttpServletRequest request) {
        logger.debug("Inside saveTaxModuleList()");

        Long id = null;

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }

        ClientPracticeInfo clientPracticeInfo = taxModuleManager.getClientPracticeInfo(id);
        clientPracticeInfo.setActiveFlag(false);
        clientPracticeInfo.setLastUpdateDate(new Date());
        taxModuleManager.saveTaxPracticeInfo(clientPracticeInfo, null);

        /*return Collections.singletonMap("id", clientPracticeInfo.getId());*/
    }
    
    @RequestMapping(value = "/task/savetaskAjaxList.do", method = RequestMethod.POST)
    public @ResponseBody
    void savetaskAjaxList(HttpServletRequest request) {
    
        logger.debug("Inside savetaskAjaxList");
        Long id = null;
        Task relatedTask = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }
        
        String oper = String.valueOf(request.getParameter("oper"));

        if (oper.equalsIgnoreCase("del")) {
            
            relatedTask = taskModuleManager.getTaskById(id);
            if(relatedTask == null){
           	 taskModuleManager.removeAdhocTaskById(id);
           }
            else{
            relatedTask.setActiveFlag(false);
            relatedTask.setLastUpdateDate(new Date()); 
            taskModuleManager.saveTask(relatedTask);
            }
            
        }
       
    }
    @RequestMapping(value = "/mobiletask/saveMobiletaskAjaxList.do", method = RequestMethod.POST)
    public @ResponseBody
    void saveMobiletaskAjaxList(HttpServletRequest request) {
    
        logger.debug("Inside savetaskAjaxList");
        Long id = null;
        Task relatedTask = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);

       /* if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }*/

        if ((request.getParameter("id") != null) &&
                !"_empty".equals(request.getParameter("id"))) {
            id = Long.valueOf(request.getParameter("id"));
        }
        
        String oper = String.valueOf(request.getParameter("oper"));

        if (oper.equalsIgnoreCase("del")) {
            
            relatedTask = taskModuleManager.getTaskById(id);
            if(relatedTask == null){
           	 taskModuleManager.removeAdhocTaskById(id);
           }
            else{
            relatedTask.setActiveFlag(false);
            relatedTask.setLastUpdateDate(new Date()); 
            taskModuleManager.saveTask(relatedTask);
            }
            
        }
	}

}
