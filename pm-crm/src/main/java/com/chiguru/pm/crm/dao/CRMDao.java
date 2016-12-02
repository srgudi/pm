package com.chiguru.pm.crm.dao;

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
import com.chiguru.pm.crm.dto.CredentialsDTO;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TimezoneDTO;
//import com.chiguru.pm.crm.service.Serializable;
import com.chiguru.pm.security.PMUser;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;


public interface CRMDao {
    Party getPartyById(Long partyId);
    List<AddressDTO> getReportAddress(Long firmid);
    List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId);

    List<Long> getPartiesByTypeId(Integer partyTypeId);

    public List<Party> getRelatedPartiesById(Long partyId,
        List<RelationshipType> listOfRelationshipType);

    public PartyRelationship createPartyAndRelationship(Party mainParty,
        Party relatedParty, String userId, RelationshipType relationshipType);

    public void createOrganization(Organization org);

    public void createParty(Party party);

    public List<PartyType> getPartyTypeList();

    public List<OrganizationType> getOrganizationTypeList();

    public List<PersonType> getPersonTypeList();

    public List<RelationshipType> getRelationshipTypeList();

    public Map<CodeType, Set<Code>> getApplicationLevelCodeMap();

    public Map<CodeType, List<Code>> getPartyLevelCodeMap(Long partyId);

    public Code getCodeById(Integer id);

    public List<CodeType> getApplicationLevelCodeType();

    public CodeType getCodeTypeById(Long id);

    public List<Code> getCodesByCodeType(Long codeTypeId);

    public PartyAccount getAccountById(Long accountId);

    /*public List<PartyAccount> getAccountById(List delList);*/
    
    public Code getCodeById(Long id);

    public void savePartyAccount(PartyAccount account,
        List<PhoneCommunication> phonesToBeRemoved);
   /* public void savePartyAccount(List<PartyAccount> account,
            List<PhoneCommunication> phonesToBeRemoved);*/
    
    public List<CommunicationType> getCommunicationTypes(boolean phoneIndicator);

    public CommunicationType getCommunicationTypeById(Integer id);

    public PartySite getPartySiteById(Long id);

    public PartyAccount getAccountByIdAndAccountType(Long accountId,
        Long accountCategoryId);

    public RelationshipType getRelationshipTypeById(Integer id);

    public List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId, String sortName, String sortType,
        Integer start, Integer maxResults);

    public List<Long> getPartiesByTypeId(Integer partyTypeId, String sortName,
        String sortType, Integer start, Integer maxResults);

    public Long getRelatedPartiesCountById(Long objectPartyId,
        Integer relationshipTypeId);

    public Long getPartiesCountByTypeId(Integer partyTypeId);

    public PartySiteType getPartySiteTypeById(Integer id);

    public Person getPersonById(Long partyId);

    public Organization getOrganizationById(Long partyId);

    public void deletePhoneCommunication(
        List<PhoneCommunication> phonesToBeRemoved);
    
    /*public List<PartyAccountDTO> findAccountsById(Long newId);*/
    
    //public void deleteBank(List<PartyAccountDTO> partyAccountDTO);

    
    /*public List<PartyAccount> getAccountListByPartyAndCategory(Long partyId,
        Long accountCategory, String sortName, String sortType, Integer start,
        Integer maxResults);
*/
    public Long findAccountsCountById(Long partyId, Long accountCategory);

    public List<PartySiteType> getPartySiteTypes();

    public void savePartySite(PartySite partySite);

    public void createCode(Code code);

    public Jurisdiction getJurisdictionById(Long id);

    public List<Jurisdiction> getJurisdictionList();

    //sagar
    public void saveJurisdiction(Jurisdiction manageJurisdiction);

    public List<Timezone> getTimezoneList();

    public Timezone getTimezoneById(Long id);

    public void saveTimezone(Timezone manageTimezone);

    //	public CodeType getCodeTypeById(Long id);
    public List<CodeType> getCodeTypeList();

    public void saveCodeType(CodeType manageCodeType);

    public List<Code> getCodeList();

    public void saveCode(Code manageCode);

    public PartyCode getPartyCodeById(Long id);

    public List<PartyCode> getPartyCodeList(Long firmId);

    public void savePartyCode(PartyCode partyCode);

    public Long getMaxCodeIdValue();

    public Long getParentCodeTypeIdById(Long codeTypeId);

    public List<Code> getRelatedCodeByCodeTypeId(Long parentCodeTypeId);

    public List<CodeType> getCodeTypeListWhereApplcationLevelIsFalse();

    public List<Code> getRelatedCodeByCodeTypeIdWhereAppFalse(
    		Long parentCodeTypeId);

    public void saveParty(Party party);

    public PartyType getPartyTypeById(Integer id);

    public List<PartyRelationship> getListOfRelatedParties(Long firmId);

    public Long getMaxJurisdictionIdValue();

    public PartyRelationship getPartyRelationshipById(Long id);

    public List<PartyCode> getPartyCodeByFirmId(Long integer, Long firmId);

    public List getCodesByCodeTypeForAdminStaff(Long id);

    public PointOfContact getPointOfContactById(Long id);

    public Communication getCommunicationById(Long id);
    
    public List<Party> getPartyRelationshipbySubId(Long id);
    
    public List<Party> getPartybyLocationIdFromPartySite(Long id,Long clientId);
    
    public List<Party> getPartyRelationshipByBothId(Long shareId,Long clientId,Integer relationshipTypeId);
    
    public List<Party> getPartyAccountByBothId(Long bankId,Long clientId,Long accountCategoryId);
    
    public List<Long> getPartyByPartyNPartyTypeId(Long partyId,Integer partyTypeId);
    
    public List<PartyCode> getPartyCodeByCodeId(Long id);
    
    public List<Organization> getFirmList();

    public List<PartyDTO> getPartyDTOListById(Long objectPartyId,
			Integer relationshipTypeId, int count, int limit, int start);

    public List<PersonDTO> getPersonDTOListById(Long clientId,
			Integer relationshipTypeId, int count);

    public Long getStaffDTOCountById(Long clientId, Integer relationshipTypeId);

    public List<PartyAccountDTO> getPartyAccountDTOListById(Long clientId,Long accountCategory, Page page);

    public Long getPartyAccountDTOCountById(Long clientId, Long accountCategory);

    public Long getJurisdictionListCount();

    public List<JurisdictionDTO> getJurisdictionDTOList(Long count);

    public	Long getTimezoneListCount();

    public	List<TimezoneDTO> getTimezoneDTOList(Long count);

    public	Long getCodeTypeListCount();

    public	List<CodeTypeDTO> getCodeTypeDTOList(Long count);

    public	Long getCodeListCount();
    
    public	List<CodeDTO> getCodeDTOList(Long count);

    public	Long getTaskNotificationTemplateListCount();

    public	List<TaskNotificationTemplateDTO> getTaskNotificationTemplateDTOList(
			Long count);

    public	Long getTaskNotificationRecipientListCount();

    public	List<TaskNotificationRecipientDTO> getTaskNotificationRecipientDTOList(
			Long count);

    public Long getPartyCodeListCount(Long firmId);

    public	List<PartyCodeDTO> getPartyCodeDTOList(Long count, Long firmId);

    public	Long getOfficersAndShareHoldersListCount(Long mainPartyId, Integer relationshipTypeId);

    public	List<PartyDTO> getOfficersAndShareHoldersList(Long mainPartyId,
			Integer relationshipTypeId, Long count);

    public  List<LocationDTO> getLocationList(Long partyId, Long count);

    public  Long getLocationListCount(Long partyId);

    public  Long getFirmStaffListCount(Long firmId, List<Integer> listOfPersonType);

    public  List<PersonDTO> getFirmStaffList(Long firmId, List<Integer> listOfPersonType, Long count);

	public List<CodeDTO> getCodeDTOListForCodeType(Long codeType);

	public List<KeyValue> getCodeDropdownListForCodeTypeAndParty(Long codeType, Long partyId, Long parentCodeTypeId);

	public List<KeyValue> getPartyDropdownListForRelationship(Long partyId,
			Integer relationshipId);

	public List getPartyDropdownListForOfficersEdit(Long firmId, Integer relationshipId);
	
	public Long getRelatedPartyId(Long mainPartyId, Integer relationshipId);

	public Long getAdminCodeListCount(Long codeTypeId, Boolean applicationLevelId);
	
	public Long getMobileAdminCodeListCount(Long codeTypeId, Boolean applicationLevelId);

	public List<CodeDTO> getAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count);

	public List<CodeDTO> getMobileAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count);
	
	public Long getCountOfCodeTypeByCodeTypeId(Long firmId, Long codeTypeId);

	public List<PartyCodeDTO> getListOfCodeTypeByCodeTypeId(Long count, Long firmId,
			Long codeTypeId);

	public Long getRelatedClientId(Long id, Long accountCategoryId);

	public Long getFirmsCountById(Integer partyTypeId, Integer organizationTypeId);

	public List<PartyDTO> getFirmsListById(Integer partyTypeId, Integer organizationTypeId, Long count);

	public List getEmailsList(List listOfPersonType);

	Object getUserById(Long partyRelationshipId);
	
	public List<Code> getListOfAdminCodes();

	public void createPartyCodeForNewFirm(List<PartyCode> listOfPartCode);

	public void userThemeSave(String theme);

	public String userGetTheme(String loggedInUser);
	public boolean checkEntityExists(Serializable id, Class entityClass);

	public Boolean codeIsPresent(String shortDesc);

	public Boolean partyCodeIsPresent(String shortDesc, Long firmId);
	
	public void updateNotification(Date notificationDate, String to, Long taskId, Long newTaskId);
	
	public List getFirmNameList();
	
	/*public Integer getParentCode(Long codeTypeId);*/
	
	public List getCodeDropdownListForCodeType(Long codeType);
	
	public Integer getPartySiteByPartyId(Long firmId);
	
	public void updatePartyAccount(PartyAccount account,
			List<PhoneCommunication> phonesToBeRemoved);
	
	public List<PartyAccountDTO> getPartyAccountDTOListByIdNew(Long clientId,
			Long accountCategory, Page page);
	
	public String getLanguage(PMUser loggedInUser);
	
	public void changeLanguage(String newLanguage, String username);
	
	public String getLanguageStr(String newuser);
	
	public PartySite getPartySiteByNewPartyId(Long id);
	
	public PointOfContact getpointOfContactByNewPartyId(Long id);
	
	public List<PersonDTO> getFirmStaffList(Long firmId,
			List<Integer> listOfPersonType, int limit, int start);
	
	public List<PartyDTO> getMobilePartyDTOListById(Long objectPartyId,
			Integer relationshipTypeId, int start, int limit);
	
	public List<CodeDTO> getCodeDTOList(int start, int limit);
	
	public List<PartyAccount> getAccountListByPartyAndCategory(Long partyId,
			Long accountCategory, String sortName, String sortType,
			Integer start, Integer maxResults);
	List<PartyAccount> getAccountListByPartyAndCategory(Long id, Long clientId,
			Long accountCategory);
	void deleteBank(boolean activeFlag,  String delList, Long accountCategory);
	
	void deleteStaff(boolean activeFlag, Long newId);
	
	void deleteFirmStaff(boolean activeFlag, Long newId);
	
	void deleteLocation(boolean activeFlag, Long newId);
	
	void deleteCode(boolean activeFlag, Long newId);
	
	void deleteFirmList(boolean activeFlag, Long newId);
	
	void deleteJurisdictions(boolean activeFlag, Long newId);
	
	void deleteCodeTypeAdmn(boolean activeFlag, Long newId);
	
	void deleteAdminCode(boolean activeFlag, Long newId);
	
	void deleteTemplate(boolean activeFlag, Long newId);
	
	void deleteRecepient(boolean activeFlag, Long newId);
	
	void deleteOfficer(Long newId);
	
	public List<CodeType> getCodeTypeListDropdown();

	public List<PartyDTO> getMobilePartyDTOList(int start, int limit,
			Integer partyTypeId, Integer orgTypeId);
	
	/*public List<ClientListDTO> getClientList(Long firmId);*/
	
	public Boolean isValidUser(String userName, String userResetPasswordKey);

	public void savePassword(String username,
			String encryptedUserResetPasswordKey);
	
	public List getPartyDropdownListForRelationshipWithoutShares(Long firmId,
			Integer relationshipId);
	
    public CredentialsDTO getUserCredentials(String module,Long partyId,String role);
}
