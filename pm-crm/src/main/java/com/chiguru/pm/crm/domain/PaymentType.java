package com.chiguru.pm.crm.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.chiguru.pm.core.common.domain.ReadOnlyEntity;

@Entity
@Table(name = "payment_type")
public class PaymentType extends ReadOnlyEntity implements java.io.Serializable{
	public static PaymentType PAYMENT_TYPE_CHEQUE = new PaymentType(1);
	public static PaymentType PAYMENT_TYPE_EFILING = new PaymentType(2);
	public static PaymentType PAYMENT_TYPE_CASH = new PaymentType(3);
	private String type;
	
	public PaymentType(){
		
	}

	public PaymentType(Integer id) {
        this.id = id;
        if (id == 1) {
            this.type = "Cheque";
        } else if(id == 2) {
            this.type = "E-Filing";
        }else if(id == 3){
        	this.type = "Cash";
        }
    }
	
	public PaymentType(Integer id, String type) {
		this.id = id;
		this.type = type;
	}
	 
	@Column(name = "type", nullable = false, length = 20)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
