package com.chiguru.pm.web.util;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.ui.ModelMap;
import org.springframework.util.AutoPopulatingList;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
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
import com.chiguru.pm.crm.dto.CommunicationDTO;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.web.servlet.CacheManagerServlet;


public class PMUtil {
	public PMUtil() {
		
	}
	
	public static void showStatusMessage(HttpServletRequest request, ModelMap model){
		if(request.getParameter("saveSuccess") != null){
			model.addAttribute("statusMessageKey", "save.msg.success");
		}
		else if(request.getParameter("deleteSuccess") != null){
			model.addAttribute("statusMessageKey", "delete.msg.success");
		}
		else if(request.getParameter("undeleteSuccess") != null){
			model.addAttribute("statusMessageKey", "activate.msg.success");
		}
	}

	public static OrganizationType getOrganizationTypeById(Integer id,
			CRMManager crmManager) {
		OrganizationType type = null;
		List<OrganizationType> orgTypeList = crmManager
				.getOrganizationTypeList();
		for (OrganizationType orgType : orgTypeList) {
			if (id.equals(orgType.getId())) {
				type = orgType;
				break;
			}
		}
		return type;
	}

	public static PartyType getPartyTypeById(Integer id, CRMManager crmManager) {
		PartyType type = null;
		List<PartyType> partyTypeList = crmManager.getPartyTypeList();
		for (PartyType partyType : partyTypeList) {
			if (id.equals(partyType.getId())) {
				type = partyType;
				break;
			}
		}
		return type;
	}

	public static RelationshipType getRelationshipTypeById(Integer id,
			CRMManager crmManager) {
		RelationshipType type = null;
		List<RelationshipType> relTypeList = crmManager
				.getPartyRelationshipTypeList();
		for (RelationshipType relType : relTypeList) {
			if (id.equals(relType.getId())) {
				type = relType;
			}
		}
		return type;
	}

	public static PartyType getPartyOrganizationType(CRMManager crmManager) {
		PartyType type = null;
		List<PartyType> partyTypeList = crmManager.getPartyTypeList();
		for (PartyType partyTpe : partyTypeList) {
			if (PartyType.PARTY_TYPE_ORGANIZATION.equals(partyTpe)) {
				type = partyTpe;
			}
		}
		return type;
	}

	public static PartyType getPersonPartyType(CRMManager crmManager) {
		PartyType type = null;
		List<PartyType> partyTypeList = crmManager.getPartyTypeList();
		for (PartyType partyTpe : partyTypeList) {
			if (PartyType.PARTY_TYPE_PERSON.equals(partyTpe)) {
				type = partyTpe;
			}
		}
		return type;
	}

	public static OrganizationType getClientOrganizationType(
			CRMManager crmManager) {
		OrganizationType type = null;
		List<OrganizationType> orgTypeList = crmManager
				.getOrganizationTypeList();
		for (OrganizationType orgType : orgTypeList) {
			if (OrganizationType.ORGANIZATION_TYPE_CLIENT.equals(orgType)) {
				type = orgType;
			}
		}
		return type;
	}

	public static OrganizationType getBankOrganizationType(CRMManager crmManager) {
		OrganizationType type = null;
		List<OrganizationType> orgTypeList = crmManager
				.getOrganizationTypeList();
		for (OrganizationType orgType : orgTypeList) {
			if (OrganizationType.ORGANIZATION_TYPE_BANK.equals(orgType)) {
				type = orgType;
			}
		}
		return type;
	}

	public static RelationshipType getClientRelationshipType(
			CRMManager crmManager) {
		RelationshipType type = null;
		List<RelationshipType> relTypeList = crmManager
				.getPartyRelationshipTypeList();
		for (RelationshipType relType : relTypeList) {
			if (RelationshipType.RELATIONSHIP_TYPE_CLIENT.equals(relType)) {
				type = relType;
			}
		}
		return type;
	}

	public static RelationshipType getBankRelationshipType(CRMManager crmManager) {
		RelationshipType type = null;
		List<RelationshipType> relTypeList = crmManager
				.getPartyRelationshipTypeList();
		for (RelationshipType relType : relTypeList) {
			if (RelationshipType.RELATIONSHIP_TYPE_BANK.equals(relType)) {
				type = relType;
			}
		}
		return type;
	}

	public static RelationshipType getPartnerRelationshipType(
			CRMManager crmManager) {
		RelationshipType type = null;
		List<RelationshipType> relTypeList = crmManager
				.getPartyRelationshipTypeList();
		for (RelationshipType relType : relTypeList) {
			if (RelationshipType.RELATIONSHIP_TYPE_PARTNER.equals(relType)) {
				type = relType;
			}
		}
		return type;
	}

	public static PersonType getPartnerPersonType(CRMManager crmManager) {
		PersonType type = null;
		List<PersonType> personTypeList = crmManager.getPersonTypeList();
		for (PersonType personType : personTypeList) {
			if (PersonType.PERSON_TYPE_PARTNER.equals(personType)) {
				type = personType;
			}
		}
		return type;
	}

	public static PersonType getPersonTypeById(Integer typeId, CRMManager crmManager) {
		PersonType type = null;
		List<PersonType> personTypeList = crmManager.getPersonTypeList();
		for (PersonType personType : personTypeList) {
			if (typeId.equals(personType.getId())) {
				type = personType;
			}
		}
		return type;
	}

	public static Party getOrganizationParty(CRMManager crmManager,
			OrganizationType orgType, String name, String userId) {
		Party party = new Party(getPartyOrganizationType(crmManager), name,
				userId);
		return party;
	}

	public static Party getPersonParty(CRMManager crmManager, String name,
			String userId) {
		Party party = new Party(getPersonPartyType(crmManager), name, userId);
		return party;
	}

	public static Page populatePageObject(HttpServletRequest request) {
		Page pageObject = null;
		if (request.getParameter("page") != null) {
			Long firmId = getFirmIdFromSession(request);
			Integer page = Integer.parseInt(request.getParameter("page"));
			Integer limit = Integer.parseInt(request.getParameter("rows"));
			String sortName = request.getParameter("sidx");
			String sortType = request.getParameter("sord");
			String filters = request.getParameter("filters");
			pageObject = new Page(firmId, page, limit, sortName, sortType, filters);
		}
		return pageObject;
	}
	
	public static Long getFirmIdFromSession(HttpServletRequest request){
		PartyDTO firm = getFirmFromSession(request);
		Long firmId = firm !=null ? firm.getId() : null;
		return firmId;
	}
	
	public static PartyDTO getFirmFromSession(HttpServletRequest request){
		HttpSession session = request.getSession(false);
		PartyDTO firm = (PartyDTO) session.getAttribute("firm");
		return firm;
	}
	public static void adjustPagination(Page page, int count) {
		// set total pages to 0 by default
		page.setCount(count);
		int totalPages = 0;
		if (count > 0) {
			totalPages = (int) Math.ceil(count / page.getLimit()) + 1;
			page.setTotalPages(totalPages);

			if (page.getCurrentPage() > totalPages) {
				page.setCurrentPage(totalPages);
			}
			int start = (page.getLimit() * page.getCurrentPage())
					- page.getLimit();
			page.setStart(start);

			if (start + page.getLimit() > count) {
				page.setLimit(count - start);
			}
		}

	}

	public static List<KeyValue> getChildCodeSet(Long parentCodeId,
			CodesManager codesManager) {
		List<KeyValue> keyValueList = new ArrayList();

		for (Code child : getChildrenCodeSet(parentCodeId, codesManager)) {
			KeyValue keyValue = new KeyValue();
			keyValue.setKey(child.getId().toString());
			keyValue.setValue(child.getShortName());
			keyValueList.add(keyValue);
		}

		return keyValueList;
	}
	
	public static Set<Code> getChildrenCodeSet(Long parentCodeId,
			CodesManager codesManager) {
		Code parentCode = codesManager.getCodeById(parentCodeId);
		Set<Code> childrenCodeSet = parentCode.getCodes();
		return childrenCodeSet;
	}
	
	public static List<KeyValue> getClientStafCodeSet(Long clientId,CRMManager crmManager) {
		List<KeyValue> keyValueList = new ArrayList();
		
		List<Party> clientStafCodeList = getClientStafCodeList(clientId, crmManager);
		System.out.println(clientStafCodeList.size());
		
		for (Party child : getClientStafCodeList(clientId, crmManager)) {
			KeyValue keyValue = new KeyValue();
			keyValue.setKey(child.getId().toString());
			keyValue.setValue(child.getName());
			keyValueList.add(keyValue);
		}
		return keyValueList;
	}
	
	public static List<Party> getClientStafCodeList(Long clientId,CRMManager crmManager) {
		List<Party> clientStafCodeList = crmManager.getRelatedPartiesById(clientId,RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
		return clientStafCodeList;
	}
	
	public static List<KeyValue> getParentCodeList(Long codeTypeId,
			CodesManager codesManager) {
		List<KeyValue> keyValueList = new ArrayList<KeyValue>();

		List<Code> listOfParentCode = getParentCodeSet(codeTypeId, codesManager);
		
		if(listOfParentCode != null){
			for (Code child : listOfParentCode) {
				KeyValue keyValue = new KeyValue();
				keyValue.setKey(child.getId().toString());
				keyValue.setValue(child.getShortName());
				keyValueList.add(keyValue);
			}
		}
		return keyValueList;
	}
	
	private static List<Code> getParentCodeSet(Long codeTypeId,
			CodesManager codesManager) {
		Long parentCodeTypeId = codesManager.getParentCodeTypeIdById(codeTypeId);
		List<Code> listOfParentCode = null;
		
		if(parentCodeTypeId != null){
			listOfParentCode = codesManager.getRelatedCodeByCodeTypeId(parentCodeTypeId);
		}
		return listOfParentCode;
	}
	
	public static List<KeyValue> getParentCodeListWhereAppFalse(
			Long codeTypeId, CodesManager codesManager) {
		List<KeyValue> keyValueList = new ArrayList<KeyValue>();

		List<Code> listOfParentCode = getParentCodeSetWhereAppFalse(codeTypeId, codesManager);
		
		if(listOfParentCode != null){
			for (Code child : listOfParentCode) {
				KeyValue keyValue = new KeyValue();
				keyValue.setKey(child.getId().toString());
				keyValue.setValue(child.getShortName());
				keyValueList.add(keyValue);
			}
		}
		return keyValueList;
	}
	
	private static List<Code> getParentCodeSetWhereAppFalse(Long codeTypeId,
			CodesManager codesManager) {
		Long parentCodeTypeId = codesManager.getParentCodeTypeIdById(codeTypeId);
		List<Code> listOfParentCode = null;
		
		if(parentCodeTypeId != null){
			listOfParentCode = codesManager.getRelatedCodeByCodeTypeIdWhereAppFalse(parentCodeTypeId);
		}
		return listOfParentCode;
	}

	public static PartyDTO getPartyDTO(Party party) {
		PartyDTO dto = new PartyDTO();
		dto.setId(party.getId());
		dto.setPartyId(party.getId());
		dto.setName(party.getName());
		dto.setViewDetails("View Tax Info Details");
		if (party.getOrganization() != null) {
			Organization org = party.getOrganization();
			dto.setYearEndDate(org.getYearEndDate());
			dto.setBusinessNumber(org.getBusinessIdentificationNumber());
			if(org.getFormOfBusiness() != null){
			//dto.setFormOfBusiness(org.getFormOfBusiness().getShortName());
			}
			if(org.getInChargePerson() != null){
				//TODO need to fix this
			dto.setInChargePerson(org.getInChargePerson().toString());
			}
			if(org.getIndustryType() != null){
			//dto.setIndustryType(org.getIndustryType()
			//		.getShortName());
			}
		}else if(party.getPerson() != null){
			Person person = party.getPerson();
			PersonDetails details = person.getPersonDetails();
			
			dto.setDateOfBirth(person.getDateOfBirth());
			
			if(details != null){
				dto.setCompensation(details.getAnnualCompensation());
				dto.setNoOfSharesOwned(details.getNoOfSharesOwned());
				if(details.getCodeTypeOfShare() != null){
					Code codeTypeOfShare = details.getCodeTypeOfShare();
					dto.setTypeOfShare(codeTypeOfShare.getShortName());
				}
				if(details.getCodeByJobTitleCode() != null){
					dto.setTitle(details.getCodeByJobTitleCode().getShortName());
			}
			}
		}
		
		//Below code is related for ClientList-----------------
		if(party.getPartySites().size()>0){
			List<PartySite> partySiteList = party.getPartySites();
			for (PartySite partySite : partySiteList) {
				PartySiteType partySiteType = partySite.getPartySiteType();
				if(PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE.equals(partySiteType.getId())){	
					CommunicationDTO commDTO = populateCommunciationDTO(partySite);
					dto.setCommunicationDTO(commDTO);
				}
			}
		}
		//----------------------------------------------------
		
		if(party.activeFlag == true){
			dto.setStatus("Active");
		}else{
			dto.setStatus("Inactive");
		}
		return dto;
	}
	
	public static PersonDTO getPersonDTO(Party party) {
		PersonDTO dto = new PersonDTO();
		dto.setPartyId(party.getId());
		if(party.getPerson() != null){
			Person person = party.getPerson();
			dto.setFirstName(person.getFirstName());
			dto.setLastName(person.getLastName());
			dto.setDateOfBirth(person.getDateOfBirth());
			
			PersonDetails details = person.getPersonDetails();
			if(details != null){
				dto.setAnnualCompensation(details.getAnnualCompensation());
				if(details.getCodeByJobTitleCode() != null){
					dto.setJobTitle(details.getCodeByJobTitleCode().getShortName());
			}
				dto.setIsStaff(details.getIsStaff());
				dto.setIsDirector(details.getIsDirector());
			}
		}

		return dto;

	}
	
	// Added by Savitri
	public static PersonDTO getPartnerDTO(Party party) {
		PersonDTO dto = new PersonDTO();
		dto.setPartyId(party.getId());
		dto.setName(party.getName());
		
		if(party.getPerson() != null){
			Person person = party.getPerson();
			PersonDetails details = person.getPersonDetails();
			dto.setFirstName(person.getFirstName());
			dto.setLastName(person.getLastName());
			dto.setDateOfBirth(person.getDateOfBirth());
			dto.setDateOfBirth(person.getDateOfBirth());
			
			PersonType personType = person.getPersonType();
			dto.setPersonType(personType.getType());
			
			if(party.getPartySites().size()>0){
			PartySite partySite=party.getPartySites().get(0);
			CommunicationDTO commDTO = populateCommunciationDTO (partySite );
			dto.setCommunicationDTO(commDTO);
			
			}
			if(details != null){
				dto.setAnnualCompensation(details.getAnnualCompensation());
				if(details.getCodeByJobTitleCode() != null){
					dto.setJobTitle(details.getCodeByJobTitleCode().getShortName());
			}
			}
		}
		
		if(party.activeFlag == true){
			dto.setStatus("Active");
		}else{
			dto.setStatus("Inactive");
		}
		

		return dto;

	}
	
	//sagar
	public static TaxDTO getTaxDTO(PracticeType practiceType) {
		TaxDTO taxDTO = new TaxDTO();
		
//		taxDTO.setPartyId(practiceType.getId());
		taxDTO.setName(practiceType.getName());
		taxDTO.setDescription(practiceType.getDescription());
		
//		taxDTO.setId(practiceType.getId());
//		taxDTO.setTaxId(practiceType.get);
		
		return taxDTO;
	}

	public static TaxDTO getTaxDTO(FirmPracticeType firmPracticeType) {
		TaxDTO taxDTO = new TaxDTO();
		
//		taxDTO.setPartyId(firmPracticeType.getId());
		taxDTO.setName(firmPracticeType.getTaxApplicationPracticeType().getName());
		taxDTO.setDescription(firmPracticeType.getTaxApplicationPracticeType().getDescription());
		
		taxDTO.setFirmPracticeID(firmPracticeType.getId());
		taxDTO.setTaxId(firmPracticeType.getTaxApplicationPracticeType().getId());
		
		if(firmPracticeType.activeFlag == true){
			taxDTO.setStatus("Active");
		}else{
			taxDTO.setStatus("Inactive");
		}
		
		return taxDTO;
	}
	public static OrganizationType getFirmOrganizationType(
			CRMManager crmManager) {
		OrganizationType type = null;
		List<OrganizationType> orgTypeList = crmManager
				.getOrganizationTypeList();
		for (OrganizationType orgType : orgTypeList) {
			if (OrganizationType.ORGANIZATION_TYPE_FIRM.equals(orgType)) {
				type = orgType;
			}
		}
		return type;
	}
	
	// Added by Savitri
	public static PartyDTO getFirmDTO(Party party) {
		PartyDTO dto = new PartyDTO();
		dto.setId(party.getId());
		dto.setPartyId(party.getId());
		dto.setName(party.getName());
		if (party.getOrganization() != null) {
			Organization org = party.getOrganization();
			org.setLegalName(party.getName());
			/*if(party.getPartySites().size()>0){
				PartySite partySite=party.getPartySites().get(0);
				CommunicationDTO commDTO = populateCommunciationDTO (partySite );
				dto.setCommunicationDTO(commDTO);
			}*/
		}
		return dto;
	}

	public static CommunicationDTO populateCommunciationDTO(PartySite partySite){
		CommunicationDTO dto = new CommunicationDTO();
		PointOfContact pointOfContact = partySite.getDefaultPointOfContact();
		if(pointOfContact.getEmailList().size() > 0){
			EmailCommunication email = pointOfContact.getEmailList().get(0);
			dto.setEmailAddress(email.getContactDetail());
		}
		if(pointOfContact.getFaxList().size() > 0){
			FaxCommunication fax = pointOfContact.getFaxList().get(0);
			dto.setFax(fax.getContactDetail());
		}
		if(pointOfContact.getWebUrlList().size() > 0){
			WebCommunication web = pointOfContact.getWebUrlList().get(0);
			dto.setWebUrlList(web.getContactDetail());
		}
		List<PhoneCommunication> phoneList = pointOfContact.getPhoneList();
		if(phoneList.size() > 0){
			for (PhoneCommunication phoneCommunication : phoneList) {
				if(PMConstants.OFFICE_PHONE.equals(phoneCommunication.getSubType())){
					dto.setOfficeNumber(phoneCommunication.getContactDetail());
				}else if(PMConstants.MOBILE_PHONE.equals(phoneCommunication.getSubType())){
					dto.setMobileNumber(phoneCommunication.getContactDetail());
				}else if(PMConstants.HOME_PHONE.equals(phoneCommunication.getSubType())){
					dto.setHomeNumber(phoneCommunication.getContactDetail());
				}else if(PMConstants.OTHER_PHONE.equals(phoneCommunication.getSubType())){
					dto.setOtherNumber(phoneCommunication.getContactDetail());
				}	
			}
		}
	return dto;
		
	}
	public static ClientPracticeInfoDTO getClientPracticeInfoDTO(
			ClientPracticeInfo clientPracticeInfo) {
		ClientPracticeInfoDTO clientPracticeInfoDTO = new ClientPracticeInfoDTO();
		clientPracticeInfoDTO.setClientPracticeInfoId(clientPracticeInfo.getId());
		clientPracticeInfoDTO.setClientName(clientPracticeInfo.getClient().getName());
		clientPracticeInfoDTO.setJurisdictionName(clientPracticeInfo.getJurisdiction().getCountry()+":" +
				""+clientPracticeInfo.getJurisdiction().getState());
		clientPracticeInfoDTO.setStaffInChargeName(clientPracticeInfo.getStaffInCharge().getParty().getName());
		if(clientPracticeInfo.getClientStaffInCharge() != null){
			clientPracticeInfoDTO.setClientStaffInChargeName(clientPracticeInfo.getClientStaffInCharge().getParty().getName());
		}
		clientPracticeInfoDTO.setPracticeName(clientPracticeInfo.getPracticeName());
		clientPracticeInfoDTO.setTaskCreator(clientPracticeInfo.getLastUpdateUserId());
		clientPracticeInfoDTO.setTaskCreatedDate(clientPracticeInfo.getLastUpdateDate());
		clientPracticeInfoDTO.setTaxReturn(clientPracticeInfo.getFirmPracticeType().getTaxApplicationPracticeType().getName());
		if(clientPracticeInfo.activeFlag == true){
			clientPracticeInfoDTO.setStatus("Active");
		}else{
			clientPracticeInfoDTO.setStatus("Inactive");
		}
		return clientPracticeInfoDTO;
	}

	public static PersonDTO getPartyRelationshipDTO(
			PartyRelationship partyRelationship) {
		
		PersonDTO dto = new PersonDTO();
		dto.setRelationshipType(partyRelationship.getRelationshipType().getType());
		
		Party party = partyRelationship.getPartyBySubject();
		dto.setPartyId(party.getId());
		if(party.getName() != null){
			dto.setName(party.getName());
		}
		
		if(party.activeFlag == true){
			dto.setStatus("Active");
		}else{
			dto.setStatus("Inactive");
		}
		
		if(party.getPartySites().size()>0){
			PartySite partySite=party.getPartySites().get(0);
			CommunicationDTO commDTO = populateCommunciationDTO (partySite );
			dto.setCommunicationDTO(commDTO);
			
		}
		
		if(party.getPerson() != null){
			Person person = party.getPerson();
			if(person.getPersonType() != null){
				dto.setRoleType(person.getPersonType().getType());
			}
			if(party.getPartySites().size()>0){
				PartySite partySite=party.getPartySites().get(0);
				CommunicationDTO commDTO = populateCommunciationDTO (partySite );
				dto.setCommunicationDTO(commDTO);
				
			}
			PersonDetails details = person.getPersonDetails();
			if(details != null){
				if(details.getCodeByJobTitleCode() != null){
					dto.setJobTitle(details.getCodeByJobTitleCode().getShortName());
				}
			}
		}
		
		/*if(party.getPartySites().size()>0){
			PartySite partySite=party.getPartySites().get(0);
			List<PartySiteCommunication> commList=partySite.getPartySiteCommunications();
			
			for(PartySiteCommunication list:commList){
				if(("Email").equals(list.getCommunicationType().getName())){
					dto.setEmailAddress(list.getContactDetail());
				}							
			}
		}*/
		return dto;
	}
	
	public static List autoPopulateList(Class cls, List listToBePopulated){
		List autoPopulateList = new AutoPopulatingList(cls);
		autoPopulateList.addAll(listToBePopulated);
		return autoPopulateList;
	}
	
	public static List<Party> getRelatedParties(CRMManager crmManager, Long partyId) {
		List<RelationshipType> listOfRelationshipType = new ArrayList<RelationshipType>();
		listOfRelationshipType.add(RelationshipType.RELATIONSHIP_TYPE_STAFF);
		//listOfRelationshipType.add(RelationshipType.RELATIONSHIP_TYPE_PARTNER);
		
		return crmManager.getRelatedPartiesById(partyId,listOfRelationshipType);
	}
	
	/*public boolean isTheHttpFieldBlank(HttpServletRequest httpReq, String field){
		String fieldValue = httpReq.getParameter("field");
		return isTheStringBlank(fieldValue);
	}
	public boolean isTheStringBlank(String value){
		return (value != null && !value.trim().isEmpty());
	}*/
	
	public static List getCachedDropdownCodesList(Long firmId, Long codeType, CodesManager codesManager, Long parentCodeTypeId){
		String type = "code";
		
		Long val = (long) 1;
		if(codeType == val){
			List cList = codesManager.getCodeDropdownListForCodeType(codeType);
			return cList;
		}
		else{
			List cachedCodeList = CacheManagerServlet.getPartyLevelCache(firmId, codeType.toString(), type, parentCodeTypeId);
	 	if(cachedCodeList.isEmpty()){
	 		List cashesCodes = codesManager.getCodeDropdownListForCodeTypeAndParty(codeType, firmId, parentCodeTypeId);
	 		cachedCodeList.addAll(cashesCodes);
	 	}
	 	return cachedCodeList;
		}
		
	}
	
	public static List getCachedDropdownPartyList(Long firmId, Integer relationshipId,  CRMManager crmManager){
		String type = "party";
		List cachedCodeList = CacheManagerServlet.getPartyLevelCache(firmId, relationshipId.toString(), type, null);
		 	if(cachedCodeList.isEmpty()){
		 		List cashesCodes = crmManager.getPartyDropdownListForRelationship(firmId, relationshipId);
		 		cachedCodeList.addAll(cashesCodes);
		 	}
		 	return cachedCodeList;
		}

	public static List getCachedDropdownEmailList(CRMManager crmManager, List listOfPersonType, Long firmId) {
		String type = "email";
		List cachedEmailList =  new ArrayList();
		//List cachedEmailList = CacheManagerServlet.getPartyLevelCache(firmId, listOfPersonType.toString(), type, null);
		if(cachedEmailList.isEmpty()){
			List cashesEamils = crmManager.getEmailsList(listOfPersonType);
			cachedEmailList.addAll(cashesEamils);
		}
		return cachedEmailList;
	}

	public static List<KeyValue> getFirmNameList(CRMManager crmManager) {
		//bug no 511
		return crmManager.getFirmNameList();
	}

	

	
/*	public static String encrypt(String plaintext) {
		// this is simple way of encrypting password using MD5, without salting
	    PasswordEncoder encoder = new Md5PasswordEncoder(); 
	    String hash = encoder.encodePassword(plaintext, null);
	    
	    return hash; //step 6
	  }*/
	
}
