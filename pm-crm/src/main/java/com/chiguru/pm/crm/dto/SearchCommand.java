package com.chiguru.pm.crm.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SearchCommand {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;
    
    private Long partId;
    private String clientName;
    private String eMail;
    private String inChargePerson;
    private String officeNumber;
    private Long mainPartyId;
    private Integer relationshipTypeId;
    private boolean activeFlag;
    
    private String opClinetName;
    
    public String getOpClinetName() {
		return opClinetName;
	}
	public void setOpClinetName(String opClinetName) {
		this.opClinetName = opClinetName;
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
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	public Long getMainPartyId() {
		return mainPartyId;
	}
	public void setMainPartyId(Long mainPartyId) {
		this.mainPartyId = mainPartyId;
	}
	public Integer getRelationshipTypeId() {
		return relationshipTypeId;
	}
	public void setRelationshipTypeId(Integer relationshipTypeId) {
		this.relationshipTypeId = relationshipTypeId;
	}
	public boolean isActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
	public Long getPartId() {
		return partId;
	}
	public void setPartId(Long partId) {
		this.partId = partId;
	}
	public String getInChargePerson() {
		return inChargePerson;
	}
	public void setInChargePerson(String inChargePerson) {
		this.inChargePerson = inChargePerson;
	}
	public String getOfficeNumber() {
		return officeNumber;
	}
	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}
	public Map<String, List> getFilterList() {
		return filterList;
	}
	public void setFilterList(Map<String, List> filterList) {
		this.filterList = filterList;
	}
	
}
