package com.chiguru.pm.web.controller.tax;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Jurisdiction;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.CodesManager;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.FilingDueDateRule;
import com.chiguru.pm.tax.domain.FilingReminderRule;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.InstallmentDueDateRule;
import com.chiguru.pm.tax.domain.InstallmentReminderRule;
import com.chiguru.pm.tax.domain.ReminderRule;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.beans.PropertyEditorSupport;

import java.lang.reflect.Method;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;


@Controller
public class TaxModuleController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(TaxModuleController.class);
    @Autowired
    private CRMManager crmManager;
    @Autowired
    private CodesManager codesManager;
    @Autowired
    private TaxModuleManager taxModuleManager;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Long.class, "myLong",
            new CustomNumberEditor(Long.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
                }
            });
        binder.registerCustomEditor(List.class, "filingDueDateRules",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    String[] dueDate = (String[]) element;
                    Integer dueDay = Integer.valueOf(dueDate[0]);
                    Long id = (dueDate[1] != null) ? Long.valueOf(dueDate[1])
                                                   : null;
                    FilingDueDateRule taxDueDate = null;

                    if (id == null) {
                        Integer dueMonth = Integer.valueOf(dueDate[2]);
                        taxDueDate = new FilingDueDateRule();
                        taxDueDate.setId(id);
                        taxDueDate.setDueDay(dueDay);
                        taxDueDate.setDueMonth(dueMonth);

                        taxDueDate.onCreate();
                    } else {
                        taxDueDate = taxModuleManager.getFilingDueDateRuleForId(id);
                    }

                    return taxDueDate;
                }
            });
        binder.registerCustomEditor(List.class, "installmentDueDateRules",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    String[] dueDate = (String[]) element;
                    Integer dueDay = Integer.valueOf(dueDate[0]);
                    Long id = (dueDate[1] != null) ? Long.valueOf(dueDate[1])
                                                   : null;
                    InstallmentDueDateRule taxDueDate = null;

                    if (id == null) {
                        Integer dueMonth = Integer.valueOf(dueDate[2]);
                        taxDueDate = new InstallmentDueDateRule();
                        taxDueDate.setId(id);
                        taxDueDate.setDueDay(dueDay);
                        taxDueDate.setDueMonth(dueMonth);

                        taxDueDate.onCreate();
                    } else {
                        taxDueDate = taxModuleManager.getInstallmentDueDateRuleForId(id);
                    }

                    return taxDueDate;
                }
            });

        binder.registerCustomEditor(List.class, "filingReminderRules",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    String[] reminder = (String[]) element;
                    Long reminderCode = Long.valueOf(reminder[0]);
                    Long id = (reminder[1] != null) ? Long.valueOf(reminder[1])
                                                    : null;

                    if (id == -1) {
                        return null;
                    }

                    //String reminders = (String) element;

                    //Integer dueDay = dueDate[0];
                    //Integer dueMonth = dueDate[1];
                    FilingReminderRule reminderRule; //= taxModuleManager

                    if (id == null) {
                        reminderRule = new FilingReminderRule();
                        reminderRule.onCreate();
                    } else {
                        reminderRule = taxModuleManager.getFilingReminderRuleById(id);
                    }

                    if ((reminderRule.getReminderDayCode() != null) &&
                            reminderRule.getReminderDayCode().getId()
                                            .equals(reminderCode)) {
                        return null;
                    } else {
                        Code code = codesManager.getCodeById(reminderCode);
                        reminderRule.setReminderDayCode(code);
                        reminderRule.setReminderDay(Short.valueOf(
                                code.getShortName()));
                    }

                    //taxDueDate.setDueMonth(dueMonth);
                    return reminderRule;
                }
            });
        binder.registerCustomEditor(List.class, "installmentReminderRules",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    String[] reminder = (String[]) element;
                    Long reminderCode = Long.valueOf(reminder[0]);
                    Long id = (reminder[1] != null) ? Long.valueOf(reminder[1])
                                                    : null;

                    if (id == -1) {
                        return null;
                    }

                    //String reminders = (String) element;

                    //Integer dueDay = dueDate[0];
                    //Integer dueMonth = dueDate[1];
                    InstallmentReminderRule reminderRule; //= taxModuleManager

                    if (id == null) {
                        reminderRule = new InstallmentReminderRule();
                        reminderRule.onCreate();
                    } else {
                        reminderRule = taxModuleManager.getInstallmentReminderRuleById(id);
                    }

                    if ((reminderRule.getReminderDayCode() != null) &&
                            reminderRule.getReminderDayCode().getId()
                                            .equals(reminderCode)) {
                        return null;
                    } else {
                        Code code = codesManager.getCodeById(reminderCode);
                        reminderRule.setReminderDayCode(code);
                        reminderRule.setReminderDay(Short.valueOf(
                                code.getShortName()));
                    }

                    //taxDueDate.setDueMonth(dueMonth);
                    return reminderRule;
                }
            });

        binder.registerCustomEditor(Integer.class, "myInt",
            new CustomNumberEditor(Integer.class, true) {
                public void setValue(Object o) {
                    super.setValue((o == null) ? 0 : o);
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

        binder.registerCustomEditor(Party.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
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

        binder.registerCustomEditor(Jurisdiction.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text) ||
                            "".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(crmManager.getJurisdictionById(Long.valueOf(
                                    text)));
                    }
                }

                public String getAsText() {
                    String retValue = null;

                    if (getValue() != null) {
                        Jurisdiction jurisdiction = (Jurisdiction) getValue();

                        if ((jurisdiction != null) &&
                                (jurisdiction.getId() != null)) {
                            retValue = jurisdiction.getId().toString();
                        }
                    }

                    return retValue;
                }
            });

        binder.registerCustomEditor(FilingReminderRule.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taxModuleManager.getFilingReminderRuleById(
                                Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        FilingReminderRule rule = (FilingReminderRule) getValue();

                        return rule.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        binder.registerCustomEditor(InstallmentReminderRule.class,
            new PropertyEditorSupport() {
                @Override
                public void setAsText(String text)
                    throws IllegalArgumentException {
                    if ("null".equals(text) || "-1".equals(text)) {
                        setValue(null);
                    } else {
                        setValue(taxModuleManager.getInstallmentReminderRuleById(
                                Long.valueOf(text)));
                    }
                }

                public String getAsText() {
                    if (getValue() != null) {
                        InstallmentReminderRule rule = (InstallmentReminderRule) getValue();

                        return rule.getId().toString();
                    } else {
                        return null;
                    }
                }
            });

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        CustomDateEditor editor = new CustomDateEditor(df, false);
        binder.registerCustomEditor(Date.class, editor);
    }

    @ModelAttribute
    public ClientPracticeInfo initializeModel(Long firmPracticeId, Long id,
        Long clientId, HttpServletRequest request) {
        ClientPracticeInfo info = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (firmPracticeId != null) {
            if (id == null) {
                info = new ClientPracticeInfo();

                FirmPracticeType type = taxModuleManager.getFirmPracticeTypeById(firmPracticeId);
                Party clientParty = crmManager.getPartyById(clientId);
                Party firmParty = crmManager.getPartyById(firmId);
                //type.setId(firmPracticeId);
                info.setFirmPracticeType(type);
                info.setClient(clientParty);
                info.setFirm(firmParty.getOrganization());
                populateFrequency(info);
                populatePartnerInCharge(info,clientParty);
            } else {
                //get info object from db
                //populateFrequency(info);
                info = taxModuleManager.getClientPracticeInfo(id);
                populateRulesProperly(info, null);
            }
        } else {
            info = new ClientPracticeInfo();

            Party clientParty = crmManager.getPartyById(clientId);
            Party firmParty = crmManager.getPartyById(firmId);
            info.setClient(clientParty);
            info.setFirm(firmParty.getOrganization());
            populateFrequency(info);
        }

        //take care of auto populate
        info.setFilingDueDateRules(autoPopulateList(FilingDueDateRule.class,
                info.getFilingDueDateRules()));
        info.setInstallmentDueDateRules(autoPopulateList(
                InstallmentDueDateRule.class, info.getInstallmentDueDateRules()));
        info.setFilingReminderRules(autoPopulateList(FilingReminderRule.class,
                info.getFilingReminderRules()));
        info.setInstallmentReminderRules(autoPopulateList(
                InstallmentReminderRule.class,
                info.getInstallmentReminderRules()));

        return info;
    }

    private void populatePartnerInCharge(ClientPracticeInfo info,Party clientParty) {
		if(clientParty.getOrganization().getInChargePerson() != null){
			info.setPartnerInCharge(clientParty.getOrganization().getInChargePerson());
		}
	}

	private List autoPopulateList(Class cls, List listToBePopulated) {
        List autoPopulateList = new AutoPopulatingList(cls);
        autoPopulateList.addAll(listToBePopulated);

        return autoPopulateList;
    }

    private void populateRulesProperly(ClientPracticeInfo info,
        List[] delteListArray) {
        if ((delteListArray != null) && (delteListArray.length >= 2)) {
            List filingDueDateDeleteList = delteListArray[0];
            List installmentDueDateDeleteList = delteListArray[1];
            List filingReminderDeleteList = delteListArray[2];
            List installmentReminderDeleteList = delteListArray[3];

            if (!filingReminderDeleteList.isEmpty()) {
                removeUncheckedReminders(info.getFilingReminderRules(),
                    filingReminderDeleteList);
            }

            if (!installmentReminderDeleteList.isEmpty()) {
                removeUncheckedReminders(info.getInstallmentReminderRules(),
                    installmentReminderDeleteList);
            }
        }

        for (FilingDueDateRule rule : info.getFilingDueDateRules()) {
            if ((rule.getCreateUserId() == null) ||
                    "".equals(rule.getCreateUserId())) {
                //TODO replace with logged in user id
//                rule.setCreateUserId("system");
                rule.setCreateDate(new Date());
                rule.setVersion(0);
            }

            if (rule.getClientPracticeInfo() == null) {
                rule.setClientPracticeInfo(info);
            }

//            rule.setLastUpdateUserId("system");
            rule.setLastUpdateDate(new Date());
        }

        for (InstallmentDueDateRule rule : info.getInstallmentDueDateRules()) {
            if ((rule.getCreateUserId() == null) ||
                    "".equals(rule.getCreateUserId())) {
                //TODO replace with logged in user id
//                rule.setCreateUserId("system");
                rule.setCreateDate(new Date());
                rule.setVersion(0);
            }

            if (rule.getClientPracticeInfo() == null) {
                rule.setClientPracticeInfo(info);
            }

//            rule.setLastUpdateUserId("system");
            rule.setLastUpdateDate(new Date());
        }

        if (info.getFilingReminderRules() != null) {
            for (Iterator it = info.getFilingReminderRules().iterator();
                    it.hasNext();) {
                FilingReminderRule rule = (FilingReminderRule) it.next();

                if ((rule == null) ||
                        ((rule.getId() != null) &&
                        (rule.getReminderDayCode() == null))) {
                    it.remove();

                    continue;
                }

                if ((rule.getCreateUserId() == null) ||
                        "".equals(rule.getCreateUserId())) {
//                    rule.setCreateUserId("system");
                    rule.setCreateDate(new Date());
                    rule.setVersion(0);
                }

                if (rule.getClientPracticeInfo() == null) {
                    rule.setClientPracticeInfo(info);
                }

//                rule.setLastUpdateUserId("system");
                rule.setLastUpdateDate(new Date());
            }
        }

        if (info.getInstallmentReminderRules() != null) {
            for (Iterator it = info.getInstallmentReminderRules().iterator();
                    it.hasNext();) {
                InstallmentReminderRule rule = (InstallmentReminderRule) it.next();

                if ((rule == null) ||
                        ((rule.getId() != null) &&
                        (rule.getReminderDayCode() == null))) {
                    it.remove();

                    continue;
                }

                if ((rule.getCreateUserId() == null) ||
                        "".equals(rule.getCreateUserId())) {
//                    rule.setCreateUserId("system");
                    rule.setCreateDate(new Date());
                    rule.setVersion(0);
                }

                if (rule.getClientPracticeInfo() == null) {
                    rule.setClientPracticeInfo(info);
                }

//                rule.setLastUpdateUserId("system");
                rule.setLastUpdateDate(new Date());
            }
        }
    }

    private void removeUncheckedReminders(List filingReminderRules,
        List filingReminderDeleteList) {
        for (Iterator it = filingReminderDeleteList.iterator(); it.hasNext();) {
            Object tobeDeleted = it.next();

            if (filingReminderRules.contains(tobeDeleted)) {
                filingReminderRules.remove(tobeDeleted);
            }
        }
    }

    private void populateFrequency(ClientPracticeInfo info) {
        boolean installmentType = false;
        boolean filingType = false;

        if (!installmentType) {
            addDateRule(info, 2);
            addReminderRule(info, 2);
        }

        if (!filingType) {
            addDateRule(info, 1);
            addReminderRule(info, 1);
        }
    }

    private void addDateRule(ClientPracticeInfo info, int type) {
        if (type == 1) { //Filing Due Date{

            FilingDueDateRule rule = new FilingDueDateRule();
            rule.setClientPracticeInfo(info);
            rule.onCreate();
            info.getFilingDueDateRules().add(rule);
        } else if (type == 2) { //Installment Due Date

            InstallmentDueDateRule rule = new InstallmentDueDateRule();
            rule.setClientPracticeInfo(info);
            rule.onCreate();
            info.getInstallmentDueDateRules().add(rule);
        } else {
            throw new RuntimeException("Unknown Filing Type");
        }
    }

    private void addReminderRule(ClientPracticeInfo info, int type) {
        if (type == 1) { //Filing Reminder{

            FilingReminderRule reminder = new FilingReminderRule();
            reminder.setClientPracticeInfo(info);
            reminder.onCreate();
            info.getFilingReminderRules().add(reminder);
        } else { //Installment Reminder

            InstallmentReminderRule reminder = new InstallmentReminderRule();
            reminder.setClientPracticeInfo(info);
            reminder.onCreate();
            info.getInstallmentReminderRules().add(reminder);
        }
    }

    @ModelAttribute
    public List[] initializeModelForDeletes(ClientPracticeInfo info,
        HttpServletRequest request) {
        List<FilingDueDateRule> filingToBeDeletedList = new ArrayList();
        List<InstallmentDueDateRule> installmentToBeDeletedList = new ArrayList();
        List<FilingReminderRule> filingReminderToBeDeletedList = new ArrayList();
        List<InstallmentReminderRule> installmentReminderToBeDeletedList = new ArrayList();

        if (request.getMethod().equals("POST")) {
            List<FilingDueDateRule> origFilingList = info.getFilingDueDateRules();
            filingToBeDeletedList = removeDeletedEntries(filingToBeDeletedList,
                    origFilingList, "filingDueDateRules", request, "id");

            //remove the installment entries
            List<InstallmentDueDateRule> origInstallmentList = info.getInstallmentDueDateRules();
            installmentToBeDeletedList = removeDeletedEntries(installmentToBeDeletedList,
                    origInstallmentList, "installmentDueDateRules", request,
                    "id");

            //remove removed filing reminders
            List<FilingReminderRule> origFilingReminderList = info.getFilingReminderRules();
            filingReminderToBeDeletedList = removeDeletedEntries(filingReminderToBeDeletedList,
                    origFilingReminderList, "filingReminderRules", request,
                    "reminderDayCode");

            List<InstallmentReminderRule> origInstallmentReminderList = info.getInstallmentReminderRules();
            installmentReminderToBeDeletedList = removeDeletedEntries(installmentReminderToBeDeletedList,
                    origInstallmentReminderList, "installmentReminderRules",
                    request, "reminderDayCode");
        }

        List[] delteListArray = {
                filingToBeDeletedList, installmentToBeDeletedList,
                filingReminderToBeDeletedList,
                installmentReminderToBeDeletedList
            };

        return delteListArray;
    }

    private List removeDeletedEntries(List toBeDeletedList, List listFromDB,
        String paramName, HttpServletRequest request, String secondKey) {
        Map paraMap = request.getParameterMap();
        Set keySet = paraMap.keySet();

        for (Iterator itComm = listFromDB.iterator(); itComm.hasNext();) {
            PersistentEntity obj = (PersistentEntity) itComm.next();

            if (obj != null) {
                boolean exists = false;

                for (Iterator it = keySet.iterator(); it.hasNext();) {
                    String key = (String) it.next();

                    //StringTokenizer token = new StringTokenizer(key, ".");
                    //String firstKey = token.nextToken();
                    //String secondKey = token.hasMoreTokens()? token.nextToken() : null;
                    if (key.contains(paramName) && key.contains(secondKey)) {
                        String value = request.getParameter(key);
                        String objValue = null;

                        // get an instance
                        if (obj instanceof FilingReminderRule) {
                            FilingReminderRule rule = (FilingReminderRule) obj;
                            objValue = rule.getReminderDayCode().getId()
                                           .toString();
                        } else if (obj instanceof InstallmentReminderRule) {
                            InstallmentReminderRule rule = (InstallmentReminderRule) obj;
                            objValue = rule.getReminderDayCode().getId()
                                           .toString();
                        } else if(obj != null && obj.getId() != null){
                            objValue = obj.getId().toString();
                        }
                        
                        if ((objValue != null) && objValue.equals(value)) {
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

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/tax/taxModule.do", method = RequestMethod.GET)
    public String getTaxModule(HttpServletRequest request,
        ClientPracticeInfo practiceInfo, Long firmPracticeId, Long clientId,
        ModelMap model) {
        logger.info("Tax Module!");
        if(practiceInfo.getFilingDueDateRules().isEmpty()){
        	List<FilingDueDateRule> filingDueDateList = new ArrayList();
        	filingDueDateList.add(new FilingDueDateRule());
        	practiceInfo.setFilingDueDateRules(filingDueDateList);
        }
        if(practiceInfo.getInstallmentDueDateRules().isEmpty()){
        	List<InstallmentDueDateRule> installmentDueDateList = new ArrayList();
        	installmentDueDateList.add(new InstallmentDueDateRule());
        	practiceInfo.setInstallmentDueDateRules(installmentDueDateList);
        }
        //model.addAttribute("clientPracticeInfo", practiceInfo);
        Long firmId = PMUtil.getFirmIdFromSession(request);

        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }
        String clientName = "Client";
        if(practiceInfo != null){
        	Party client = practiceInfo.getClient();
        	if(client != null)
        	{
              clientName = client.getName();
        	}
        if(clientName != null){
        	 model.put("clientPartyName", clientName);
        }
        }
        //set
        List<Party> listOfParties = PMUtil.getRelatedParties(crmManager, firmId);
        model.put("staffList", listOfParties);
        model.put("clientStaffList", getStaffData(clientId));
        model.put("partnerList", getPartnerData(firmId));
        model.put("filingFrequency",codesManager.getCodesByCodeType(CodeType.FILING_FREQUENCY_CODE_TYPE.getId()));
        model.put("filingReminderDays",codesManager.getCodesByCodeType(CodeType.FILING_REMINDER_DAYS.getId()));
        model.put("instalmentFrequency",codesManager.getCodesByCodeType(CodeType.INSTALLMENT_FREQUENCY_CODE_TYPE.getId()));
        model.put("instalmentReminderDays",codesManager.getCodesByCodeType(CodeType.INSTALLMENT_REMINDER_DAYS.getId()));
        model.put("monthList", PMConstants.MONTHLIST);
        model.put("dueDayLabelMap", PMConstants.DUE_DAY_LABEL_MAP);
        model.put("jurisdictionList", crmManager.getJurisdictionList());
        model.put("yesNoList", PMConstants.YES_NO_LIST);
        model.put("taxModules", taxModuleManager.getFirmPracticeTypeList(firmId));
        PMUtil.showStatusMessage(request, model);

        //return "redirect:/Chiguru/taxModule.do?id="+firmPracticeId+"&firmId=" + firmId+"&clientId="+clientId;
        return "taxModule.tilesView";
    }

    /**
     * Simply selects the welcome view to render by returning void and relying
     * on the default request-to-view-translator.
     */
    @RequestMapping(value = "/tax/taxModule.do", method = RequestMethod.POST)
    public String saveTaxModule(HttpServletRequest request,
    		ClientPracticeInfo practiceInfo, Long firmPracticeId, Long clientId,
        ModelMap model, List[] delteListArray) {
        logger.info("Tax Module!");

        Long firmId = PMUtil.getFirmIdFromSession(request);
        Organization org = crmManager.getOrganizationById(firmId);
        practiceInfo.setFirm(org);
        FirmPracticeType type = taxModuleManager.getFirmPracticeTypeById(firmPracticeId);
        practiceInfo.setFirmPracticeType(type);
        System.out.println("tax module firm ID"+firmId);
        if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
                (firmId == null)) {
            throw new RuntimeException("firmId can not be empty");
        }

        populateRulesProperly(practiceInfo, delteListArray);
        if(practiceInfo.getClient() == null){
        	Party newParty = crmManager.getPartyById(clientId);
        	practiceInfo.setClient(newParty);
        }
        String baseURL = request.getParameter("baseURL");
        //System.out.println("practice info firm ID"+practiceInfo.getFirm().getId());
        if(practiceInfo != null){
        taxModuleManager.saveTaxPracticeInfo(practiceInfo, delteListArray);

        //taxModuleManager.deleteDueDateRules(delteListArray);
        //set
        List<Party> listOfParties = PMUtil.getRelatedParties(crmManager, firmId);
        model.put("staffList", listOfParties);
        model.put("clientStaffList", getStaffData(clientId));
        model.put("partnerList", getPartnerData(clientId));
        model.put("filingFrequency",
            codesManager.getCodesByCodeType(
                CodeType.FILING_FREQUENCY_CODE_TYPE.getId()));
        model.put("filingReminderDays",
            codesManager.getCodesByCodeType(
                CodeType.FILING_REMINDER_DAYS.getId()));
        model.put("instalmentFrequency",
            codesManager.getCodesByCodeType(
                CodeType.INSTALLMENT_FREQUENCY_CODE_TYPE.getId()));
        model.put("instalmentReminderDays",
            codesManager.getCodesByCodeType(
                CodeType.INSTALLMENT_REMINDER_DAYS.getId()));
        model.put("monthList", PMConstants.MONTHLIST);
        model.put("dueDayLabelMap", PMConstants.DUE_DAY_LABEL_MAP);
        model.put("jurisdictionList", crmManager.getJurisdictionList());
        model.put("yesNoList", PMConstants.YES_NO_LIST);
        model.put("taxModules", taxModuleManager.getFirmPracticeTypeList(firmId));

       
        String returnURL = baseURL + 
            "?firmPracticeId=" + firmPracticeId + "&clientId=" + clientId +
            "&saveSuccess=true";

        return "redirect:" + returnURL;
        }else{
        	return "redirect:" + baseURL;
        }
    }

    private List<Party> getStaffData(Long partyId) {
        return crmManager.getRelatedPartiesById(partyId,
            RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
    }

    private List<Party> getPartnerData(Long partyId) {
        return crmManager.getRelatedPartiesById(partyId,
            RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
    }
}
