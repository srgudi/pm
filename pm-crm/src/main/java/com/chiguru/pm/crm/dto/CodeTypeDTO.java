package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class CodeTypeDTO implements Serializable {

    private Long id;
    private String name;
    private String description;
 //   private Long parentCodeTypeId;
    private Integer  parentCodeTypeId;
    private String parentCodeTypeName;
    private String strApplicationLevelIndicator;
    private Boolean applicationLevelIndicator;
    private String status;
    private Boolean activeFlag;

    public Long getId() {
            return id;
    }
    public void setId(Long id) {
            this.id = id;
    }
    public String getName() {
        return name;
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

   /* public Long getParentCodeTypeId() {
        return parentCodeTypeId;
    }

    public void setParentCodeTypeId(Long parentCodeTypeId) {
        this.parentCodeTypeId = parentCodeTypeId;
    }*/

    public String getParentCodeTypeName() {
        return parentCodeTypeName;
    }

    public void setParentCodeTypeName(String parentCodeTypeName) {
        this.parentCodeTypeName = parentCodeTypeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
	public Boolean getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
	public Integer getParentCodeTypeId() {
		return parentCodeTypeId;
	}
	public void setParentCodeTypeId(Integer parentCodeTypeId) {
		this.parentCodeTypeId = parentCodeTypeId;
	}
	public void setParentCodeTypeId(Long id2) {
		// TODO Auto-generated method stub
		
	}
	
}
