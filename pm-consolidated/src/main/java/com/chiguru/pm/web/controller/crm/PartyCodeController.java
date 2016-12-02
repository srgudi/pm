package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
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
import javax.servlet.http.HttpSession;
import javax.validation.Valid;


@Controller
public class PartyCodeController extends BaseController{
    private Logger logger = org.slf4j.LoggerFactory.getLogger(PartyCodeController.class);
    
    @ModelAttribute("partyCode")
    public PartyCode initializePartyCodeModel(Long id,
        HttpServletRequest request) {
        PartyCode partyCode;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }


        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        if(session.getAttribute("inValidClientId")==null){
	        if (id == null) {
	            partyCode = new PartyCode();
	        } else {
	            partyCode = crmManager.getPartyCodeById(id);
	        }
        }else{
        	partyCode = new PartyCode();
        }

        return partyCode;
    }

    @RequestMapping(value = {"/firmadmin/managePartyCode.do","/mobilefirmadmin/managePartyCodeMobile.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveManagePartyCode(HttpServletRequest request,
        ModelMap model,@Valid PartyCode partyCode,Long id) {
        logger.info("Manage CodeType Save!");

        Party party = null;
        HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.setContentType(MediaType.TEXT_HTML);
      
        StringBuffer responseText = new StringBuffer("{\"codeId\":");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        String shortDesc = partyCode.getCode().getShortName();
        Boolean codePresent = false;
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL;
        if(shortDesc != null){
            codePresent = crmManager.partyCodeIsPresent(shortDesc,firmId);
        }
        //		code.setApplicationLevelIndicator(true);
        if(codePresent == false || id!=null){
        
        /*if(result.hasErrors()) {
        	this.getManagePartyCode(request, model, partyCode);
        	return null;
        }*/
        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            party = crmManager.getPartyById(firmId);
            partyCode.setParty(party);
            partyCode.getCode().setCreateUserId(getUserProfileEmailId());
        }
        partyCode.getCode().setApplicationLevelIndicator(false);
        //need to check with sort order
        partyCode.getCode().setSortOrder(1);

        //		crmManager.saveCode(partyCode.getCode());
        

       /* baseURL = request.getParameter("baseURL");
        returnURL = baseURL + "?id=" + partyCode.getId() +
            "&saveSuccess=true";*/
        try{
        	crmManager.savePartyCode(partyCode);
			          responseText.append("\""+partyCode.getId()+"\"}");
				 	  logger.info("SAVED ****** "+partyCode.getId());
	               
	           }catch(Exception e){
	          logger.error("Exception occurred during save for code "+ e);
	          System.out.println("error"+e);
	          responseText.append("\"-1\"}");
	          
	         }
		 	
		
        //remove the impacted item from cache, so that it can be refreshed on UI
       // CacheManagerServlet.removeFirmLevelCache(firmId, partyCode.getCode().getCodeType().getId().toString(), "code" );
        return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
        }else{
        	model.addAttribute("invalidCode", "Given Code already exists. Please enter different one");
        	responseText.append("\"-1\"}");
        	return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
        }
        /*return "redirect:" + returnURL;*/
    }

    @RequestMapping(value = {"/firmadmin/managePartyCode.do","/mobilefirmadmin/managePartyCodeMobile.do"}, method = RequestMethod.GET)
    public String getManagePartyCode(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("partyCode") PartyCode partyCode) {
        logger.info("Get Party Code!!");
        PMUtil.showStatusMessage(request, model);

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        
        List<CodeType> codeTypeSet = crmManager.getCodeTypeListWhereApplcationLevelIsFalse();
        //		List<Code> parentCodeSet = crmManager.getCodeList();
        model.addAttribute("codeTypeSet", codeTypeSet);

        //		model.addAttribute("parentCodeSet", parentCodeSet);
        if (request.getRequestURI().contains("/firmadmin/managePartyCode.do")){
           return "firmadmin/managePartyCode";
        }else{
           return "managePartyCodeMobile.tilesView";
        }
        
   }

}
