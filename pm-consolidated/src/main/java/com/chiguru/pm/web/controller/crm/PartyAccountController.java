package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.AccountSearch;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.service.GridService;
import com.chiguru.pm.crm.util.GridUtil;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.web.util.GridJSONResponse;
import com.chiguru.pm.web.util.PMUtil;

/**
 * Handles requests for the application welcome page.
 */
@Controller
public class PartyAccountController extends BaseController {
	@Autowired
    private GridService gridService;

	private Logger logger = org.slf4j.LoggerFactory
			.getLogger(PartyAccountController.class);

	
	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = {"/client/accountAjaxList.do","/mobileclient/mobileAccountAjaxList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse clientAjaxList(HttpServletRequest request, Long clientId) {
		logger.info("Account List!");
		Map retMap = new HashMap();

		Long firmId = PMUtil.getFirmIdFromSession(request);
		Long accountCategory = Long.valueOf(request.getParameter("accountCategory"));
		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do")
				&& firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}

		HttpSession session1 = request.getSession();
		if (clientId == null) {
			clientId = (Long) session1.getAttribute("clientId");
			if (clientId == null) {
				throw new RuntimeException("client Id can not be empty");
			}
		}
		String sEcho = request.getParameter("sEcho");
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
	//	AccountSearch command = new AccountSearch();
    	AccountSearch command = null;
    	if(accountCategory == 702){
    		 command = GridUtil.setFilterParametersForAgent(request);    	
    	}else {
    		 command = GridUtil.setFilterParametersForPartyAccount(request);    
		} 
		              command.setClientId(clientId);
		              command.setAccountCategory(accountCategory);
		              command.setActiveFlag(true);
		Long count = gridService.getPartyAccountCountById(command);
		command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	List<PartyAccountDTO> partyAccountList =gridService.getPartyAccountListById(command);
    	GridJSONResponse jsonResponse = null;
    	if(accountCategory == 702){
    	 jsonResponse = prepareResponForAgent(partyAccountList);
    	}else{
    	 jsonResponse = prepareRespon(partyAccountList, accountCategory);
    	}
    	jsonResponse.setsEcho(sEcho);
        jsonResponse.setiTotalDisplayRecords(count);
        return jsonResponse;
	}

	private GridJSONResponse prepareRespon(List<PartyAccountDTO> partyAccountList, Long accountCategory/*, Long clientId*/) {
		String javascriptName = null;
		if(accountCategory == 700){
			javascriptName = "BankEdit";
		}else if(accountCategory == 701){
			javascriptName = "InsuranceEdit";
		}else if(accountCategory == 703){
			javascriptName = "editLaw";
		}
		
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(partyAccountList.size()>0){
			for(PartyAccountDTO partyAccountDTO: partyAccountList){
				Object[] objects = new Object[8];
				objects[0] = partyAccountDTO.getNewId();
				objects[1] = partyAccountDTO.getAccountFirmName();
				objects[2] = partyAccountDTO.getAccountType();
				objects[3] = partyAccountDTO.getAccountNumber();
				objects[4] = partyAccountDTO.getContactName();
				objects[5] = partyAccountDTO.getOfficeNumber();
				objects[6] = partyAccountDTO.getEmailAddress();
				/*if(accountCategory == 700){
				objects[7] = "<a class='javascript:colorBoxDemoBank cboxElement' href='clientBankColor.do?clientId="+clientId+"&id="+partyAccountDTO.getNewId()+"'>edit</a>";
				}else if(accountCategory == 701){
					objects[7] = "<a class='javascript:colorBoxDemoIns cboxElement' href='clientInsuranceCol.do?clientId="+clientId+"&id="+partyAccountDTO.getNewId()+"'>edit</a>";
				}else if(accountCategory == 702){											
					objects[7] = "<a class='javascript:colorBoxDemoTransAgent cboxElement' href='clientTransferAgentCol.do?clientId="+clientId+"&id="+partyAccountDTO.getNewId()+"'>edit</a>";
				}else if(accountCategory == 703){
					objects[7] = "<a class='javascript:colorBoxDemoLaw cboxElement' href='clientLawyerCol.do?clientId="+clientId+"&id="+partyAccountDTO.getNewId()+"'>edit</a>";
				}*/	
				objects[7] = "<a href='javascript:"+javascriptName+"(" + partyAccountDTO.getNewId() + ")'>edit</a>";
				aaData.add(objects);
			}
		}
		jsonResponse.setAaData(aaData);
		jsonResponse.setiTotalRecords(10);
		return jsonResponse;
	}

	private GridJSONResponse prepareResponForAgent(List<PartyAccountDTO> partyAccountList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(partyAccountList.size()>0){
			for(PartyAccountDTO partyAccountDTO: partyAccountList){
				Object[] objects = new Object[7];
				objects[0] = partyAccountDTO.getNewId();
				objects[1] = partyAccountDTO.getAccountFirmName();
				objects[2] = partyAccountDTO.getAccountNumber();
				objects[3] = partyAccountDTO.getContactName();
				objects[4] = partyAccountDTO.getOfficeNumber();
				objects[5] = partyAccountDTO.getEmailAddress();
				objects[6] = "<a href='javascript:TransferEdit(" + partyAccountDTO.getNewId() + ")'>edit</a>";
				aaData.add(objects);
			}
		}
		jsonResponse.setAaData(aaData);
		jsonResponse.setiTotalRecords(10);
		return jsonResponse;
		
	}

	
	private void mobileBankMethod(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Bank Module!");
		Code accountcategory = codesManager.getCodeById((long) 700);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
	}
	
	private void setScreenData(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (! request.getRequestURI().contains("/appadmin/adminFirmModule.do") && firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}
		setReferenceData(model, account, firmId);
		account.getDefaultPointOfContact().populateAllCommunications();
	}
	
	private void setReferenceData(ModelMap model, PartyAccount account, Long firmId) {
		// Map<CodeType, Set<Code>> codeTypeMap =
		// codesManager.getApplicationLevelCodeMap();
		
		
		List industryCodeSet = codesManager
				.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
		List formOfBusinessTypeSet = codesManager
				.getCodesByCodeType(CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId());
/*		List<Code> countryCodeSet = codesManager
				.getCodesByCodeType(CodeType.COUNTRY_CODE_TYPE.getId());*/
		Set<Code> accountTypeCodeSet = null;
		Long accountId = (long) 0;
		if(!account.equals(null)){
			Code accountCategoryNew = account.getAccountCategory();
			if(accountCategoryNew != null){
		      accountId = accountCategoryNew.getId();
			}
		}
		if(accountId != null & accountId != (long) 0){
		 accountTypeCodeSet = PMUtil.getChildrenCodeSet(account.getAccountCategory().getId(), codesManager);
		}
		RelationshipType relType = null;
		Code accountCategory = account.getAccountCategory();
		if(accountCategory.getShortName().equals("Bank Account")){
			relType = RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK;
		}else if(accountCategory.getShortName().equals("Insurance Policy Account")){
			relType = RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM;
		}else if(accountCategory.getShortName().equals("Transfer Agency Account")){
			relType = RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM;
		}else if(accountCategory.getShortName().equals("Law Firm Account")){
			relType = RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM;
		}
			
		List<Party>  partyListFromDB = crmManager.getRelatedPartiesById(firmId, 
				relType.getId());

		model.addAttribute("industryCodeSet", industryCodeSet);
		model.addAttribute("formOfBusinessCodeSet", formOfBusinessTypeSet);
//		model.addAttribute("countryCodeSet", countryCodeSet);
		model.addAttribute("phoneCommunicationTypeSet", PMConstants.PHONE_TYPE_LIST);
		model.addAttribute("accountTypeCodeSet",
				accountTypeCodeSet);
		model.addAttribute("mainEntityList",
				partyListFromDB);
		
		Address address = account.getAddress();
		if (address != null && address.getCountryCode() != null) {
			List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
			model.addAttribute("statesSet", stateSet);
		}
		
		List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);
		model.addAttribute("countryCodeSet", countryCodeSet);
		
	}
}