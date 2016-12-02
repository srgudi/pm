package com.chiguru.pm.tax.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.Person;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.ForceDiscriminator;

// Generated Dec 6, 2010 12:16:20 AM by Hibernate Tools 3.3.0.GA
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * TaxFirmPracticeType generated by hbm2java
 */
@Entity
@ForceDiscriminator
@Table(name = "task")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "filing_type", discriminatorType = DiscriminatorType.INTEGER)
//and taskinfo.dueDate between ? and ?  and taskinfo.dueDate between ? and ?
public class BaseTask extends PersistentEntity {
    //private Long id;
    protected ClientPracticeInfo clientPracticeInfo;
    private PracticeType practiceId;
    private Organization firm;
    private Person clientStaffInCharge;
    private Person staffInCharge;
    private Long partnerInCharge;
    private Party client;
    private Date dueDate;
    private TaskStatus status;
    private String taskNote;
    private Date actualCompletionDate;

//    private Long filingType;
    private DueDateRule taxInfoDueDateRule;
    private List<TaskNotification> taskNotificationList;
    private String filingTitle;
    
    public BaseTask() {
    }

    public BaseTask(ClientPracticeInfo clientPracticeInfo, Organization firm,
        TaskStatus status) {
        this.clientPracticeInfo = clientPracticeInfo;
        this.firm = firm;
        this.status = status;
    }

    /**
     * @return the practiceId
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partice_id", nullable = false)
    public PracticeType getPracticeId() {
        return practiceId;
    }

    /**
     * @param practiceId the practiceId to set
     */
    public void setPracticeId(PracticeType practiceId) {
        this.practiceId = practiceId;
    }

    /**
     * @return the filingTitle
     */
    @Column(name = "filing_title")
    public String getFilingTitle() {
        return filingTitle;
    }

    /**
     * @param filingTitle the filingTitle to set
     */
    public void setFilingTitle(String filingTitle) {
        this.filingTitle = filingTitle;
    }
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_staff_in_charge")
    public Person getClientStaffInCharge() {
        return this.clientStaffInCharge;
    }

    public void setClientStaffInCharge(Person clientStaffInCharge) {
        this.clientStaffInCharge = clientStaffInCharge;
    }

    /**
	 * @return the partnerInCharge
	 */
    
	
	
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "staff_in_charge", nullable = false)
    public Person getStaffInCharge() {
        return this.staffInCharge;
    }

    public void setStaffInCharge(Person staffInCharge) {
        this.staffInCharge = staffInCharge;
    }

    /**
     * @return the filingType
     */

    /*@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "filing_type", nullable = false)
    public TaxInfoFilingType getFilingType() {
            return filingType;
    }*/
    
    /**
     * @param filingType the filingType to set
     */

    /*public void setFilingType(TaxInfoFilingType filingType) {
            this.filingType = filingType;
    }*/
    
    @Temporal(TemporalType.DATE)
    @Column(name = "actual_completion_date", length = 10)
    public Date getActualCompletionDate() {
        return actualCompletionDate;
    }

    public void setActualCompletionDate(Date actualCompletionDate) {
        this.actualCompletionDate = actualCompletionDate;
    }

    /**
     * @return the taskNote
     */
    @Column(name = "task_note", length = 10)
    public String getTaskNote() {
        return taskNote;
    }

    /**
     * @param taskNote the taskNote to set
     */
    public void setTaskNote(String taskNote) {
        this.taskNote = taskNote;
    }

    /**
     * @return the taxClientPracticeType
     */

    /*@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "practice_client_info_id", nullable = false)
    public ClientPracticeInfo getTaxClientPracticeType() {
            return taxClientPracticeType;
    }
    /**
     * @param taxClientPracticeType the taxClientPracticeType to set
     */
    public void setClientPracticeInfo(ClientPracticeInfo clientPracticeInfo) {
        this.clientPracticeInfo = clientPracticeInfo;
    }

    /**
     * @return the organization
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "firm_id")
    public Organization getFirm() {
        return firm;
    }

    /**
     * @param organization the organization to set
     */
    public void setFirm(Organization firm) {
        this.firm = firm;
    }

    /**
     * @return the client
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false)
    public Party getClient() {
        return client;
    }

    /**
     * @param client the client to set
     */
    public void setClient(Party client) {
        this.client = client;
    }

    /**
     * @return the dueDate
     */
    @Temporal(TemporalType.DATE)
    @Column(name = "due_date", length = 10)
    public Date getDueDate() {
        return dueDate;
    }

    /**
     * @param dueDate the dueDate to set
     */
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    /**
     * @return the statusId
     */
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status", nullable = false)
    public TaskStatus getStatus() {
        return status;
    }

    /**
     * @param statusId the statusId to set
     */
    public void setStatus(TaskStatus status) {
        this.status = status;
    }

    public void setTaxInfoDueDateRule(DueDateRule taxInfoDueDateRule) {
        this.taxInfoDueDateRule = taxInfoDueDateRule;
    }

    /**
     * @return the parent date rule
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tax_info_date_rule_id")
    public DueDateRule getTaxInfoDueDateRule() {
        return taxInfoDueDateRule;
    }

    /**
     * @return the practiceId
     */
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "baseTask")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    public List<TaskNotification> getTaskNotificationList() {
        return taskNotificationList;
    }

    public void setTaskNotificationList(List<TaskNotification> notificationList) {
        this.taskNotificationList = notificationList;
    }

	/**
	 * @return the partnerInCharge
	 */
    @Column(name = "partner_in_charge")
	public Long getPartnerInCharge() {
		return partnerInCharge;
	}

	/**
	 * @param partnerInCharge the partnerInCharge to set
	 */
	public void setPartnerInCharge(Long partnerInCharge) {
		this.partnerInCharge = partnerInCharge;
	}

    
    /**
     * @return the practiceId
     */

    /*@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "practice_id", nullable = false)
    public PracticeType getPracticeId() {
            return practiceId;
    }
    
    /**
     * @param practiceId the practiceId to set
     */

    /*public void setPracticeId(PracticeType practiceId) {
            this.practiceId = practiceId;
    }*/
}