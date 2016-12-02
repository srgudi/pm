package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.CodeType;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

@Controller
public class AdminCodeTypeController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminCodeTypeController.class);
    @Autowired
    private CRMManager crmManager;
    
    @Autowired
	private Validator validator;

    @Autowired
    public AdminCodeTypeController(CRMManager crmManager, Validator validator){
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

        binder.registerCustomEditor(CodeType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getCodeTypeById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        CodeType codeType = (CodeType) getValue();

                        return codeType.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        /*binder.registerCustomEditor(Code.class,
                        new PropertyEditorSupport() {
                                @Override
                                public void setAsText(String text)
                                                throws IllegalArgumentException {
                                        if ("null".equals(text) || "-1".equals(text)) {
                                                setValue(null);
                                        } else {
                                                setValue(crmManager.getCodeById(Long.valueOf(text)));
        
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
                        });*/
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute("codeType")
    public CodeType initializeCodeTypeModel(Long id, HttpServletRequest request) {
        CodeType codeType;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            codeType = new CodeType();
        } else {
            codeType = crmManager.getCodeTypeById(id);
        }

        return codeType;
    }

    @RequestMapping(value = {"/appadmin/adminCodeType.do","/mobileadmin/mobileAdminCodeType.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveManageCodeType(HttpServletRequest request,
        ModelMap model,@Valid CodeType codeType,BindingResult result, Integer id) {
        logger.info("Manage CodeType Save!");
        HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"codeTypeId\":");
        Long firmId = PMUtil.getFirmIdFromSession(request);

        /*if(result.hasErrors()) {
        	this.getManageCodeType(request, model, codeType, id);
			return null;
		 }*/
        
        String status = request.getParameter("activeFlag");

        if (status.equalsIgnoreCase("true")) {
            codeType.setActiveFlag(true);
        } else {
            codeType.setActiveFlag(false);
        }

        String applicationLevelIndicator = request.getParameter(
                "applicationLevelIndicator");

        if (applicationLevelIndicator.equalsIgnoreCase("true")) {
            codeType.setApplicationLevelIndicator(true);
        } else {
            codeType.setApplicationLevelIndicator(false);
        }

        //			codeType.setApplicationLevelIndicator(true);
        try{
        crmManager.saveCodeType(codeType);
        responseText.append("\""+codeType.getId()+"\"}");
	 	  logger.info("SAVED ****** "+codeType.getId());
        }catch (Exception e) {
        	 logger.error("Exception occurred during save of Code Type ");
             responseText.append("\"-1\"}");
             
            }
   	 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = {"/appadmin/adminCodeType.do","/mobileadmin/mobileAdminCodeType.do"}, method = RequestMethod.GET)
    public String getManageCodeType(HttpServletRequest request, ModelMap model,@ModelAttribute("codeType")
        CodeType codeType, Integer id) {
        logger.info("Get Manage Code Type!");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        List<CodeType> parentCodeTypeSet = crmManager.getCodeTypeList();
        model.addAttribute("parentCodeTypeSet", parentCodeTypeSet);
        PMUtil.showStatusMessage(request, model);
        if(request.getRequestURI().contains("/appadmin/adminCodeType.do")){
           return "appadmin/adminCodeType";
        }else{
           return "mobileAdminCodeType.tilesView";
        }
    }
}
