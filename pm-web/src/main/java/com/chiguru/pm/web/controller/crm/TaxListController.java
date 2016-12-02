package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;


@Controller
public class TaxListController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(TaxListController.class);
    @Autowired
    private TaxModuleManager taxModuleManager;
    

    private void populateReturnMapWithPageDatails(Map retMap, List entityList,
        Page page) {
        retMap.put("rows", entityList);

        if (page != null) {
            retMap.put("page", page.getCurrentPage());
            retMap.put("total", page.getTotalPages());
            retMap.put("records", page.getCount());
        }
    }

    @RequestMapping(value = "/firmadmin/manageTaxList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getManageTaxList(HttpServletRequest request) {
        logger.info("Manage Tax List!!");

        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("firmId =" + firmId);

        if(page != null){
        	count = taxModuleManager.getTaxDTOListCount(firmId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<TaxDTO> taxDTOList =taxModuleManager.getTaxDTOList(firmId, page); 
        for(TaxDTO taxDTO:taxDTOList){
         	if(taxDTO.getActiveFlag()== true){
         		taxDTO.setStatus("Active");
        	}else{
        		taxDTO.setStatus("Inactive");
          	}
        }

        populateReturnMapWithPageDatails(retMap, taxDTOList, page);      
        return retMap;
    }

    @RequestMapping(value = "/tax/taxModuleList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map getTaxModuleList(HttpServletRequest request, Long clientId,
        Long firmPracticeId) {
        logger.info("Tax Module List!");

        Map retMap = new HashMap();
        Long count = null;
        Page page = PMUtil.populatePageObject(request);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("firmId =" + firmId);

        if(page != null){
        	count = taxModuleManager.getClientPracticeInfoCount(firmPracticeId,clientId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }
        List<ClientPracticeInfoDTO> clientPracticeInfoDTOList =taxModuleManager.getClientPracticeInfoList(firmPracticeId, clientId, count); 
        for(ClientPracticeInfoDTO clientPracticeInfoDTO:clientPracticeInfoDTOList){
         	if(clientPracticeInfoDTO.activeFlag == true){
         		clientPracticeInfoDTO.setStatus("Active");
        	}else{
        		clientPracticeInfoDTO.setStatus("Inactive");
          	}
         	clientPracticeInfoDTO.setJurisdictionName(clientPracticeInfoDTO.getJuriCountry()+":"+clientPracticeInfoDTO.getJuriState());
        }

        populateReturnMapWithPageDatails(retMap, clientPracticeInfoDTOList, page);

        return retMap;
    }
}
