package com.chiguru.pm.crm.dto;

public class Page {
    private Long firmId;
    private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int start;
    private int count;
    private int totalPages;
    private String filters;

    public Page(Long firmId, int page, int limit, String sortName,
        String sortType, String filters) {
        this.firmId = firmId;
        this.currentPage = page;
        this.limit = limit;
        this.sortName = sortName;
        this.sortType = sortType;
        this.filters = filters;
    }

    /**
     * @return the totalPages
     */
    public int getTotalPages() {
        return totalPages;
    }

    /**
     * @param totalPages the totalPages to set
     */
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    /**
     * @return the start
     */
    public int getStart() {
        return start;
    }

    /**
     * @param start the start to set
     */
    public void setStart(int start) {
        this.start = start;
    }

    /**
     * @return the count
     */
    public int getCount() {
        return count;
    }

    /**
     * @param count the count to set
     */
    public void setCount(int count) {
        this.count = count;
    }

    /**
     * @return the firmId
     */
    public Long getFirmId() {
        return firmId;
    }

    /**
     * @param firmId the firmId to set
     */
    public void setFirmId(Long firmId) {
        this.firmId = firmId;
    }

    /**
     * @return the page
     */
    public int getCurrentPage() {
        return currentPage;
    }

    /**
     * @param page the page to set
     */
    public void setCurrentPage(int page) {
        this.currentPage = page;
    }

    /**
     * @return the limit
     */
    public int getLimit() {
        return limit;
    }

    /**
     * @param limit the limit to set
     */
    public void setLimit(int limit) {
        this.limit = limit;
    }

    /**
     * @return the sortType
     */
    public String getSortType() {
        return sortType;
    }

    /**
     * @param sortType the sortType to set
     */
    public void setSortType(String sortType) {
        this.sortType = sortType;
    }

    /**
     * @return the sortName
     */
    public String getSortName() {
        return sortName;
    }

    /**
     * @param sortName the sortName to set
     */
    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

	public String getFilters() {
		return filters;
	}

	public void setFilters(String filters) {
		this.filters = filters;
	}
}
