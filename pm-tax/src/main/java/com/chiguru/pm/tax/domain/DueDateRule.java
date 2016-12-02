package com.chiguru.pm.tax.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import org.hibernate.annotations.ForceDiscriminator;

// Generated Dec 29, 2010 10:46:55 PM by Hibernate Tools 3.3.0.GA
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * TaxInfoDueDateRule generated by hbm2java
 */
@Entity
@ForceDiscriminator
@Table(name = "tax_info_due_date_rule")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "filing_type", discriminatorType = DiscriminatorType.INTEGER)
@NamedQueries({@NamedQuery(name = "dueDateRule.checkForNewEventGeneration",query = "from DueDateRule where generatedTaskDate is null")
})
public class DueDateRule extends PersistentEntity implements java.io.Serializable {
    //private Long id;
    protected ClientPracticeInfo clientPracticeInfo;
    protected Integer dueDay;
    protected Integer dueMonth;
    private String schedulingRule;

    //private TaxInfoFilingType taxInfoFilingType;
    private Date generatedTaskDate;

    /*@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "practice_info_id", nullable = false)
    public ClientPracticeInfo getClientPracticeInfo() {
            return this.clientPracticeInfo;
    }
    */
    public void setClientPracticeInfo(ClientPracticeInfo clientPracticeInfo) {
        this.clientPracticeInfo = clientPracticeInfo;
    }

    @Column(name = "due_day")
    public Integer getDueDay() {
        return this.dueDay;
    }

    public void setDueDay(Integer dueDay) {
        this.dueDay = dueDay;
    }

    @Column(name = "due_month")
    public Integer getDueMonth() {
        return this.dueMonth;
    }

    public void setDueMonth(Integer dueMonth) {
        this.dueMonth = dueMonth;
    }

    @Column(name = "scheduling_rule", length = 50)
    public String getSchedulingRule() {
        return this.schedulingRule;
    }

    public void setSchedulingRule(String schedulingRule) {
        this.schedulingRule = schedulingRule;
    }

    /*        @ManyToOne(fetch = FetchType.LAZY)
            @JoinColumn(name = "filing_type")
            public TaxInfoFilingType getTaxInfoFilingType() {
                    return taxInfoFilingType;
            }
    
            public void setTaxInfoFilingType(TaxInfoFilingType taxInfoFilingType) {
                    this.taxInfoFilingType = taxInfoFilingType;
            }*/
    public void setGeneratedTaskDate(Date generatedTaskDate) {
        this.generatedTaskDate = generatedTaskDate;
    }

    @Column(name = "generated_task_date")
    public Date getGeneratedTaskDate() {
        return this.generatedTaskDate;
    }
}