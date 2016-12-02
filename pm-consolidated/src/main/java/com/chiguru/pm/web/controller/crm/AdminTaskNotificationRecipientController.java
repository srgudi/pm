package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.beans.PropertyEditorSupport;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;


@Controller
public class AdminTaskNotificationRecipientController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminTaskNotificationRecipientController.class);
    @Autowired
    private TaskModuleManager taskModuleManager;
	@Autowired
	private Validator validator;
	
    @Autowired
    public AdminTaskNotificationRecipientController(
        TaskModuleManager taskModuleManager, Validator validator){
        this.taskModuleManager = taskModuleManager;
        this.validator = validator;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Long.class, "myLong",
            new CustomNumberEditor(Long.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
                }
            });

        binder.registerCustomEditor(TaskNotificationTemplate.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taskModuleManager.getTaskNotificationTemplate(
                                Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        TaskNotificationTemplate taskNotificationTemplate = (TaskNotificationTemplate) getValue();

                        return taskNotificationTemplate.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(TaskNotificationRecipient.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taskModuleManager.getNotificationRecipient(
                                Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        TaskNotificationRecipient taskNotificationRecipient = (TaskNotificationRecipient) getValue();

                        return taskNotificationRecipient.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute("taskNotificationRecipient")
    public TaskNotificationRecipient initializeTaskNotificationTemplateModel(
        Long id, HttpServletRequest request) {
        TaskNotificationRecipient notificationRecipient = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            notificationRecipient = new TaskNotificationRecipient();
        } else {
            notificationRecipient = taskModuleManager.getNotificationRecipient(id);
        }

        return notificationRecipient;
    }

    @RequestMapping(value = {"/appadmin/adminTaskNotificationRecipient.do","/mobileadmin/mobileAdminTaskNotificationRecepient.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveAdminTaskNotificationRecipient(
        HttpServletRequest request,@Valid TaskNotificationRecipient notificationRecipient, BindingResult result,
        ModelMap model, Long clientId, Long id) {
        logger.info("save TaskNotificationTemplate !");
        HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"recipientId\":");
		 
        if(result.hasErrors()) {
        	this.getAdminTaskNotificationRecipient(request, model, notificationRecipient, id);
//			return "/appadmin/adminTaskNotificationRecipient";
        	return null;
		 }
        
        if (notificationRecipient.getId() == null) {
            notificationRecipient.setActiveFlag(true);
//            notificationRecipient.setCreateUserId("system");
            notificationRecipient.setVersion(0);
        }

        if (notificationRecipient.getCreateUserId() == null) {
            notificationRecipient.setActiveFlag(true);
//            notificationRecipient.setCreateUserId("system");
            notificationRecipient.setVersion(2);
            notificationRecipient.setCreateDate(new Date());
        }

        if (notificationRecipient.getNotificationTemplateId().getCreateUserId() == null) {
            notificationRecipient.getNotificationTemplateId().setActiveFlag(true);
//            notificationRecipient.getNotificationTemplateId().setCreateUserId("system");
            notificationRecipient.getNotificationTemplateId().setVersion(2);
            notificationRecipient.getNotificationTemplateId()
                                 .setCreateDate(new Date());
        }
        try{
        taskModuleManager.saveTaskNotificationRecipient(notificationRecipient);
        responseText.append("\""+notificationRecipient.getId()+"\"}");
	 	  logger.info("SAVED ****** "+notificationRecipient.getId());
        }catch(Exception e){
            logger.error("Exception occurred during save for recipient Save "+ notificationRecipient.getId());
            responseText.append("\"-1\"}");
            
           }
        /*String returnURL = "/appadmin/adminTaskNotificationRecipient.do?id=" +
            notificationRecipient.getId() + "&saveSuccess=true";
*/
        return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = {"/appadmin/adminTaskNotificationRecipient.do","/mobileadmin/mobileAdminTaskNotificationRecepient.do"}, method = RequestMethod.GET)
    public String getAdminTaskNotificationRecipient(HttpServletRequest request,
        ModelMap model,@ModelAttribute("taskNotificationRecipient") TaskNotificationRecipient notificationRecipient, Long id) {
        logger.info("Get TaskNotificationTemplate !");

        List<TaskNotificationTemplate> taskNotificationTemplate = taskModuleManager.getTaskNotificationTemplateList();

        model.addAttribute("templateSet", taskNotificationTemplate);
        PMUtil.showStatusMessage(request, model);
       // model.addAttribute("taskNotificationRecipient", notificationRecipient);
        if(request.getRequestURI().contains("/appadmin/adminTaskNotificationRecipient.do")){
           return "appadmin/adminTaskNotificationRecipient";
        }else{
           return "mobadminTaskNotificationRecipient.tilesview";
        }
    }
}
