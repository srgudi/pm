package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.service.CRMManager;
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

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class AdminJurisdictionController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminJurisdictionController.class);
    @Autowired
    private CRMManager crmManager;

    @Autowired
    private Validator validator;

    @Autowired
    public AdminJurisdictionController(CRMManager crmManager, Validator validator) {
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

	@ModelAttribute("jurisdiction")
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

    @RequestMapping(value = {"/appadmin/adminJurisdiction.do","/mobileadmin/mobileAdminJurisdiction.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveManageJurisdiction(HttpServletRequest request, @Valid Jurisdiction jurisdiction, BindingResult result,
                                                         ModelMap model, Long clientId, Long id) {
        logger.info("Manage Jurisdiction Save!");
        Long jId;
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
        StringBuffer responseText = new StringBuffer("{\"clientId\":");
        if (result.hasErrors()) {
            this.getManageJurisdiction(request, model, jurisdiction, id);
            return null;
        }

        String status = request.getParameter("activeFlag");

        if (status.equalsIgnoreCase("true")) {
            jurisdiction.setActiveFlag(true);
        } else {
            jurisdiction.setActiveFlag(false);
        }
        
        try{
        	  crmManager.saveJurisdiction(jurisdiction);
			  responseText.append("\""+jurisdiction.getId()+"\"}");
			  logger.info("JURISDICTION SAVED ****** "+jurisdiction.getId());
	               
	         }catch(Exception e){
	          logger.error("Exception occurred during save of jurisdiction save "+ jurisdiction.getId() +e.getMessage());
	          responseText.append("\""+-1+"\"}");
	          
	         }
/*
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + jurisdiction.getId() +
            "&saveSuccess=true";*/

        return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK);
    }

    @RequestMapping(value = {"/appadmin/adminJurisdiction.do","/mobileadmin/mobileAdminJurisdiction.do","/mobileadmin/EditMobileAdminJurisdiction.do"}, method = RequestMethod.GET)
    public String getManageJurisdiction(HttpServletRequest request,
                                        ModelMap model,@ModelAttribute("jurisdiction") Jurisdiction jurisdiction, Long id) {
        logger.info("Get Manage Jurisdiction!");

        /*if(id == null){
                jurisdiction = new Jurisdiction();
        }else{
                jurisdiction = crmManager.getJurisdictionById(id);
        }*/
        List<Timezone> timezoneSet = crmManager.getTimezoneList();
        PMUtil.showStatusMessage(request, model);
        model.addAttribute("timezoneSet", timezoneSet);
       // model.addAttribute("jurisdiction", jurisdiction);
        
        String servletPath = request.getServletPath();
        
        if(servletPath.equals("/appadmin/adminJurisdiction.do")){
        	return "/appadmin/adminJurisdiction";
        }else if(servletPath.equals("/mobileadmin/mobileAdminJurisdiction.do")){
        	//return "/mobileadmin/mobileAdminJurisdiction";
        	return "mobileAdminJuridList.tilesView";
        }else{
        	return "EditMobileAdminJurisdiction.tilesView";
        }

        
    }
}
