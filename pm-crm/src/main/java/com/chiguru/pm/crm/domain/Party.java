package com.chiguru.pm.crm.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import org.hibernate.annotations.Cascade;

// Generated Jun 9, 2010 9:02:16 PM by Hibernate Tools 3.3.0.GA
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * Party generated by hbm2java
 */
@Entity
@Table(name = "party")
@NamedQueries({@NamedQuery(name = "party.findfirm_by_party_type_id",query = "select id from Party party where party.partyType.id =?")
    , @NamedQuery(name = "party.findfirm_by_party_type_id_with_order",query = "select id from Party party where party.partyType.id =? order by ?")
    , @NamedQuery(name = "party.findfirm_count_by_party_type_id",query = "select count(id) from Party party where party.partyType.id =?")
    , @NamedQuery(name = "party.findfirm_by_party_and_party_type_id",query = "select id from Party party where party.id=? and party.partyType.id =?")
})
@AttributeOverride(name = "id", column = @Column(name = "party_id")
)
public class Party extends PersistentEntity implements java.io.Serializable {
    //private Long id;
    private Timezone timezone;
    private Language language;
    private PartyType partyType;
    private Jurisdiction jurisdiction;
    private String name;
    private Date startDate;
    private Date endDate;
    private String memo;
    private Integer newStat;
    
//    @Valid
    private Person person;
    private Set<PartyRelationship> partyRelationshipsForObject = new HashSet<PartyRelationship>(0);
    private Set<PartyRelationship> partyRelationshipsForSubject = new HashSet<PartyRelationship>(0);

    //private List<PartySiteCommunication> partySiteCommunications = new AutoPopulatingList(PartySiteCommunication.class);
//    @Valid
    private Set<PartyAccount> partyAccounts = new HashSet<PartyAccount>();
    private Set<PartyCode> partyCodes = new HashSet<PartyCode>(0);
    private List<PartySite> partySites = new ArrayList<PartySite>();
//    @Valid
    private Organization organization;
    
    private String password;
    
    private List<PointOfContact> pointOfContactList = new ArrayList<PointOfContact>(0);

    public Party() {
    }

    public Party(Timezone timezone, Language language, PartyType partyType,
        Jurisdiction jurisdiction, String name, Date startDate, Date endDate,
        String memo, Person person,
        Set<PartyRelationship> partyRelationshipsForSubject,
        Set<PartyRelationship> partyRelationshipsForObject,
        Set<PartyCode> partyCodes, List<PartySite> partySites,
        Organization organization) {
        this.timezone = timezone;
        this.language = language;
        this.partyType = partyType;
        this.jurisdiction = jurisdiction;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.memo = memo;
        this.person = person;
        this.partyRelationshipsForSubject = partyRelationshipsForSubject;
        this.partyRelationshipsForObject = partyRelationshipsForObject;
        this.partyCodes = partyCodes;
        this.partySites = partySites;
        this.organization = organization;
    }

    public Party(PartyType partyType, String name, String createUserId) {
        this.partyType = partyType;
        this.name = name;
        this.createUserId = createUserId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "timezone")
    public Timezone getTimezone() {
        return this.timezone;
    }

    public void setTimezone(Timezone timezone) {
        this.timezone = timezone;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "language")
    public Language getLanguage() {
        return this.language;
    }

    public void setLanguage(Language language) {
        this.language = language;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "party_type", nullable = false)
    public PartyType getPartyType() {
        return this.partyType;
    }

    public void setPartyType(PartyType partyType) {
        this.partyType = partyType;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "juridisction")
    public Jurisdiction getJurisdiction() {
        return this.jurisdiction;
    }

    public void setJurisdiction(Jurisdiction jurisdiction) {
        this.jurisdiction = jurisdiction;
    }

    @Column(name = "name", length = 60)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "start_date", length = 10)
    public Date getStartDate() {
        return this.startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "end_date", length = 10)
    public Date getEndDate() {
        return this.endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Column(name = "memo", length = 65535)
    public String getMemo() {
        return this.memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @OneToOne(fetch = FetchType.LAZY, mappedBy = "party")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    public Person getPerson() {
        return this.person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "party")
    public Set<PartyCode> getPartyCodes() {
        return this.partyCodes;
    }

    public void setPartyCodes(Set<PartyCode> partyCodes) {
        this.partyCodes = partyCodes;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "party")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    public List<PartySite> getPartySites() {
        return this.partySites;
    }

    public void setPartySites(List<PartySite> partySites) {
        this.partySites = partySites;
    }

    @OneToOne(fetch = FetchType.LAZY, mappedBy = "party")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    public Organization getOrganization() {
        return this.organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "partyByObject")
    public Set<PartyRelationship> getPartyRelationshipsForObject() {
        return this.partyRelationshipsForObject;
    }

    public void setPartyRelationshipsForObject(
        Set<PartyRelationship> partyRelationshipsForObject) {
        this.partyRelationshipsForObject = partyRelationshipsForObject;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "partyBySubject")
    public Set<PartyRelationship> getPartyRelationshipsForSubject() {
        return this.partyRelationshipsForSubject;
    }

    public void setPartyRelationshipsForSubject(
        Set<PartyRelationship> partyRelationshipsForSubject) {
        this.partyRelationshipsForSubject = partyRelationshipsForSubject;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "party")
    @Cascade({org.hibernate.annotations.CascadeType.ALL
    })
    /**
     * @return the partyAccounts
     */
    public Set<PartyAccount> getPartyAccounts() {
        return partyAccounts;
    }

    /**
     * @param partyAccounts the partyAccounts to set
     */
    public void setPartyAccounts(Set<PartyAccount> partyAccounts) {
        this.partyAccounts = partyAccounts;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = (prime * result) + ((id == null) ? 0 : id.hashCode());

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

        if (!(obj instanceof Party)) {
            return false;
        }

        Party other = (Party) obj;

        if ((id == null) || (other != null) || (other.getId() == null)) {
            return false;
        } else if (!id.equals(other.getId())) {
            return false;
        }

        return true;
    }

    public void addAccount(PartyAccount partyAccount) {
        this.getPartyAccounts().add(partyAccount);
    }

    public void addPartySite(PartySite partySite) {
        this.getPartySites().add(partySite);
    }

   @Transient
    public PartySite getDefaultPartySite() {
        PartySite retSite = null;

        for (PartySite site : partySites) {
            PartySiteType siteType = site.getPartySiteType();

            if ((partySites.size() == 1) ||
                    ((siteType != null) && siteType.isDefaultFlag()) ||
                    ((siteType != null) &&
                    PartySiteType.HOME_PARTY_SITE_TYPE.equals(siteType.getId()))) {
                retSite = site;

                break;
            }
        }

        if (retSite == null) {
            retSite = new PartySite();
            
            PartySiteType type = new PartySiteType(PartySiteType.HOME_PARTY_SITE_TYPE);
            type.setDefaultFlag(true);
            retSite.setPartySiteType(type);
            partySites.add(retSite);
            retSite.setParty(this);
        }

        return retSite;
    }

    /**
     * User name is email address
     */
    @Transient
    public String getUserName() {
        String userName = null;

        EmailCommunication email = getDefaultPartySite()
                                       .getDefaultPointOfContact().getEmailList()
                                       .get(0);

        if (email.getContactDetail() != null) {
            userName = email.getContactDetail();
        } else {
            //exception
        }

        return userName;
    }

    @Transient
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setNewStat(Integer newStat) {
		this.newStat = newStat;
	}
	@Transient
	public Integer getNewStat() {
		return newStat;
	}

	public void setPointOfContactList(List<PointOfContact> pointOfContactList) {
		this.pointOfContactList = pointOfContactList;
	}

	 @OneToMany(fetch = FetchType.LAZY, mappedBy = "party")
	    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE
	    })
	public List<PointOfContact> getPointOfContactList() {
		return pointOfContactList;
	}
        
	 @Transient
	    public PointOfContact getDefaultPointOfContact() {
	        PointOfContact poc = null;

	        if (pointOfContactList.size() > 0) {
	            poc = this.pointOfContactList.get(0);
	        } else {
	            poc = new PointOfContact();
	            poc.setParty(this);
	            this.getPointOfContactList().add(poc);
	        }

	        return poc;
	    }
}
