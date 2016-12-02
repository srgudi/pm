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
public class EmailCommunication extends Communication implements java.io.Serializable {
	
//  @NotNull
//	@NotEmpty
//	@Size(min = 0, max = 50)
//  @Pattern(regexp = "^[a-zA-Z0-9_.-]*@[a-zA-Z]*.[a-zA-Z]*$")
//	@Email
	private String contactDetail;
	
     @Column(name = "contact_detail", nullable = false, length = 50)
    public String getContactDetail() {
        return this.contactDetail;
    }

    public void setContactDetail(String contactDetail) {
        this.contactDetail = contactDetail;
    }
	
    public EmailCommunication() {
        super();

        // TODO Auto-generated constructor stub
    }

    public EmailCommunication(Long id) {
        super(id);

        // TODO Auto-generated constructor stub
    }

    public EmailCommunication(PointOfContact pointOfContact) {
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
