package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.hibernate.loader.custom.Return;
import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

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

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

@Controller
public class AdminTaskNotificationTemplateController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminTaskNotificationTemplateController.class);
    @Autowired
    private TaskModuleManager taskModuleManager;
    @Autowired
	private Validator validator;

    @Autowired
    public AdminTaskNotificationTemplateController(
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

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute("taskNotificationTemplate")
    public TaskNotificationTemplate initializeTaskNotificationTemplateModel(
        Long id, HttpServletRequest request) {
        TaskNotificationTemplate notificationTemplate = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            notificationTemplate = new TaskNotificationTemplate();
        } else {
            notificationTemplate = taskModuleManager.getTaskNotificationTemplate(id);
        }

        return notificationTemplate;
    }

    @RequestMapping(value = {"/appadmin/adminTaskNotificationTemplate.do","/mobileadmin/mobileadminTaskNotificationTemplate.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveAdminTaskNotificationTemplate(
        HttpServletRequest request,@Valid TaskNotificationTemplate notificationTemplate,
        BindingResult result, ModelMap model, Long clientId, Long id) {
        logger.info("save TaskNotificationTemplate !");
        HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"templateId\":");
        /*if(result.hasErrors()) {
        	this.getAdminTaskNotificationTemplate(request, model, notificationTemplate, id);
//			return "/appadmin/adminTaskNotificationTemplate?id=" +notificationTemplate.getId();
        	return null;
		 }*/
        
        if (notificationTemplate.getId() == null) {
            notificationTemplate.setActiveFlag(true);
//            notificationTemplate.setCreateUserId("system");
            notificationTemplate.setVersion(0);
        }

        if (notificationTemplate.getCreateUserId() == null) {
            notificationTemplate.setActiveFlag(true);
//            notificationTemplate.setCreateUserId("system");
            notificationTemplate.setVersion(2);
            notificationTemplate.setCreateDate(new Date());
        }
        try{
        taskModuleManager.saveTaskNotificationTemplate(notificationTemplate);
          responseText.append("\""+notificationTemplate.getId()+"\"}");
	 	  logger.info("SAVED ****** "+notificationTemplate.getId());
        }catch(Exception e){
            logger.error("Exception occurred during save for template Save "+ notificationTemplate.getId());
            responseText.append("\"-1\"}");
            
           }
  	 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
      /* String returnURL = "/appadmin/adminTaskNotificationTemplate.do?id=" +
        notificationTemplate.getId() + "&saveSuccess=true";

        return "redirect:" + returnURL;*/
       
        
        //return new ResponseEntity<String>(responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = {"/appadmin/adminTaskNotificationTemplate.do","/mobileadmin/mobileadminTaskNotificationTemplate.do"}, method = RequestMethod.GET)
    public String getAdminTaskNotificationTemplate(HttpServletRequest request,
        ModelMap model, @ModelAttribute("taskNotificationTemplate") TaskNotificationTemplate notificationTemplate, Long id) {
        logger.info("Get TaskNotificationTemplate !");
        PMUtil.showStatusMessage(request, model);
     //   model.addAttribute("taskNotificationTemplate", notificationTemplate);
        if(request.getRequestURI().contains("/appadmin/adminTaskNotificationTemplate.do")){
           return "appadmin/adminTaskNotificationTemplate";
        }else{
        	return "taskNotificationTemplate.tilesView";
        }
       // return "adminTaskNotificationTemplate.tilesView";
    }
}
