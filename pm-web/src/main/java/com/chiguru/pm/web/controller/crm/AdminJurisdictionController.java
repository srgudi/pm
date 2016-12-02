package com.chiguru.pm.web.controller.crm;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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

import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.web.util.PMUtil;


@Controller
public class AdminJurisdictionController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminJurisdictionController.class);
    @Autowired
	private CRMManager crmManager;
	
	@Autowired
	private Validator validator;
	
	@Autowired
	public AdminJurisdictionController(CRMManager crmManager, Validator validator){
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

        binder.registerCustomEditor(Jurisdiction.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getJurisdictionById(Long.valueOf(
                                    text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        Jurisdiction jurisdiction = (Jurisdiction) getValue();

                        return jurisdiction.getId().toString();
                    } else {
                        return null;
                    }
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
    public Jurisdiction initializeJurisdictionModel(Long id,
        HttpServletRequest request) {
        Jurisdiction jurisdiction;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            jurisdiction = new Jurisdiction();
        } else {
            jurisdiction = crmManager.getJurisdictionById(id);
        }

        return jurisdiction;
    }

    @RequestMapping(value = "/appadmin/adminJurisdiction.do", method = RequestMethod.POST)
    public String saveManageJurisdiction(HttpServletRequest request,@Valid Jurisdiction jurisdiction, BindingResult result,
    		ModelMap model,Long clientId, Long id) {
        logger.info("Manage Jurisdiction Save!");
        Long jId;

        if(result.hasErrors()) {
        	this.getManageJurisdiction(request, model, jurisdiction, id);
        	return null;
		 }
        
        String status = request.getParameter("activeFlag");
        
        if (status.equalsIgnoreCase("true")) {
        	jurisdiction.setActiveFlag(true);
        } else {
        	jurisdiction.setActiveFlag(false);
        }
        
        crmManager.saveJurisdiction(jurisdiction);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + jurisdiction.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

    @RequestMapping(value = "/mobileadmin/mobileAdminJurisdiction.do", method = RequestMethod.POST)
    public String saveMobileManageJurisdiction(HttpServletRequest request,@Valid Jurisdiction jurisdiction, BindingResult result,
    		ModelMap model,Long clientId, Long id) {
        logger.info("Manage Jurisdiction Save!");
        Long jId;

        if(result.hasErrors()) {
        	this.getManageJurisdiction(request, model, jurisdiction, id);
        	return null;
		 }
        
        String status = request.getParameter("activeFlag");
        
        if (status.equalsIgnoreCase("true")) {
        	jurisdiction.setActiveFlag(true);
        } else {
        	jurisdiction.setActiveFlag(false);
        }
        
        crmManager.saveJurisdiction(jurisdiction);

        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + jurisdiction.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }
    
    @RequestMapping(value = "/appadmin/adminJurisdiction.do", method = RequestMethod.GET)
    public String getManageJurisdiction(HttpServletRequest request,
        ModelMap model, Jurisdiction jurisdiction, Long id) {
        logger.info("Get Manage Jurisdiction!");

        /*if(id == null){
                jurisdiction = new Jurisdiction();
        }else{
                jurisdiction = crmManager.getJurisdictionById(id);
        }*/
        List<Timezone> timezoneSet = crmManager.getTimezoneList();
        PMUtil.showStatusMessage(request, model);
        model.addAttribute("timezoneSet", timezoneSet);
        model.addAttribute("jurisdiction", jurisdiction);
        
    return "adminJurisdiction.tilesView";
    }
    
    @RequestMapping(value = "/mobileadmin/mobileAdminJurisdiction.do", method = RequestMethod.GET)
    public String getMobileManageJurisdiction(HttpServletRequest request,
        ModelMap model, Jurisdiction jurisdiction, Long id) {
        logger.info("Get Manage Jurisdiction!");

        /*if(id == null){
                jurisdiction = new Jurisdiction();
        }else{
                jurisdiction = crmManager.getJurisdictionById(id);
        }*/
        List<Timezone> timezoneSet = crmManager.getTimezoneList();
        PMUtil.showStatusMessage(request, model);
        model.addAttribute("timezoneSet", timezoneSet);
        model.addAttribute("jurisdiction", jurisdiction);
        
    return "mobileadminJurisdiction.tilesView";
    }
}
