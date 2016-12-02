package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Jurisdiction;
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
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.CommunicationDTO;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TimezoneDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * Handles requests for the application welcome page.
 */
@Controller
public class ClientListController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(ClientListController.class);
    private CRMManager crmManager;
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    private TaskModuleManager taskModuleManager;

    @Autowired
    public ClientListController(CRMManager crmManager) {
        this.crmManager = crmManager;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/locationList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map locationList(HttpServletRequest request, Long clientId, Long partyId) {
        logger.info("Location Bank List!");

        Map retMap = new HashMap();
        if (clientId != null) {
            partyId = clientId;
        }
        Page page = PMUtil.populatePageObject(request);
        Long count = null;
       
       
          if(page != null){
        	count = crmManager.getLocationListCount(partyId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<LocationDTO> partySiteList =crmManager.getLocationList(partyId, count);
        
        populateReturnMapWithPageDatails(retMap, partySiteList, page);

        return retMap;
    }

    @RequestMapping(value = "/appadmin/timeZoneList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map TimeZoneList(HttpServletRequest request, Long clientId, Long partyId) {
        logger.info("TimeZone List!");

        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        
        if(page != null){
        	count = crmManager.getTimezoneListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        
        List<TimezoneDTO> timezoneDTOList =crmManager.getTimezoneDTOList(count);
        for (TimezoneDTO timezoneDTO : timezoneDTOList) {
			if(timezoneDTO.getActiveFlag() == true){
				timezoneDTO.setStatus("Active");
			}else{
				timezoneDTO.setStatus("Inactive");
			}
		}
        
        populateReturnMapWithPageDatails(retMap, timezoneDTOList, page);
        }
        return retMap;
    
  }
    private TimezoneDTO getTimezoneDTO(Timezone timezone) {
        TimezoneDTO timezoneDTO = new TimezoneDTO();
        timezoneDTO.setId(timezone.getId());
        timezoneDTO.setGlobalTimezoneName(timezone.getGlobalTimezoneName());
        timezoneDTO.setGmtDeviationHours(timezone.getGmtDeviationHours());
        timezoneDTO.setDstFlag(timezone.getDstFlag());
        timezoneDTO.setDstBeginMonth(timezone.getDstBeginMonth());
        timezoneDTO.setDstBeginDay(timezone.getDstBeginDay());
        timezoneDTO.setDstBeginDayOfWeek(timezone.getDstBeginDayOfWeek());
        timezoneDTO.setDstBeginHour(timezone.getDstBeginHour());
        timezoneDTO.setDstEndMonth(timezone.getDstEndMonth());
        timezoneDTO.setDstEndDay(timezone.getDstEndDay());
        timezoneDTO.setDstEndDayOfWeek(timezone.getDstEndDayOfWeek());
        timezoneDTO.setDstEndDayOfWeek(timezone.getDstEndDayOfWeek());
        timezoneDTO.setDstEndHour(timezone.getDstEndHour());
        timezoneDTO.setDstStdCd(timezone.getDstStdCd());
        timezoneDTO.setDstSavingsCd(timezone.getDstSavingsCd());

        if (timezone.activeFlag == true) {
            timezoneDTO.setStatus("Active");
        } else {
            timezoneDTO.setStatus("Inactive");
        }

        return timezoneDTO;
    }

    @RequestMapping(value = "/tax/jurisdictionsList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getJurisdictions(HttpServletRequest request, Long clientId, Long partyId) {
        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        if(page != null){
        	count = crmManager.getJurisdictionListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<JurisdictionDTO> jurisdictionDTOList = crmManager.getJurisdictionDTOList(count);
        
        for (JurisdictionDTO jurisdictionDTO : jurisdictionDTOList) {
			if(jurisdictionDTO.getActiveFlag() == true ){
				jurisdictionDTO.setStatus("Active");
			}else{
				jurisdictionDTO.setStatus("Inactive");
			}
		}
        
        populateReturnMapWithPageDatails(retMap, jurisdictionDTOList, page);

        return retMap;
    }

    private JurisdictionDTO getJurisdictionDTO(Jurisdiction jurisdiction) {
        JurisdictionDTO jurisdictionDTO = new JurisdictionDTO();
        jurisdictionDTO.setId(jurisdiction.getId());
        jurisdictionDTO.setCountry(jurisdiction.getCountry());
        jurisdictionDTO.setState(jurisdiction.getState());
        jurisdictionDTO.setCounty(jurisdiction.getCounty());
        jurisdictionDTO.setCity(jurisdiction.getCity());

        if (jurisdiction.activeFlag == true) {
            jurisdictionDTO.setStatus("Active");
        } else {
            jurisdictionDTO.setStatus("Inactive");
        }

        jurisdictionDTO.setGlobalTimezoneName(jurisdiction.getTimezone()
                                                          .getGlobalTimezoneName());
        jurisdictionDTO.setGmtDeviationHours(jurisdiction.getTimezone()
                                                         .getGmtDeviationHours());

        return jurisdictionDTO;
    }

    @RequestMapping(value = "/appadmin/codeTypeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getCodeType(HttpServletRequest request) {
    	Map retMap = new HashMap();
    	 Long count = null;
        Page page = PMUtil.populatePageObject(request);
         
        if(page != null){
        	count = crmManager.getCodeTypeListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<CodeTypeDTO> codeTypeList =crmManager.getCodeTypeDTOList(count);
        
        for (CodeTypeDTO codeTypeDTO : codeTypeList) {
			if(codeTypeDTO.getActiveFlag() == true){
				codeTypeDTO.setStatus("Active");
			}else{
				codeTypeDTO.setStatus("Inactive");
			}
			if(codeTypeDTO.getApplicationLevelIndicator() == true){
				codeTypeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeTypeDTO.setStrApplicationLevelIndicator("No");
			}
		}

        populateReturnMapWithPageDatails(retMap, codeTypeList, page);

        return retMap;
    }

    @RequestMapping(value = "/mobileadmin/codeTypeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getMobileCodeType(HttpServletRequest request) {
    	Map retMap = new HashMap();
    	 Long count = null;
        Page page = PMUtil.populatePageObject(request);
         
        if(page != null){
        	count = crmManager.getCodeTypeListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<CodeTypeDTO> codeTypeList =crmManager.getCodeTypeDTOList(count);
        
        for (CodeTypeDTO codeTypeDTO : codeTypeList) {
			if(codeTypeDTO.getActiveFlag() == true){
				codeTypeDTO.setStatus("Active");
			}else{
				codeTypeDTO.setStatus("Inactive");
			}
			if(codeTypeDTO.getApplicationLevelIndicator() == true){
				codeTypeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeTypeDTO.setStrApplicationLevelIndicator("No");
			}
		}

        populateReturnMapWithPageDatails(retMap, codeTypeList, page);

        return retMap;
    }
    
    private CodeTypeDTO getCodeTypeDTO(CodeType codeType) {
        CodeTypeDTO codeTypeDTO = new CodeTypeDTO();
        codeTypeDTO.setId(codeType.getId());
        codeTypeDTO.setName(codeType.getName());

        if (codeType.isApplicationLevelIndicator() == true) {
            codeTypeDTO.setStrApplicationLevelIndicator("Yes");
        } else {
            codeTypeDTO.setStrApplicationLevelIndicator("No");
        }

        if (codeType.getParentCodeType() != null) {
            codeTypeDTO.setParentCodeTypeId(codeType.getParentCodeType().getId());
            codeTypeDTO.setParentCodeTypeName(codeType.getParentCodeType()
                                                      .getName());
        }
        codeTypeDTO.setDescription(codeType.getDescription());

        if (codeType.isActiveFlag() == true) {
            codeTypeDTO.setStatus("Active");
        } else {
            codeTypeDTO.setStatus("Inactive");
        }

        return codeTypeDTO;
    }

    @RequestMapping(value = "/appadmin/codeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getCode(HttpServletRequest request) {
        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);

        if(page != null){
        	count = crmManager.getCodeListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<CodeDTO> codeList =crmManager.getCodeDTOList(count);
        for (CodeDTO codeDTO : codeList) {
			if(codeDTO.getActiveFlag() == true){
				codeDTO.setStatus("Active");
			}else{
				codeDTO.setStatus("InActive");
			}
			if(codeDTO.getApplicationLevelIndicator() == true){
				codeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeDTO.setStrApplicationLevelIndicator("No");
			}
		}
        
        populateReturnMapWithPageDatails(retMap, codeList, page);

        return retMap;
    }
    
    @RequestMapping(value = "/appadmin/retriveAdminCode.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getRetriveAdminCode(HttpServletRequest request,Long codeTypeId,Boolean applicationLevelId) {
        Map retMap = new HashMap();
        System.out.println("Retrive Admin Code");
        System.out.println("codetype ID = "+codeTypeId);
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
                            request.getParameter("applicationLevelIndicator");
                            
         /* Integer parentCode = crmManager.getParentCode(codeTypeId); 
          Long newval = parentCode.longValue();*/
//        if(page != null){
        	count = crmManager.getAdminCodeListCount(codeTypeId, applicationLevelId);
//            PMUtil.adjustPagination(page, count.intValue());
//            page.setCount(count.intValue());
//        }
        List<CodeDTO> codeList =crmManager.getAdminCodeDTOList(codeTypeId, applicationLevelId, count);
        for (CodeDTO codeDTO : codeList) {
			if(codeDTO.getActiveFlag() == true){
				codeDTO.setStatus("Active");
			}else{
				codeDTO.setStatus("Inactive");
			}
			if(codeDTO.getApplicationLevelIndicator() == true){
				codeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeDTO.setStrApplicationLevelIndicator("No");
			}
		}
        if(codeList != null){
        System.out.println("list is not empty");
        }
        populateReturnMapWithPageDatails(retMap, codeList, page);

        return retMap;
    }

    private CodeDTO getCodeDTO(Code code) {
        CodeDTO codeDTO = new CodeDTO();
        codeDTO.setId(code.getId());
        codeDTO.setShortName(code.getShortName());
        codeDTO.setLongDescription(code.getLongDescription());
        codeDTO.setApplicationLevelIndicator(code.isApplicationLevelIndicator());

        CodeType codeType = code.getCodeType();
        codeDTO.setCodeTypeId(codeType.getId());
        codeDTO.setCodeTypeName(codeType.getName());

        codeDTO.setSortOrder(code.getSortOrder());

        if (code.getParentCode() != null) {
            codeDTO.setParentCodeId(code.getParentCode().getId());
            codeDTO.setParentCodeShortName(code.getParentCode().getShortName());
        }

        if (code.activeFlag == true) {
            codeDTO.setStatus("Active");
        } else {
            codeDTO.setStatus("Inactive");
        }

        return codeDTO;
    }

    @RequestMapping(value = "/firmadmin/partyCodeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getPartyCode(HttpServletRequest request) {
        Map retMap = new HashMap();
        Long count = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);
        Page page = PMUtil.populatePageObject(request);
        
        logger.info("firmId =" + firmId);

        if(page != null){
        	count = crmManager.getPartyCodeListCount(firmId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<PartyCodeDTO> partyCodeList =crmManager.getPartyCodeDTOList(count,firmId); 
        for (PartyCodeDTO partyCodeDTO : partyCodeList) {
	         if(partyCodeDTO.getActiveFlag()== true){
         		partyCodeDTO.setStatus("Active");
        	}else{
        		partyCodeDTO.setStatus("Inactive");
          	}
        }
        populateReturnMapWithPageDatails(retMap, partyCodeList, page);
        return retMap;
    }
    
    @RequestMapping(value = "/firmadmin/retriveCodeType.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getPartyCodeByCodeTypeId(HttpServletRequest request, Long codeTypeId) {
        Map retMap = new HashMap();
        Long count = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);
        Page page = PMUtil.populatePageObject(request);
        
        logger.info("firmId =" + firmId);

//        if(page != null){
        	count = crmManager.getCountOfCodeTypeByCodeTypeId(firmId,codeTypeId);
//            PMUtil.adjustPagination(page, count.intValue());
//            page.setCount(count.intValue());
//        }
        List<PartyCodeDTO> partyCodeList =crmManager.getListOfCodeTypeByCodeTypeId(count,firmId,codeTypeId); 
        for (PartyCodeDTO partyCodeDTO : partyCodeList) {
	         if(partyCodeDTO.getActiveFlag()== true){
         		partyCodeDTO.setStatus("Active");
        	}else{
        		partyCodeDTO.setStatus("Inactive");
          	}
        }
        populateReturnMapWithPageDatails(retMap, partyCodeList, page);
        return retMap;
    }     

    private PartyCodeDTO getCodeDTO(PartyCode partyCode) {
        PartyCodeDTO partyCodeDTO = new PartyCodeDTO();
        partyCodeDTO.setId(partyCode.getId());
        partyCodeDTO.setPartyCodeId(partyCode.getId());
        partyCodeDTO.setCodeShortName(partyCode.getCode().getShortName());
        partyCodeDTO.setCodeApplicationLevelIndicator(partyCode.getCode()
                                                               .isApplicationLevelIndicator());
        partyCodeDTO.setCodeCodeTypeName(partyCode.getCode().getCodeType()
                                                  .getName());

        if (partyCode.getCode().getParentCode() != null) {
            partyCodeDTO.setCodeParentCodeShortName(partyCode.getCode()
                                                             .getParentCode()
                                                             .getShortName());
        }

        partyCodeDTO.setPartyId(partyCode.getParty().getId());
        partyCodeDTO.setPartyName(partyCode.getParty().getName());
        partyCodeDTO.setSortOrder(partyCode.getSortOrder());

        if (partyCode.activeFlag == true) {
            partyCodeDTO.setStatus("Active");
        } else {
            partyCodeDTO.setStatus("Inactive");
        }

        return partyCodeDTO;
    }
    
    @RequestMapping(value = "/staffList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map PersonList(HttpServletRequest request, Long clientId, Long partyId,
        int relation) {
        logger.info("Manage Firm Staff List!");

        Map retMap = new HashMap();

        if (clientId != null) {
            partyId = clientId;
        }

        if (partyId != null) {
            Party party = crmManager.getPartyById(partyId);
            Page page = PMUtil.populatePageObject(request);

            List<PartySite> totalPartySites = party.getPartySites();
            int count = totalPartySites.size();
            PMUtil.adjustPagination(page, count);
            page.setCount(count);

            List<PartySite> paginatedList = totalPartySites;

            if (totalPartySites.size() > page.getLimit()) {
                paginatedList = totalPartySites.subList(page.getStart(),
                        page.getLimit());
            }

            List<LocationDTO> personList = new ArrayList();

            for (PartySite partySite : paginatedList) {
                personList.add(getLocationDTO(partySite));
            }
            populateReturnMapWithPageDatails(retMap, personList, page);
        }
        return retMap;
    }

    @RequestMapping(value = "/partnerList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map PartnerList(HttpServletRequest request) {
        logger.info("Main Partner List!");

        Long firmId = Long.valueOf(request.getParameter("firmId"));
        Page page = PMUtil.populatePageObject(request);

        return getPartnerList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), page);
    }

    @RequestMapping(value = "/appadmin/firmList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map FirmList(HttpServletRequest request) {
        logger.info("Main Firm List!");

        HttpSession session = request.getSession(false);
        PartyDTO firm = (PartyDTO) session.getAttribute("firm");
        Long firmId = (firm != null) ? firm.getId() : null;
        Page page = PMUtil.populatePageObject(request);

        return getFirmList(firmId, PartyType.PARTY_TYPE_ORGANIZATION.getId(),
            page);
    }

    @RequestMapping(value = "/mobileadmin/mobilefirmList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getFirmList(HttpServletRequest request) {
        logger.info("Main Firm List!");

        HttpSession session = request.getSession(false);
        PartyDTO firm = (PartyDTO) session.getAttribute("firm");
        Long firmId = (firm != null) ? firm.getId() : null;
        Page page = PMUtil.populatePageObject(request);

        return getFirmList(firmId, PartyType.PARTY_TYPE_ORGANIZATION.getId(),
            page);
    }
    
    public static LocationDTO getLocationDTO(PartySite partySite) {
        LocationDTO dto = new LocationDTO();
        dto.setId(partySite.getId());
        dto.setPartySiteId(partySite.getId());
        dto.setName(partySite.getName());
        dto.setLocationType(partySite.getPartySiteType().getName());
        dto.setPartyName(partySite.getParty().getName());

        CommunicationDTO commDTO = populateCommunciationDTO(partySite);
        dto.setCommunicationDTO(commDTO);

        if (partySite.activeFlag == true) {
            dto.setStatus("Active");
        } else {
            dto.setStatus("Inactive");
        }

        return dto;
    }

    public static CommunicationDTO populateCommunciationDTO(PartySite partySite) {
        CommunicationDTO dto = new CommunicationDTO();
        PointOfContact pointOfContact = partySite.getDefaultPointOfContact();

        if (pointOfContact.getEmailList().size() > 0) {
            EmailCommunication email = pointOfContact.getEmailList().get(0);
            dto.setEmailAddress(email.getContactDetail());
        }

        if (pointOfContact.getFaxList().size() > 0) {
            FaxCommunication fax = pointOfContact.getFaxList().get(0);
            dto.setFax(fax.getContactDetail());
        }

        if (pointOfContact.getWebUrlList().size() > 0) {
            WebCommunication web = pointOfContact.getWebUrlList().get(0);
            dto.setWebUrlList(web.getContactDetail());
        }

        List<PhoneCommunication> phoneList = pointOfContact.getPhoneList();

        if (phoneList.size() > 0) {
            for (PhoneCommunication phoneCommunication : phoneList) {
                if (PMConstants.OFFICE_PHONE.equals(
                            phoneCommunication.getSubType())) {
                    dto.setOfficeNumber(phoneCommunication.getContactDetail());
                } else if (PMConstants.MOBILE_PHONE.equals(
                            phoneCommunication.getSubType())) {
                    dto.setMobileNumber(phoneCommunication.getContactDetail());
                } else if (PMConstants.HOME_PHONE.equals(
                            phoneCommunication.getSubType())) {
                    dto.setHomeNumber(phoneCommunication.getContactDetail());
                } else if (PMConstants.OTHER_PHONE.equals(
                            phoneCommunication.getSubType())) {
                    dto.setOtherNumber(phoneCommunication.getContactDetail());
                }
            }
        }

        return dto;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/allOfficeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getAllOfficeList(HttpServletRequest request, Long firmId, Long partyId) {
        logger.info("All Office List");

        Map<String, List<LocationDTO>> retMap = new HashMap();
        Party party = crmManager.getPartyById(partyId);
        List<PartySite> partySites = party.getPartySites();

        List<LocationDTO> partySiteDTOList = new ArrayList();

        for (PartySite partySite : partySites) {
            partySiteDTOList.add(getLocationDTO(partySite));
        }

        retMap.put("allOfficeList", partySiteDTOList);

        return retMap;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/branchList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map branchList(HttpServletRequest request, Long firmId, Long partyId) {
        logger.info("Bank Branch List!");

        Map<String, List<LocationDTO>> retMap = new HashMap();
        Party party = crmManager.getPartyById(partyId);
        List<PartySite> partySites = party.getPartySites();

        List<LocationDTO> partySiteDTOList = new ArrayList();

        for (PartySite partySite : partySites) {
            if (PartySiteType.BRANCH_OFFICE_PARTY_SITE_TYPE.equals(
                        partySite.getPartySiteType().getId()) ||
                    PartySiteType.AGENCY_PARTY_SITE_TYPE.equals(
                        partySite.getPartySiteType().getId())) {
                partySiteDTOList.add(getLocationDTO(partySite));
            }
        }

        retMap.put("branchList", partySiteDTOList);

        return retMap;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/mainBankList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainBankList(HttpServletRequest request) {
        logger.info("Main Bank List!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Page page = PMUtil.populatePageObject(request);

        return getPartyList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK.getId(), page);
    }

    @RequestMapping(value = "/client/mainClientList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainClientList(HttpServletRequest request) {
        logger.info("Main Client List!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Long clientId = Long.valueOf(request.getParameter("clientId"));
        Page page = PMUtil.populatePageObject(request);

        Map retMap = new HashMap();
        
        if (page != null) {
        	Long count = crmManager.getStaffDTOCountById(clientId,RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PersonDTO> personList = crmManager.getPersonDTOListById(clientId,RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(), page);
    
        populateReturnMapWithPageDatails(retMap, personList, page);

        return retMap;
    }

    @RequestMapping(value = "/mainStaffList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainStaffList(HttpServletRequest request) {
        logger.info("Main Staff List!");

        Long firmId = Long.valueOf(request.getParameter("firmId"));
        Page page = PMUtil.populatePageObject(request);

        return getPersonList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(), page);
    }

    @RequestMapping(value = "/mainPartnerList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainPartnerList(HttpServletRequest request) {
        logger.info("Main Partner List!");

        Long firmId = Long.valueOf(request.getParameter("firmId"));
        Page page = PMUtil.populatePageObject(request);
        
        return getPartnerList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), page);
    }

    @RequestMapping(value = "/appadmin/mainEmployeeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainEmployeeList(HttpServletRequest request) {
    	//Long firmId = PMUtil.getFirmIdFromSession(request);
    	String firmId = request.getParameter("firmId");
    	if(firmId == null || firmId == ""){
    		 firmId = request.getParameter("newfirmId");
    	}
    	Long fId = Long.parseLong(firmId);
    	//Long firmId = Long.valueOf(request.getParameter("newfirmId"));
        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        Page page = PMUtil.populatePageObject(request);
        Map retMap = new HashMap();
        Long count = null;
        
        List<Integer> listOfPersonType = new ArrayList<Integer>();
        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
        
        if (page != null) {
        	count = crmManager.getFirmStaffListCount(fId,listOfPersonType);
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PersonDTO> firmStaffList = crmManager.getFirmStaffList(fId,listOfPersonType, count);
    	for (PersonDTO personDTO :firmStaffList) {
			if(personDTO.getActiveFlag() == true){
				personDTO.setStatus("Active");
			}else{
				personDTO.setStatus("Deactive");
			}
			
		}
        populateReturnMapWithPageDatails(retMap, firmStaffList, page);
        return retMap;
    }

    @RequestMapping(value = "/mobileadmin/mainEmployeeList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map mainMobileEmployeeList(HttpServletRequest request) {
    	//Long firmId = PMUtil.getFirmIdFromSession(request);
    	String firmId = request.getParameter("firmId");
    	if(firmId == null || firmId == ""){
    		 firmId = request.getParameter("newfirmId");
    	}
    	Long fId = Long.parseLong(firmId);
    	//Long firmId = Long.valueOf(request.getParameter("newfirmId"));
        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        Page page = PMUtil.populatePageObject(request);
        Map retMap = new HashMap();
        Long count = null;
        
        List<Integer> listOfPersonType = new ArrayList<Integer>();
        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_FIRM_ADMIN.getId());
        
        if (page != null) {
        	count = crmManager.getFirmStaffListCount(fId,listOfPersonType);
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PersonDTO> firmStaffList = crmManager.getFirmStaffList(fId,listOfPersonType, count);
    	for (PersonDTO personDTO :firmStaffList) {
			if(personDTO.getActiveFlag() == true){
				personDTO.setStatus("Active");
			}else{
				personDTO.setStatus("Deactive");
			}
			
		}
        populateReturnMapWithPageDatails(retMap, firmStaffList, page);
        return retMap;
    }
    
    @RequestMapping(value = "/firmadmin/manageFirmStaffList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map manageFirmStaffList(HttpServletRequest request) {
        logger.info("Main Partner List!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        Page page = PMUtil.populatePageObject(request);

        Map retMap = new HashMap();
        Long count = null;
        List<Integer> listOfPersonType = new ArrayList<Integer>();
        listOfPersonType.add(PersonType.PERSON_TYPE_STAFF.getId());
        listOfPersonType.add(PersonType.PERSON_TYPE_PARTNER.getId());
        listOfPersonType.add(0);
        
        if (page != null) {
        	count = crmManager.getFirmStaffListCount(firmId,listOfPersonType);
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PersonDTO> firmStaffList = crmManager.getFirmStaffList(firmId,listOfPersonType, page);
    	for (PersonDTO personDTO :firmStaffList) {
			if(personDTO.getActiveFlag() == true){
				personDTO.setStatus("Active");
			}else{
				personDTO.setStatus("Inactive");
			}
		}
        populateReturnMapWithPageDatails(retMap, firmStaffList, page);

        return retMap;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/lawFirmList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map lawFirmList(HttpServletRequest request) {
        logger.info("lawFirmList!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Page page = PMUtil.populatePageObject(request);

        return getPartyList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM.getId(), page);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/transferAgentFirmList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map transferAgentFirmList(HttpServletRequest request) {
        logger.info("transferAgentFirmList!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Page page = PMUtil.populatePageObject(request);

        return getPartyList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM.getId(), page);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/insuranceFirmList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map insuranceFirmList(HttpServletRequest request) {
        logger.info("Insurance Firm List!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Page page = PMUtil.populatePageObject(request);

        return getPartyList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM.getId(), page);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/clientAjaxList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getClientAjaxList(HttpServletRequest request) {
        logger.info("Client List!");

        HttpSession session = request.getSession(false);
        PartyDTO firm = (PartyDTO) session.getAttribute("firm");
        Long firmId = (firm != null) ? firm.getId() : null;

        Page page = PMUtil.populatePageObject(request);

        return getPartyList(firmId,
            RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(), page);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/partyList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map partyList(HttpServletRequest request) {
        logger.info("Party List!");

        Long mainPartyId = Long.valueOf(request.getParameter("mainParty"));
        Integer relationshipTypeId = Integer.valueOf(request.getParameter(
                    "relation"));
        Page page = PMUtil.populatePageObject(request);
        Long count = null;
        Map retMap = new HashMap();
                
        if(page != null){
        	count = crmManager.getOfficersAndShareHoldersListCount(mainPartyId,relationshipTypeId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<PartyDTO> partyList =crmManager.getOfficersAndShareHoldersList(mainPartyId,relationshipTypeId, count);
       
        populateReturnMapWithPageDatails(retMap, partyList, page);

        return retMap;
    }

    private Map getPersonList(Long mainPartyId, Integer relationshipTypeId,
        Page page) {
        Map retMap = new HashMap();

        if (page != null) {
            Long count = crmManager.getRelatedPartiesCountById(mainPartyId,
                    relationshipTypeId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }

        List<Party> partyListFromDB = crmManager.getRelatedPartiesById(mainPartyId,
                relationshipTypeId, page);

        List<PersonDTO> personList = new ArrayList();

        for (Party party : partyListFromDB) {
            if (party.activeFlag == true) {
                personList.add(PMUtil.getPartnerDTO(party));
            }
        }
               
        populateReturnMapWithPageDatails(retMap, personList, page);

        return retMap;
    }

    private Map getPartnerList(Long mainPartyId, Integer relationshipTypeId,
        Page page) {
        Map retMap = new HashMap();

        if (page != null) {
            Long count = crmManager.getRelatedPartiesCountById(mainPartyId,
                    relationshipTypeId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }

        List<Party> partyListFromDB = crmManager.getRelatedPartiesById(mainPartyId,
                relationshipTypeId, page);

        List<PersonDTO> personList = new ArrayList();

        for (Party party : partyListFromDB) {
           personList.add(PMUtil.getPartnerDTO(party));
        }

        populateReturnMapWithPageDatails(retMap, personList, page);

        return retMap;
    }

    private Map getPartyList(Long mainPartyId, Integer relationshipTypeId,
        Page page) {
        Map retMap = new HashMap();
        Long count = null;
        
        if(page != null){
        	count = crmManager.getRelatedPartiesCountById(mainPartyId,relationshipTypeId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        
        List<PartyDTO> partyList = crmManager.getPartyDTOListById(mainPartyId,relationshipTypeId,page);

        populateReturnMapWithPageDatails(retMap, partyList, page);

        return retMap;
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


    public PersonDTO getPartnerDTO(Party party) {
        PersonDTO dto = new PersonDTO();
        dto.setPartyId(party.getId());

        if (party.getPerson() != null) {
            Person person = party.getPerson();
            dto.setFirstName(person.getFirstName());
            dto.setLastName(person.getLastName());
            dto.setDateOfBirth(person.getDateOfBirth());

            PersonDetails details = person.getPersonDetails();

            if (details != null) {
                dto.setAnnualCompensation(details.getAnnualCompensation());

                if (details.getCodeByJobTitleCode() != null) {
                    dto.setJobTitle(details.getCodeByJobTitleCode()
                                           .getShortName());
                } else {
                    dto.setJobTitle(details.getJobTitle());
                }

                dto.setComittee(details.getComittee());
                dto.setIsStaff(details.getIsStaff());
                dto.setIsDirector(details.getIsDirector());
            }
        }

        return dto;
    }

    private Map getFirmList(Long mainPartyId, Integer partyTypeId, Page page) {
        Map retMap = new HashMap();
        Long count = null;

        if (page != null) {
            count = crmManager.getFirmsCountById(partyTypeId,OrganizationType.ORGANIZATION_TYPE_FIRM.id);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }

        List<PartyDTO> firmList = crmManager.getFirmsListById(partyTypeId, OrganizationType.ORGANIZATION_TYPE_FIRM.id, count);
        for (PartyDTO partyDTO : firmList) {
			if(partyDTO.getActiveFlag()  == true){
				partyDTO.setStatus("Active");
			}else{
				partyDTO.setStatus("Inactive");
			}
		}

        populateReturnMapWithPageDatails(retMap, firmList, page);

        return retMap;
    }

    // Added by Savitri
    public PartyDTO getFirmDTO(long partyId) {
        PartyDTO dto = new PartyDTO();
        dto.setPartyId(partyId);

        Party party = crmManager.getPartyById((long) partyId);

        if (party.getOrganization() != null) {
            Organization org = party.getOrganization();

            if (OrganizationType.ORGANIZATION_TYPE_FIRM.equals(
                        org.getOrganizationType())) {
                org.setLegalName(party.getName());
                dto.setName(party.getName());

                if (party.getPartySites().size() > 0) {
                    PartySite partySite = party.getPartySites().get(0);
                    CommunicationDTO commDTO = PMUtil.populateCommunciationDTO(partySite);
                    dto.setCommunicationDTO(commDTO);
                }
            }

            if (party.activeFlag == true) {
                dto.setStatus("Active");
            } else {
                dto.setStatus("Inactive");
            }
        }

        return dto;
    }

    @RequestMapping(value = "/appadmin/taskNotificationTemplateList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getTaskNotificationTemplates(HttpServletRequest request, Long clientId,
        Long partyId) {
        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        
        if(page != null){
        	count = crmManager.getTaskNotificationTemplateListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaskNotificationTemplateDTO> taskNotificationTemplateList =crmManager.getTaskNotificationTemplateDTOList(count);
        
        for(TaskNotificationTemplateDTO taskNotificationTemplateDTO:taskNotificationTemplateList ){
        	if(taskNotificationTemplateDTO.getActiveFlag()==true){
        		taskNotificationTemplateDTO .setStatus("Active");
        	}else
        		taskNotificationTemplateDTO.setStatus("Inactive");
        	}
        populateReturnMapWithPageDatails(retMap, taskNotificationTemplateList, page);
        return retMap;
    }

    @RequestMapping(value = "/mobileadmin/mobiletaskNotificationTemplateList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getMobileTaskNotificationTemplates(HttpServletRequest request, Long clientId,
        Long partyId) {
        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        
        if(page != null){
        	count = crmManager.getTaskNotificationTemplateListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaskNotificationTemplateDTO> taskNotificationTemplateList =crmManager.getTaskNotificationTemplateDTOList(count);
        
        for(TaskNotificationTemplateDTO taskNotificationTemplateDTO:taskNotificationTemplateList ){
        	if(taskNotificationTemplateDTO.getActiveFlag()==true){
        		taskNotificationTemplateDTO .setStatus("Active");
        	}else
        		taskNotificationTemplateDTO.setStatus("Inactive");
        	}
        populateReturnMapWithPageDatails(retMap, taskNotificationTemplateList, page);
        return retMap;
    }
    
    private TaskNotificationTemplateDTO getTaskNotificationTemplateDTO(
        TaskNotificationTemplate taskNotificationTemplate) {
        TaskNotificationTemplateDTO dto = new TaskNotificationTemplateDTO();
        dto.setId(taskNotificationTemplate.getId());
        dto.setSubject(taskNotificationTemplate.getSubject());
        dto.setBodyText(taskNotificationTemplate.getBodyText());
        dto.setAdminEmailId(taskNotificationTemplate.getAdminEmailId());

        if (taskNotificationTemplate.activeFlag == null) {
            taskNotificationTemplate.setActiveFlag(false);
        }

        if (taskNotificationTemplate.activeFlag == true) {
            dto.setStatus("Active");
        } else {
            dto.setStatus("Inactive");
        }

        return dto;
    }

    @RequestMapping(value = "/appadmin/taskNotificationRecipientList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getTaskNotificationRecipient(HttpServletRequest request, Long clientId,
        Long partyId) {
        Map retMap = new HashMap();
        Long count = null;
        
        Page page = PMUtil.populatePageObject(request);

     
        if(page != null){
        	count = crmManager.getTaskNotificationRecipientListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaskNotificationRecipientDTO> taskNotificationRecipientList = crmManager.getTaskNotificationRecipientDTOList(count);
        for (TaskNotificationRecipientDTO taskNotificationRecipientDTO : taskNotificationRecipientList) {
        	if(taskNotificationRecipientDTO.getActiveFlag() != null){
			if(taskNotificationRecipientDTO.getActiveFlag() == true){
				taskNotificationRecipientDTO.setStatus("Active");
			}
			}else{
				taskNotificationRecipientDTO.setStatus("Deactive");
			}
		}

        populateReturnMapWithPageDatails(retMap, taskNotificationRecipientList,
            page);

        return retMap;
    }

    @RequestMapping(value = "/mobileadmin/mobiletaskNotificationRecipientList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getMobileTaskNotificationRecipient(HttpServletRequest request, Long clientId,
        Long partyId) {
        Map retMap = new HashMap();
        Long count = null;
        
        Page page = PMUtil.populatePageObject(request);

     
        if(page != null){
        	count = crmManager.getTaskNotificationRecipientListCount();
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaskNotificationRecipientDTO> taskNotificationRecipientList = crmManager.getTaskNotificationRecipientDTOList(count);
        for (TaskNotificationRecipientDTO taskNotificationRecipientDTO : taskNotificationRecipientList) {
        	if(taskNotificationRecipientDTO.getActiveFlag() != null){
			if(taskNotificationRecipientDTO.getActiveFlag() == true){
				taskNotificationRecipientDTO.setStatus("Active");
			}
			}else{
				taskNotificationRecipientDTO.setStatus("Deactive");
			}
		}

        populateReturnMapWithPageDatails(retMap, taskNotificationRecipientList,
            page);

        return retMap;
    }
    
    private TaskNotificationRecipientDTO getTaskNotificationRecipientDTO(
        TaskNotificationRecipient taskNotificationRecipient) {
        TaskNotificationRecipientDTO dto = new TaskNotificationRecipientDTO();
        dto.setId(taskNotificationRecipient.getId());
        dto.setRecipient(taskNotificationRecipient.getRecipient());
        dto.setTypeOfNotificationTemplate(taskNotificationRecipient.getNotificationTemplateId()
                                                                   .getSubject());
        dto.setEmailType(taskNotificationRecipient.getEmailType());

        if (taskNotificationRecipient.activeFlag == null) {
            taskNotificationRecipient.setActiveFlag(false);
        }

        if (taskNotificationRecipient.activeFlag == true) {
            dto.setStatus("Active");
        } else {
            dto.setStatus("Inactive");
        }

        return dto;
    }
    
    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/clientList.do", method = RequestMethod.GET)
    public String clientList(HttpServletRequest request, 
        ModelMap model, Party party) {
        

        Long firmId = PMUtil.getFirmIdFromSession(request);
        
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        
        if (session.getAttribute("inValidClientId")!=null) {
        	 session.setAttribute("clientPartyName", "");
        } 
        return "clientList.tilesView";
    }
    
    @RequestMapping(value = "/home/clientNewList.do", method = RequestMethod.GET)
    public String clientNewList(HttpServletRequest request, 
            ModelMap model) {
    	System.out.println("Hello people");
		return "Jqgrid";
    }
    
    @RequestMapping(value = "/mobileadmin/retriveMobileAdminCode.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getMobileRetriveAdminCode(HttpServletRequest request,Long codeTypeId,Boolean applicationLevelId) {
        Map retMap = new HashMap();
        System.out.println("Retrive Admin Code");
        System.out.println("codetype ID = "+codeTypeId);
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
                            request.getParameter("applicationLevelIndicator");
                            
         /* Integer parentCode = crmManager.getParentCode(codeTypeId); 
          Long newval = parentCode.longValue();*/
//        if(page != null){
        	count = crmManager.getMobileAdminCodeListCount(codeTypeId, applicationLevelId);
//            PMUtil.adjustPagination(page, count.intValue());
//            page.setCount(count.intValue());
//        }
        List<CodeDTO> codeList =crmManager.getMobileAdminCodeDTOList(codeTypeId, applicationLevelId, count);
        for (CodeDTO codeDTO : codeList) {
			if(codeDTO.getActiveFlag() == true){
				codeDTO.setStatus("Active");
			}else{
				codeDTO.setStatus("Inactive");
			}
			if(codeDTO.getApplicationLevelIndicator() == true){
				codeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeDTO.setStrApplicationLevelIndicator("No");
			}
		}
        if(codeList != null){
        System.out.println("list is not empty");
        }
        populateReturnMapWithPageDatails(retMap, codeList, page);

        return retMap;
    }
}
