package com.chiguru.pm.crm.dao;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.dto.AddressDTO;
import com.chiguru.pm.crm.dto.ClientListDTO;
import com.chiguru.pm.crm.dto.CredentialsDTO;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TimezoneDTO;
import com.chiguru.pm.security.PMUser;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.ejb.HibernateEntityManager;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.orm.hibernate3.HibernateAccessor;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.http.HttpSession;


@Repository("crmDao")
public class CRMDaoImpl extends HibernateDaoSupport implements CRMDao {
	
	public static final String UPDATE_THEME = "UPDATE users SET  theme = :theme WHERE username = :username";
	private static final String UPDATE_NOTIFICATION = "UPDATE task_notification SET  sent_to = :to, sent_date = :notificationDate WHERE task_id = :taskId and id = :newTaskId";
	private static final String UPDATE_SELECTED_ACCOUNT = null;
	public static final String DEF_UPDATE_LANGUAGE_SQL = "UPDATE users SET default_lang = :newLanguage WHERE username = :username";
    public static final String DEF_SELECT_LANGUAGE_SQL = "Select default_lang from users where username = :user";
    public static final String DELETE_SELECTED_PARTYACCOUNT = "UPDATE party_account SET active_flag = %s WHERE id in (%s) and account_category = %s";
    public static final String  DELETE_SELECTED_PARTY = "UPDATE party SET active_flag = :activeFlag WHERE party_id = :newId";
    public static final String  DELETE_SELECTED_PARTYSITE = "UPDATE party_site SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_PARTYCODE = "UPDATE party_code SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_JURISDICTION = "UPDATE jurisdiction SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_CODE_TYPE = "UPDATE code_type SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_CODE = "UPDATE code SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_TEMPLATE = "UPDATE task_notification_template SET active_flag = :activeFlag WHERE id = :newId";
    public static final String  DELETE_SELECTED_RECEPIENT = "UPDATE task_notification_recipient SET active_flag = :activeFlag WHERE notification_type = :newId";
    public static final String  DELETE_SELECTED_OFFICER = "UPDATE person_details SET no_of_shares_owned = null Where party_id = :newId";
    private static final String DEF_VERIFY_USER_SQL = "SELECT username FROM users where password = :userKey and username = :userName";
    private static final String DEF_UPDATE_PASSWORD_SQL = "UPDATE users SET  password = :newPassword , enabled = 1 WHERE username = :username";
    private static final String DEF_SELECTED_USER_CREDENTIALS = "SELECT r.role as role, upper(m.module) as module, c.credential as credential,r.party_id as partyId FROM credentials as c,modules as m,roles as r WHERE r.id = c.role_id and m.id = c.module_id and module = :module and role = :role and r.party_id = :partyId";
    
    @Autowired
    public void setDaoSessionFactory(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    private HibernateTemplate getHibernate() {
        HibernateTemplate template = getHibernateTemplate();
        template.setAllowCreate(false);
        template.setFlushMode(HibernateAccessor.FLUSH_COMMIT);

        return template;
    }

    @Override
    public Party getPartyById(Long partyId) {
        return getHibernate().get(Party.class, partyId);
    }

    @Override
    public Person getPersonById(Long partyId) {
        return getHibernate().get(Person.class, partyId);
    }

    @Override
    public Organization getOrganizationById(Long partyId) {
        return getHibernate().get(Organization.class, partyId);
    }

    public List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId) {
        Object[] paraArray = { objectPartyId, relationshipTypeId };

        return getHibernate()
                   .findByNamedQuery("relationship.findclients_by_object_id",
            paraArray);
    }

    public Long getRelatedPartiesCountById(Long objectPartyId,
        Integer relationshipTypeId) {
    	
    	SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
    			" SELECT count(client.party_id) as count " +
				" from organization as client " +
				" inner join party_relationship as relation on relation.subject = client.party_id " +
				" left outer join party as inChargePerson on client.in_charge_person = inChargePerson.party_id " +
				" left outer join point_of_contact poc on poc.party_id = client.party_id " +
				" inner join party_site as site on poc.party_site_id = site.id " +
				" inner join party as subject on subject.party_id = client.party_id " +
				" where relation.object = :objectPartyId and relation.relationship_type = :relationshipTypeId and site.party_site_type = 1 and subject.active_flag= true");
		query.setParameter("objectPartyId", objectPartyId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        
       return (Long) (result.get(0));
    }
    public List<AddressDTO> getReportAddress(Long firmid){
    	SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
    			" select ps.party_id as party,a.address_line_1 as addressLine,a.city as city, a.postal_code as postalCode " +
    			" from party_site ps " +
    			" left join party p on ps.id = p.party_id " +
    			" right join address a on ps.address_id = a.id " +
    			" left join code c on c.id = a.country_code " +
    			" where ps.party_id = :firmid");
    	query.setParameter("firmid",firmid);
    	List reportAddressDTO = query.addScalar("party",StandardBasicTypes.LONG)
                                     .addScalar("addressLine")
                                     .addScalar("city")
                                     .addScalar("postalCode")
                                     .setResultTransformer(Transformers.aliasToBean(AddressDTO.class))
                                     .list();
		return reportAddressDTO;
		
    	
    }
    public Long getPartiesCountByTypeId(Integer partyTypeId) {
        Object[] paraArray = { partyTypeId };
        List result = getHibernate()
                          .findByNamedQuery("party.findfirm_count_by_party_type_id",
                paraArray);

        return (Long) (result.get(0));
    }

    public List<Party> getRelatedPartiesById(Long objectPartyId,
        Integer relationshipTypeId, String sortName, String sortType,
        Integer start, Integer maxResults) {
        Object[] paraArray = { objectPartyId, relationshipTypeId, sortName };

        return getHibernate()
                   .findByNamedQuery("relationship.findclients_by_object_id_with_order",
            paraArray).subList(start, start + maxResults);
    }

    public List<Long> getPartiesByTypeId(Integer relationshipTypeId) {
        Object[] paraArray = { relationshipTypeId };

        return getHibernate()
                   .findByNamedQuery("party.findfirm_by_party_type_id",
            paraArray);
    }

    public List<Long> getPartiesByTypeId(Integer relationshipTypeId,
        String sortName, String sortType, Integer start, Integer maxResults) {
        Object[] paraArray = { relationshipTypeId, sortName };

        return getHibernate()
                   .findByNamedQuery("party.findfirm_by_party_type_id_with_order",
            paraArray).subList(start, start + maxResults);
    }

    @Override
    public List<Party> getRelatedPartiesById(Long objectPartyId,
        List<RelationshipType> listOfRelationshipType) {
        List<Party> listOfRelatedParties = new ArrayList<Party>();

        for (RelationshipType relationshipType : listOfRelationshipType) {
            Object[] paraArray = { objectPartyId, relationshipType.getId() };
            listOfRelatedParties.addAll(getHibernate()
                                            .findByNamedQuery("relationship.findclients_by_object_id",
                    paraArray));
        }

        return listOfRelatedParties;
    }

    public List<PartyType> getPartyTypeList() {
        return getHibernate().find("from PartyType");
    }

    public List<OrganizationType> getOrganizationTypeList() {
        return getHibernate().find("from OrganizationType");
    }

    public List<PersonType> getPersonTypeList() {
        return getHibernate().find("from PersonType");
    }

    public List<RelationshipType> getRelationshipTypeList() {
        return getHibernate().find("from RelationshipType");
    }

    @Override
    public PartyRelationship createPartyAndRelationship(Party mainParty,
        Party relatedParty, String userId, RelationshipType relationshipType) {
        /*Long mainPartyId = mainParty.getId();
        mainParty = getHibernate().get(Party.class, mainPartyId);
        Integer relatedPartyTypeId = relatedParty.getPartyType().getId();
        PartyType relatedPartyType = getHibernate().get(PartyType.class, relatedPartyTypeId);
        */
        PartyRelationship rel = null;

        if (relationshipType != null) {
            Integer relationshipTypeId = relationshipType.getId();
            relationshipType = getHibernate()
                                   .get(RelationshipType.class,
                    relationshipTypeId);

            /* OrganizationType orgType = getHibernate().get(OrganizationType.class,
                            relatedParty.getOrganization().getOrganizationType().getId());
            
            relatedParty.setPartyType(relatedPartyType);
            relatedParty.getOrganization().setOrganizationType(orgType);*/
            rel = getPartyRelationship(mainParty.getId(), relatedParty.getId(),
                    relationshipTypeId);

            if (rel == null) {
                rel = new PartyRelationship();
                rel.setActiveFlag(true);
                rel.setPartyBySubject(relatedParty);
                rel.setPartyByObject(mainParty);
//                rel.setCreateUserId(userId);
                rel.setRelationshipType(relationshipType);
            }

            //		getHibernate().saveOrUpdate(relatedParty);
            getHibernate().saveOrUpdate(rel);
        }

        if (relatedParty.getOrganization() != null) {
            getHibernate().saveOrUpdate(relatedParty.getOrganization());
        } else if (relatedParty.getPerson() != null) {
            getHibernate().saveOrUpdate(relatedParty.getPerson());
        }

        getHibernate().saveOrUpdate(relatedParty);

        return rel;
    }

    @Override
    public void createOrganization(Organization org) {
        getHibernate().saveOrUpdate(org);

        //getHibernate().flush();
    }

    @Override
    public void createParty(Party party) {
        getHibernate().saveOrUpdate(party);

        /*if(party.getDefaultPartySite().getPartySiteCommunications().size() > 0){
                getHibernate().saveOrUpdate(
                                party.getDefaultPartySite());
        }*/

        //getHibernate().flush();
    }

    @Override
    public Map<CodeType, Set<Code>> getApplicationLevelCodeMap() {
        Map<CodeType, Set<Code>> applicationCodeMap = new HashMap();
        List results = getHibernate()
                           .find("select new map(codeType, codeType.codes as codes) from CodeType as codeType where codeType.applicationLevelIndicator =true");

        if (results.size() > 1) {
            applicationCodeMap = (Map<CodeType, Set<Code>>) results.get(0);
        }

        return applicationCodeMap;
    }

    @Override
    public Code getCodeById(Integer id) {
        Code code = getHibernate().get(Code.class, id);

        return code;
    }

    @Override
    public CodeType getCodeTypeById(Long id) {
        CodeType codeType = getHibernate().get(CodeType.class, id);

        return codeType;
    }

    @Override
    public List<Code> getCodesByCodeType(Long codeTypeId) {
        return getHibernate()
                   .find("from Code code where code.codeType.id=" + codeTypeId +
            " and applicationLevelIndicator=" + true +" and activeFlag=" + true);
    }

    @Override
    public Map<CodeType, List<Code>> getPartyLevelCodeMap(Long partyId) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<CodeType> getApplicationLevelCodeType() {
        return getHibernate()
                   .find("from CodeType as codeType where codeType.applicationLevelIndicator =true");
    }

    @Override
    public PartyAccount getAccountById(Long accountId) {
        return getHibernate().get(PartyAccount.class, accountId);
    }

    @Override
    public PartyAccount getAccountByIdAndAccountType(Long accountId,
        Long accountCategory) {
        List accountList = getHibernate()
                               .find("from PartyAccount account where account.id =" +
                accountId + " and account.accountCategory.id=" +
                accountCategory);
        PartyAccount retAccount = null;

        if (!accountList.isEmpty()) {
            retAccount = (PartyAccount) accountList.get(0);
        }

        return retAccount;
    }

    public Code getCodeById(Long id) {
        return getHibernate().get(Code.class, id);
    }

    @Override
    @Transactional
    public void savePartyAccount(PartyAccount account,
        List<PhoneCommunication> phonesToBeRemoved) {
        getHibernate().saveOrUpdate(account);
    	//getHibernate().merge(account);
        if(phonesToBeRemoved != null){
        	getHibernate().deleteAll(phonesToBeRemoved);
        }
    }

    @Override
    public List<CommunicationType> getCommunicationTypes(boolean phoneIndicator) {
        return getHibernate()
                   .find("from CommunicationType type where type.phoneIndicator=" +
            phoneIndicator);
    }

    public CommunicationType getCommunicationTypeById(Integer id) {
        return getHibernate().load(CommunicationType.class, id);
    }

    public PartySite getPartySiteById(Long id) {
        return getHibernate().load(PartySite.class, id);
    }

    public PartySiteType getPartySiteTypeById(Integer id) {
        return getHibernate().load(PartySiteType.class, id);
    }

    public RelationshipType getRelationshipTypeById(Integer id) {
        return getHibernate().get(RelationshipType.class, id);
    }

    public PartyRelationship getPartyRelationship(Long objectPartyId,
        Long subjectPartyId, Integer relationshipTypeId) {
        PartyRelationship retObject = null;
        Object[] paraArray = { objectPartyId, subjectPartyId, relationshipTypeId };
        List<PartyRelationship> relList = getHibernate()
                                              .findByNamedQuery("relationship.findrelationship_by_object_id_and_subject_id",
                paraArray);

        if (relList.size() > 0) {
            retObject = relList.get(0);
        }

        return retObject;

        //paraArray).subList(start, start + maxResults);
    }

    @Override
    public void deletePhoneCommunication(
        List<PhoneCommunication> phonesToBeRemoved) {
        getHibernate().deleteAll(phonesToBeRemoved);
    }

    public List<PartyAccount> getAccountListByPartyAndCategory(Long partyId,
        Long accountCategory, String sortName, String sortType, Integer start,
        Integer maxResults) {
        /*Object[] paraArray = {partyId, accountCategory, sortName};
        return getHibernate().findByNamedQuery("account.findAccounts_by_party_and_category",
                        paraArray).subList(start, start + maxResults);*/
        Object[] paraArray = { partyId, accountCategory };

        return getHibernate()
                   .findByNamedQuery("account.findAccounts_by_party_and_category",
            paraArray);
    }

    public Long findAccountsCountById(Long partyId, Long accountCategory) {
        Object[] paraArray = { partyId, accountCategory };
        List result = getHibernate()
                          .findByNamedQuery("account.findAccounts_count_by_party_id",
                paraArray);

        return (Long) (result.get(0));
    }

    @Override
    public List<PartySiteType> getPartySiteTypes() {
        return getHibernate().find("from PartySiteType type");
    }

    @Override
    public void savePartySite(PartySite partySite) {
        getHibernate().saveOrUpdate(partySite);
    }

    public void createCode(Code code) {
        getHibernate().saveOrUpdate(code);
    }

    @Override
    public Jurisdiction getJurisdictionById(Long id) {
        return getHibernate().get(Jurisdiction.class, id);
    }

    public List<Jurisdiction> getJurisdictionList() {
        return getHibernate().find("from Jurisdiction juri where active_flag=true");
    }

    //sagar
    @Override
    public void saveJurisdiction(Jurisdiction manageJurisdiction) {
        getHibernate().saveOrUpdate(manageJurisdiction);
    }

    @Override
    public List<Timezone> getTimezoneList() {
        return getHibernate().find("from Timezone timezone");
    }

    @Override
    public Timezone getTimezoneById(Long id) {
        return getHibernate().get(Timezone.class, id);
    }

    @Override
    public void saveTimezone(Timezone manageTimezone) {
        getHibernate().saveOrUpdate(manageTimezone);
    }

    /*@Override
    public CodeType getCodeTypeById(Long id) {
            return getHibernate().get(CodeType.class, id);
    }*/
    @Override
    public List<CodeType> getCodeTypeList() {
        return getHibernate().find("from CodeType codeType where activeFlag=true");
    }

    @Override
    public void saveCodeType(CodeType manageCodeType) {
        getHibernate().saveOrUpdate(manageCodeType);
    }

    @Override
    public List<Code> getCodeList() {
        return getHibernate().find("from Code code");
    }

    @Override
    public void saveCode(Code manageCode) {
        getHibernate().saveOrUpdate(manageCode);
    }

    @Override
    public PartyCode getPartyCodeById(Long id) {
        return getHibernate().get(PartyCode.class, id);
    }

    @Override
    public List<PartyCode> getPartyCodeList(Long firmId) {
        return getHibernate()
                   .find("from PartyCode partyCode where party.id=" + firmId);
    }

    @Override
    public void savePartyCode(PartyCode partyCode) {
        getHibernate().saveOrUpdate(partyCode.getCode());
        getHibernate().saveOrUpdate(partyCode);
    }

    @Override
    public Long getMaxCodeIdValue() {
        //		return getHibernate().find("select max(id) from Code");
        List<Long> result = getHibernate().find("select max(id) from Code");

        return result.get(0);
    }

    @Override
    public Long getParentCodeTypeIdById(Long codeTypeId) {
        List<Long> result = getHibernate()
                                   .find("select parentCodeType.id from CodeType codeType where id=" +
                codeTypeId);
        
        return result.get(0);
    }

    @Override
    public List<Code> getRelatedCodeByCodeTypeId(Long parentCodeTypeId) {
        return getHibernate().find("from Code code where codeType.id=" +parentCodeTypeId);
    }

    @Override
    public List<CodeType> getCodeTypeListWhereApplcationLevelIsFalse() {
        return getHibernate()
                   .find("from CodeType codeType where applicationLevelIndicator=false");
    }

    @Override
    public List<Code> getRelatedCodeByCodeTypeIdWhereAppFalse(
    		Long parentCodeTypeId) {
        List<Code> result = getHibernate()
                                .find("from Code code where applicationLevelIndicator=false and codeType.id=" +
                parentCodeTypeId);

        return result;
    }

    @Override
    public void saveParty(Party party) {
        getHibernate().saveOrUpdate(party);
    }

    @Override
    public PartyType getPartyTypeById(Integer id) {
        return getHibernate().get(PartyType.class, id);
    }

    @Override
    public List<PartyRelationship> getListOfRelatedParties(Long firmId) {
        List<PartyRelationship> list = getHibernate()
                                           .find("from PartyRelationship partyRelationship where partyByObject.id=" +
                firmId);

        return list;
    }

    @Override
    public Long getMaxJurisdictionIdValue() {
        List<Long> result = getHibernate()
                                .find("select max(id) from Jurisdiction");

        return result.get(0);
    }

    @Override
    public PartyRelationship getPartyRelationshipById(Long id) {
        return getHibernate().get(PartyRelationship.class, id);
    }

    @Override
    public List<PartyCode> getPartyCodeByFirmId(Long integer, Long firmId) {
        List<PartyCode> result = getHibernate()
                                     .find("from PartyCode partyCode where party.id=" +
                firmId + " and code.codeType.id=" + integer);

        return result;
    }

    @Override
    public List getCodesByCodeTypeForAdminStaff(Long codeTypeId) {
        return getHibernate()
                   .find("from Code code where code.codeType.id=" + codeTypeId);
    }

    @Override
    public PointOfContact getPointOfContactById(Long id) {
        return getHibernate().get(PointOfContact.class, id);
    }

    @Override
    public Communication getCommunicationById(Long id) {
        return getHibernate().get(Communication.class, id);
    }

	@Override
	public List<Party> getPartyRelationshipbySubId(Long id) {
		 Object[] paraArray = { id };

		 return getHibernate().findByNamedQuery("relationship.findclients_by_subject_id",paraArray);
		
	}

	@Override
	public List<Party> getPartybyLocationIdFromPartySite(Long id,Long clientId) {
		Object[] paraArray = { id,clientId };

		 return getHibernate().findByNamedQuery("partysite.findclients_by_location_n_client_id",paraArray);

	}
	
	@Override
	public List<Party> getPartyRelationshipByBothId(Long shareId,Long clientId,Integer relationshipTypeId) {
		 Object[] paraArray = { shareId, clientId , relationshipTypeId};

		 return getHibernate().findByNamedQuery("relationship.findclients_by_both_id",paraArray);
		
	}
	
	@Override
	public List<Party> getPartyAccountByBothId(Long bankId,Long clientId,Long accountCategoryId) {
		 Object[] paraArray = { bankId, clientId,accountCategoryId};

		 return getHibernate().findByNamedQuery("account.findAccount_by_party_both_id",paraArray);
		
	}
	
	@Override
	public List<Long> getPartyByPartyNPartyTypeId(Long partyId, Integer partyTypeId) {
		 Object[] paraArray = { partyId, partyTypeId };
	        //List result = getHibernate().findByNamedQuery("party.findfirm_by_party_and_party_type_id",paraArray);

	        //return (Long) (result.get(0));
	        return getHibernate().findByNamedQuery("party.findfirm_by_party_and_party_type_id",paraArray);
	}

	@Override
	public List<PartyCode> getPartyCodeByCodeId(Long id) {
		// TODO Auto-generated method stub
		 Object[] paraArray = { id };
	        //List result = getHibernate().findByNamedQuery("party.findfirm_by_party_and_party_type_id",paraArray);

	        //return (Long) (result.get(0));
	        return getHibernate().findByNamedQuery("partyCode.findPartyCodeById",paraArray);
	}

	@Override
	public List<Organization> getFirmList() {		
		return getHibernate().find("from Organization where organizationType=1");
	}

	@Override
	public List<PartyDTO> getPartyDTOListById(Long objectPartyId,
			Integer relationshipTypeId, int count, int limit, int offset) {
		/*Integer start = offset;
		Long longCount = (long) limit;*/
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct client.party_id as partyId, client.name as name, inChargePerson.name as inChargePerson, " +
				" phonComm.contact_detail as officeNumber, emailComm.contact_detail as emailAddress, subject.create_date as createDate " +
				" from organization as client " +
				" inner join party_relationship as relation on relation.subject = client.party_id " +
				" left outer join party as inChargePerson on client.in_charge_person = inChargePerson.party_id " +
				" left outer join point_of_contact poc on poc.party_id = client.party_id " +
				" inner join party_site as site on poc.party_site_id = site.id " +
				" left outer join communication as phonComm on phonComm.contact_point_id = poc.id and phonComm.communication_Type = 3 and phonComm.sub_type = 3 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" inner join party as subject on subject.party_id = client.party_id " +
				" where relation.object = :objectPartyId and relation.relationship_type = :relationshipTypeId and site.party_site_type = 1 and subject.active_flag= true" +
				" limit :limit offset :offset");
		query.setParameter("objectPartyId", objectPartyId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		query.setParameter("limit", limit);
		query.setParameter("offset", offset);
              
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("inChargePerson")
											.addScalar("officeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(PartyDTO.class))
										   	 .list();

		return resultWithAliasedBean;
	}

	@Override
	public Long getStaffDTOCountById(Long clientId, Integer relationshipTypeId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select count(staff.party_id) as count " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" where relation.object = :clientId and relation.relationship_type = :relationshipTypeId and staff.active_flag = true");
		query.setParameter("clientId", clientId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		
		return (Long) (result.get(0));
	}
	
	@Override
	public List<PersonDTO> getPersonDTOListById(Long clientId,
			Integer relationshipTypeId, int count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct staff.party_id as partyId, staff.name as name, jobCode.short_name as jobTitle, " +
				" officeNumber.contact_detail as officeNumber,homeNumber.contact_detail as homeNumber, emailComm.contact_detail as emailAddress " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" left outer join person_details as staffDetail on staffDetail.party_id = staff.party_id " +
				" left outer join code as jobCode on jobCode.id = staffDetail.job_title_code " +
				" left outer join point_of_contact poc on poc.party_id = staff.party_id " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3 " +
				" left outer join communication as homeNumber on homeNumber.contact_point_id = poc.id and homeNumber.communication_Type = 3 and homeNumber.sub_type = 4 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" where relation.object = :clientId and relation.relationship_type = :relationshipTypeId and staff.active_flag = true");
		query.setParameter("clientId", clientId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("jobTitle")
											.addScalar("officeNumber")
											.addScalar("homeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(PersonDTO.class))
											 .list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public List<PartyAccountDTO> getPartyAccountDTOListById(Long clientId,
			Long accountCategory, Page page) {
		Integer start = 0;
		Long longCount = (long) page.getCount();
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct account.id as id, account.account_entity_name as accountFirmName, account_type.short_name as accountType, " +
				" account.account_number as accountNumber, poc.contact_name as contactName, officeNumber.contact_detail as officeNumber,  " +
				" emailComm.contact_detail as emailAddress " +
				" from party_account account " +
				" inner join party party on party.party_id = account.party_id " +
				" inner join code account_category on account_category.id = account.account_category " +
				" left outer join code account_type on account_type.id = account.account_type " +
				" left outer join point_of_contact poc on poc.account_id = account.id " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" where party.party_id = :clientId  and account_category.id = :accountCategory and account.active_flag = true");
		query.setParameter("clientId", clientId);
		query.setParameter("accountCategory", accountCategory);
		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("accountFirmName")
											.addScalar("accountType")
											.addScalar("accountNumber")
											.addScalar("contactName")
											.addScalar("officeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(PartyAccountDTO.class))
											 .list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public Long getPartyAccountDTOCountById(Long clientId, Long accountCategory) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select count(account.id) as count " +
				" from party_account account " +
				" inner join party party on party.party_id = account.party_id " +
				" inner join code account_category on account_category.id = account.account_category " +
				" where party.party_id = :clientId and account_category.id = :accountCategory and account.active_flag = true");
		query.setParameter("clientId", clientId);
		query.setParameter("accountCategory", accountCategory);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		
		return (Long) (result.get(0));
	}

	@Override
	public List<JurisdictionDTO> getJurisdictionDTOList(Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct jurisdiction.id as id,jurisdiction.country as country,jurisdiction.state as state,jurisdiction.city as city, "  +
				" timezone.global_timezone_name as globalTimezoneName,timezone.gmt_deviation_hours as gmtDeviationHours, jurisdiction.active_flag as activeFlag" +
				" from jurisdiction as jurisdiction " +
		        " inner join timezone as timezone " +
		        " on timezone.id = jurisdiction.timezone ");
	
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
                                   .addScalar("country")
                                   .addScalar("state")
                                   .addScalar("city")
                                   .addScalar("globalTimezoneName")
                                   .addScalar("gmtDeviationHours")
                                   .addScalar("activeFlag")
                                   .setResultTransformer(Transformers.aliasToBean(JurisdictionDTO.class))
                                   .list().subList(start,start+longCount.intValue());
                                   
                                                                      
		return resultWithAliasedBean;
	}


	@Override
	public Long getJurisdictionListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(jurisdiction.id) as count " +
				" from jurisdiction as jurisdiction ");
		query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        
		return (Long) (result.get(0));
	}

	@Override
	public Long getTimezoneListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
		" SELECT count(timezone.id) as count " +
		" from timezone as timezone");
		query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        return (Long) (result.get(0));
	}

	@Override
	public List<TimezoneDTO> getTimezoneDTOList(Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select timezone.id as Id,timezone.global_timezone_name as globalTimezoneName,timezone.gmt_deviation_hours as gmtDeviationHours,timezone.active_flag as activeFlag " +
				"from timezone as timezone");
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("globalTimezoneName")
											.addScalar("gmtDeviationHours")
											.addScalar("activeFlag")
											.setResultTransformer(Transformers.aliasToBean(TimezoneDTO.class))
											.list().subList(start,start+longCount.intValue());
                                      
		return  resultWithAliasedBean;
}

	@Override
	public Long getCodeTypeListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(code_type.id) as count " +
				" from code_type as code_type");
		query.addScalar("count", StandardBasicTypes.LONG);
		 List result = query.list();
	        return (Long) (result.get(0));
		}

	@Override
	public List<CodeTypeDTO> getCodeTypeDTOList(Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code_type.id as id,code_type.name as name,code_type.description as description,parent_code_type.name as parentCodeTypeName, " +
				" code_type.application_level_indicator as applicationLevelIndicator,code_type.active_flag as activeFlag " +
				" from code_type as code_type " +
				" left outer join code_type as parent_code_type on parent_code_type.id = code_type.parent_code_type_id ");
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		                                   .addScalar("name")
		                                   .addScalar("description")
		                                   .addScalar("parentCodeTypeName")
		                                   .addScalar("applicationLevelIndicator")
		                                   .addScalar("activeFlag")
		                                   .setResultTransformer(Transformers.aliasToBean(CodeTypeDTO.class))
                                           .list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public Long getCodeListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(code.id) as count " +
				" from code as code " +
				" left outer join code as parent_code on parent_code.id = code.parent_code_id ");
				query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}
	
	@Override
	public List<CodeDTO> getCodeDTOList(Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as id, code.short_name as shortName,code.long_description as longDescription,code_type.name as codeTypeName, " +
				" code.application_level_indicator as applicationLevelIndicator, parentCode.short_name as parentCodeShortName, code.active_flag as activeFlag " +
				" from code as code " +
				" left outer join code_type as code_type on code_type.id = code.code_type_id " +
				" left outer join code as parentCode on parentCode.id = code.parent_code_id ");
		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		  								.addScalar("shortName")
		  								.addScalar("longDescription")
		  								.addScalar("codeTypeName")
		  								.addScalar("applicationLevelIndicator")
		  								.addScalar("parentCodeShortName")
		  								.addScalar("activeFlag")
		  								.setResultTransformer(Transformers.aliasToBean(CodeDTO.class))
		  								.list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public List<CodeDTO> getCodeDTOList(int offset, int limit) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as id, code.short_name as shortName,code.long_description as longDescription,code_type.name as codeTypeName, " +
				" code.application_level_indicator as applicationLevelIndicator, parentCode.short_name as parentCodeShortName, code.active_flag as activeFlag " +
				" from code as code " +
				" left outer join code_type as code_type on code_type.id = code.code_type_id " +
				" left outer join code as parentCode on parentCode.id = code.parent_code_id " +
				" limit :limit offset :offset");
	query.setParameter("limit", limit);
	query.setParameter("offset", offset);
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		  								.addScalar("shortName")
		  								.addScalar("longDescription")
		  								.addScalar("codeTypeName")
		  								.addScalar("applicationLevelIndicator")
		  								.addScalar("parentCodeShortName")
		  								.addScalar("activeFlag")
		  								.setResultTransformer(Transformers.aliasToBean(CodeDTO.class))
		  								.list();
		return resultWithAliasedBean;
	}
	
	@Override
	public Long getTaskNotificationTemplateListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(task_notification_template.id) as count " +
				" from task_notification_template as task_notification_template ");
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<TaskNotificationTemplateDTO> getTaskNotificationTemplateDTOList(
			Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select task_notification_template.id as id,task_notification_template.subject as subject,task_notification_template.body as bodyText,task_notification_template.additional_emailId as adminEmailId,task_notification_template.active_flag as activeFlag  " +
				" from task_notification_template as task_notification_template ");
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		                                   .addScalar("subject")
		                                   .addScalar("bodyText")
		                                   .addScalar("adminEmailId")
		                                    .addScalar("activeFlag")
		                                   .setResultTransformer(Transformers.aliasToBean(TaskNotificationTemplateDTO.class))
		  								   .list().subList(start,start+longCount.intValue());
		
		return resultWithAliasedBean;
	}

	@Override
	public Long getTaskNotificationRecipientListCount() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(task_notification_recipient.recipient) as count " +
				" from task_notification_recipient as task_notification_recipient ");
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<TaskNotificationRecipientDTO> getTaskNotificationRecipientDTOList(
			Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select notification_recipient.notification_type as id, notification_recipient.recipient as recipient,notification_recipient.email_type as emailType, " +
                " notification_template.subject as typeOfNotificationTemplate, notification_recipient.active_flag as activeFlag " +
                " from task_notification_recipient as notification_recipient " +
                " left outer join task_notification_template as notification_template on notification_template.id = notification_recipient.template_id ");       		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		                                   .addScalar("recipient")
		                                   .addScalar("emailType")
		                                   .addScalar("typeOfNotificationTemplate")
		                                   .addScalar("activeFlag")
		                                   .setResultTransformer(Transformers.aliasToBean(TaskNotificationRecipientDTO.class))
		  								   .list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public Long getPartyCodeListCount(Long firmId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(party_code.id) as count " +
				" from party_code as party_code  " +
				" inner join code as code on code.id = party_code.code_id "+
				" inner join code_type as codeType on codeType.id = code.code_type_id "+
				" inner join party as party on party.party_id = party_code.party_id " +
		  		" where party.party_id = :firmId"); 
		query.setParameter("firmId", firmId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<PartyCodeDTO> getPartyCodeDTOList(Long count, Long firmId) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select  party_code.id as partyCodeId,code.short_name as codeShortName, codeType.name as codeCodeTypeName, "+
				" codeType.application_level_indicator as codeApplicationLevelIndicator, parentCode.short_name as codeParentCodeShortName, " +
				" party_code.sort_order as sortOrder,party_code.active_flag as activeFlag " +
                " from party_code as party_code " +
                " inner join code as code on code.id = party_code.code_id "+
                " inner join code_type as codeType on codeType.id = code.code_type_id "+
                " left outer join code as parentCode on parentCode.id = code.parent_code_id "+
                " inner join party as party on party.party_id = party_code.party_id " +
                " where party.party_id = :firmId"); 
		query.setParameter("firmId", firmId);
		List resultWithAliasedBean = query.addScalar("partyCodeId", StandardBasicTypes.LONG)
		                                   .addScalar("codeShortName")
		                                   .addScalar("codeCodeTypeName")
		                                   .addScalar("codeApplicationLevelIndicator")
		                                   .addScalar("codeParentCodeShortName")
		                                   .addScalar("sortOrder")
		                                   .addScalar("activeFlag")
		                                   .setResultTransformer(Transformers.aliasToBean(PartyCodeDTO.class))
		                                   .list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
		                                  
	}

	@Override
	public Long getOfficersAndShareHoldersListCount(Long mainPartyId, Integer relationshipTypeId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(staff.party_id) as count " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" left outer join person_details as staffDetail on staffDetail.party_id = staff.party_id " +
				" left outer join code as jobCode on jobCode.id = staffDetail.job_title_code " +
				" left outer join code as typeOfShareCode on typeOfShareCode.id = staffDetail.type_of_share " +
				" where relation.object = :mainPartyId and relation.relationship_type = :relationshipTypeId and staff.active_flag = true and staffDetail.no_of_shares_owned != ''"); 
		query.setParameter("mainPartyId", mainPartyId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<PartyDTO> getOfficersAndShareHoldersList(Long mainPartyId,
			Integer relationshipTypeId, Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct staff.party_id as id, staff.name as name, typeOfShareCode.short_name as typeOfShare, " +
				" staffDetail.no_of_shares_owned as bigIntNoOfSharesOwned " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" left outer join person_details as staffDetail on staffDetail.party_id = staff.party_id " +
				" left outer join code as jobCode on jobCode.id = staffDetail.job_title_code " +
				" left outer join code as typeOfShareCode on typeOfShareCode.id = staffDetail.type_of_share " +
				" where relation.object = :mainPartyId and relation.relationship_type = :relationshipTypeId and staff.active_flag = true and staffDetail.no_of_shares_owned != ''");
		query.setParameter("mainPartyId", mainPartyId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("typeOfShare")
											.addScalar("bigIntNoOfSharesOwned", StandardBasicTypes.LONG)
											.setResultTransformer(Transformers.aliasToBean(PartyDTO.class))
											 .list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public List<LocationDTO> getLocationList(Long partyId, Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct site_location.id as partySiteId, party.name as partyName, " +
				" site_location.name as name, location_type.name as locationType,officeNumber.contact_detail as officeNumber, homeNumber.contact_detail as homeNumber, emailComm.contact_detail as emailAddress " +
				" from party_site as site_location " +
				" left outer join party as party on party.party_id = site_location.party_id " +
				" left outer join party_site_type as location_type on location_type.id = site_location.party_site_type" +
				" left outer join point_of_contact as poc on poc.party_site_id = site_location.id " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3 " +
				" left outer join communication as homeNumber on homeNumber.contact_point_id = poc.id and homeNumber.communication_Type = 3 and homeNumber.sub_type = 4 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1" +
				" where party.party_id =:partyId and site_location.active_flag = true");
		query.setParameter("partyId", partyId);
		List resultWithAliasedBean = query.addScalar("partySiteId", StandardBasicTypes.LONG)
											.addScalar("partyName")
											.addScalar("name")
											.addScalar("locationType")
											.addScalar("officeNumber")
											.addScalar("homeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(LocationDTO.class))
											.list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public Long getLocationListCount(Long partyId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(site_location.id) as count " +
				" from party_site as site_location  " +
				" left outer join party as party on party.party_id = site_location.party_id "+
		  		" where party.party_id = :partyId and site_location.active_flag = true "); 
		query.setParameter("partyId", partyId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
		
	}

	@Override
	public Long getFirmStaffListCount(Long firmId, List<Integer> listOfPersonType) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select count(staff.party_id) as count " +
				" from party as staff  " +
				" inner join party_relationship as relation on relation.subject = staff.party_id "+
		  		" left outer join person as person on person.party_id = staff.party_id" +
		  		" left outer join person_type as type on type.id = person.person_type" +
		  		" where relation.object = :firmId and staff.active_flag = true and " +
		  		" (type.id = :staffTypeId or type.id = :partnerTypeId or type.id = :firmAdminTypeId) "); 
		query.setParameter("firmId", firmId);
		query.setParameter("staffTypeId", listOfPersonType.get(0));
		query.setParameter("partnerTypeId", listOfPersonType.get(1));
		query.setParameter("firmAdminTypeId", listOfPersonType.get(2));
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<PersonDTO> getFirmStaffList(Long firmId,List<Integer> listOfPersonType,Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct staff.party_id as partyId, staff.name as name,staff.active_flag as activeFlag,relationshipType.type as relationshipType" +
				" ,type.type as role, emailComm.contact_detail as emailAddress, jobCode.short_name as jobTitle  " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" inner join relationship_type as relationshipType on relationshipType.id = relation.relationship_type " +
				" left outer join point_of_contact poc on poc.party_id = staff.party_id " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" left outer join person as person on person.party_id = staff.party_id " +
				" left outer join person_type as type on type.id = person.person_type" +
				" left outer join person_details as staffDetail on staffDetail.party_id = staff.party_id" +
				" left outer join code as jobCode on jobCode.id = staffDetail.job_title_code" +
				" where relation.object = :firmId and staff.active_flag = true and " +
				" (type.id = :staffTypeId or type.id = :partnerTypeId or type.id = :firmAdminTypeId) ");
		query.setParameter("firmId", firmId);
		query.setParameter("staffTypeId", listOfPersonType.get(0));
		query.setParameter("partnerTypeId", listOfPersonType.get(1));
		query.setParameter("firmAdminTypeId", listOfPersonType.get(2));
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("jobTitle")
											.addScalar("role")
											.addScalar("relationshipType")
											.addScalar("emailAddress")
											.addScalar("activeFlag")
											.setResultTransformer(Transformers.aliasToBean(PersonDTO.class))
											.list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public List<CodeDTO> getCodeDTOListForCodeType(Long codeType) {
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as id, code.short_name as shortName,code.long_description as longDescription,code_type.name as codeTypeName, " +
				" code.application_level_indicator as applicationLevelIndicator, parentCode.short_name as parentCodeShortName, code.active_flag as activeFlag " +
				" from code as code " +
				" left outer join code_type as code_type on code_type.id = code.code_type_id " +
				" left outer join code as parentCode on parentCode.id = code.parent_code_id " +
				" where code.code_type_id = :codeType and code.application_level_indicator =true and code.active_flag=true");
		query.setParameter("codeType", codeType);
		
		List resultWithAliasedBean = query.addScalar("id", Hibernate.LONG)
		  								.addScalar("shortName")
		  								.addScalar("longDescription")
		  								.addScalar("codeTypeName")
		  								.addScalar("applicationLevelIndicator")
		  								.addScalar("parentCodeShortName")
		  								.addScalar("activeFlag")
		  								.setResultTransformer(Transformers.aliasToBean(CodeDTO.class))
		  								.list();
		return resultWithAliasedBean;
	}
	
	@Override
	public List<KeyValue> getCodeDropdownListForCodeTypeAndParty(Long codeType, Long partyId, Long parentCodeTypeId) {
		
		List resultWithAliasedBean = new ArrayList();
		if(parentCodeTypeId == null){
			SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
					" select code.id as 'key', code.short_name as 'value'"+
					" from code as code " +
					" inner join party_code as party_code on party_code.code_id = code.id" +
					" inner join code_type as code_type on code_type.id = code.code_type_id " +
					" where party_code.party_id =:partyId and code.code_type_id = :codeType and party_code.active_flag=true");
			query.setParameter("codeType", codeType);
			query.setParameter("partyId",  partyId);
			
			resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
			  								.addScalar("value")
			  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
			  								.list();
		}else{
			SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
					" select code.id as 'key', code.short_name as 'value'"+
					" from code as code " +
					"  where code.code_type_id = :codeType and code.active_flag=true  and code.parent_code_id = :parentCodeTypeId");
			query.setParameter("codeType", codeType);
			query.setParameter("parentCodeTypeId",  parentCodeTypeId);
			resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
			  								.addScalar("value")
			  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
			  								.list();
		}
		return resultWithAliasedBean;
	}
	
	@Override
	public List<KeyValue> getPartyDropdownListForRelationship(Long partyId, Integer relationshipId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				"select party.party_id as 'key', party.name as 'value' " +
" from party " +
" join party_relationship on party_relationship.subject = party.party_id " + 
" join person_details on person_details.party_id = party.party_id " +
" where party_relationship.relationship_type = :relationshipId " +
" and party_relationship.object = :partyId " +
" and party.active_flag = true " + 
" and party_relationship.active_flag = true " +
" and person_details.no_of_shares_owned is null " +
" order by party.name ");
		query.setParameter("relationshipId", relationshipId);
		query.setParameter("partyId",  partyId);
		
		List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		return resultWithAliasedBean;
	}
	
	@Override
	public Long getRelatedPartyId(Long mainPartyId, Integer relationshipId){
		Long relatedPartyId = null;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				"select object as id from party_relationship"+ 
				" where party_relationship.relationship_type =:relationshipId and party_relationship.subject = :partyId"+
				" and party_relationship.active_flag = true");
		query.setParameter("relationshipId", relationshipId);
		query.setParameter("partyId",  mainPartyId);
		List<Long> relatedParties = query.addScalar("id", StandardBasicTypes.LONG).list();
		if(! relatedParties.isEmpty()){
			relatedPartyId = relatedParties.get(0);
		}
		return relatedPartyId;
	}

	@Override
	public Long getAdminCodeListCount(Long codeTypeId, Boolean applicationLevelId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select  count(code.id) as count" +
				" from code as code "+
				"  left outer join code_type as code_type on code_type.id = code.code_type_id "+
		  		" where code_type.id = :codeTypeId and code.application_level_indicator = :applicationLevelId");
		query.setParameter("codeTypeId", codeTypeId);
		query.setParameter("applicationLevelId",  applicationLevelId);
		query.addScalar("count", Hibernate.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public Long getMobileAdminCodeListCount(Long codeTypeId, Boolean applicationLevelId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select  count(code.id) as count" +
				" from code as code "+
				"  left outer join code_type as code_type on code_type.id = code.code_type_id "+
		  		" where code_type.id = :codeTypeId and code.application_level_indicator = :applicationLevelId");
		query.setParameter("codeTypeId", codeTypeId);
		query.setParameter("applicationLevelId",  applicationLevelId);
		query.addScalar("count", Hibernate.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}
	
	@Override
	public List<CodeDTO> getAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count) {
		Integer start = 0;
		Long longCount = count !=null ? count : 0 ;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as id, code.short_name as shortName,code.long_description as longDescription,code_type.name as codeTypeName, " +
				" code.application_level_indicator as applicationLevelIndicator, parentCode.short_name as parentCodeShortName, code.active_flag as activeFlag " +
				" from code as code " +
				" left outer join code_type as code_type on code_type.id = code.code_type_id " +
				" left outer join code as parentCode on parentCode.id = code.parent_code_id "+
				" where code_type.id = :codeTypeId and code.application_level_indicator = :applicationLevelId");
		query.setParameter("codeTypeId", codeTypeId);
		query.setParameter("applicationLevelId",  applicationLevelId);
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		  								.addScalar("shortName")
		  								.addScalar("longDescription")
		  								.addScalar("codeTypeName")
		  								.addScalar("applicationLevelIndicator")
		  								.addScalar("parentCodeShortName")
		  								.addScalar("activeFlag")
		  								.setResultTransformer(Transformers.aliasToBean(CodeDTO.class))
		  								.list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public List<CodeDTO> getMobileAdminCodeDTOList(Long codeTypeId, Boolean applicationLevelId, Long count) {
		Integer start = 0;
		Long longCount = count !=null ? count : 0 ;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as id, code.short_name as shortName,code.long_description as longDescription,code_type.name as codeTypeName, " +
				" code.application_level_indicator as applicationLevelIndicator, parentCode.short_name as parentCodeShortName, code.active_flag as activeFlag " +
				" from code as code " +
				" left outer join code_type as code_type on code_type.id = code.code_type_id " +
				" left outer join code as parentCode on parentCode.id = code.parent_code_id "+
				" where code_type.id = :codeTypeId and code.application_level_indicator = :applicationLevelId");
		query.setParameter("codeTypeId", codeTypeId);
		query.setParameter("applicationLevelId",  applicationLevelId);
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
		  								.addScalar("shortName")
		  								.addScalar("longDescription")
		  								.addScalar("codeTypeName")
		  								.addScalar("applicationLevelIndicator")
		  								.addScalar("parentCodeShortName")
		  								.addScalar("activeFlag")
		  								.setResultTransformer(Transformers.aliasToBean(CodeDTO.class))
		  								.list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public Long getCountOfCodeTypeByCodeTypeId(Long firmId, Long codeTypeId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select count(party_code.id) as count " +
				" from party_code as party_code " +
				" inner join code as code on code.id = party_code.code_id "+
				" inner join code_type as codeType on codeType.id = code.code_type_id "+
		  		" inner join party as party on party.party_id = party_code.party_id " +
		  		" where party.party_id = :firmId and codeType.id = :codeTypeId "); 
		query.setParameter("firmId", firmId);
		query.setParameter("codeTypeId", codeTypeId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	@Override
	public List<PartyCodeDTO> getListOfCodeTypeByCodeTypeId(Long count,
			Long firmId, Long codeTypeId) {
		Integer start = 0;
		Long longCount = (long) count;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select  party_code.id as partyCodeId,code.short_name as codeShortName, codeType.name as codeCodeTypeName, "+
				" codeType.application_level_indicator as codeApplicationLevelIndicator, parentCode.short_name as codeParentCodeShortName, " +
				" party_code.sort_order as sortOrder,party_code.active_flag as activeFlag " +
                " from party_code as party_code " +
                " inner join code as code on code.id = party_code.code_id "+
                " inner join code_type as codeType on codeType.id = code.code_type_id "+
                " left outer join code as parentCode on parentCode.id = code.parent_code_id "+
                " inner join party as party on party.party_id = party_code.party_id " +
                " where party.party_id = :firmId and codeType.id = :codeTypeId "); 
		query.setParameter("firmId", firmId);
		query.setParameter("codeTypeId", codeTypeId);
		List resultWithAliasedBean = query.addScalar("partyCodeId", StandardBasicTypes.LONG)
		                                   .addScalar("codeShortName")
		                                   .addScalar("codeCodeTypeName")
		                                   .addScalar("codeApplicationLevelIndicator")
		                                   .addScalar("codeParentCodeShortName")
		                                   .addScalar("sortOrder")
		                                   .addScalar("activeFlag")
		                                   .setResultTransformer(Transformers.aliasToBean(PartyCodeDTO.class))
		                                   .list().subList(start,start+longCount.intValue());
		return resultWithAliasedBean;
	}

	@Override
	public Long getRelatedClientId(Long id, Long accountCategoryId) {
		Long relatedClientId = null;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select party.party_id as id "+ 
				" from party_account as account " +
				" inner join party as party on party.party_id = account.party_id "+
				" where party.party_id = :id and account.account_category = :accountCategoryId");
		query.setParameter("id", id);
		query.setParameter("accountCategoryId",  accountCategoryId);
		List<Long> relatedClientIds = query.addScalar("id", StandardBasicTypes.LONG).list();
		if(! relatedClientIds.isEmpty()){
			relatedClientId = relatedClientIds.get(0);
		}
		return relatedClientId;
	}

	@Override
	public Long getFirmsCountById(Integer partyTypeId, Integer organizationTypeId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT count(firm.party_id) as count " +
				" from party as firm " +
				" left outer join organization as organization on organization.party_id = firm.party_id "+
		  		" where firm.party_type = :partyTypeId and organization.organization_type= :organizationTypeId "); 
		query.setParameter("partyTypeId", partyTypeId);
		query.setParameter("organizationTypeId", organizationTypeId);
		query.addScalar("count", StandardBasicTypes.LONG);
		List result = query.list();
		return (Long) (result.get(0));
	}

	/* (non-Javadoc)
	 * @see com.chiguru.pm.crm.dao.CRMDao#getFirmsListById(java.lang.Integer, java.lang.Integer, java.lang.Long)
	 */
	@Override
	public List<PartyDTO> getFirmsListById(Integer partyTypeId, Integer organizationTypeId,
			Long count) {
		Integer start = 0;
		Long longCount = (long) count;
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct organization.party_id as id, firm.name as name, officeNumber.contact_detail as officeNumber, " +
				" homeNumber.contact_detail as homeNumber, emailComm.contact_detail as emailAddress, firm.active_flag as activeFlag " +
				" from party as firm " +
				" left outer join organization as organization on organization.party_id = firm.party_id " +
				" left outer join point_of_contact as poc on poc.party_id = firm.party_id " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3 " +
				" left outer join communication as homeNumber on homeNumber.contact_point_id = poc.id and homeNumber.communication_Type = 3 and homeNumber.sub_type = 4 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" where firm.party_type = :partyTypeId and organization.organization_type= :organizationTypeId and firm.active_flag = 1");
		query.setParameter("partyTypeId", partyTypeId);
		query.setParameter("organizationTypeId", organizationTypeId);
		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("officeNumber")
											.addScalar("homeNumber")
											.addScalar("emailAddress")
											.addScalar("activeFlag")
											.setResultTransformer(Transformers.aliasToBean(PartyDTO.class))
											 .list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	@Override
	public List getEmailsList(List listOfPersonType) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select person.party_id as 'key', person.username as 'value' "+ 
				" from person person "+
				" where (person.username IS NOT NULL) and " +
				" (person.person_type = :PERSON_TYPE_STAFF or person.person_type = :PERSON_TYPE_PARTNER or person.person_type = :PERSON_TYPE_FIRM_ADMIN) ");
		query.setParameter("PERSON_TYPE_STAFF", listOfPersonType.get(0));
		query.setParameter("PERSON_TYPE_PARTNER", listOfPersonType.get(1));
		query.setParameter("PERSON_TYPE_FIRM_ADMIN", listOfPersonType.get(2));
		
		List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		
		return resultWithAliasedBean;
	}

	@Override
	public Object getUserById(Long partyRelationshipId) {
		return getHibernate().get(PMUser.class, partyRelationshipId);
	}

	
	@Override
	public List<Code> getListOfAdminCodes() {
		
		List<Code> listOfCode = getHibernate().find(" from Code as code " +
				" where (applicationLevelIndicator = true and codeType.id not in (1,2)) ");
		
	    return listOfCode;
	}

	@Override
	public void createPartyCodeForNewFirm(List<PartyCode> listOfPartCode) {
		for (PartyCode partyCode : listOfPartCode) {
			getHibernate().saveOrUpdate(partyCode);
		}
	}

	@Override
	@Transactional
	public void userThemeSave(String theme) {
		SecurityContext context = SecurityContextHolder.getContext();
		PMUser loggedInUser = null;
		if(context.getAuthentication()!= null && context.getAuthentication().getPrincipal() instanceof PMUser){
        	loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
        }
		String name = loggedInUser.getUsername();
		String[] parameterArray = {"theme","username"};
		Object[] parameterValues = {theme,name};
		SQLQuery query =  prepareSQLQuery(UPDATE_THEME, parameterArray, parameterValues);
		query.executeUpdate();
	}

	private SQLQuery prepareSQLQuery(String sqlQueryName, String[] parameterArray, Object[] parameterValues) {
		SQLQuery query =  getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(sqlQueryName);
		for(int i =0; i < parameterArray.length; i++){
			query.setParameter(parameterArray[i], parameterValues[i]);
		}
		return query;
	}

	@Override
	@Transactional
	public String userGetTheme(String loggedInUser) {
		String name = loggedInUser;
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select theme  from users where username = :USERNAME ");
		
		query.setParameter("USERNAME",name);
		List resultWithAliasedBean = query.list();
		
		return (String) resultWithAliasedBean.get(0);
	}
	
	@Override
	public boolean checkEntityExists(Serializable id, Class entityClass) {
		boolean exists = false;
		
		Object entity = getHibernateTemplate().get(entityClass, id);
		if(entity != null){
			exists = true;
		}
		
		return exists;
	}
	@Override
	public Boolean codeIsPresent(String shortDesc) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
		" select id as Id from code where  application_level_indicator = true and active_flag = true and short_name = :SD ");
         query.setParameter("SD",shortDesc);
         List resultWithAliasedBean = query.list();
         if(resultWithAliasedBean.size() > 0)
         {
        	return true;
         }else{
        	return false;
         }
       
	}

	@Override
	public Boolean partyCodeIsPresent(String shortDesc, Long firmId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
		" select code_id from party_code pc where pc.party_id = :FI and code_id in ( select distinct id from code c where c.short_name = :SD  and c.application_level_indicator = false) ");
         query.setParameter("SD",shortDesc);
         query.setParameter("FI",firmId);
         List resultWithAliasedBean = query.list();
         if(resultWithAliasedBean.size() > 0)
         {
        	return true;
         }else{
        	return false;
         }
	}

	@Override
	public void updateNotification(Date notificationDate, String to, Long taskId, Long newTaskId) {
			String[] parameterArray = {"notificationDate","to","taskId","newTaskId"};
			Object[] parameterValues = {notificationDate,to,taskId,newTaskId};
			SQLQuery query =  prepareSQLQuery(UPDATE_NOTIFICATION, parameterArray, parameterValues);
			query.executeUpdate();
		
	}

	@Override
	public List getFirmNameList() {
		//bug no 511
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select party.name as 'key', party.name as 'value' "+ 
				" from party "+
				" where party.active_flag = true " );
				
		List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		
		return resultWithAliasedBean;
	}

	/*@Override
	public Integer getParentCode(Long codeTypeId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select parent_code_type_id " +
				" from code_type " +
		  		" where id = :codeTypeId "); 
		query.setParameter("codeTypeId", codeTypeId);
		List result = query.list();
		return (Integer) (result.get(0));
	}
*/
	@Override
	public List getCodeDropdownListForCodeType(Long codeType) {
		
		List resultWithAliasedBean = new ArrayList();
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select code.id as 'key', code.short_name as 'value'"+
				" from code as code " +
				" where code.code_type_id = :codeType and code.active_flag=1 ");
		query.setParameter("codeType", codeType);
		resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		return resultWithAliasedBean;
	}

	@Override
	public Integer getPartySiteByPartyId(Long firmId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select ps.party_site_type as psId " +
				" from party_site ps " +
		  		" where ps.party_id = :firmId "); 
		query.setParameter("firmId", firmId);
		query.addScalar("psId", StandardBasicTypes.INTEGER);
		List result = query.list();
		return (Integer) (result.get(0));
	}
	
	@Override
	public void updatePartyAccount(PartyAccount account,
			List<PhoneCommunication> phonesToBeRemoved ) {
		 /* EntityManagerFactory entityManagerFactory;
		  EntityManager em = getEntityManager();
		  HibernateEntityManager hem = em.unwrap(HibernateEntityManager.class);*/
		  /*Session session = getHibernate().getSessionFactory().getCurrentSession();
		  session.persist(account);
		  session.saveOrUpdate(account);*/
		getHibernate().saveOrUpdate(account);
		   /*Session session =  getHibernate().getSessionFactory().getCurrentSession();
		   session.clear(); 
		   session.saveOrUpdate(account);*/
		/*String Name = NullHandleStr(account.getAccountEntityName());
		String Type = NullHandleStr(account.getAccountType().getShortName());
		String num = NullHandleStr(account.getAccountNumber());
		String add1 = NullHandleStr(account.getAddress().getAddressLine1());
		String add2 = NullHandleStr(account.getAddress().getAddressLine2());
		String city = NullHandleStr(account.getAddress().getCity());
		Long coun = account.getAddress().getCountryCode();
		Long state = account.getAddress().getStateCode();
		String conName = NullHandleStr(account.getDefaultPointOfContact().getContactName());
		String conTitle = NullHandleStr(account.getDefaultPointOfContact().getContactTitle());
		String email = NullHandleStr(account.getDefaultPointOfContact().getEmailList().get(0).getContactDetail());
		String fax = NullHandleStr(account.getDefaultPointOfContact().getFaxList().get(0).getContactDetail());
		String memo = NullHandleStr(account.getTerms());
		String phone1 = NullHandleStr(account.getDefaultPointOfContact().getPhoneList().get(0).getContactDetail());
		Integer phoneType1 = NullHandlerInt(account.getDefaultPointOfContact().getPhoneList().get(0).getSubType());
		String phone2 = NullHandleStr(account.getDefaultPointOfContact().getPhoneList().get(1).getContactDetail());
		Integer phoneType2 = NullHandlerInt(account.getDefaultPointOfContact().getPhoneList().get(1).getSubType());
		String phone3 = NullHandleStr(account.getDefaultPointOfContact().getPhoneList().get(2).getContactDetail());
		Integer phoneType3 = NullHandlerInt(account.getDefaultPointOfContact().getPhoneList().get(2).getSubType());
		String phone4 = NullHandleStr(account.getDefaultPointOfContact().getPhoneList().get(3).getContactDetail());
		Integer phoneType4 = NullHandlerInt(account.getDefaultPointOfContact().getPhoneList().get(3).getSubType());
		String phone5 = NullHandleStr(account.getDefaultPointOfContact().getPhoneList().get(4).getContactDetail());
		Integer phoneType5 = NullHandlerInt(account.getDefaultPointOfContact().getPhoneList().get(4).getSubType());
		String[] parameterArray = {"Name","Type","num","add1","add2","city","coun","state","conName","conTitle","email","fax","memo","phone1","phoneType1","phone2","phoneType2","phone3","phoneType3","phone4","phoneType4","phone5","phoneType5"};
		Object[] parameterValues = {Name,Type,num,add1,add2,city,coun,state,conName,conTitle,email,fax,memo,phone1,phoneType1,phone2,phoneType2,phone3,phoneType3,phone4,phoneType4,phone5,phoneType5};
		SQLQuery query =  prepareSQLQuery(UPDATE_SELECTED_ACCOUNT, parameterArray, parameterValues);
		query.executeUpdate();*/
	}

	private Integer NullHandlerInt(Integer subType) {
		if(subType != null){
			return subType;
		}
		return 0;
	}

	private String NullHandleStr(String Name) {
		if(Name != null){
			return Name;
		}
		return "";
	}

	@Override
	public List<PartyAccountDTO> getPartyAccountDTOListByIdNew(Long clientId,
			Long accountCategory, Page page) {
		Integer start = 0;
		Long longCount = (long) page.getCount();
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct account.id as newId, account.account_entity_name as accountFirmName, account_type.short_name as accountType, " +
				" account.account_number as accountNumber, poc.contact_name as contactName, officeNumber.contact_detail as officeNumber,  " +
				" emailComm.contact_detail as emailAddress " +
				" from party_account account " +
				" inner join party party on party.party_id = account.party_id " +
				" inner join code account_category on account_category.id = account.account_category " +
				" left outer join code account_type on account_type.id = account.account_type " +
				" left outer join point_of_contact poc on poc.account_id = account.id " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" where party.party_id = :clientId  and account_category.id = :accountCategory and account.active_flag = true");
		query.setParameter("clientId", clientId);
		query.setParameter("accountCategory", accountCategory);
		
		List resultWithAliasedBean = query.addScalar("newId", StandardBasicTypes.LONG)
											.addScalar("accountFirmName")
											.addScalar("accountType")
											.addScalar("accountNumber")
											.addScalar("contactName")
											.addScalar("officeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(PartyAccountDTO.class))
											 .list().subList(start, start + longCount.intValue());

		return resultWithAliasedBean;
	}

	
	@Override
	public String getLanguage(PMUser loggedInUser) {
		String user = loggedInUser.getUsername();
		SQLQuery query = getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(" select default_lang from users where username=:user");
		query.setParameter("user",user);
             List resultWithAliasedBean = query.list(); 
           return (String) resultWithAliasedBean.get(0);
	}

	public void changeLanguage(String newLanguage, String username) {
		String[] parameterArray = {"newLanguage","username"};
		Object[] parameterValues = {newLanguage,username};
		SQLQuery query =  prepareSQLQuery(DEF_UPDATE_LANGUAGE_SQL, parameterArray, parameterValues);
		query.executeUpdate();
	}

	public String getLanguageStr(String newuser) {
		String user = newuser;
		String[] parameterArray = {"newuser"};
		Object[] parameterValues = {newuser};
		SQLQuery query =  prepareSQLQuery(DEF_SELECT_LANGUAGE_SQL, parameterArray, parameterValues);
             List resultWithAliasedBean = query.list(); 
           return (String) resultWithAliasedBean.get(0);
	}

	public PartySite getPartySiteByNewPartyId(Long id) {
		PartySite newSite = null;
		List<PartySite> partysiteList = getHibernate().find("from PartySite partysite where party_id="+id);
		if(! partysiteList.isEmpty()){
			newSite = partysiteList.get(0);
		}
		return newSite;
	}

	public PointOfContact getpointOfContactByNewPartyId(Long id) {
		// TODO Auto-generated method stub
		return (PointOfContact)getHibernate().find("from PointOfContact poc where party_id="+id).get(0);
	}

	
	/*@Override
	public List<ClientListDTO> getClientList(Long firmId) {
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" SELECT distinct " +
				" ORG.`name` as name,@rownum ?= @rownum + 1 as slNo ,PSTYPE.name as addressType, ADDR.`address_line_1`as address1, ADDR.`address_line_2` as address2," +
				" ADDR.`city` as city, ADDR.`state` as state, ADDR.`postal_code` as postalCode, ADDR.`country` as country " +
				" FROM `party` AS PARTY, `party_relationship` AS REL,`organization` AS ORG, `party_site` AS PSITE,`party_site_type` AS PSTYPE," +
				" `address` AS ADDR,(SELECT @rownum ?= 0) r " +
				" WHERE PARTY.PARTY_ID = REL.OBJECT AND REL.SUBJECT = ORG.PARTY_ID " +
				" AND ORG.ORGANIZATION_TYPE = 2 AND ORG.PARTY_ID = PSITE.PARTY_ID " +
				" AND PSITE.ADDRESS_ID = ADDR.ID AND PSTYPE.id = PSITE.party_site_type " +
				" AND PARTY.party_id=:firmId");
		query.setString(0, ":");
		query.setString(1, ":");
		query.setParameter("firmId", firmId);
		
		List resultWithAliasedBean = query.addScalar("slNo", StandardBasicTypes.INTEGER)
											.addScalar("name")
											.addScalar("addressType")
											.addScalar("address1")
											.addScalar("address2")
											.addScalar("city")
											.addScalar("state")
											.addScalar("postalCode")
											.addScalar("country")
											.setResultTransformer(Transformers.aliasToBean(ClientListDTO.class))
											.list();

		return resultWithAliasedBean;
	}
*/
	
	public List<PersonDTO> getFirmStaffList(Long firmId,
			List<Integer> listOfPersonType, int limit, int offset){
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct staff.party_id as partyId, staff.name as name,staff.active_flag as activeFlag,relationshipType.type as relationshipType" +
				" ,type.type as role, emailComm.contact_detail as emailAddress, jobCode.short_name as jobTitle  " +
				" from party as staff " +
				" inner join party_relationship as relation on relation.subject = staff.party_id " +
				" inner join relationship_type as relationshipType on relationshipType.id = relation.relationship_type " +
				" left outer join point_of_contact poc on poc.party_id = staff.party_id " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" left outer join person as person on person.party_id = staff.party_id " +
				" left outer join person_type as type on type.id = person.person_type" +
				" left outer join person_details as staffDetail on staffDetail.party_id = staff.party_id" +
				" left outer join code as jobCode on jobCode.id = staffDetail.job_title_code" +
				" where relation.object = :firmId and staff.active_flag = true and " +
				" (type.id = :staffTypeId or type.id = :partnerTypeId or type.id = :firmAdminTypeId) " +
		        " limit :limit offset :offset");
		query.setParameter("firmId", firmId);
		query.setParameter("staffTypeId", listOfPersonType.get(0));
		query.setParameter("partnerTypeId", listOfPersonType.get(1));
		query.setParameter("firmAdminTypeId", listOfPersonType.get(2));
		query.setParameter("limit", limit);
		query.setParameter("offset", offset);
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("jobTitle")
											.addScalar("role")
											.addScalar("relationshipType")
											.addScalar("emailAddress")
											.addScalar("activeFlag")
											.setResultTransformer(Transformers.aliasToBean(PersonDTO.class))
											.list();  
		return resultWithAliasedBean;
		
	}
	
	@Override
	public List<PartyDTO> getMobilePartyDTOListById(Long objectPartyId,
			Integer relationshipTypeId, int offset, int limit) {
		/*Integer start = offset;
		Long longCount = (long) limit;*/
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct client.party_id as partyId, client.name as name, inChargePerson.name as inChargePerson, " +
				" phonComm.contact_detail as officeNumber, emailComm.contact_detail as emailAddress " +
				" from organization as client " +
				" inner join party_relationship as relation on relation.subject = client.party_id " +
				" left outer join party as inChargePerson on client.in_charge_person = inChargePerson.party_id " +
				" left outer join point_of_contact poc on poc.party_id = client.party_id " +
				" inner join party_site as site on poc.party_site_id = site.id " +
				" left outer join communication as phonComm on phonComm.contact_point_id = poc.id and phonComm.communication_Type = 3 and phonComm.sub_type = 3 " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
				" inner join party as subject on subject.party_id = client.party_id " +
				" where relation.object = :objectPartyId and relation.relationship_type = :relationshipTypeId and site.party_site_type = 1 and subject.active_flag= true" +
				" limit :limit offset :offset");
		query.setParameter("objectPartyId", objectPartyId);
		query.setParameter("relationshipTypeId", relationshipTypeId);
		query.setParameter("limit", limit);
		query.setParameter("offset", offset);
              
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("inChargePerson")
											.addScalar("officeNumber")
											.addScalar("emailAddress")
											.setResultTransformer(Transformers.aliasToBean(PartyDTO.class))
										   	 .list();

		return resultWithAliasedBean;
	}

	@Override
	public List<CodeType> getCodeTypeListDropdown() {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery( " Select id, name from " +
				" code_type ");
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
										  .addScalar("name")
										  .setResultTransformer(Transformers.aliasToBean(CodeType.class))
										  .list();
		return resultWithAliasedBean;
	}

	@Override
	public void deleteBank(boolean activeFlag, String delList,Long accountCategory) {
		String[] parameterArray = {"activeFlag","delList","accountCategory"};
		Object[] parameterValues = {activeFlag,delList,accountCategory};
		String sql = String.format(DELETE_SELECTED_PARTYACCOUNT,activeFlag, delList,accountCategory);
		SQLQuery query =  getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(sql);
		query.executeUpdate();
	}
	
	@Override
	public void deleteStaff(boolean activeFlag,Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PARTY, parameterArray, parameterValues);
		query.executeUpdate();
	}
	
	@Override
	public List<PartyAccount> getAccountListByPartyAndCategory(Long id,
			Long clientId, Long accountCategory) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteLocation(boolean activeFlag,  Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PARTYSITE, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteFirmStaff(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PARTY, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteCode(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PARTYCODE, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteFirmList(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PARTY, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteJurisdictions(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_JURISDICTION, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteCodeTypeAdmn(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_CODE_TYPE, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteAdminCode(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_CODE, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteTemplate(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_TEMPLATE, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteRecepient(boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_RECEPIENT, parameterArray, parameterValues);
		query.executeUpdate();
	}

	@Override
	public void deleteOfficer(Long newId) {
		String[] parameterArray = {"newId"};
		Object[] parameterValues = {newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_OFFICER, parameterArray, parameterValues);
		query.executeUpdate();
	}

	public List<PartyDTO> getMobilePartyDTOList(int start, int limit,Integer partyTypeId, Integer orgTypeId) {
		
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select distinct organization.party_id as id, firm.name as name,  " +
				"  officeNumber.contact_detail as officeNumber,  " +
				" homeNumber.contact_detail as homeNumber,  " +
				" emailComm.contact_detail as emailAddress,  " +
				" firm.active_flag as activeFlag  " +
				" from party as firm  " +
				" left outer join organization as organization on organization.party_id = firm.party_id   " +
				" left outer join point_of_contact as poc on poc.party_id = firm.party_id  " +
				" left outer join communication as officeNumber on officeNumber.contact_point_id = poc.id and officeNumber.communication_Type = 3 and officeNumber.sub_type = 3  " +
				"  left outer join communication as homeNumber on homeNumber.contact_point_id = poc.id and homeNumber.communication_Type = 3 and homeNumber.sub_type = 4  " +
				" left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1  " +
				" where firm.party_type = :partyTypeId and organization.organization_type= :orgTypeId "+
				" limit :limit offset :offset");
		query.setParameter("partyTypeId", partyTypeId);
		query.setParameter("orgTypeId", orgTypeId);
		query.setParameter("limit", limit);
		query.setParameter("offset", start);
              
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("name")
											.addScalar("officeNumber")
											.addScalar("homeNumber")
											.addScalar("emailAddress")
											.addScalar("activeFlag")
											.setResultTransformer(Transformers.aliasToBean(PartyDTO.class))
										   	 .list();

		return resultWithAliasedBean;
	}

	public Boolean isValidUser(String userName, String userResetPasswordKey) {
		String[] parameterArray = {"userName","userKey"};
		Object[] parameterValues = {userName,userResetPasswordKey};
		SQLQuery query =  prepareSQLQuery(DEF_VERIFY_USER_SQL, parameterArray, parameterValues);
		Boolean status = false;
		if(!query.list().isEmpty()){
			status = true;
		}
		return status;
	}

	public void savePassword(String username, String newPassword) {
		String[] parameterArray = {"username","newPassword"};
		Object[] parameterValues = {username,newPassword};
		SQLQuery query =  prepareSQLQuery(DEF_UPDATE_PASSWORD_SQL, parameterArray, parameterValues);
		query.executeUpdate();
	}

	public List getPartyDropdownListForOfficersEdit(Long firmId,
			Integer relationshipId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				"select party.party_id as 'key', party.name as 'value' " +
                " from party " +
                " join party_relationship on party_relationship.subject = party.party_id " + 
                " join person_details on person_details.party_id = party.party_id " +
                " where party_relationship.relationship_type = :relationshipId " +
                " and party_relationship.object = :partyId " +
                " and party.active_flag = true " + 
                " and party_relationship.active_flag = true " +
                " order by party.name ");
		query.setParameter("relationshipId", relationshipId);
		query.setParameter("partyId",  firmId);
		
		List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		return resultWithAliasedBean;
	}

	public List getPartyDropdownListForRelationshipWithoutShares(Long firmId,
			Integer relationshipId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
		"select party.party_id as 'key', party.name as 'value' " +
				" from party " +
				" join party_relationship on party_relationship.subject = party.party_id " + 
				" join person_details on person_details.party_id = party.party_id " +
				" where party_relationship.relationship_type = :relationshipId " +
				" and party_relationship.object = :partyId " +
				" and party.active_flag = true " + 
				" and party_relationship.active_flag = true " +
				" order by party.name ");
						query.setParameter("relationshipId", relationshipId);
						query.setParameter("partyId",  firmId);
						
						List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
						  								.addScalar("value")
						  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
						  								.list();
						return resultWithAliasedBean;
	}

	@Transactional
	public CredentialsDTO getUserCredentials(String module, Long partyId,
			String role) {
		String[] parameterArray = {"module","partyId","role"};
		Object[] parameterValues = {module,partyId,role};
		SQLQuery query =  prepareSQLQuery(DEF_SELECTED_USER_CREDENTIALS, parameterArray, parameterValues);
		List resultWithAliasedBean = query.addScalar("partyId", StandardBasicTypes.INTEGER)
				.addScalar("module")
				.addScalar("role")
				.addScalar("credential", StandardBasicTypes.INTEGER)
				.setResultTransformer(Transformers.aliasToBean(CredentialsDTO.class))
				.list(); 
        return (CredentialsDTO) resultWithAliasedBean.get(0);
	}
}
