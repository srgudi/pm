package com.chiguru.pm.web.controller.crm;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.chiguru.pm.crm.domain.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.tax.domain.ReminderRule;
import com.chiguru.pm.crm.domain.Code;
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
	  
	  @Autowired
	    private CodesManager codesManager;
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
	
	  @InitBinder
	    public void initBinder(WebDataBinder binder) {
	        binder.registerCustomEditor(Long.class, "myLong",
	            new CustomNumberEditor(Long.class, true) {
	                public void setValue(Object o) {
	                    super.setValue((o == null) ? 0 : o);
	                }
	            });

	        binder.registerCustomEditor(List.class, "taxInfoReminders",
	            new CustomCollectionEditor(List.class) {
	                @Override
	                protected Object convertElement(Object element) {
	                    String reminders = (String) element;

	                    //Integer dueDay = dueDate[0];
	                    //Integer dueMonth = dueDate[1];
	                    ReminderRule reminder = new ReminderRule();

	                    //reminder.setReminderDay(reminders[0]);
	                    //taxDueDate.setDueMonth(dueMonth);
	                    return reminder;
	                }
	            });

	        binder.registerCustomEditor(Integer.class, "myInt",
	            new CustomNumberEditor(Integer.class, true) {
	                public void setValue(Object o) {
	                    super.setValue((o == null) ? 0 : o);
	                }
	            });

	        binder.registerCustomEditor(Code.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(codesManager.getCodeById(Long.valueOf(text)));
	                    }
	                }

	                public String getAsText() {
	                    if (getValue() != null) {
	                        Code code = (Code) getValue();

	                        return code.getId().toString();
	                    } else {
	                        return null;
	                    }
	                }
	            });

	        binder.registerCustomEditor(TaxInfoFilingType.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(taxModuleManager.getTaxInfoFilingType(
	                                Integer.valueOf(text)));
	                    }
	                }

	                public String getAsText() {
	                    if (getValue() != null) {
	                        TaxInfoFilingType type = (TaxInfoFilingType) getValue();

	                        return type.getId().toString();
	                    } else {
	                        return null;
	                    }
	                }
	            });

	        binder.registerCustomEditor(Party.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text) ||
	                            "".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(crmManager.getPartyById(Long.valueOf(text)));
	                    }
	                }

	                public String getAsText() {
	                    String retValue = null;

	                    if (getValue() != null) {
	                        Party party = (Party) getValue();

	                        if ((party != null) && (party.getId() != null)) {
	                            retValue = party.getId().toString();
	                        }
	                    }

	                    return retValue;
	                }
	            });
	        binder.registerCustomEditor(Person.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text) ||
	                            "".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(crmManager.getPersonById(Long.valueOf(text)));
	                    }
	                }

	                public String getAsText() {
	                    String retValue = null;

	                    if (getValue() != null) {
	                        Person person = (Person) getValue();

	                        if ((person != null) && (person.getId() != null)) {
	                            retValue = person.getId().toString();
	                        }
	                    }

	                    return retValue;
	                }
	            });

	        binder.registerCustomEditor(Jurisdiction.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text) ||
	                            "".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(crmManager.getJurisdictionById(Long.valueOf(
	                                    text)));
	                    }
	                }

	                public String getAsText() {
	                    String retValue = null;

	                    if (getValue() != null) {
	                        Jurisdiction jurisdiction = (Jurisdiction) getValue();

	                        if ((jurisdiction != null) &&
	                                (jurisdiction.getId() != null)) {
	                            retValue = jurisdiction.getId().toString();
	                        }
	                    }

	                    return retValue;
	                }
	            });
	        
	        /*binder.registerCustomEditor(TaskStatus.class,
	                new PropertyEditorSupport() {
	                    @Override
	                    public void setAsText(String text)
	                        throws IllegalArgumentException {
	                        if ("null".equals(text) || "-1".equals(text) ||
	                                "".equals(text)) {
	                            setValue(null);
	                        } else {
	                            setValue(taxModuleManager.getStatusById(Integer.valueOf(text)));
	                        }
	                    }

	                    public String getAsText() {
	                        String retValue = null;

	                        if (getValue() != null) {
	                        	TaskStatus status = (TaskStatus) getValue();

	                            if ((status != null) &&
	                                    (status.getId() != null)) {
	                                retValue = status.getId().toString();
	                            }
	                        }

	                        return retValue;
	                    }
	                });*/

	        binder.registerCustomEditor(TaskStatus.class,
	            new PropertyEditorSupport() {
	                @Override
	                public void setAsText(String text)
	                    throws IllegalArgumentException {
	                    if ("null".equals(text) || "-1".equals(text)) {
	                        setValue(null);
	                    } else {
	                        setValue(taxModuleManager.getStatusById(Integer.valueOf(
	                                    text)));
	                       
	                    }
	                }

	                public String getAsText() {
	                    if (getValue() != null) {
	                        TaskStatus code = (TaskStatus) getValue();

	                        return code.getId().toString();
	                    } else {
	                        return null;
	                    }
	                }
	            });
	        
	        binder.registerCustomEditor(PracticeType.class,
	                new PropertyEditorSupport() {
	                    @Override
	                    public void setAsText(String text)
	                        throws IllegalArgumentException {
	                        if ("null".equals(text) || "-1".equals(text) ||
	                                "".equals(text)) {
	                            setValue(null);
	                        } else {
	                            setValue(taxModuleManager.getPracticeTypeById(Long.valueOf(text)));
	                        }
	                    }

	                    public String getAsText() {
	                        String retValue = null;

	                        if (getValue() != null) {
	                        	PracticeType practiceType = (PracticeType) getValue();

	                            if ((practiceType != null) && (practiceType.getId() != null)) {
	                                retValue = practiceType.getId().toString();
	                            }
	                        }

	                        return retValue;
	                    }
	                });

	        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	        CustomDateEditor editor = new CustomDateEditor(df, false);
	        binder.registerCustomEditor(Date.class, editor);
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
	  
	  @RequestMapping(value = "/mobiletask/mobileTaskmodule.do", method = RequestMethod.POST)
	    public String saveTask(HttpServletRequest request, Long taskId, Task task,
	        BindingResult result, SessionStatus status) {
	        logger.info("Mobile Task  Module Save!");
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        
	        if(task.getId() == null){
	        	task.setFirm(crmManager.getOrganizationById(firmId));
	        	/*if(task.getFilingTitle().equalsIgnoreCase("Tax Filing Type")){
	            	task.setFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId());
	            }else{
	            	task.setFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId());
	            }*/
	        	
	        	if(task.getFilingType() == TaxInfoFilingType.TAX_FILING_TYPE.getId()){
//	            	task.setFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId());
	            	task.setFilingTitle("Tax Filing Type");
	            }else{
//	            	task.setFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId());
	            	task.setFilingTitle("Installment Filing Type");
	            }
	        }
	        
	        taxModuleManager.saveTask(task);

	        String baseURL = request.getParameter("baseURL");
//	        String returnURL = baseURL + "?taskId=" +request.getParameter("taskId") + "&saveSuccess=true";
	        String returnURL = baseURL + "?taskId=" +task.getId()+ "&saveSuccess=true";
	        return "redirect:" + returnURL;
	    }

	    @RequestMapping(value = "/mobiletask/mobileTaskmodule.do", method = RequestMethod.GET)
	    public String taskModule(HttpServletRequest request, Task task,
	        Long taskId, Long clientId, ModelMap model) {
	        logger.info("Mobile Task  Module!");

	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        Page page = PMUtil.populatePageObject(request);
	        
	        setDataForUI(request, model, task, firmId, page);
	        return "mobileTaskModule.tilesView";
	    }
	    
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
	            	List<KeyValue> clientStaffList = PMUtil.getCachedDropdownPartyList(task.getClient().getId(), RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),crmManager);
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
	    
	    @RequestMapping(value = "/mobiletask/mobiletaskajaxlist.do", method = RequestMethod.GET)
	    public @ResponseBody
	    Map getmobileTaskAjaxList(HttpServletRequest request) {
	        logger.info("Task List!");

	        //Long firmId = Long.valueOf(request.getParameter("firmId"));
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        Page page = PMUtil.populatePageObject(request);

	        return getMobileTaskList(firmId, page);
	    }
	    
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
	    
}