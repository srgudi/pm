package com.chiguru.pm.crm.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ClientPracInfoDTO {
	private static final long serialVersionUID = 1L;
	private Long clientPracticeInfoId;
    private String clientName;
    private String jurisdictionName;
    private String juriCountry;
    private String juriState;
    private String staffInChargeName;
    private String clientStaffInChargeName;
    private String status;
    private String practiceName;
    private String taskCreator;
    private Date taskCreatedDate;
    private String formatedtaskCreatedDate;
    SimpleDateFormat sd = new SimpleDateFormat("MM/dd/yyyy");
    private String taxReturn;
    public Boolean activeFlag = true;

    public Long getClientPracticeInfoId() {
        return clientPracticeInfoId;
    }

    public void setClientPracticeInfoId(Long clientPracticeInfoId) {
        this.clientPracticeInfoId = clientPracticeInfoId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public String getJurisdictionName() {
        return jurisdictionName;
    }

    public void setJurisdictionName(String jurisdictionName) {
        this.jurisdictionName = jurisdictionName;
    }

    public String getJuriCountry() {
		return juriCountry;
	}

	public void setJuriCountry(String juriCountry) {
		this.juriCountry = juriCountry;
	}

	public String getJuriState() {
		return juriState;
	}

	public void setJuriState(String juriState) {
		this.juriState = juriState;
	}

	public String getStaffInChargeName() {
        return staffInChargeName;
    }

    public void setStaffInChargeName(String staffInChargeName) {
        this.staffInChargeName = staffInChargeName;
    }

    public String getClientStaffInChargeName() {
        return clientStaffInChargeName;
    }

    public void setClientStaffInChargeName(String clientStaffInChargeName) {
        this.clientStaffInChargeName = clientStaffInChargeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPracticeName() {
        return practiceName;
    }

    public void setPracticeName(String practiceName) {
        this.practiceName = practiceName;
    }

	public void setTaskCreator(String taskCreator) {
		this.taskCreator = taskCreator;
	}

	public String getTaskCreator() {
		return taskCreator;
	}

	public void setTaskCreatedDate(Date taskCreatedDate) {
		this.taskCreatedDate = taskCreatedDate;
	}

	public Date getTaskCreatedDate() {
		return taskCreatedDate;
	}
	
	public void setFormatedtaskCreatedDate(String formatedtaskCreatedDate) {
		  this.formatedtaskCreatedDate = formatedtaskCreatedDate;
		 }

    public String getFormatedtaskCreatedDate() {
		  if(formatedtaskCreatedDate == null && taskCreatedDate != null){
		   formatedtaskCreatedDate = sd.format(taskCreatedDate);
		  }
		  return formatedtaskCreatedDate;
		}

	public void setTaxReturn(String taxReturn) {
		this.taxReturn = taxReturn;
	}

	public String getTaxReturn() {
		return taxReturn;
	}

	public Boolean getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}

}
