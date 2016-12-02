package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Code;
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
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
@Controller
public class AdminCodeController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminCodeController.class);
    @Autowired
	private CRMManager crmManager;
	
	@Autowired
	private Validator validator;

    @Autowired
    public AdminCodeController(CRMManager crmManager, Validator validator){
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

        binder.registerCustomEditor(Code.class,
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

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute("code")
    public Code initializeCodeModel(Long id, HttpServletRequest request) {
        Code code;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            code = new Code();
        } else {
            code = crmManager.getCodeById(id);
        }

        return code;
    }

    @RequestMapping(value = {"/appadmin/adminCode.do","/mobileadmin/mobileAdminCode.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveManageCode(HttpServletRequest request, ModelMap model,
    		@Valid Code code, BindingResult result, Long id) {
        logger.info("Manage CodeType Save!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
        StringBuffer responseText = new StringBuffer("{\"codeId\":");
        if(result.hasErrors()) {
        	this.getManageCode(request, model, code, id);
//			return "/appadmin/adminCode";
        	return null;
		 }
        String shortDesc = code.getShortName();
        Boolean codePresent = false;
        if(shortDesc != null){
            codePresent = crmManager.codeIsPresent(shortDesc);
        }
        if(id != null){
        	codePresent = false;
        }
        //		code.setApplicationLevelIndicator(true);
        if(codePresent == false){
        String status = request.getParameter("activeFlag");

        if (status.equalsIgnoreCase("true")) {
            code.setActiveFlag(true);
        } else {
            code.setActiveFlag(false);
        }

        //As code.Id is not auto-generating, So explicitly incrementing the id when new Code is entered.
        //Now code.id is auto generating
        /*if (id == null) {
            Long maxId = crmManager.getMaxCodeIdValue();
            code.setId(maxId + 1);
        }*/
        try{
         crmManager.saveCode(code);
        }catch (Exception e) {
			logger.error("Error occurs while save admin code" +e.getMessage());
        }
        }
        else{
        	model.addAttribute("invalidCode", "Given Code already exists. Please enter different one");
        	return null;
        }
        return new ResponseEntity<String>(responseHeaders, HttpStatus.OK); 
    }

    @RequestMapping(value = {"/appadmin/adminCode.do","/mobileadmin/mobileAdminCode.do"}, method = RequestMethod.GET)
    public String getManageCode(HttpServletRequest request, ModelMap model, @ModelAttribute("code")
        Code code, Long id) {
        logger.info("Get Manage Code!");
        PMUtil.showStatusMessage(request, model);
        Long firmId = PMUtil.getFirmIdFromSession(request);

        List<CodeType> codeTypeSet = crmManager.getCodeTypeList();
       	List<Code> parentCodeSet = crmManager.getCodeList();
        model.addAttribute("codeTypeSet", codeTypeSet);
       	model.addAttribute("parentCodeSet", parentCodeSet);
       	if(request.getRequestURI().contains("/appadmin/adminCode.do")){
            return "appadmin/adminCode";
       	}else{
       		return "mobadminCode.tilesview";
       	}
    }
    
    /*@RequestMapping(value = "/appadmin/adminCodeColor.do", method = RequestMethod.GET)
    public String getManageCodeColor(HttpServletRequest request, ModelMap model, @ModelAttribute("code")
        Code code, Long id) {
        logger.info("Get Manage Code!");
       // model.addAttribute("code", code);
        PMUtil.showStatusMessage(request, model);
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if(id == null){
                code = new Code();
        }else{
                code = crmManager.getCodeById(id);
        }
        List<CodeType> codeTypeSet = crmManager.getCodeTypeList();
        model.addAttribute("codeTypeSet", codeTypeSet);
        List<Code> parentCodeSet = crmManager.getCodeList();
        model.addAttribute("parentCodeSet", parentCodeSet);
       
    return "appadmin/adminCodeColor";
    }
    
    @RequestMapping(value = "/appadmin/adminCodeColor.do", method = RequestMethod.POST)
    public ResponseEntity<String> saveManageCodeColor(HttpServletRequest request, ModelMap model,
    		Code code, BindingResult result, Long id) {
        logger.info("Manage CodeType Save!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
		StringBuffer responseText = new StringBuffer("{\"codeId\":");
        if(result.hasErrors()) {
        	this.getManageCode(request, model, code, id);
//			return "/appadmin/adminCode";
        	return null;
		 }
        String shortDesc = code.getShortName();
        Boolean codePresent = false;
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL;
        if(shortDesc != null){
            codePresent = crmManager.codeIsPresent(shortDesc);
        }
        if(id != null){
        	codePresent = false;
        }
        //		code.setApplicationLevelIndicator(true);
        if(codePresent == false){
        String status = request.getParameter("activeFlag");

        if (status.equalsIgnoreCase("true")) {
            code.setActiveFlag(true);
        } else {
            code.setActiveFlag(false);
        }

        //As code.Id is not auto-generating, So explicitly incrementing the id when new Code is entered.
        //Now code.id is auto generating
        if (id == null) {
            Long maxId = crmManager.getMaxCodeIdValue();
            code.setId(maxId + 1);
        }
        try{
             crmManager.saveCode(code);
             responseText.append("\""+code.getId()+"\"}");
        }catch (Exception e) {
			 logger.error("Error occurs while save admin code" +e.getMessage());
			 responseText.append("\""+-1+"\"}");
        }
        }
        else{
        	model.addAttribute("invalidCode", "Given Code already exists. Please enter different one");
        	return null;
        }
        return new ResponseEntity<String>(responseHeaders, HttpStatus.OK); 
    }*/    

}
