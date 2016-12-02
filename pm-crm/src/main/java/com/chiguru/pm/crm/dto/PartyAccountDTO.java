package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class PartyAccountDTO implements Serializable {
    private Long accountId;
    private String accountFirmName;
    private String accountCategory;
    private String accountType;
    private String accountNumber;
    private String terms;
    private Long id;
    private Long newId;
    private String status;
    private String allNumber;
    private String contactName;
    private CommunicationDTO communicationDTO;
    private String officeNumber;
    private String emailAddress;

    /**
     * @return the accountFirmName
     */
    public String getAccountFirmName() {
        return accountFirmName;
    }

    /**
     * @param accountFirmName the accountFirmName to set
     */
    public void setAccountFirmName(String accountFirmName) {
        this.accountFirmName = accountFirmName;
    }

    public CommunicationDTO getCommunicationDTO() {
        return communicationDTO;
    }

    public void setCommunicationDTO(CommunicationDTO communicationDTO) {
        this.communicationDTO = communicationDTO;
    }

    /**
     * @return the accountId
     */
    public Long getAccountId() {
        return accountId;
    }

    /**
     * @param accountId the accountId to set
     */
    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    /**
     * @return the accountCategory
     */
    public String getAccountCategory() {
        return accountCategory;
    }

    /**
     * @param accountCategory the accountCategory to set
     */
    public void setAccountCategory(String accountCategory) {
        this.accountCategory = accountCategory;
    }

    /**
     * @return the accountType
     */
    public String getAccountType() {
        return accountType;
    }

    /**
     * @param accountType the accountType to set
     */
    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    /**
     * @return the accountNumber
     */
    public String getAccountNumber() {
        return accountNumber;
    }

    /**
     * @param accountNumber the accountNumber to set
     */
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    /**
     * @return the terms
     */
    public String getTerms() {
        return terms;
    }

    /**
     * @param terms the terms to set
     */
    public void setTerms(String terms) {
        this.terms = terms;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the allNumber
     */
    public String getAllNumber() {
        return allNumber;
    }

    /**
     * @param allNumber the allNumber to set
     */
    public void setAllNumber(String allNumber) {
        this.allNumber = allNumber;
    }

    /**
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
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

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setNewId(Long newId) {
		this.newId = newId;
	}

	public Long getNewId() {
		return newId;
	}

	
}
