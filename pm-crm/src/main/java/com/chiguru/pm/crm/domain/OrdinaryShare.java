package com.chiguru.pm.crm.domain;

import org.hibernate.annotations.Cascade;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;



@Entity
@DiscriminatorValue("1")
public class OrdinaryShare extends Share implements java.io.Serializable {

	private String contactDetail;
	
     @Column(name = "contact_detail", nullable = false, length = 50)
    public String getContactDetail() {
        return this.contactDetail;
    }

    public void setContactDetail(String contactDetail) {
        this.contactDetail = contactDetail;
    }
	
    public OrdinaryShare() {
        super();

        // TODO Auto-generated constructor stub
    }

    public OrdinaryShare(Long id) {
        super(id);

        // TODO Auto-generated constructor stub
    }

    public OrdinaryShare(PointOfContact pointOfContact) {
        super(pointOfContact);

        // TODO Auto-generated constructor stub
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contact_point_id", nullable = false)
   
    public PointOfContact getPointOfContact() {
        return this.pointOfContact;
    }
}
