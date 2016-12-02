package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class LocationDTO implements Serializable {
    private Long id;
    private Long partySiteId;
    private String name;
    private String locationType;
    private String partyName;
    private String status;
    private CommunicationDTO communicationDTO;
    private String emailAddress;
    private String officeNumber;
    private String homeNumber;
    /**
     * @return the partyName
     */
    public String getPartyName() {
        return partyName;
    }

    /**
     * @param partyName the partyName to set
     */
    public void setPartyName(String partyName) {
        this.partyName = partyName;
    }

    public CommunicationDTO getCommunicationDTO() {
        return communicationDTO;
    }

    public void setCommunicationDTO(CommunicationDTO communicationDTO) {
        this.communicationDTO = communicationDTO;
    }

    /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the partySiteId
     */
    public Long getPartySiteId() {
        return partySiteId;
    }

    /**
     * @param partySiteId the partySiteId to set
     */
    public void setPartySiteId(Long partySiteId) {
        this.partySiteId = partySiteId;
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
     * @return the locationType
     */
    public String getLocationType() {
        return locationType;
    }

    /**
     * @param locationType the locationType to set
     */
    public void setLocationType(String locationType) {
        this.locationType = locationType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}

	public String getOfficeNumber() {
		return officeNumber;
	}

	public void setHomeNumber(String homeNumber) {
		this.homeNumber = homeNumber;
	}

	public String getHomeNumber() {
		return homeNumber;
	}
}
