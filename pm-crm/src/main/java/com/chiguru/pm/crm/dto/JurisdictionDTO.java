package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class JurisdictionDTO implements Serializable {
    public Long id;
    private String country;
    private String state;
    private String county;
    private String city;
    private String status;
    private String globalTimezoneName;
  // private Integer gmtDeviationHours;
    private Float gmtDeviationHours;
    private Boolean activeFlag;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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


	public void setGmtDeviationHours(Integer gmtDeviationHours2) {
		// TODO Auto-generated method stub
		
	}

	public Boolean getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(Boolean activeFlag) {
		this.activeFlag = activeFlag;
	}

/*	public Float getGmtDeviationHours() {
		return gmtDeviationHours;
	}

	public void setGmtDeviationHours(Float gmtDeviationHours) {
		this.gmtDeviationHours = gmtDeviationHours;
	}*/

   /* public Integer getGmtDeviationHours() {
        return gmtDeviationHours;
    }

    public void setGmtDeviationHours(Integer gmtDeviationHours) {
        this.gmtDeviationHours = gmtDeviationHours;
    }*/
}
