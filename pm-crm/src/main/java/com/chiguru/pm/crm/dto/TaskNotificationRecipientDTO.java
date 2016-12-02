package com.chiguru.pm.crm.dto;

import java.io.Serializable;

public class TaskNotificationRecipientDTO implements Serializable{
	private Long id;
    private String recipient;   
    private String typeOfNotificationTemplate;
    private String emailType;
    private String status;
    private Boolean activeFlag;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getTypeOfNotificationTemplate() {
		return typeOfNotificationTemplate;
	}
	public void setTypeOfNotificationTemplate(String typeOfNotificationTemplate) {
		this.typeOfNotificationTemplate = typeOfNotificationTemplate;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
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
