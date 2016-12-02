package com.chiguru.pm.crm.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import org.hibernate.annotations.Cascade;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

// Generated Jun 9, 2010 9:02:16 PM by Hibernate Tools 3.3.0.GA
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;


/**
 * PartyCode generated by hbm2java
 */
@Entity
@Table(name = "party_code")
@NamedQueries({@NamedQuery(name = "partyCode.findPartyCodeById",query = "from PartyCode partyCode where " +
    "partyCode.id =? and activeFlag=true")
})
public class PartyCode extends PersistentEntity implements java.io.Serializable {
    //	private Long id;
	
//	@Valid
    private Code code;
    private Party party;
    
//    @NotNull
//    @NumberFormat(style = Style.NUMBER)
//    @Min(0)
//    @Max(20)
    private Integer sortOrder;

    public PartyCode() {
    }

    public PartyCode(Code code, Party party) {
        this.code = code;
        this.party = party;
    }

    public PartyCode(Code code, Party party, Integer sortOrder) {
        this.code = code;
        this.party = party;
        this.sortOrder = sortOrder;
    }

    //	@Id
    //	@GeneratedValue(strategy = IDENTITY)
    //	@Column(name = "id", unique = true, nullable = false)
    //	public Long getId() {
    //		return this.id;
    //	}

    //	public void setId(Long id) {
    //		this.id = id;
    //	}
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "code_id", nullable = false)
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE
    })
    public Code getCode() {
        return this.code;
    }

    public void setCode(Code code) {
        this.code = code;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "party_id", nullable = false)
    public Party getParty() {
        return this.party;
    }

    public void setParty(Party party) {
        this.party = party;
    }

    @Column(name = "sort_order")
    public Integer getSortOrder() {
        return this.sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }
}
