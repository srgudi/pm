package com.chiguru.pm.tax.service;

import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.dto.EventDTO;
import com.chiguru.pm.tax.dto.TaskDTO;

import java.util.Date;
import java.util.List;


public interface TaskModuleManager {
    Task getTaskById(Long long1);

    public Long getTasksCountByDueDate(Date dueDate, Long partyId);

    public List<Long> getTasksByDueDate(Long page, Date dueDate, Long partyId);

    //new methods
    public void generateTasks();

    public void sendReminders();

    public TaskNotificationTemplate getTaskNotificationTemplate(Long valueOf);

    public List<TaskNotificationTemplate> getTaskNotificationTemplateList();

    public void saveTaskNotificationTemplate(
			TaskNotificationTemplate notificationTemplate);

    public TaskNotificationRecipient getNotificationRecipient(Long valueOf);

   public void saveTaskNotificationRecipient(
			TaskNotificationRecipient notificationRecipient);

   public List<TaskNotificationRecipient> getTaskNotificationRecipientList();
   
   public List<Task>  getTasksListAssignedForAStaff(Long page, Date dueDate, Long partyId);

   public List<Task> getTasksListForAFirm(Long count, Long mainPartyId);
   
   public Long getTasksCount(Long partyId);

   public List<TaskDTO> getTasksDTOListForAFirm(Long count, Long mainPartyId);

   public Long getTaskCountFromNativeSQL(Long mainPartyId);

   public Long getTaskListCount(Long firmId, Long userId, String userRole,
		int dateRangeType, List taskStatusList);

   public List<TaskDTO> getTaskLists(Long firmId, Long userProfileId, String userRole,
		int pmConstants, List taskStatusList, Long count);

   public Long getTaskCountCalender(Long firmId, Long userProfileId, String userRole,
		List taskStatusList);

   public List<EventDTO> getTaskListCalender(Long firmId, Long userProfileId,
		String userRole, List taskStatusList, Long count);

   public void saveTask(Task task);
   
   public void removeAdhocTaskById(Long id);

   public List<TaskDTO> getTasksDTOListForAFirmNew(Long newFirmId);

   public List<TaskDTO> getTasksDTOListForAFirm(Page page, Long mainPartyId);

   public List<TaskDTO> getCliListForDash(Long firmId);
   public void deleteTask(boolean activeFlag,Long newId);
   
}
