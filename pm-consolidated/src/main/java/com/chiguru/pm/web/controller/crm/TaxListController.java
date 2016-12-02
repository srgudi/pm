package com.chiguru.pm.web.controller.crm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.ClientPracInfoDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.SearchCommand;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.crm.dto.TaxSearch;
import com.chiguru.pm.crm.service.GridService;
import com.chiguru.pm.crm.util.GridUtil;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.GridJSONResponse;
import com.chiguru.pm.web.util.PMUtil;
import com.chiguru.pm.web.util.TextEncryptUtil;


@Controller
public class TaxListController {
    private Logger logger = org.slf4j.LoggerFactory.getLogger(TaxListController.class);
    @Autowired
    private TaxModuleManager taxModuleManager;
    @Autowired
    private GridService gridService;

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
    GridJSONResponse getManageTaxList(HttpServletRequest request) {
        logger.info("Manage Tax List!!");
        String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
        Long count = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("firmId =" + firmId);

        TaxSearch command = GridUtil.setFilterParameterForTaxType(request);
        command.setFirmId(firmId);
        count = gridService.getTaxDTOListCount(command);	
        command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
        String sEcho = request.getParameter("sEcho");
        List<TaxDTO> taxDTOList = gridService.getTaxDTOList(command);
        for(TaxDTO taxDTO:taxDTOList){
         	if(taxDTO.getActiveFlag() == true){
         		taxDTO.setStatus("Active");
        	}else{
        		taxDTO.setStatus("Inactive");
          	}
        }
    	GridJSONResponse jsonResponse = prepareResponse(taxDTOList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
    }

    public static GridJSONResponse prepareResponse(List<TaxDTO> taxDTOList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(taxDTOList.size()>0){
			for(TaxDTO taxDTO: taxDTOList){
				Object[] objects = new Object[5];
				 objects[0] = taxDTO.getTaxId();
				 objects[1] = taxDTO.getName();
				 objects[2] = taxDTO.getDescription();
				 objects[3] = taxDTO.getStatus();
				 /*objects[4] = "<a href='javascript:editTaxType(&quot;" + TextEncryptUtil.encryptForLong(taxDTO.getTaxId()) + "&quot;)'>edit</a>";*/
				 objects[4] = "<a href='javascript:editTaxType(&quot;" +taxDTO.getTaxId()+ "&quot;)'>edit</a>";
				 aaData.add(objects);
			}
		}
		 jsonResponse.setAaData(aaData);
		 jsonResponse.setiTotalRecords(10);
		return jsonResponse;	
	}
    @RequestMapping(value = {"/tax/taxModuleList.do","/mobiletax/mobileTaxModuleList.do"}, method = RequestMethod.GET)
    public @ResponseBody
    GridJSONResponse getTaxModuleList(HttpServletRequest request, Long clientId,
        Long firmPracticeId) {
        logger.info("Tax Module List!");
        String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	clientId = Long.valueOf(request.getParameter("clientId"));
        Long count = null;
        Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("firmId =" + firmId);

       TaxSearch command = GridUtil.setFilterParametersForTaxList(request);
       command.setClientId(clientId);
       count = gridService.getCliPracInfoCount(command); 
       command.setCount(count.intValue());
       command.setLimit(Integer.parseInt(pageSize));
   	   command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
       
   	   List<ClientPracInfoDTO> clientPracticeInfoDTOList = gridService.getCliPracInfoList(command);
        for(ClientPracInfoDTO clientPracticeInfoDTO:clientPracticeInfoDTOList){
         	if(clientPracticeInfoDTO.activeFlag == true){
         		clientPracticeInfoDTO.setStatus("Active");
        	}else{
        		clientPracticeInfoDTO.setStatus("Inactive");
          	}
         	clientPracticeInfoDTO.setJurisdictionName(clientPracticeInfoDTO.getJuriCountry()+":"+clientPracticeInfoDTO.getJuriState());
        }

       /* populateReturnMapWithPageDatails(retMap, clientPracticeInfoDTOList, page);

        return retMap;*/
        String sEcho = request.getParameter("sEcho");
        GridJSONResponse jsonResponse = prepareResponses(clientPracticeInfoDTOList);
        jsonResponse.setsEcho(sEcho);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        return jsonResponse;
    }
   
    public GridJSONResponse prepareResponses(List<ClientPracInfoDTO> clientPracticeInfoDTOList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(clientPracticeInfoDTOList.size()>0){
			for(ClientPracInfoDTO clientPracticeInfoDTO:clientPracticeInfoDTOList){
				Object[] objects = new Object[10];
				objects[0] = clientPracticeInfoDTO.getClientPracticeInfoId();
				objects[1] = clientPracticeInfoDTO.getClientName();
				objects[2] = clientPracticeInfoDTO.getJurisdictionName();
				objects[3] = clientPracticeInfoDTO.getStaffInChargeName();
				objects[4] = clientPracticeInfoDTO.getClientStaffInChargeName();
				objects[5] = clientPracticeInfoDTO.getTaxReturn();
				objects[6] = clientPracticeInfoDTO.getTaskCreator();
				objects[7] = clientPracticeInfoDTO.getFormatedtaskCreatedDate();
				objects[8] = clientPracticeInfoDTO.getStatus();
				//objects[9] = "<a class='javascript:colorBoxDemotax cboxElement' href='taxModule.do?id=" + clientPracticeInfoDTO.getClientPracticeInfoId() + "&firmPracticeId="+firmPracticeId+"'>edit</a>";
				  objects[9] = "<a href='javascript:TaxEdit(" + clientPracticeInfoDTO.getClientPracticeInfoId() + ")'>edit</a>";												      
				aaData.add(objects);
			}
			
			//jsonResponse.setiTotalRecords(10);
		}
		jsonResponse.setAaData(aaData);
		return jsonResponse;
	}
    @RequestMapping(value="/tax/mainTax.do", method=RequestMethod.GET)
	public String mainTax(HttpServletRequest request,ModelMap model){
    	System.out.println("Hello people");
		return "mainTAX.tilesView";
	}
    
    @RequestMapping(value = {"/tax/taxList.do","/mobiletax/mobileTaxList.do"}, method = RequestMethod.GET)
    public String taxList(HttpServletRequest request, ModelMap model) {
		logger.info("Get Tax List!");
		if(request.getRequestURI().contains("/tax/taxList.do")){
			return "/tax/taxList";
		}else{
		return "mobiletaxList.tilesView";
		}
	}
}
