package com.chiguru.pm.crm.domain;


// Generated Jun 9, 2010 9:02:16 PM by Hibernate Tools 3.3.0.GA
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import com.chiguru.pm.core.common.domain.PersistentEntity;

/**
 * Code generated by hbm2java
 */
@Entity
@Table(name = "code")
public class Code extends PersistentEntity implements java.io.Serializable {
    //private Long id;
	
    private CodeType codeType;
    
	/*@NotEmpty
    @Size(min = 0, max = 50)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$")*/ 
    private String shortName;
    
	/*@Size(min = 0, max = 100)
	@Pattern(regexp = "^[a-zA-Z.\\s]*$") */
    private String longDescription;
    
//    @NotNull   //(This is commented because same field effecting in PartCode table for server side validation.)
//	@NumberFormat(style = Style.NUMBER)
//	@NotEmpty
	private Integer sortOrder;
    private boolean applicationLevelIndicator = true;

    //	private Set<PartyCode> partyCodes = new HashSet<PartyCode>(0);
    private Set<Code> codes = new HashSet<Code>(0);
//    @NotNull
//   @Valid
    private Code parentCode;
    
    public Code() {
    }

    public Code(Long id) {
        this.id = id;
    }

    public Code(CodeType codeType, String shortName, String longDescription,
        Integer sortOrder, boolean applicationLevelIndicator) {
        this.codeType = codeType;
        this.shortName = shortName;
        this.longDescription = longDescription;
        this.sortOrder = sortOrder;
        this.applicationLevelIndicator = applicationLevelIndicator;
    }

    public Code(CodeType codeType, String shortName, String longDescription,
        Integer sortOrder, boolean applicationLevelIndicator,
        Set<PartyCode> partyCodes) {
        this.codeType = codeType;
        this.shortName = shortName;
        this.longDescription = longDescription;
        this.sortOrder = sortOrder;
        this.applicationLevelIndicator = applicationLevelIndicator;

        //		this.partyCodes = partyCodes;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "code_type_id", nullable = false)
    public CodeType getCodeType() {
        return this.codeType;
    }

    public void setCodeType(CodeType codeType) {
        this.codeType = codeType;
    }

    @Column(name = "short_name", nullable = false, length = 50)
    public String getShortName() {
        return this.shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    @Column(name = "long_description", nullable = false, length = 100)
    public String getLongDescription() {
        return this.longDescription;
    }

    public void setLongDescription(String longDescription) {
        this.longDescription = longDescription;
    }

    @Column(name = "sort_order", nullable = false)
    public Integer getSortOrder() {
        return this.sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    @Column(name = "application_level_indicator", nullable = false)
    public boolean isApplicationLevelIndicator() {
        return this.applicationLevelIndicator;
    }

    public void setApplicationLevelIndicator(boolean applicationLevelIndicator) {
        this.applicationLevelIndicator = applicationLevelIndicator;
    }

    /*@OneToMany(fetch = FetchType.LAZY, mappedBy = "code")
    public Set<PartyCode> getPartyCodes() {
            return this.partyCodes;
    }
    
    public void setPartyCodes(Set<PartyCode> partyCodes) {
            this.partyCodes = partyCodes;
    }*/
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_code_id")
    public Code getParentCode() {
        return this.parentCode;
    }

    public void setParentCode(Code parentCode) {
        this.parentCode = parentCode;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parentCode")
    public Set<Code> getCodes() {
        return this.codes;
    }

    public void setCodes(Set<Code> codes) {
        this.codes = codes;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = (prime * result) + ((this.id == null) ? 0 : id.hashCode());

        return result;
    }

    /* (non-Javadoc)
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

        if (!(obj instanceof Code)) {
            return false;
        }

        Code other = (Code) obj;

        if (this.id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!this.id.equals(other.id)) {
            return false;
        }

        return true;
    }
    
    public String stringValue(){
    	String stringValue = id!= null ? id.toString(): "";
    	return stringValue;
    }
}
