package com.chiguru.pm.crm.domain;

import org.hibernate.annotations.Cascade;
import org.hibernate.validator.constraints.NotEmpty;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;

// Generated Jun 9, 2010 9:02:16 PM by Hibernate Tools 3.3.0.GA
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


/**
 * CodeType generated by hbm2java
 */
@Entity
@Table(name = "code_type")
public class CodeType extends PersistentEntity implements java.io.Serializable {
    public static CodeType COUNTRY_CODE_TYPE = new CodeType((long) 1);
    public static CodeType STATE_CODE_TYPE = new CodeType((long) 2);
    public static CodeType FORM_OF_BUSINESS_CODE_TYPE = new CodeType((long) 3);
    public static CodeType INDUSTRY_CODE_TYPE = new CodeType((long) 4);
    public static CodeType JOB_TITLE_CODE_TYPE = new CodeType((long) 5);
    public static CodeType DEPARTMENT_CODE_TYPE = new CodeType((long) 6);
    public static CodeType ACCOUNT_CODE_TYPE = new CodeType((long) 8);
    public static CodeType SHARE_CODE_TYPE = new CodeType((long) 9);
    public static CodeType FILING_FREQUENCY_CODE_TYPE = new CodeType((long) 10);
    public static CodeType INSTALLMENT_FREQUENCY_CODE_TYPE = new CodeType((long) 11);
    public static CodeType FILING_REMINDER_DAYS = new CodeType((long) 12);
    public static CodeType INSTALLMENT_REMINDER_DAYS = new CodeType((long) 13);
    public static CodeType FIRM_STAFF_TITLE_CODE = new CodeType((long) 17);
    /*private Integer id;
    private boolean activeFlag = true;
    private Date createDate = new Date();
    private String createUserId;
    private String lastUpdateUserId;
    private Date lastUpdateDate;
    private Integer version;*/

    //private Integer id;
	@NotEmpty
    @Size(min = 0, max = 50)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$") 
	private String name;
    
    @Size(min = 0, max = 100)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$")
    private String description;
    private boolean applicationLevelIndicator = true;
    
//    @NotNull
    private CodeType parentCodeType;
    private Set<CodeType> codeTypes = new HashSet<CodeType>(0);

    //	private String lastUdateUserId;
    private Set<Code> codes = new HashSet<Code>(0);

    public CodeType() {
    }

    public CodeType(Long id) {
        this.id = id;
    }

    public CodeType(String name, boolean applicationLevelIndicator) {
        this.name = name;
        this.applicationLevelIndicator = applicationLevelIndicator;
    }

    public CodeType(String name, String description,
        boolean applicationLevelIndicator, CodeType parentCodeType,
        String lastUdateUserId, Set<Code> codes) {
        this.name = name;
        this.description = description;
        this.applicationLevelIndicator = applicationLevelIndicator;
        this.parentCodeType = parentCodeType;
        this.lastUpdateUserId = lastUdateUserId;
        this.codes = codes;
    }

    //	@Id
    //	@GeneratedValue(strategy = IDENTITY)
    //	@Column(name = "id", unique = true, nullable = false)
    //	public Integer getId() {
    //		return this.id;
    //	}
    //
    //	public void setId(Integer id) {
    //		this.id = id;
    //	}
    /*@Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "active_flag", nullable = false)
    public boolean isActiveFlag() {
        return this.activeFlag;
    }

    public void setActiveFlag(boolean activeFlag) {
        this.activeFlag = activeFlag;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date", nullable = false, length = 19)
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
    @Column(name = "version")
    public Integer getVersion() {
        return (this.version != null) ? this.version : 0;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }*/

    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "description", length = 100)
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "application_level_indicator", nullable = false)
    public boolean isApplicationLevelIndicator() {
        return this.applicationLevelIndicator;
    }

    public void setApplicationLevelIndicator(boolean applicationLevelIndicator) {
        this.applicationLevelIndicator = applicationLevelIndicator;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_code_type_id")
    public CodeType getParentCodeType() {
        return this.parentCodeType;
    }

    public void setParentCodeType(CodeType parentCodeType) {
        this.parentCodeType = parentCodeType;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parentCodeType")
    public Set<CodeType> getCodeTypes() {
        return codeTypes;
    }

    public void setCodeTypes(Set<CodeType> codeTypes) {
        this.codeTypes = codeTypes;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "codeType")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    public Set<Code> getCodes() {
        return this.codes;
    }

    public void setCodes(Set<Code> codes) {
        this.codes = codes;
    }

    /*@Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = (prime * result) + ((this.id == null) ? 0 : id.hashCode());

        return result;
    }

     (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null) {
            return false;
        }

        if (!(obj instanceof CodeType)) {
            return false;
        }

        CodeType other = (CodeType) obj;

        if (this.id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!this.id.equals(other.id)) {
            return false;
        }

        return true;
    }*/
}
