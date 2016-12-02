package com.chiguru.pm.crm.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JurisdictionSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;
    
    private String country;
    private String state;
    private String city;
    private String globalTimezoneName;
    private Float gmtDeviationHours;
    private String status;
    
    
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGlobalTimezoneName() {
		return globalTimezoneName;
	}
	public void setGlobalTimezoneName(String globalTimezoneName) {
		this.globalTimezoneName = globalTimezoneName;
	}
	public Float getGmtDeviationHours() {
		return gmtDeviationHours;
	}
	public void setGmtDeviationHours(Float gmtDeviationHours) {
		this.gmtDeviationHours = gmtDeviationHours;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
