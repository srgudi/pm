package com.chiguru.pm.crm.dto;

import java.io.Serializable;
import java.math.BigInteger;

import java.util.Date;


public class PartyDTO implements Serializable {
    private Long id;
    private Long partyId;
    private Long noOfSharesOwned;
    private Long bigIntNoOfSharesOwned;
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

    public String getInChargePerson() {
		return inChargePerson;
	}

	public void setInChargePerson(String inChargePerson) {
		this.inChargePerson = inChargePerson;
	}

	public CommunicationDTO getCommunicationDTO() {
        return communicationDTO;
    }

    public void setCommunicationDTO(CommunicationDTO communicationDTO) {
        this.communicationDTO = communicationDTO;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(String phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the partyId
     */
    public Long getPartyId() {
        return partyId;
    }

    /**
     * @param partyId the partyId to set
     */
    public void setPartyId(Long partyId) {
        this.partyId = partyId;
    }

    /**
     * @return the formOfBusiness
     */
    public String getFormOfBusiness() {
        return formOfBusiness;
    }

    /**
     * @param formOfBusiness the formOfBusiness to set
     */
    public void setFormOfBusiness(String formOfBusiness) {
        this.formOfBusiness = formOfBusiness;
    }

    /**
     * @return the businessNumber
     */
    public String getBusinessNumber() {
        return businessNumber;
    }

    /**
     * @param businessNumber the businessNumber to set
     */
    public void setBusinessNumber(String businessNumber) {
        this.businessNumber = businessNumber;
    }

    /**
     * @return the yearEndDate
     */
    /*public Date getYearEndDate() {
        return yearEndDate;
    }

    *//**
     * @param yearEndDate the yearEndDate to set
     *//*
    public void setYearEndDate(Date yearEndDate) {
        this.yearEndDate = yearEndDate;
    }*/

    /**
     * @return the industryType
     */
    public String getIndustryType() {
        return industryType;
    }

    /**
     * @param industryType the industryType to set
     */
    public void setIndustryType(String industryType) {
        this.industryType = industryType;
    }

    /**
     * @return the jurisdiction
     */
    public String getJurisdiction() {
        return jurisdiction;
    }

    /**
     * @param jurisdiction the jurisdiction to set
     */
    public void setJurisdiction(String jurisdiction) {
        this.jurisdiction = jurisdiction;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the startDate
     */
    public Date getStartDate() {
        return startDate;
    }

    /**
     * @param startDate the startDate to set
     */
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    /**
     * @return the endDate
     */
    public Date getEndDate() {
        return endDate;
    }

    /**
     * @param endDate the endDate to set
     */
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the typeOfShare
     */
    public String getTypeOfShare() {
        return typeOfShare;
    }

    /**
     * @param typeOfShare the typeOfShare to set
     */
    public void setTypeOfShare(String typeOfShare) {
        this.typeOfShare = typeOfShare;
    }

    /**
     * @return the viewDetails
     */
    public String getViewDetails() {
        return viewDetails;
    }

    /**
     * @param viewDetails the viewDetails to set
     */
    public void setViewDetails(String viewDetails) {
        this.viewDetails = viewDetails;
//    	this.viewDetails = "View Tax Info Details";
    }

	public String getYearEndDate() {
		return yearEndDate;
	}

	public void setYearEndDate(String yearEndDate) {
		this.yearEndDate = yearEndDate;
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

	public void setNoOfSharesOwned(Long noOfSharesOwned) {
		this.noOfSharesOwned = noOfSharesOwned;
	}

	public Long getNoOfSharesOwned() {
		return noOfSharesOwned;
	}

	public Long getBigIntNoOfSharesOwned() {
		return bigIntNoOfSharesOwned;
	}

	public void setBigIntNoOfSharesOwned(Long bigIntNoOfSharesOwned) {
		this.bigIntNoOfSharesOwned = bigIntNoOfSharesOwned;
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
