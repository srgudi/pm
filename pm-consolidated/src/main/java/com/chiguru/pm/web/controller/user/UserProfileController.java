package com.chiguru.pm.web.controller.user;
import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonDetails;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.security.PMUserService;
import com.chiguru.pm.web.util.PMUtil;
import com.chiguru.pm.web.util.EncryptionUtil;

@Controller
public class UserProfileController {

	private Logger logger = org.slf4j.LoggerFactory
			.getLogger(UserProfileController.class);
	@Autowired
	private CRMManager crmManager;
	@Autowired
    private CodesManager codesManager;
	@Autowired
    private PMUserService userService;
		
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Long.class, "myLong",
            new CustomNumberEditor(Long.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
                }
            });

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
                        setValue(null);
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

        binder.registerCustomEditor(RelationshipType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getRelationshipTypeById(
                                Integer.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        RelationshipType type = (RelationshipType) getValue();

                        return type.getId().toString();
                    } else {
                        return null;
                    }
                }
            });
        binder.registerCustomEditor(OrganizationType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(PMUtil.getOrganizationTypeById(Integer.valueOf(
                                    text), crmManager));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        OrganizationType type = (OrganizationType) getValue();

                        return type.getId().toString();
                    } else {
                        return null;
                    }
                }
            });
        binder.registerCustomEditor(PartyType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(PMUtil.getPartyTypeById(Integer.valueOf(text),
                                crmManager));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        PartyType type = (PartyType) getValue();

                        return type.getId().toString();
                    } else {
                        return null;
                    }
                }
            });
        binder.registerCustomEditor(Person.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPersonById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Person person = (Person) getValue();

                        if ((person != null) && (person.getId() != null)) {
                            retValue = person.getId().toString();
                        }
                    }

                    return retValue;
                }
            });

        binder.registerCustomEditor(PersonType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(PMUtil.getPersonTypeById(Integer.valueOf(text),
                                crmManager));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        PersonType personType = (PersonType) getValue();

                        if ((personType != null) &&
                                (personType.getId() != null)) {
                            retValue = personType.getId().toString();
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
                    if (getValue() != null) {
                        Party party = (Party) getValue();

                        return party.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(PartyCode.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getPartyCodeById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        PartyCode partyCode = (PartyCode) getValue();

                        return partyCode.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(CodeType.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getCodeTypeById(Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        CodeType codeType = (CodeType) getValue();

                        return codeType.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(Code.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getCodeById(Long.valueOf(text)));
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

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }
	 @ModelAttribute
	    public List<PhoneCommunication> initializeModelForDeletes(Party party,
	        HttpServletRequest request) {
	        List<PhoneCommunication> phonesToBeDeletedList = new ArrayList();

	        if (request.getMethod().equals("POST")) {
	            List<PhoneCommunication> origPhoneList = party.getDefaultPartySite()
	                                                          .getDefaultPointOfContact()
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

	@ModelAttribute("party")
	public Party initializeModel(Long id, Long clientId, Integer relationType,
			HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
		
		Party party = crmManager.getPartyById(userProfile.getId());
		return party;
	}

	@RequestMapping(value = {"/user/userProfile.do","/mobileuser/userProfileMobile.do"}, method = RequestMethod.GET)
	public String userProfile(HttpServletRequest request, ModelMap model,
			@ModelAttribute("party")Party party, Long clientId, String clientPartyName) {
				
		logger.info("user profile select");
		Long firmId = PMUtil.getFirmIdFromSession(request);
		setReferenceData(party,model, firmId);
		model.addAttribute("party", party);
		PMUtil.showStatusMessage(request, model);
		if(request.getRequestURI().contains("/user/userProfile.do")){
		    return "userProfile.tilesView";
		}else{
			return "userProfileMobile.tilesView";
		}
	}
	
	 private void setReferenceData(Party party, ModelMap model, Long firmId) {
	        
	        List<CommunicationType> communicationTypeSet = crmManager.getCommunicationTypes(true);
	        model.addAttribute("phoneCommunicationTypeSet", communicationTypeSet);
	        model.addAttribute("phoneCommunicationTypeSet",
	            PMConstants.PHONE_TYPE_LIST);
	        
	        Address address = party.getDefaultPartySite().getAddress();
	        if ((address != null) && (address.getCountryCode() != null)) {
	        	List stateSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.STATE_CODE_TYPE.getId(), codesManager, address.getCountryCode());
	            model.addAttribute("statesSet", stateSet);
	        }
	        
	        List countryCodeSet = PMUtil.getCachedDropdownCodesList(firmId, CodeType.COUNTRY_CODE_TYPE.getId(), codesManager, null);
	        model.addAttribute("countryCodeSet", countryCodeSet);
	    }
	 
	 @RequestMapping(value = {"/user/userProfile.do","/mobileuser/userProfileMobile.do"}, method = RequestMethod.POST)
	       public String saveUserProfile(HttpServletRequest request, 
	    	        Party staffParty, ModelMap model, SessionStatus status,
	    	        List<PhoneCommunication> phonesToBeRemoved ,@ModelAttribute Party party) {
        logger.info("User Profile Save!");
       
        String role = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);
        BindingResult result = (BindingResult) model.get("org.springframework.validation.BindingResult.party");
        PartyType staffPartyType = PMUtil.getPartyTypeById(PartyType.PARTY_TYPE_PERSON.getId(),
                crmManager);

        RelationshipType employeeRelationType = new RelationshipType();

        if (PersonType.PERSON_TYPE_STAFF.equals(staffParty.getPerson()
                                                                 .getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(),
                    crmManager);
            role = "ROLE_STAFF";
        } else if (PersonType.PERSON_TYPE_PARTNER.equals(
        		staffParty.getPerson().getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(),
                    crmManager);
            role = "ROLE_FIRM_PARTNER";
        } else if (PersonType.PERSON_TYPE_FIRM_ADMIN.equals(
        		staffParty.getPerson().getPersonType())) {
            employeeRelationType = PMUtil.getRelationshipTypeById(RelationshipType.RELATIONSHIP_TYPE_LAW_ADMIN.getId(),
                    crmManager);
            role = "ROLE_FIRM_ADMIN";
        }

        PartySiteType partySiteType = crmManager.getPartySiteTypeById(PartySiteType.HOME_PARTY_SITE_TYPE);
       
        staffParty.getDefaultPartySite().setPartySiteType(partySiteType);
        Party firmParty = crmManager.getPartyById(firmId);
        
        PartyRelationship relationship = saveParty(firmParty, staffParty, staffPartyType, null,
        		employeeRelationType, staffParty.getPerson().getPersonType(), phonesToBeRemoved,request,party);
        
        String userName = staffParty.getPerson().getUserName();
        /*String password = EncryptionUtil.getInstance().encrypt(staffParty.getPassword()); */  
        
        /*BasicPasswordEncryptor passwordEncryptor = new BasicPasswordEncryptor();
        String password = passwordEncryptor.encryptPassword(staffParty.getPassword());*/
        
//        String password = staffParty.getPassword();   // without encryption
        
        /*String oldPassword = userService.getPassword(userName);*/
        
        /*userService.changePassword(oldPassword,password);*/
        String baseURL = request.getParameter("baseURL");
        String returnURL = baseURL + "?id=" + staffParty.getId() +
           "&saveSuccess=true";

        return "redirect:" + returnURL;
    }

	 
	 private PartyRelationship saveParty(Party mainParty, Party relatedParty,
		        PartyType relatedPartyType, OrganizationType relatedOrgType,
		        RelationshipType relationshipType, PersonType personType,
		        List<PhoneCommunication> phonesToBeRemoved,HttpServletRequest request,@ModelAttribute Party party) {
//		        relatedParty.setCreateUserId("system");

		        relatedParty.setPartyType(relatedPartyType);

		        if (relatedOrgType != null) {
		            Organization org = relatedParty.getOrganization();
		            org.setName(org.getOperatingName());
		            relatedParty.setName(org.getName());
		            org.setOrganizationType(relatedOrgType);
		            org.setParty(relatedParty);

		            if (relatedParty.getPartySites() == null) {
		                PartySite partySite = relatedParty.getPartySites().get(0);
		                partySite.setPartySiteType(crmManager.getPartySiteTypeById(
		                        PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));
		            } else {
		                PartySite partySite = relatedParty.getPartySites().get(0);

		                if (partySite.getId() == null) {
		                    partySite.setPartySiteType(crmManager.getPartySiteTypeById(
		                            PartySiteType.MAIN_OFFICE_PARTY_SITE_TYPE));
		                }
		            }
		        } else if (personType != null) {
		            Person person = relatedParty.getPerson();
		            relatedParty.setName(person.getFirstName() + " " +
		                person.getLastName());
		            person.setPersonType(personType);
		            person.setParty(relatedParty);

		            PersonDetails details = person.getPersonDetails();
		            PartySite newpartysite = relatedParty.getPartySites().get(0);
		            String emailId = null;
		            if(newpartysite != null){
		            	List<PointOfContact> pocList = newpartysite.getPointOfContactList();
		            	if(!pocList.isEmpty()){
		            		List<EmailCommunication> emailList = pocList.get(0).getEmailList();
		            		if(!emailList.isEmpty()){
		            			emailId = emailList.get(0).getContactDetail();
		            		}
		            	}
		            }
		           // emailId = newpartysite.getPointOfContactList().get(0).getEmailList().get(0).getContactDetail();
		            if(emailId != null){
		            person.setUserName(emailId);
		            }
		            if(details != null){
		            details.setPerson(person);
		            }
		            PartySite partySite = relatedParty.getPartySites().get(0);
		            partySite.setContactName(person.getFirstName());
		            partySite.setContactTitle(person.getLastName());
		            partySite.setName(person.getFirstName() + " " +
		                person.getLastName());

		            Address address = partySite.getAddress();
		            Set<PartySite> partySites = new HashSet<PartySite>();
		            partySites.add(partySite);
		            address.setPartySite(partySite);
		            partySite.setParty(relatedParty);
		            
		            HttpServletRequest httpReq = (HttpServletRequest) request;
		            HttpSession session = httpReq.getSession();
		    		if (session != null) {
		                if (session.getAttribute("inValidClientId") != null) {
		                    session.removeAttribute("inValidClientId");
		                }

		               /* String theme = request.getParameter("themeValue");

		                    session.setAttribute("theme", theme );
		                    crmManager.userThemeSave(theme);
		                */
		            }

		            List<PartySite> list = new ArrayList<PartySite>();
		            list.add(partySite);
		            relatedParty.setPartySites(list);
		        }

		        if (relatedParty != null) {
		            List<PointOfContact> listOfPointOfContact = relatedParty.getDefaultPartySite()
		                                                                    .getPointOfContactList();

		            for (PointOfContact pointOfContact : listOfPointOfContact) {
//		                pointOfContact.setCreateUserId("system");
		                pointOfContact.setLastUpdateDate(new Date());
//		                pointOfContact.setLastUpdateUserId("system");
		                pointOfContact.setActiveFlag(true);
		                setPointOfContact(pointOfContact);
		            }
		        }

		        PartyRelationship rel = crmManager.createPartyAndRelationship(mainParty,
		                relatedParty, null, relationshipType, "", null, null);
		        crmManager.deletePhoneCommunication(phonesToBeRemoved);

		        return rel;
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
//	            communication.setCreateUserId("system");
	            communication.setLastUpdateDate(new Date());
//	            communication.setLastUpdateUserId("system");
	            communication.setActiveFlag(true);
	            communication.setPointOfContact(poc);
	        }
	    }
	  
	}
