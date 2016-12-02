package com.chiguru.pm.web.security;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyAccount;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PartyRelationShipDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.security.PmRolesEnum;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.service.TaxModuleManager;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.util.StringUtils;

import java.io.IOException;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * @author ORANGUTAN
 * @since 02.02.2011
 */
public class SecurityDelegatingFilterProxy implements Filter {
    // define bean dependencies here!
    @Autowired
    CRMManager crmManager;
    @Autowired
    TaxModuleManager taxManager;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        SecurityContext context = SecurityContextHolder.getContext();

        PMUser loggedInUser = null;
        String userRole = null;
        
        if(context.getAuthentication()!= null && context.getAuthentication().getPrincipal() instanceof PMUser){
        	loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
        }

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession();

        if (session != null) {
            if (session.getAttribute("inValidClientId") != null) {
                session.removeAttribute("inValidClientId");
            }

            /**
             * SET DEFAULT THEME HERE
             *
             */
           String theme = (String) session.getAttribute("theme");
            
            
            
            /*if(loggedInUser != null){
            	String name = loggedInUser.getUsername();
               theme = crmManager.userGetTheme(name);
            }*/
            if (!StringUtils.hasText(theme)) {
                session.setAttribute("theme", "cupertino");
            }
            
            // --- END THEME SET
        }

        if (context.getAuthentication()!= null && context.getAuthentication().getPrincipal() instanceof PMUser) {
        	Collection<? extends GrantedAuthority> grantedAuth = context.getAuthentication()
                    .getAuthorities();
            Iterator<? extends GrantedAuthority> iterator = grantedAuth.iterator();

            for (GrantedAuthority grantedAuthority : grantedAuth) {
                if (grantedAuthority.getAuthority()
                        .equalsIgnoreCase(PmRolesEnum.ROLE_APP_ADMIN.toString())) {
                    userRole = grantedAuthority.getAuthority();

                    break;
                }

                userRole = grantedAuthority.getAuthority();
            }
        }

        if (userRole != null) {
            if (!userRole.equalsIgnoreCase(
                    PmRolesEnum.ROLE_APP_ADMIN.toString())) {
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientDetail.do")) {
                    String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/mobileclient/mobileClientDetail.do")) {
                    String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientStaff.do")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/mobileclient/mobileclientStaff.do ")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientLocation.do")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/mobileclient/mobileclientLocation.do")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientOfficersAndShareHolders.do")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/mobileclient/mobileClientOfficersAndShareHolders.do")) {
                	String clientId = httpReq.getParameter("clientId");
                	getPermissonForUserToViewClientPage(clientId, httpReq, session);
                }
                
                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientBank.do")) {
                    Long accountCategoryId = PartyAccount.BANK_ACCOUNT_TYPE;
                    getCommonDetailsFromPartyAccount(httpReq, session, accountCategoryId);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientLawyer.do")) {
                    Long accountCategoryId = PartyAccount.LAWYER_ACCOUNT_TYPE;
                    getCommonDetailsFromPartyAccount(httpReq, session, accountCategoryId);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientInsurance.do")) {
                    Long accountCategoryId = PartyAccount.INSURANCE_ACCOUNT_TYPE;
                    getCommonDetailsFromPartyAccount(httpReq, session, accountCategoryId);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/client/clientTransferAgent.do")) {
                    Long accountCategoryId = PartyAccount.TRANSFER_AGENT_ACCOUNT_TYPE;
                    getCommonDetailsFromPartyAccount(httpReq, session, accountCategoryId);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/firmadmin/manageFirmStaff.do")) {
                	 getPermissonForUserToViewFirmAdminPage(userRole, session);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/firmadmin/manageTaxModule.do")) {
                	getPermissonForUserToViewFirmAdminPage(userRole, session);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/firmadmin/managePartyCode.do")) {
                	getPermissonForUserToViewFirmAdminPage(userRole, session);
                }

                if (httpReq.getServletPath()
                        .equalsIgnoreCase("/task/taskModule.do")) {
                    if (!isTheHttpFieldBlank(httpReq, "taskId")) {
                        Long id = Long.valueOf(httpReq.getParameter("taskId"));
                        List<Party> party = taxManager.getPartyByTaskId(id);

                        if (party.size() > 0) {
                            Party clientParty = party.get(0);
                            List<Party> partyRel = crmManager.getPartyRelationshipbySubId(clientParty.getId());

                            Party clientPartyRel = partyRel.get(0);
                            PartyDTO partyByObj = (PartyDTO) session.getAttribute(
                                    "firm");

                            if (!clientPartyRel.getId()
                                    .equals(partyByObj.getId())) {
                                String notificationMsg = "The Client Id " +
                                        clientPartyRel.getId() +
                                        " is not belongs to this Firm";

                                session.setAttribute("inValidClientId",
                                        notificationMsg);
                                httpReq.getRequestDispatcher(
                                        "/task/taskList.do")
                                        .forward(request, response);
                            }
                        } else {
                            String notificationMsg = "The Task is not belongs to this Firm";

                            session.setAttribute("inValidClientId",
                                    notificationMsg);
                            httpReq.getRequestDispatcher("/task/taskList.do")
                                    .forward(request, response);
                        }
                    }
                }
            } else {
            }
        }

        if ((loggedInUser != null) && (session != null) &&
                (session.getAttribute("firm") == null)) {
            // PartyRelationship relashiship =
            // crmManager.getPartyRelationshipById(loggedInUser.getPartyRelationshipId());
            // Party party = relashiship.getPartyByObject();
            // PartyDTO firm = Util.getFirmDTO(party);

            /*
             * PartyDTO firm = crmManager
             * .getFirmPartyDTOForRelationshipById(loggedInUser
             * .getPartyRelationshipId()); session.setAttribute("firm", firm);
             */
        	String theme = (String) session.getAttribute("theme");
        	String name = loggedInUser.getUsername();
            if(name != null){
            
              //theme = crmManager.userGetTheme(name);
              session.setAttribute("theme", theme);
            }
            
            /*if (!StringUtils.hasText(theme)) {
                session.setAttribute("theme", "south-street");
            }*/
            
            PartyRelationShipDTO relDTO = crmManager.getFirmPartyDTOForRelationshipById(loggedInUser.getPartyRelationshipId());

            session.setAttribute("firm", relDTO.getPartyByObject());
            session.setAttribute("userProfile", relDTO.getPartyBySubject());
        }

        chain.doFilter(request, response);
    }

    private void getPermissonForUserToViewClientPage(String clientId, HttpServletRequest httpReq, HttpSession session) {
    	if (StringUtils.hasText(clientId)) {
            Long id = Long.valueOf(httpReq.getParameter("clientId"));
            Long relatedFirmId = crmManager.getRelatedPartyId(id, RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId());

                PartyDTO partyByObj = (PartyDTO) session.getAttribute(
                        "firm");

                if (!partyByObj.getId().equals(relatedFirmId)) {
                    String notificationMsg = "The Client Id " + id +
                            " does not belongs to this Firm";
                    session.setAttribute("inValidClientId",
                            notificationMsg);
                }
       }
	}
    
    private void getPermissonForUserToViewFirmAdminPage(String userRole, HttpSession session) {
    	if (!userRole.equalsIgnoreCase(PmRolesEnum.ROLE_FIRM_ADMIN.toString())){
         	String notificationMsg = "This page is not available";
            session.setAttribute("inValidClientId",
                     notificationMsg);
         }
	}

	private void getCommonDetailsFromPartyAccount(HttpServletRequest httpReq, HttpSession session,Long accountCategoryId) {
    	String clientId = httpReq.getParameter("clientId");
    	if (StringUtils.hasText(clientId)) {
            Long id = Long.valueOf(httpReq.getParameter("clientId"));
            Long relatedClientId = crmManager.getRelatedClientId(id,accountCategoryId);
            Long relatedFirmId = null;
            if(relatedClientId != null){
            	relatedFirmId = crmManager.getRelatedPartyId(relatedClientId, RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId());
            }else{
            	relatedFirmId = crmManager.getRelatedPartyId(id, RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId());
            }
            
            PartyDTO partyByObj = (PartyDTO) session.getAttribute("firm");
                if (!partyByObj.getId().equals(relatedFirmId)) {
                    String notificationMsg = "The Client Id " + id +
                            " does not belongs to this Firm";
                    session.setAttribute("inValidClientId",
                            notificationMsg);
                }
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        /** Init logic goes here,one time parameter initialization */
    }

    @Override
    public void destroy() {
    }

    public boolean isTheHttpFieldBlank(HttpServletRequest httpReq, String field) {
        String fieldValue = httpReq.getParameter(field);
        return isTheStringBlank(fieldValue);
    }

    public boolean isTheStringBlank(String value) {
        return (value == null || value.trim().isEmpty());
    }
}
