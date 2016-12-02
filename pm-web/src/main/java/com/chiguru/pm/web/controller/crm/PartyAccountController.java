package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.AutoPopulatingList;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.web.util.PMUtil;

/**
 * Handles requests for the application welcome page.
 */
@Controller
public class PartyAccountController extends BaseController{

	private Logger logger = org.slf4j.LoggerFactory
			.getLogger(PartyAccountController.class);

    @ModelAttribute
	public PartyAccount initializeModel(Long id, Long clientId, Long accountCategory, PartySiteType siteType, HttpServletRequest request) {
		
		Long firmId = PMUtil.getFirmIdFromSession(request);
		
		if (! request.getRequestURI().contains("/appadmin/adminFirmModule.do") && firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}
		
		if(clientId == null){
				throw new RuntimeException("client Id can not be empty");
		}
		
		//removed relationType=1 from Link in clientBank.jsp, 
		String servletPath = request.getServletPath();
		
		if(servletPath.equals("/client/clientBank.do")){
			accountCategory = PartyAccount.BANK_ACCOUNT_TYPE;
		}else if(servletPath.equals("/client/clientLawyer.do")){
			accountCategory = PartyAccount.LAWYER_ACCOUNT_TYPE;
		}else if(servletPath.equals("/client/clientInsurance.do")){
			accountCategory = PartyAccount.INSURANCE_ACCOUNT_TYPE;
		}else if(servletPath.equals("/client/clientTransferAgent.do")){
			accountCategory = PartyAccount.TRANSFER_AGENT_ACCOUNT_TYPE;
		}else if(servletPath.equals("/mobileclient/mobileClientBank.do")){
			accountCategory = PartyAccount.BANK_ACCOUNT_TYPE;
		}else if(servletPath.equals("/mobileclient/mobileClientInsurance.do")){
			accountCategory = PartyAccount.INSURANCE_ACCOUNT_TYPE;
		}else if(servletPath.equals("/mobileclient/mobileClientTAgent.do")){
			accountCategory = PartyAccount.TRANSFER_AGENT_ACCOUNT_TYPE;
		}else if(servletPath.equals("/mobileclient/clientLawyerMobile.do")){
			accountCategory = PartyAccount.LAWYER_ACCOUNT_TYPE;
		}
		
		PartyAccount account;
		HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
		if( session.getAttribute("inValidClientId")==null){
			if (id == null) {
				account = new PartyAccount();
				PointOfContact contact = account.getDefaultPointOfContact();
//				contact.setCreateUserId("system");
				account.setAccountCategory(codesManager.getCodeById(accountCategory));
				Party party = crmManager.getPartyById(clientId);
				account.setParty(party);
				contact.setParty(party);
			
						
			} else {
				account = crmManager.getAccountByIdAndAccountType(id,
						accountCategory);
				if(account == null){
					throw new RuntimeException("Account not found");
				}
				
			}
			PointOfContact pointOfContact = account.getDefaultPointOfContact();
			List phoneList = new AutoPopulatingList(PhoneCommunication.class);
			phoneList.addAll(pointOfContact.getPhoneList());
			List emailList = new AutoPopulatingList(EmailCommunication.class);
			emailList.addAll(pointOfContact.getEmailList());
			List webURLList = new AutoPopulatingList(WebCommunication.class);
			webURLList.addAll(pointOfContact.getWebUrlList());
			List faxList = new AutoPopulatingList(FaxCommunication.class);
			faxList.addAll(pointOfContact.getFaxList());
			
			account.getDefaultPointOfContact().setPhoneList(phoneList);
			account.getDefaultPointOfContact().setFaxList(faxList);
			account.getDefaultPointOfContact().setEmailList(emailList);
			account.getDefaultPointOfContact().setWebUrlList(webURLList);
		}else{
			account = new PartyAccount();
			PointOfContact contact = account.getDefaultPointOfContact();
//			contact.setCreateUserId("system");
			account.setAccountCategory(codesManager.getCodeById(accountCategory));
			Party party = crmManager.getPartyById(clientId);
			account.setParty(party);
			contact.setParty(party);
			
			PointOfContact pointOfContact = account.getDefaultPointOfContact();
			List phoneList = new AutoPopulatingList(PhoneCommunication.class);
			phoneList.addAll(pointOfContact.getPhoneList());
			List emailList = new AutoPopulatingList(EmailCommunication.class);
			emailList.addAll(pointOfContact.getEmailList());
			List webURLList = new AutoPopulatingList(WebCommunication.class);
			webURLList.addAll(pointOfContact.getWebUrlList());
			List faxList = new AutoPopulatingList(FaxCommunication.class);
			faxList.addAll(pointOfContact.getFaxList());
			
			account.getDefaultPointOfContact().setPhoneList(phoneList);
			account.getDefaultPointOfContact().setFaxList(faxList);
			account.getDefaultPointOfContact().setEmailList(emailList);
			account.getDefaultPointOfContact().setWebUrlList(webURLList);
		}
		return account;
	}

	
	@ModelAttribute
	public List<PhoneCommunication> initializeModelForDeletes(PartyAccount account,
			HttpServletRequest request) {
		List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();
		
		if (request.getMethod().equals("POST")) {
			List<PhoneCommunication> origPhoneList = account.getDefaultPointOfContact().getPhoneList();
			phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
					origPhoneList, "defaultPointOfContact.phoneList", request);
			
					}
		return phonesToBeDeletedList;
	}
	
	public void saveAccount(HttpServletRequest request, ModelMap model,
			 PartyAccount account, BindingResult result, SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
		
		logger.info("SAVE ACCOUNT");
		if(account != null){
			List<PointOfContact> listOfPointOfContact = account.getPointOfContactList();
			for (PointOfContact pointOfContact : listOfPointOfContact) {
//				pointOfContact.setCreateUserId("system");
				pointOfContact.setLastUpdateDate(new Date());
//				pointOfContact.setLastUpdateUserId("system");
				pointOfContact.setActiveFlag(true);
				setPointOfContact(pointOfContact);
			}
			  if(account.getAddress().getCountryCode() == -1)
		        {
				  account.getAddress().setCountryCode(null);
				  account.getAddress().setStateCode(null);
		        } 
		}
		logger.info("account number: "+account.getAccountNumber());
		crmManager.savePartyAccount(account, phonesToBeRemoved);
				
	}

	

	@RequestMapping(value = {"/client/clientBank.do","/mobileclient/mobileClientBank.do"}, method = RequestMethod.POST)
	public String saveBank(HttpServletRequest request, ModelMap model,
			@ModelAttribute("partyAccount") PartyAccount partyAccount, List<PhoneCommunication> phonesToBeRemoved,
			SessionStatus status) {
		logger.info("SAVE BANK");
		
//		String returnURL = "client/clientBank.do";
		BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
		if(result.hasErrors()) {
			setScreenData(request, model, partyAccount);
			//has errors go back to original form that has errors
			return null;
        	
        }
		saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
		//String baseURL = request.getParameter("baseURL");
		/*returnURL = returnURL.concat("&saveSuccess=true");

		return "redirect:"+returnURL;*/
//		return getBank(request, model,account);
		
		
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?id=" + partyAccount.getId()
			+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

		return "redirect:"+returnURL;
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
	
	@RequestMapping(value = "/client/clientTransferAgent.do", method = RequestMethod.POST)
	public String saveTransferAgent(HttpServletRequest request, ModelMap model,
			@Valid PartyAccount partyAccount,  List<PhoneCommunication> phonesToBeRemoved,
			SessionStatus status) {
		logger.info("Transfer Agent");
		BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
		if(result.hasErrors()) {
			setScreenData(request, model, partyAccount);
			return null;
        	
        }
		saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
		
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?id=" + partyAccount.getId()
			+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

		return "redirect:"+returnURL;
	}

	@RequestMapping(value = "/mobileclient/mobileClientTAgent.do", method = RequestMethod.POST)
	public String saveTransferAgentMobile(HttpServletRequest request, ModelMap model,
			@Valid PartyAccount partyAccount,  List<PhoneCommunication> phonesToBeRemoved,
			SessionStatus status) {
		logger.info("Transfer Agent");
		BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
		if(result.hasErrors()) {
			setScreenData(request, model, partyAccount);
			return null;
        	
        }
		saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
		
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?id=" + partyAccount.getId()
			+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

		return "redirect:"+returnURL;
	}

	@RequestMapping(value = "/client/clientTransferAgent.do", method = RequestMethod.GET)
	public String getTransferAgent(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Transfer Agent Module!");
		Code accountcategory = codesManager.getCodeById((long) 702);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		model.addAttribute("account", account);
		return "clientTransferAgent.tilesView";
	}

	@RequestMapping(value = "/mobileclient/mobileClientTAgent.do", method = RequestMethod.GET)
	public String getTransferAgentMobile(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Transfer Agent Module!");
		Code accountcategory = codesManager.getCodeById((long) 702);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		//model.addAttribute("account", account);
		return "clientTransferAgentMobile.tilesView";
	}
	
	@RequestMapping(value = "/client/clientBank.do", method = RequestMethod.GET)
	public String getBank(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		mobileBankMethod(request, model, account);
		//model.addAttribute("account", account);
		return "clientBank.tilesView";
		
	}


	private void mobileBankMethod(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Bank Module!");
		Code accountcategory = codesManager.getCodeById((long) 700);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
	}
	
	@RequestMapping(value = "/mobileclient/mobileClientBank.do", method = RequestMethod.GET)
	public String getMobileBank(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		mobileBankMethod(request, model, account);
		//model.addAttribute("account", account);
		return "mobileClientBank.tilesView";
		
	}
	
	@RequestMapping(value = "/client/clientLawyer.do", method = RequestMethod.GET)
	public String getClientLawyer(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Client Lawyer Module!");
		lawyersmethod(request, model, account);
		return "clientLawyer.tilesView";
	}

	@RequestMapping(value = "/mobileclient/clientLawyerMobile.do", method = RequestMethod.GET)
	public String getClientLawyerMobile(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Client Lawyer Mobile!");
		lawyersmethod(request, model, account);
		return "clientLawyerMobile.tilesView";
	}

	private void lawyersmethod(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		Code accountcategory = codesManager.getCodeById((long) 703);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		model.addAttribute("partyAccount", account);
	}
	
	@RequestMapping(value = {"/client/clientLawyer.do","/mobileclient/clientLawyerMobile.do"}, method = RequestMethod.POST)
	public String saveLawyer(HttpServletRequest request, ModelMap model,
			@Valid @ModelAttribute("partyAccount")PartyAccount partyAccount, List<PhoneCommunication> phonesToBeRemoved,
			SessionStatus status) {
		logger.info("SAVE LAWYER");
		BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
		if(result.hasErrors()) {
			setScreenData(request, model, partyAccount);
			return null;
        	
        }
		saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
		
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?id=" + partyAccount.getId()
			+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

		return "redirect:"+returnURL;
	}

	
	@RequestMapping(value = "/client/clientInsurance.do", method = RequestMethod.GET)
	public String getInsurance(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		mobileinsuranceMethod(request, model, account);
		model.addAttribute("account", account);
		return "clientInsurance.tilesView";
	}


	private void mobileinsuranceMethod(HttpServletRequest request,
			ModelMap model, PartyAccount account) {
		logger.info("Insurance Module!");
		Code accountcategory = codesManager.getCodeById((long) 701);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		
	}
	
	@RequestMapping(value = "/mobileclient/mobileClientInsurance.do", method = RequestMethod.GET)
	public String getInsuranceMobile(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		mobileinsuranceMethod(request, model, account);
		//model.addAttribute("account", account);
		return "mobileClientInsurance.tilesView";
	}
	
	
	@RequestMapping(value = {"/client/clientInsurance.do","/mobileclient/mobileClientInsurance.do"}, method = RequestMethod.POST)
	public String saveInsurance(HttpServletRequest request, ModelMap model,
			@Valid PartyAccount partyAccount, List<PhoneCommunication> phonesToBeRemoved,SessionStatus status) {
		logger.info("SAVE INSURANCE");
		BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
		if(result.hasErrors()) {
			setScreenData(request, model, partyAccount);
			return null;
        	
        }
		saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
		
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?id=" + partyAccount.getId()
			+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

		return "redirect:"+returnURL;
	}

	
		/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/client/accountAjaxList.do",method = RequestMethod.GET)
	public @ResponseBody Map clientAjaxList(HttpServletRequest request, Long clientId) {
		logger.info("Account List!");
		Map retMap = new HashMap();
		
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (! request.getRequestURI().contains("/appadmin/adminFirmModule.do") && firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}
		
		Page page = PMUtil.populatePageObject(request);
		Long accountCategory = Long.valueOf(request.getParameter("accountCategory"));
		
	    
        if (page != null) {
        	Long count = crmManager.getPartyAccountDTOCountById(clientId,accountCategory);
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PartyAccountDTO> partyAccountList = crmManager.getPartyAccountDTOListById(clientId,accountCategory, page);
    
        populateReturnMapWithPageDatails(retMap, partyAccountList, page);
        return retMap;
		
	}
	
	
	@RequestMapping(value = "/client/accountMobileAjaxList.do",method = RequestMethod.GET)
	public @ResponseBody Map clientAjaxListMobile(HttpServletRequest request, Long clientId) {
		logger.info("Account List!");
		Map retMap = new HashMap();
		
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (! request.getRequestURI().contains("/appadmin/adminFirmModule.do") && firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}
		
		Page page = PMUtil.populatePageObject(request);
		Long accountCategory = Long.valueOf(request.getParameter("accountCategory"));
		
	    
        if (page != null) {
        	Long count = crmManager.getPartyAccountDTOCountById(clientId,accountCategory);
        	PMUtil.adjustPagination(page, count.intValue());
        	page.setCount(count.intValue());
    	}
    	List<PartyAccountDTO> partyAccountList = crmManager.getPartyAccountDTOListById(clientId,accountCategory, page);
    
        populateReturnMapWithPageDatails(retMap, partyAccountList, page);
        return retMap;
		
	}
	
	private void populateReturnMapWithPageDatails(Map retMap, List entityList,Page page) {
	        retMap.put("rows", entityList);
	        if (page != null) {
	            retMap.put("page", page.getCurrentPage());
	            retMap.put("total", page.getTotalPages());
	            retMap.put("records", page.getCount());
	        }
	}



	/*private PartyAccountDTO getPartyaccountDTO(PartyAccount partyaccount) {
		PartyAccountDTO accountDTO = new PartyAccountDTO();
		accountDTO.setId(partyaccount.getId());
		accountDTO.setAccountFirmName(partyaccount.getAccountEntityName());
		//accountDTO.setAccountFirmName(partyaccount.getPartySite().getParty().getName());
		accountDTO.setAccountCategory(partyaccount.getAccountCategory().getLongDescription());
		if(partyaccount.getAccountType() != null){
			accountDTO.setAccountType(partyaccount.getAccountType().getLongDescription());
		}
		accountDTO.setTerms(partyaccount.getTerms());
		accountDTO.setAccountNumber(partyaccount.getAccountNumber());
		if(partyaccount.activeFlag == true){
			accountDTO.setStatus("Active");
		}else{
			accountDTO.setStatus("Inactive");
		}
		if(partyaccount.getPointOfContactList().size()>0){
			PointOfContact pointOfContact = partyaccount.getPointOfContactList().get(0);
			accountDTO.setContactName(pointOfContact.getContactName());
			
			if(pointOfContact.getEmailList().size()>0){
				EmailCommunication email = pointOfContact.getEmailList().get(0);
//				accountDTO.getCommunicationDTO().setEmailAddress(email.getContactDetail());
				FaxCommunication fax = pointOfContact.getFaxList().get(0);
				WebCommunication web = pointOfContact.getWebUrlList().get(0);
				List<PhoneCommunication> phoneList = pointOfContact.getPhoneList();
				
				CommunicationDTO communicationDTO = new CommunicationDTO();
				communicationDTO.setEmailAddress(email.getContactDetail());
				communicationDTO.setFax(fax.getContactDetail());
				communicationDTO.setWebUrlList(web.getContactDetail());
				if(phoneList.size() > 0){
					for (PhoneCommunication phoneCommunication : phoneList) {
						if(PMConstants.OFFICE_PHONE.equals(phoneCommunication.getSubType())){
							communicationDTO.setOfficeNumber(phoneCommunication.getContactDetail());
						}else if(PMConstants.MOBILE_PHONE.equals(phoneCommunication.getSubType())){
							communicationDTO.setMobileNumber(phoneCommunication.getContactDetail());
						}else if(PMConstants.HOME_PHONE.equals(phoneCommunication.getSubType())){
							communicationDTO.setHomeNumber(phoneCommunication.getContactDetail());
						}else if(PMConstants.OTHER_PHONE.equals(phoneCommunication.getSubType())){
							communicationDTO.setOtherNumber(phoneCommunication.getContactDetail());
						}	
					}
				}
				
				accountDTO.setCommunicationDTO(communicationDTO);
			}
			
			
		}
		return accountDTO;
	}*/
	
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