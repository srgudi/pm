package com.chiguru.pm.crm.dto;

import java.io.Serializable;

import java.util.Date;


public class PersonDTO implements Serializable {
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

    public Long getPartyId() {
        return partyId;
    }

    public void setPartyId(Long partyId) {
        this.partyId = partyId;
    }

    public CommunicationDTO getCommunicationDTO() {
        return communicationDTO;
    }

    public void setCommunicationDTO(CommunicationDTO communicationDTO) {
        this.communicationDTO = communicationDTO;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(String phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

	public void setRelationshipTypeId(String relationshipTypeId) {
		this.relationshipTypeId = relationshipTypeId;
	}

	public String getRelationshipTypeId() {
		return relationshipTypeId;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRole() {
		return role;
	}

	public Boolean getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
}
