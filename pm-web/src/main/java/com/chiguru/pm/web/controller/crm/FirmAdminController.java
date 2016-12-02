package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.service.CRMManager;

import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;


@Controller
public class FirmAdminController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(FirmAdminController.class);
    private CRMManager crmManager;

    @Autowired
    public FirmAdminController(CRMManager crmManager) {
        this.crmManager = crmManager;
    }

    @ModelAttribute
    public Party initializeModel(Long id, Long firmId,
        HttpServletRequest request) {
        Party party;

        if (firmId == null) {
            throw new RuntimeException("firmId can not be empty");
        }

        if (id == null) {
            party = new Party();

            Organization org = new Organization();
            party.setOrganization(org);
        } else {
            party = crmManager.getPartyById(id);
        }

        return party;
    }
}
