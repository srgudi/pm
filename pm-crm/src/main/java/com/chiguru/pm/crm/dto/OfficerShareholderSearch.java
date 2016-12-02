package com.chiguru.pm.crm.dto;

import java.math.BigInteger;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OfficerShareholderSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
    
    private Long id;
    private Long partyId;
    private Long noOfSharesOwned;
    private BigInteger bigIntNoOfSharesOwned;
    private String formOfBusiness;
    private String businessNumber;
//    private Date yearEndDate;
    private String yearEndDate;
    private String industryType;
    private String jurisdiction;
    private String name;
    private Date startDate;
    private Date endDate;
    private String title;
    private Date dateOfBirth;
    private String compensation;
    private Boolean isDirector;
    private String phoneNumbers;
    private CommunicationDTO communicationDTO;
    private String status;
    private String typeOfShare;
    private String viewDetails = "View Tax Info Details";
    private String inChargePerson;
    private String officeNumber;
    private String emailAddress;
    private String homeNumber;
    private Boolean activeFlag;
    private String personType;
    private Integer relationshipTypeId;
    private Long mainPartyId;
    
    
	public Long getMainPartyId() {
		return mainPartyId;
	}
	public void setMainPartyId(Long mainPartyId) {
		this.mainPartyId = mainPartyId;
	}
	public Integer getRelationshipTypeId() {
		return relationshipTypeId;
	}
	public void setRelationshipTypeId(Integer relationshipTypeId) {
		this.relationshipTypeId = relationshipTypeId;
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
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPartyId() {
		return partyId;
	}
	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}
	public Long getNoOfSharesOwned() {
		return noOfSharesOwned;
	}
	public void setNoOfSharesOwned(Long noOfSharesOwned) {
		this.noOfSharesOwned = noOfSharesOwned;
	}
	public BigInteger getBigIntNoOfSharesOwned() {
		return bigIntNoOfSharesOwned;
	}
	public void setBigIntNoOfSharesOwned(BigInteger bigIntNoOfSharesOwned) {
		this.bigIntNoOfSharesOwned = bigIntNoOfSharesOwned;
	}
	public String getFormOfBusiness() {
		return formOfBusiness;
	}
	public void setFormOfBusiness(String formOfBusiness) {
		this.formOfBusiness = formOfBusiness;
	}
	public String getBusinessNumber() {
		return businessNumber;
	}
	public void setBusinessNumber(String businessNumber) {
		this.businessNumber = businessNumber;
	}
	public String getYearEndDate() {
		return yearEndDate;
	}
	public void setYearEndDate(String yearEndDate) {
		this.yearEndDate = yearEndDate;
	}
	public String getIndustryType() {
		return industryType;
	}
	public void setIndustryType(String industryType) {
		this.industryType = industryType;
	}
	public String getJurisdiction() {
		return jurisdiction;
	}
	public void setJurisdiction(String jurisdiction) {
		this.jurisdiction = jurisdiction;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getCompensation() {
		return compensation;
	}
	public void setCompensation(String compensation) {
		this.compensation = compensation;
	}
	public Boolean getIsDirector() {
		return isDirector;
	}
	public void setIsDirector(Boolean isDirector) {
		this.isDirector = isDirector;
	}
	public String getPhoneNumbers() {
		return phoneNumbers;
	}
	public void setPhoneNumbers(String phoneNumbers) {
		this.phoneNumbers = phoneNumbers;
	}
	public CommunicationDTO getCommunicationDTO() {
		return communicationDTO;
	}
	public void setCommunicationDTO(CommunicationDTO communicationDTO) {
		this.communicationDTO = communicationDTO;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTypeOfShare() {
		return typeOfShare;
	}
	public void setTypeOfShare(String typeOfShare) {
		this.typeOfShare = typeOfShare;
	}
	public String getViewDetails() {
		return viewDetails;
	}
	public void setViewDetails(String viewDetails) {
		this.viewDetails = viewDetails;
	}
	public String getInChargePerson() {
		return inChargePerson;
	}
	public void setInChargePerson(String inChargePerson) {
		this.inChargePerson = inChargePerson;
	}
	public String getOfficeNumber() {
		return officeNumber;
	}
	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public String getHomeNumber() {
		return homeNumber;
	}
	public void setHomeNumber(String homeNumber) {
		this.homeNumber = homeNumber;
	}
	public Boolean getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
    
}
