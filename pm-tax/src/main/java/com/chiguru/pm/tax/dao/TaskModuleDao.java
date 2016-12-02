package com.chiguru.pm.tax.dao;

import com.chiguru.pm.crm.dto.BaseTaskDTO;
import com.chiguru.pm.tax.domain.BaseTask;
import com.chiguru.pm.tax.domain.DueDateRule;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskNotification;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.dto.EventDTO;
import com.chiguru.pm.tax.dto.TaskDTO;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public interface TaskModuleDao {
    Task getTaskById(Long taskId);

    public Long getTasksCountByDueDate(Date dueDate, Long partyId);

    public List<Long> getTasksByDueDate(Date dueDate, Long count, Long partyId);

    public List<DueDateRule> getRecurringEvents(Date recurringDate);

    public void generateTasks(List<BaseTask> taskList);

    public TaskStatus getTaskStatusById(Integer id);

    public Long getTaskNotificationCountbyDate(Date notificationDate);

    public TaskNotification getTaskNotificationById(Long taskNotificationId);

    public List<Long> getNotificationCountByDate(Date notificationDate);
    
    public TaskNotificationTemplate getTaskNotificationTemplate(Long notificationTempId);
    
    public Long getTaskNotificationRecipientCount(Long notificationTempId);
    
    public List<Long> getTaskNotificationRecipientCountById(Long notificationTempId);
    
    public TaskNotificationRecipient getNotificationRecipient(Long notificationTypeId);

    public List<TaskNotificationTemplate> getTaskNotificationTemplateList();

    public void saveTaskNotificationTemplate(
			TaskNotificationTemplate notificationTemplate);

    public void saveTaskNotificationRecipient(
			TaskNotificationRecipient notificationRecipient);

    public List<TaskNotificationRecipient> getTaskNotificationRecipientList();

    public void saveTaskNotification(TaskNotification taskNotification);

	public List<Task> getTasksListAssignedForAStaff(Date dueDate, Long count,
			Long partyId);

	public List<Task> getTasksListForAFirm(Long count, Long mainPartyId);
	
	public Long getTasksCount(Long taskId);

	
	public List<TaskDTO> getTasksDTOListForAFirm(Long count, Long mainPartyId);

	public Long getTaskCountFromNativeSQL(Long mainPartyId);

	public Long getTaskListCount(Long firmId, Long userId, String userRole,
			Date startDate, Date endDate, List taskStatusList);

	public List<TaskDTO> getTaskLists(Long firmId, Long userProfileId, String userRole, Date startDate,
			Date endDate, List taskStatusList, Long count);

	public Long getTaskCountCalender(Long firmId, Long userProfileId, String userRole,
			List taskStatusList);

	public List<EventDTO> getTaskListCalender(Long firmId, Long userProfileId,
			String userRole, List taskStatusList, Long count);

	public void saveTask(Task task);
	
	public void removeAdhocTaskById(Long id);
	public boolean checkEntityExists(Serializable id, Class entityClass);

	public List<TaskDTO> getTasksListForAFirmNew(Long newFirmId);

	public BaseTaskDTO getBaseTaskById(Long newTaskId);

	public List<TaskDTO> getTasksDTOListForAFirm(int count, int limit, int start,
			Long mainPartyId);

	public List<TaskDTO> getCliListForDash(Long firmId);

	public void deleteTask(Boolean activeFlag, Long newId);
}
