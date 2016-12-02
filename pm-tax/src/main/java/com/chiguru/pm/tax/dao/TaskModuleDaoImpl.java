package com.chiguru.pm.tax.dao;

import com.chiguru.pm.crm.dto.BaseTaskDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.tax.domain.*;
import com.chiguru.pm.tax.dto.EventDTO;
import com.chiguru.pm.tax.dto.TaskDTO;

import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateAccessor;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Repository("taskModuleDao")
public class TaskModuleDaoImpl extends HibernateDaoSupport
        implements TaskModuleDao {
    private Logger logger = Logger.getLogger(TaskModuleDaoImpl.class);
    
    public static final String  DELETE_SELECTED_TASK = "UPDATE task SET active_flag = :activeFlag WHERE id = :newId";
    @Autowired
    public void setDaoSessionFactory(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    private HibernateTemplate getHibernate() {
        HibernateTemplate template = getHibernateTemplate();
        template.setAllowCreate(false);
        template.setFlushMode(HibernateAccessor.FLUSH_AUTO);

        return template;
    }

    @Override
    public Task getTaskById(Long taskId) {
        return getHibernate().get(Task.class, taskId);
    }

    @Override
    public Long getTasksCountByDueDate(Date dueDate, Long partyId) {
        int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();

        //java.sql.Date tempDate = new java.sql.Date(((Date) dueDate).getTime());

        //Object[] paraArray = {status_id,tempDate};		
        Object[] paraArray = {status_id, partyId};

        //List result= getHibernate().findByNamedQuery("taskinfo.findtask_count_by_id",paraArray);
        List<Long> result = getHibernate().findByNamedQuery("task.findtask_count_by_duedate",
                paraArray);

        return (Long) (result.get(0));
    }

    @Override
    public List<Long> getTasksByDueDate(Date dueDate, Long count, Long partyId) {
        int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        Object[] paraArray = {status_id, partyId};
        Integer start = 0;

        return getHibernate().findByNamedQuery("task.findtask_by_duedate_with_order",
                paraArray).subList(start, start + count.intValue());
    }

    @Override
    public TaskStatus getTaskStatusById(Integer id) {
        return getHibernate().load(TaskStatus.class, id);
    }

    @Override
    public void generateTasks(List<BaseTask> taskList) {
        for (BaseTask task : taskList) {
            getHibernate().saveOrUpdate(task);
            getHibernate().saveOrUpdate(task.getTaxInfoDueDateRule());
        }
    }

    public Calendar getTodaysCalendar() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        return cal;
    }

    public Calendar addRecurringRange(Calendar cal, int field,
                                      int toBeAddedValue) {
        int current = cal.get(field);
        cal.set(field, current + toBeAddedValue);

        return cal;
    }

    @Override
    public List<DueDateRule> getRecurringEvents(Date recurringDate) {
    	//Sagar: please remove "Date recurringDate" as an argument in future.
//        Object[] paraArray = {recurringDate};
        return getHibernate().findByNamedQuery("dueDateRule.checkForNewEventGeneration");
    }

    @Override
    public Long getTaskNotificationCountbyDate(Date notificationDate) {
        //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        java.sql.Date tempDate = new java.sql.Date(((Date) notificationDate).getTime());

        //Object[] paraArray = {status_id,tempDate};		
        Object[] paraArray = {tempDate};

        //List result= getHibernate().findByNamedQuery("taskinfo.findtask_count_by_id",paraArray);
        List result = getHibernate().findByNamedQuery("tasknotification.findtasknotification_count_by_tasknotification_id",
                paraArray);

        return (Long) (result.get(0));
    }

    @Override
    @Transactional
    public TaskNotification getTaskNotificationById(Long taskNotificationId) {
        return getHibernate().get(TaskNotification.class, taskNotificationId);
    }

    @Override
    @Transactional    
    public List<Long> getNotificationCountByDate(Date notificationDate) {
        java.sql.Date tempDate = new java.sql.Date(((Date) notificationDate).getTime());

        //Object[] paraArray = {status_id,tempDate};		
        Object[] paraArray = {tempDate};

        return getHibernate().findByNamedQuery("tasknotification.findtasknotification_by_id_with_order", paraArray);
    }

    @Override
    public TaskNotificationTemplate getTaskNotificationTemplate(
            Long notificationTempId) {
        return getHibernate().get(TaskNotificationTemplate.class, notificationTempId);
    }

    @Override
    public Long getTaskNotificationRecipientCount(Long notificationTempId) {
        Object[] paraArray = {notificationTempId};

        //List result= getHibernate().findByNamedQuery("taskinfo.findtask_count_by_id",paraArray);
        List<Long> result = getHibernate().findByNamedQuery("tasknotificationrecipient.findrecipient_count_by_template_id",
                paraArray);

        return (Long) (result.get(0));

    }

    @Override
    public TaskNotificationRecipient getNotificationRecipient(
            Long notificationTypeId) {
        return getHibernate().get(TaskNotificationRecipient.class, notificationTypeId);
    }

    @Override
    public List<Long> getTaskNotificationRecipientCountById(
            Long notificationTempId) {
        Object[] paraArray = {notificationTempId};

        return getHibernate().findByNamedQuery("tasknotificationrecipient.findrecipient_by_template_id_with_order", paraArray);
    }

    @Override
    public List<TaskNotificationTemplate> getTaskNotificationTemplateList() {
        return getHibernate().find("from TaskNotificationTemplate notificationTemplate where active_flag=true");
    }

    @Override
    public void saveTaskNotificationTemplate(
            TaskNotificationTemplate notificationTemplate) {
        getHibernate().saveOrUpdate(notificationTemplate);
    }

    @Override
    public void saveTaskNotificationRecipient(
            TaskNotificationRecipient notificationRecipient) {
        getHibernate().saveOrUpdate(notificationRecipient);
    }

    @Override
    public List<TaskNotificationRecipient> getTaskNotificationRecipientList() {
        return getHibernate().find("from TaskNotificationRecipient notificationRecipient");
    }

    @Override
    public void saveTaskNotification(TaskNotification taskNotification) {
        getHibernate().saveOrUpdate(taskNotification);
    }

    @Override
    public List<Task> getTasksListAssignedForAStaff(Date dueDate, Long count,
                                                    Long partyId) {
        int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        Object[] paraArray = {status_id, partyId};
        Integer start = 0;

        return getHibernate().findByNamedQuery("task.findtask_by_staff_with_order",
                paraArray).subList(start, start + count.intValue());
    }

    @Override
    public List<Task> getTasksListForAFirm(Long count, Long mainPartyId) {
        int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        Object[] paraArray = {status_id, mainPartyId};
        Integer start = 0;
        return getHibernate().findByNamedQuery("task.findtasks_for_firm_with_order",
                paraArray).subList(start, start + count.intValue());
    }

    @Override
    public Long getTasksCount(Long partyId) {
        Object[] paraArray = {TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId(), partyId};
        return (Long) getHibernate().findByNamedQuery("task.findtask_count_by_id", paraArray).get(0);
    }

    @Override
    public Long getTaskCountFromNativeSQL(Long mainPartyId) {
        Integer completeStatus = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        List DONOT_WANT_STATUS_LIST = new ArrayList();
        DONOT_WANT_STATUS_LIST.add(completeStatus);

        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                		"select count(tk.id) as count from task as tk" +
                        " where tk.firm_id = :firmId and tk.status NOT IN (:statusId)");
        query.setParameter("firmId", mainPartyId);
        query.setParameterList("statusId", DONOT_WANT_STATUS_LIST);
        query.addScalar("count", StandardBasicTypes.LONG);
        List result = query.list();
        return (Long) (result.get(0));
    }

    @Override
    public List<TaskDTO> getTasksDTOListForAFirm(Long count, Long mainPartyId) {
        // TODO Auto-generated method stub
        Integer completeStatus = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        /*List DONOT_WANT_STATUS_LIST = new ArrayList();
        DONOT_WANT_STATUS_LIST.add(completeStatus);*/

        //Object[] paraArray = { status_id, mainPartyId };
        //may need to play with Start for the Pagination
        Integer start = 0;
        SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
                "select tk.id as taskId, customer.name as clientName, practice_type.name as PracticeType, tk.filing_type as filingTypeFromDB, tk.due_date as dueDate, assignedParty.name as assignedTo," +
                        "clientStaffIncharge.name as clientStaffInCharge, partnerInCharge.name as partnerInCharge, tk.task_type as taskType , tk_stauts.status as status" +
                        " from task as tk" +
                        " inner join party as customer on tk.customer_id = customer.party_id" +
                        " inner join tax_application_practice_type as practice_type on tk.partice_id = practice_type.id" +
                        " left outer join party as assignedParty on tk.staff_in_charge = assignedParty.party_id" +
                        " left outer join party as clientStaffIncharge on tk.client_staff_in_charge = clientStaffIncharge.party_id" +
                        " left outer join party as partnerInCharge on tk.partner_in_charge = partnerInCharge.party_id" +
                        " left outer join  task_status as tk_stauts on tk.status = tk_stauts.id" +
                        " where tk.firm_id = :firmId and tk.status != :statusId");
        query.setParameter("firmId", mainPartyId);
        query.setParameter("statusId", completeStatus);

        List resultWithAliasedBean = query.addScalar("taskId", StandardBasicTypes.LONG)
                .addScalar("clientName")
                .addScalar("practiceType")
                .addScalar("filingTypeFromDB")
                .addScalar("dueDate")
                .addScalar("assignedTo")
                .addScalar("clientStaffInCharge")
                .addScalar("partnerInCharge")
                .addScalar("taskType")
                .addScalar("status")
                .setResultTransformer(Transformers.aliasToBean(TaskDTO.class))
                .list().subList(start, start + count.intValue());

        //return getHibernate().findByNamedQuery("task.native_find_task");
        return resultWithAliasedBean;
        // paraArray).subList(start, start + count.intValue());
    }

    @Override
	public Long getTaskListCount(Long firmId, Long userProfileId, String userRole,
			Date startDate, Date endDate, List taskStatusList) {
    	StringBuffer query = new StringBuffer("select count(tk.id) as count from task as tk  where ");
    	if(!userRole.equals("ROLE_CLIENT_STAFF")){
    		query.append(" tk.firm_id = :firmId");
    	}
    	if(userRole.equals("ROLE_FIRM_PARTNER")){
    		query.append(" and tk.partner_in_charge =:partnerId");
    	}else if(userRole.equals("ROLE_STAFF")){
    		query.append(" and tk.staff_in_charge =:staffId");
    	}else if(userRole.equals("ROLE_CLIENT_STAFF")){
    		query.append(" tk.client_staff_in_charge =:clientStaffId");
    	}
    	/*else{
    		//this is firm admin
    	}*/
    		query.append(" and tk.status IN (:statusList)");
    
    		//This is to handle Missed deadlines, which gives only one date
    		if(startDate != null && endDate == null){
    			query.append(" and DATE(tk.due_date) < DATE(:startDate)");
    		}else{
	    		query.append(" and DATE(tk.due_date) >= DATE(:startDate)");
	    		query.append(" and DATE(tk.due_date) <= DATE(:endDate)");
            }

    		SQLQuery sqlQuery = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(query.toString());
    		sqlQuery.setParameter("startDate", startDate);
    		if(endDate != null){
    			sqlQuery.setParameter("endDate", endDate);
    		}
    		
    		if(!userRole.equals("ROLE_CLIENT_STAFF")){
    			sqlQuery.setParameter("firmId", firmId);
    		}
    		if(userRole.equals("ROLE_FIRM_PARTNER")){
    			sqlQuery.setParameter("partnerId", userProfileId);
    		}else if(userRole.equals("ROLE_STAFF")){
    			sqlQuery.setParameter("staffId", userProfileId);
    		}else if(userRole.equals("ROLE_CLIENT_STAFF")){
    			sqlQuery.setParameter("clientStaffId", userProfileId);
    		}
    		/*else{
    			//this is for firm admin
    		}*/
    		
    		sqlQuery.setParameterList("statusList", taskStatusList);
    		
    		sqlQuery.addScalar("count", StandardBasicTypes.LONG);
    		List result = sqlQuery.list();
    		return (Long) (result.get(0));
	}

	@Override
	public List<TaskDTO> getTaskLists(Long firmId, Long userProfileId, String userRole,
			Date startDate, Date endDate, List taskStatusList, Long count) {
		Integer start = 0;
    	StringBuffer query = new StringBuffer(
				" select tk.id as taskId, party.name as clientName, partice.name as taskType, tk.due_date as dueDate, tk_stauts.status as status, "+
				" emailComm.contact_detail as emailAddress,ti_filing_type.name as flashFilingType, officeComm.contact_detail as officeNumber " +
				" from task as tk " +
				" left outer join party as party on party.party_id = tk.customer_id " +
				" left outer join party as clientStaff on clientStaff.party_id = tk.client_staff_in_charge "+
                " inner join tax_application_practice_type as partice on tk.partice_id = partice.id "+
                " inner join task_status as tk_stauts on tk.status = tk_stauts.id " +
                " left outer join tax_info_filing_type as ti_filing_type on tk.filing_type = ti_filing_type.id " +
                " left outer join party_site as site on clientStaff.party_id = site.party_id "+
                " left outer join point_of_contact as poc on site.id = poc.party_site_id "+
                " left outer join communication as emailComm on emailComm.contact_point_id = poc.id and emailComm.communication_Type = 1 " +
                " left outer join communication as officeComm on officeComm.contact_point_id = poc.id and officeComm.communication_Type = 3 and officeComm.sub_type = 3 " +
                " left outer join communication as mobileComm on mobileComm.contact_point_id = poc.id and mobileComm.communication_Type = 5 and mobileComm.sub_type = 5 " +
                " left outer join communication as faxComm on faxComm.contact_point_id = poc.id and faxComm.communication_Type = 2 where ");
    	
    	if(!userRole.equals("ROLE_CLIENT_STAFF")){
    		query.append(" tk.firm_id = :firmId");
    	}
    	if(userRole.equals("ROLE_FIRM_PARTNER")){    		
    		query.append(" and tk.partner_in_charge =:partnerId");
    	}else if(userRole.equals("ROLE_STAFF")){
    		query.append(" and tk.staff_in_charge =:staffId");
    	}else if(userRole.equals("ROLE_CLIENT_STAFF")){
    		query.append(" tk.client_staff_in_charge =:clientStaffId");
    	}
    	/*else{
    		//this is firm admin
    	}*/
    		query.append(" and tk.status IN (:statusList)");
    
    		//This is to handle Missed deadlines, which gives only one date
    		if(startDate != null && endDate == null){
    			query.append(" and DATE(tk.due_date) < DATE(:startDate)");
    		}else{
    			query.append(" and DATE(tk.due_date) >= DATE(:startDate)");
	    		query.append(" and DATE(tk.due_date) <= DATE(:endDate)");
            }
    	SQLQuery sqlQuery = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(query.toString());
		sqlQuery.setParameter("startDate", startDate);
		if(endDate != null){
			sqlQuery.setParameter("endDate", endDate);
		}
		
		if(!userRole.equals("ROLE_CLIENT_STAFF")){
			sqlQuery.setParameter("firmId", firmId);
		}
		if(userRole.equals("ROLE_FIRM_PARTNER")){
			sqlQuery.setParameter("partnerId", userProfileId);
		}else if(userRole.equals("ROLE_STAFF")){
			sqlQuery.setParameter("staffId", userProfileId);
		}else if(userRole.equals("ROLE_CLIENT_STAFF")){
			sqlQuery.setParameter("clientStaffId", userProfileId);
		}
		/*else{
			//this is for firm admin
		}*/
		sqlQuery.setParameterList("statusList", taskStatusList);
		
		List resultWithAliasedBean = sqlQuery.addScalar("taskId", StandardBasicTypes.LONG)
		   									.addScalar("clientName")
		   									.addScalar("taskType")
		   									.addScalar("dueDate")
		   									.addScalar("status")
		   									.addScalar("emailAddress")
		   									.addScalar("officeNumber")
		   									.addScalar("flashFilingType")
		   									.setResultTransformer(Transformers.aliasToBean(TaskDTO.class))
		   									.list().subList(start,start+count.intValue());
		
		return resultWithAliasedBean;
	}
	
	@Override
	public Long getTaskCountCalender(Long firmId, Long userProfileId,
			String userRole, List taskStatusList) {
		
		    Long filingType = TaxInfoFilingType.TAX_FILING_TYPE.getId();
	    	StringBuffer query = new StringBuffer("select count(tk.id) as count from task as tk  where ");
	    	query.append(" tk.firm_id = :firmId and tk.filing_type = :filingType");
	    	if(userRole.equals("ROLE_FIRM_PARTNER")){
	    		query.append(" and tk.partner_in_charge =:partnerId");
	    	}else if(userRole.equals("ROLE_STAFF")){
	    		query.append(" and tk.staff_in_charge =:staffId");
	    	}
	    	/*else{
	    		//this is firm admin
	    	}*/
    		query.append(" and tk.status IN (:statusList)");
    
    		SQLQuery sqlQuery = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(query.toString());
    		sqlQuery.setParameter("firmId", firmId);
    		sqlQuery.setParameter("filingType", filingType);
    		if(userRole.equals("ROLE_FIRM_PARTNER")){
    			sqlQuery.setParameter("partnerId", userProfileId);
    		}else if(userRole.equals("ROLE_STAFF")){
    			sqlQuery.setParameter("staffId", userProfileId);
    		}
    		/*else{
    			//this is for firm admin
    		}*/
    		
    		sqlQuery.setParameterList("statusList", taskStatusList);
    		
    		sqlQuery.addScalar("count", StandardBasicTypes.LONG);
    		List result = sqlQuery.list();
    		return (Long) (result.get(0));
	}

	@Override
	public List<EventDTO> getTaskListCalender(Long firmId, Long userProfileId,
			String userRole, List taskStatusList, Long count) {
		Integer start = 0;
		Long filingType = TaxInfoFilingType.TAX_FILING_TYPE.getId();
    	StringBuffer query = new StringBuffer(
    			" SELECT task.id as id, staffInCharge.name as staffInCharge, practiceType.name as taxType, " +
                " partnerInCharge.name as partnerInCharge, task.due_date as dueDate, task.due_date as start, task.due_date as end  " +
                " from task as task " +
                " inner join task_status as status on status.id = task.status " +
                " inner join party as staffInCharge on staffInCharge.party_id = task.staff_in_charge " +
                " inner join tax_application_practice_type as practiceType on practiceType.id = task.partice_id " +
                " left outer join party as partnerInCharge on partnerInCharge.party_id = task.partner_in_charge where ");
    	query.append(" task.firm_id = :firmId and task.filing_type = :filingType");
    	if(userRole.equals("ROLE_FIRM_PARTNER")){
    		query.append(" and task.partner_in_charge =:partnerId");
    	}else if(userRole.equals("ROLE_STAFF")){
    		query.append(" and task.staff_in_charge =:staffId");
    	}
    	/*else{
    		//this is firm admin
    	}*/
    		query.append(" and task.status IN (:statusList)");
    
    	SQLQuery sqlQuery = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(query.toString());
    	sqlQuery.setParameter("firmId", firmId);
    	sqlQuery.setParameter("filingType", filingType);
		if(userRole.equals("ROLE_FIRM_PARTNER")){
			sqlQuery.setParameter("partnerId", userProfileId);
		}else if(userRole.equals("ROLE_STAFF")){
			sqlQuery.setParameter("staffId", userProfileId);
		}
		/*else{
			//this is for firm admin
		}*/
		sqlQuery.setParameterList("statusList", taskStatusList);
		
		List resultWithAliasedBean = sqlQuery.addScalar("id", StandardBasicTypes.INTEGER)
		   									.addScalar("staffInCharge")
							                .addScalar("taxType")
							                .addScalar("partnerInCharge")
							                .addScalar("dueDate", StandardBasicTypes.DATE)
							                .addScalar("start", StandardBasicTypes.DATE)
							                .addScalar("end", StandardBasicTypes.DATE)
							                .setResultTransformer(Transformers.aliasToBean(EventDTO.class))
							                .list().subList(start, start + count.intValue());
		
		return resultWithAliasedBean;
	}
	
	@Override
	public void saveTask(Task task) {
	getHibernate().delete(task);
	    }
	
	@Override
	
		public void removeAdhocTaskById(Long id ) {
		    Integer start = 0;
	    	
	StringBuffer querydel = new StringBuffer("Delete from task where id = :id");
	SQLQuery sqlQuerydel = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(querydel.toString());
	sqlQuerydel.setParameter("id", id);
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
	public List<TaskDTO> getTasksListForAFirmNew(Long newFirmId) {
		int status_id = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
        Object[] paraArray = {status_id, newFirmId};
        Integer start = 0;
        return getHibernate().findByNamedQuery("task.findtasks_for_firm_with_order",
                paraArray).subList(start, start + 21);
	}

	@Override
	public BaseTaskDTO getBaseTaskById(Long newTaskId) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
				" select task.id as id,task.staff_in_charge as staffId,task.client_staff_in_charge as clientStaffId" +
				" ,task.customer_id as customerId,task.partner_in_charge as partnerId,task.firm_id as firmId ,tapt.name as practiceId,task.due_date as dueDate ,task.filing_title as filingTitle , ts.status as newStatus from task " +
				"left outer join task_notification as tn on tn.task_id = task.id "+
				"left outer join tax_application_practice_type as tapt on tapt.id = task.partice_id "+
				"left outer join task_status as ts on ts.id = task.status "+
				" where tn.id = :newTaskId");
		query.setParameter("newTaskId", newTaskId);
		
		List resultWithAliasedBean = query.addScalar("id", StandardBasicTypes.LONG)
											.addScalar("staffId", StandardBasicTypes.LONG)
											.addScalar("clientStaffId", StandardBasicTypes.LONG)
											.addScalar("customerId", StandardBasicTypes.LONG)
											.addScalar("partnerId", StandardBasicTypes.LONG)
											.addScalar("firmId", StandardBasicTypes.LONG)
											.addScalar("practiceId")
											.addScalar("dueDate")
											.addScalar("filingTitle")
											.addScalar("newStatus")
											.setResultTransformer(Transformers.aliasToBean(BaseTaskDTO.class))
											 .list();

		return (BaseTaskDTO) resultWithAliasedBean.get(0);
	}

	 @Override
	    public List<TaskDTO> getTasksDTOListForAFirm(int count, int limit, int offset, Long mainPartyId) {
	        // TODO Auto-generated method stub
	        Integer completeStatus = TaskStatus.TASK_STATUS_TYPE_COMPLETE.getId();
	        /*List DONOT_WANT_STATUS_LIST = new ArrayList();
	        DONOT_WANT_STATUS_LIST.add(completeStatus);*/

	        //Object[] paraArray = { status_id, mainPartyId };
	        //may need to play with Start for the Pagination
	           SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
	                "select tk.id as taskId, customer.name as clientName, practice_type.name as PracticeType, tk.filing_type as filingTypeFromDB, tk.due_date as dueDate, assignedParty.name as assignedTo," +
	                        "clientStaffIncharge.name as clientStaffInCharge, partnerInCharge.name as partnerInCharge, tk.task_type as taskType , tk_stauts.status as status" +
	                        " from task as tk" +
	                        " inner join party as customer on tk.customer_id = customer.party_id" +
	                        " inner join tax_application_practice_type as practice_type on tk.partice_id = practice_type.id" +
	                        " left outer join party as assignedParty on tk.staff_in_charge = assignedParty.party_id" +
	                        " left outer join party as clientStaffIncharge on tk.client_staff_in_charge = clientStaffIncharge.party_id" +
	                        " left outer join party as partnerInCharge on tk.partner_in_charge = partnerInCharge.party_id" +
	                        " left outer join  task_status as tk_stauts on tk.status = tk_stauts.id" +
	                        " where tk.firm_id = :firmId and tk.status != :statusId"+
	                        " limit :limit offset :offset");
	        query.setParameter("firmId", mainPartyId);
	        query.setParameter("statusId", completeStatus);
	        query.setParameter("limit", limit);
			query.setParameter("offset", offset);

	        List resultWithAliasedBean = query.addScalar("taskId", StandardBasicTypes.LONG)
	                .addScalar("clientName")
	                .addScalar("practiceType")
	                .addScalar("filingTypeFromDB")
	                .addScalar("dueDate")
	                .addScalar("assignedTo")
	                .addScalar("clientStaffInCharge")
	                .addScalar("partnerInCharge")
	                .addScalar("taskType")
	                .addScalar("status")
	                .setResultTransformer(Transformers.aliasToBean(TaskDTO.class))
	                .list();

	        //return getHibernate().findByNamedQuery("task.native_find_task");
	        return resultWithAliasedBean;
	        // paraArray).subList(start, start + count.intValue());
	    }

	public List<TaskDTO> getCliListForDash(Long firmId) {
		 SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
         		"select  CONCAT(substring(party.name, 1, 10),'..') as clientName , count(tk.id) AS rank  from task as tk left outer join party as party on party.party_id = tk.customer_id  left outer join party as clientStaff on clientStaff.party_id = tk.client_staff_in_charge" +
                 " where tk.firm_id = :firmId group by clientName ORDER BY rank DESC ");
       query.setParameter("firmId", firmId);
       List result = query.list();
       return result;
	}
	
	private SQLQuery prepareSQLQuery(String sqlQueryName, String[] parameterArray, Object[] parameterValues) {
		SQLQuery query =  getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(sqlQueryName);
		for(int i =0; i < parameterArray.length; i++){
			query.setParameter(parameterArray[i], parameterValues[i]);
		}
		return query;
	}

	public void deleteTask(Boolean activeFlag, Long newId) {
		String[] parameterArray = {"activeFlag","newId"};
		Object[] parameterValues = {activeFlag,newId};
		SQLQuery query =  prepareSQLQuery(DELETE_SELECTED_TASK, parameterArray, parameterValues);
		query.executeUpdate();
	}


		
}
