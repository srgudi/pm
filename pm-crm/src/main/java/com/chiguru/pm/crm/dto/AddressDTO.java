package com.chiguru.pm.crm.dto;

import java.io.Serializable;

public class AddressDTO implements Serializable {
	private String addressLine;
	private String city;
	//private String state;
	//private Long country;
	private String postalCode;
	//private String firmName;
	private Long party;
	
	/*public String getFirmName() {
		return firmName;
	}
	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}*/
	
	public String getAddressLine() {
		return addressLine;
	}
	public Long getParty() {
		return party;
	}
	public void setParty(Long party) {
		this.party = party;
	}
	public void setAddressLine(String addressLine) {
		this.addressLine = addressLine;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
/*	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}*/
	
/*	public Long getCountry() {
		return country;
	}
	public void setCountry(Long country) {
		this.country = country;
	}*/
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
}
