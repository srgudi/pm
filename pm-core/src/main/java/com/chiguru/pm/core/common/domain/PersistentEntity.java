package com.chiguru.pm.core.common.domain;

import java.io.Serializable;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.Version;


@MappedSuperclass
public class PersistentEntity implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 4130141855300371497L;
    public Long id;
    public Boolean activeFlag = true;
    public Date createDate = new Date();
    public String createUserId;
    public String lastUpdateUserId;
    public Date lastUpdateDate;
    public Integer version = 0;
    public String entityKey;

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = (prime * result) + ((id == null) ? 0 : id.hashCode());

        return result;
    }

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null) {
            return false;
        }

        if (!(obj instanceof PersistentEntity)) {
            return false;
        }

        PersistentEntity other = (PersistentEntity) obj;

        if ((id == null) || (other.id == null)) {
            return false;
        } else if (!id.equals(other.id)) {
            return false;
        }

        return true;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
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

    @PrePersist
    public void onCreate() {
//        setCreateUserId("system");

        Date createDate = new Date();
        setCreateDate(createDate);
        setLastUpdateDate(createDate);
    }

    @PreUpdate
    public void onUpdate() {
        setLastUpdateDate(new Date());
    }

    @Transient
	public String getEntityKey() {
		return entityKey;
	}

	public void setEntityKey(String entityKey) {
		this.entityKey = entityKey;
	}
    
}
