package com.chiguru.pm.crm.dto;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CodeSearch {
	private Map<String, List> filterList = new HashMap();
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
	private int count;
    private int totalPages;	
    
    public Long id;
    public boolean applicationLevelId;
    private String shortName;
    private String longDescription;
    private Long codeTypeId;
    private String codeTypeName;
    private Integer sortOrder;
    private Long parentCodeId;
    private String parentCodeShortName;
    private String strApplicationLevelIndicator;
    private Boolean applicationLevelIndicator;
    private String status;
    private Boolean activeFlag;
    private BigInteger bigIntParentCodeId;
    public Long firmId;

    private String codeShortName;
    private boolean codeApplicationLevelIndicator;
    private String codeParentCodeShortName;
    private String codeCodeTypeName;
    private Long partyCodeId;
    private Long codeId;
    private Long partyId;
    private String partyName;
    
    
	public Long getPartyCodeId() {
		return partyCodeId;
	}
	public void setPartyCodeId(Long partyCodeId) {
		this.partyCodeId = partyCodeId;
	}
	public Long getCodeId() {
		return codeId;
	}
	public void setCodeId(Long codeId) {
		this.codeId = codeId;
	}
	public Long getPartyId() {
		return partyId;
	}
	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}
	public String getPartyName() {
		return partyName;
	}
	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}
	public boolean isCodeApplicationLevelIndicator() {
		return codeApplicationLevelIndicator;
	}
	public void setCodeApplicationLevelIndicator(
			boolean codeApplicationLevelIndicator) {
		this.codeApplicationLevelIndicator = codeApplicationLevelIndicator;
	}
	public String getCodeParentCodeShortName() {
		return codeParentCodeShortName;
	}
	public void setCodeParentCodeShortName(String codeParentCodeShortName) {
		this.codeParentCodeShortName = codeParentCodeShortName;
	}
	public String getCodeCodeTypeName() {
		return codeCodeTypeName;
	}
	public void setCodeCodeTypeName(String codeCodeTypeName) {
		this.codeCodeTypeName = codeCodeTypeName;
	}
	public String getCodeShortName() {
		return codeShortName;
	}
	public void setCodeShortName(String codeShortName) {
		this.codeShortName = codeShortName;
	}
	public Long getFirmId() {
		return firmId;
	}
	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}
	public boolean isApplicationLevelId() {
		return applicationLevelId;
	}
	public void setApplicationLevelId(boolean applicationLevelId) {
		this.applicationLevelId = applicationLevelId;
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
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getLongDescription() {
		return longDescription;
	}
	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}
	public Long getCodeTypeId() {
		return codeTypeId;
	}
	public void setCodeTypeId(Long codeTypeId) {
		this.codeTypeId = codeTypeId;
	}
	public String getCodeTypeName() {
		return codeTypeName;
	}
	public void setCodeTypeName(String codeTypeName) {
		this.codeTypeName = codeTypeName;
	}
	public Integer getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}
	public Long getParentCodeId() {
		return parentCodeId;
	}
	public void setParentCodeId(Long parentCodeId) {
		this.parentCodeId = parentCodeId;
	}
	public String getParentCodeShortName() {
		return parentCodeShortName;
	}
	public void setParentCodeShortName(String parentCodeShortName) {
		this.parentCodeShortName = parentCodeShortName;
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
	public BigInteger getBigIntParentCodeId() {
		return bigIntParentCodeId;
	}
	public void setBigIntParentCodeId(BigInteger bigIntParentCodeId) {
		this.bigIntParentCodeId = bigIntParentCodeId;
	}    
}
