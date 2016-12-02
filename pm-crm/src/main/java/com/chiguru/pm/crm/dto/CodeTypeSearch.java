package com.chiguru.pm.crm.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CodeTypeSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;
    
    private Long id;
    private String name;
    private String description;
    private Integer  parentCodeTypeId;
    private String parentCodeTypeName;
    private String strApplicationLevelIndicator;
    private Boolean applicationLevelIndicator;
    private String status;
    private Boolean activeFlag;
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
	public Integer getParentCodeTypeId() {
		return parentCodeTypeId;
	}
	public void setParentCodeTypeId(Integer parentCodeTypeId) {
		this.parentCodeTypeId = parentCodeTypeId;
	}
	public String getParentCodeTypeName() {
		return parentCodeTypeName;
	}
	public void setParentCodeTypeName(String parentCodeTypeName) {
		this.parentCodeTypeName = parentCodeTypeName;
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
}
