package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonDetails;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import java.beans.PropertyEditorSupport;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javax.validation.Valid;


@Controller
public class LocationController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(LocationController.class);
    @Autowired
    private CRMManager crmManager;
    @Autowired
    private CodesManager codesManager;

    //@Autowired
    //private Validator validator;
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Code.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(codesManager.getCodeById(Long.valueOf(text)));
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
        binder.registerCustomEditor(CommunicationType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getCommunicationTypeById(
                                Integer.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        CommunicationType type = (CommunicationType) getValue();

                        return type.getId().toString();
                    } else {
                        return null;
                    }
                }
            });
        binder.registerCustomEditor(PartySite.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "".equals(text)) {
                        setValue(new PartySite());
                    } else {
                        setValue(crmManager.getPartySiteById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        PartySite site = (PartySite) getValue();

                        if ((site != null) && (site.getId() != null)) {
                            retValue = site.getId().toString();
                        }
                    }

                    return retValue;
                }
            });
        binder.registerCustomEditor(PartySiteType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPartySiteTypeById(
                                Integer.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        PartySiteType site = (PartySiteType) getValue();

                        if ((site != null) && (site.getId() != null)) {
                            retValue = site.getId().toString();
                        }
                    }

                    return retValue;
                }
            });
        binder.registerCustomEditor(Party.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPartyById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Party party = (Party) getValue();

                        if ((party != null) && (party.getId() != null)) {
                            retValue = party.getId().toString();
                        }
                    }

                    return retValue;
                }
            });

        binder.registerCustomEditor(PointOfContact.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPointOfContactById(Long.valueOf(
                                    text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        PointOfContact site = (PointOfContact) getValue();

                        if ((site != null) && (site.getId() != null)) {
                            retValue = site.getId().toString();
                        }
                    }

                    return retValue;
                }
            });
    }

    @ModelAttribute("partySite")
    public PartySite initializeModel(Long clientId, Long partyId, Long id,
        HttpServletRequest request) {
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        /*if(clientId ==  null && partyId == null ){
                throw new RuntimeException("partyId can not be empty");
        }*/
        
        HttpSession session1 = request.getSession();
		if(clientId == null){
			clientId = (Long) session1.getAttribute("clientId");
			if(clientId == null){
				throw new RuntimeException("client Id can not be empty");
			}
		}
		
        if (clientId != null) {
            partyId = clientId;
        }

        PartySite partySite = null;

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        if( session.getAttribute("inValidClientId")==null){
	        if (id != null) {
	            partySite = crmManager.getPartySiteById(id);
	        } else {
	            Party party = null;
	
	            if (partyId != null) {
	                party = crmManager.getPartyById(partyId);
	            } else {
	                party = new Party();
	            }
	
	            partySite = new PartySite();
	            //			partySite = party.getDefaultPartySite();
	            partySite.setParty(party);
	            party.addPartySite(partySite);
	//            partySite.setCreateUserId("system");
	
	            PointOfContact contact = partySite.getDefaultPointOfContact();
	//            contact.setCreateUserId("system");
	        }
	
	        PointOfContact pointOfContact = partySite.getDefaultPointOfContact();
	        List phoneList = new AutoPopulatingList(PhoneCommunication.class);
	        phoneList.addAll(pointOfContact.getPhoneList());
	
	        List emailList = new AutoPopulatingList(EmailCommunication.class);
	        emailList.addAll(pointOfContact.getEmailList());
	
	        List webURLList = new AutoPopulatingList(WebCommunication.class);
	        webURLList.addAll(pointOfContact.getWebUrlList());
	
	        List faxList = new AutoPopulatingList(FaxCommunication.class);
	        faxList.addAll(pointOfContact.getFaxList());
	
	        partySite.getDefaultPointOfContact().setPhoneList(phoneList);
	        partySite.getDefaultPointOfContact().setFaxList(faxList);
	        partySite.getDefaultPointOfContact().setEmailList(emailList);
	        partySite.getDefaultPointOfContact().setWebUrlList(webURLList);
        }else{        	
        	Party party = null;

            if (partyId != null) {
                party = crmManager.getPartyById(partyId);
            } else {
                party = new Party();
            }

            partySite = new PartySite();
            if(partySite.getId() != null){
	            partySite.setParty(party);
	            party.addPartySite(partySite);
//	            partySite.setCreateUserId("system");
	
	            PointOfContact contact = partySite.getDefaultPointOfContact();
//	            contact.setCreateUserId("system");
	            
	            PointOfContact pointOfContact = partySite.getDefaultPointOfContact();
	            List phoneList = new AutoPopulatingList(PhoneCommunication.class);
	            phoneList.addAll(pointOfContact.getPhoneList());
	
	            List emailList = new AutoPopulatingList(EmailCommunication.class);
	            emailList.addAll(pointOfContact.getEmailList());
	
	            List webURLList = new AutoPopulatingList(WebCommunication.class);
	            webURLList.addAll(pointOfContact.getWebUrlList());
	
	            List faxList = new AutoPopulatingList(FaxCommunication.class);
	            faxList.addAll(pointOfContact.getFaxList());
//	            System.out.println("I AM HERE");
	            partySite.getDefaultPointOfContact().setPhoneList(phoneList);
	            partySite.getDefaultPointOfContact().setFaxList(faxList);
	            partySite.getDefaultPointOfContact().setEmailList(emailList);
	            partySite.getDefaultPointOfContact().setWebUrlList(webURLList);
            }
        }
        return partySite;
    }

    @ModelAttribute
    public List<PhoneCommunication> initializeModelForDeletes(
    		@ModelAttribute ("partySite")PartySite partySite, HttpServletRequest request) {
        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        if (request.getMethod().equals("POST")) {
            List<PhoneCommunication> origPhoneList = partySite.getDefaultPointOfContact()
                                                              .getPhoneList();
            phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                    origPhoneList, "defaultPointOfContact.phoneList", request);
        }

        return phonesToBeDeletedList;
    }

    private List removeDeletedEntries(List toBeDeletedList, List listFromDB,
        String paramName, HttpServletRequest request) {
        Map paraMap = request.getParameterMap();
        Set keySet = paraMap.keySet();

        for (Iterator itComm = listFromDB.iterator(); itComm.hasNext();) {
            PersistentEntity obj = (PersistentEntity) itComm.next();

            if (obj != null) {
                boolean exists = false;

                for (Iterator it = keySet.iterator(); it.hasNext();) {
                    String key = (String) it.next();

                    if (key.contains(paramName) && key.contains("id")) {
                        String value = request.getParameter(key);

                        if ((obj.getId() != null) &&
                                obj.getId().toString().equals(value)) {
                            exists = true;

                            break;
                        }
                    }
                }

                if (!exists) {
                    toBeDeletedList.add(obj);
                    itComm.remove();
                }
            } else {
                itComm.remove();
            }
        }

        return toBeDeletedList;
    }

    @RequestMapping(value = {"/client/clientLocation.do","/mobileclient/mobileclientLocation.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveClientLocation(HttpServletRequest request,
    		PartySite partySite, SessionStatus status,
         ModelMap model, PartySite PartySite, List<PhoneCommunication> phonesToBeDeletedList) {
        logger.info("Client Location Save!");
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
		 StringBuffer responseText = new StringBuffer("{\"id\":");

        Long firmId = PMUtil.getFirmIdFromSession(request);
       

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        Long clientId = Long.valueOf(request.getParameter("clientId"));
        try{
        saveLocationWithoutBidingResult(request, partySite,status, phonesToBeDeletedList);
        responseText.append("\""+partySite.getId()+"\"}");
	 	  logger.info("SAVED ****** "+partySite.getId());
     
         }catch(Exception e){
       logger.error("Exception occurred during save for location Save ");
          responseText.append("\"-1\"}");

         }
         return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
      
    }

    private void saveLocation(HttpServletRequest request, PartySite partySite,
        BindingResult result, SessionStatus status,
        List<PhoneCommunication> phonesToBeRemoved) {
        List<PointOfContact> listOfPointOfContact = partySite.getPointOfContactList();

        for (PointOfContact pointOfContact : listOfPointOfContact) {
//            pointOfContact.setCreateUserId("system");
            pointOfContact.setLastUpdateDate(new Date());
//            pointOfContact.setLastUpdateUserId("system");
            pointOfContact.setActiveFlag(true);
            setPointOfContact(pointOfContact);
        }
        
        if(partySite.getAddress().getCountryCode() == -1)
        {
         partySite.getAddress().setCountryCode(null);
         partySite.getAddress().setStateCode(null);
        }
        
        //need to find workaround for the following
        crmManager.savePartySite(partySite);
        crmManager.deletePhoneCommunication(phonesToBeRemoved);
    }
    
    private void saveLocationWithoutBidingResult(HttpServletRequest request, PartySite partySite,
            SessionStatus status,
            List<PhoneCommunication> phonesToBeRemoved) {
            List<PointOfContact> listOfPointOfContact = partySite.getPointOfContactList();

            for (PointOfContact pointOfContact : listOfPointOfContact) {
//                pointOfContact.setCreateUserId("system");
                pointOfContact.setLastUpdateDate(new Date());
//                pointOfContact.setLastUpdateUserId("system");
                pointOfContact.setActiveFlag(true);
                setPointOfContact(pointOfContact);
            }
            
            if(partySite.getAddress().getCountryCode() == -1)
            {
             partySite.getAddress().setCountryCode(null);
             partySite.getAddress().setStateCode(null);
            }
            
            //need to find workaround for the following
            crmManager.savePartySite(partySite);
            crmManager.deletePhoneCommunication(phonesToBeRemoved);
        }

    private void setPointOfContact(PointOfContact poc) {
        setPointOfContact(poc, poc.getEmailList());
        setPointOfContact(poc, poc.getFaxList());
        setPointOfContact(poc, poc.getPhoneList());
        setPointOfContact(poc, poc.getWebUrlList());
    }

    private void setPointOfContact(PointOfContact poc, List commList) {
        for (Iterator it = commList.iterator(); it.hasNext();) {
            Communication communication = (Communication) it.next();
//            communication.setCreateUserId("system");

            communication.setLastUpdateDate(new Date());
//            communication.setLastUpdateUserId("system");
            communication.setActiveFlag(true);
            communication.setPointOfContact(poc);
        }
    }

    @RequestMapping(value = "/manageBankBranch.do", method = RequestMethod.POST)
    public String manageBankBranch(PartySite partySite, BindingResult result,
        HttpServletRequest request, SessionStatus status) {
        logger.info("manageBankBranch() Save!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (result.hasErrors()) {
            return "manageBankBranch";
        }
        
        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        
            List<PhoneCommunication> origPhoneList = partySite.getDefaultPointOfContact()
                                                              .getPhoneList();
            phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                    origPhoneList, "defaultPointOfContact.phoneList", request);
        

        //	Long partyId = Long.valueOf(request.getParameter("partyId"));
        saveLocation(request, partySite, result, status, phonesToBeDeletedList);

        return "redirect:/Chiguru/manageBankBranch.do?id=" + partySite.getId() +
        "&partyId=" + partySite.getParty().getId() + "&saveSuccess=true";
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/manageLawFirmOffice.do", method = RequestMethod.GET)
    public void manageLawFirmOffice(HttpServletRequest request, ModelMap model,
        PartySite partySite) {
        logger.info("manageLawFirmOffice() !");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, partySite, firmId);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE.equals(type.getId()) ||
                    PartySiteType.BRANCH_OFFICE_PARTY_SITE_TYPE.equals(
                        type.getId()))) {
                it.remove();
            }
        }

        List<Party> partyList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM.getId());
        model.addAttribute("lawFirmList", partyList);
    }

    @RequestMapping(value = "/manageLawFirmOffice.do", method = RequestMethod.POST)
    public String manageLawFirmOffice(PartySite partySite,
        BindingResult result, HttpServletRequest request, SessionStatus status) {
        logger.info("manageLawFirmOffice() Save!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (result.hasErrors()) {
            return "manageLawFirmOffice";
        }
        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        
        List<PhoneCommunication> origPhoneList = partySite.getDefaultPointOfContact()
                                                          .getPhoneList();
        phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                origPhoneList, "defaultPointOfContact.phoneList", request);
    
        
        //	Long partyId = Long.valueOf(request.getParameter("partyId"));
        saveLocation(request, partySite, result, status, phonesToBeDeletedList);

        return "redirect:/Chiguru/manageLawFirmOffice.do?id=" +
        partySite.getId() + "&partyId=" + partySite.getParty().getId() +
        "&saveSuccess=true";
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/manageTransferAgentOffice.do", method = RequestMethod.GET)
    public void manageTransferAgentOffice(HttpServletRequest request,
        ModelMap model, PartySite partySite) {
        logger.info("manageTransferAgentOffice() !");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, partySite, firmId);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE.equals(type.getId()) ||
                    PartySiteType.AGENCY_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }

        List<Party> partyList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM.getId());
        model.addAttribute("transferAgentList", partyList);
    }

    @RequestMapping(value = "/manageTransferAgentOffice.do", method = RequestMethod.POST)
    public String manageTransferAgentOffice(PartySite partySite,
        BindingResult result, HttpServletRequest request, SessionStatus status) {
        logger.info("manageTransferAgentOffice() Save!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (result.hasErrors()) {
            return "manageTransferAgentOffice";
        }

        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        
        List<PhoneCommunication> origPhoneList = partySite.getDefaultPointOfContact()
                                                          .getPhoneList();
        phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                origPhoneList, "defaultPointOfContact.phoneList", request);
    
        //	Long partyId = Long.valueOf(request.getParameter("partyId"));
        saveLocation(request, partySite, result, status, phonesToBeDeletedList);

        return "redirect:/Chiguru/manageTransferAgentOffice.do?id=" +
        partySite.getId() + "&partyId=" + partySite.getParty().getId() +
        "&saveSuccess=true";
    }

    /*@RequestMapping(value = "/manageFirmPartner.do", method = RequestMethod.GET)
    public void saveFirmPartner(HttpServletRequest request, ModelMap model, PartySite partySite, Long firmId) {
            logger.info("firmStaff.do!");
            Long id;
            if(request.getParameter("id")!=null){
                    id=Long.valueOf(request.getParameter("id"));
                    PartySite tempPartySite=crmManager.getPartySiteById(partySite.getId());
                    List<PartySiteCommunication> partySitecom=crmManager.getPartySiteById(partySite.getId()).getPartySiteCommunications();
                    tempPartySite.setPartySiteCommunications(partySitecom);
                    setDataForUI(request, model, tempPartySite, firmId);
            }else{
            setDataForUI(request, model, partySite, firmId);
            }
    
            List<PartySiteType> partySiteTypeCodeSet = (List)model.get("partySiteTypeCodeSet");
            for(Iterator it=partySiteTypeCodeSet.iterator(); it.hasNext();){
                    PartySiteType type = (PartySiteType)it.next();
                    if(!(PartySiteType.HOME_PARTY_SITE_TYPE.equals(type.getId()))){
                            it.remove();
                    }
            }
    }
    
    
    @RequestMapping(value = "/manageFirmPartner.do", method = RequestMethod.POST)
    public String managePartnerBranch(PartySite partySite, BindingResult result, HttpServletRequest request,
                     SessionStatus status, List<PartySiteCommunication> toBeDeletedList) {
    
            logger.info("manageFirmPartner() Save!");
            Long firmId = Long.valueOf(request.getParameter("firmId"));
    
            if (result.hasErrors()) {
                    return "manageFirmPartner";
            }
    //        Long partyId = Long.valueOf(request.getParameter("partyId"));
            saveLocation(request, partySite, result, status, toBeDeletedList );
            return "redirect:/Chiguru/manageFirmPartner.do?id="+partySite.getId()+"&firmId=" + firmId+"&partyId="+partySite.getParty().getId();
    
    }*/

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/manageInsuranceOffice.do", method = RequestMethod.GET)
    public void manageInsuranceOffice(HttpServletRequest request,
        ModelMap model, PartySite partySite) {
        logger.info("manageInsuranceOffice() !");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, partySite, firmId);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE.equals(type.getId()) ||
                    PartySiteType.AGENCY_PARTY_SITE_TYPE.equals(type.getId()))) {
                it.remove();
            }
        }

        List<Party> partyList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM.getId());
        model.addAttribute("insuranceFirmList", partyList);
    }

    @RequestMapping(value = "/manageInsuranceOffice.do", method = RequestMethod.POST)
    public String manageInsuranceOffice(@Valid
    PartySite partySite, BindingResult result, HttpServletRequest request,
        SessionStatus status) {
        logger.info("manageInsuranceOffice() Save!");

        //		Long firmId = Long.valueOf(request.getParameter("firmId"));
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (result.hasErrors()) {
            return "manageInsuranceOffice";
        }

        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

        
        List<PhoneCommunication> origPhoneList = partySite.getDefaultPointOfContact()
                                                          .getPhoneList();
        phonesToBeDeletedList = removeDeletedEntries(phonesToBeDeletedList,
                origPhoneList, "defaultPointOfContact.phoneList", request);
    
        //	Long partyId = Long.valueOf(request.getParameter("partyId"));
        saveLocation(request, partySite, result, status, phonesToBeDeletedList);

        return "redirect:/Chiguru/manageInsuranceOffice.do?id=" +
        partySite.getId() + "&partyId=" + partySite.getParty().getId() +
        "&saveSuccess=true";
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/manageBankBranch.do", method = RequestMethod.GET)
    public void manageBankBranch(HttpServletRequest request, ModelMap model,
        PartySite partySite) {
        logger.info("manageBankBranch() !");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        setDataForUI(request, model, partySite, firmId);

        List<PartySiteType> partySiteTypeCodeSet = (List) model.get(
                "partySiteTypeCodeSet");

        for (Iterator it = partySiteTypeCodeSet.iterator(); it.hasNext();) {
            PartySiteType type = (PartySiteType) it.next();

            if (!(PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE.equals(type.getId()) ||
                    PartySiteType.BRANCH_OFFICE_PARTY_SITE_TYPE.equals(
                        type.getId()))) {
                it.remove();
            }
        }

        List<Party> partyList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK.getId());
        model.addAttribute("bankList", partyList);
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
     @RequestMapping(value = "/mobileclient/mobilecLocation.do", method = RequestMethod.GET)
     public String getClientLocation(HttpServletRequest request,ModelMap model){
    	 return "mobilecLocation.tilesView";
     }
     
    @RequestMapping(value = {"/client/clientLocation.do","/mobileclient/mobileclientLocation.do"}, method = RequestMethod.GET)
    public String getClient(HttpServletRequest request,ModelMap model,
    		@ModelAttribute("partySite")PartySite partySite) {
        logger.info("Client Location!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        String servletPath = httpReq.getServletPath();
        if( session.getAttribute("inValidClientId")==null){
        	setDataForUI(request, model, partySite, firmId);
        }else{
        	setDataForUI(request, model, partySite, firmId);
        }
        
        List<PartySiteType> partySiteTypeCodeSet = crmManager.getPartySiteTypes();
        
        if(partySite != null){
        	Integer partySiteTypeId = 1;
        	if(partySite.getPartySiteType() != null){
        		partySiteTypeId = partySite.getPartySiteType().getId();
        	}
        	if((partySite.getId() == null) || ((partySite.getId() != null) && (partySiteTypeId != 1))){
        		partySiteTypeCodeSet.remove(0);
        	}
        }
        
        model.addAttribute("partySiteTypeCodeSet", partySiteTypeCodeSet);
        
        if(servletPath.equals("/mobileclient/mobileclientLocation.do")){
        	return "mobileClientLocation.tilesView";
        }else{
        	return "client/clientLocation";   //Dont change this to tiles view it should return jsp nly
        }
    }

    @RequestMapping(value = "/client/clientLocationColor.do", method = RequestMethod.GET)
    public String getClientColor(HttpServletRequest request,ModelMap model,
        PartySite partySite) {
        logger.info("Client Location!");

        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        
        if( session.getAttribute("inValidClientId")==null){
        	setDataForUI(request, model, partySite, firmId);
        }else{
        	setDataForUI(request, model, partySite, firmId);
        }
        
        List<PartySiteType> partySiteTypeCodeSet = crmManager.getPartySiteTypes();
        
        logger.info("Trowing null ponter exception here! - client location");
        
        Integer psType = crmManager.getPartySiteByPartyId(firmId);
        
        if(partySite != null){
        	Long id = partySite.getId();
        	PartySiteType ps = crmManager.getPartySiteTypeById(psType);
        	partySite.setPartySiteType(ps);
        	if(partySite.getPartySiteType() != null){
        	Integer pstId = partySite.getPartySiteType().getId();
        	if(pstId != null){
                   if((id != null) && (pstId == 1)){

                  }else{
			          partySiteTypeCodeSet.remove(0);
                  }
                              }
        }
        }
        model.addAttribute("partySiteTypeCodeSet", partySiteTypeCodeSet);
        
        return "clientLocationColor.tilesView";
    }
    
    private void setDataForUI(HttpServletRequest request, ModelMap model,
        PartySite partySite, Long firmId) {
       /* model.addAttribute("partySite", partySite);*/
        setReferenceData(model);
        setPartnerData(firmId, model);

        partySite.getDefaultPointOfContact().populateAllCommunications();

        Address address = partySite.getAddress();

        if ((address != null) && (address.getCountryCode() != null)) {
        	List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
            model.addAttribute("statesSet", stateSet);
        }

        //Sagar: getting country related one FirmId 
        List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);
        model.addAttribute("countryCodeSet", countryCodeSet);
        PMUtil.showStatusMessage(request, model);
    }

    private void setPartnerData(Long firmId, ModelMap model) {
        List<Party> partnerList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
        model.addAttribute("partnerList", partnerList);
    }

    private void setReferenceData(ModelMap model) {
        //Map<CodeType, Set<Code>> codeTypeMap = codesManager.getApplicationLevelCodeMap();

        //		List<Code> countryCodeSet = codesManager.getCodesByCodeType(CodeType.COUNTRY_CODE_TYPE.getId());
        List<CommunicationType> communicationTypeSet = crmManager.getCommunicationTypes(true);
        List<CommunicationType> otherCommunicationTypeSet = crmManager.getCommunicationTypes(false);
//        List<PartySiteType> partySiteTypeCodeSet = crmManager.getPartySiteTypes();

        List industryCodeSet = codesManager.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
        List formOfBusinessTypeSet = codesManager.getCodesByCodeType(CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId());
        List titleCodeList = codesManager.getCodesByCodeType(CodeType.JOB_TITLE_CODE_TYPE.getId());
        List yesNoList = new ArrayList();
        KeyValue valueYes = new KeyValue("true", "Yes");
        KeyValue valueNo = new KeyValue("false", "No");
        yesNoList.add(valueYes);
        yesNoList.add(valueNo);
        //yesNoList.add(Boolean.FALSE);
//        model.addAttribute("partySiteTypeCodeSet", partySiteTypeCodeSet);
        //		model.addAttribute("countryCodeSet", countryCodeSet);
        model.addAttribute("phoneCommunicationTypeSet", communicationTypeSet);
        model.addAttribute("otherCommunicationTypeSet",
            otherCommunicationTypeSet);

        model.addAttribute("yesNoList", yesNoList);
        model.addAttribute("titleCodeList", titleCodeList);
        model.addAttribute("industryCodeSet", industryCodeSet);
        model.addAttribute("formOfBusinessCodeSet", formOfBusinessTypeSet);
        model.addAttribute("phoneCommunicationTypeSet",
            PMConstants.PHONE_TYPE_LIST);
    }

    /*private PartySiteCommunication getPartySiteCommunicationForType(int communicationType, PartySite site){
            return new PartySiteCommunication(crmManager.getCommunicationTypeById(communicationType), site);
    }*/
    private void saveParty(Party mainParty, Party relatedParty,
        PartyType relatedPartyType, OrganizationType relatedOrgType,
        RelationshipType relationshipType, PersonType personType) {
//        relatedParty.setCreateUserId("system");

        relatedParty.setPartyType(relatedPartyType);

        if (relatedOrgType != null) {
            Organization org = relatedParty.getOrganization();
            org.setOperatingName(org.getName());
            relatedParty.setName(org.getName());
            org.setOrganizationType(relatedOrgType);
            org.setParty(relatedParty);
        } else if (personType != null) {
            Person person = relatedParty.getPerson();
            relatedParty.setName(person.getFirstName() + " " +
                person.getLastName());
            person.setPersonType(personType);
            person.setParty(relatedParty);
            String emailId = relatedParty.getPartySites().get(0).getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
            if(emailId != null){
            person.setUserName(emailId);
            }
            PersonDetails details = person.getPersonDetails();
            details.setPerson(person);
        }

        crmManager.createPartyAndRelationship(mainParty, relatedParty,
            null, relationshipType, "", null, null);

        //crmManager.deletePartySiteCommunication(toBeDeletedList);
    }
}
