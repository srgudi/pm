<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<style type="text/css">
.party fieldset p.error label {
	color: red;
}

div.error_container {
	background-color: #eee;
	border: 2px solid red;
	margin: 5px;
	padding: 5px;
}

div.error_container ol li {
	list-style-type: disc;
	margin-left: 20px;
}

div.error_container {
	display: none
}

.error_container label.error {
	display: inline;
}

form.party {
	width: 30em;
}

form.party label.error {
	display: block;
	margin-left: 1em;
	width: auto;
}

input:focus {
	border: 1px dotted black;
}

select:focus {
	border: 1px dotted black;
}

input.error {
	border: 2px solid red;
}

select.error {
	border: 2px solid red;
}

label.error {
	/* remove the next line when you have trouble in IE6 with labels in list */
	color: red;
	font-style: italic
}
</style>
<script type="text/javascript">
var label;
var errormsg;
	$(document).ready(function() {

	$.validator.addMethod("alphabetsOnly", function(value, element) {  
	    return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);  
	},"Please enter a valid Name.");

	$.validator.addMethod("alphaNumeric", function(value, element) {  
	    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
	},"Please enter valid Number.");

	$.validator.addMethod("webUrl", function(value, element) {  
	    return this.optional(element) || /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i.test(value);  
	},"Please enter valid Web URL.");

	$.validator.addMethod("phoneValidaion", function(value, element) {  
	    return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);  
	},"Please enter valid Phone Number. For Ex: 646-222-3333");

	$.validator.addMethod("faxValidaion", function(value, element) {  
	    return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);  
	},"Please enter valid Fax Number. For Ex: 123-456-7890");
	
	$.validator.addMethod('postalCode', function(value, element) {
    	errormsg = 'Please enter a valid postal code.';
    	if(label == 'CANADA'){
    		errormsg = 'Please enter a valid postal code. Ex: A1B 2C3';
           return this.optional(element) || /^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/i.test(value);
    	}
    	else if(label == 'INDIA'){
    		errormsg = 'Please enter a valid postal code. Ex: 123456';
    	    return this.optional(element) || /^(\d{6})$/i.test(value);	
    	}
    	else if(label == 'USA'){
    		errormsg = 'Please enter a valid postal code. Ex: 12345';
    	    return this.optional(element) || /^(\d{5})$/i.test(value);		
    	}else{
    		errormsg = 'Please enter a valid postal code.';
    		return this.optional(element) || /^[0-9]+$/i.test(value);		
    	}
    }, "Please enter a valid postal code.");
	
	$.validator.addMethod("addressValidation", function(value, element) {  
	    return this.optional(element) || /^[0-9A-Z-_#&{},.;\s]+$/i.test(value);  
	},"No Special Character allowed.");

	});
		// only for demo purposes
		$.validator.setDefaults({
			submitHandler: function(form) {
			   	form.submit();
			}
		});

		$().ready(function() {
			$("#save").click(function() {	
			partyId = $("#partyId").val();
			var container = $('div.error_container');
			label = $('#defaultPartySite\\.address\\.countryCode option:selected').text();
			if(label == 'CANADA'){
    			errormsg = 'Ex: A1B 2C3';
    		}
    		else if(label == 'INDIA'){
    			errormsg = ' Ex: 123456';
    		}
    		else if(label == 'USA'){
    			errormsg = 'Ex: 12345';
    		}else{
    			errormsg = '';	
    		}
			// validate the form when it is submitted
				var validator = $("#party").validate({
					
					rules: { 
					'person.personType': {required: true,min:1},
					'person.firstName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 40},
					'person.lastName': {alphabetsOnly: true,minlength: 0,maxlength: 50},
					'person.personDetails.codeByJobTitleCode': {required: true,min:1},
					'person.dateOfBirth': {required: true,date: true},
					'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {required: true, email:true},
					'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {required: true, faxValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {required: true, phoneValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[0].subType': {required: true,min:1},
					'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {required: true, phoneValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[1].subType': {required: true,min:1},
					'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {required: true, phoneValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[2].subType': {required: true,min:1},
					'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {required: true, phoneValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[3].subType': {required: true,min:1},
					'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {required: true, phoneValidaion: true},
					'defaultPartySite.defaultPointOfContact.phoneList[4].subType': {required: true,min:1},
					'defaultPartySite.address.addressLine1': {required: true,addressValidation:true, minlength: 0,maxlength: 100},
					'defaultPartySite.address.addressLine2': {addressValidation:true,minlength: 0,maxlength: 100},
					'defaultPartySite.address.countryCode': {required: true,min:1},
					'defaultPartySite.address.stateCode': {required: true,min:1},
					'defaultPartySite.address.city': {required: true, alphabetsOnly:true,minlength: 0,maxlength: 50},
					'defaultPartySite.address.postalCode': {required: true,postalCode:true,maxlength: 10} 
					}, 
					
	        	messages: { 
	        		'person.personType': "Select one Role",
					'person.firstName': {
	            		required: "First Name is required",
	            		alphabetsOnly:"Please enter a Valid First Name ,No special characters are allowed .",
	            		minlength: "Enter First Name with at least {0} characters.",
	            		maxlength: "Enter First Name with no more than {0} characters."},
	        		'person.lastName': {
	            		required: "Last Name is required",
	            		alphabetsOnly:"Please enter a Valid Last Name ,No special characters are allowed .",
	            		minlength: "Enter Last Name with at least {0} characters.",
	            		maxlength: "Enter Last Name with no more than {0} characters."},
	        		'person.personDetails.codeByJobTitleCode': "Select one Title",
					'person.dateOfBirth': {
	            		required: "Date Of Birth is required",
	            		date: "Enter a valid Date Of Birth in the format dd/mm/yyyy"},
					
					
					'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {
	            		required: "Email Address is required",
	            		email: "Please enter valid email address."},
	        		'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {
	            		required: "Fax is required",
	            		digits: "No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {
	            		required: "1st Phone No. is required",
	            		digits: "Please enter valid Phone 1st Number. For Ex: 646-222-3333"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[0].subType': "Select one Phone Type for 1st Phone No.",
	        		'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {
	            		required: "2nd Phone No. is required",
	            		digits: "Please enter valid Phone 2nd Number. For Ex: 646-222-3333"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[1].subType': "Select one Phone Type 2nd Phone No.",
	        		'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {
	            		required: "3rd Phone No. is required",
	            		digits: "Please enter valid Phone 3rd Number. For Ex: 646-222-3333"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[2].subType': "Select one Phone Type 3rd Phone No.",
	        		'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {
	            		required: "4th Phone No. is required",
	            		digits: "Please enter valid Phone 4th Number. For Ex: 646-222-3333"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[3].subType': "Select one Phone Type 4th Phone No.",
	        		'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {
	            		required: "5th Phone No. is required",
	            		digits: "Please enter valid Phone 5th Number. For Ex: 646-222-3333"},
	        		'defaultPartySite.defaultPointOfContact.phoneList[4].subType': "Select one Phone Type 5th Phone No.",
					
					
					'defaultPartySite.address.addressLine1': {
	            		required: "Address Line 1 is required",
	            		minlength: "Enter Address Line 1 with at least {0} characters.",
	            		maxlength: "Enter Address Line 1 with no more than {0} characters."},
	        		'defaultPartySite.address.addressLine2': {
	            		required: "Address Line 2 is required",
	            		minlength: "Enter Address Line 2 with at least {0} characters.",
	            		maxlength: "Enter Address Line 2 with no more than {0} characters."},
	        		'defaultPartySite.address.countryCode': "Select one Country",
	        		'defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
	        		'defaultPartySite.address.city': {
	            		required: "City is required",
	            		alphabetsOnly:"Please enter a Valid City Name ,No special characters are allowed .",
	            		minlength: "Enter City with at least {0} characters.",
	            		maxlength: "Enter City with no more than {0} characters."},
	        		'defaultPartySite.address.postalCode': {
	            		required: "Postal Code is required",
	            		postalCode: "Please enter a valid postal code."+errormsg,
	            		minlength: "Enter Postal Code with at least {0} characters.",
	            		maxlength: "Enter Postal Code with no more than {0} characters."}
	        		}, 
				errorContainer: container,
					errorLabelContainer: $("ol", container),
					wrapper: 'li',
					meta: "validate"
					});
				$("#party").submit();
			});
			
		});
	</script>

<style>
.error {
	color: red;
}

.errorblock {
	color: #000;
	background-color: #ffEEEE;
	border: 2px solid red;
	margin: 5px;
	padding: 5px;
	width: auto;
}
</style>

<c:url value="/mobilefirmadmin/manageFirmStaffMobile.do" var="mobilefirmstaffUrl"/>
	<div class="error_container">
		<h7>
			<b>Please correct the following errors</b>
		</h7>
		<ol></ol>
	</div>
<a href="<c:out value='${mobilefirmstaffUrl}'/>" style="text-decoration:none;">	
	<button id="showFirmStaffform" 
	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	<span class="ui-button-text">New FirmStaff</span>
	</button>
</a>

<body onload="hideform()">
 <div id="divFirmstaff">
			<form:form modelAttribute="party" method="POST"
				action="manageFirmStaffMobile.do">
				<input type="hidden" id="clientId" name="clientId"
					value="${param.clientId }" />
				<input type="hidden" name="baseURL" id="baseURL"
					value="manageFirmStaffMobile.do" />
				<input type="hidden" name="party" id="party" value="${party}" />
				<input type="hidden" name="partyId" id="partyId" value="${party.id}" />
				<input type="hidden" name="inValidClientId"
					value="${param.inValidClientId }" />
				<i><b><form:errors path="*" class="errorblock" element="div" />
				</b>
				</i>
				
				<center><b><strong>${inValidClientId}</strong> </b> </center> 
				<center> 
					<c:if test="${not empty invalidEmilId}">
						<b><font color="red"><c:out value="${invalidEmilId}"/></font></b>
					</c:if>
				</center>
				<form:hidden path="id" />
                 <!-- Sample code just for one row in client staff -->
                
               <div data-role="fieldcontain">
                    <form:label path="person.personType">Role</form:label>
                    
                   		<form:select path="person.personType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							<form:options items="${personTypeSet}" itemValue="id" itemLabel="type" />
						</form:select>
                   
                </div>
                <div data-role="fieldcontain">
                    <form:label path="person.firstName">First Name</form:label>
                    <form:input path="person.firstName" cssClass="input_full" tabindex="2"/>
                </div>
                 <div data-role="fieldcontain">  
                    <form:label   path="person.lastName">Last Name</form:label>
                    <form:input path="person.lastName" cssClass="input_full" tabindex="3"/>
                </div>
                <div data-role="fieldcontain">
                    <form:label path="person.personDetails.codeByJobTitleCode">Title</form:label>
                   		<form:select path="person.personDetails.codeByJobTitleCode" cssClass="input_full" tabindex="4">
							<form:option value="-1" label="Select" />
							<form:options items="${titleList}" itemValue="id" itemLabel="shortName"/>
						</form:select>
                 </div>
                <div data-role="fieldcontain">
                    <form:label path="person.dateOfBirth">Date Of Birth   </form:label>
                    <form:input path="person.dateOfBirth" cssClass="input_full" id="datepicker" tabindex="5"/>
                </div>
                
                
                <div data-role="fieldcontain">
                    <form:label   path="defaultPartySite.address.addressLine1">Address Line 1</form:label>
                    <form:input path="defaultPartySite.address.addressLine1" cssClass="input_full" tabindex="6"/>
                </div>
                 <div data-role="fieldcontain">
                    <form:label   path="defaultPartySite.address.addressLine2">Address Line 2</form:label>
                    <form:input path="defaultPartySite.address.addressLine2" cssClass="input_full" tabindex="7"/>
                </div>
                
                <form:hidden path="defaultPartySite.defaultPointOfContact.contactName" class="input" value="${party.name}" />
				<form:hidden path="defaultPartySite.defaultPointOfContact.contactTitle" class="input" value="${party.name}" />
				
                <div data-role="fieldcontain">
                    <form:label   path="defaultPartySite.address.city">City</form:label>
                    <form:input path="defaultPartySite.address.city" cssClass="input_full" tabindex="8"/>
                    </div>
                   <div data-role="fieldcontain">
                    <form:label   path="defaultPartySite.address.countryCode">Country</form:label>
                    <form:select path="defaultPartySite.address.countryCode" cssClass="input_full" tabindex="9">
                        	<form:option value="-1" label="Select"/>
                       	 	<form:options items="${countryCodeSet}" itemValue="key" itemLabel="value"/>
                    </form:select>
                    
                </div>
               <div data-role="fieldcontain">
                    <form:label  path="defaultPartySite.address.stateCode">State/Province</form:label>
                    <form:select path="defaultPartySite.address.stateCode" cssClass="input_full" tabindex="10">
                        	<form:option value="-1" label="Select"/>
                        	<form:options items="${statesSet}" itemValue="key" itemLabel="value"/>
                    	</form:select>
                    </div>
                   <div data-role="fieldcontain">
                    <form:label   path="defaultPartySite.address.postalCode">Postal Code</form:label>
                    <form:input path="defaultPartySite.address.postalCode" cssClass="input_full" tabindex="11"/>
                </div>
                
                
                
                    <c:forEach items="${party.defaultPartySite.defaultPointOfContact.emailList}" var="email"
                                   varStatus="cStatus">
                     <div data-role="fieldcontain">              
                        <form:label cssClass="label"
            						path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail">Email Address  </form:label>
                        
                         <form:hidden path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                                    tabindex="12" id="email" cssClass="input_full"/>
                      </div>
                    </c:forEach>
                  
                 
                    <c:forEach items="${party.defaultPartySite.defaultPointOfContact.faxList}" var="email"
                                   varStatus="cStatus">
                         <div data-role="fieldcontain">           
                        <form:label cssClass="label"
            						path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail">Fax Number</form:label>
                       
                         <form:hidden path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                                    tabindex="13" cssClass="input_full"/>
                         </div>            
                    </c:forEach>
               
                
               
                        
            			<form:label path="defaultPartySite.defaultPointOfContact.phoneList">Phone No.</form:label>
                         <div data-role="fieldcontain">
                     
            			<c:set var="phoneCount" value="0"/>
            			<c:set var="tabOrder" value="14"/>
            			<c:forEach items="${party.defaultPartySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			                <table width="100%">
			                    <tr class="phonerow">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
			                        <td width="20%"><form:input
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"
			                                cssClass="input phoneField" tabindex="${tabOrder}"/>
			                        </td>
			                        <form:hidden
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].id"
			                                class="input_h1_id"/>
			                        <form:hidden
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"
			                                class="input_h1"/>
									<td width="3%"></td>
			                        <% /** Phone Type **/ %>
			                         <td width="7%" class="grid_4 right" style="text-align:center; color : #00498F">Type </td>
			                        <c:set var="displayStyle" value="display:show;"/>
			                        <c:if test="${phoneCount == 0}">
			                            <c:set var="displayStyle" value="display:none;"/>
			                        </c:if>
			                        <c:set var="tabOrder" value="${tabOrder}++"/>
			                        <td class="row-nav1"><form:select
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			
			                            <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addicon"/>
			                        </a> &nbsp; <a href='javascript:;' class='removeicon'
			                                       style="${displayStyle}"><img
			                                src='<c:url value='/images/remove_icon.gif'/>' width='20'
			                                height='15' alt='Remove Phone Number'
			                                title='Remove Phone Number'/>
			                        </a>
			                        </td>
			                    </tr>
			                    <c:set var="phoneCount" value="${phoneCount}++"/>
			                </table>
			                </div>
			            </c:forEach>
<br/><br/>
            
            	<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">

                	<button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<c:if test="${party.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
						</c:if>
						<c:if test="${party.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;
                	<button type="reset"
                     class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                     role="button" aria-disabled="false" data-inline="true" data-mini="true" >
                     <span class="ui-button-text">Cancel</span>
                    </button>
                    
                    <button id="showFirmStaffGrid" onclick="window.location='manageFirmStaffMobile.do?id=${param.clientId}';return false;"
	                 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                 role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                 <span class="ui-button-text">Back</span>
	                 </button>
	                 
                   </security:authorize>
                    <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyAccount.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false" data-inline="true" data-mini="true">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false" data-inline="true" data-mini="true">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
              
			</form:form>
	</div>
	</body>
	<br/><br/>
	
	<div id="gridFirmStaff" style="width:300px;">	  
		<div id="grid_wrapper" class="ml10 mr10 mt20" style="width:300px;">
			<table id="firmstafflist" style="width:300px;"></table>
			<div id="firmstaffpager" class="scroll" style="text-align: center;"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
			$(document).ready(function() {		
			
			$("#save_continue").click(function() {
			$("#clientmenu li").removeClass('hidemenu');
			window.location.href="clients_bankers.html";
			});
			$("#save").click(function() {		
				$("#party").submit();
			});
			$("#content").find('.table-long').find('tr:last').find("td").css('background-image', 'none');	
			});

			jQuery(document).ready(function(){ 
				partyId = $("#partyId").val();				
				
				var mygrid = jQuery("#firmstafflist").jqGrid({
					url:'<c:url value="/firmadmin/manageFirmStaffList.do"/>?partyId='+partyId,
					datatype: 'json',
					
					"height":200,
			        "width" :300,
					mtype: 'GET',
					colNames:['Name', 'Title', 'Role' , 'Relationship Type', 'Email Address', 'Status'],
					colModel :[
						{name:'name', index:'name',  width:150,formatter: 'showlink', formatoptions: {baseLinkUrl: 'manageFirmStaffMobile.do', 
	   						idName:'id'}},
   						{name:'jobTitle', index:'jobTitle',  width:150},
   						{name:'role', index:'role',  width:100},
   						{name:'relationshipType', index:'relationshipType',  width:100},
   						{name:'emailAddress', index:'emailAddress',  width:180},
   						{name:'status', index:'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
   				   		 	formatter:'select', stype: 'select', sorttype:
   					   		 	function(cell) {return status[cell];},
   					   		 edittype:'select', editoptions: { value: statusStr }, 
   					   		searchoptions:{ sopt:['eq'] }},
				    ],
				    jsonReader : {
    					root: "rows",
    					page: "page",
    					total: "total",
    					records: "records",  
    					repeatitems: false,
    					cell: "cell",
    					id: "partyId",
    					userdata: "userdata"  
						},
						pager: jQuery('#firmstaffpager'),
						rowNum:10,
					//	loadonce: true,
						rowList:[10,25,50],
						sortname: 'firstName',
						sortorder: 'asc',
						viewrecords: true,
						autowidth: true,
					    caption: 'Staff List',
						editurl:'<c:url value="/firmadmin/saveClientAjaxList.do"/>'
					});
				
				
				  jQuery("#firmstafflist").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});
				  <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
	                jQuery("#firmstafflist").jqGrid('navGrid', '#firmstaffpager', {
	                 del : true,
	                 add : false,
	                 edit : false,
	                 search : false
	                });
	                
	                jQuery("#firmstafflist").jqGrid('navButtonAdd',
		                    "#firmstaffpager", {
		                        caption : "Apply Filter",
		                        title : "Toggle Search Toolbar",
		                        buttonicon : 'ui-icon-pin-s',
		                        onClickButton : function() {
		                            mygrid[0].toggleToolbar();
		                        }
		                    });
	             </security:authorize>
		});
			
			// resize the grid if needed
			 $(window).bind('resize', function() {
				jQuery("#firmstafflist").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('resize');
			 
			 $(window).bind('load', function() {
					jQuery("#firmstafflist").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('load');	
		
		</script>
	</div>

	<script type="text/javascript">
	$(document).ready(function() {
			 if($("#id").val() == "")  {
				 $("#person\\.personType").removeAttr("disabled");
				 $("#email").removeAttr("disabled");
			 }else{
				 $("#person\\.personType").attr('disabled', true);
				 $("#email").attr('disabled', true);
			 }
	});
</script>
	<script type="text/javascript">
	$(document)
			.ready(
					function() {

						firmId = ${firm.id};
						$("#defaultPartySite\\.address\\.countryCode").change(
										function() {
											
											$.get(
															"<c:url value='/getStates.do'/>",
															{
																countryId : $(
																		this)
																		.val(),
																firmId : firmId
															},
															function(data) {
																populateDropdown(
																		$("#defaultPartySite\\.address\\.stateCode"),
																		data);
															});
										});
					});

	function populateDropdown(select, data) {
		select.html('');
		select.append($('<option></option>').val("-1").html("Select"));
		$.each(data, function(id, option) {
			$.each(option, function(id, option) {
				select.append($('<option></option>').val(option.key).html(
						option.value));
			});
		});
	}
</script>

	<script type="text/javascript" charset="utf-8">
$('.addicon').click(function() {
if($("tr.phonerow").length < 5) {
var x = $("input[class^='input phoneField']").length ;

$("table tbody").find("tr.phonerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr({
		name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].contactDetail', 
		id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].contactDetail'})
		.val("");	

$("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].subType',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].subType'})
	.val("");

$("table tbody").find("tr.phonerow:last").find("input[class='input_h1_id']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].id',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].id'})
	.val("");


$("table tbody").find("tr.phonerow:last").find("input[class='input_h1']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].pointOfContact',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].pointOfContact'});


firstrowLength();
};
	 
});
$(".removeicon").click(function () {
	$(this).parent().parent().remove();
});	

function firstrowLength () {
	if($("tr.phonerow").length > 1) {	
		$("tr.phonerow:last").find("td:last").find("a.removeicon").show();				
	}
}
</script>
<script type="text/javascript">
function hideform(){
	$("#divFirmstaff").hide();	
	$("#gridFirmStaff").show();
}

$().ready(function() {
	
		$("#showFirmStaffform").click(function() {
			$("#gridFirmStaff").hide();	
			$("#divFirmstaff").show();  
			});
		
		
		$("#showFirmStaffGrid").click(function() {
			$("#divFirmstaff").hide();	
			$("#gridFirmStaff").show();
			    
			});
}); 
</script> 
<script type="text/javascript">
$(document).ready(function(){
	<c:if test="${statusMessageKey eq 'save.msg.sucess'}">
	$.jGrowl("Record saved sucessfully");
	</c:if>
 });
</script>
 

