package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.dto.EventDTO;
import com.chiguru.pm.tax.dto.TaskDTO;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class TaskListController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(TaskListController.class);
    @Autowired
    private TaskModuleManager taskModuleManager;
   

    private void populateReturnMapWithPageDatails(Map retMap, List entityList,
        Page page) {
        retMap.put("rows", entityList);

        if (page != null) {
            retMap.put("page", page.getCurrentPage());
            retMap.put("total", page.getTotalPages());
            retMap.put("records", page.getCount());
        }
    }

    @RequestMapping(value = "/calendar/eventAjaxList.do", method = RequestMethod.GET)
    public @ResponseBody
    List<EventDTO> getEventAjaxList(HttpServletRequest request) {
        logger.info("Task List!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        String start = request.getParameter("start");
        logger.info("start:" + start);

        HttpSession session = request.getSession(false);
        PartyDTO userDetail = (PartyDTO) session.getAttribute("userProfile");
        Page page = PMUtil.populatePageObject(request);
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
        String userRole = grantedAuthorityImpls.get(0).toString();
        
        List taskStatusList = new ArrayList();
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());

        return getEventList(firmId, userDetail.getId(),userRole,taskStatusList, page);
    }

    private List<EventDTO> getEventList(Long firmId, Long userProfileId,String userRole,List taskStatusList, Page page) {
            Map retMap = new HashMap();
            //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            
            Long count = taskModuleManager.getTaskCountCalender(firmId, userProfileId, userRole,taskStatusList);
            List<EventDTO> taskList = taskModuleManager.getTaskListCalender(firmId, userProfileId, userRole,taskStatusList,count);
            
            for (EventDTO eventDTO : taskList) {
            	Date newDate = eventDTO.getDueDate();
            	java.sql.Date sqlDate = new java.sql.Date(newDate.getTime());
        	    System.out.println("utilDate:" + newDate);
        	    System.out.println("sqlDate:" + sqlDate);
        	    DateFormat df = new SimpleDateFormat("MM-dd-yyyy");
        	    String text = df.format(sqlDate);
            	System.out.println("Today's date :"+text);
            	String title = "Staff: " + eventDTO.getStaffInCharge() +
            		"\n" + "Tax Type: "+ eventDTO.getTaxType() + 
            		"\n" + "Partner: " + eventDTO.getPartnerInCharge() +
            		"\n" + "Due Date: " + text;
            	
            	eventDTO.setTitle(title);
			}
            
            populateReturnMapWithPageDatails(retMap, taskList, page);
            return taskList;
        }

    // Added by Savitri
    public EventDTO getEventDTO(Long taskId) {
        EventDTO dto = new EventDTO();
        dto.setId(taskId.intValue());

        Task task = taskModuleManager.getTaskById(taskId);

        if (task != null) {
            //ClientPracticeInfo clientPracticeInfo=task.getTaxClientPracticeType();
            //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            
            dto.setStart(task.getDueDate());
            dto.setEnd(task.getDueDate());

            /*String title = task.getStaffInCharge().getFirstName() + " " +
                task.getStaffInCharge().getLastName() + "\n" +
                task.getPracticeId().getName();
            dto.setTitle(title);*/

            Party party = task.getClient();
        }

        return dto;
    }
    
    public EventDTO getEventDTO(Task task) {
        EventDTO dto = new EventDTO();
        
        if (task != null) {
        	dto.setId(task.getId().intValue());
            //ClientPracticeInfo clientPracticeInfo=task.getTaxClientPracticeType();
            //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            
            dto.setStart(task.getDueDate());
            dto.setEnd(task.getDueDate());

            /*String title = "Staff: " + task.getStaffInCharge().getParty().getName() +
            	"\n" + "Tax Type: "+ task.getPracticeId().getName() + 
            	"\n" + "Partner: " + task.getPartnerInCharge().getParty().getName() +
            	"\n" + "Due Date: " + task.getDueDate().toString();
            dto.setTitle(title);*/

            Party party = task.getClient();
        }

        return dto;
    }
    
  //Savitri
    @RequestMapping(value = "/task/taskajaxlist.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getTaskAjaxList(HttpServletRequest request) {
        logger.info("Task List!");

        //Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);
        Page page = PMUtil.populatePageObject(request);

        return getTaskList(firmId, page);
    }
    
    private Map getTaskList(Long mainPartyId, Page page) {
        Map retMap = new HashMap();
        Long count = null;
        if (page != null) {
            count = taskModuleManager.getTaskCountFromNativeSQL(mainPartyId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaskDTO> taskList = taskModuleManager.getTasksDTOListForAFirm(page,mainPartyId);
       /*if (page != null) {
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }*/
        populateReturnMapWithPageDatails(retMap, taskList, page);
        return retMap;
    }
    
    public List<TaskDTO> getTaskDTOList (List<Task> taskList) {
    	List<TaskDTO> taskDTOList = new ArrayList();
    	for(Task task: taskList){
        TaskDTO dto = populateTaskDTO(task);
            //add dto to List
            taskDTOList.add(dto);
        }
        return taskDTOList;
    }

	private TaskDTO populateTaskDTO(Task task) {
		TaskDTO dto = new TaskDTO();
           dto.setTaskId(task.getId().intValue());
            dto.setPracticeType(task.getPracticeId().getName());

            Party party = task.getClient();

            dto.setClientName(party.getName());

            //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

            if (task.getFilingType() == 1) {
                TaxInfoFilingType filing = new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId());

                dto.setFilingType(filing.getName());
            } else {
                TaxInfoFilingType filing = new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId());

                dto.setFilingType(filing.getName());
            }

            dto.setDueDate(task.getDueDate());
            dto.setStatus(task.getStatus().getStatusName());
		return dto;
	}

    @RequestMapping(value = "/task/taskList.do", method = RequestMethod.GET)
    public String taskList(HttpServletRequest request, ModelMap model) {
        return "taskList.tilesView";
    }
    
    @RequestMapping(value = "/dashboard/dashboard.do", method = RequestMethod.GET)
    public void getListOfTaskDueDate(HttpServletRequest request, ModelMap model) {
        Long firmId = PMUtil.getFirmIdFromSession(request);
        
        List taskStatusList = new ArrayList();
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
        List taskStatusForWaiting = new ArrayList();
        taskStatusForWaiting.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
        HttpSession session = request.getSession(false);
		PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
        String userRole = grantedAuthorityImpls.get(0).toString();
        
        model.addAttribute("missedDeadLines", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.MISSED_DEADLINE,taskStatusList));
        model.addAttribute("dueForToday", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.TODAY_DEADLINE,taskStatusList));
        model.addAttribute("dueForWeek", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.SEVEN_DAY_RANGE,taskStatusList));
        model.addAttribute("dueForMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.THIRTY_DAY_RANGE,taskStatusList));
        model.addAttribute("dueForTwoMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.SIXTY_DAY_RANGE,taskStatusList));
        model.addAttribute("dueForThreeMonth", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.NINETY_DAY_RANGE,taskStatusList));
        model.addAttribute("filesWaitingForClientReply", taskModuleManager.getTaskListCount(firmId, userProfile.getId(), userRole, PMConstants.WAITING_STATUS,taskStatusList));
        model.addAttribute("firmId",firmId);
        
        
    }

	private List<TaskDTO> newTasklist(HttpServletRequest request) {
		Long firmId = PMUtil.getFirmIdFromSession(request);
		List<TaskDTO> taskList = taskModuleManager.getTasksDTOListForAFirm((long) 0,firmId);
		return taskList;
	}
    
	@RequestMapping(value = "/dashboard/newTasklist.do", method = RequestMethod.GET)
	public @ResponseBody
	Map getTaskDetails(String firmId) {
		Map<String, List<TaskDTO>> retMap = new HashMap();
		Long newFirmId = Long.parseLong(firmId);
		List<TaskDTO> taskList = new ArrayList();
		if (firmId != null) {
			taskList = taskModuleManager.getTasksDTOListForAFirmNew(newFirmId);
		} 
		retMap.put("newtaskList", taskList);
		return retMap;
	}
    	
    	/*@RequestMapping(value = "/dashboard/getDashboardDetails.do", method = RequestMethod.GET)
    	public @ResponseBody
    	Map getEmployeeDetails(String fullName) {
    		Map<String, DashboardDTO> retMap = new HashMap();
    		DashboardDTO dash = new DashboardDTO();
    		retMap.put("dashboardDetails", dash);
    		return retMap;
    	}*/
    
    @RequestMapping(value = "/dashboard/filesDueTodayList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getfilesDueTodayList(HttpServletRequest request) {
        Map retMap = new HashMap();
        Page page = PMUtil.populatePageObject(request);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        String strDueCount = request.getParameter("count");
        
        List taskStatusList = new ArrayList();
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_NEW.getId());
        taskStatusList.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
        List taskStatusForWaiting = new ArrayList();
        taskStatusForWaiting.add(TaskStatus.TASK_STATUS_TYPE_WAITING.getId());
        HttpSession session = request.getSession(false);
		PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
        String userRole = grantedAuthorityImpls.get(0).toString();
		
		if(strDueCount != null){
			if(strDueCount.equalsIgnoreCase("0")){
				retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.MISSED_DEADLINE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("1")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("2")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.SEVEN_DAY_RANGE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("3")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.THIRTY_DAY_RANGE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("4")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.SIXTY_DAY_RANGE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("5")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.NINETY_DAY_RANGE, taskStatusList);
	        }else if(strDueCount.equalsIgnoreCase("6")){
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.WAITING_STATUS, taskStatusList);
	        }else{
	        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
	        }
        }else{
        	retMap = getTaskList(page,firmId,userProfile.getId(), userRole,PMConstants.TODAY_DEADLINE, taskStatusList);
        }
        
        return retMap;
    }

	private Map getTaskList(Page page, Long firmId, Long userProfileId, String userRole,
			int pmConstants, List taskStatusList) {
		Map retMap = new HashMap();
		Long count = taskModuleManager.getTaskListCount(firmId, userProfileId, userRole, pmConstants,taskStatusList);
        List<TaskDTO> taskList =taskModuleManager.getTaskLists(firmId, userProfileId, userRole, pmConstants ,taskStatusList, count);
        populateReturnMapWithPageDatails(retMap, taskList, page);
		return retMap;
	}
    
}
