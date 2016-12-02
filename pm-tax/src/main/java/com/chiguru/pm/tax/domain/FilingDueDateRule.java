package com.chiguru.pm.tax.domain;


// Generated Dec 29, 2010 10:46:55 PM by Hibernate Tools 3.3.0.GA
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;


/**
 * TaxInfoDueDateRule generated by hbm2java
 */
@Entity
@DiscriminatorValue("1")
/**
 * This uses Single Table per Class Hierarchy Inheritance, so no attributes are there
 */
public class FilingDueDateRule extends DueDateRule implements java.io.Serializable {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "practice_info_id", nullable = false)
    public ClientPracticeInfo getClientPracticeInfo() {
        return this.clientPracticeInfo;
    }
}
