package com.chiguru.pm.web.controller.crm;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.core.common.utilities.EmailService;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Communication;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.security.PMUserService;
import com.chiguru.pm.tax.dao.TaskModuleDao;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;

public class BaseController {

    @Autowired
    protected CRMManager crmManager;
    @Autowired
    protected CodesManager codesManager;
    @Autowired
    protected PMUserService userService;
    @Autowired
    protected TaxModuleManager taxModuleManager;
    @Autowired
    protected EmailService emailService;
    @Autowired
    protected TaskModuleDao taskModuleDao;
   
    
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
        
        binder.registerCustomEditor(Organization.class,
                new PropertyEditorSupport() {
                    @Override
                    public void setAsText(String text)
                        throws IllegalArgumentException {
                        if ("null".equals(text) || "-1".equals(text)) {
                            setValue(null);
                        } else {
                            setValue(crmManager.getOrganizationById(Long.valueOf(
                                        text)));
                        }
                    }

                    public String getAsText() {
                        if (getValue() != null) {
                        	Organization org = (Organization) getValue();

                            return org.getId().toString();
                        } else {
                            return null;
                        }
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
        
        binder.registerCustomEditor(PMUser.class,
                new PropertyEditorSupport() {
                    @Override
                    public void setAsText(String text)
                        throws IllegalArgumentException {
                        if ("null".equals(text) || "-1".equals(text)) {
                            setValue(null);
                        } else {
                        	PMUser pmuser = (PMUser) getValue();
                            setValue(pmuser.getPartyRelationshipId().toString());
                        }
                    }

                    public String getAsText() {
                        if (getValue() != null) {
                        	PMUser pmuser = (PMUser) getValue();
                        	return pmuser.getPartyRelationshipId().toString();
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

    protected List removeDeletedEntries(
			List toBeDeletedList,
			List listFromDB,
			String paramName,
			HttpServletRequest request) {
		Map paraMap = request.getParameterMap();
		Set keySet = paraMap.keySet();
		for (Iterator itComm = listFromDB.iterator(); itComm.hasNext();) {
			PersistentEntity obj = (PersistentEntity)itComm.next();
			if (obj != null) {
				boolean exists = false;

				for (Iterator it = keySet.iterator(); it.hasNext();) {
					String key = (String) it.next();
					if (key.contains(paramName)
							&& key.contains("id")) {
						String value = request.getParameter(key);
						if (obj.getId() != null
								&& obj.getId().toString().equals(value)) {
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

    protected void setPointOfContact(PointOfContact poc) {
        setPointOfContact(poc, poc.getEmailList());
        setPointOfContact(poc, poc.getFaxList());
        setPointOfContact(poc, poc.getPhoneList());
        setPointOfContact(poc, poc.getWebUrlList());
    }

    protected void setPointOfContact(PointOfContact poc, List commList) {
        for (Iterator it = commList.iterator(); it.hasNext();) {
            Communication communication = (Communication) it.next();
            communication.setCreateUserId(getUserProfileEmailId());

            communication.setLastUpdateDate(new Date());
            communication.setLastUpdateUserId(getUserProfileEmailId());
            communication.setActiveFlag(true);
            communication.setPointOfContact(poc);
        }
    }

	public static String getUserProfileEmailId(){
		String emailId = null;
		SecurityContext context = SecurityContextHolder.getContext();
 		PMUser loggedInUser = null;
 		
 		if(context.getAuthentication() == null){
 			emailId = "SYSTEM";
 		}else{
 			emailId = ((PMUser) context.getAuthentication().getPrincipal()).getUsername();
 		}
		return emailId;
	}
}
