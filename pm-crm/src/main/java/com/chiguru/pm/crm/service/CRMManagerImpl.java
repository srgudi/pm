package com.chiguru.pm.crm.service;

import com.chiguru.pm.crm.dao.CRMDao;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.dto.AddressDTO;
import com.chiguru.pm.crm.dto.ClientListDTO;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.CredentialsDTO;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PartyRelationShipDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TimezoneDTO;
import com.chiguru.pm.crm.util.CRMUtil;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.security.PMUserService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service
public class CRMManagerImpl implements CRMManager {
    @Autowired
    CRMDao crmDao;
    
    @Autowired
    PMUserService userService;
    
   /* @Autowired
    private DJMapper dJMapper;*/

    @Override
    public Party getPartyById(Long partyId) {
        return crmDao.getPartyById(partyId);
    }
    
    @Override
	public List<AddressDTO> getReportAddress(Long firmid) {
		return crmDao.getReportAddress(firmid);
	}
    @Override
    public List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId) {
        // TODO Auto-generated method stub
        return crmDao.getRelatedPartiesById(objectPartyId, relationshipTypeId);
    }

    public Long getRelatedPartiesCountById(Long objectPartyId,
        Integer relationshipTypeId) {
        return crmDao.getRelatedPartiesCountById(objectPartyId,
            relationshipTypeId);
    }

    public List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId, Page page) {
        if ((page != null) && (page.getCount() > page.getLimit())) {
            return crmDao.getRelatedPartiesById(objectPartyId,
                relationshipTypeId, page.getSortName(), page.getSortType(),
                page.getStart(), page.getLimit());
        } else {
            return crmDao.getRelatedPartiesById(objectPartyId,
                relationshipTypeId);
        }
    }

    @Override
    public List<Party> getRelatedPartiesById(Long partyId,
        List<RelationshipType> listOfRelationshipType) {
        return crmDao.getRelatedPartiesById(partyId, listOfRelationshipType);
    }

    @Override
    @Transactional
    public PartyRelationship createPartyAndRelationship(Party mainParty,
        Party relatedParty, String role, RelationshipType relationshipType, String encryptedPassword, List<Code> listOfAdminCodes, Long clientId) {
    	
    	boolean newUser = (relatedParty.getId() == null) ? true : false;
    	PartyRelationship rel = crmDao.createPartyAndRelationship(mainParty, relatedParty,null, relationshipType);
    	
    	if(newUser == true && !encryptedPassword.equalsIgnoreCase("")){
           String[] roles = { role };
           PMUser user = PMUser.defaultInstance(relatedParty.getUserName(),encryptedPassword, true, rel.getId(), roles);
           user.setCreatedBy("system");
           userService.createNewUser(user, roles);
    	}
    	
    	if(newUser == true && (listOfAdminCodes != null) && (relatedParty.getId() != null)){
    		setPartyCode(listOfAdminCodes, relatedParty);
    	}
        return rel;
    }

    //For brand new Firm, This method is used to create new data PartyCode by taking reference from Code tables. 
    private void setPartyCode(List<Code> listOfAdminCodes, Party relatedParty) {
    	// Using List of Admin level Code, i must get List of List of firm level PartyCode.
    	List<PartyCode> listOfPartyCode = new ArrayList<PartyCode>();
    	for (Code code : listOfAdminCodes) {
    			Code newCode = new Code();
    			newCode.setShortName(code.getShortName());
    			newCode.setLongDescription(code.getLongDescription());
    			newCode.setCodeType(code.getCodeType());
    			newCode.setSortOrder(code.getSortOrder());
    			newCode.setApplicationLevelIndicator(false);
    			newCode.setParentCode(code.getParentCode());
    			
    			PartyCode partyCode = new PartyCode();
    			partyCode.setParty(relatedParty);
    			partyCode.setCode(newCode);
    			listOfPartyCode.add(partyCode);
		}
    	crmDao.createPartyCodeForNewFirm(listOfPartyCode); //by this, we will get all new Id values.
    	
    	//now, we need to take care of some Code which has Parent Code. Like, relation between COuntry and State.
    	List<PartyCode> listOfParentCode = new ArrayList<PartyCode>();
    	listOfParentCode = listOfPartyCode; // I am coping ParentCode to another list for future use.
    	
    	//make sure that we get correct relationship between Child and Parent code.
    	for (PartyCode partyCode : listOfPartyCode) {
			if(partyCode.getCode().getParentCode() != null){
				String oldParentCodeName = partyCode.getCode().getParentCode().getShortName();
				for (PartyCode parentCode : listOfParentCode) {
					if(parentCode.getCode().getShortName().equals(oldParentCodeName)){
						partyCode.getCode().setParentCode(parentCode.getCode());
						break;
					}
				}
			} 
		}
	}

    @Override
    @Transactional
    public void createOrganization(Organization org) {
        crmDao.createOrganization(org);
    }

    @Override
    @Transactional
    public void createParty(Party party) {
        crmDao.createParty(party);
    }

    public List<PartyType> getPartyTypeList() {
        return crmDao.getPartyTypeList();
    }

    public List<OrganizationType> getOrganizationTypeList() {
        return crmDao.getOrganizationTypeList();
    }

    public List<PersonType> getPersonTypeList() {
        return crmDao.getPersonTypeList();
    }

    public List<RelationshipType> getPartyRelationshipTypeList() {
        return crmDao.getRelationshipTypeList();
    }

    public PartyAccount getAccountById(Long accountId) {
        return crmDao.getAccountById(accountId);
    }

   /* public List<PartyAccount> getAccountById(List delList) {
        return crmDao.getAccountById(delList);
    }*/
    
   /* @Transactional*/
    public void savePartyAccount(PartyAccount account,
        List<PhoneCommunication> phonesToBeRemoved) {
        crmDao.savePartyAccount(account, phonesToBeRemoved);
    }
   /* @Transactional
    public void savePartyAccount(List<PartyAccount> account,
        List<PhoneCommunication> phonesToBeRemoved) {
        crmDao.savePartyAccount(account, phonesToBeRemoved);
    }*/
    
    public List<CommunicationType> getCommunicationTypes(boolean phoneIndicator) {
        return crmDao.getCommunicationTypes(phoneIndicator);
    }

    public CommunicationType getCommunicationTypeById(Integer id) {
        return crmDao.getCommunicationTypeById(id);
    }

    public PartySite getPartySiteById(Long id) {
        return crmDao.getPartySiteById(id);
    }

    public PartySiteType getPartySiteTypeById(Integer id) {
        return crmDao.getPartySiteTypeById(id);
    }

   public PartyAccount getAccountByIdAndAccountType(Long accountId,
        Long accountCategoryId) {
        return crmDao.getAccountByIdAndAccountType(accountId, accountCategoryId);
    }

    
    public RelationshipType getRelationshipTypeById(Integer id) {
        return crmDao.getRelationshipTypeById(id);
    }

    public Person getPersonById(Long partyId) {
        return crmDao.getPersonById(partyId);
    }

    public Organization getOrganizationById(Long partyId) {
        return crmDao.getOrganizationById(partyId);
    }

    @Transactional
    public void deletePhoneCommunication(
        List<PhoneCommunication> phonesToBeRemoved) {
        crmDao.deletePhoneCommunication(phonesToBeRemoved);
    }

    public List<PartyAccount> getAccountListByPartyAndCategory(Long partyId,
        Long accountCategory, String sortName, String sortType, Integer start,
        Integer maxResults, int totalCount) {
        //		if(totalCount > 0){
        return crmDao.getAccountListByPartyAndCategory(partyId,
            accountCategory, sortName, sortType, start, maxResults);

        //		}else {
        //			return new ArrayList<PartyAccount>();
        //		}
    }

    public Long findAccountsCountById(Long partyId, Long accountCategory) {
        return crmDao.findAccountsCountById(partyId, accountCategory);
    }

    @Override
    public List<PartySiteType> getPartySiteTypes() {
        return crmDao.getPartySiteTypes();
    }

   /* @Override
    public List<PartyAccountDTO> findAccountsById(Long newId){
    	return crmDao.findAccountsById(newId);
    }*/
    
   /* @Transactional
    public void deleteBank(List<PartyAccountDTO> partyAccountDTO){
    	crmDao.deleteBank(partyAccountDTO);
    }*/
    
    @Transactional
    public void savePartySite(PartySite partySite) {
        crmDao.savePartySite(partySite);
    }

    public Jurisdiction getJurisdictionById(Long id) {
        return crmDao.getJurisdictionById(id);
    }

    public List<Jurisdiction> getJurisdictionList() {
        return crmDao.getJurisdictionList();
    }

    @Override
    public Long getPartiesCountByTypeId(Integer partyTypeId) {
        // TODO Auto-generated method stub
        return crmDao.getPartiesCountByTypeId(partyTypeId);
    }

    public List<Long> getPartiesByTypeId(Integer partyTypeId, Page page) {
        if ((page != null) && (page.getCount() > page.getLimit())) {
            return crmDao.getPartiesByTypeId(partyTypeId, page.getSortName(),
                page.getSortType(), page.getStart(), page.getLimit());
        } else {
            return crmDao.getPartiesByTypeId(partyTypeId);
        }
    }

    //sagar
    @Override
    @Transactional
    public void saveJurisdiction(Jurisdiction manageJurisdiction) {
        crmDao.saveJurisdiction(manageJurisdiction);
    }

    @Override
    public List<Timezone> getTimezoneList() {
        return crmDao.getTimezoneList();
    }

    @Override
    public Timezone getTimezoneById(Long id) {
        return crmDao.getTimezoneById(id);
    }

    @Override
    @Transactional
    public void saveTimezone(Timezone manageTimezone) {
        crmDao.saveTimezone(manageTimezone);
    }

    @Override
    public CodeType getCodeTypeById(Long id) {
        return crmDao.getCodeTypeById(id);
    }

    @Override
    public List<CodeType> getCodeTypeList() {
        return crmDao.getCodeTypeList();
    }

    @Override
    @Transactional
    public void saveCodeType(CodeType manageCodeType) {
        crmDao.saveCodeType(manageCodeType);
    }

    @Override
    public List<Code> getCodeList() {
        return crmDao.getCodeList();
    }

    @Override
    public Code getCodeById(Long id) {
        return crmDao.getCodeById(id);
    }

    @Override
    @Transactional
    public void saveCode(Code manageCode) {
        crmDao.saveCode(manageCode);
    }

    @Override
    public PartyCode getPartyCodeById(Long id) {
        return crmDao.getPartyCodeById(id);
    }

    @Override
    public List<PartyCode> getPartyCodeList(Long firmId) {
        return crmDao.getPartyCodeList(firmId);
    }

    @Override
    @Transactional
    public void savePartyCode(PartyCode partyCode) {
        crmDao.savePartyCode(partyCode);
    }

    @Override
    public Long getMaxCodeIdValue() {
        return crmDao.getMaxCodeIdValue();
    }

    @Override
    public List<CodeType> getCodeTypeListWhereApplcationLevelIsFalse() {
        return crmDao.getCodeTypeListWhereApplcationLevelIsFalse();
    }

    @Override
    @Transactional
    public void saveParty(Party party) {
        crmDao.saveParty(party);
    }

    @Override
    public PartyType getPartyTypeById(Integer id) {
        return crmDao.getPartyTypeById(id);
    }

    @Override
    public List<PartyRelationship> getListOfRelatedParties(Long firmId) {
        return crmDao.getListOfRelatedParties(firmId);
    }

    @Override
    public Long getMaxJurisdictionIdValue() {
        return crmDao.getMaxJurisdictionIdValue();
    }

    @Transactional
    @Override
    public PartyRelationship getPartyRelationshipById(Long id) {
        return crmDao.getPartyRelationshipById(id);
    }

    @Transactional
    @Override
    public PartyRelationShipDTO getFirmPartyDTOForRelationshipById(Long id) {
        PartyRelationship rel = crmDao.getPartyRelationshipById(id);
        PartyDTO firmDTO = CRMUtil.getFirmDTO(rel.getPartyByObject());
        PartyDTO userProfileDTO = CRMUtil.getFirmDTO(rel.getPartyBySubject());
        PartyRelationShipDTO relDTO = new PartyRelationShipDTO();
        relDTO.setPartyByObject(firmDTO);
        relDTO.setPartyBySubject(userProfileDTO);

        return relDTO;
    }

    @Override
    public PartyAccount getPartyAccount(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public PointOfContact getPointOfContactById(Long id) {
        return crmDao.getPointOfContactById(id);
    }

    @Override
    public Communication getCommunicationById(Long id) {
        return crmDao.getCommunicationById(id);
    }

    @Transactional
	@Override
	public List<Party> getPartyRelationshipbySubId(Long id) {
		return crmDao.getPartyRelationshipbySubId(id);
	}

    @Transactional
	@Override
	public List<Party> getPartybyLocationIdFromPartySite(Long id,Long clientId) {		
		return crmDao.getPartybyLocationIdFromPartySite(id, clientId);
	}
    
    @Transactional
	@Override
	public List<Party> getPartyRelationshipByBothId(Long shareId,Long clientId,Integer relationshipTypeId) {
		return crmDao.getPartyRelationshipByBothId(shareId,clientId,relationshipTypeId);
	}
    
    @Transactional
	@Override
	public List<Party> getPartyAccountByBothId(Long bankId,Long clientId,Long accountCategoryId) {
		return crmDao.getPartyAccountByBothId(bankId, clientId, accountCategoryId);
	}
    
    @Transactional
	@Override
	public List<Long> getPartyByPartyNPartyTypeId(Long partyId,Integer partyTypeId) {
		return crmDao.getPartyByPartyNPartyTypeId(partyId, partyTypeId);
	}

    @Transactional
	@Override
	public List<PartyCode> getPartyCodeByCodeId(Long id) {
		// TODO Auto-generated method stub
		return crmDao.getPartyCodeByCodeId(id);
	}

	@Override
	public List<Organization> getFirmList() {		
		return crmDao.getFirmList();
	}

	@Override
	public List<PartyDTO> getPartyDTOListById(Long objectPartyId,
	        Integer relationshipTypeId, Page page) {
		 return crmDao.getPartyDTOListById(objectPartyId,
	                relationshipTypeId, page.getCount(), page.getLimit(), page.getStart());
	}

	@Override
	public List<PersonDTO> getPersonDTOListById(Long clientId,
			Integer relationshipTypeId, Page page) {
		return crmDao.getPersonDTOListById(clientId,relationshipTypeId, page.getCount());
	}

	@Override
	public Long getStaffDTOCountById(Long clientId, Integer relationshipTypeId) {
		return crmDao.getStaffDTOCountById(clientId,relationshipTypeId);
	}

	@Override
	public List<PartyAccountDTO> getPartyAccountDTOListById(Long clientId,
			Long accountCategory, Page page) {
		return crmDao.getPartyAccountDTOListById(clientId,accountCategory,page);
	}

	@Override
	public Long getPartyAccountDTOCountById(Long clientId, Long accountCategory) {
		return crmDao.getPartyAccountDTOCountById(clientId,accountCategory);
	}

	@Override
	public Long getJurisdictionListCount() {
		return crmDao.getJurisdictionListCount();
	}

	@Override
	public List<JurisdictionDTO> getJurisdictionDTOList(Long count){
		return crmDao.getJurisdictionDTOList(count);
	}

	@Override
	public Long getTimezoneListCount() {
		return crmDao.getTimezoneListCount();
	}

	@Override
	public List<TimezoneDTO> getTimezoneDTOList(Long count){
		return crmDao.getTimezoneDTOList(count);
	}

	@Override
	public Long getCodeTypeListCount() {
		return crmDao.getCodeTypeListCount();
	}

	@Override
	public List<CodeTypeDTO> getCodeTypeDTOList(Long count){
		return crmDao.getCodeTypeDTOList(count);
	}

	@Override
	public Long getCodeListCount() {
		return crmDao.getCodeListCount();
	}

	@Override
	public List<CodeDTO> getCodeDTOList(Long count) {
		return crmDao.getCodeDTOList(count);
	}

	@Override
	public Long getTaskNotificationTemplateListCount() {
		return crmDao.getTaskNotificationTemplateListCount();
	}

	@Override
	public List<TaskNotificationTemplateDTO> getTaskNotificationTemplateDTOList(
			Long count) {
		return crmDao.getTaskNotificationTemplateDTOList(count);
	}

	@Override
	public Long getTaskNotificationRecipientListCount() {
		return crmDao.getTaskNotificationRecipientListCount();
	}

	@Override
	public List<TaskNotificationRecipientDTO> getTaskNotificationRecipientDTOList(
			Long count) {
		return crmDao.getTaskNotificationRecipientDTOList(count);
	}

	@Override
	public Long getPartyCodeListCount(Long firmId) {
		return crmDao.getPartyCodeListCount(firmId);
	}

	@Override
	public List<PartyCodeDTO> getPartyCodeDTOList(Long count, Long firmId) {
		return crmDao.getPartyCodeDTOList(count,firmId);
	}

	@Override
	public Long getOfficersAndShareHoldersListCount(Long mainPartyId, Integer relationshipTypeId) {
		return crmDao.getOfficersAndShareHoldersListCount(mainPartyId, relationshipTypeId);
	}

	@Override
	public List<PartyDTO> getOfficersAndShareHoldersList(Long mainPartyId, Integer relationshipTypeId, 
			Long count) {
		return crmDao.getOfficersAndShareHoldersList(mainPartyId, relationshipTypeId, count);
	}

	@Override
	public List<LocationDTO> getLocationList(Long partyId, Long count) {
		
		return crmDao.getLocationList(partyId,count);
	}

	@Override
	public Long getLocationListCount(Long partyId) {
		
		return crmDao.getLocationListCount(partyId);
	}

	@Override
	public Long getFirmStaffListCount(Long firmId, List<Integer> listOfPersonType) {
		
		return crmDao.getFirmStaffListCount(firmId,listOfPersonType);
	}

	@Override
	public List<PersonDTO> getFirmStaffList(Long firmId, List<Integer> listOfPersonType, Long count) {
		
		return crmDao.getFirmStaffList(firmId,listOfPersonType,count);
	}

	@Override
	public List getPartyDropdownListForRelationship(Long partyId,
			Integer relationshipId) {
		return crmDao.getPartyDropdownListForRelationship(partyId, relationshipId);
	}
	
	@Override
	@Transactional
	public Long getRelatedPartyId(Long mainPartyId, Integer relationshipId){
		return crmDao.getRelatedPartyId(mainPartyId, relationshipId);
	}

	@Override
	public Long getAdminCodeListCount(Long codeTypeId, Boolean applicationLevelId) {
		return crmDao.getAdminCodeListCount(codeTypeId, applicationLevelId);
	}

	@Override
	public Long getMobileAdminCodeListCount(Long codeTypeId,
			Boolean applicationLevelId) {
		return crmDao.getMobileAdminCodeListCount(codeTypeId, applicationLevelId);
	}
	
	@Override
	public List<CodeDTO> getAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count) {
		return crmDao.getAdminCodeDTOList(codeTypeId, applicationLevelId, count);
	}

	@Override
	public List<CodeDTO> getMobileAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count) {
		return crmDao.getMobileAdminCodeDTOList(codeTypeId, applicationLevelId, count);
	}
	
	@Override
	public Long getCountOfCodeTypeByCodeTypeId(Long firmId, Long codeTypeId) {
		return crmDao.getCountOfCodeTypeByCodeTypeId(firmId, codeTypeId);
	}

	@Override
	public List<PartyCodeDTO> getListOfCodeTypeByCodeTypeId(Long count,
			Long firmId, Long codeTypeId) {
		return crmDao.getListOfCodeTypeByCodeTypeId(count, firmId, codeTypeId);
	}

	@Override
	@Transactional
	public Long getRelatedClientId(Long id, Long accountCategoryId) {
		return crmDao.getRelatedClientId(id, accountCategoryId);
	}

	@Override
	public Long getFirmsCountById(Integer partyTypeId, Integer organizationTypeId) {
		return crmDao.getFirmsCountById(partyTypeId, organizationTypeId);
	}

	@Override
	public List<PartyDTO> getFirmsListById(Integer partyTypeId, Integer organizationTypeId,
			Long count) {
		return crmDao.getFirmsListById(partyTypeId, organizationTypeId, count);
	}

	@Override
	public List getEmailsList(List listOfPersonType) {
		return crmDao.getEmailsList(listOfPersonType);
	}

	@Override
	public Object getUserById(Long partyRelationshipId) {
		return crmDao.getUserById(partyRelationshipId);
	}

	@Override
	@Transactional
	public void userThemeSave(String theme) {
		crmDao.userThemeSave(theme);
		
	}

	@Override
	@Transactional
	public String userGetTheme(String loggedInUser) {
		return crmDao.userGetTheme(loggedInUser);
	}

	@Override
	public Boolean codeIsPresent(String shortDesc) {
		return crmDao.codeIsPresent(shortDesc);
	}

	@Override
	public Boolean partyCodeIsPresent(String shortDesc, Long firmId) {
		return crmDao.partyCodeIsPresent(shortDesc,firmId);
	}

	@Override
	public void updateNotification(Date notificationDate, String to, Long taskId, Long newTaskId) {
		
		crmDao.updateNotification(notificationDate,to,taskId,newTaskId);
	}

	@Override
	public List getFirmNameList() {
		//bug no 511
		return crmDao.getFirmNameList();
	}

	@Override
	public Integer getPartySiteByPartyId(Long firmId) {
		return crmDao.getPartySiteByPartyId(firmId);
	}

	@Override
	public List<ClientListDTO> getClientList(Long firmId) {
		/*return dJMapper.getClientList(firmId);*/
		return null;
	}

	@Override
	@Transactional(readOnly = false)
	public void updatePartyAccount(PartyAccount account,
			List<PhoneCommunication> phonesToBeRemoved) {
		crmDao.updatePartyAccount(account,phonesToBeRemoved);
		
	}

	@Override
	public List<PartyAccountDTO> getPartyAccountDTOListByIdNew(Long clientId,
			Long accountCategory, Page page) {
		// TODO Auto-generated method stub
		return crmDao.getPartyAccountDTOListByIdNew(clientId,accountCategory, page);
	}

	@Transactional
	@Override
	public String getLanguage(PMUser loggedInUser) {
		return crmDao.getLanguage(loggedInUser);
	}

	public void changeLanguage(String newLanguage, String username) {
		// TODO Auto-generated method stub
		crmDao.changeLanguage(newLanguage,username);
	}
	
	public String getLanguageStr(String newuser) {
		// TODO Auto-generated method stub
		return crmDao.getLanguageStr(newuser);
	}

	public PartySite getPartySiteByNewPartyId(Long id) {
		return crmDao.getPartySiteByNewPartyId(id);
	}

	public PointOfContact getpointOfContactByNewPartyId(Long id) {
		return crmDao.getpointOfContactByNewPartyId(id);
	}
	
	public List<PersonDTO> getFirmStaffList(Long firmId,
			List<Integer> listOfPersonType, Page page){
		return crmDao.getFirmStaffList(firmId,listOfPersonType,page.getLimit(),page.getStart());
	}
	
	@Override
	public List<PartyDTO> getMobilePartyDTOListById(Long objectPartyId,
	        Integer relationshipTypeId, int start, int limit) {
		 return crmDao.getMobilePartyDTOListById(objectPartyId,
	                relationshipTypeId, start, limit);
	}

	@Override
	public List<CodeDTO> getCodeDTOList(int start, int limit) {
		 return crmDao.getCodeDTOList(start, limit);
	}
	
	@Override
	public List<PartyAccount> getAccountListByPartyAndCategory(Long id, Long clientId, Long accountCategory) {
		return crmDao.getAccountListByPartyAndCategory(id, clientId, accountCategory);
	}

	@Override
	public void deleteBank(boolean activeFlag, String delList, Long accountCategory) {
		crmDao.deleteBank(Boolean.FALSE, delList, accountCategory);
	}

	@Override
	public void deleteStaff(boolean activeFlag, Long newId) {
		crmDao.deleteStaff(Boolean.FALSE, newId);	
	}

	@Override
	public void deleteLocation(boolean activeFlag, Long newId) {
		crmDao.deleteLocation(Boolean.FALSE, newId);
	}

	@Override
	public void deleteFirmStaff(boolean activeFlag, Long newId) {
		crmDao.deleteFirmStaff(Boolean.FALSE, newId);
	}

	@Override
	public void deleteCode(boolean activeFlag, Long newId) {
		crmDao.deleteCode(Boolean.FALSE, newId);
	}

	@Override
	public void deleteFirmList(boolean activeFlag, Long newId) {
		crmDao.deleteFirmList(Boolean.FALSE, newId);
	}

	@Override
	public void deleteJurisdictions(boolean activeFlag, Long newId) {
		crmDao.deleteJurisdictions(Boolean.FALSE, newId);
	}

	@Override
	public void deleteCodeTypeAdmn(boolean activeFlag, Long newId) {
		crmDao.deleteCodeTypeAdmn(Boolean.FALSE, newId);
	}

	@Override
	public void deleteAdminCode(boolean activeFlag, Long newId) {
		crmDao.deleteAdminCode(Boolean.FALSE, newId);
	}

	@Override
	public void deleteTemplate(boolean activeFlag, Long newId) {
		crmDao.deleteTemplate(Boolean.FALSE, newId);
	}

	@Override
	public void deleteRecepient(boolean activeFlag, Long newId) {
		crmDao.deleteRecepient(Boolean.FALSE, newId);
	}

	@Override
	public void deleteOfficer(Long newId) {
		crmDao.deleteOfficer(newId);
	}
	
	public List<CodeType> getCodeTypeListDropdown(){
		return crmDao.getCodeTypeListDropdown();
	}

	public List<PartyDTO> getMobilePartyDTOList(int start, int limit,
			Integer partyTypeId, Integer orgTypeId) {
		// TODO Auto-generated method stub
		return crmDao.getMobilePartyDTOList(start, limit,
				partyTypeId, orgTypeId);
	}

	public Boolean isValidUser(String userName, String userResetPasswordKey) {
		// TODO Auto-generated method stub
		return crmDao.isValidUser(userName, userResetPasswordKey);
	}

	public void savePassword(String username,
			String encryptedUserResetPasswordKey) {
		crmDao.savePassword(username,
				encryptedUserResetPasswordKey);
	}

	public List getPartyDropdownListForOfficersEdit(Long firmId,
			Integer relationshipId) {
		return crmDao.getPartyDropdownListForOfficersEdit(firmId, relationshipId);
	}

	public List getPartyDropdownListForRelationshipWithoutShares(Long firmId,
			Integer relationshipId) {
		return crmDao.getPartyDropdownListForRelationshipWithoutShares(firmId,
				 relationshipId);
	}

	@Transactional
	public CredentialsDTO getUserCredentials(String module, Long partyId,
			String role) {
		return crmDao.getUserCredentials(module, partyId,
				 role);
	}

	
	
	/*@Override
	public Integer getParentCode(Long codeTypeId) {
		return crmDao.getParentCode(codeTypeId);
	}
*/
}
