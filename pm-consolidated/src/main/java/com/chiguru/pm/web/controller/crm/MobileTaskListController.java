package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.dto.TaskDTO;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;
@Controller
public class MobileTaskListController {
	
	@Autowired
    private CRMManager crmManager;
	@Autowired
    private TaxModuleManager taxModuleManager;
	  @Autowired
	    private TaskModuleManager taskModuleManager;
	 private Logger logger = org.slf4j.LoggerFactory.getLogger(MobileTaskListController.class);
	 
	 private void populateReturnMapWithPageDatails(Map retMap, List entityList,
		        Page page) {
		        retMap.put("rows", entityList);

		        if (page != null) {
		            retMap.put("page", page.getCurrentPage());
		            retMap.put("total", page.getTotalPages());
		            retMap.put("records", page.getCount());
		        }
		    }
	 
	 
	
	  @RequestMapping(value = "/mobiletask/mobileTaskList.do", method = RequestMethod.GET)
	    public String taskList(HttpServletRequest request, ModelMap model) {
	        return "mobiletaskList.tilesView";
	    }
	  
	  @RequestMapping(value = "/mobilefirmadmin/firmStaffMobileList.do", method = RequestMethod.GET)
	    public String firmstaffList(HttpServletRequest request, ModelMap model) {
	        return "mobilefirmstaffList.tilesView";
	    }
	
	  @RequestMapping(value = "/mobilefirmadmin/taxtypeMobileList.do", method = RequestMethod.GET)
	    public String taxtypeList(HttpServletRequest request, ModelMap model) {
	        return "mobiletaxtypeList.tilesView";
	    }
	  
	  @ModelAttribute
	    public Task initializeModel(Long taskId, Long id, Long clientId,
	        HttpServletRequest request) {
	        Task task = null;

	        if (taskId == null) {
	            task = new Task();
	            task.setTaskType("ADHOC");
	        } else {
	            task = taxModuleManager.getTaskById(taskId);
	        }

	        return task;
	    }
	  
	 /* @RequestMapping(value = "/mobiletask/mobileTaskmodule.do", method = RequestMethod.POST)
	    public ResponseEntity<String> saveTask(HttpServletRequest request, Long taskId, Task task,
	        BindingResult result, SessionStatus status) {
	        logger.info("Mobile Task  Module Save!");
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        
	        if(task.getId() == null){
	        	task.setFirm(crmManager.getOrganizationById(firmId));
	        	
	        	if(task.getFilingType() == TaxInfoFilingType.TAX_FILING_TYPE.getId()){
	            	task.setFilingTitle("Tax Filing Type");
	            }else{
	            	task.setFilingTitle("Installment Filing Type");
	            }
	        }
	        HttpHeaders responseHeaders = new HttpHeaders();
			 responseHeaders.setContentType(MediaType.TEXT_HTML);
			 StringBuffer responseText = new StringBuffer("{\"mobtaskId\":");
			 try{
	              taxModuleManager.saveTask(task);
			      responseText.append("\""+task.getId()+"\"}");
		 	      logger.info("mobile task module ****** "+task.getId());
              
              }catch(Exception e){
                  logger.error("Exception occurred during save/update for task "+ task.getTaskType() +e.getMessage());
                  responseText.append("\"-1\"}");
              }
	       return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 

	    }*/

	   /* @RequestMapping(value = "/mobiletask/mobileTaskmodule.do", method = RequestMethod.GET)
	    public String taskModule(HttpServletRequest request, Task task,
	        Long taskId, Long clientId, ModelMap model) {
	        logger.info("Mobile Task  Module!");

	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        Page page = PMUtil.populatePageObject(request);
	        
	        setDataForUI(request, model, task, firmId, page);
	        return "mobileTaskModule.tilesView";
	    }*/
	    
	    /*@RequestMapping(value = "/mobiletask/mobileTaskmodule.do", method = RequestMethod.GET)
	    public String taskModule(HttpServletRequest request, ModelMap model) {
	        return "mobileTaskModule.tilesView";
	    }*/
	    private void setDataForUI(HttpServletRequest request, ModelMap model,
	            Task task, Long firmId, Page page) {
	            model.addAttribute("task", task);
	            
	            if (TaxInfoFilingType.TAX_FILING_TYPE.getId().equals(task.getFilingType())){
	                task.getPracticeId().setDescription("Tax Filing Type");
	            } else if(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId().equals(task.getFilingType())){
	                task.getPracticeId().setDescription("Installment Filing Type");
	            }
	            if(task.getClient() != null){
	            	List<KeyValue> clientStaffList = PMUtil.getCachedDropdownPartyList(task.getClient().getId(), RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId(),crmManager);
	            	model.put("clientStaffList",clientStaffList);
	            }
	            
	            List<KeyValue> staffList = PMUtil.getCachedDropdownPartyList(firmId, RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
	            model.put("staffList", staffList);
	            
	            List<KeyValue> partnerList = PMUtil.getCachedDropdownPartyList(firmId, RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),crmManager);
	            model.put("partnerList", partnerList);
	            
	            List<TaskStatus> statusList = taxModuleManager.getTaskStatusList();
	            model.addAttribute("statusCodeList", statusList);
	            
	            if(task.getId() == null){
	            	List<Party> partyListFromDB = crmManager.getRelatedPartiesById(firmId,RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(), page);
	            	model.put("clientList",partyListFromDB);
	            	for (TaskStatus taskStatus : statusList) {
	            		if(taskStatus.getId() == 3){
	            			task.setStatus(taskStatus);
	            		}
	            	}
//	            	setReferenceData(model);
	            	List<TaxInfoFilingType> listOfAllFilingType = new ArrayList<TaxInfoFilingType>();
	                listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId()));
	                listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId()));
	                
	                List<PracticeType> listOfAllPracticeType = taxModuleManager.getPractTypesByFirmId(firmId);

	                model.put("filingTypeList",listOfAllFilingType);
	                model.put("taxTypeList",listOfAllPracticeType );
	            }
	            PMUtil.showStatusMessage(request, model);
	        }
	    
	   /* @RequestMapping(value = "/mobiletask/mobiletaskajaxlist.do", method = RequestMethod.GET)
	    public @ResponseBody
	    Map getmobileTaskAjaxList(HttpServletRequest request) {
	        logger.info("Task List!");

	        //Long firmId = Long.valueOf(request.getParameter("firmId"));
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        Page page = PMUtil.populatePageObject(request);

	        return getMobileTaskList(firmId, page);
	    }
	    */
	    private Map getMobileTaskList(Long mainPartyId, Page page) {
	        Map retMap = new HashMap();
	        Long count = null;
	        if (page != null) {
	            count = taskModuleManager.getTaskCountFromNativeSQL(mainPartyId);
	            PMUtil.adjustPagination(page, count.intValue());
	            page.setCount(count.intValue());
	        }
	        List<TaskDTO> taskList = taskModuleManager.getTasksDTOListForAFirm(count,mainPartyId);
	        if (page != null) {
	            PMUtil.adjustPagination(page, count.intValue());
	            page.setCount(count.intValue());
	        }
	        populateReturnMapWithPageDatails(retMap, taskList, page);
	        return retMap;
	    }
	    
	    @RequestMapping(value = "/mobile/home.do", method = RequestMethod.GET)
	    public String home(HttpServletRequest request, ModelMap model) {
	    	return "mobileHome.tilesView";
		}
	    
	    @RequestMapping(value = "/mobilefirmadmin/firmadminhome.do", method = RequestMethod.GET)
	    public String firmadminhome(HttpServletRequest request, ModelMap model) {
	    	return "mobileFirmAdminHome.tilesView";
		}
	    
	    @RequestMapping(value = "/mobileadmin/adminhome.do", method = RequestMethod.GET)
	    public String adminhome(HttpServletRequest request, ModelMap model) {
	    	return "mobileAdminHome.tilesView";
		}
	    
}