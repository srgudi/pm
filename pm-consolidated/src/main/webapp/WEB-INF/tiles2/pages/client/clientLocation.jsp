<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style type="text/css">
.partySite fieldset p.error label {
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

form.partySite {
	width: 30em;
}

form.partySite label.error {
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
	$(document)
			.ready(
					function() {

						$.validator.addMethod("alphabetsOnly", function(value,
								element) {
							return this.optional(element)
									|| /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
						}, "Please enter a valid Name.");

						$.validator.addMethod("alphaNumeric", function(value,
								element) {
							return this.optional(element)
									|| /^[0-9A-Z-]+$/i.test(value);
						}, "Please enter valid Number.");

						$.validator
								.addMethod(
										"webUrl",
										function(value, element) {
											return this.optional(element)
													|| /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i
															.test(value);
										}, "Please enter valid Web URL.");

						$.validator
								.addMethod("phoneValidaion", function(value,
										element) {
									return this.optional(element)
											|| /^(\d{3}-\d{3}-\d{4})*$/i
													.test(value);
								},
										"Please enter valid Phone Number. For Ex: 646-222-3333");

						$.validator
								.addMethod("faxValidaion", function(value,
										element) {
									return this.optional(element)
											|| /^(\d{3}-\d{3}-\d{4})*$/i
													.test(value);
								},
										"Please enter valid Fax Number. For Ex: 123-456-7890");

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

						$.validator.addMethod("addressValidation", function(
								value, element) {
							return this.optional(element)
									|| /^[0-9A-Z-_#&{},.;\s]+$/i.test(value);
						}, "No Special Character allowed.");

					});
	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});
$().ready(function() {
	/* var editId = $("#id").val();
	// alert("hi"+editId); 
	var editStatus=new Boolean();
	//alert("hi"+editStatus);
	console.log(editStatus);
	  if (editId != "")
		{
		  editStatus = true;
		} */
	 $("#locSave").click(function() {
		 var container = $('div.error_container');
			// validate the form when it is submitted
			var validator = $("#partySite")
					.validate(
							{

								  rules: {	  
									'name' : {
										alphabetsOnly : true,
										minlength : 0,
										maxlength : 50
									},
									'partySiteType' : {
										required : true,
										min : 1
									},

									'defaultPointOfContact.contactName' : {
										alphabetsOnly : true,
										minlength : 0,
										maxlength : 50
									},
									'defaultPointOfContact.contactTitle' : {
										alphabetsOnly : true,
										minlength : 0,
										maxlength : 50
									},
									'defaultPointOfContact.webUrlList[0].contactDetail' : {
										webUrl : true
									},
									'defaultPointOfContact.emailList[0].contactDetail' : {
										email : true
									},
									'defaultPointOfContact.faxList[0].contactDetail' : {
										faxValidaion : true
									},
									'defaultPointOfContact.phoneList[0].contactDetail' : {
										required : true,
										phoneValidaion : true
									},
									'defaultPointOfContact.phoneList[0].subType' : {
										required : true,
										min : 1
									},
									'defaultPointOfContact.phoneList[1].contactDetail' : {
										required : true,
										phoneValidaion : true
									},
									'defaultPointOfContact.phoneList[1].subType' : {
										required : true,
										min : 1
									},
									'defaultPointOfContact.phoneList[2].contactDetail' : {
										required : true,
										phoneValidaion : true
									},
									'defaultPointOfContact.phoneList[2].subType' : {
										required : true,
										min : 1
									},
									'defaultPointOfContact.phoneList[3].contactDetail' : {
										required : true,
										phoneValidaion : true
									},
									'defaultPointOfContact.phoneList[3].subType' : {
										required : true,
										min : 1
									},
									'defaultPointOfContact.phoneList[4].contactDetail' : {
										required : true,
										phoneValidaion : true
									},
									'defaultPointOfContact.phoneList[4].subType' : {
										required : true,
										min : 1
									},

									'address.addressLine1' : {
										addressValidation : true,
										minlength : 0,
										maxlength : 100
									},
									'address.addressLine2' : {
										addressValidation : true,
										minlength : 0,
										maxlength : 100
									},
									'address.city' : {
										alphabetsOnly : true,
										minlength : 0,
										maxlength : 50
									},
									'address.countryCode' : {
										
									},
									'address.stateCode' : {
										
									} ,
									'address.postalCode' : {
										postalCode : true
										,maxlength: 10
									} 
								},
								messages : {
									'name' : {
										required : "Location Name is required",
										alphabetsOnly : "No Special Charcters allowed. Please enter a valid Location Name",
										minlength : "Enter Location Name with at least {0} characters.",
										maxlength : "Enter Location Name with no more than {0} characters."
									},
									'partySiteType' : "Enter Type of Location",

									'defaultPointOfContact.contactName' : {
										required : "Contact Name is required",
										alphabetsOnly : "No Special Charcters allowed. Please enter a Valid Contact Name",
										minlength : "Enter Contact Name with at least {0} characters.",
										maxlength : "Enter Contact Name with no more than {0} characters."
									},
									'defaultPointOfContact.contactTitle' : {
										required : "Title is required",
										alphabetsOnly : "No Special Charcters allowed. Please enter a Valid	Title",
										minlength : "Enter Title with at least {0} characters.",
										maxlength : "Enter Title with no more than {0} characters."
									},
									'defaultPointOfContact.webUrlList[0].contactDetail' : {
										required : "Weburl is required",
										webUrl : " Please enter a Valid Web"
									},
									'defaultPointOfContact.emailList[0].contactDetail' : {
										required : "Email Address is required",
										email : "No Special Charcters allowed. Please enter valid Email Address."
									},
									'defaultPointOfContact.faxList[0].contactDetail' : {
										required : "Fax is required",
										faxValidaion : "No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890"
									},
									'defaultPointOfContact.phoneList[0].contactDetail' : {
										required : "1st Phone No. is required",
										phoneValidaion:"Please enter valid Phone 1st Number. For Ex: 646-222-3333"	
									},
									'defaultPointOfContact.phoneList[0].subType' : "Select one Phone Type for 1st Phone No.",
									'defaultPointOfContact.phoneList[1].contactDetail' : {
										required : "2nd Phone No. is required",
										phoneValidaion:"Please enter valid Phone 2nd Number. For Ex: 646-222-3333"	
									},
									'defaultPointOfContact.phoneList[1].subType' : "Select one Phone Type for 2nd Phone No.",
									'defaultPointOfContact.phoneList[2].contactDetail' : {
										required : "3rd Phone No. is required",
										phoneValidaion:"Please enter valid Phone 3rd Number. For Ex: 646-222-3333"	
									},
									'defaultPointOfContact.phoneList[2].subType' : "Select one Phone Type for 3rd Phone No.",
									'defaultPointOfContact.phoneList[3].contactDetail' : {
										required : "4th Phone No. is required",
										phoneValidaion:"Please enter valid Phone 4th Number. For Ex: 646-222-3333"	
									},
									'defaultPointOfContact.phoneList[3].subType' : "Select one Phone Type for 4th Phone No.",
									'defaultPointOfContact.phoneList[4].contactDetail' : {
										required : "5th Phone No. is required",
										phoneValidaion:"Please enter valid Phone 5th Number. For Ex: 646-222-3333"	
									},
									'defaultPointOfContact.phoneList[4].subType' : "Select one Phone Type for 5th Phone No.",

									'address.addressLine1' : {
										required : "Address Line 1 is required",
										addressValidation:"No Special Character allowed in Address Line 1.",
										minlength : "Enter Address Line 1 with at least {0} characters.",
										maxlength : "Enter Address Line 1 with no more than {0} characters."
									},
									'address.addressLine2' : {
										required : "Address Line 2 is required",
										addressValidation:"No Special Character allowed in Address Line 2.",
										minlength : "Enter Address Line 2 with at least {0} characters.",
										maxlength : "Enter Address Line 2 with no more than {0} characters."
									},
									'address.city' : {
										required : "City is required",
										alphabetsOnly : "No Special Charcters allowed. Please enter a valid City",
										minlength : "Enter City with at least {0} characters.",
										maxlength : "Enter City with no more than {0} characters."
									},
									'address.countryCode' : "Select one Country",
									'address.stateCode' : "Select any one Country to get State/Province",
									'address.postalCode' : {
										required : "Postal Code is required",
										postalCode : "Please enter a valid postal code."+errormsg,
										minlength : "Enter Postal Code with at least {0} characters.",
										maxlength : "Enter Postal Code with no more than {0} characters."
									}
								},
								errorContainer : container,
								errorLabelContainer : $("ol",
										container),
								wrapper : 'li',
								meta : "validate",
								submitHandler: function(form) {
		
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#partySite').serialize(),
				        url: 'clientLocation.do',
				        success: function(id) {
				             if(id != -1){
			            		$.jGrowl("Record saved successfully");
			            		//$("#locList").setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
			        			var clientId = ${clientId};
			        			/* var tableName = '#getAllLoc';
			        			var gridURL = 'locationList.do?clientId='+ clientId;
			        			reloadGrid(tableName, gridURL); */
			        			$('#getAllLoc').dataTable().fnReloadAjax('locationList.do?clientId='+ clientId);
			        			if($("#id").val()!=""){
			        				 $('#locationhome').show();
			        				 $('#locationfoo').hide();
			        				 $('#locationTabs a:last').tab('show');
			        			}
			        			else
			        			{
			        			/* document.getElementById("partySite").reset(); */
			        				$('#locationfoo').load('clientLocation.do');
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
	 
	 $("#newLocation").click(function(){
			$('#locationfoo').load('clientLocation.do');
	 });
	 
	 
	 $("#backToList").click(function(){
			$('#list').load('clientLocList.do');
			$('#clientLocationTabs a:first').tab('show');
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
	<h7><b>Please correct the following errors </b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<!-- <span class="legend b">Client Location Information</span> -->
    <div class="f13">
				<form:form modelAttribute="partySite" method="POST"		action="clientLocation.do">
				<input type="hidden" name="inValidClientId"	value="${param.inValidClientId }" />
				<b><form:errors path="*" class="errorblock" element="div" /></b>
								
				<b><strong>${inValidClientId}</strong> </b>

					<br />
					<form:hidden path="id" />
					<input type="hidden" name="clientId" id="clientId"
						value="${clientId}" />
					<form:hidden path="party.id" />
            

 <div class="container_12 mt20">
 </br>
 
         <div class="row">	
				 <div class="span3">
				 <form:label path="name"><spring:message code="label.locationname"/></form:label>
                 <form:input path="name" cssClass="formInput" tabindex="1"/>
				 </div>
				 <div class="span3">
				 <form:label  path="partySiteType"><spring:message code="label.typeoflocation"/></form:label>
                 <form:select path="partySiteType" tabindex="2" cssClass="formSelect">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${partySiteTypeCodeSet}" itemValue="id" itemLabel="name"/>
                   		</form:select>
				 </div>
				 <div class="span3">
				 <form:label path="address.addressLine1"><spring:message code="label.addressline1"/></form:label>
                 <form:input cssClass="formInput" path="address.addressLine1" class="input"
                        tabindex="3"/>
				 </div>
				</div>
				
				<div class="row">	
				 <div class="span3">
				 <form:label path="address.addressLine2"><spring:message code="label.addressline2"/></form:label>
                 <form:input cssClass="formInput" path="address.addressLine2" class="input"
                        tabindex="4"/>
				 </div>
				 <div class="span3">
				 <form:label path="address.city"><spring:message code="label.city"/></form:label>
                 <form:input cssClass="formInput" path="address.city" class="input"
                        tabindex="5"/>
				 </div>
				 <div class="span3">
				 <form:label path="address.countryCode"><spring:message code="label.country"/></form:label>
                 <form:select
                    path="address.countryCode" cssClass="formSelect" tabindex="6">
                <form:option value="-1" label="Select"/>
                <form:options items="${countryCodeSet}" itemValue="key"
                              itemLabel="value"/>
            </form:select>
				 </div>
				</div>
				<div class="row">	
				 <div class="span3">
				 <form:label path="address.stateCode"><spring:message code="label.state"/></form:label> 
                 <form:select path="address.stateCode" cssClass="formSelect" tabindex="7">
                <form:option value="-1" label="Select"/>
                <form:options items="${statesSet}" itemValue="key"
                              itemLabel="value"/>
            </form:select> 
				 </div>
				 <div class="span3">
				 <form:label path="address.postalCode" cssClass="input_full"><spring:message code="label.postelcode"/></form:label>
                 <form:input path="address.postalCode" cssClass="formInput" tabindex="8"/>
				 </div>
				 <div class="span3">
				 <form:label path="defaultPointOfContact.contactName"><spring:message code="label.contactname"/></form:label>
                 <form:input cssClass="formInput" path="defaultPointOfContact.contactName" class="input"
                        tabindex="9"/>
				 </div>
				</div>
				
				<div class="row">	
				 <div class="span3">
				 <form:label path="defaultPointOfContact.contactTitle"><spring:message code="label.contacttitle"/></form:label>
                 <form:input cssClass="formInput" path="defaultPointOfContact.contactTitle" class="input"
                        tabindex="10"/>
				 </div>
				 <div class="span3">
				 <c:forEach
                    items="${partySite.defaultPointOfContact.emailList}"
                    var="email" varStatus="cStatus">

               <form:label path="defaultPointOfContact.emailList" cssClass="input_full"><spring:message code="label.emailAddress"/></form:label>
            
                <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                        tabindex="11" cssClass="formInput"/>
                </c:forEach>
                        
				 </div>
				 <div class="span3">
				 <c:forEach
                    items="${partySite.defaultPointOfContact.faxList}"
                    var="contact" varStatus="cStatus">
                    
             <form:label path="defaultPointOfContact.faxList" cssClass="input_full"><spring:message code="label.faxnumber"/></form:label>  
            
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                        tabindex="12" cssClass="formInput"/>
              </c:forEach> 
				 </div>
				</div>
				<div class="row">	
				 <div class="span6">
				 <form:label path="defaultPointOfContact.phoneList"><spring:message code="label.phoneno"/></form:label>
				 <c:set var="phoneCount" value="0"/>
            			<c:set var="tabOrder" value="13"/>
            			 <table width="100%">
            			<c:forEach items="${partySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			               <c:set var="rowCounter" value="${cStatus}"/>
			               <c:set var="rowCount" value="${rowCounter.count}"/>
			                    <tr class="phonerowForLocation">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
			                        <td width="20%"><form:input style="width: 150px;"
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"
			                                cssClass="input phoneFieldForLocation" tabindex="${tabOrder}"/>
			                        </td>
			                        <form:hidden
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].id"
			                                class="input_h1_id"/>
			                        <form:hidden
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"
			                                class="input_h1"/>
									<td width="3%"></td>
			                        <% /** Phone Type **/ %>
			                         <td width="7%" class="grid_4 right" style="text-align:top;"><spring:message code="label.phonetype"/></td>
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
			                                class="addiconForLocation" />
			                        </a> &nbsp; <a href='javascript:;' class='removeiconForLocation'
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
				
</br>
			<div class="row">
            
	            <div class="span">
            	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	
	                    	<%-- <button type="button" id="newLocation"
	                        	    class="btn btn-primary"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.newlocation"/></span>
	                    	</button> --%>
	                	&nbsp;&nbsp;
	
	                	<button id="locSave"
							class="btn btn-success">
							<c:if test="${partySite.id == null}">
							<span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</c:if>
							<c:if test="${partySite.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    <a href="#home" onclick="locList()" data-toggle="tab" style="text-decoration:none;"> 
	                    <button type="button"
	                        	class="btn btn-success" aria-disabled="false">
	                     	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
	                    </button>
	                    </a>
            	</security:authorize>
            	<%-- <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${partySite.id != null}">
		                	<button type="button" id="locSave"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="btn btn-success"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
		                    </button>
	            	</c:if>
            	</security:authorize> --%>
		        </div>
        	</div>   
        	 </div>     	
        	<div class="container_12" style="margin:0px;"></div>
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
					$.get("<c:url value='/getStates.do'/>", {
						countryId : $(this).val(),
						firmId : firmId
					}, function(data) {
						populateDropdown($("#address\\.stateCode"), data);
					});
				});
			});
			
			$(document).ready(function() {
				var partySiteTypeId = $("#partySiteType").val();
				if(partySiteTypeId == 1){
					document.getElementById('partySiteType').disabled= true;
				}else{
					document.getElementById('partySiteType').disabled = false;
				}
			});

			function populateDropdown(select, data) {
				select.html('');
				select.append($('<option></option>').val("-1").html("Select"));
				$.each(data, function(id, option) {
					$.each(option, function(id, option) {
						select.append($('<option></option>').val(option.key)
								.html(option.value));

					});
				});
			}
		</script>
		<script type="text/javascript" charset="utf-8">
		var x = ${rowCount};
			$('.addiconForLocation')
					.click(
							function() {
								if ($("tr.phonerowForLocation").length < 5) {
									/* var x = $("input[class^='input phoneFieldForLocation']").length; */

									$("table tbody")
											.find("tr.phonerowForLocation:last")
											.clone(true)
											.insertAfter("tr.phonerowForLocation:last")
											.find(
													"input[class^='input phoneFieldForLocation']")
											.attr(
													{
														name : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].contactDetail',
														id : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].contactDetail'
													}).val("");

									$("table tbody")
											.find("tr.phonerowForLocation:last")
											.find("select[class^='phone_type']")
											.attr(
													{
														name : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].subType',
														id : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].subType'
													}).val("");

									$("table tbody")
											.find("tr.phonerowForLocation:last")
											.find("input[class='input_h1_id']")
											.attr(
													{
														name : 'defaultPointOfContact.phoneList['
																+ (x) + '].id',
														id : 'defaultPointOfContact.phoneList['
																+ (x) + '].id'
													}).val("");

									$("table tbody")
											.find("tr.phonerowForLocation:last")
											.find("input[class='input_h1']")
											.attr(
													{
														name : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].pointOfContact',
														id : 'defaultPointOfContact.phoneList['
																+ (x)
																+ '].pointOfContact'
													});

									firstrowLength();
									++x;
								}
								;
							});

								$(".removeiconForLocation").click(function() {
									$(this).parent().parent().remove();
								});

			function firstrowLength() {
				if ($("tr.phonerowForLocation").length > 1) {
					$("tr.phonerowForLocation:last").find("td:last").find("a.removeiconForLocation")
							.show();
				}
			}
			function locList(){
				$('#locationTabs a:first').tab("show");
				 $('#locationhome').show();
				 $('#locationfoo').hide();
			}
		</script>

<script type="text/javascript">
$(document).ready(function(){ 
	<c:if test="${statusMessageKey eq 'save.msg.success'}">
	   $.jGrowl('Record Saved Sucessfully'); 
	</c:if>
 });
</script>

