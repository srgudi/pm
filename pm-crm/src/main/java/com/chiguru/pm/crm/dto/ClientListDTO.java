package com.chiguru.pm.crm.dto;

import java.io.Serializable;

public class ClientListDTO implements Serializable {
	
	private Integer slNo;
	private String name;
	private String addressType;
	private String address1;
	private String address2;
	private String city;
	private String state;
	private String country;
	private String postalCode;
	private String compadd;
	private String compdetail;
	
	public void setSlNo(Integer slNo) {
		this.slNo = slNo;
	}
	public Integer getSlNo() {
		return slNo;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}
	public String getAddressType() {
		return addressType;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress2() {
		return address2;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCity() {
		return city;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getState() {
		return state;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCountry() {
		return country;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setCompadd(String compadd) {
		this.compadd = compadd;
	}
	public String getCompadd() {
		return compadd;
	}
	public void setCompdetail(String compdetail) {
		this.compdetail = compdetail;
	}
	public String getCompdetail() {
		return compdetail;
	}
	 
	
}