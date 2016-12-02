package com.chiguru.pm.crm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.dto.AccountSearch;
import com.chiguru.pm.crm.dto.CodeSearch;
import com.chiguru.pm.crm.dto.CodeTypeSearch;
import com.chiguru.pm.crm.dto.DocumentSerach;
import com.chiguru.pm.crm.dto.EmployeeSearch;
import com.chiguru.pm.crm.dto.FirmSearch;
import com.chiguru.pm.crm.dto.FirmStaffSearch;
import com.chiguru.pm.crm.dto.JurisdictionSearch;
import com.chiguru.pm.crm.dto.LocationSearch;
import com.chiguru.pm.crm.dto.OfficerShareholderSearch;
import com.chiguru.pm.crm.dto.SearchCommand;
import com.chiguru.pm.crm.dto.StaffSearch;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientSearch;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateSearch;
import com.chiguru.pm.crm.dto.TaskSearchCommand;
import com.chiguru.pm.crm.dto.TaxSearch;

import org.springframework.util.*;
public class GridUtil {
	
	
	public static final String JQGRID_FIELD_IDENTIFIER = "\"field\":";
	public static final String DOUBLE_QUOTE_IDENTIFIER = "\"";
	public static int FIELD_NAME_NO = 0;
	public static int DATA_VALUE_FIELD = 4;

	public static List ingoreListForField = new ArrayList();
	static{
		
		ingoreListForField.add("{");
		ingoreListForField.add("groupOp");
		ingoreListForField.add("AND");
		ingoreListForField.add("rules");
		ingoreListForField.add(":");
		ingoreListForField.add(",");
		ingoreListForField.add("[");
		ingoreListForField.add(":[{");
		ingoreListForField.add("},{");
		ingoreListForField.add("");
		ingoreListForField.add("}]}");
	}
	 public final static Map<String, String> OPLIST = new HashMap<String, String>();
		
	 static{
		 OPLIST.put( "=", "eq"); // equal
			OPLIST.put( "<>", "ne");// not equal
			OPLIST.put( "<", "lt"); // less than
			OPLIST.put( "<=", "le");// less than or equal
			OPLIST.put( ">", "gt" ); // greater than
			OPLIST.put( ">=", "ge");// greater than or equal
			OPLIST.put("LIKE", "bw" ); // begins with
			OPLIST.put( "NOT LIKE", "bn"); // doesn"t begin with
			OPLIST.put( "LIKE", "in"); // is in
			OPLIST.put( "NOT LIKE", "ni"); // is not in
			OPLIST.put( "LIKE", "ew"); // ends with
			OPLIST.put( "NOT LIKE", "en"); // doesn"t end with
			OPLIST.put( "LIKE", "cn"); // contains
			OPLIST.put( "NOT LIKE", "nc"); // doesn"t contain
		
		}
	 public static DocumentSerach prepareDocumentSearch(String filters) {
		 DocumentSerach documentSearch = new DocumentSerach();
		 if(filters != null){
				String delims = JQGRID_FIELD_IDENTIFIER;
				String[] tokens = filters.split(delims);
					
				for(int i=0; i< tokens.length; i++){
					if(i== 0){
						continue;
					}
				
					String token = tokens[i];
					List fieldList = new ArrayList();
					String[] fields = token.split(DOUBLE_QUOTE_IDENTIFIER);
					for(int j=0; j< fields.length; j++){
						String tokenField = fields[j];
						if(! ingoreListForField.contains(tokenField)){
							fieldList.add(tokenField);
						}
					}
					if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
						String filedName = (String) fieldList.get(FIELD_NAME_NO);
					    String data = (String) fieldList.get(DATA_VALUE_FIELD);
					    if(filedName.equalsIgnoreCase("fileName")){
					    	documentSearch.setFileName(data);
						}else if(filedName.equalsIgnoreCase("clientName")){
							documentSearch.setClientName(data);
						}else if(filedName.equalsIgnoreCase("date")){
							documentSearch.setDate(data);
						}else if(filedName.equalsIgnoreCase("fileExtension")){
							documentSearch.setFileExtension(data);
						}else if(filedName.equalsIgnoreCase("to")){
							documentSearch.setTo(data);
						}else if(filedName.equalsIgnoreCase("clientId")){
							documentSearch.setClntId(data);
						}else if(filedName.equalsIgnoreCase("taskId")){
							documentSearch.setTskId(data);
						}else if(filedName.equalsIgnoreCase("dueDate")){
							documentSearch.setDueDate(data);
						}else if(filedName.equalsIgnoreCase("dueDateTo")){
							documentSearch.setDueDateTo(data);
						}else if(filedName.equalsIgnoreCase("author")){
							documentSearch.setAuthor(data);
						}else if(filedName.equalsIgnoreCase("docAuthor")){
							documentSearch.setDocAuthor(data);
						}
					}
				}
		 }
		 return documentSearch;
			 }
	 
	 public static SearchCommand prepareSearchCommand(String filter){
			SearchCommand command = new SearchCommand();
			
			if(filter != null){
				String delims = JQGRID_FIELD_IDENTIFIER;
				String[] tokens = filter.split(delims);
				
				for(int i=0; i< tokens.length; i++){
					//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
					if(i== 0){
						continue;
					}
				
					String token = tokens[i];
					System.out.println(token);
					
					extractField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
					}
				System.out.println("Command filter"+ command.getFilterList());
				
			}
			return command;
		}
	 
	 private static void extractField(String token, String filedDelim,  List ignoreList, SearchCommand command) {
			
			List fieldList = new ArrayList();
			String[] fields = token.split(filedDelim);
			for(int j=0; j< fields.length; j++){
				String tokenField = fields[j];
				if(! ignoreList.contains(tokenField)){
					fieldList.add(tokenField);
				}
			}
			
			if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
				String filedName = (String) fieldList.get(FIELD_NAME_NO);
				String data = (String) fieldList.get(DATA_VALUE_FIELD);
				if(filedName.equalsIgnoreCase("name")){
			    	command.setClientName(data);
				}else if(filedName.equalsIgnoreCase("emailAddress")){
					command.seteMail(data);
				}else if(filedName.equalsIgnoreCase("partyId")){
					command.setPartId(Long.parseLong(data));
				}else if(filedName.equalsIgnoreCase("inChargePerson")){
					command.setInChargePerson(data);
				}else if(filedName.equalsIgnoreCase("officeNumber")){
					command.setOfficeNumber(data);
				}
			}
	 }

	public static TaskSearchCommand prepareTaskSearchCommand(String filter) {
		TaskSearchCommand command = new TaskSearchCommand();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractTaskField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;
	}

	private static void extractTaskField(String token, String filedDelim,  List ignoreList, TaskSearchCommand command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("taskId")){
				command.setTaskId(Long.parseLong(data));
			}else if(filedName.equalsIgnoreCase("clientName")){
				command.setClientName(data);
			}else if(filedName.equalsIgnoreCase("practiceType")){
				command.setPracticeType(data);
			}else if(filedName.equalsIgnoreCase("filingType")){
				command.setFilingType(data);
				if(command.getFilingType().equalsIgnoreCase("Filing")){
					command.setFilingTypeFromDB((short) 1);
				}else{
					command.setFilingTypeFromDB((short) 2);
				}
			}else if(filedName.equalsIgnoreCase("formattedDueDate")){
				command.setFormattedDueDate(data);
				Date dueDate =  convertStrToDate(command.getFormattedDueDate());
				command.setDueDate(dueDate);
			}else if(filedName.equalsIgnoreCase("assignedTo")){
				command.setAssignedTo(data);
			}else if(filedName.equalsIgnoreCase("clientStaffInCharge")){
				command.setClientStaffInCharge(data);
			}else if(filedName.equalsIgnoreCase("taskType")){
				command.setTaskType(data);
			}else if(filedName.equalsIgnoreCase("status")){
				command.setStatus(data);
			}else if(filedName.equalsIgnoreCase("partnerInCharge")){
				command.setPartnerInCharge(data);
			}
		}
		
	}

	public static FirmStaffSearch prepareFirmStaffSearchCommand(String filter) {
		FirmStaffSearch command = new FirmStaffSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractFirmStaffField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractFirmStaffField(String token, String filedDelim,  List ignoreList, FirmStaffSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("name")){
				command.setName(data);
			}else if(filedName.equalsIgnoreCase("jobTitle")){
				command.setJobTitle(data);
			}else if(filedName.equalsIgnoreCase("role")){
				command.setRole(data);
			}else if(filedName.equalsIgnoreCase("relationshipType")){
				command.setRelationshipType(data);
			}else if(filedName.equalsIgnoreCase("emailAddress")){
				command.setEmailAddress(data);
			}else if(filedName.equalsIgnoreCase("status")){
				command.setStatus(data);
			}
		}
		
	}
	
	public static Date convertStrToDate(String fromTransCreateDate){
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date convertedDate = new Date();
		try {
			convertedDate = dateFormat.parse(fromTransCreateDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return convertedDate;
	}

	public static FirmSearch prepareFirmSearchCommand(String filter) {
		FirmSearch command = new FirmSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractFirmField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractFirmField(String token, String filedDelim,  List ignoreList, FirmSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("id")){
				command.setId(Long.parseLong(data));
			}else if(filedName.equalsIgnoreCase("name")){
				command.setName(data);
			}else if(filedName.equalsIgnoreCase("officeNumber")){
				command.setOfficeNumber(data);
			}else if(filedName.equalsIgnoreCase("homeNumber")){
				command.setHomeNumber(data);
			}else if(filedName.equalsIgnoreCase("emailAddress")){
				command.setEmailAddress(data);
			}
		}
		
	}

	public static AccountSearch prepareAccountSearchCommand(String filter) {
		AccountSearch command = new AccountSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractAccountField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractAccountField(String token, String filedDelim,  List ignoreList, AccountSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("newId")){
				command.setNewId(Long.parseLong(data));
			}else if(filedName.equalsIgnoreCase("accountFirmName")){
				command.setAccountFirmName(data);
			}else if(filedName.equalsIgnoreCase("accountType")){
				command.setAccountType(data);
			}else if(filedName.equalsIgnoreCase("accountNumber")){
				command.setAccountNumber(data);
			}else if(filedName.equalsIgnoreCase("contactName")){
				command.setContactName(data);
			}else if(filedName.equalsIgnoreCase("officeNumber")){
				command.setOfficeNumber(data);
			}else if(filedName.equalsIgnoreCase("emailAddress")){
				command.setEmailAddress(data);
			}
		}
		
	}

	public static LocationSearch prepareLocationSearchCommand(String filter) {
		LocationSearch command = new LocationSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractLocationField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractLocationField(String token, String filedDelim,  List ignoreList, LocationSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("partyName")){
				command.setPartyName(data);
			}else if(filedName.equalsIgnoreCase("name")){
				command.setName(data);
			}else if(filedName.equalsIgnoreCase("locationType")){
				command.setLocationType(data);
			}else if(filedName.equalsIgnoreCase("officeNumber")){
				command.setOfficeNumber(data);
			}else if(filedName.equalsIgnoreCase("homeNumber")){
				command.setHomeNumber(data);
			}else if(filedName.equalsIgnoreCase("emailAddress")){
				command.setEmailAddress(data);
			}
				
		}
		
	}

	public static StaffSearch prepareStaffSearchCommand(String filter) {
		StaffSearch command = new StaffSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractStaffField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractStaffField(String token, String filedDelim,  List ignoreList, StaffSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("name")){
				command.setName(data);
			}else if(filedName.equalsIgnoreCase("jobTitle")){
				command.setJobTitle(data);
			}else if(filedName.equalsIgnoreCase("officeNumber")){
				command.setOfficeNumber(data);
			}else if(filedName.equalsIgnoreCase("homeNumber")){
				command.setHomeNumber(data);
			}else if(filedName.equalsIgnoreCase("emailAddress")){
				command.setEmailAddress(data);
			}
				
		}	
		
	}

	public static TaxSearch prepareTaxSearchCommand(String filter) {
		TaxSearch command = new TaxSearch();
		if(filter != null){
			String delims = JQGRID_FIELD_IDENTIFIER;
			String[] tokens = filter.split(delims);
			
			for(int i=0; i< tokens.length; i++){
				//ignore the 1st set of tokens, they will be of form {"groupOp":"AND","rules":[{"
				if(i== 0){
					continue;
				}
			
				String token = tokens[i];
				System.out.println(token);
				
				extractTaxField(token, DOUBLE_QUOTE_IDENTIFIER,  ingoreListForField, command);
				}
			System.out.println("Command filter"+ command.getFilterList());
			
		}
		return command;	
	}

	private static void extractTaxField(String token, String filedDelim,  List ignoreList, TaxSearch command) {
		List fieldList = new ArrayList();
		String[] fields = token.split(filedDelim);
		for(int j=0; j< fields.length; j++){
			String tokenField = fields[j];
			if(! ignoreList.contains(tokenField)){
				fieldList.add(tokenField);
			}
		}
		
		if(fieldList.size() > 4 && !fieldList.get(4).toString().equalsIgnoreCase("-1")){
			String filedName = (String) fieldList.get(FIELD_NAME_NO);
			String data = (String) fieldList.get(DATA_VALUE_FIELD);
			if(filedName.equalsIgnoreCase("clientPracticeInfoId")){
				command.setClientPracticeInfoId(Long.parseLong(data));
			}else if(filedName.equalsIgnoreCase("clientName")){
				command.setClientName(data);
			}else if(filedName.equalsIgnoreCase("jurisdictionName")){
				command.setJurisdictionName(data);
			}else if(filedName.equalsIgnoreCase("staffInChargeName")){
				command.setStaffInChargeName(data);
			}else if(filedName.equalsIgnoreCase("clientStaffInChargeName")){
				command.setClientStaffInChargeName(data);
			}else if(filedName.equalsIgnoreCase("taxReturn")){
				command.setTaxReturn(data);
			}else if(filedName.equalsIgnoreCase("taskCreator")){
				command.setTaskCreator(data);
			}else if(filedName.equalsIgnoreCase("formatedtaskCreatedDate")){
				command.setFormatedtaskCreatedDate(data);
				Date createdDate =  convertStrToDate(command.getFormatedtaskCreatedDate());
				command.setTaskCreatedDate(createdDate);
			}else if(filedName.equalsIgnoreCase("name")){
				command.setName(data);
			}else if(filedName.equalsIgnoreCase("description")){
				command.setDescription(data);
			}
				
		}	
		
	}
	
	

	public static FirmSearch setFilterParameters(HttpServletRequest request) {
		FirmSearch command = new FirmSearch();
		command.setPartyTypeId(PartyType.PARTY_TYPE_ORGANIZATION.getId());
		command.setOrganizationTypeId(OrganizationType.ORGANIZATION_TYPE_FIRM.id);
		if(!request.getParameter("sSearch").isEmpty()){
		command.setFilter(request.getParameter("sSearch"));
		}else if(!request.getParameter("sSearch_1").isEmpty()){
		command.setName(request.getParameter("sSearch_1"));
		}else if(!request.getParameter("sSearch_2").isEmpty()){
		command.setOfficeNumber(request.getParameter("sSearch_2"));
		}else if(!request.getParameter("sSearch_3").isEmpty()){
		command.setHomeNumber(request.getParameter("sSearch_3"));
		}else if(!request.getParameter("sSearch_4").isEmpty()){
		command.setEmailAddress(request.getParameter("sSearch_4"));
		}else if(!request.getParameter("sSearch_5").isEmpty()){
		if(request.getParameter("sSearch_5").equalsIgnoreCase("ACTIVE")){
			command.setStatus("1");
		}else{
			command.setStatus("0");
		}
		}
		return command;
	}
	
	public static JurisdictionSearch setFilterParameterForJurisdiction(HttpServletRequest request){
		JurisdictionSearch command = new JurisdictionSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setCountry(request.getParameter("sSearch_1"));
		}else if(!request.getParameter("sSearch_2").isEmpty()){
			command.setState(request.getParameter("sSearch_2"));
		}else if(!request.getParameter("sSearch_3").isEmpty()){
			command.setCity(request.getParameter("sSearch_3"));
		}else if(!request.getParameter("sSearch_4").isEmpty()){
		    command.setGlobalTimezoneName(request.getParameter("sSearch_4"));
		}else if(!request.getParameter("sSearch_5").isEmpty()){
			String gmtDeviation = request.getParameter("sSearch_5");
			float gmtDevationHrs = Float.parseFloat(gmtDeviation);
			command.setGmtDeviationHours(gmtDevationHrs);
		}else if(!request.getParameter("sSearch_6").isEmpty()){
			if(request.getParameter("sSearch_6").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else{
				command.setStatus("0");
			}
			}
		return command;
		
	}
	
	public static  CodeTypeSearch setFilterParameterForCodeType(HttpServletRequest request){
		CodeTypeSearch command = new CodeTypeSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setDescription(request.getParameter("sSearch_2")); 			
		}else if(!request.getParameter("sSearch_3").isEmpty()){
			command.setParentCodeTypeName(request.getParameter("sSearch_3"));
		}else if(!request.getParameter("sSearch_4").isEmpty()){
			if(request.getParameter("sSearch_4").equalsIgnoreCase("true")){
				command.setStrApplicationLevelIndicator("1");
			}else{
				command.setStrApplicationLevelIndicator("0");
			}
		}else if (!request.getParameter("sSearch_5").isEmpty()){
			if(request.getParameter("sSearch_5").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else{
				command.setStatus("0");
			}
		}
		return command;
	}
	
	public static CodeSearch setCodeFilterParameters(HttpServletRequest request){
		CodeSearch command = new CodeSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setShortName(request.getParameter("sSearch_1"));
		}else if(!request.getParameter("sSearch_2").isEmpty()){
			command.setLongDescription(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setCodeTypeName(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			if(request.getParameter("sSearch_4").equalsIgnoreCase("true")){
				command.setStrApplicationLevelIndicator("1");
			}else{
				command.setStrApplicationLevelIndicator("0");
			}
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setParentCodeShortName(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()){
			if(request.getParameter("sSearch_6").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else{
				command.setStatus("0");
			}
		}
		return command;
	}
	
	public static TaskNotificationTemplateSearch setTemplateFilterParameters(HttpServletRequest request){
		TaskNotificationTemplateSearch command = new TaskNotificationTemplateSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setSubject(request.getParameter("sSearch_1"));
		}else if(!request.getParameter("sSearch_2").isEmpty()){
			command.setBodyText(request.getParameter("sSearch_2"));
		}else if(!request.getParameter("sSearch_3").isEmpty()){
			command.setAdminEmailId(request.getParameter("sSearch_3"));
		}else if(!request.getParameter("sSearch_4").isEmpty()){
			if(request.getParameter("sSearch_4").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else{
				command.setStatus("0");
			}
		}
		return command;
	}
	public static TaskNotificationRecipientSearch setReceipientFilterParameter(HttpServletRequest request){
		TaskNotificationRecipientSearch command = new TaskNotificationRecipientSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setRecipient(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setEmailType(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setTypeOfNotificationTemplate(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			if(request.getParameter("sSearch_4").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else{
				command.setStatus("0");
			}
		}
		return command;
	}
	public static FirmStaffSearch prepareFirmAdminFirmStaffList(HttpServletRequest request){
		FirmStaffSearch command = new FirmStaffSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setJobTitle(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setRole(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setRelationshipType(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			if(request.getParameter("sSearch_6").equalsIgnoreCase("ACTIVE")){
				command.setStatus("1");
			}else {
				command.setStatus("0");
			}
		}
		return command;
		}
	public static TaxSearch setFilterParameterForTaxType(HttpServletRequest request){
		TaxSearch command = new TaxSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setDescription(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			if (request.getParameter("sSearch_3").equalsIgnoreCase("ACTIVE")) {
				command.setStatus("1");
			}else {
				command.setStatus("0");
			}
		}
		return command;
	}
	public static CodeSearch setFilterParameterForFirmCode(HttpServletRequest request){
		CodeSearch command = new CodeSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setCodeShortName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setCodeCodeTypeName(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setParentCodeShortName(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			Integer sortOrder = Integer.parseInt(request.getParameter("sSearch_4"));
			command.setSortOrder(sortOrder);
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			if (request.getParameter("sSearch_5").equalsIgnoreCase("ACTIVE")) {
				command.setStatus("1");
			}else {
				command.setStatus("0");
			}
		}
		return command;
	}
	
	public static SearchCommand	setFilterParameterForClient(HttpServletRequest request){
		SearchCommand command = new SearchCommand();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setClientName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setInChargePerson(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setOfficeNumber(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.seteMail(request.getParameter("sSearch_4"));
		}
		return command;
	}
	public static StaffSearch setFilterParameterForStaff(HttpServletRequest request){
		StaffSearch command = new StaffSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setJobTitle(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setOfficeNumber(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setHomeNumber(request.getParameter("sSearch_4")); 
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_5"));
		}
		return command;	
	}
	
	public static OfficerShareholderSearch setFilterParameterForOfficers(HttpServletRequest request){
		OfficerShareholderSearch command = new OfficerShareholderSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setTypeOfShare(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			Long noOfShares = Long.parseLong(request.getParameter("sSearch_3"));
			command.setNoOfSharesOwned(noOfShares);
		}
		return command;
	}
	
	public static LocationSearch setFilterParameterForLocation(HttpServletRequest request){
		LocationSearch command = new LocationSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setPartyName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setName(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setLocationType(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setOfficeNumber(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setHomeNumber(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_6"));
		}
		return command;
	}
	public static AccountSearch setFilterParametersForPartyAccount(HttpServletRequest request){
		AccountSearch command = new AccountSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setAccountFirmName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setAccountType(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setAccountNumber(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setContactName(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setOfficeNumber(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_6"));
		}
		return command;
	}
	
	public static AccountSearch setFilterParametersForAgent(HttpServletRequest request){
		AccountSearch command = new AccountSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setAccountFirmName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setAccountNumber(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setContactName(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setOfficeNumber(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_5"));
		}
		return command;
	}
	
	public static TaxSearch setFilterParametersForTaxList(HttpServletRequest request){
		TaxSearch command = new  TaxSearch();
		if(!request.getParameter("sSearch_1").isEmpty()){
			command.setClientName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setJurisdictionName(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setStaffInChargeName(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setClientStaffInChargeName(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setTaxReturn(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			command.setTaskCreator(request.getParameter("sSearch_6"));
		}else if (!request.getParameter("sSearch_7").isEmpty()) {
			if (request.getParameter("sSearch_5").equalsIgnoreCase("ACTIVE")) {
				command.setStatus("1");
			}else {
				command.setStatus("0");
			}
		}
		return command;
	}
	public static TaskSearchCommand setFilterParametersForTaskList(HttpServletRequest request){
		TaskSearchCommand command = new TaskSearchCommand();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setClientName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setPracticeType(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			if(request.getParameter("sSearch_3").equalsIgnoreCase("Installment")){
				command.setFilingTypeFromDB((short) 2);
			}else {
				command.setFilingTypeFromDB((short) 1);
			}
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setFormattedDueDate(request.getParameter("sSearch_4"));
			Date dueDate =  convertStrToDate(command.getFormattedDueDate());
			command.setDueDate(dueDate);
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setAssignedTo(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			command.setClientStaffInCharge(request.getParameter("sSearch_6"));
		}else if (!request.getParameter("sSearch_7").isEmpty()) {
			command.setPartnerInCharge(request.getParameter("sSearch_7"));
		}else if (!request.getParameter("sSearch_8").isEmpty()) {
			command.setTaskType(request.getParameter("sSearch_8"));
		}else if (!request.getParameter("sSearch_9").isEmpty()) {
			command.setStatus(request.getParameter("sSearch_9"));
		}
		return command;
	}

	public static EmployeeSearch setFilterParameterForFirmEmployee(HttpServletRequest request){
		EmployeeSearch command = new EmployeeSearch();
		if (!request.getParameter("sSearch_1").isEmpty()) {
			command.setName(request.getParameter("sSearch_1"));
		}else if (!request.getParameter("sSearch_2").isEmpty()) {
			command.setJobTitle(request.getParameter("sSearch_2"));
		}else if (!request.getParameter("sSearch_3").isEmpty()) {
			command.setRole(request.getParameter("sSearch_3"));
		}else if (!request.getParameter("sSearch_4").isEmpty()) {
			command.setRelationshipType(request.getParameter("sSearch_4"));
		}else if (!request.getParameter("sSearch_5").isEmpty()) {
			command.setEmailAddress(request.getParameter("sSearch_5"));
		}else if (!request.getParameter("sSearch_6").isEmpty()) {
			if (request.getParameter("sSearch_6").equalsIgnoreCase("ACTIVE")) {
				command.setStatus("1");
			}else {
				command.setStatus("0");
			}
		}
		return command;
	}
}