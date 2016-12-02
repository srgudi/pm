package com.chiguru.pm.crm.domain;

import com.chiguru.pm.core.common.domain.ReadOnlyEntity;

// Generated Jun 9, 2010 9:02:16 PM by Hibernate Tools 3.3.0.GA
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


/**
 * PartyType generated by hbm2java
 */
@Entity
@Table(name = "communication_type")
public class CommunicationType extends ReadOnlyEntity implements Serializable {
    public static int EMAIL_COMMUNICATION_TYPE = 1;
    public static int FAX_COMMUNICATION_TYPE = 2;
    public static int WEB_COMMUNICATION_TYPE = 7;
    public static int PHONE_COMMUNICATION_TYPE = 3;
    private Boolean phoneIndicator;
    private String name;
    private String description;

    public CommunicationType() {
    }

    public CommunicationType(Integer id) {
        this.id = id;
    }

    public CommunicationType(Integer id, Boolean phoneIndicator, String name) {
        this.id = id;
        this.phoneIndicator = phoneIndicator;
        this.name = name;
    }

    /**
     * @return the name
     */
    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the description
     */
    @Column(name = "description", length = 100)
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the phoneIndicator
     */
    @Column(name = "phone_indicator")
    public Boolean getPhoneIndicator() {
        return phoneIndicator;
    }

    /**
     * @param phoneIndicator the phoneIndicator to set
     */
    public void setPhoneIndicator(Boolean phoneIndicator) {
        this.phoneIndicator = phoneIndicator;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null) {
            return false;
        }

        if (!(obj instanceof CommunicationType)) {
            return false;
        }

        CommunicationType other = (CommunicationType) obj;

        if (getId().intValue() != other.getId().intValue()) {
            return false;
        }

        return true;
    }
}
