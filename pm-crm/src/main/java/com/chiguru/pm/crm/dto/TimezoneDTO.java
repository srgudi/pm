package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class TimezoneDTO implements Serializable {
    public Long id;
    private String globalTimezoneName;
   // private Integer gmtDeviationHours;
    private Float gmtDeviationHours;
    private Boolean dstFlag;
    private Short dstBeginMonth;
    private Short dstBeginDay;
    private Short dstBeginDayOfWeek;
    private Short dstBeginHour;
    private Short dstEndMonth;
    private Short dstEndDay;
    private Short dstEndDayOfWeek;
    private Short dstEndHour;
    private String dstStdCd;
    private String dstSavingsCd;
    private String status;
    private Boolean activeFlag;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGlobalTimezoneName() {
        return globalTimezoneName;
    }

    public void setGlobalTimezoneName(String globalTimezoneName) {
        this.globalTimezoneName = globalTimezoneName;
    }

  /*  public Integer getGmtDeviationHours() {
        return gmtDeviationHours;
    }

    public void setGmtDeviationHours(Integer gmtDeviationHours) {
        this.gmtDeviationHours = gmtDeviationHours;
    }*/

    public Boolean getDstFlag() {
        return dstFlag;
    }

    public void setDstFlag(Boolean dstFlag) {
        this.dstFlag = dstFlag;
    }

    public Short getDstBeginMonth() {
        return dstBeginMonth;
    }

    public void setDstBeginMonth(Short dstBeginMonth) {
        this.dstBeginMonth = dstBeginMonth;
    }

    public Short getDstBeginDay() {
        return dstBeginDay;
    }

    public void setDstBeginDay(Short dstBeginDay) {
        this.dstBeginDay = dstBeginDay;
    }

    public Short getDstBeginDayOfWeek() {
        return dstBeginDayOfWeek;
    }

    public void setDstBeginDayOfWeek(Short dstBeginDayOfWeek) {
        this.dstBeginDayOfWeek = dstBeginDayOfWeek;
    }

    public Short getDstBeginHour() {
        return dstBeginHour;
    }

    public void setDstBeginHour(Short dstBeginHour) {
        this.dstBeginHour = dstBeginHour;
    }

    public Short getDstEndMonth() {
        return dstEndMonth;
    }

    public void setDstEndMonth(Short dstEndMonth) {
        this.dstEndMonth = dstEndMonth;
    }

    public Short getDstEndDay() {
        return dstEndDay;
    }

    public void setDstEndDay(Short dstEndDay) {
        this.dstEndDay = dstEndDay;
    }

    public Short getDstEndDayOfWeek() {
        return dstEndDayOfWeek;
    }

    public void setDstEndDayOfWeek(Short dstEndDayOfWeek) {
        this.dstEndDayOfWeek = dstEndDayOfWeek;
    }

    public Short getDstEndHour() {
        return dstEndHour;
    }

    public void setDstEndHour(Short dstEndHour) {
        this.dstEndHour = dstEndHour;
    }

    public String getDstStdCd() {
        return dstStdCd;
    }

    public void setDstStdCd(String dstStdCd) {
        this.dstStdCd = dstStdCd;
    }

    public String getDstSavingsCd() {
        return dstSavingsCd;
    }

    public void setDstSavingsCd(String dstSavingsCd) {
        this.dstSavingsCd = dstSavingsCd;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	public Float getGmtDeviationHours() {
		return gmtDeviationHours;
	}

	public void setGmtDeviationHours(Float gmtDeviationHours) {
		this.gmtDeviationHours = gmtDeviationHours;
	}

	public void setGmtDeviationHours(Integer gmtDeviationHours2) {
		this.gmtDeviationHours = gmtDeviationHours;//This line is optional
	}

	public Boolean getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}

	/*public Float getGmtDeviationHours() {
		return gmtDeviationHours;
	}

	public void setGmtDeviationHours(Float gmtDeviationHours) {
		this.gmtDeviationHours = gmtDeviationHours;
	}*/
    
}
