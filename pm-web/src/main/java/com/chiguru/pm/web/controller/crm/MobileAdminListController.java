package com.chiguru.pm.web.controller.crm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.web.util.PMUtil;

@Controller
public class MobileAdminListController extends BaseController{
	
    private Map getFirmList(Long mainPartyId, Integer partyTypeId, Page page) {
        Map retMap = new HashMap();
        Long count = null;

        if (page != null) {
            count = crmManager.getFirmsCountById(partyTypeId,OrganizationType.ORGANIZATION_TYPE_FIRM.id);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }

        List<PartyDTO> firmList = crmManager.getFirmsListById(partyTypeId, OrganizationType.ORGANIZATION_TYPE_FIRM.id, count);
        for (PartyDTO partyDTO : firmList) {
			if(partyDTO.getActiveFlag()  == true){
				partyDTO.setStatus("Active");
			}else{
				partyDTO.setStatus("Inactive");
			}
		}

        populateReturnMapWithPageDatails(retMap, firmList, page);

        return retMap;
    }
    
    private void populateReturnMapWithPageDatails(Map retMap, List entityList,
            Page page) {
            retMap.put("rows", entityList);

            if (page != null) {
                retMap.put("page", page.getCurrentPage());
                retMap.put("total", page.getTotalPages());
                retMap.put("records", page.getCount());
            }
        }	   
}
