package com.chiguru.pm.crm.dto;

/**
 * @author Apoorva
 *
 */
public class PaymentDetails {

	private String paymentType;
	private Long clientId;
	private String cheqOrAcknowledgementNumber;
	private Integer ammountPaid;
	private String Taxtype;
	
	
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public Long getClientId() {
		return clientId;
	}
	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	public String getCheqOrAcknowledgementNumber() {
		return cheqOrAcknowledgementNumber;
	}
	public void setCheqOrAcknowledgementNumber(
			String cheqOrAcknowledgementNumber) {
		this.cheqOrAcknowledgementNumber = cheqOrAcknowledgementNumber;
	}
	public Integer getAmmountPaid() {
		return ammountPaid;
	}
	public void setAmmountPaid(Integer ammountPaid) {
		this.ammountPaid = ammountPaid;
	}
	public String getTaxtype() {
		return Taxtype;
	}
	public void setTaxtype(String taxtype) {
		Taxtype = taxtype;
	}
	
	

}
