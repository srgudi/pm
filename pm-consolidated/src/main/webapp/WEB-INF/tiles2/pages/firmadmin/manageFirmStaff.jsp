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

			$("#content").find('.table-long').find('tr:last').find("td").css('background-image', 'none');	
			
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
	
	$.validator.addMethod("emailIdExists", function(value, element) {  
		 var isSuccess = false;
		 $.post("<c:url value='../emailIdExists.do'/>", {userName: value}, function(data) {
			 //alert("hi"+data.mailexists);
			 isSuccess = data.mailexists;
         }); 
		 return isSuccess;
	},"Please enter a new Email ID. This mail Id already exists.");
	
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
		/* 	var editId = $("#id").val();
			//alert("hi"+editId); 
			var editStatus=new Boolean();
			console.log(editId);
			  if (editId != "")
				{
				  editStatus = true;
				} */
			$("#saveFirmStaff").click(function() {	
			partyId = $("#partyId").val();
			 var container = $('div.error_container');
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
					meta: "validate",
					 submitHandler: function(form) {
			 $.ajax({
		           dataType: 'json',
		         type: 'POST',
	               data: $('#party').serialize(),
			       url: 'manageFirmStaff.do',
			       success: function(id) {
			           	if(id != -1){
			        		$.jGrowl("Record saved successfully");
			        		var tabl = $("#getFirmStaff").dataTable();
			        		tabl.fnDraw();
			        		
			        		if($("#id").val()!=""){
		       				 $('#firmStaffhome').show();
		       				 $('#firmStaffTabs a:first').tab('show');
		       				 $('#firmStaffFoo').hide();
	       					}else{
	       						/* document.getElementById("party").reset(); */
	       						$('#firmStaffFoo').load('manageFirmStaff.do');
	       					}
	       				}else{
			           		 $.jGrowl("As Error has happened while process. ");	
		            	 } 
		           }

			});
			 return false;
		}
			 
			 });
			});
			
			
			 $(function() {
		            $("#datepicker").datepicker({
		                changeMonth: true,
		                changeYear: true,
		                yearRange: '-40:+20'
		            });
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

<div class="well">
	<div class="error_container">
		<h7>
			<b>Please correct the following errors</b>
		</h7>
		<ol></ol>
	</div>
	<div class="fieldset">
		<!-- <span class="legend b">Firm Staff</span> -->
		<div class="f13">
			<form:form modelAttribute="party" >
				<input type="hidden" id="clientId" name="clientId"
					value="${clientId}" />
				<input type="hidden" name="baseURL" id="baseURL"
					value="manageFirmStaff.do" />
				<input type="hidden" name="party" id="party" value="${party}" /> 
				<input type="hidden" name="partyId" id="partyId" value="${party.id}" />
				<input type="hidden" name="inValidClientId"
					value="${param.inValidClientId}" />
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
                
<div class="container_12 mt20">

	</br>
	</br>			
<div class="row">	
<div class="span3">
 <form:label path="person.personType"><spring:message code="label.role"/></form:label>
 <form:select path="person.personType" cssClass="formSelect" tabindex="1">
	<form:option value="-1" label="Select" />
	<form:options items="${personTypeSet}" itemValue="id" itemLabel="type" />
 </form:select>
</div>
<div class="span3">
<form:label path="person.firstName"><spring:message code="label.firstname"/></form:label>
<form:input path="person.firstName" cssClass="formInput" tabindex="2"/>              
</div>
<div class="span3">
  <form:label   path="person.lastName"><spring:message code="label.lastname"/></form:label>
  <form:input path="person.lastName" cssClass="formInput" tabindex="3"/>
</div>
</div>
<div class="row">	
<div class="span3">
<form:label path="person.personDetails.codeByJobTitleCode"><spring:message code="label.title"/></form:label>
  <form:select path="person.personDetails.codeByJobTitleCode" cssClass="formSelect" tabindex="4">
	<form:option value="-1" label="Select" />
	<form:options items="${titleCodeList}" itemValue="key" itemLabel="value"/>
 </form:select>
</div>
<div class="span3">
<form:label path="person.dateOfBirth"><spring:message code="label.dateofbirth"/></form:label>
<form:input path="person.dateOfBirth" cssClass="formInput" id="datepicker" tabindex="5"/>
</div>
<div class="span3">
<form:label   path="defaultPartySite.address.addressLine1"><spring:message code="label.addressline1"/></form:label>
<form:input path="defaultPartySite.address.addressLine1" cssClass="formInput" tabindex="6"/>
</div>
</div>
<div class="row">	
<div class="span3">
<form:label   path="defaultPartySite.address.addressLine2"><spring:message code="label.addressline2"/></form:label>
<form:input path="defaultPartySite.address.addressLine2" cssClass="formInput" tabindex="7"/>
</div>
<form:hidden path="defaultPartySite.defaultPointOfContact.contactName" class="input" value="${party.name}" />
<form:hidden path="defaultPartySite.defaultPointOfContact.contactTitle" class="input" value="${party.name}" />
<div class="span3">
<form:label   path="defaultPartySite.address.city"><spring:message code="label.city"/></form:label>
<form:input path="defaultPartySite.address.city" cssClass="formInput" tabindex="8"/>
</div>
<div class="span3">
<form:label   path="defaultPartySite.address.countryCode"><spring:message code="label.country"/></form:label>
<form:select path="defaultPartySite.address.countryCode" cssClass="formSelect" tabindex="9">
   <form:option value="-1" label="Select"/>
   <form:options items="${countryCodeSet}" itemValue="key" itemLabel="value"/>
</form:select>
</div>
</div>
<div class="row">	
<div class="span3">
<form:label  path="defaultPartySite.address.stateCode"><spring:message code="label.state/province"/></form:label>
<form:select path="defaultPartySite.address.stateCode" cssClass="formSelect" tabindex="10">
     <form:option value="-1" label="Select"/>
     <form:options items="${statesSet}" itemValue="key" itemLabel="value"/>
</form:select>
</div>
<div class="span3">
<form:label   path="defaultPartySite.address.postalCode"><spring:message code="label.postelcode"/></form:label>
<form:input path="defaultPartySite.address.postalCode" cssClass="formInput" tabindex="11"/>
</div>
<div class="span3">
 <c:forEach items="${party.defaultPartySite.defaultPointOfContact.emailList}" var="email"
                                   varStatus="cStatus">
                       <form:label
            						path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"><spring:message code="label.emailaddress"/></form:label>
                       
                         <form:hidden path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                                    tabindex="12" id="email" cssClass="formInput"/>
                        
                    </c:forEach>
</div>
</div>
<!-- <h5>Staff Communication</h5> -->
<div class="row">	
<div class="span3">
 <c:forEach items="${party.defaultPartySite.defaultPointOfContact.faxList}" var="email"
                                   varStatus="cStatus">
                        <form:label 
            						path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"><spring:message code="label.faxnumber"/></form:label>
                        
                         <form:hidden path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                                    tabindex="13" cssClass="formInput"/>
                       
                    </c:forEach>
</div>
<div class="span6">

<form:label path="defaultPartySite.defaultPointOfContact.phoneList"><spring:message code="label.phoneno"/></form:label>
                       
 
  <c:set var="phoneCount" value="0"/>
  <c:set var="tabOrder" value="14"/>
  <table width="100%">
 <c:forEach items="${party.defaultPartySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
	 <c:set var="rowCounter" value="${cStatus}"/>
	 <c:set var="rowCount" value="${rowCounter.count}"/>
	<tr class="phonerowfirmstaff">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
	<td width="20%"><form:input style="width: 150px;"
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
		<td width="7%" class="grid_4 right" style="text-align:center;"><spring:message code="label.phonetype"/>&nbsp;&nbsp;</td>
       <c:set var="displayStyle" value="display:show;"/>
		  <c:if test="${phoneCount == 0}">
			        <c:set var="displayStyle" value="display:none;"/>
	       </c:if>
		<c:set var="tabOrder" value="${tabOrder + 1}"/>
		 <td class="row-nav1"><form:select style="width: 120px;"
			     path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
		         id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
		   <form:option value="-1" label="Select"/>
			   <form:options items="${phoneCommunicationTypeSet}"
		                  itemValue="value" itemLabel="key"/>
	    </form:select>
			
		   <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
	    src="<c:url value='/images/add_icon.gif'/>" width="20"
	                      height="15" alt="Add Phone Number" title="Add Phone Number"
		          class="addiconfirmstaff"/>
		 </a> &nbsp; <a href='javascript:;' class='removeiconfirmstaff'
			         style="${displayStyle}"><img
		               src='<c:url value='/images/remove_icon.gif'/>' width='20'
	                   height='15' alt='Remove Phone Number'
		            title='Remove Phone Number'/>
			                        </a>
			                        </td>
			                    </tr>
			                    <c:set var="phoneCount" value="${phoneCount + 1}"/> 
			               
			            </c:forEach>

 </table>
</div>
</div>             
                <div class="container_12">
            	<div class="grid_4">&nbsp;&nbsp;</div>
            	<div class="grid_8">
            	<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
                	<button  id="saveFirmStaff"
						class="btn btn-success"
						role="button" aria-disabled="false">
						<c:if test="${party.id == null}">
						<span class="ui-button-text" tabindex="13"><spring:message code="label.save"/></span>
						</c:if>
						<c:if test="${party.id != null}">
    	                <span class="ui-button-text" tabindex="12"><spring:message code="label.update"/></span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;
					<a href="#firmStaffhome" onclick="firmStaffList()" data-toggle="tab">
                	<button type="button"
                     class="btn btn-success"
                     role="button" aria-disabled="false">
                     <span class="ui-button-text"><spring:message code="label.backToList"/></span>
                    </button>
                    </a>
                   </security:authorize>
                   <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyAccount.id != null}">
		                	<button  id="saveFirmStaff"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                	
		                	<a href="#firmStaffhome" onclick="firmStaffList()" data-toggle="tab">
		                    <button type="button"
		                        	class="btn btn-success"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
		                    </button>
		                    </a>
	            	</c:if>
            	</security:authorize>
                	</div>
        	</div>
			</form:form>
			</div>
		</div>
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
	
	function firmStaffList(){
		$('#firmStaffTabs a:first').tab("show");
		$('#firmStaffhome').show();
		$('#firmStaffFoo').hide();	
	}
</script>

	<script type="text/javascript" charset="utf-8">
	var x = ${rowCount};
$('.addiconfirmstaff').click(function() {
if($("tr.phonerowfirmstaff").length < 5) {
/* var x = $("input[class^='input phoneField']").length ; */

$("table tbody").find("tr.phonerowfirmstaff:last").clone(true).insertAfter("tr.phonerowfirmstaff:last").find("input[class^='input phoneField']").attr({
		name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].contactDetail', 
		id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].contactDetail'})
		.val("");	

$("table tbody").find("tr.phonerowfirmstaff:last").find("select[class^='phone_type']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].subType',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].subType'})
	.val("");

$("table tbody").find("tr.phonerowfirmstaff:last").find("input[class='input_h1_id']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].id',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].id'})
	.val("");


$("table tbody").find("tr.phonerowfirmstaff:last").find("input[class='input_h1']").attr({
	name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].pointOfContact',
	id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) +'].pointOfContact'});


firstrowLength();
++x;
};
	 
});
$(".removeiconfirmstaff").click(function () {
	$(this).parent().parent().remove();
});	

function firstrowLength () {
	if($("tr.phonerowfirmstaff").length > 1) {	
		$("tr.phonerowfirmstaff:last").find("td:last").find("a.removeiconfirmstaff").show();				
	}
}
</script>


