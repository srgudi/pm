package com.chiguru.pm.crm.dto;

import java.io.Serializable;
import java.math.BigInteger;


public class CodeDTO implements Serializable {
	
    public Long id;
    private String shortName;
    private String longDescription;
    private Long codeTypeId;
    private String codeTypeName;
    private Integer sortOrder;
    private Long parentCodeId;
    private String parentCodeShortName;
    private String strApplicationLevelIndicator;
    private Boolean applicationLevelIndicator;
    private String status;
    private Boolean activeFlag;
    private BigInteger bigIntParentCodeId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getLongDescription() {
        return longDescription;
    }

    public void setLongDescription(String longDescription) {
        this.longDescription = longDescription;
    }

    public Long getCodeTypeId() {
        return codeTypeId;
    }

    public void setCodeTypeId(Long codeTypeId) {
        this.codeTypeId = codeTypeId;
    }

    public String getCodeTypeName() {
        return codeTypeName;
    }

    public void setCodeTypeName(String codeTypeName) {
        this.codeTypeName = codeTypeName;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Long getParentCodeId() {
        return parentCodeId;
    }

    public void setParentCodeId(Long parentCodeId) {
        this.parentCodeId = parentCodeId;
    }

    public String getParentCodeShortName() {
        return parentCodeShortName;
    }

    public void setParentCodeShortName(String parentCodeShortName) {
        this.parentCodeShortName = parentCodeShortName;
    }

	public String getStrApplicationLevelIndicator() {
		return strApplicationLevelIndicator;
	}

	public void setStrApplicationLevelIndicator(String strApplicationLevelIndicator) {
		this.strApplicationLevelIndicator = strApplicationLevelIndicator;
	}

	public Boolean getApplicationLevelIndicator() {
		return applicationLevelIndicator;
	}

	public void setApplicationLevelIndicator(Boolean applicationLevelIndicator) {
		this.applicationLevelIndicator = applicationLevelIndicator;
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

	public BigInteger getBigIntParentCodeId() {
		return bigIntParentCodeId;
	}

	public void setBigIntParentCodeId(BigInteger bigIntParentCodeId) {
		this.bigIntParentCodeId = bigIntParentCodeId;
	}

}
