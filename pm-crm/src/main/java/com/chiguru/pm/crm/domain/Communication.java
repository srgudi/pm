package com.chiguru.pm.crm.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import org.hibernate.annotations.ForceDiscriminator;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

// Generated Feb 10, 2011 11:10:04 PM by Hibernate Tools 3.3.0.GA
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;


/**
 * Communication generated by hbm2java
 */
@Entity
@Table(name = "communication")
@ForceDiscriminator
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "communication_type", discriminatorType = DiscriminatorType.INTEGER)
public class Communication extends PersistentEntity implements java.io.Serializable {
    //private CommunicationType communicationType;
	
//	@NotNull
    protected PointOfContact pointOfContact;
    
//	@NotNull
//	@NotEmpty
//    private String contactDetail;
    private String bestTimeToContact;
    private Boolean preferredFlag;
    private Integer subType;

    //private String createUsrerId;
    public Communication() {
//        setCreateUserId("system");
//        setLastUpdateUserId("system");
    }

    public Communication(Long id) {
        this.id = id;
    }

    public Communication(PointOfContact pointOfContact) {
        this.pointOfContact = pointOfContact;
    }

    @Column(name = "sub_type")
    public Integer getSubType() {
        return subType;
    }

    public void setSubType(Integer subType) {
        this.subType = subType;
    }

    /*public Communication(CommunicationType commType) {
            this.communicationType = commType;
    }
    
    public Communication(CommunicationType communicationType, PointOfContact pointOfContact) {
            this.communicationType = communicationType;
            this.pointOfContact = pointOfContact;
    }
    */

    /*        @ManyToOne(fetch = FetchType.LAZY)
            @JoinColumn(name = "communication_type", nullable = false)
            public CommunicationType getCommunicationType() {
                    return this.communicationType;
            }
    
            public void setCommunicationType(CommunicationType communicationType) {
                    this.communicationType = communicationType;
            }
    */

    /*@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contact_point_id", nullable = false)
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    public PointOfContact getPointOfContact() {
            return this.pointOfContact;
    }*/
    public void setPointOfContact(PointOfContact pointOfContact) {
        this.pointOfContact = pointOfContact;
    }

    /*@Column(name = "contact_detail", nullable = false, length = 50)
    public String getContactDetail() {
        return this.contactDetail;
    }

    public void setContactDetail(String contactDetail) {
        this.contactDetail = contactDetail;
    }*/

    @Column(name = "best_time_to_contact", length = 50)
    public String getBestTimeToContact() {
        return this.bestTimeToContact;
    }

    public void setBestTimeToContact(String bestTimeToContact) {
        this.bestTimeToContact = bestTimeToContact;
    }

    @Column(name = "preferred_flag")
    public Boolean getPreferredFlag() {
        return this.preferredFlag;
    }

    public void setPreferredFlag(Boolean preferredFlag) {
        this.preferredFlag = preferredFlag;
    }
}
