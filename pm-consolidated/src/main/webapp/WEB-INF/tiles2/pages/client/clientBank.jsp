<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<style type="text/css">
    .bankPartyAccount fieldset p.error label {
        color: red;
    }

    div.error_container_bank {
        background-color: #eee;
        border: 2px solid red;
        margin: 5px;
        padding: 5px;
    }

    div.error_container_bank ol li {
        list-style-type: disc;
        margin-left: 20px;
    }

    div.error_container_bank {
        display: none
    }

    .error_container_bank label.error {
        display: inline;
    }

    form.bankPartyAccount {
        width: 30em;
    }

    form.bankPartyAccountlabel.error {
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
     }, "Please enter a valid Name.");

     $.validator.addMethod("alphaNumeric", function(value, element) {
         return this.optional(element) || /^[0-9A-Z-_\s]+$/i.test(value);
     }, "Please enter valid Number.");

     $.validator.addMethod("webUrl", function(value, element) {
         return this.optional(element) || /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i.test(value);
     }, "Please enter valid Web URL.");

     $.validator.addMethod("phoneValidaion", function(value, element) {
         return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
     }, "Please enter valid Phone Number. For Ex: 646-222-3333");

     $.validator.addMethod("faxValidaion", function(value, element) {
         return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
     }, "Please enter valid Fax Number. For Ex: 123-456-7890");

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
     }, "No Special Character allowed.");

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
	
	 $("#bankSave").click(function() {
		 var container = $('div.error_container_bank');
	        // validate the form when it is submitted
	        var validator = $("#bankPartyAccount").validate({

	            rules: {
	                'accountEntityName': {alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'accountNumber': {alphaNumeric:true, minlength: 0,maxlength: 50},
	                'accountType': {required: true,min:1},
	                'terms' : {minlength: 0,maxlength: 1000},

	                'address.addressLine1': {addressValidation:true,minlength: 0,maxlength: 100},
	                'address.addressLine2': {addressValidation:true,minlength: 0,maxlength: 100},
	                'address.city': {alphabetsOnly:true,minlength: 0,maxlength: 50},
	                'address.countryCode': {},
	                'address.stateCode': {},
	                'address.postalCode': {postalCode:true,maxlength: 10}, 

	                'defaultPointOfContact.contactName': {alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'defaultPointOfContact.contactTitle': {alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'defaultPointOfContact.webUrlList[0].contactDetail': {webUrl:true},
	                'defaultPointOfContact.emailList[0].contactDetail': {email:true},
	                'defaultPointOfContact.faxList[0].contactDetail': {faxValidaion: true},
	                'defaultPointOfContact.phoneList[0].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPointOfContact.phoneList[0].subType': {required: true,min:1},
	                'defaultPointOfContact.phoneList[1].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPointOfContact.phoneList[1].subType': {required: true,min:1},
	                'defaultPointOfContact.phoneList[2].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPointOfContact.phoneList[2].subType': {required: true,min:1},
	                'defaultPointOfContact.phoneList[3].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPointOfContact.phoneList[3].subType': {required: true,min:1},
	                'defaultPointOfContact.phoneList[4].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPointOfContact.phoneList[4].subType': {required: true,min:1}
	            },
	            messages: {
	                'accountEntityName': {
	                    required: "Name is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid Bank Name",
	                    minlength: "Enter Name with at least {0} characters.",
	                    maxlength: "Enter Name with no more than {0} characters."},
	                'accountNumber': {
	                    required: "Account Number is required",
	                    alphaNumeric:"No Special Charcters allowed. Please enter a valid Account Number",
	                    digits: "Enter Account Number only digits.",
	                    minlength: "Enter Account Number with at least {0} characters.",
	                    maxlength: "Enter Account Number with no more than {0} characters."},
	                'accountType': "Select one Account Type",
	                'terms': {
	                    required: "Terms is required",
	                    minlength: "Enter Terms with at least {0} characters.",
	                    maxlength: "Enter Terms with no more than {0} characters."},


	                'address.addressLine1': {
	                    required: "Address Line 1 is required",
	                    addressValidation:"No Special Charcters allowed. Please enter a valid Address Line 1",
	                    minlength: "Enter Address Line 1 with at least {0} characters.",
	                    maxlength: "Enter Address Line 1 with no more than {0} characters."},
	                'address.addressLine2': {
	                    required: "Address Line 2 is required",
	                    addressValidation:"Please enter a valid Address Line 2",
	                    minlength: "Enter Address Line 2 with at least {0} characters.",
	                    maxlength: "Enter Address Line 2 with no more than {0} characters."},
	                'address.city': {
	                    required: "City is required",
	                    alphabetsOnly:"Please enter a valid City Name.No Special Charcters allowed. ",
	                    minlength: "Enter City with at least {0} characters.",
	                    maxlength: "Enter City with no more than {0} characters."},
	                'address.countryCode': "Select one Country",
	                'address.stateCode': "Select any one Country to get State/Province",
	                'address.postalCode': {
	                    required: "Postal Code is required",
	                    postalCode:"Please enter a valid postal code."+errormsg,
	                    minlength: "Enter Postal Code with at least {0} characters.",
	                    maxlength: "Enter Postal Code with no more than {0} characters."},

	 
	                'defaultPointOfContact.contactName': {
	                    required: "Contact Name is required",
	                    alphabetsOnly:"No Special Charcters allowed. Please enter a valid Contact Name",
	                    minlength: "Enter Contact Name with at least {0} characters.",
	                    maxlength: "Enter Contact Name with no more than {0} characters."},
	                'defaultPointOfContact.contactTitle': {
	                    required: "Title is required",
	                    alphabetsOnly:"No Special Charcters allowed. Please enter a valid Title",
	                    minlength: "Enter Title with at least {0} characters.",
	                    maxlength: "Enter Title with no more than {0} characters."},
	                'defaultPointOfContact.webUrlList[0].contactDetail': {
	                    required: "Web is required"},
	                'defaultPointOfContact.emailList[0].contactDetail': {
	                    required: "Email Address is required",
	                    email: "Please enter valid email address."},
	                'defaultPointOfContact.faxList[0].contactDetail': {
	                    required: "Fax is required",
	                    faxValidaion: "No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890"},
	                'defaultPointOfContact.phoneList[0].contactDetail': {
	                    required: "1st Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 1st Number. For Ex: 646-222-3333"},
	                'defaultPointOfContact.phoneList[0].subType': "Select one Phone Type for 1st Phone No.",
	                'defaultPointOfContact.phoneList[1].contactDetail': {
	                    required: "2nd Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 2nd Number. For Ex: 646-222-3333"},
	                'defaultPointOfContact.phoneList[1].subType': "Select one Phone Type for 2nd Phone No.",
	                'defaultPointOfContact.phoneList[2].contactDetail': {
	                    required: "3rd Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 3rd Number. For Ex: 646-222-3333"},
	                'defaultPointOfContact.phoneList[2].subType': "Select one Phone Type for 3rd Phone No.",
	                'defaultPointOfContact.phoneList[3].contactDetail': {
	                    required: "4th Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 4th Number. For Ex: 646-222-3333"},
	                'defaultPointOfContact.phoneList[3].subType': "Select one Phone Type for 4th Phone No.",
	                'defaultPointOfContact.phoneList[4].contactDetail': {
	                    required: "5th Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 5ht Number. For Ex: 646-222-3333"},
	                'defaultPointOfContact.phoneList[4].subType': "Select one Phone Type for 5th Phone No."
	            },
	            errorContainer: container,
	            errorLabelContainer: $("ol", container),
	            wrapper: 'li',
	            meta: "validate",
	            submitHandler: function(form) {
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#bankPartyAccount').serialize(),
				        url: 'clientBank.do',
				        success: function(clientId) {
				        	//$("#cboxCancel").click();
			              	if(clientId != -1){
		            			$.jGrowl("Record saved successfully");
		            			//$('#getAllBank').dataTable()._fnAjaxUpdate();
		            			var clientId = ${clientId};
		            			/* var tableName = '#getAllBank';
		            			var gridURL = 'accountAjaxList.do?clientId=' + clientId + '&accountCategory=700';
		            			reloadGrid(tableName, gridURL); */
		            			
		            			$('#getAllBank').dataTable().fnReloadAjax('accountAjaxList.do?clientId=' + clientId + '&accountCategory=700');
		            			/* var bankList = $('#getAllBank').dataTable();
		            			bankList.fnDraw(); */
		            			//alert($("#id").val());
		            			if($("#id").val()!=""){
		            				 $('#home').show();
		            				 $('#myTabs a:first').tab('show');
		            				 $('#foo').hide();
		            			}else{
		            			     /* document.getElementById("bankPartyAccount").reset(); */
		            				$('#foo').load('clientBank.do');
		            			}
		            		}
		            	 else{
		            		 $.jGrowl("As Error has happened while process. ");	
		            	 } 
		            }
	
				});
		 return false;
	            }
	        });
	 });
	 
	 $("#newBank").click(function(){
			$('#foo').load('clientBank.do');
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
<!--  BUCKET -->

<div class="error_container_bank">
	<h7><b>Please correct the following errors </b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<div class="f13">
<form:form modelAttribute="bankPartyAccount" action="clientBank.do">

<input type="hidden" name="inValidClientId"
       value="${param.inValidClientId}"/>

<input type="hidden" name="clientId" id="clientId"
       value="${clientId}"/>
<input type="hidden" name="baseURL" id="baseURL"
       value="clientBank.do"/>
<form:hidden path="accountCategory"/>
<form:hidden path="id"/>
<%-- <form:hidden path="createUserId" value="system"/> --%>
<%-- <form:hidden path="party"/> --%>
<input type="hidden" name="party" value="${clientId}"/>
<i><b><form:errors path="*" class="errorblock" element="div"/>
</b>
</i>
<b><strong>${inValidClientId}</strong></b> 
 <div class="container_12 mt20">

				 <div class="row">	
				 <div class="span3">
				  <form:label path="accountEntityName"><spring:message code="label.bankname"/></form:label>
                  <form:input path="accountEntityName" cssClass="formInput" tabindex="1"/>
				</div>
				<div class="span3">
				  <form:label path="accountNumber"><spring:message code="label.accountnumber"/></form:label>
                  <form:input path="accountNumber" cssClass="formInput" tabindex="2"/>
				</div>
				<div class="span3">
				  <form:label path="accountType"><spring:message code="label.accounttype"/></form:label>
                  <form:select path="accountType" tabindex="3" cssClass="formSelect">
                  <form:option value="-1" label="Select"/>
                  <form:options items="${accountTypeCodeSet}" itemValue="id" itemLabel="shortName"/>
                  </form:select> 
				</div>
				</div>
				<div class="row">	
				 <div class="span3">
				  <form:label path="address.addressLine1"><spring:message code="label.addressline1"/></form:label>
                  <form:input cssClass="formInput" path="address.addressLine1" class="input" tabindex="4"/>
				 </div>
				 <div class="span3">
				  <form:label path="address.addressLine2"><spring:message code="label.addressline2"/></form:label>
                  <form:input cssClass="formInput" path="address.addressLine2" class="input" tabindex="5"/>
				 </div>
				 <div class="span3">
				  <form:label path="address.city"><spring:message code="label.city"/></form:label>
                  <form:input cssClass="formInput" path="address.city" class="input" tabindex="6"/>
				 </div>
				</div>
				<div class="row">	
				 <div class="span3">
				 <form:label path="address.countryCode"><spring:message code="label.country"/></form:label>
                 <form:select
                    path="address.countryCode" cssClass="formSelect" tabindex="7">
                    <form:option value="-1" label="Select"/>
                    <form:options items="${countryCodeSet}" itemValue="key"
                              itemLabel="value"/>
                 </form:select>
				 </div>
				 <div class="span3">
				 <form:label path="address.stateCode"><spring:message code="label.state"/></form:label>  
                 <form:select path="address.stateCode"
                         cssClass="formSelect" tabindex="8">
                  <form:option value="-1" label="Select"/>
                  <form:options items="${statesSet}" itemValue="key"
                              itemLabel="value"/>
                 </form:select> 
				 </div>
				 <div class="span3">
				 <form:label path="address.postalCode" cssClass="input_full"><spring:message code="label.postelcode"/></form:label>
                  <form:input path="address.postalCode"
                        cssClass="formInput" tabindex="9"/>
				 </div>
				</div>
				<div class="row">	
				 <div class="span3">
				 <form:label path="defaultPointOfContact.contactName"><spring:message code="label.contactname"/></form:label>
                 <form:input cssClass="formInput" path="defaultPointOfContact.contactName" class="input"
                        tabindex="10"/>
				 </div>
				 <div class="span3">
				 <form:label path="defaultPointOfContact.contactTitle"><spring:message code="label.contacttitle"/></form:label>
                 <form:input cssClass="formInput" path="defaultPointOfContact.contactTitle" class="input"
                        tabindex="11"/>
				 </div>
				 <div class="span3">
				 <c:forEach
                    items="${bankPartyAccount.defaultPointOfContact.emailList}"
                    var="email" varStatus="cStatus">
                    <form:label path="defaultPointOfContact.emailList" cssClass="input_full"><spring:message code="label.emailaddress"/></form:label>
            
                    <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].id"/>
                    <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                    <form:input
                        path="defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                        tabindex="12" cssClass="formInput"/>
                </c:forEach>
				 </div>
				</div>
				
				<div class="row">	
				 <div class="span3">
				 <c:forEach
                    items="${bankPartyAccount.defaultPointOfContact.faxList}"
                    var="contact" varStatus="cStatus">
                    
             <form:label path="defaultPointOfContact.faxList" cssClass="input_full"><spring:message code="label.faxnumber"/></form:label>   
            
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                        tabindex="13" cssClass="formInput"/>
              </c:forEach> 
				 </div>
				 <div class="span3">
				  <c:forEach
                    items="${bankPartyAccount.defaultPointOfContact.webUrlList}"
                    var="contact" varStatus="cStatus">
                  <form:label path="defaultPointOfContact.webUrlList" cssClass="input_full"><spring:message code="label.web"/>&nbsp;&nbsp;</form:label> 
          
                  <form:hidden
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].id"/>
                  <form:hidden
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].pointOfContact"/>
                  <form:input
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].contactDetail"
                        tabindex="14" cssClass="formInput"/>
                 </c:forEach>    
				 </div>
								 <div class="span6">
               <form:label path="defaultPointOfContact.phoneList"><spring:message code="label.phoneno"/></form:label>
             
            			<c:set var="phoneCount" value="0"/>
            			<c:set var="tabOrder" value="15"/>
            			 <table width="100%">
            			<c:forEach items="${bankPartyAccount.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			               <c:set var="rowCounter" value="${cStatus}"/>
			               <c:set var="rowCount" value="${rowCounter.count}"/>
			                    <tr class="phonerowBank">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
			                        <td width="20%"><form:input style="width: 150px;"
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"
			                                cssClass="input phoneField" tabindex="${tabOrder}"/>
			                        </td>
			                        <form:hidden
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].id"
			                                class="input_h1_id"/>
			                        <form:hidden
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"
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
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			
			                            <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addiconBank" style="text-decoration:none;"/>
			                        </a> &nbsp; <a href='javascript:;' class='removeiconBank'
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
				<div class="row">	
				 <div class="span9">
				 <form:label path="terms" cssClass="input_full"><spring:message code="label.memo"/></form:label>
                 <form:textarea path="terms" rows="3" cssClass="textareanew" style="width: 500px;" tabindex="16"/>
				 </div>
				</div>

</br>

			<div class="row">
            
	            <div class="span">
            	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	
	                    	<%-- <button type="button" id="newBank"
	                        	    class="btn btn-primary"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.newbank"/></span>
	                    	</button> --%>
	                		&nbsp;&nbsp;
	
	                	<button  id="bankSave"
						class="btn btn-success">
							<c:if test="${bankPartyAccount.id == null}">
							 <span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span> 
							</c:if>
							<c:if test="${bankPartyAccount.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                	<a href="#home" onclick=bankList(); data-toggle="tab" style="text-decoration:none;"> 
	                    <button type="button" class="btn btn-success" aria-disabled="false">
	                     	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
	                    </button>
	                    </a>
            	</security:authorize>
            	<%-- <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${bankPartyAccount.id != null}">
		                	<button type="button" id="bankSave"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button id="cancel"
		                        	class="btn btn-success"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
		                    </button>
	            	</c:if>
            	</security:authorize> --%>
		        </div>
        	</div>
        	</div>

</form:form>
	</div>
	</div>
</div>

    <script type="text/javascript">
        $(document).ready(function() {
            //alert('Hello Sai');
            firmId = ${firm.id};
            $("#address\\.countryCode").change(function() {
            	label = $('#address\\.countryCode option:selected').text();
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
                $.get("<c:url value='/getStates.do'/>", { countryId: $(this).val(), firmId:firmId }, function(data) {
                    populateStateDropdown($("#address\\.stateCode"), data);
                });
            });
        });

        function populateStateDropdown(select, data) {
            select.html('');
            select.append($('<option></option>').val("-1").html("Select"));
            $.each(data, function(id, option) {
                $.each(option, function(id, option) {
                    select.append($('<option></option>').val(option.key).html(option.value));

                });
            });
        }
    </script>

<script type="text/javascript" charset="utf-8">
var x = ${rowCount};
$('.addiconBank').click(function() {
if($("tr.phonerowBank").length < 5) {
/* var x = $("input[class^='input phoneField']").length ; */

$("table tbody").find("tr.phonerowBank:last").clone(true).insertAfter("tr.phonerowBank:last").find("input[class^='input phoneField']").attr({
		name: 'defaultPointOfContact.phoneList[' + (x) +'].contactDetail', 
		id: 'defaultPointOfContact.phoneList[' + (x) +'].contactDetail'})
		.val("");	

$("table tbody").find("tr.phonerowBank:last").find("select[class^='phone_type']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].subType',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].subType'})
	.val("");

$("table tbody").find("tr.phonerowBank:last").find("input[class='input_h1_id']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].id',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].id'})
	.val("");


$("table tbody").find("tr.phonerowBank:last").find("input[class='input_h1']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].pointOfContact',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].pointOfContact'});


firstrowLength();
++x;
};
});

$(".removeiconBank").click(function () {
	$(this).parent().parent().remove();
});		 

function firstrowLength () {
	if($("tr.phonerowBank").length > 1) {	
		$("tr.phonerowBank:last").find("td:last").find("a.removeiconBank").show();				
	}
}
function bankList(){
	$('#myTabs a:first').tab("show");
	 $('#home').show();
	 $('#foo').hide();
}

</script>

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 