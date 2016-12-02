package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class AdminTaxMouduleController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminTaxMouduleController.class);
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    private CRMManager crmManager;

    @ModelAttribute("firmPracticeType")
    public FirmPracticeType initializeModel(Long id, HttpServletRequest request) {
        FirmPracticeType type = null;

        Long firmId = PMUtil.getFirmIdFromSession(request);
        
        String entityKey = request.getParameter("entityKey");
        if(StringUtils.hasText(entityKey)){
        	/*id = TextEncryptUtil.decryptToLong(entityKey);*/
        	id = Long.parseLong(entityKey);
        }

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        if(session.getAttribute("inValidClientId")==null){
	        if (id == null ) {
	            type = new FirmPracticeType();
	        } else {
	            type = taxModuleManager.getFirmPracticeTypeById(id);
	            /*type.setEntityKey(TextEncryptUtil.encryptForLong(id));*/
	            type.setEntityKey(id.toString());
	        }
       }else{
    	   type = new FirmPracticeType();
       }

        return type;
    }

    /*private void saveFirmPracticeType(FirmPracticeType firmPracticeType) {
            taxModuleManager.saveFirmPracticeInfo(firmPracticeType);
    }*/

    /*private void setPracticeTypeData(Long firmId, Long firmPracticeID, ModelMap model) {
            //List<FirmPracticeType> manageTaxList = taxModuleManager.getFirmPracticeTypeList(firmId);
            FirmPracticeType firmPracticeType = taxModuleManager.getFirmPracticeTypeById(firmId);
            model.addAttribute("firmPracticeType", firmPracticeType);
    }*/
    @RequestMapping(value = {"/firmadmin/manageTaxModule.do","/mobilefirmadmin/manageTaxModuleMobile.do"}, method = RequestMethod.GET)
    public String getManageTaxModule(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("firmPracticeType") FirmPracticeType firmPracticeType, Long firmPracticeID) {
        logger.info("manageTaxModule.do");
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        if(session.getAttribute("inValidClientId")==null){
        	PMUtil.showStatusMessage(request, model);
        	model.addAttribute("firmPracticeType", firmPracticeType);
        }
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        
        if (request.getRequestURI().contains("/firmadmin/manageTaxModule.do")){
        	return "firmadmin/manageTaxModule";
        }else{
        	return "manageTaxModuleMobile.tilesView";
        }
        
    }

    @RequestMapping(value = {"/firmadmin/manageTaxModule.do","/mobilefirmadmin/manageTaxModuleMobile.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveManageTaxModule(HttpServletRequest request,ModelMap model,
        Long clientId, FirmPracticeType firmPracticeType, BindingResult result,
        SessionStatus status, Long firmPracticeID) {
        logger.info("Manage Tax Module Save");
         HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"entityKey\":");
        if(result.hasErrors()) {
        	this.getManageTaxModule(request, model, firmPracticeType, firmPracticeID);
        	return null;
        }

        String Operation = request.getParameter("Operation");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Party firmParty = crmManager.getPartyById(firmId);
        firmPracticeType.setOrganization(firmParty.getOrganization());

        firmPracticeType.setActiveFlag(true);

        PracticeType practiceType = firmPracticeType.getTaxApplicationPracticeType();
        practiceType.setActiveFlag(true);
        firmPracticeType.setTaxApplicationPracticeType(practiceType);
        try{
        	/*if(StringUtils.hasText(firmPracticeType.getEntityKey())){
        		firmPracticeType.setId(TextEncryptUtil.decryptToLong(firmPracticeType.getEntityKey()));
        	}*/
        	taxModuleManager.saveFirmPracticeInfo(firmPracticeType);
			          /*responseText.append("\""+TextEncryptUtil.encryptForLong(firmPracticeType.getId())+"\"}");*/
        	      responseText.append("\""+firmPracticeType.getId()+"\"}");
				 	  logger.info("ManageTaxModule SAVED ****** "+firmPracticeType.getId());
	               
	           }catch(Exception e){
	          logger.error("Exception occurred during save for tax type "+ firmPracticeType.getId() +e.getMessage());
	          responseText.append("\"-1\"}");
	          
	         }
		 	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
		
    }
}
