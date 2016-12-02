package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.web.servlet.CacheManagerServlet;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;


@Controller
public class OrganizationController extends BaseController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(OrganizationController.class);

    @ModelAttribute("organization")
    public Organization initializeModel(Long id, Long clientId, Integer relationType,
                                        HttpServletRequest request) {
        //	org.springframework.security.core.context.SecurityContext context = org.springframework.security.core.context.SecurityContextHolder.getContext();
        //	PMUser user = (PMUser)context.getAuthentication().getPrincipal();
        //PartyRelationship relashiship = crmManager.getPartyRelationshipById(user.getPartyRelationshipId());
        //Party firm = relashiship.getPartyByObject();
        Long firmId = PMUtil.getFirmIdFromSession(request);
        String loggedInUser = BaseController.getUserProfileEmailId();

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        //removed relationType=1 from Link in clientList.jsp
        String servletPath = request.getServletPath();

        if (servletPath.equals("/client/clientDetail.do") || servletPath.equals("/mobileclient/mobileManageClient.do") || servletPath.equals("/mobileclient/mobileClientDetail.do")) {
            id = clientId;
        }
        if (servletPath.equals("/client/newEditclientDetail.do")) {
            id = clientId;
        }
        if (RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId()
                .equals(relationType)) {
            id = clientId;
        }

        Organization organization;

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);

        if ((id != null) && (session.getAttribute("inValidClientId") == null)) {
            organization = crmManager.getOrganizationById(id);
            String clientName = organization.getOperatingName();
            if(clientName == null || clientName == ""){
            	clientName = organization.getName();
            }
            session.setAttribute("clientName", clientName);
            //PartySite site = party.getDefaultPartySite();
        } else {
            organization = new Organization();
            Party party = new Party();
            organization.setParty(party);

            PartySite site = party.getDefaultPartySite();
            site.setCreateUserId(loggedInUser);

            PointOfContact contact = site.getDefaultPointOfContact();
            contact.setCreateUserId(loggedInUser);

        }
        return organization;
    }


    @RequestMapping(value = {"/client/clientDetail.do","/mobileclient/mobileClientDetail.do"}, method = RequestMethod.POST)
    public ResponseEntity<String> saveClient(HttpServletRequest request, Organization clientOrganization,
                                             SessionStatus status, ModelMap model,
                                             Long clientId) {
        logger.info("Client Module Save!");
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setContentType(MediaType.TEXT_HTML);
        StringBuffer responseText = new StringBuffer("{\"clientId\":");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        String loggedInUser = BaseController.getUserProfileEmailId();
        Party firmParty = crmManager.getPartyById(firmId);

        PartyType clientPartyType = PMUtil.getPartyOrganizationType(crmManager);
        OrganizationType clientOrgType = PMUtil.getClientOrganizationType(crmManager);
        RelationshipType clientRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(),
                crmManager);

        try {
            saveOrganization(firmParty, clientOrganization, clientPartyType, clientOrgType,
                    clientRelationType, loggedInUser);
            responseText.append("\"" + clientOrganization.getId() + "\"}");
            logger.info("ClientDetail  SAVED ****** " + clientOrganization.getId());

        } catch (Exception e) {
            logger.error("Exception occurred during client detail Save " + clientOrganization.getName() +e.getMessage());
            responseText.append("\"-1\"}");

        }
        return new ResponseEntity<String>(responseText.toString(), responseHeaders, HttpStatus.OK);
    }

    //Added By Savitri


    private PartyRelationship saveOrganization(Party mainParty, Organization relatedOrganization,
                                               PartyType relatedPartyType, OrganizationType relatedOrgType,
                                               RelationshipType relationshipType, String loggedInUser) {
        Party relatedParty = relatedOrganization.getParty();
        if (relatedOrganization.getId() == null) {
            relatedParty.setCreateUserId(loggedInUser);
            relatedOrganization.setOrganizationType(relatedOrgType);
            relatedOrganization.setParty(relatedParty);
            relatedParty.setOrganization(relatedOrganization);
            relatedParty.setPartyType(relatedPartyType);
        } else {
            relatedParty.setLastUpdateUserId(loggedInUser);
        }
        relatedOrganization.setName(relatedOrganization.getOperatingName());
        relatedParty.setName(relatedOrganization.getName());

        PartySite partySite = relatedParty.getDefaultPartySite();

        if (partySite.getAddress().getCountryCode() == -1) {
            partySite.getAddress().setCountryCode(null);
            partySite.getAddress().setStateCode(null);
        }
        if (partySite.getId() == null) {
            partySite.setPartySiteType(crmManager.getPartySiteTypeById(
                    PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));
            partySite.setCreateUserId(loggedInUser);
        }

        PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
                relatedParty, loggedInUser, relationshipType, "", null, null);

        return rel;
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/client/clientDetail.do", method = RequestMethod.GET)
    public String getClient(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("organization")Organization clientOrganization, Long clientId) {
        logger.info("Client Module!");
        Party clientParty = clientOrganization.getParty();
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        if ((clientId != null) && (session.getAttribute("inValidClientId") == null)) {
            session.setAttribute("clientPartyName", clientParty.getName());
            Long firmPracticeId = taxModuleManager.getDefaultFirmPracticeIdByFirmId(firmId);
            session.setAttribute("firmPracticeId", firmPracticeId);
        } else {
            session.setAttribute("clientPartyName", "");
        }

        /*Party clientParty = crmManager.getPartyById(clientId);
        model.addAttribute("clientPartyName", clientParty.getName());*/
        setDataForUI(request, model, clientParty);

        return "clientDetail.tilesView";
    }
    
   @RequestMapping(value = {"/client/newEditclientDetail.do","/mobileclient/mobileClientDetail.do"}, method = RequestMethod.GET)
    public String getClientNewDetail(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("organization")Organization clientOrganization, Long clientId) {
        logger.info("Client Module!");
        Party clientParty = clientOrganization.getParty();
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        if ((clientId != null) && (session.getAttribute("inValidClientId") == null)) {
            session.setAttribute("clientPartyName", clientParty.getName());
            Long firmPracticeId = taxModuleManager.getDefaultFirmPracticeIdByFirmId(firmId);
            session.setAttribute("firmPracticeId", firmPracticeId);
        } else  {
            session.setAttribute("clientPartyName", "");
        }

       /* Party clientParty = crmManager.getPartyById(clientId);
        model.addAttribute("clientPartyName", clientParty.getName());*/
        setDataForUI(request, model, clientParty);

        String servletPath = request.getServletPath();

        if (servletPath.equals("/client/newEditclientDetail.do")) {
        	 return "clientDetailNew.tilesView";
        }else{
        	return "mobileClientDetail.tilesView";
        }
       
    }

    @RequestMapping(value = "/mobileclient/mobileManageClient.do", method = RequestMethod.GET)
    public String getClientManage(HttpServletRequest request, ModelMap model,
    		@ModelAttribute("organization")Organization clientOrganization, Long clientId) {
        logger.info("Client Module!");
        Party clientParty = clientOrganization.getParty();
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        if ((clientId != null) && (session.getAttribute("inValidClientId") == null)) {
            session.setAttribute("clientPartyName", clientParty.getName());
            Long firmPracticeId = taxModuleManager.getDefaultFirmPracticeIdByFirmId(firmId);
            session.setAttribute("firmPracticeId", firmPracticeId);
        } else  {
            session.setAttribute("clientPartyName", "");
        }
        	return "mobileTest.tilesView";
       
    }
    
    private void setDataForUI(HttpServletRequest request, ModelMap model,
                              Party party) {
        Long firmId = PMUtil.getFirmIdFromSession(request);
        model.addAttribute("party", party);
        setReferenceData(model, firmId);

        List<KeyValue> partnerList = PMUtil.getCachedDropdownPartyList(firmId, RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),
                crmManager);

        model.addAttribute("partnerList", partnerList);
        //setPartnerData(firmId, model);

        // setStaffData(firmId, model);

          /*party.getDefaultPartySite().getDefaultPointOfContact()
             .populateAllCommunications();*/

        Address address = party.getDefaultPartySite().getAddress();

        if ((address != null) && (address.getCountryCode() != null)) {
            List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
            model.addAttribute("statesSet", stateSet);
        }
        List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);
       
        
        
       /* TODO need to check the below
        * List<PartyCode> partyCodeSet = codesManager.getPartyCodeByFirmId(CodeType.COUNTRY_CODE_TYPE.getId(),
                firmId);

        for (PartyCode partyCode : partyCodeSet) {
            countryCodeSet.add(partyCode.getCode());
        }
*/
        model.addAttribute("countryCodeSet", countryCodeSet);

        PMUtil.showStatusMessage(request, model);
    }

    private void setReferenceData(ModelMap model, Long firmId) {
        //List industryCodeSet = codesManager.getCodesByCodeType(CodeType.INDUSTRY_CODE_TYPE.getId());
        List industryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.INDUSTRY_CODE_TYPE.getId(), codesManager, null);

        List typeOfBusinessSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.FORM_OF_BUSINESS_CODE_TYPE.getId(), codesManager, null);

        Set yesNoSet = CacheManagerServlet.getYesNoSet();
        model.addAttribute("yesNoList", yesNoSet);
        //model.addAttribute("titleCodeList", titleCodeList);
        model.addAttribute("industryCodeSet", industryCodeSet);
        model.addAttribute("formOfBusinessCodeSet", typeOfBusinessSet);
        //  model.addAttribute("phoneCommunicationTypeSet",
        //     PMConstants.PHONE_TYPE_LIST);
    }

    @RequestMapping(value = "/client/colorClientDetail.do", method = RequestMethod.GET)
    public String getClientColor(HttpServletRequest request, ModelMap model,
                                 Organization clientOrganization, Long clientId) {
        logger.info("Client Module!");
        Party clientParty = clientOrganization.getParty();
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession(false);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        if ((clientId != null) &&
                (session.getAttribute("inValidClientId") == null)) {

            session.setAttribute("clientPartyName", clientParty.getName());
            Long firmPracticeId = taxModuleManager.getDefaultFirmPracticeIdByFirmId(firmId);
            session.setAttribute("firmPracticeId", firmPracticeId);
        } else {
            session.setAttribute("clientPartyName", "");
        }

//        Party clientParty = crmManager.getPartyById(clientId);
//        model.addAttribute("clientPartyName", clientParty.getName());
        setDataForUI(request, model, clientParty);

        return "clientDetailColor.tilesView";
    }
}