package com.chiguru.pm.crm.dto;

import java.util.Date;


public class BaseTaskDTO{
	
	private Long id;
	private Long staffId;
	private Long clientStaffId;
	private Long customerId;
	private Long partnerId;
	private Long firmId;
	private String practiceId;
	private Date dueDate;
	private String filingTitle;
	private String newStatus;
	
	
	
	public void setId(Long id) {
		this.id = id;
	}
	public Long getId() {
		return id;
	}
	public void setStaffId(Long staffId) {
		this.staffId = staffId;
	}
	public Long getStaffId() {
		return staffId;
	}
	public void setClientStaffId(Long clientStaffId) {
		this.clientStaffId = clientStaffId;
	}
	public Long getClientStaffId() {
		return clientStaffId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public Long getCustomerId() {
		return customerId;
	}
	public void setPartnerId(Long partnerId) {
		this.partnerId = partnerId;
	}
	public Long getPartnerId() {
		return partnerId;
	}
	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}
	public Long getFirmId() {
		return firmId;
	}
	public void setPracticeId(String practiceId) {
		this.practiceId = practiceId;
	}
	public String getPracticeId() {
		return practiceId;
	}
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public Date getDueDate() {
		return dueDate;
	}
	public void setFilingTitle(String filingTitle) {
		this.filingTitle = filingTitle;
	}
	public String getFilingTitle() {
		return filingTitle;
	}
	public void setNewStatus(String newStatus) {
		this.newStatus = newStatus;
	}
	public String getNewStatus() {
		return newStatus;
	}
	
	
	
	
}