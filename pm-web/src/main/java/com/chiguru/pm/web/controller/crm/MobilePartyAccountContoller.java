/*package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.AutoPopulatingList;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.web.util.PMUtil;

@Controller
public class MobilePartyAccountContoller extends BaseController{
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
			
			 if(servletPath.equals("/mobileclient/mobileClientBank.do")){
				accountCategory = PartyAccount.BANK_ACCOUNT_TYPE;
			}else if(servletPath.equals("/mobileclient/mobileClientInsurance.do")){
				accountCategory = PartyAccount.INSURANCE_ACCOUNT_TYPE;
			}
			
			PartyAccount account;
			HttpServletRequest httpReq = (HttpServletRequest) request;
	        HttpSession session = httpReq.getSession(false);
			if( session.getAttribute("inValidClientId")==null){
				if (id == null) {
					account = new PartyAccount();
					PointOfContact contact = account.getDefaultPointOfContact();
//					contact.setCreateUserId("system");
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
//				contact.setCreateUserId("system");
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
	 
	 @RequestMapping(value = "/mobileclient/mobileClientBank.do", method = RequestMethod.GET)
		public String getMobileBank(HttpServletRequest request, ModelMap model,
				PartyAccount account) {
			Code accountcategory = codesManager.getCodeById((long) 700);
			account.setAccountCategory(accountcategory);
			setScreenData(request, model, account);
			PMUtil.showStatusMessage(request, model);
			//model.addAttribute("account", account);
			return "mobileClientBank.tilesView";
			
		}
	 
	 
	 @RequestMapping(value = "/mobileclient/mobileClientBank.do", method = RequestMethod.POST)
		public String saveMobileBank(HttpServletRequest request, ModelMap model,
				@ModelAttribute("partyAccount") PartyAccount partyAccount, List<PhoneCommunication> phonesToBeRemoved,
				SessionStatus status) {
//			String returnURL = "client/clientBank.do";
			BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.partyAccount");
			if(result.hasErrors()) {
				setScreenData(request, model, partyAccount);
				//has errors go back to original form that has errors
				return null;
	        	
	        }
			saveAccount(request,  model, partyAccount,  result,  status,  phonesToBeRemoved);
			//String baseURL = request.getParameter("baseURL");
			returnURL = returnURL.concat("&saveSuccess=true");

			return "redirect:"+returnURL;
//			return getBank(request, model,account);
			
			
			String baseURL = request.getParameter("baseURL");
			String returnURL = baseURL + "?id=" + partyAccount.getId()
				+ "&clientId=" + request.getParameter("clientId")+"&saveSuccess=true";

			return "redirect:"+returnURL;
		}
	 
	 
	 @RequestMapping(value = "/mobileclient/mobileClientInsurance.do", method = RequestMethod.GET)
		public String getInsuranceMobile(HttpServletRequest request, ModelMap model,
				PartyAccount account) {
			
			Code accountcategory = codesManager.getCodeById((long) 701);
			account.setAccountCategory(accountcategory);
			setScreenData(request, model, account);
			PMUtil.showStatusMessage(request, model);
			//model.addAttribute("account", account);
			return "mobileClientIns.tilesView";
		}
		
		
		@RequestMapping(value = "/mobileclient/mobileClientInsurance.do", method = RequestMethod.POST)
		public String saveInsuranceMobile(HttpServletRequest request, ModelMap model,
				@ModelAttribute("partyAccount") PartyAccount partyAccount, List<PhoneCommunication> phonesToBeRemoved,SessionStatus status) {
			
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
		
		
	 public void saveAccount(HttpServletRequest request, ModelMap model,
			 PartyAccount account, BindingResult result, SessionStatus status, List<PhoneCommunication> phonesToBeRemoved) {
		
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
		crmManager.savePartyAccount(account, phonesToBeRemoved);
				
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
			List<Code> countryCodeSet = codesManager
					.getCodesByCodeType(CodeType.COUNTRY_CODE_TYPE.getId());
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
//			model.addAttribute("countryCodeSet", countryCodeSet);
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
*/