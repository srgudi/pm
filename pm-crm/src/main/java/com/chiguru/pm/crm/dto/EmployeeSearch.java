package com.chiguru.pm.crm.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployeeSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
    
    private Long firmId;
    private Long partyId;
    private String firstName;
    private String lastName;
    private String middleName;
    private String personIdentificationNumber;
    private Date dateOfBirth;
    private String departmentCode;
    private String jobTitle;
    private Long noOfSharesOwned;
    private String annualCompensation;
    private String comittee;
    private Boolean isDirector;
    private Boolean isStaff;
    private String typeOfShare;
    private String phoneNumbers;

    //sagar
    private String name;
    private CommunicationDTO communicationDTO;
    private String personType;
    private String roleType;
    private String relationshipType;
    private String relationshipTypeId;
    private String officeNumber;
    private String homeNumber;
    private String emailAddress;
    private String role;
    private String status;
    private Boolean activeFlag;
    private List<Integer> listOfPersonType;
    private Integer staffTypeId;
    private Integer partnerTypeId;
    private Integer firmAdminTypeId;
    

    
	public Integer getStaffTypeId() {
		return staffTypeId;
	}
	public void setStaffTypeId(Integer staffTypeId) {
		this.staffTypeId = staffTypeId;
	}
	public Integer getPartnerTypeId() {
		return partnerTypeId;
	}
	public void setPartnerTypeId(Integer partnerTypeId) {
		this.partnerTypeId = partnerTypeId;
	}
	public Integer getFirmAdminTypeId() {
		return firmAdminTypeId;
	}
	public void setFirmAdminTypeId(Integer firmAdminTypeId) {
		this.firmAdminTypeId = firmAdminTypeId;
	}
	public List<Integer> getListOfPersonType() {
		return listOfPersonType;
	}
	public void setListOfPersonType(List<Integer> listOfPersonType) {
		this.listOfPersonType = listOfPersonType;
	}
	public Map<String, List> getFilterList() {
		return filterList;
	}
	public void setFilterList(Map<String, List> filterList) {
		this.filterList = filterList;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public Long getFirmId() {
		return firmId;
	}
	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}
	public Long getPartyId() {
		return partyId;
	}
	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getPersonIdentificationNumber() {
		return personIdentificationNumber;
	}
	public void setPersonIdentificationNumber(String personIdentificationNumber) {
		this.personIdentificationNumber = personIdentificationNumber;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getDepartmentCode() {
		return departmentCode;
	}
	public void setDepartmentCode(String departmentCode) {
		this.departmentCode = departmentCode;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public Long getNoOfSharesOwned() {
		return noOfSharesOwned;
	}
	public void setNoOfSharesOwned(Long noOfSharesOwned) {
		this.noOfSharesOwned = noOfSharesOwned;
	}
	public String getAnnualCompensation() {
		return annualCompensation;
	}
	public void setAnnualCompensation(String annualCompensation) {
		this.annualCompensation = annualCompensation;
	}
	public String getComittee() {
		return comittee;
	}
	public void setComittee(String comittee) {
		this.comittee = comittee;
	}
	public Boolean getIsDirector() {
		return isDirector;
	}
	public void setIsDirector(Boolean isDirector) {
		this.isDirector = isDirector;
	}
	public Boolean getIsStaff() {
		return isStaff;
	}
	public void setIsStaff(Boolean isStaff) {
		this.isStaff = isStaff;
	}
	public String getTypeOfShare() {
		return typeOfShare;
	}
	public void setTypeOfShare(String typeOfShare) {
		this.typeOfShare = typeOfShare;
	}
	public String getPhoneNumbers() {
		return phoneNumbers;
	}
	public void setPhoneNumbers(String phoneNumbers) {
		this.phoneNumbers = phoneNumbers;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public CommunicationDTO getCommunicationDTO() {
		return communicationDTO;
	}
	public void setCommunicationDTO(CommunicationDTO communicationDTO) {
		this.communicationDTO = communicationDTO;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getRelationshipType() {
		return relationshipType;
	}
	public void setRelationshipType(String relationshipType) {
		this.relationshipType = relationshipType;
	}
	public String getRelationshipTypeId() {
		return relationshipTypeId;
	}
	public void setRelationshipTypeId(String relationshipTypeId) {
		this.relationshipTypeId = relationshipTypeId;
	}
	public String getOfficeNumber() {
		return officeNumber;
	}
	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}
	public String getHomeNumber() {
		return homeNumber;
	}
	public void setHomeNumber(String homeNumber) {
		this.homeNumber = homeNumber;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Boolean getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
}
