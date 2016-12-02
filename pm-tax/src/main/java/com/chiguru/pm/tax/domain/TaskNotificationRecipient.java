package com.chiguru.pm.tax.domain;


// Generated Dec 29, 2010 10:46:55 PM by Hibernate Tools 3.3.0.GA
import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.chiguru.pm.core.common.domain.PersistentEntity;


/**
 * TaxInfoFilingType generated by hbm2java
 */

@Entity
@Table(name = "task_notification_recipient")
@NamedQueries({@NamedQuery(name = "tasknotificationrecipient.findrecipient_by_template_id",query = "select id from TaskNotificationRecipient where id=?")
    , @NamedQuery(name = "tasknotificationrecipient.findrecipient_by_template_id_with_order",query = "select id from TaskNotificationRecipient taskinfo where taskinfo.notificationTemplateId.id =? order by taskinfo.recipient")
    , @NamedQuery(name = "tasknotificationrecipient.findrecipient_count_by_template_id",query = "select count(id) from TaskNotificationRecipient taskinfo where taskinfo.notificationTemplateId.id =?")
})
public class TaskNotificationRecipient implements java.io.Serializable {
	private Long id;
	
	@NotEmpty
    @Size(min = 0, max = 30)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$") 
//    @Pattern(regexp = "^[a-zA-Z.]*$",flags=Pattern.Flag.COMMENTS)
    private String recipient;   
	
	@NotNull
    private TaskNotificationTemplate notificationTemplateId;
    
	@NotEmpty
	@Size(min = 0, max = 300)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$") 
//    @Pattern(regexp = "^[a-zA-Z.]*$",flags=Pattern.Flag.COMMENTS)
    private String emailType;
    
    public Boolean activeFlag = true;
    public Date createDate = new Date();
    public String createUserId;
    public String lastUpdateUserId;
    public Date lastUpdateDate;
    public Integer version = 0;

    public TaskNotificationRecipient() {
    }

    public TaskNotificationRecipient(Long id) {
        this.id = id;       
    }

    public TaskNotificationRecipient(String recipient) {
        this.recipient = recipient;       
    }  

    

	/**
	 * @return the id
	 */
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "notification_type", unique = true, nullable = false)    
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the recipient
	 */
	@Column(name = "recipient", unique = true, nullable = false)
	public String getRecipient() {
		return recipient;
	}

	/**
	 * @param recipient the recipient to set
	 */
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	/**
	 * @return the notificationTemplateId
	 */
	@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "template_id", nullable = false)
	public TaskNotificationTemplate getNotificationTemplateId() {
		return notificationTemplateId;
	}

	/**
	 * @param notificationTemplateId the notificationTemplateId to set
	 */
	public void setNotificationTemplateId(TaskNotificationTemplate notificationTemplateId) {
		this.notificationTemplateId = notificationTemplateId;
	}

	
	/**
	 * @return the emailType
	 */
	@Column(name = "email_type", unique = true, nullable = false)
	public String getEmailType() {
		return emailType;
	}

	/**
	 * @param emailType the emailType to set
	 */
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}

	@Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null) {
            return false;
        }

        if (!(obj instanceof TaskNotificationRecipient)) {
            return false;
        }

        TaskNotificationRecipient other = (TaskNotificationRecipient) obj;

        return getId().equals(other.getId());
    }
	
	@Column(name = "active_flag", nullable = false)
    public boolean isActiveFlag() {
        if (activeFlag == null) {
            return false;
        } else {
            return this.activeFlag;
        }
    }

    public void setActiveFlag(Boolean activeFlag) {
        this.activeFlag = activeFlag;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date", length = 19)
    public Date getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Column(name = "create_user_id", nullable = false, length = 25)
    public String getCreateUserId() {
        return this.createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    @Column(name = "last_update_user_id", length = 30)
    public String getLastUpdateUserId() {
        return this.lastUpdateUserId;
    }

    public void setLastUpdateUserId(String lastUpdateUserId) {
        this.lastUpdateUserId = lastUpdateUserId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_update_date", length = 19)
    public Date getLastUpdateDate() {
        return this.lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    @Version
    @Column(name = "version", nullable = false)
    public Integer getVersion() {
        return (this.version != null) ? this.version : 0;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
}