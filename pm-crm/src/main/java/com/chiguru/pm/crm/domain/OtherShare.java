package com.chiguru.pm.crm.domain;

import org.hibernate.annotations.Cascade;


import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;



@Entity
@DiscriminatorValue("3")
public class OtherShare extends Share implements java.io.Serializable {
	
	//@NotNull
//	@NotEmpty
//	@Size(min = 0, max = 50)
//    @Pattern(regexp = "^(\\d{3}-\\d{3}-\\d{4})*$")
	private String contactDetail;
	
	@Column(name = "contact_detail", nullable = false, length = 50)
    public String getContactDetail() {
        return this.contactDetail;
    }

    public void setContactDetail(String contactDetail) {
        this.contactDetail = contactDetail;
    }
	
    public OtherShare() {
        super();

        // TODO Auto-generated constructor stub
    }

    public OtherShare(Long id) {
        super(id);

        // TODO Auto-generated constructor stub
    }

    public OtherShare(PointOfContact pointOfContact) {
        super(pointOfContact);

        // TODO Auto-generated constructor stub
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contact_point_id", nullable = false)
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE
    })
    public PointOfContact getPointOfContact() {
        return this.pointOfContact;
    }
}
