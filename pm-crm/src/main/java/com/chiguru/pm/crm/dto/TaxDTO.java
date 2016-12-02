package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class TaxDTO implements Serializable {
    //	private Long partyId;
    private Long taxId;
    private Long firmPracticeID;
    private String name;
    private String description;
    private String status;
    private Boolean activeFlag = true;
    //	public Long getPartyId() {
    //		return partyId;
    //	}
    //	public void setPartyId(Long partyId) {
    //		this.partyId = partyId;
    //	}
    
    public String getName() {
        return name;
    }

    public Boolean getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}

	public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getTaxId() {
        return taxId;
    }

    public void setTaxId(Long taxId) {
        this.taxId = taxId;
    }

    public Long getFirmPracticeID() {
        return firmPracticeID;
    }

    public void setFirmPracticeID(Long firmPracticeID) {
        this.firmPracticeID = firmPracticeID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
