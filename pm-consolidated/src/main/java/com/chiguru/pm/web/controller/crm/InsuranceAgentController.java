package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import java.beans.PropertyEditorSupport;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;


/**
 * Handles requests for the application welcome page.
 */
@Controller
public class InsuranceAgentController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(InsuranceAgentController.class);
    @Autowired
    private CRMManager crmManager;
    @Autowired
    private CodesManager codesManager;

    public InsuranceAgentController() {
    }

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
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPartySiteById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        PartySite site = (PartySite) getValue();
                        String idString = (site.getId() != null)
                            ? site.getId().toString() : null;

                        return idString;
                    } else {
                        return null;
                    }
                }
            });
    }

    @ModelAttribute
    public PartyAccount initializeModel(Long id) {
        PartyAccount account;

        if (id == null) {
            account = new PartyAccount();

            PartySite site = new PartySite();
            //account.setPartySite(site);
            account.setAccountCategory(new Code(
                    PartyAccount.INSURANCE_ACCOUNT_TYPE));

            //			site.addPartySiteCommunication(new PartySiteCommunication());
        } else {
            account = crmManager.getAccountByIdAndAccountType(id,
                    PartyAccount.INSURANCE_ACCOUNT_TYPE);

            //List commList = new AutoPopulatingList(PartySiteCommunication.class);
            //commList
            //		.addAll(account.getPartySite().getPartySiteCommunications());
            //account.getPartySite().setPartySiteCommunications(commList);
        }

        return account;
    }

    private void setReferenceData(ModelMap model) {
        // Map<CodeType, Set<Code>> codeTypeMap =
        // codesManager.getApplicationLevelCodeMap();
        List industryCodeSet = codesManager.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
        List formOfBusinessTypeSet = codesManager.getCodesByCodeType(CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId());
        List<Code> countryCodeSet = codesManager.getCodesByCodeType(CodeType.COUNTRY_CODE_TYPE.getId());
        List<CommunicationType> communicationTypeSet = crmManager.getCommunicationTypes(true);
        List<CommunicationType> otherCommunicationTypeSet = crmManager.getCommunicationTypes(false);

        model.addAttribute("industryCodeSet", industryCodeSet);
        model.addAttribute("formOfBusinessCodeSet", formOfBusinessTypeSet);
        model.addAttribute("countryCodeSet", countryCodeSet);
        model.addAttribute("phoneCommunicationTypeSet", communicationTypeSet);
        model.addAttribute("otherCommunicationTypeSet",
            otherCommunicationTypeSet);
    }

    private void setPartnerData(Long firmId, ModelMap model) {
        List<Party> partnerList = crmManager.getRelatedPartiesById(firmId,
                RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
        model.addAttribute("partnerList", partnerList);
    }

    @RequestMapping(value = "/insuranceAgent.do", method = RequestMethod.POST)
    public String saveBank(HttpServletRequest request, ModelMap model,
        PartyAccount account, BindingResult result, SessionStatus status) {
        logger.info("SAVE INSURANCE AGENT");
        crmManager.savePartyAccount(account, null);

        return "redirect:/Chiguru/insuranceAgent.do?id=" + account.getId() +
        "&clientId=" + request.getParameter("clientId");
    }

    /*private void addNewCommunicationTypes(
                    List<PartySiteCommunication> communicationListDb,
                    List<PartySiteCommunication> communicationListUI) {
            List<PartySiteCommunication> newList = new ArrayList<PartySiteCommunication>();
            for (PartySiteCommunication uiCommunication : communicationListUI) {
                    boolean alreadyPresent = false;
                    System.out.println(" UI Type:"
                                    + uiCommunication.getCommunicationType().getName());
                    for (PartySiteCommunication dbCommunication : communicationListDb) {
                            System.out.println("** DB Type:"
                                            + dbCommunication.getCommunicationType().getName());
                            if (uiCommunication.getCommunicationType().equals(
                                            dbCommunication.getCommunicationType())) {
                                    alreadyPresent = true;
                            }
                    }
                    if (!alreadyPresent) {
                            newList.add(uiCommunication);
                    }
            }
    
            // add the newList to DB list
            communicationListDb.addAll(newList);
    }*/
    @RequestMapping(value = "/insuranceAgent.do", method = RequestMethod.GET)
    public void getInsuranceAgent(HttpServletRequest request, ModelMap model,
        PartyAccount account) {
        logger.info("Bank Module!");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        setReferenceData(model);

        Long clientId = Long.valueOf(request.getParameter("clientId"));
        Party client = crmManager.getPartyById(clientId);
        Long accountId = null;

        // PartySite site = account.getPartySite();
        Address address = account.getAddress();

        if ((address != null) && (address.getCountryCode() != null)) {
        	List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
            model.addAttribute("statesSet", stateSet);
        }

        model.addAttribute("account", account);

        //List<PartySiteCommunication> communicationSet = null;
        //account.getPartySite()
        //.null();
        // account.getPartySite().setPartySiteCommunications(communicationSet);

        //populatePartySiteCommunication(null, communicationSet);
        // partySiteCommunicationList.addAll(communicationSet);

        // model.addAttribute("partyCommunicationSet", partyCommunicationSet);
        //System.out.println("partySiteCommunicationList ="
        //		+ model.get("partySiteCommunicationList"));
        // model.addAttribute("partySiteCommunicationList",
        // partySiteCommunicationList);
    }

    @RequestMapping(value = "/getAddressStates.do", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, List<KeyValue>> getStates(Long countryId) {
        Map<String, List<KeyValue>> retMap = new HashMap();

        List<KeyValue> keyValueList = new ArrayList();

        for (Code state : getStatesSet(countryId)) {
            KeyValue keyValue = new KeyValue();
            keyValue.setKey(state.getId().toString());
            keyValue.setValue(state.getShortName());
            keyValueList.add(keyValue);
        }

        retMap.put("states", keyValueList);

        return retMap;

        // return "sairam";
    }

    private Set<Code> getStatesSet(Long countryId) {
        Code countryCode = codesManager.getCodeById(countryId);
        Set<Code> stateCodeSet = countryCode.getCodes();

        return stateCodeSet;
    }

    /*private void populatePartySiteCommunication(PartySite site,
                    List<PartySiteCommunication> commList) {
            boolean emailFlag = false;
            boolean faxFlag = false;
            boolean webFlag = false;
            boolean phoneFlag = false;
            for (PartySiteCommunication comm : commList) {
                    CommunicationType commType = comm.getCommunicationType();
                    if (commType != null) {
    
                            if (commType.getId().equals(
                                            CommunicationType.EMAIL_COMMUNICATION_TYPE)) {
                                    emailFlag = true;
                            } else if (comm.getCommunicationType().getId().equals(
                                            CommunicationType.FAX_COMMUNICATION_TYPE)) {
                                    faxFlag = true;
                            } else if (comm.getCommunicationType().getId().equals(
                                            CommunicationType.WEB_COMMUNICATION_TYPE)) {
                                    webFlag = true;
                            } else if (comm.getCommunicationType().getId().equals(
                                            CommunicationType.PHONE_COMMUNICATION_TYPE)) {
                                    phoneFlag = true;
                            }
                    }
            }
    
            if (!emailFlag) {
                    site.addPartySiteCommunication(getPartySiteCommunicationForType(
                                    CommunicationType.EMAIL_COMMUNICATION_TYPE, site));
            }
            if (!faxFlag) {
                    site.addPartySiteCommunication(getPartySiteCommunicationForType(
                                    CommunicationType.FAX_COMMUNICATION_TYPE, site));
            }
            if (!webFlag) {
                    site.addPartySiteCommunication(getPartySiteCommunicationForType(
                                    CommunicationType.WEB_COMMUNICATION_TYPE, site));
            }
            if (!phoneFlag) {
                    site.addPartySiteCommunication(getPartySiteCommunicationForType(
                                    CommunicationType.PHONE_COMMUNICATION_TYPE, site));
            }
    }*/

    /*private PartySiteCommunication getPartySiteCommunicationForType(
                    int communicationType, PartySite site) {
            return new PartySiteCommunication(crmManager
                            .getCommunicationTypeById(communicationType), site);
    }*/
}
