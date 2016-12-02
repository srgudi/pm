package com.chiguru.pm.crm.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaxSearch {

	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
    
    private Long clientPracticeInfoId;
    private String clientName;
    private String jurisdictionName;
    private String staffInChargeName;
    private String clientStaffInChargeName;
    private String taxReturn;
    private String taskCreator;
    private String formatedtaskCreatedDate;
    private Date taskCreatedDate;
    private Long clientId;
    
    private String name;
    private String description;
    private Long firmId;
    private String status;
    
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
	public String getTaxReturn() {
		return taxReturn;
	}
	public void setTaxReturn(String taxReturn) {
		this.taxReturn = taxReturn;
	}
	public String getTaskCreator() {
		return taskCreator;
	}
	public void setTaskCreator(String taskCreator) {
		this.taskCreator = taskCreator;
	}
	public String getFormatedtaskCreatedDate() {
		return formatedtaskCreatedDate;
	}
	public void setFormatedtaskCreatedDate(String formatedtaskCreatedDate) {
		this.formatedtaskCreatedDate = formatedtaskCreatedDate;
	}
	public Long getClientId() {
		return clientId;
	}
	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	public Date getTaskCreatedDate() {
		return taskCreatedDate;
	}
	public void setTaskCreatedDate(Date taskCreatedDate) {
		this.taskCreatedDate = taskCreatedDate;
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
	public Long getFirmId() {
		return firmId;
	}
	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
