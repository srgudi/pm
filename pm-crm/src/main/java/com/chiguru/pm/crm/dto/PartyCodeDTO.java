package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class PartyCodeDTO implements Serializable {
    private Long id;
    private Long partyCodeId;
    private Long codeId;
    private String codeShortName;
    private boolean codeApplicationLevelIndicator;
    private String codeParentCodeShortName;
    private String codeCodeTypeName;
    private Long partyId;
    private String partyName;
    private Integer sortOrder;
    private String status;
    private Boolean activeFlag;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPartyCodeId() {
        return partyCodeId;
    }

    public void setPartyCodeId(Long partyCodeId) {
        this.partyCodeId = partyCodeId;
    }

    public Long getCodeId() {
        return codeId;
    }

    public void setCodeId(Long codeId) {
        this.codeId = codeId;
    }

    public String getCodeShortName() {
        return codeShortName;
    }

    public void setCodeShortName(String codeShortName) {
        this.codeShortName = codeShortName;
    }

    public boolean isCodeApplicationLevelIndicator() {
        return codeApplicationLevelIndicator;
    }

    public void setCodeApplicationLevelIndicator(
        boolean codeApplicationLevelIndicator) {
        this.codeApplicationLevelIndicator = codeApplicationLevelIndicator;
    }

    public String getCodeParentCodeShortName() {
        return codeParentCodeShortName;
    }

    public void setCodeParentCodeShortName(String codeParentCodeShortName) {
        this.codeParentCodeShortName = codeParentCodeShortName;
    }

    public String getCodeCodeTypeName() {
        return codeCodeTypeName;
    }

    public void setCodeCodeTypeName(String codeCodeTypeName) {
        this.codeCodeTypeName = codeCodeTypeName;
    }

    public Long getPartyId() {
        return partyId;
    }

    public void setPartyId(Long partyId) {
        this.partyId = partyId;
    }

    public String getPartyName() {
        return partyName;
    }

    public void setPartyName(String partyName) {
        this.partyName = partyName;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
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
