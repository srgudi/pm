package com.chiguru.pm.tax.dao;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.tax.domain.*;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;

import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateAccessor;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository("taxModuleDao")
@SuppressWarnings("unchecked")
public class TaxModuleDaoImpl extends HibernateDaoSupport implements TaxModuleDao {
	
	public static final String DELETE_SELECTED_PRACTICEINFO = "UPDATE tax_client_practice_info SET active_flag = :activeFlag WHERE id = :delList";
	public static final String DELETE_SELECTED_TAX_FIRM_PRACTICE_TYPE = "UPDATE tax_firm_practice_type SET active_flag = :activeFlag WHERE id = :delList";
	public static final String  DELETE_SELECTED_RELATEDTASK = "UPDATE task SET active_flag = :activeFlag WHERE practice_client_info_id = :delList";
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

    private SQLQuery prepareSQLQuery(String sqlQueryName, String[] parameterArray, Object[] parameterValues) {
		SQLQuery query =  getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(sqlQueryName);
		for(int i =0; i < parameterArray.length; i++){
			query.setParameter(parameterArray[i], parameterValues[i]);
		}
		return query;
	}
    @Override
    public List<ClientPracticeInfo> getClientPracticeInfo(
            Long firmPracticeType, Long clientId) {
        return getHibernate()
                .find("from ClientPracticeInfo where firmPracticeType.id=" +
                        firmPracticeType + " and client.id=" + clientId);
    }

    public List<FirmPracticeType> getFirmPracticeTypeList(Long firmId) {
        return getHibernate().findByNamedQuery("firmPracticeType.findPracticeByFirmId",
                new Object[]{firmId});
    }

    public void saveTaxPracticeInfo(ClientPracticeInfo practiceInfo) {
    	//getHibernateTemplate().merge(practiceInfo);
        getHibernateTemplate().saveOrUpdate(practiceInfo);
    }

    @Override
    public void saveFirmPracticeInfo(FirmPracticeType type) {
        getHibernateTemplate().saveOrUpdate(type);
    }

    //sagar
    @Override
    public List<TaxDTO> getPracticeTypeList(Long firmId) {
       // return getHibernate().find(" from PracticeType inner ");
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
        		" select firm_practice_type.id as taxId, application_practice_type.name as name, " +
                " application_practice_type.description as description, firm_practice_type.active_flag as activeFlag " +
                " from tax_firm_practice_type as firm_practice_type " +
                " inner join tax_application_practice_type as application_practice_type on application_practice_type.id = firm_practice_type.practice_id " +
                " where firm_practice_type.firm_id = :firmId and firm_practice_type.active_flag = true" );
        query.setParameter("firmId", firmId);
        List resultWithAliasedBean = query.addScalar("taxId", StandardBasicTypes.LONG)
        							.addScalar("name")
        							.addScalar("description")
        							.addScalar("activeFlag")
        							.setResultTransformer(Transformers.aliasToBean(TaxDTO.class))
        							.list();
        return resultWithAliasedBean;
    }

    @Override
    public FirmPracticeType getFirmPracticeTypeById(Long id) {
        return getHibernate().get(FirmPracticeType.class, id);
    }

    public TaxInfoFilingType getTaxInfoFilingType(Integer id) {
        return getHibernate().get(TaxInfoFilingType.class, id);
    }

    @Override
    public ClientPracticeInfo getClientPracticeInfo(Long id) {
        return getHibernate().get(ClientPracticeInfo.class, id);
    }

    @Override
    public DueDateRule getDueDateForId(Long id) {
        return getHibernate().get(DueDateRule.class, id);
    }

    @Override
    public List<Task> getTaskList() {
        return null;
    }

    @Override
    public List<Long> getTasksByTaskId(Long taskId, String sortName,
                                       String sortType, Integer start, Integer maxResults) {
        int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        return getHibernate()
                .findByNamedQuery("task.findtask_by_id_with_order", new Object[]{status_id, taskId});
    }

    @Override
    public List<Long> getTasksByTaskId(Long taskId) {
        return getHibernate()
                .findByNamedQuery("task.findtask_by_task_id", new Object[]{taskId});
    }


    @Override
    public Task getTaskById(Long taskId) {
//        return getHibernate().get(Task.class, taskId);
        List<Task> listOfTask = getHibernate().find("from Task task where task.id =" + taskId);
        return listOfTask.get(0);
    }

    @Override
    public List<TaskStatus> getTaskStatusList() {
        return getHibernate().find("from TaskStatus");
    }

    @Override
    public void saveTask(Task task) {
        getHibernateTemplate().saveOrUpdate(task);
    }

    @Override
    public TaskStatus getStatusById(Integer statusId) {
        return getHibernate().get(TaskStatus.class, statusId);
    }

    @Override
    public Long getDefaultFirmPracticeIdByFirmId(Long firmId) {
        List<Long> firmPracticeIdList = getHibernate()
                .find("select id " +
                        "from FirmPracticeType firmPracticeType where firmPracticeType.organization.id=" +
                        firmId);
        Long firmPracticeId = firmPracticeIdList.isEmpty() ? null
                : firmPracticeIdList.get(0);

        return firmPracticeId;
    }

    @Override
    public FilingDueDateRule getFilingDueDateRuleForId(Long id) {
        return getHibernate().get(FilingDueDateRule.class, id);
    }

    @Override
    public InstallmentDueDateRule getInstallmentDueDateRuleForId(Long id) {
        return getHibernate().get(InstallmentDueDateRule.class, id);
    }

    @Override
    public void deleteDueDateRules(List[] delteListArray) {
        if ((delteListArray != null) && (delteListArray.length >= 2)) {
            List filingDueDateDeleteList = delteListArray[0];
            List installmentDueDateDeleteList = delteListArray[1];
            List filingReminderDeleteList = delteListArray[2];
            List installmentReminderDeleteList = delteListArray[3];

            getHibernate().deleteAll(filingDueDateDeleteList);
            getHibernate().deleteAll(installmentDueDateDeleteList);
            getHibernate().deleteAll(filingReminderDeleteList);
            getHibernate().deleteAll(installmentReminderDeleteList);
            logger.debug("Deletion complete !!!");
        }
        logger.debug("exiting deleteDueDateRules() ");
    }

    @Override
    public FilingReminderRule getFilingReminderRuleById(Long id) {
        return getHibernate().get(FilingReminderRule.class, id);
    }

    @Override
    public InstallmentReminderRule getInstallmentReminderRuleById(Long id) {
        return getHibernate().get(InstallmentReminderRule.class, id);
    }

    @Override
    public List<FirmPracticeType> getFirmPracticeTypeByTypeId(Long id) {
        return getHibernate().findByNamedQuery("firmPracticeType.findPracticeTypeById", new Object[]{id});
    }

    @Override
    public List<Party> getPartyByTaskId(Long id) {
        return getHibernate().findByNamedQuery("task.findparty_by_task_id", new Object[]{id});
    }

    @Override
    public List<FirmPracticeType> getAllFirmPracticeTypeList(Long firmId) {
        return getHibernate().find("from FirmPracticeType firmPractiveType where firmPractiveType.organization.id =" + firmId);
    }

    @Override
    public PracticeType getPracticeTypeById(Long practiceTypeId) {
        return getHibernate().get(PracticeType.class, practiceTypeId);
    }

    @Override
    public Long getTaxDTOListCount(Long firmId) {
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                " SELECT count(firm_practice_type.id) as count " +
                        " from tax_firm_practice_type as firm_practice_type " +
                        " where firm_practice_type.firm_id = :firmId ");
		query.setParameter("firmId", firmId);
        query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        return (Long) (result.get(0));

    }

    @Override
    public List<TaxDTO> getTaxDTOList(Long firmId,int limit, int offset) {
       /* Integer start = 0;
        Long longCount = (long) count;*/
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                " select firm_practice_type.id as taxId, application_practice_type.name as name, " +
                        " application_practice_type.description as description, firm_practice_type.active_flag as activeFlag " +
                        " from tax_firm_practice_type as firm_practice_type " +
                        " inner join tax_application_practice_type as application_practice_type on application_practice_type.id = firm_practice_type.practice_id " +
                        " where firm_practice_type.firm_id = :firmId " +
                        " limit :limit offset :offset");
        query.setParameter("firmId", firmId);
        query.setParameter("limit", limit);
		query.setParameter("offset", offset);
        List resultWithAliasedBean = query.addScalar("taxId", StandardBasicTypes.LONG)
                							.addScalar("name")
                							.addScalar("description")
                							.addScalar("activeFlag")
                							.setResultTransformer(Transformers.aliasToBean(TaxDTO.class))
                							.list();
        return resultWithAliasedBean;
    }

	@Override
	public List<PracticeType> getPractTypesByFirmId(Long firmId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select application_practice_type.id as 'key', application_practice_type.name as 'value' "+
				" from tax_firm_practice_type as firm_practice_type " +
				" inner join tax_application_practice_type as application_practice_type on application_practice_type.id = firm_practice_type.practice_id " +
				" where firm_practice_type.active_flag = true and firm_practice_type.firm_id = :firmId");
		query.setParameter("firmId",  firmId);
		List resultWithAliasedBean = query.addScalar("key", StandardBasicTypes.STRING)
		  								.addScalar("value")
		  								.setResultTransformer(Transformers.aliasToBean(KeyValue.class))
		  								.list();
		return resultWithAliasedBean;
	}

	@Override
	public Long getClientPracticeInfoCount(Long firmPracticeId, Long clientId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                		" select count(clientPracticeInfo.id) as count " +
                        " from tax_client_practice_info as clientPracticeInfo " +
                        " where clientPracticeInfo.tax_firm_practice_type = :firmPracticeId and clientPracticeInfo.client = :clientId ");
		query.setParameter("firmPracticeId", firmPracticeId);
		query.setParameter("clientId", clientId);
        query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        return (Long) (result.get(0));
	}

	@Override
	public List<ClientPracticeInfoDTO> getClientPracticeInfoList(Long firmPracticeId,
			Long clientId, Long count) {
		Integer start = 0;
        Long longCount = (long) count;
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                		" select clientPracticeInfo.id as clientPracticeInfoId, client.name as clientName, jurisdiction.country as juriCountry, jurisdiction.state as juriState, " +
                        " staffInChange.name as staffInChargeName, clientStaff.name as clientStaffInChargeName, appPracticeType.name as taxReturn, " +
                        " clientPracticeInfo.create_user_id as taskCreator, clientPracticeInfo.create_date as taskCreatedDate, clientPracticeInfo.active_flag as activeFlag " +
                        " from tax_client_practice_info as clientPracticeInfo" +
                        " inner join jurisdiction as jurisdiction on clientPracticeInfo.jurisdiction = jurisdiction.id " +
                        " inner join party as client on clientPracticeInfo.client = client.party_id" +
                        " inner join party as staffInChange on clientPracticeInfo.staff_in_charge = staffInChange.party_id" +
                        " inner join party as clientStaff on clientPracticeInfo.client_staff_in_charge = clientStaff.party_id" +
                        " inner join tax_firm_practice_type as firmPracticeType on clientPracticeInfo.tax_firm_practice_type = firmPracticeType.id" +
                        " inner join tax_application_practice_type as appPracticeType on firmPracticeType.practice_id = appPracticeType.id " +
                        " where clientPracticeInfo.tax_firm_practice_type = :firmPracticeId and clientPracticeInfo.client = :clientId ");
        query.setParameter("firmPracticeId", firmPracticeId);
        query.setParameter("clientId", clientId);
        List resultWithAliasedBean = query.addScalar("clientPracticeInfoId", StandardBasicTypes.LONG)
                							.addScalar("clientName")
                							.addScalar("juriCountry")
                							.addScalar("juriState")
                							.addScalar("staffInChargeName")
                							.addScalar("clientStaffInChargeName")
                							.addScalar("taxReturn")
                							.addScalar("taskCreator")
                							.addScalar("taskCreatedDate")
                							.addScalar("activeFlag")
                							.setResultTransformer(Transformers.aliasToBean(ClientPracticeInfoDTO.class))
                							.list().subList(start, start + longCount.intValue());
        return resultWithAliasedBean;
	}

	public Long getCliPracInfoCount(Long clientId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
        		" select count(clientPracticeInfo.id) as count " +
                " from tax_client_practice_info as clientPracticeInfo " +
                " where clientPracticeInfo.client = :clientId ");
        query.setParameter("clientId", clientId);
        query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
       return (Long) (result.get(0));
	}

	public List<ClientPracticeInfoDTO> getCliPracInfoList(Long clientId,
			Long count) {
		Integer start = 0;
        Long longCount = (long) count;
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                		" select clientPracticeInfo.id as clientPracticeInfoId, client.name as clientName, jurisdiction.country as juriCountry, jurisdiction.state as juriState, " +
                        " staffInChange.name as staffInChargeName, clientStaff.name as clientStaffInChargeName, appPracticeType.name as taxReturn, " +
                        " clientPracticeInfo.create_user_id as taskCreator, clientPracticeInfo.create_date as taskCreatedDate, clientPracticeInfo.active_flag as activeFlag " +
                        " from tax_client_practice_info as clientPracticeInfo" +
                        " inner join jurisdiction as jurisdiction on clientPracticeInfo.jurisdiction = jurisdiction.id " +
                        " inner join party as client on clientPracticeInfo.client = client.party_id" +
                        " inner join party as staffInChange on clientPracticeInfo.staff_in_charge = staffInChange.party_id" +
                        " inner join party as clientStaff on clientPracticeInfo.client_staff_in_charge = clientStaff.party_id" +
                        " inner join tax_firm_practice_type as firmPracticeType on clientPracticeInfo.tax_firm_practice_type = firmPracticeType.id" +
                        " inner join tax_application_practice_type as appPracticeType on firmPracticeType.practice_id = appPracticeType.id " +
                        " where clientPracticeInfo.client = :clientId ");
        
        query.setParameter("clientId", clientId);
        List resultWithAliasedBean = query.addScalar("clientPracticeInfoId", StandardBasicTypes.LONG)
                							.addScalar("clientName")
                							.addScalar("juriCountry")
                							.addScalar("juriState")
                							.addScalar("staffInChargeName")
                							.addScalar("clientStaffInChargeName")
                							.addScalar("taxReturn")
                							.addScalar("taskCreator")
                							.addScalar("taskCreatedDate")
                							.addScalar("activeFlag")
                							.setResultTransformer(Transformers.aliasToBean(ClientPracticeInfoDTO.class))
                							.list().subList(start, start + longCount.intValue());
        return resultWithAliasedBean;
	}

	@Override
	public void deleteClientPracticeInfo(boolean activeFlag,Long delList){
		String[] parameterArray = {"activeFlag","delList"};
		Object[] parameterValues = {activeFlag,delList};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_PRACTICEINFO, parameterArray, parameterValues);
		//SQLQuery query1 = prepareSQLQuery(DELETE_SELECTED_RELATEDTASK, parameterArray, parameterValues);
		query.executeUpdate();
		//query1.executeUpdate();
	}
	
	@Override
	public void deleteRelatedTask(boolean activeFlag,Long delList){
		String[] parameterArray = {"activeFlag","delList"};
		Object[] parameterValues = {activeFlag,delList};
		SQLQuery query = prepareSQLQuery(DELETE_SELECTED_RELATEDTASK, parameterArray, parameterValues);
		query.executeUpdate();
	}
	
	@Override
	public void deleteTax(boolean activeFlag, Long delList) {
		String[] parameterArray = {"activeFlag","delList"};
		Object[] parameterValues = {activeFlag,delList};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_TAX_FIRM_PRACTICE_TYPE, parameterArray, parameterValues);
		query.executeUpdate();
	}
	
	@Override
	public String getFirmStaffName(Long id){
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select name from party where party_id = :ID ");
		
		query.setParameter("ID",id);
		List resultWithAliasedBean = query.list();
		
		return (String) resultWithAliasedBean.get(0);	
	}

	public List<PaymentType> getPaymentTypeList() {
		 return getHibernate().find("from PaymentType");
	}
	
	

}
