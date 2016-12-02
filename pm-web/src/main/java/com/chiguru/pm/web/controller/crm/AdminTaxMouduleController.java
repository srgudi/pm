package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;


@Controller
public class AdminTaxMouduleController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(AdminTaxMouduleController.class);
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    private CRMManager crmManager;

    @ModelAttribute
    public FirmPracticeType initializeModel(Long id, HttpServletRequest request) {
        FirmPracticeType type = null;

        Long firmId = PMUtil.getFirmIdFromSession(request);

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
    @RequestMapping(value = "/firmadmin/manageTaxModule.do", method = RequestMethod.GET)
    public String getManageTaxModule(HttpServletRequest request, ModelMap model,
        FirmPracticeType firmPracticeType, Long firmPracticeID) {
        logger.info("manageTaxModule.do");
        taxtypemethod(request, model, firmPracticeType);
        return "manageTaxModule.tilesView";
    }
    
    @RequestMapping(value = "/mobilefirmadmin/manageTaxModuleMobile.do", method = RequestMethod.GET)
    public String getManageTaxModuleMobile(HttpServletRequest request, ModelMap model,
        FirmPracticeType firmPracticeType, Long firmPracticeID) {
        logger.info("manageTaxModule.do");
        taxtypemethod(request, model, firmPracticeType);
        return "manageTaxModuleMobile.tilesView";
    }

	private void taxtypemethod(HttpServletRequest request, ModelMap model,
			FirmPracticeType firmPracticeType) {
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
	}

    @RequestMapping(value = {"/firmadmin/manageTaxModule.do","/mobilefirmadmin/manageTaxModuleMobile.do"}, method = RequestMethod.POST)
    public String saveManageTaxModule(HttpServletRequest request,ModelMap model,
        Long clientId, FirmPracticeType firmPracticeType, BindingResult result,
        SessionStatus status, Long firmPracticeID) {
        logger.info("Manage Tax Module Save");
        
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
        /*if(Operation.equalsIgnoreCase("save")){
                firmPracticeType.setActiveFlag(true);//saving
        }else if(Operation.equalsIgnoreCase("cancel")){
                firmPracticeType.setActiveFlag(false);//deleting
        }*/
//        firmPracticeType.setCreateUserId("system");

        PracticeType practiceType = firmPracticeType.getTaxApplicationPracticeType();
        practiceType.setActiveFlag(true);
//        practiceType.setCreateUserId("system");
        firmPracticeType.setTaxApplicationPracticeType(practiceType);

        taxModuleManager.saveFirmPracticeInfo(firmPracticeType);

        //		saveFirmPracticeType(firmPracticeType);
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + firmPracticeType.getId() +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
    }
}
