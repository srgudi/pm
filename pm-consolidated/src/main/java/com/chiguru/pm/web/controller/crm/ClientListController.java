package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Jurisdiction;
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
import com.chiguru.pm.crm.domain.Timezone;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeSearch;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.CodeTypeSearch;
import com.chiguru.pm.crm.dto.CommunicationDTO;
import com.chiguru.pm.crm.dto.EmployeeSearch;
import com.chiguru.pm.crm.dto.FirmSearch;
import com.chiguru.pm.crm.dto.FirmStaffSearch;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.JurisdictionSearch;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.LocationSearch;
import com.chiguru.pm.crm.dto.OfficerShareholderSearch;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.SearchCommand;
import com.chiguru.pm.crm.dto.StaffSearch;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientSearch;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateSearch;
import com.chiguru.pm.crm.dto.TaskSearchCommand;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.crm.dto.TimezoneDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.service.GridService;
import com.chiguru.pm.crm.util.GridUtil;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.security.PMUserService;
import com.chiguru.pm.tax.domain.TaskNotificationRecipient;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.tax.service.TaskModuleManager;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.GridJSONResponse;
import com.chiguru.pm.web.util.PMUtil;


import org.slf4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;


/**
 * Handles requests for the application welcome page.
 */
@Controller
public class ClientListController {
	private Logger logger = org.slf4j.LoggerFactory.getLogger(ClientListController.class);
	private CRMManager crmManager;
	@Autowired
	private PMUserService userService;
	@Autowired
	private TaxModuleManager taxModuleManager;
	@Autowired
	private TaskModuleManager taskModuleManager;
	@Autowired
	private GridService gridService;

	@Autowired
	public ClientListController(CRMManager crmManager) {
		this.crmManager = crmManager;
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = {"/client/locationList.do","/mobileclient/mobileLocationList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse locationList(HttpServletRequest request, Long clientId, Long partyId) {
		logger.info("Location Bank List!");
		if(clientId == null){
			HttpSession session = request.getSession();
			clientId = (Long) session.getAttribute("clientId");
		}
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		if (clientId != null) {
			partyId = clientId;
		}
		String sEcho = request.getParameter("sEcho");
		LocationSearch command = GridUtil.setFilterParameterForLocation(request);
    	command.setPartyId(partyId);
    	command.setActiveFlag(true);
    	Long count = gridService.getLocationCount(command);
    	command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	List<LocationDTO> partySiteList = gridService.getLocationList(command);
    	
    	GridJSONResponse jsonResponse = prepareRespons(partySiteList, clientId);
    	jsonResponse.setsEcho(sEcho);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        return jsonResponse;


	}

	GridJSONResponse prepareRespons(List<LocationDTO> partySiteList, Long clientId){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(partySiteList.size()>0){
			for(LocationDTO locationDTO: partySiteList){
				Object[] objects = new Object[8];
				objects[0] = locationDTO.getPartySiteId();
				objects[1] = locationDTO.getPartyName();
				objects[2] = locationDTO.getName();
				objects[3] = locationDTO.getLocationType();
				objects[4] = locationDTO.getOfficeNumber();
				objects[5] = locationDTO.getHomeNumber();
				objects[6] = locationDTO.getEmailAddress();
				objects[7] = "<a href='javascript:LocationEdit(" + locationDTO.getPartySiteId() + ")'>edit</a>";
				aaData.add(objects);
			}
		}
		jsonResponse.setAaData(aaData);
		//jsonResponse.setiTotalRecords(10);
		return jsonResponse;
	}
	
	@RequestMapping(value = "/appadmin/timeZoneList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map TimeZoneList(HttpServletRequest request, Long clientId, Long partyId) {
		logger.info("TimeZone List!");

		Map retMap = new HashMap();
		Long count = null;
		Page page = PMUtil.populatePageObject(request);

		if(page != null){
			count = crmManager.getTimezoneListCount();
			PMUtil.adjustPagination(page, count.intValue());
			page.setCount(count.intValue());

			List<TimezoneDTO> timezoneDTOList =crmManager.getTimezoneDTOList(count);
			for (TimezoneDTO timezoneDTO : timezoneDTOList) {
				if(timezoneDTO.getActiveFlag() == true){
					timezoneDTO.setStatus("Active");
				}else{
					timezoneDTO.setStatus("Inactive");
				}
			}

			populateReturnMapWithPageDatails(retMap, timezoneDTOList, page);
		}
		return retMap;

	}
	private TimezoneDTO getTimezoneDTO(Timezone timezone) {
		TimezoneDTO timezoneDTO = new TimezoneDTO();
		timezoneDTO.setId(timezone.getId());
		timezoneDTO.setGlobalTimezoneName(timezone.getGlobalTimezoneName());
		timezoneDTO.setGmtDeviationHours(timezone.getGmtDeviationHours());
		timezoneDTO.setDstFlag(timezone.getDstFlag());
		timezoneDTO.setDstBeginMonth(timezone.getDstBeginMonth());
		timezoneDTO.setDstBeginDay(timezone.getDstBeginDay());
		timezoneDTO.setDstBeginDayOfWeek(timezone.getDstBeginDayOfWeek());
		timezoneDTO.setDstBeginHour(timezone.getDstBeginHour());
		timezoneDTO.setDstEndMonth(timezone.getDstEndMonth());
		timezoneDTO.setDstEndDay(timezone.getDstEndDay());
		timezoneDTO.setDstEndDayOfWeek(timezone.getDstEndDayOfWeek());
		timezoneDTO.setDstEndDayOfWeek(timezone.getDstEndDayOfWeek());
		timezoneDTO.setDstEndHour(timezone.getDstEndHour());
		timezoneDTO.setDstStdCd(timezone.getDstStdCd());
		timezoneDTO.setDstSavingsCd(timezone.getDstSavingsCd());

		if (timezone.activeFlag == true) {
			timezoneDTO.setStatus("Active");
		} else {
			timezoneDTO.setStatus("Inactive");
		}

		return timezoneDTO;
	}

	@RequestMapping(value = {"/appadmin/jurisdictionsList.do","/mobileadmin/mobileAdminJuridList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getJurisdictions(HttpServletRequest request, Long clientId, Long partyId) {
	     String start = request.getParameter("iDisplayStart");
	    	String pageSize = request.getParameter("iDisplayLength");
	    	String sortColumn = request.getParameter("iSortCol_0");
	    	String order = request.getParameter("sSortDir_0");
	    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		  	Long count = null;
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        logger.info("firmId =" + firmId);
	        JurisdictionSearch command = GridUtil.setFilterParameterForJurisdiction(request);
	        count = gridService.getJurisdictionListCount(command);
	        command.setCount(count.intValue());
    	    command.setLimit(Integer.parseInt(pageSize));
    	    command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	
    	String sEcho = request.getParameter("sEcho");
		List<JurisdictionDTO> jurisdictionDTOList = gridService.getJurisdictionDTOList(command);

		for (JurisdictionDTO jurisdictionDTO : jurisdictionDTOList) {
			if(jurisdictionDTO.getActiveFlag() == true ){
				jurisdictionDTO.setStatus("Active");
			}else{
				jurisdictionDTO.setStatus("Inactive");
			}
		}
		GridJSONResponse jsonResponse = prepareResponsing(jurisdictionDTOList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	public static GridJSONResponse prepareResponsing(List<JurisdictionDTO> jurisdictionDTOList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(jurisdictionDTOList.size()>0){
			for(JurisdictionDTO jurisdictionDTO: jurisdictionDTOList){
				Object[] objects = new Object[8];
				 objects[0] = jurisdictionDTO.getId();
				 objects[1] = jurisdictionDTO.getCountry();
				 objects[2] = jurisdictionDTO.getState();
				 objects[3] = jurisdictionDTO.getCity();
				 objects[4] = jurisdictionDTO.getGlobalTimezoneName();
				 objects[5] = jurisdictionDTO.getGmtDeviationHours();
				 objects[6] = jurisdictionDTO.getStatus();
				 objects[7] = "<a href='javascript:editJurid(" + jurisdictionDTO.getId() + ")'>edit</a>";
				 aaData.add(objects);
			}
			 jsonResponse.setAaData(aaData);
			 jsonResponse.setiTotalRecords(10);
		}
		return jsonResponse;	
	}
	
	private JurisdictionDTO getJurisdictionDTO(Jurisdiction jurisdiction) {
		JurisdictionDTO jurisdictionDTO = new JurisdictionDTO();
		jurisdictionDTO.setId(jurisdiction.getId());
		jurisdictionDTO.setCountry(jurisdiction.getCountry());
		jurisdictionDTO.setState(jurisdiction.getState());
		jurisdictionDTO.setCounty(jurisdiction.getCounty());
		jurisdictionDTO.setCity(jurisdiction.getCity());

		if (jurisdiction.activeFlag == true) {
			jurisdictionDTO.setStatus("Active");
		} else {
			jurisdictionDTO.setStatus("Inactive");
		}

		jurisdictionDTO.setGlobalTimezoneName(jurisdiction.getTimezone()
				.getGlobalTimezoneName());
		jurisdictionDTO.setGmtDeviationHours(jurisdiction.getTimezone()
				.getGmtDeviationHours());

		return jurisdictionDTO;
	}

	@RequestMapping(value = "/appadmin/codeTypeList.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getCodeType(HttpServletRequest request) {
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		Long count = null;
		Long firmId = PMUtil.getFirmIdFromSession(request);
        logger.info("firmId =" + firmId);
        String sEcho = request.getParameter("sEcho");
        CodeTypeSearch command = GridUtil.setFilterParameterForCodeType(request);
        count = gridService.getCodeTypeListCount(command);
        command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
		List<CodeTypeDTO> codeTypeList =gridService.getCodeTypeDTOList(command);

		for (CodeTypeDTO codeTypeDTO : codeTypeList) {
			if(codeTypeDTO.getActiveFlag() == true){
				codeTypeDTO.setStatus("Active");
			}else{
				codeTypeDTO.setStatus("Inactive");
			}
			if(codeTypeDTO.getApplicationLevelIndicator() == true){
				codeTypeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeTypeDTO.setStrApplicationLevelIndicator("No");
			}
		}

		//populateReturnMapWithPageDatails(retMap, codeTypeList, page);

		//return retMap;
		GridJSONResponse jsonResponse = prepareResponser(codeTypeList);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	public static GridJSONResponse prepareResponser(List<CodeTypeDTO> codeTypeList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(codeTypeList.size()>0){
			for(CodeTypeDTO codeTypeDTO: codeTypeList){
				Object[] objects = new Object[6];
				 objects[0] = codeTypeDTO.getId();
				 objects[1] = codeTypeDTO.getName();
				 objects[2] = codeTypeDTO.getDescription();
				 /*objects[3] = codeTypeDTO.getParentCodeTypeName();*/
				 objects[3] = codeTypeDTO.getApplicationLevelIndicator();
				 objects[4] = codeTypeDTO.getStatus();
				 objects[5] = "<a href='javascript:editcodeType(" + codeTypeDTO.getId() + ")'>edit</a>";
				 aaData.add(objects);
			}
			 jsonResponse.setAaData(aaData);
			 //jsonResponse.setiTotalRecords(10);
		}
		return jsonResponse;	
	}
	private CodeTypeDTO getCodeTypeDTO(CodeType codeType) {
		CodeTypeDTO codeTypeDTO = new CodeTypeDTO();
		codeTypeDTO.setId(codeType.getId());
		codeTypeDTO.setName(codeType.getName());

		if (codeType.isApplicationLevelIndicator() == true) {
			codeTypeDTO.setStrApplicationLevelIndicator("Yes");
		} else {
			codeTypeDTO.setStrApplicationLevelIndicator("No");
		}

		if (codeType.getParentCodeType() != null) {
			codeTypeDTO.setParentCodeTypeId(codeType.getParentCodeType().getId());
			codeTypeDTO.setParentCodeTypeName(codeType.getParentCodeType()
					.getName());
		}
		codeTypeDTO.setDescription(codeType.getDescription());

		if (codeType.isActiveFlag() == true) {
			codeTypeDTO.setStatus("Active");
		} else {
			codeTypeDTO.setStatus("Inactive");
		}

		return codeTypeDTO;
	}

	@RequestMapping(value = "/appadmin/codeList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map getCode(HttpServletRequest request) {
		Map retMap = new HashMap();
		Long count = null;
		Page page = PMUtil.populatePageObject(request);

		if(page != null){
			count = crmManager.getCodeListCount();
			PMUtil.adjustPagination(page, count.intValue());
			page.setCount(count.intValue());
		}
		List<CodeDTO> codeList =crmManager.getCodeDTOList(count);
		for (CodeDTO codeDTO : codeList) {
			if(codeDTO.getActiveFlag() == true){
				codeDTO.setStatus("Active");
			}else{
				codeDTO.setStatus("InActive");
			}
			if(codeDTO.getApplicationLevelIndicator() == true){
				codeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeDTO.setStrApplicationLevelIndicator("No");
			}
		}

		populateReturnMapWithPageDatails(retMap, codeList, page);

		return retMap;
	}

	@RequestMapping(value = "/appadmin/retriveAdminCode.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getRetriveAdminCode(HttpServletRequest request,Long codeType,Boolean applicationLevelId) {
		//Map retMap = new HashMap();
		String start = request.getParameter("iDisplayStart");
	    String pageSize = request.getParameter("iDisplayLength");
	    String sortColumn = request.getParameter("iSortCol_0");
	    String order = request.getParameter("sSortDir_0");
	    logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		Long count = 0l;
		List<CodeDTO> codeList = new ArrayList<CodeDTO>();
		String sEcho = request.getParameter("sEcho");
		request.getParameter("applicationLevelIndicator");

		CodeSearch command = GridUtil.setCodeFilterParameters(request);
		if(codeType != null && codeType != -1){
			if(codeType != -1){
				command.setCodeTypeId(codeType);
				if(applicationLevelId != null){
					command.setApplicationLevelId(applicationLevelId);
				}else{
					command.setApplicationLevelId(true);
				}
				
				count = gridService.getAdminCodeListCount(command);
				command.setCount(count.intValue());
		    	command.setLimit(Integer.parseInt(pageSize));
		    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
				codeList =gridService.getAdminCodeDTOList(command);
				for (CodeDTO codeDTO : codeList) {
					if(codeDTO.getActiveFlag() == true){
						codeDTO.setStatus("Active");
					}else{
						codeDTO.setStatus("Inactive");
					}
					if(codeDTO.getApplicationLevelIndicator() == true){
						codeDTO.setStrApplicationLevelIndicator("Yes");
					}else{
						codeDTO.setStrApplicationLevelIndicator("No");
					}
				}
			}
		}
		
		if(codeList != null){
			System.out.println("list is not empty");
		}
		
		GridJSONResponse jsonResponse = prepareRespo(codeList);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	 public static GridJSONResponse prepareRespo(List<CodeDTO> codeList){
			GridJSONResponse jsonResponse = new GridJSONResponse();
			List<Object[]> aaData = new ArrayList();
			if(codeList.size()>0){
				for(CodeDTO codeDTO: codeList){
					Object[] objects = new Object[8];
					 objects[0] = codeDTO.getId();
					 objects[1] = codeDTO.getShortName();
					 objects[2] = codeDTO.getLongDescription();
					 objects[3] = codeDTO.getCodeTypeName();
					 objects[4] = codeDTO.getApplicationLevelIndicator();
					 objects[5] = codeDTO.getParentCodeShortName();
					 objects[6] = codeDTO.getStatus();
					 objects[7] = "<a href='javascript:adminCodeEdit(" + codeDTO.getId() + ")'>edit</a>";
					 aaData.add(objects);
				}
			}
			 jsonResponse.setAaData(aaData);
			 jsonResponse.setiTotalRecords(10);
			return jsonResponse;	
		}
	 
	private CodeDTO getCodeDTO(Code code) {
		CodeDTO codeDTO = new CodeDTO();
		codeDTO.setId(code.getId());
		codeDTO.setShortName(code.getShortName());
		codeDTO.setLongDescription(code.getLongDescription());
		codeDTO.setApplicationLevelIndicator(code.isApplicationLevelIndicator());

		CodeType codeType = code.getCodeType();
		codeDTO.setCodeTypeId(codeType.getId());
		codeDTO.setCodeTypeName(codeType.getName());

		codeDTO.setSortOrder(code.getSortOrder());

		if (code.getParentCode() != null) {
			codeDTO.setParentCodeId(code.getParentCode().getId());
			codeDTO.setParentCodeShortName(code.getParentCode().getShortName());
		}

		if (code.activeFlag == true) {
			codeDTO.setStatus("Active");
		} else {
			codeDTO.setStatus("Inactive");
		}

		return codeDTO;
	}

	@RequestMapping(value = "/firmadmin/partyCodeList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map getPartyCode(HttpServletRequest request) {
		Map retMap = new HashMap();
		Long count = null;
		Long firmId = PMUtil.getFirmIdFromSession(request);
		Page page = PMUtil.populatePageObject(request);

		logger.info("firmId =" + firmId);

		if(page != null){
			count = crmManager.getPartyCodeListCount(firmId);
			PMUtil.adjustPagination(page, count.intValue());
			page.setCount(count.intValue());
		}
		List<PartyCodeDTO> partyCodeList =crmManager.getPartyCodeDTOList(count,firmId); 
		for (PartyCodeDTO partyCodeDTO : partyCodeList) {
			if(partyCodeDTO.getActiveFlag()== true){
				partyCodeDTO.setStatus("Active");
			}else{
				partyCodeDTO.setStatus("Inactive");
			}
		}
		populateReturnMapWithPageDatails(retMap, partyCodeList, page);
		return retMap;
	}

	@RequestMapping(value = {"/firmadmin/retriveCodeType.do","/mobilefirmadmin/retriveCodeType.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getPartyCodeByCodeTypeId(HttpServletRequest request, Long codeTypeId) {
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		Long count = 0l;
		Long firmId = PMUtil.getFirmIdFromSession(request);
		logger.info("firmId =" + firmId);
		List<PartyCodeDTO> partyCodeList = new ArrayList<PartyCodeDTO>();
		CodeSearch command = GridUtil.setFilterParameterForFirmCode(request);
		command.setFirmId(firmId);
		if(codeTypeId != null && codeTypeId != -1){
			command.setCodeTypeId(codeTypeId);
			count = gridService.getCountOfCodeTypeByCodeTypeId(command);
			command.setCount(count.intValue());
	    	command.setLimit(Integer.parseInt(pageSize));
	    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
	    	
			partyCodeList =gridService.getListOfCodeTypeByCodeTypeId(command);
	    	for (PartyCodeDTO partyCodeDTO : partyCodeList) {
				if(partyCodeDTO.getActiveFlag()== true){
					partyCodeDTO.setStatus("Active");
				}else{
					partyCodeDTO.setStatus("Inactive");
				}
			}
		}
		String sEcho = request.getParameter("sEcho");
		GridJSONResponse jsonResponse = prepareRe(partyCodeList);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}     

    public static GridJSONResponse prepareRe(List<PartyCodeDTO> partyCodeList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(partyCodeList.size()>0){
			for(PartyCodeDTO partyCodeDTO: partyCodeList){
				Object[] objects = new Object[7];
				 objects[0] = partyCodeDTO.getPartyCodeId();
				 objects[1] = partyCodeDTO.getCodeShortName();
				 objects[2] = partyCodeDTO.getCodeCodeTypeName();
				 objects[3] = partyCodeDTO.getCodeParentCodeShortName();
				 objects[4] = partyCodeDTO.getSortOrder(); 
				 objects[5] = partyCodeDTO.getStatus();
				 objects[6] = "<a href='javascript:CodeEdit(" + partyCodeDTO.getPartyCodeId() + ")'>edit</a>";
				 aaData.add(objects);
			}
		}
		 jsonResponse.setAaData(aaData);
		 jsonResponse.setiTotalRecords(10);
		return jsonResponse;	
	}
	private PartyCodeDTO getCodeDTO(PartyCode partyCode) {
		PartyCodeDTO partyCodeDTO = new PartyCodeDTO();
		partyCodeDTO.setId(partyCode.getId());
		partyCodeDTO.setPartyCodeId(partyCode.getId());
		partyCodeDTO.setCodeShortName(partyCode.getCode().getShortName());
		partyCodeDTO.setCodeApplicationLevelIndicator(partyCode.getCode()
				.isApplicationLevelIndicator());
		partyCodeDTO.setCodeCodeTypeName(partyCode.getCode().getCodeType()
				.getName());

		if (partyCode.getCode().getParentCode() != null) {
			partyCodeDTO.setCodeParentCodeShortName(partyCode.getCode()
					.getParentCode()
					.getShortName());
		}

		partyCodeDTO.setPartyId(partyCode.getParty().getId());
		partyCodeDTO.setPartyName(partyCode.getParty().getName());
		partyCodeDTO.setSortOrder(partyCode.getSortOrder());

		if (partyCode.activeFlag == true) {
			partyCodeDTO.setStatus("Active");
		} else {
			partyCodeDTO.setStatus("Inactive");
		}

		return partyCodeDTO;
	}

	@RequestMapping(value = "/staffList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map PersonList(HttpServletRequest request, Long clientId, Long partyId,
			int relation) {
		logger.info("Manage Firm Staff List!");

		Map retMap = new HashMap();

		if (clientId != null) {
			partyId = clientId;
		}

		if (partyId != null) {
			Party party = crmManager.getPartyById(partyId);
			Page page = PMUtil.populatePageObject(request);

			List<PartySite> totalPartySites = party.getPartySites();
			int count = totalPartySites.size();
			PMUtil.adjustPagination(page, count);
			page.setCount(count);

			List<PartySite> paginatedList = totalPartySites;

			if (totalPartySites.size() > page.getLimit()) {
				paginatedList = totalPartySites.subList(page.getStart(),
						page.getLimit());
			}

			List<LocationDTO> personList = new ArrayList();

			for (PartySite partySite : paginatedList) {
				personList.add(getLocationDTO(partySite));
			}
			populateReturnMapWithPageDatails(retMap, personList, page);
		}
		return retMap;
	}

	@RequestMapping(value = "/partnerList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map PartnerList(HttpServletRequest request) {
		logger.info("Main Partner List!");

		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Page page = PMUtil.populatePageObject(request);

		return getPartnerList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), page);
	}

	@RequestMapping(value = {"/appadmin/firmList.do","/mobileadmin/mobileFirmList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse FirmList(HttpServletRequest request) {
		logger.info("Main Firm List!");
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
		
       logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	
		HttpSession session = request.getSession(false);
		PartyDTO firm = (PartyDTO) session.getAttribute("firm");
		Long firmId = (firm != null) ? firm.getId() : null;
		Long count = null;
		FirmSearch command = GridUtil.setFilterParameters(request);
		count = gridService.getFirmsCountById(command);
		
		command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	String sEcho = request.getParameter("sEcho");
    	List<PartyDTO> firmList = gridService.getFirmsListById(command);
    	for (PartyDTO partyDTO : firmList) {
			if(partyDTO.getActiveFlag()  == true){
				partyDTO.setStatus("Active");
			}else{
				partyDTO.setStatus("Inactive");
			}
		}
    	GridJSONResponse jsonResponse = prepareRespon(firmList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        /*String redirecturl = "http://localhost:7865/pm-new/login.jsp";
        return "redirect:"+redirecturl;*/
        return jsonResponse;
	}

	@RequestMapping(value = "/appadmin/mobileAjaxfirmList.do", method = RequestMethod.GET)
	public @ResponseBody
	List<PartyDTO> mobileAjaxfirmList(HttpServletRequest request) {
		logger.info("Firm List!");
		String strt = request.getParameter("start");
		int start = Integer.parseInt(strt);
		String lmt = request.getParameter("limit");
		int limit = Integer.parseInt(lmt);
		return getFirmList(start, limit);

	}
	
	 private List<PartyDTO> getFirmList(int start, int limit) {
		// TODO Auto-generated method stub
		 Integer partyTypeId = PartyType.PARTY_TYPE_ORGANIZATION.getId();
		 Integer orgTypeId = OrganizationType.ORGANIZATION_TYPE_FIRM.id;
		 List<PartyDTO> firmList = crmManager.getMobilePartyDTOList(start, limit,partyTypeId,orgTypeId);
	    	for (PartyDTO partyDTO : firmList) {
				if(partyDTO.getActiveFlag()  == true){
					partyDTO.setStatus("Active");
				}else{
					partyDTO.setStatus("Inactive");
				}
			}
			return firmList;
	}

	public static GridJSONResponse prepareRespon(List<PartyDTO> firmList){
			GridJSONResponse jsonResponse = new GridJSONResponse();
			List<Object[]> aaData = new ArrayList();
			if(firmList.size()>0){
				for(PartyDTO partyDTO: firmList){
					Object[] objects = new Object[7];
					 objects[0] = partyDTO.getId();
					 objects[1] = partyDTO.getName();
					 objects[2] = partyDTO.getOfficeNumber();
					 objects[3] = partyDTO.getHomeNumber();
					 objects[4] = partyDTO.getEmailAddress();
					 objects[5] = partyDTO.getStatus();
					 objects[6] = "<a href='javascript:editAdmin(" + partyDTO.getId() + ")'>edit</a>";
					 aaData.add(objects);
				}
				 jsonResponse.setAaData(aaData);
				 jsonResponse.setiTotalRecords(10);
			}
			return jsonResponse;	
		}
	 
	public static LocationDTO getLocationDTO(PartySite partySite) {
		LocationDTO dto = new LocationDTO();
		dto.setId(partySite.getId());
		dto.setPartySiteId(partySite.getId());
		dto.setName(partySite.getName());
		dto.setLocationType(partySite.getPartySiteType().getName());
		dto.setPartyName(partySite.getParty().getName());

		CommunicationDTO commDTO = populateCommunciationDTO(partySite);
		dto.setCommunicationDTO(commDTO);

		if (partySite.activeFlag == true) {
			dto.setStatus("Active");
		} else {
			dto.setStatus("Inactive");
		}

		return dto;
	}

	public static CommunicationDTO populateCommunciationDTO(PartySite partySite) {
		CommunicationDTO dto = new CommunicationDTO();
		PointOfContact pointOfContact = partySite.getDefaultPointOfContact();

		if (pointOfContact.getEmailList().size() > 0) {
			EmailCommunication email = pointOfContact.getEmailList().get(0);
			dto.setEmailAddress(email.getContactDetail());
		}

		if (pointOfContact.getFaxList().size() > 0) {
			FaxCommunication fax = pointOfContact.getFaxList().get(0);
			dto.setFax(fax.getContactDetail());
		}

		if (pointOfContact.getWebUrlList().size() > 0) {
			WebCommunication web = pointOfContact.getWebUrlList().get(0);
			dto.setWebUrlList(web.getContactDetail());
		}

		List<PhoneCommunication> phoneList = pointOfContact.getPhoneList();

		if (phoneList.size() > 0) {
			for (PhoneCommunication phoneCommunication : phoneList) {
				if (PMConstants.OFFICE_PHONE.equals(
						phoneCommunication.getSubType())) {
					dto.setOfficeNumber(phoneCommunication.getContactDetail());
				} else if (PMConstants.MOBILE_PHONE.equals(
						phoneCommunication.getSubType())) {
					dto.setMobileNumber(phoneCommunication.getContactDetail());
				} else if (PMConstants.HOME_PHONE.equals(
						phoneCommunication.getSubType())) {
					dto.setHomeNumber(phoneCommunication.getContactDetail());
				} else if (PMConstants.OTHER_PHONE.equals(
						phoneCommunication.getSubType())) {
					dto.setOtherNumber(phoneCommunication.getContactDetail());
				}
			}
		}

		return dto;
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/allOfficeList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map getAllOfficeList(HttpServletRequest request, Long firmId, Long partyId) {
		logger.info("All Office List");

		Map<String, List<LocationDTO>> retMap = new HashMap();
		Party party = crmManager.getPartyById(partyId);
		List<PartySite> partySites = party.getPartySites();

		List<LocationDTO> partySiteDTOList = new ArrayList();

		for (PartySite partySite : partySites) {
			partySiteDTOList.add(getLocationDTO(partySite));
		}

		retMap.put("allOfficeList", partySiteDTOList);

		return retMap;
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/branchList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map branchList(HttpServletRequest request, Long firmId, Long partyId) {
		logger.info("Bank Branch List!");

		Map<String, List<LocationDTO>> retMap = new HashMap();
		Party party = crmManager.getPartyById(partyId);
		List<PartySite> partySites = party.getPartySites();

		List<LocationDTO> partySiteDTOList = new ArrayList();

		for (PartySite partySite : partySites) {
			if (PartySiteType.BRANCH_OFFICE_PARTY_SITE_TYPE.equals(
					partySite.getPartySiteType().getId()) ||
					PartySiteType.AGENCY_PARTY_SITE_TYPE.equals(
							partySite.getPartySiteType().getId())) {
				partySiteDTOList.add(getLocationDTO(partySite));
			}
		}

		retMap.put("branchList", partySiteDTOList);

		return retMap;
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/mainBankList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map mainBankList(HttpServletRequest request) {
		logger.info("Main Bank List!");

		Long firmId = PMUtil.getFirmIdFromSession(request);

		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}

		Page page = PMUtil.populatePageObject(request);

		return getPartyList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_MAIN_BANK.getId(), page);
	}

	@RequestMapping(value = {"/client/mainClientList.do","/mobileclient/mobileStaffList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse mainClientList(HttpServletRequest request) {
		logger.info("Main Client List!");
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}
		Long clientId = Long.valueOf(request.getParameter("clientId"));
		String sEcho = request.getParameter("sEcho");
        GridJSONResponse jsonResponse = usingDataTabl(request, firmId);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	private GridJSONResponse usingDataTabl(HttpServletRequest request, Long firmId){
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	Long clientId = Long.valueOf(request.getParameter("clientId"));
    	
    	Integer relationshipType = RelationshipType.RELATIONSHIP_TYPE_CLIENT_STAFF.getId();
		StaffSearch command = GridUtil.setFilterParameterForStaff(request);
		command.setRelationshipTypeId(relationshipType);
		command.setClientId(clientId);
		command.setActiveFlag(true);
		Long count = gridService.getStaffCountById(command);
		command.setCount(count.intValue());
		command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	List<PersonDTO> personList = gridService.getPersonDTOListById(command);
    	
    	GridJSONResponse jsonResponse = prepareResponses(personList, clientId);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        return jsonResponse;
	}
	
	public GridJSONResponse prepareResponses(List<PersonDTO> personList,Long clientId){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(personList.size()>0){
			for(PersonDTO personDTO: personList){
				Object[] objects = new Object[7];
				objects[0] = personDTO.getPartyId();
				objects[1] = personDTO.getName();
				objects[2] = personDTO.getJobTitle();
				objects[3] = personDTO.getOfficeNumber();
				objects[4] = personDTO.getHomeNumber();
				objects[5] = personDTO.getEmailAddress();
				//objects[6] = "<a class='javascript:colorBoxDemoStaff cboxElement' href='clientStaffColor.do?clientId=" + clientId + "&id="+personDTO.getPartyId()+"'>edit</a>";
				objects[6] = "<a href='javascript:StaffEdit(" + personDTO.getPartyId() + ")'>edit</a>";
				aaData.add(objects);									
			}
		}
		jsonResponse.setAaData(aaData);
		//jsonResponse.setiTotalRecords(10);
		return jsonResponse;
	}
	@RequestMapping(value = "/mainStaffList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map mainStaffList(HttpServletRequest request) {
		logger.info("Main Staff List!");

		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Page page = PMUtil.populatePageObject(request);

		return getPersonList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_STAFF.getId(), page);
	}

	@RequestMapping(value = "/mainPartnerList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map mainPartnerList(HttpServletRequest request) {
		logger.info("Main Partner List!");

		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Page page = PMUtil.populatePageObject(request);

		return getPartnerList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId(), page);
	}

	@RequestMapping(value = "/appadmin/mainEmployeeList.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse mainEmployeeList(HttpServletRequest request) {
		 logger.info("Manage Tax List!!");
	        String start = request.getParameter("iDisplayStart");
	    	String pageSize = request.getParameter("iDisplayLength");
	    	String sortColumn = request.getParameter("iSortCol_0");
	    	String order = request.getParameter("sSortDir_0");
	    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
	    	
		Long firmId = Long.valueOf(request.getParameter("newfirmId"));
		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}
		Long count = null;
		EmployeeSearch command = GridUtil.setFilterParameterForFirmEmployee(request);
		command.setFirmId(firmId);
		Integer staffTypeId = PersonType.PERSON_TYPE_STAFF.getId();
		Integer partnerTypeId = PersonType.PERSON_TYPE_PARTNER.getId();
		Integer firmAdminTypeId = PersonType.PERSON_TYPE_FIRM_ADMIN.getId();
		command.setStaffTypeId(staffTypeId);
		command.setPartnerTypeId(partnerTypeId);
		command.setFirmAdminTypeId(firmAdminTypeId);
		count = gridService.getStaffListCount(command);
		command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	String sEcho = request.getParameter("sEcho");
		List<PersonDTO> firmStaffList = gridService.getStaffList(command);
		for (PersonDTO personDTO :firmStaffList) {
			if(personDTO.getActiveFlag() == true){
				personDTO.setStatus("Active");
			}else{
				personDTO.setStatus("Deactive");
			}

		}
		GridJSONResponse jsonResponse = prepareRes(firmStaffList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
		/*populateReturnMapWithPageDatails(retMap, firmStaffList, page);
		return retMap;*/
	}

	public static GridJSONResponse prepareRes(List<PersonDTO> firmStaffList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(firmStaffList.size()>0){
			for(PersonDTO personDTO: firmStaffList){
				Object[] objects = new Object[8];
				 objects[0] = personDTO.getPartyId();
				 objects[1] = personDTO.getName();
				 objects[2] = personDTO.getJobTitle();
				 objects[3] = personDTO.getRole();
				 objects[4] = personDTO.getRelationshipType();
				 objects[5] = personDTO.getEmailAddress();
				 objects[6] = personDTO.getStatus();
				 objects[7] =  "<a href='javascript:EmpEdit(" + personDTO.getPartyId() + ")'>edit</a>";;
				 aaData.add(objects);
			}
		}
		 jsonResponse.setAaData(aaData);
		 jsonResponse.setiTotalRecords(10);

		return jsonResponse;	
	}
	
	@RequestMapping(value = "/firmadmin/manageFirmStaffList.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse manageFirmStaffList(HttpServletRequest request) {
		logger.info("Main Partner List!");
		Long firmId = PMUtil.getFirmIdFromSession(request);
		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}
		String sEcho = request.getParameter("sEcho");
        GridJSONResponse jsonResponse = usingDataTables(request, firmId);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	private GridJSONResponse usingDataTables(HttpServletRequest request, Long firmId){
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	
    	Integer relationshipTypeId = RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId();
    	FirmStaffSearch command = GridUtil.prepareFirmAdminFirmStaffList(request);
    	command.setFirmId(firmId);
		command.setStaffTypeId(PersonType.PERSON_TYPE_STAFF.getId());
		command.setPartnerTypeId(PersonType.PERSON_TYPE_PARTNER.getId());
		command.setActiveFlag(true);
    	Long count = gridService.getFirmStaffListCount(command);
    	command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	List<PersonDTO> firmStaffList = gridService.getFirmStaffList(command);
    	
    	GridJSONResponse jsonResponse = prepareRespond(firmStaffList);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        return jsonResponse;
	}
	public static GridJSONResponse prepareRespond(List<PersonDTO> firmStaffList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(firmStaffList.size()>0){
			for(PersonDTO personDTO: firmStaffList){
				Object[] objects = new Object[8];
				 objects[0] = personDTO.getPartyId();
				 objects[1] = personDTO.getName();
				 objects[2] = personDTO.getJobTitle();
				 objects[3] = personDTO.getRole();
				 objects[4] = personDTO.getRelationshipType();
				 objects[5] = personDTO.getEmailAddress();
				 if(personDTO.getActiveFlag() == true)
				 {
					 personDTO.setStatus("Active");
					 
				 }else
				 {
					 personDTO.setStatus("Inactive");
				 }
				 objects[6] = personDTO.getStatus();
				 objects[7] =  "<a href='javascript:editFirmStaff(" + personDTO.getPartyId() + ")'>edit</a>";;
				 aaData.add(objects);
			}
		}
		 jsonResponse.setAaData(aaData);
		 //jsonResponse.setiTotalRecords(10);
		return jsonResponse;	
	}
	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/lawFirmList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map lawFirmList(HttpServletRequest request) {
		logger.info("lawFirmList!");

		//		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Long firmId = PMUtil.getFirmIdFromSession(request);

		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}

		Page page = PMUtil.populatePageObject(request);

		return getPartyList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_LAW_FIRM.getId(), page);
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/transferAgentFirmList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map transferAgentFirmList(HttpServletRequest request) {
		logger.info("transferAgentFirmList!");

		//		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Long firmId = PMUtil.getFirmIdFromSession(request);

		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}

		Page page = PMUtil.populatePageObject(request);

		return getPartyList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_TRANSFER_AGENT_FIRM.getId(), page);
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/insuranceFirmList.do", method = RequestMethod.GET)
	public @ResponseBody
	Map insuranceFirmList(HttpServletRequest request) {
		logger.info("Insurance Firm List!");

		//		Long firmId = Long.valueOf(request.getParameter("firmId"));
		Long firmId = PMUtil.getFirmIdFromSession(request);

		if (!request.getRequestURI().contains("/appadmin/adminFirmModule.do") &&
				(firmId == null)) {
			throw new RuntimeException("firmId can not be empty");
		}

		Page page = PMUtil.populatePageObject(request);

		return getPartyList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_INSURANCE_FIRM.getId(), page);
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = {"/client/clientAjaxList.do","/mobileclient/mobileClientList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getClientAjaxList(HttpServletRequest request) {
		logger.info("Client List!");
		HttpSession session = request.getSession(false);
		PartyDTO firm = (PartyDTO) session.getAttribute("firm");
		Long firmId = (firm != null) ? firm.getId() : null;
		String sEcho = request.getParameter("sEcho");
        GridJSONResponse jsonResponse = usingDataTable(request, firmId);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	private GridJSONResponse usingDataTable(HttpServletRequest request, Long firmId){
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	
    	Integer relationshipTypeId = RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId();
    //	SearchCommand command = GridUtil.setFilterParameterForClient(request);
    	SearchCommand command = new SearchCommand();
    	command.setMainPartyId(firmId);
    	command.setRelationshipTypeId(relationshipTypeId);
    	command.setActiveFlag(true);
    	Long count = gridService.getRelatedPartiesCountById(command);
    	command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	List<PartyDTO> clientList = gridService.getPartyDTOListById(command);
    	
    	GridJSONResponse jsonResponse = prepareResponse(clientList);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        return jsonResponse;
	}
	
	public static GridJSONResponse prepareResponse(List<PartyDTO> clientList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(clientList.size()>0){
			for(PartyDTO partyDTO: clientList){
				Object[] objects = new Object[7];
				 objects[0] = partyDTO.getPartyId();
				 objects[1] = partyDTO.getName();
				 objects[2] = partyDTO.getInChargePerson();
				 objects[3] = partyDTO.getOfficeNumber();
				 objects[4] = partyDTO.getEmailAddress();
				 objects[5] = "<a href='javascript:editClient(" + partyDTO.getPartyId() + ")'>edit</a>";
				 objects[6] = "<a href='javascript:manageClient(" + partyDTO.getPartyId() + ")'>Manage</a>";
				 
				 aaData.add(objects);
			}
		}
    	 jsonResponse.setAaData(aaData);
		jsonResponse.setiTotalRecords(10);
		return jsonResponse;	
	}
	@RequestMapping(value = "/client/mobileClientAjaxList.do", method = RequestMethod.GET)
	public @ResponseBody
	List<PartyDTO> getMobileClientAjaxList(HttpServletRequest request) {
		logger.info("Client List!");
		String strt = request.getParameter("start");
		int start = Integer.parseInt(strt);
		String lmt = request.getParameter("limit");
		int limit = Integer.parseInt(lmt);
		HttpSession session = request.getSession(false);
		PartyDTO firm = (PartyDTO) session.getAttribute("firm");
		Long firmId = (firm != null) ? firm.getId() : null;
		return getPartyList(firmId,
				RelationshipType.RELATIONSHIP_TYPE_CLIENT.getId(),start, limit);

	}
	
	
	@RequestMapping(value = "/appadmin/mobileAjaxSaveFirm.do", method = RequestMethod.POST)
	public
	String getMobileFirmSave(HttpServletRequest request) {
		String name = request.getParameter("firmname");
		System.out.println("param pass"+name);
		return "Save";
		
	}
	
	@RequestMapping(value = "/client/mobileCodeList.do", method = RequestMethod.GET)
	public @ResponseBody
	List<CodeDTO> getCodeList(HttpServletRequest request) {
		Map retMap = new HashMap();
		Long count = null;
		//Page page = PMUtil.populatePageObject(request);
		String strt = request.getParameter("start");
		int start = Integer.parseInt(strt);
		String lmt = request.getParameter("limit");
		int limit = Integer.parseInt(lmt);
		//if(page != null){
			count = crmManager.getCodeListCount();
	//		PMUtil.adjustPagination(page, count.intValue());
	//		page.setCount(count.intValue());
	//	}
		/*List<CodeDTO> codeList =crmManager.getCodeDTOList(count);
		for (CodeDTO codeDTO : codeList) {
			if(codeDTO.getActiveFlag() == true){
				codeDTO.setStatus("Active");
			}else{
				codeDTO.setStatus("InActive");
			}
			if(codeDTO.getApplicationLevelIndicator() == true){
				codeDTO.setStrApplicationLevelIndicator("Yes");
			}else{
				codeDTO.setStrApplicationLevelIndicator("No");
			}
		}*/


		return getCodeDTOList(start, limit);
	}
	
    @RequestMapping(value = "/client/mobileAdminCode.do", method = RequestMethod.GET)
    public List<CodeType> getManageCodeDropdown(HttpServletRequest request, ModelMap model, @ModelAttribute("code")
        Code code, Long id) {
        logger.info("Get Manage Code!");
        PMUtil.showStatusMessage(request, model);
        Long firmId = PMUtil.getFirmIdFromSession(request);
        List<CodeType> codeTypeSet = crmManager.getCodeTypeListDropdown();    
        return codeTypeSet;
    }
    
	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = {"/client/partyList.do","/mobileclient/mobilePartyList.do"}, method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse partyList(HttpServletRequest request) {
		logger.info("Party List!");
		logger.info("Manage Tax List!!");
        String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
    	
		Long mainPartyId = Long.valueOf(request.getParameter("mainParty"));
		Integer relationshipTypeId = Integer.valueOf(request.getParameter(
		"relation"));
		Long count = null;
		OfficerShareholderSearch command = GridUtil.setFilterParameterForOfficers(request);
		command.setMainPartyId(mainPartyId);
		command.setRelationshipTypeId(relationshipTypeId);
		count = gridService.getOfficersAndShareHoldersListCount(command);
		command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	
    	String sEcho = request.getParameter("sEcho");
		//List<PartyDTO> partyList =crmManager.getOfficersAndShareHoldersList(mainPartyId,relationshipTypeId, count);
    	List<PartyDTO> partyList =gridService.getOfficersAndShareHoldersList(command);
    	GridJSONResponse jsonResponse = prepareResponserss(partyList,mainPartyId);
        jsonResponse.setiTotalDisplayRecords(count);
        jsonResponse.setiTotalRecords(count);
        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}

	public static GridJSONResponse prepareResponserss(List<PartyDTO> partyList, Long mainPartyId){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(partyList.size()>0){
			
			for(PartyDTO partyDTO: partyList){
				Object[] objects = new Object[5];
				 objects[0] = partyDTO.getId();
				 objects[1] = partyDTO.getName();
				 objects[2] = partyDTO.getTypeOfShare();
				 objects[3] = partyDTO.getBigIntNoOfSharesOwned();
				 //objects[4] = "<a class='javascript:colorBoxDemoOff cboxElement' href='clientOfficersAndShareHoldersCol.do?clientId="+mainPartyId+"&id="+partyDTO.getId()+"'>edit</a>";
				 objects[4] = "<a href='javascript:OfficerEdit(" + partyDTO.getId() + ")'>edit</a>";
				 aaData.add(objects);
			}
		}
		 jsonResponse.setAaData(aaData);
		 //jsonResponse.setiTotalRecords(10);
		return jsonResponse;	
	}
	private Map getPersonList(Long mainPartyId, Integer relationshipTypeId,
			Page page) {
		Map retMap = new HashMap();

		if (page != null) {
			Long count = crmManager.getRelatedPartiesCountById(mainPartyId,
					relationshipTypeId);
			PMUtil.adjustPagination(page, count.intValue());
			page.setCount(count.intValue());
		}

		List<Party> partyListFromDB = crmManager.getRelatedPartiesById(mainPartyId,
				relationshipTypeId, page);

		List<PersonDTO> personList = new ArrayList();

		for (Party party : partyListFromDB) {
			if (party.activeFlag == true) {
				personList.add(PMUtil.getPartnerDTO(party));
			}
		}

		populateReturnMapWithPageDatails(retMap, personList, page);

		return retMap;
	}

	private Map getPartnerList(Long mainPartyId, Integer relationshipTypeId,
			Page page) {
		Map retMap = new HashMap();

		if (page != null) {
			Long count = crmManager.getRelatedPartiesCountById(mainPartyId,
					relationshipTypeId);
			PMUtil.adjustPagination(page, count.intValue());
			page.setCount(count.intValue());
		}

		List<Party> partyListFromDB = crmManager.getRelatedPartiesById(mainPartyId,
				relationshipTypeId, page);

		List<PersonDTO> personList = new ArrayList();

		for (Party party : partyListFromDB) {
			personList.add(PMUtil.getPartnerDTO(party));
		}

		populateReturnMapWithPageDatails(retMap, personList, page);

		return retMap;
	}

	private Map getPartyList(Long mainPartyId, Integer relationshipTypeId,
			Page page) {
		Map retMap = new HashMap();
		Long count = null;

		/*if(page != null){
        	count = crmManager.getRelatedPartiesCountById(mainPartyId,relationshipTypeId);
            PMUtil.adjustPagination(page, count.intValue());
            page.setCount(count.intValue());
        }

        List<PartyDTO> partyList = crmManager.getPartyDTOListById(mainPartyId,relationshipTypeId,page);*/

		SearchCommand command = GridUtil.prepareSearchCommand(page.getFilters());
		command.setActiveFlag(true);
		command.setMainPartyId(mainPartyId);
		command.setRelationshipTypeId(relationshipTypeId);
		//count = crmManager.getRelatedPartiesCountById(mainPartyId,relationshipTypeId);
		count = gridService.getRelatedPartiesCountById(command);
		System.out.println(count);
		PMUtil.adjustPagination(page, count.intValue());
		page.setCount(count.intValue());
		command.setCurrentPage(page.getCurrentPage());
		command.setLimit(page.getLimit());
		command.setSortName(page.getSortName());
		command.setSortType(page.getSortType());
		command.setCount(page.getCount());
		command.setTotalPages(page.getTotalPages());
		command.setOffset(page.getStart());

		//  List<PartyDTO> partyList = crmManager.getPartyDTOListById(mainPartyId,relationshipTypeId,page);
		List<PartyDTO> partyList = gridService.getPartyDTOListById(command);

		populateReturnMapWithPageDatails(retMap, partyList, page);

		return retMap;
	}

	private List<PartyDTO> getPartyList(Long mainPartyId, Integer relationshipTypeId, int start, int limit) {
		// Map retMap = new HashMap();

		List<PartyDTO> partyList = crmManager.getMobilePartyDTOListById(mainPartyId,relationshipTypeId,start, limit);

		return partyList;
	}

	private List<CodeDTO> getCodeDTOList(int start, int limit) {
		// Map retMap = new HashMap();

		List<CodeDTO> codeList = crmManager.getCodeDTOList(start, limit);

		return codeList;
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


	public PersonDTO getPartnerDTO(Party party) {
		PersonDTO dto = new PersonDTO();
		dto.setPartyId(party.getId());

		if (party.getPerson() != null) {
			Person person = party.getPerson();
			dto.setFirstName(person.getFirstName());
			dto.setLastName(person.getLastName());
			dto.setDateOfBirth(person.getDateOfBirth());

			PersonDetails details = person.getPersonDetails();

			if (details != null) {
				dto.setAnnualCompensation(details.getAnnualCompensation());

				if (details.getCodeByJobTitleCode() != null) {
					dto.setJobTitle(details.getCodeByJobTitleCode()
							.getShortName());
				} else {
					dto.setJobTitle(details.getJobTitle());
				}

				dto.setComittee(details.getComittee());
				dto.setIsStaff(details.getIsStaff());
				dto.setIsDirector(details.getIsDirector());
			}
		}

		return dto;
	}

	private Map getFirmList(Long mainPartyId, Integer partyTypeId, Page page) {
		Map retMap = new HashMap();
		Long count = null;

		FirmSearch command = GridUtil.prepareFirmSearchCommand(page.getFilters());
		command.setPartyTypeId(partyTypeId);
		command.setOrganizationTypeId(OrganizationType.ORGANIZATION_TYPE_FIRM.id);
		count = gridService.getFirmsCountById(command);
		//count = crmManager.getFirmsCountById(partyTypeId,OrganizationType.ORGANIZATION_TYPE_FIRM.id);
		PMUtil.adjustPagination(page, count.intValue());
		page.setCount(count.intValue());
		command.setCurrentPage(page.getCurrentPage());
		command.setLimit(page.getLimit());
		command.setSortName(page.getSortName());
		command.setSortType(page.getSortType());
		command.setCount(page.getCount());
		command.setTotalPages(page.getTotalPages());
		command.setOffset(page.getStart());     
		List<PartyDTO> firmList = gridService.getFirmsListById(command);
		//   List<PartyDTO> firmList = crmManager.getFirmsListById(partyTypeId, OrganizationType.ORGANIZATION_TYPE_FIRM.id, count);
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

	// Added by Savitri
	public PartyDTO getFirmDTO(long partyId) {
		PartyDTO dto = new PartyDTO();
		dto.setPartyId(partyId);

		Party party = crmManager.getPartyById((long) partyId);

		if (party.getOrganization() != null) {
			Organization org = party.getOrganization();

			if (OrganizationType.ORGANIZATION_TYPE_FIRM.equals(
					org.getOrganizationType())) {
				org.setLegalName(party.getName());
				dto.setName(party.getName());

				if (party.getPartySites().size() > 0) {
					PartySite partySite = party.getPartySites().get(0);
					CommunicationDTO commDTO = PMUtil.populateCommunciationDTO(partySite);
					dto.setCommunicationDTO(commDTO);
				}
			}

			if (party.activeFlag == true) {
				dto.setStatus("Active");
			} else {
				dto.setStatus("Inactive");
			}
		}

		return dto;
	}

	@RequestMapping(value = "/appadmin/taskNotificationTemplateList.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getTaskNotificationTemplates(HttpServletRequest request, Long clientId,
			Long partyId) {
	    	 String start = request.getParameter("iDisplayStart");
	    	String pageSize = request.getParameter("iDisplayLength");
	    	String sortColumn = request.getParameter("iSortCol_0");
	    	String order = request.getParameter("sSortDir_0");
	    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
		Long count = null;
		TaskNotificationTemplateSearch command = GridUtil.setTemplateFilterParameters(request);
		count =gridService.getTaskNotificationTemplateListCount(command);
		command.setCount(count.intValue());
	    command.setLimit(Integer.parseInt(pageSize));
	    command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
	    String sEcho = request.getParameter("sEcho");
	    List<TaskNotificationTemplateDTO> taskNotificationTemplateList = gridService.getTaskNotificationTemplateDTOList(command);
		for(TaskNotificationTemplateDTO taskNotificationTemplateDTO:taskNotificationTemplateList ){
			if(taskNotificationTemplateDTO.getActiveFlag()==true){
				taskNotificationTemplateDTO .setStatus("Active");
			}else
				taskNotificationTemplateDTO.setStatus("Inactive");
		}
		/*populateReturnMapWithPageDatails(retMap, taskNotificationTemplateList, page);
		return retMap;*/
		GridJSONResponse jsonResponse = prepareResponsers(taskNotificationTemplateList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
	}
	
	public static GridJSONResponse prepareResponsers(List<TaskNotificationTemplateDTO> taskNotificationTemplateList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(taskNotificationTemplateList.size()>0){
			//int index = 1;
			//List<Object[]> aaData = new ArrayList();
			for(TaskNotificationTemplateDTO taskNotificationTemplateDTO:taskNotificationTemplateList){
				Object[] objects = new Object[6];
				 objects[0] = taskNotificationTemplateDTO.getId();
				 objects[1] = taskNotificationTemplateDTO.getSubject();
				 objects[2] = taskNotificationTemplateDTO.getBodyText();
				 objects[3] = taskNotificationTemplateDTO.getAdminEmailId();
				 objects[4] = taskNotificationTemplateDTO.getStatus();
				 objects[5] = "<a href='javascript:editTemplate(" + taskNotificationTemplateDTO.getId() + ")'>edit</a>";
				 aaData.add(objects);
				// index++;
			}
			 jsonResponse.setAaData(aaData);
			 jsonResponse.setiTotalRecords(10);
		}
		return jsonResponse;	
	}

	private TaskNotificationTemplateDTO getTaskNotificationTemplateDTO(
			TaskNotificationTemplate taskNotificationTemplate) {
		TaskNotificationTemplateDTO dto = new TaskNotificationTemplateDTO();
		dto.setId(taskNotificationTemplate.getId());
		dto.setSubject(taskNotificationTemplate.getSubject());
		dto.setBodyText(taskNotificationTemplate.getBodyText());
		dto.setAdminEmailId(taskNotificationTemplate.getAdminEmailId());

		if (taskNotificationTemplate.activeFlag == null) {
			taskNotificationTemplate.setActiveFlag(false);
		}

		if (taskNotificationTemplate.activeFlag == true) {
			dto.setStatus("Active");
		} else {
			dto.setStatus("Inactive");
		}

		return dto;
	}

	@RequestMapping(value = "/appadmin/taskNotificationRecipientList.do", method = RequestMethod.GET)
	public @ResponseBody
	GridJSONResponse getTaskNotificationRecipient(HttpServletRequest request, Long clientId,
			Long partyId) {
		Long count = null;
		String start = request.getParameter("iDisplayStart");
    	String pageSize = request.getParameter("iDisplayLength");
    	String sortColumn = request.getParameter("iSortCol_0");
    	String order = request.getParameter("sSortDir_0");
    	logger.debug("start = "+start+"; pageSize = "+pageSize+"; sortColumn = "+sortColumn+"; order = "+order);
	//	TaskNotificationRecipientSearch command = new TaskNotificationRecipientSearch();
    	TaskNotificationRecipientSearch command = GridUtil.setReceipientFilterParameter(request);
		//command.setFirmId(firmId);
        count = gridService.getTaskNotificationRecipientListCount(command);	
        command.setCount(count.intValue());
    	command.setLimit(Integer.parseInt(pageSize));
    	command.setOffset((Integer.parseInt(start) / Integer.parseInt(pageSize)) * Integer.parseInt(pageSize));
    	
		List<TaskNotificationRecipientDTO> taskNotificationRecipientList = gridService.getTaskNotificationRecipientDTOList(command);
		for (TaskNotificationRecipientDTO taskNotificationRecipientDTO : taskNotificationRecipientList) {
			if(taskNotificationRecipientDTO.getActiveFlag() != null){
				if(taskNotificationRecipientDTO.getActiveFlag() == true){
					taskNotificationRecipientDTO.setStatus("Active");
				}else{
					taskNotificationRecipientDTO.setStatus("Inactive");
			}
			}
		}
		String sEcho = request.getParameter("sEcho");
		GridJSONResponse jsonResponse = prepareResponsee(taskNotificationRecipientList);
        jsonResponse.setiTotalDisplayRecords(count);

        jsonResponse.setsEcho(sEcho);
        return jsonResponse;
		/*populateReturnMapWithPageDatails(retMap, taskNotificationRecipientList,page);

		return retMap;*/
	}
	
	public static GridJSONResponse prepareResponsee(List<TaskNotificationRecipientDTO> taskNotificationRecipientList){
		GridJSONResponse jsonResponse = new GridJSONResponse();
		List<Object[]> aaData = new ArrayList();
		if(taskNotificationRecipientList.size()>0){
			//int index = 1;
			//List<Object[]> aaData = new ArrayList();
			for(TaskNotificationRecipientDTO taskNotificationRecipientDTO : taskNotificationRecipientList){
				Object[] objects = new Object[6];
				 objects[0] = taskNotificationRecipientDTO.getId();
				 objects[1] = taskNotificationRecipientDTO.getRecipient();
				 objects[2] = taskNotificationRecipientDTO.getEmailType();
				 objects[3] = taskNotificationRecipientDTO.getTypeOfNotificationTemplate();
				 objects[4] = taskNotificationRecipientDTO.getStatus();
				 objects[5] = "<a href='javascript:editRecepient(" + taskNotificationRecipientDTO.getId() + ")'>edit</a>";
				 aaData.add(objects);
				// index++;
			}
			 jsonResponse.setAaData(aaData);
			 jsonResponse.setiTotalRecords(10);
		}
		return jsonResponse;	
	}

	private TaskNotificationRecipientDTO getTaskNotificationRecipientDTO(
			TaskNotificationRecipient taskNotificationRecipient) {
		TaskNotificationRecipientDTO dto = new TaskNotificationRecipientDTO();
		dto.setId(taskNotificationRecipient.getId());
		dto.setRecipient(taskNotificationRecipient.getRecipient());
		dto.setTypeOfNotificationTemplate(taskNotificationRecipient.getNotificationTemplateId()
				.getSubject());
		dto.setEmailType(taskNotificationRecipient.getEmailType());

		if (taskNotificationRecipient.activeFlag == null) {
			taskNotificationRecipient.setActiveFlag(false);
		}

		if (taskNotificationRecipient.activeFlag == true) {
			dto.setStatus("Active");
		} else {
			dto.setStatus("Inactive");
		}

		return dto;
	}

	/**
	 * Simply selects the welcome view to render by returning void and relying
	 * on the default request-to-view-translator.
	 */
	@RequestMapping(value = "/client/clientList.do", method = RequestMethod.GET)
	public String clientList(HttpServletRequest request, 
			ModelMap model, Party party) {


		Long firmId = PMUtil.getFirmIdFromSession(request);

		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpSession session = httpReq.getSession(false);

		if (session.getAttribute("inValidClientId")!=null) {
			session.setAttribute("clientPartyName", "");
		} 
		return "clientList.jsp";
	}

	@RequestMapping(value = "/home/clientNewList.do", method = RequestMethod.GET)
	public String clientNewList(HttpServletRequest request, 
			ModelMap model) {
		return "Jqgrid";
	}

	@RequestMapping(value="/client/mainClient.do", method=RequestMethod.GET)
	public String mainClient(HttpServletRequest request,ModelMap model){
			return "mainClient.tilesView";
	}
	
	@RequestMapping(value="/mobileclient/mainMobileClient.do", method=RequestMethod.GET)
	public String mainMobileClient(HttpServletRequest request,ModelMap model){
			return "mainMobileClient.tilesView";
	}
	
	@RequestMapping(value="/mobileadmin/mobileadminTaskNotificationTemplateHome.do", method=RequestMethod.GET)
	public String mainMobileTemplate(HttpServletRequest request,ModelMap model){
			return "mainMobileTemplateList.tilesView";
	}
	
	@RequestMapping(value="/mobileadmin/mobileadminTaskNotificationRecipientHome.do", method=RequestMethod.GET)
	public String mainMobileRecipient(HttpServletRequest request,ModelMap model){
			return "mainMobileRecipientList.tilesView";
	}
	
	@RequestMapping(value="/mobileadmin/mobileadminCodeTypeHome.do", method=RequestMethod.GET)
	public String mainMobileCodeType(HttpServletRequest request,ModelMap model){
			return "mainMobileCodeTypeList.tilesView";
	}
	
	@RequestMapping(value = "/client/clientListPage.do", method = RequestMethod.GET)
	public String clientList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client List!");
		return "client/clientList";
	}

	@RequestMapping(value = "/client/clientBankList.do", method = RequestMethod.GET)
	public String clientBankList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client bank List!");
		return "client/clientBankList";
	}

	@RequestMapping(value = "/client/clientEdit.do", method = RequestMethod.GET)
	public String clientEdit(HttpServletRequest request, ModelMap model) {
		logger.info("Get Customer Summary List!");
		return "client/clientDetail";
	}

	@RequestMapping(value = "/client/clientStaffList.do", method = RequestMethod.GET)
	public String clientStaffList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client Staff List!");
		return "client/clientStaffList";
	}

	@RequestMapping(value = "/client/clientLocList.do", method = RequestMethod.GET)
	public String clientLocationList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client Location List!");
		return "client/clientLocList";
	}

	@RequestMapping(value = "/client/clientTAList.do", method = RequestMethod.GET)
	public String clientTAList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client Transfer Agent List!");
		return "client/clientTransferAgentList";
	}

	@RequestMapping(value = "/client/clientOfficersList.do", method = RequestMethod.GET)
	public String clientOfficersList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client officers!");
		return "client/ClientOfficersAndShareHolderList";
	}

	@RequestMapping(value = "/client/clientINList.do", method = RequestMethod.GET)
	public String clientINList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client Insurances List!");
		return "client/clientInsList";
	}
	@RequestMapping(value = "/client/clientLawyersList.do", method = RequestMethod.GET)
	public String clientLawList(HttpServletRequest request, ModelMap model) {
		logger.info("Get client lawyers List!");
		return "client/clientLawList";
	}
	@RequestMapping(value = "/saveLanguage.do", method = RequestMethod.GET)
	public @ResponseBody
	Map langSelect(HttpServletRequest request, HttpServletResponse response,String newLanguage) {
		logger.info("Change Language Save!");
		Map retMap = new HashMap();
		SecurityContext context = SecurityContextHolder.getContext();
		PMUser loggedInUser = null;
		loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
		String username=loggedInUser.getUsername();
		crmManager.changeLanguage(newLanguage,username);
		//String lang = crmManager.getLanguageStr(newuser);
		retMap.put("id", "1");
		HttpSession session = request.getSession();
		session.setAttribute("lang", null);
		Locale locale = Locale.getDefault();
		System.out.println("Before setting, Locale is = " + locale);
		Locale newLocale = new Locale(newLanguage);
		Locale.setDefault(newLocale);
		System.out.println("After setting, Locale is = " + newLocale);
		return retMap;
	}

	@RequestMapping(value = "/changePassword.do", method = RequestMethod.GET)
	public @ResponseBody
	Map saveUserProfile(HttpServletRequest request, HttpServletResponse response,String newPassword, String oldPassword){
		logger.info("Change Password Save!");
		HttpSession session1 = request.getSession();
		//System.out.println("session:" +session1);
		Map retMap = new HashMap();
		SecurityContext context = SecurityContextHolder.getContext();
		PMUser loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
		String username=loggedInUser.getUsername();
		//System.out.println("user: " +username);
		String encryptedOldPassword = EncryptionUtil.getInstance().encrypt(oldPassword);
		String dbPassword = userService.getPassword(username);
		if(encryptedOldPassword.equals(dbPassword)){
			String encryptedNewPassword = EncryptionUtil.getInstance().encrypt(newPassword);
			userService.changePassword(encryptedOldPassword, encryptedNewPassword);
			retMap.put("id", "1");
		}else{
			retMap.put("id", "0");
		}
		return retMap;
	}
}
