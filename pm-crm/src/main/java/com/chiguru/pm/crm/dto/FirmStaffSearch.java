package com.chiguru.pm.crm.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FirmStaffSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
	
    private String name;
    private String jobTitle;
    private String role;
    private String relationshipType;
    private String emailAddress;
    private String status;
    private Boolean activeFlag;
    private Integer staffTypeId;
    private Integer partnerTypeId;
    private Long firmId;
    
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getRelationshipType() {
		return relationshipType;
	}
	public void setRelationshipType(String relationshipType) {
		this.relationshipType = relationshipType;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
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
	public Integer getStaffTypeId() {
		return staffTypeId;
	}
	public void setStaffTypeId(Integer staffTypeId) {
		this.staffTypeId = staffTypeId;
	}
	public Integer getPartnerTypeId() {
		return partnerTypeId;
	}
	public void setPartnerTypeId(Integer partnerTypeId) {
		this.partnerTypeId = partnerTypeId;
	}
	public Long getFirmId() {
		return firmId;
	}
	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}
	
}
