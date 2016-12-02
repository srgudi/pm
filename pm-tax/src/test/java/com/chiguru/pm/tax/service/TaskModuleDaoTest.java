package com.chiguru.pm.tax.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.dto.TaskDTO;

/*@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/app-config.xml", "/mail-config.xml", "/security-config.xml"})
@Transactional
@TransactionConfiguration(defaultRollback=false)*/
/*public class TaskModuleDaoTest extends AbstractTransactionalJUnit4SpringContextTests{*/
	 /*@Autowired
	 TaskModuleManager taskMagager;
 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskCountForMissedDeadlines() {
			Long firmId = (long) 648;   
			Long partnerId = (long) 651;   
			Long staffId = (long) 650;
			Long firmAdminId = (long) 649;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.MISSED_DEADLINE,taskStatusList);
//			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.MISSED_DEADLINE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, firmAdminId, "ROLE_FIRM_ADMIN", PMConstants.MISSED_DEADLINE,taskStatusList);
			System.out.println("MissedDeadlines count="+ count);
	
	  } 
	 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskListForMissedDeadlines() {
			Long firmId = (long) 648;   
			Long partnerId = (long) 651;  
			Long staffId = (long) 650;
			Long firmAdminId = (long) 649;
			Long count = (long) 222220;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.MISSED_DEADLINE,taskStatusList, count);
//			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.MISSED_DEADLINE,taskStatusList, count);
			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, firmAdminId, "ROLE_FIRM_ADMIN", PMConstants.MISSED_DEADLINE,taskStatusList, count);
			
			for (TaskDTO taskDTO : taskListForMissedDeadlines) {
				System.out.println("MissedDeadlines task type="+ taskDTO.getTaskType());
			}
	
	  }
	 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskCountForDueToday() {
		 	Long firmId = (long) 648;   
			Long partnerId = (long) 651;   
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.TODAY_DEADLINE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.TODAY_DEADLINE,taskStatusList);
			System.out.println("DueToday count="+ count);
	
	  } 
	 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskListForDueToday() {
		 	Long firmId = (long) 648;   
//			Long partnerId = (long) 651;   
			Long staffId = (long) 650;
			Long count = (long) 0;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.TODAY_DEADLINE,taskStatusList, count);
			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.TODAY_DEADLINE,taskStatusList, count);
			
			for (TaskDTO taskDTO : taskListForMissedDeadlines) {
				System.out.println("DueToday task type="+ taskDTO.getTaskType());
			}
	
	  }
	 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskCountForDueWeek() {
		 Long firmId = (long) 648;   
			Long partnerId = (long) 651; 
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.SEVEN_DAY_RANGE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.SEVEN_DAY_RANGE,taskStatusList);
			System.out.println("DueWeek count="+ count);
	
	  } 
	 
	 @Test
	 @Transactional (readOnly=true)
		public void testTaskListForDueWeek() {
			Long firmId = (long) 648;   
			Long partnerId = (long) 651;   
			Long staffId = (long) 650;
			Long count = (long) 0;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			//Date endDate = new Date(System.currentTimeMillis());
			
//			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.SEVEN_DAY_RANGE,taskStatusList, count);
			List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.SEVEN_DAY_RANGE,taskStatusList, count);
			
			for (TaskDTO taskDTO : taskListForMissedDeadlines) {
				System.out.println("DueWeek task type="+ taskDTO.getTaskType());
			}
	
	  }
 
	 @Test
	   @Transactional (readOnly=true)
		public void testGetTaskCountForDue30Days() {
		   Long firmId = (long) 648;   
			Long partnerId = (long) 651;  
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.THIRTY_DAY_RANGE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.THIRTY_DAY_RANGE,taskStatusList);
			System.out.println("Due30Days count="+ count);
	
	    }
	   
	 @Test
		 @Transactional (readOnly=true)
			public void testTaskListForDue30Days() {
				Long firmId = (long) 648;   
				Long partnerId = (long) 651;   
				Long staffId = (long) 650;
				Long count = (long) 2;
				List taskStatusList = new ArrayList();
				//Status for Pending Tasks
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
				//Date endDate = new Date(System.currentTimeMillis());
				
//				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.THIRTY_DAY_RANGE,taskStatusList, count);
				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.THIRTY_DAY_RANGE,taskStatusList, count);
				
				for (TaskDTO taskDTO : taskListForMissedDeadlines) {
					System.out.println("Due30Days task type="+ taskDTO.getTaskType());
				}
		
		  }
	   
	   @Test
	   @Transactional (readOnly=true)
		public void testGetTaskCountForDue60Days() {
		   Long firmId = (long) 648;   
			Long partnerId = (long) 651; 
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.SIXTY_DAY_RANGE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.SIXTY_DAY_RANGE,taskStatusList);
			System.out.println("Due60Days count="+ count);
	
	    }
	   
	   @Test
		 @Transactional (readOnly=true)
			public void testTaskListForDue60Days() {
				Long firmId = (long) 648;   
				Long partnerId = (long) 651; 
				Long staffId = (long) 650;  
				Long count = (long) 6;
				List taskStatusList = new ArrayList();
				//Status for Pending Tasks
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
				//Date endDate = new Date(System.currentTimeMillis());
				
//				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.SIXTY_DAY_RANGE,taskStatusList, count);
				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.SIXTY_DAY_RANGE,taskStatusList, count);
				
				for (TaskDTO taskDTO : taskListForMissedDeadlines) {
					System.out.println("Due60Days task type="+ taskDTO.getTaskType());
				}
		
		  }
	   
	   @Test
	   @Transactional (readOnly=true)
		public void testGetTaskCountForDue90Days() {
		   Long firmId = (long) 648;   
			Long partnerId = (long) 651; 
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.NINETY_DAY_RANGE,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.NINETY_DAY_RANGE,taskStatusList);
			System.out.println("Due90Days count="+ count);
	
	    }
	   
	   @Test
		 @Transactional (readOnly=true)
			public void testTaskListForDue90Days() {
				Long firmId = (long) 648;   
				Long partnerId = (long) 651;
				Long staffId = (long) 650;   
				Long count = (long) 6;
				List taskStatusList = new ArrayList();
				//Status for Pending Tasks
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
				//Date endDate = new Date(System.currentTimeMillis());
				
//				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.NINETY_DAY_RANGE,taskStatusList, count);
				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.NINETY_DAY_RANGE,taskStatusList, count);
				
				for (TaskDTO taskDTO : taskListForMissedDeadlines) {
					System.out.println("Due90Days task type="+ taskDTO.getTaskType());
				}
		
		  }
	   
	   @Test
	   @Transactional (readOnly=true)
		public void testGetTaskCountForDueWaiting() {
		   Long firmId = (long) 648;   
			Long partnerId = (long) 651;  
			Long staffId = (long) 650;
			List taskStatusList = new ArrayList();
			//Status for Pending Tasks
//			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
			taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
			Date endDate = new Date(System.currentTimeMillis());
			
//			Long count = taskMagager.getTaskListCount(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.WAITING_STATUS,taskStatusList);
			Long count = taskMagager.getTaskListCount(firmId, staffId, "ROLE_STAFF", PMConstants.WAITING_STATUS,taskStatusList);
			System.out.println("DueWaiting count="+ count);
	
	    }
	   
	   @Test
		 @Transactional (readOnly=true)
			public void testTaskListForDueWaiting() {
				Long firmId = (long) 648;   
				Long partnerId = (long) 651;
				Long staffId = (long) 650;
				Long count = (long) 8;
				List taskStatusList = new ArrayList();
				//Status for Pending Tasks
//				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
				taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
				//Date endDate = new Date(System.currentTimeMillis());
				
//				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, partnerId, "ROLE_FIRM_PARTNER", PMConstants.WAITING_STATUS,taskStatusList, count);
				List<TaskDTO> taskListForMissedDeadlines = taskMagager.getTaskLists(firmId, staffId, "ROLE_STAFF", PMConstants.WAITING_STATUS,taskStatusList, count);
				
				for (TaskDTO taskDTO : taskListForMissedDeadlines) {
					System.out.println("DueWaiting task type="+ taskDTO.getTaskType());
				}
	   }*/
   
//}
