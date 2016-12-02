package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.AutoPopulatingList;
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
public class ClientLawyerController  extends BaseController{

	private Logger logger = org.slf4j.LoggerFactory
	.getLogger(ClientLawyerController.class);
	
	@ModelAttribute
	public PartyAccount initializeModel(Long id, Long clientId,
			Long accountCategory, PartySiteType siteType,
			HttpServletRequest request) {

		Long firmId = PMUtil.getFirmIdFromSession(request);

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

		// removed relationType=1 from Link in clientBank.jsp,
		String servletPath = request.getServletPath();
	    if (servletPath.equals("/client/clientLawyer.do")|| servletPath.equals("/mobileclient/mobileClientLawyer.do") || servletPath.equals("/mobileclient/mobilecLawyer.do")) {
			accountCategory = PartyAccount.LAWYER_ACCOUNT_TYPE;																	  
		}

		PartyAccount account;
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpSession session = httpReq.getSession(false);
		if (session.getAttribute("inValidClientId") == null) {
			if (id == null) {
				account = new PartyAccount();
				PointOfContact contact = account.getDefaultPointOfContact();
				// contact.setCreateUserId("system");
				account.setAccountCategory(codesManager
						.getCodeById(accountCategory));
				Party party = crmManager.getPartyById(clientId);
				account.setParty(party);
				contact.setParty(party);

			} else {
				account = crmManager.getAccountByIdAndAccountType(id,
						accountCategory);
				if (account == null) {
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
	public List<PhoneCommunication> initializeModelForDeletes(
			PartyAccount account, HttpServletRequest request) {
		List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

		if (request.getMethod().equals("POST")) {
			List<PhoneCommunication> origPhoneList = account
					.getDefaultPointOfContact().getPhoneList();
			phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
					origPhoneList, "defaultPointOfContact.phoneList", request);

		}
		return phonesToBeDeletedList;
	}
	@RequestMapping(value = "/mobileclient/mobilecLawyer.do", method = RequestMethod.GET)
	public String getcLawyer(HttpServletRequest request, ModelMap model){
		return "cLawyerMobile.tilesView";
	}
	@RequestMapping(value = {"/client/clientLawyer.do","/mobileclient/mobileClientLawyer.do"}, method = RequestMethod.GET)
	public String getClientLawyer(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Client Lawyer Module!");
		String servletPath = request.getServletPath();
		Code accountcategory = codesManager.getCodeById((long) 703);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		model.addAttribute("lawyerPartyAccount", account);
		if(servletPath.equals("/mobileclient/mobileClientLawyer.do")){
			return "clientLawyerMobile.tilesView";
		}else{
		return "client/clientLawyer";
		}
	}
	
	@RequestMapping(value = "/client/clientLawyerCol.do", method = RequestMethod.GET)
	public String getClientLawyerCol(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		logger.info("Client Lawyer Module!");
		Code accountcategory = codesManager.getCodeById((long) 703);
		account.setAccountCategory(accountcategory);
		setScreenData(request, model, account);
		PMUtil.showStatusMessage(request, model);
		model.addAttribute("lawyerPartyAccount", account);
		return "client/clientLawyerCol";
	}
	
	@RequestMapping(value = {"/client/clientLawyer.do","/mobileclient/mobileClientLawyer.do"}, method = RequestMethod.POST)
	public ResponseEntity<String> saveLawyer(HttpServletRequest request, ModelMap model,
			@Valid PartyAccount account, 
			List<PhoneCommunication> phonesToBeRemoved, SessionStatus status) {
		logger.info("SAVE LAWYER");
		HttpHeaders responseHeaders = new HttpHeaders();
		 responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"id\":");
		try{
		saveAccountWithoutBindingResult(request, model, account, status, phonesToBeRemoved);
		 responseText.append("\""+account.getId()+"\"}");
	 	  logger.info("ClientLawyer SAVED ****** "+account.getId());
	}catch (Exception e) {
		 logger.error("Exception occurred during Lawyer Save " +e.getMessage());
		 responseText.append("\"-1\"}");
	}
	 return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
	}
	
	private void setScreenData(HttpServletRequest request, ModelMap model,
			PartyAccount account) {
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do")
				&& firmId == null) {
			throw new RuntimeException("firmId can not be empty");
		}
		setReferenceData(model, account, firmId);
		account.getDefaultPointOfContact().populateAllCommunications();
	}
	
	private void setReferenceData(ModelMap model, PartyAccount account,
			Long firmId) {
		List industryCodeSet = codesManager
				.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
		List formOfBusinessTypeSet = codesManager
				.getCodesByCodeType(CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId());

		Set<Code> accountTypeCodeSet = null;
		Long accountId = (long) 0;
		if (!account.equals(null)) {
			Code accountCategoryNew = account.getAccountCategory();
			if (accountCategoryNew != null) {
				accountId = accountCategoryNew.getId();
			}
		}
		if (accountId != null & accountId != (long) 0) {
			accountTypeCodeSet = PMUtil.getChildrenCodeSet(account
					.getAccountCategory().getId(), codesManager);
		}
		RelationshipType relType = null;
		Code accountCategory = account.getAccountCategory();
		if (accountCategory.getShortName().equals("Bank Account")) {
			relType = RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK;
		} else if (accountCategory.getShortName().equals(
				"Insurance Policy Account")) {
			relType = RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM;
		} else if (accountCategory.getShortName().equals(
				"Transfer Agency Account")) {
			relType = RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM;
		} else if (accountCategory.getShortName().equals("Law Firm Account")) {
			relType = RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM;
		}

		List<Party> partyListFromDB = crmManager.getRelatedPartiesById(firmId,
				relType.getId());

		model.addAttribute("industryCodeSet", industryCodeSet);
		model.addAttribute("formOfBusinessCodeSet", formOfBusinessTypeSet);
		// model.addAttribute("countryCodeSet", countryCodeSet);
		model.addAttribute("phoneCommunicationTypeSet",
				PMConstants.PHONE_TYPE_LIST);
		model.addAttribute("accountTypeCodeSet", accountTypeCodeSet);
		model.addAttribute("mainEntityList", partyListFromDB);

		Address address = account.getAddress();
		if (address != null && address.getCountryCode() != null) {
			List stateSet = PMUtil.getCachedDropdownCodesList(firmId,
					CodeType.STATE_CODE_TYPE.getId(), codesManager,
					address.getCountryCode());
			model.addAttribute("statesSet", stateSet);
		}

		List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId,
				CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);
		model.addAttribute("countryCodeSet", countryCodeSet);

	}
	
	public void saveAccountWithoutBindingResult(HttpServletRequest request, ModelMap model,
			PartyAccount account, SessionStatus status,
			List<PhoneCommunication> phonesToBeRemoved) {

		logger.info("SAVE ACCOUNT");
		if (account != null) {
			List<PointOfContact> listOfPointOfContact = account
					.getPointOfContactList();
			for (PointOfContact pointOfContact : listOfPointOfContact) {
				// pointOfContact.setCreateUserId("system");
				pointOfContact.setLastUpdateDate(new Date());
				// pointOfContact.setLastUpdateUserId("system");
				pointOfContact.setActiveFlag(true);
				setPointOfContact(pointOfContact);
			}
			if (account.getAddress().getCountryCode() == -1) {
				account.getAddress().setCountryCode(null);
				account.getAddress().setStateCode(null);
			}
		}
		logger.info("account number: " + account.getAccountNumber());
		crmManager.savePartyAccount(account, phonesToBeRemoved);

	}
}
