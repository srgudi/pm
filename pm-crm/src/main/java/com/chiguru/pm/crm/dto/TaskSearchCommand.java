package com.chiguru.pm.crm.dto;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.KeyValue;

public class TaskSearchCommand {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
    
    private Long id;
    private Long taskId;
    private String clientName;
    private String practiceType; 
    private Date dueDate;
    private String filingType;
    private Short filingTypeFromDB;
    private String formattedDueDate;
    SimpleDateFormat sd = new SimpleDateFormat("MM/dd/yyyy");
    private String assignedTo;
    private String clientStaffInCharge;
    private String partnerInCharge;
    private String taskType;
    private String status;
    private Long mainPartyId;
    private boolean activeFlag;
    private  Integer completeStatus;
    private String userRole;
    
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public boolean isActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
	public Map<String, List> getFilterList() {
		return filterList;
	}
	public void setFilterList(Map<String, List> filterList) {
		this.filterList = filterList;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public Long getTaskId() {
		return taskId;
	}
	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getPracticeType() {
		return practiceType;
	}
	public void setPracticeType(String practiceType) {
		this.practiceType = practiceType;
	}
	public Date getDueDate() {
		return dueDate;
	}
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public String getFilingType() {
		return filingType;
	}
	public void setFilingType(String filingType) {
		this.filingType = filingType;
	}
	public Short getFilingTypeFromDB() {
		return filingTypeFromDB;
	}
	public void setFilingTypeFromDB(Short filingTypeFromDB) {
		this.filingTypeFromDB = filingTypeFromDB;
	}
	public String getFormattedDueDate() {
		return formattedDueDate;
	}
	public void setFormattedDueDate(String formattedDueDate) {
		this.formattedDueDate = formattedDueDate;
	}
	public SimpleDateFormat getSd() {
		return sd;
	}
	public void setSd(SimpleDateFormat sd) {
		this.sd = sd;
	}
	public String getAssignedTo() {
		return assignedTo;
	}
	public void setAssignedTo(String assignedTo) {
		this.assignedTo = assignedTo;
	}
	public String getClientStaffInCharge() {
		return clientStaffInCharge;
	}
	public void setClientStaffInCharge(String clientStaffInCharge) {
		this.clientStaffInCharge = clientStaffInCharge;
	}
	public String getPartnerInCharge() {
		return partnerInCharge;
	}
	public void setPartnerInCharge(String partnerInCharge) {
		this.partnerInCharge = partnerInCharge;
	}
	public String getTaskType() {
		return taskType;
	}
	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getMainPartyId() {
		return mainPartyId;
	}
	public void setMainPartyId(Long mainPartyId) {
		this.mainPartyId = mainPartyId;
	}
	public Integer getCompleteStatus() {
		return completeStatus;
	}
	public void setCompleteStatus(Integer completeStatus) {
		this.completeStatus = completeStatus;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
    
    
}
