package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.web.util.PMUtil;

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
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;


@Controller
public class AdminTimezoneController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminTimezoneController.class);
    @Autowired
	private CRMManager crmManager;
	
	@Autowired
	private Validator validator;

    @Autowired
    public AdminTimezoneController(CRMManager crmManager, Validator validator){
        this.crmManager = crmManager;
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

        binder.registerCustomEditor(Timezone.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getTimezoneById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        Timezone timezone = (Timezone) getValue();

                        return timezone.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute
    public Timezone initializeTimezoneModel(Long id, HttpServletRequest request) {
        Timezone timezone;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            timezone = new Timezone();
        } else {
            timezone = crmManager.getTimezoneById(id);
        }

        return timezone;
    }

    @RequestMapping(value = "/appadmin/adminTimezone.do", method = RequestMethod.POST)
    public String saveManageTimezone(HttpServletRequest request, @Valid Timezone timezone, BindingResult result,
    		ModelMap model, Long id) {
        logger.info("Manage Timezone Save!");

        if(result.hasErrors()) {
        	this.getManageTimezone(request, model, timezone, id);
//			return "/appadmin/adminTimezone";
			
			return null;
			
			/*String baseURL = request.getParameter("baseURL");
            String returnURL = baseURL + "?id=" + timezone.getId();
            return "redirect:" + returnURL;*/
		 }
        
        Long firmId = PMUtil.getFirmIdFromSession(request);
        crmManager.saveTimezone(timezone);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + timezone.getId() + "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/appadmin/adminTimezone.do", method = RequestMethod.GET)
    public String getManageTimezone(HttpServletRequest request, ModelMap model,
        Timezone timezone, Long id) {
        logger.info("Get Manage Timezone!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        /*if(id == null){
                timezone = new Timezone();
        }else{
                timezone = crmManager.getTimezoneById(id);
        }*/
        List<Timezone> listOfTimezone = crmManager.getTimezoneList();
        PMUtil.showStatusMessage(request, model);
        model.addAttribute("timezone", timezone);
        model.addAttribute("listOfTimezone",
            getGlobalTimezoneNameStringString(listOfTimezone));
        model.addAttribute("listOfTimezoneStr",
            getGlobalTimezoneName(listOfTimezone));
        return "adminTimezone.tilesView";
    }

    private Object getGlobalTimezoneNameStringString(
        List<Timezone> listOfTimezone) {
        StringBuffer titleStringBuffer = new StringBuffer("'All");

        for (Timezone timezone : listOfTimezone) {
            titleStringBuffer.append("','");
            titleStringBuffer.append(timezone.getGlobalTimezoneName());
            titleStringBuffer.append("','");
            titleStringBuffer.append(timezone.getGlobalTimezoneName());
        }

        titleStringBuffer.append("'");

        return titleStringBuffer.toString();
    }

    private Object getGlobalTimezoneName(List<Timezone> listOfTimezone) {
        StringBuffer titleStringBuffer = new StringBuffer(":All");

        for (Timezone timezone : listOfTimezone) {
            titleStringBuffer.append(";");
            titleStringBuffer.append(timezone.getGlobalTimezoneName());
            titleStringBuffer.append(":");
            titleStringBuffer.append(timezone.getGlobalTimezoneName());
        }

        return titleStringBuffer.toString();
    }
}
