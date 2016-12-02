<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<%@ page isELIgnored="false"%>
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
	color: red;
	font-style: italic
}
</style>

<c:url value="/mobileclient/mobilecLocation.do"
	var="mobileLocationModuleUrl">
	<c:param name="clientId" value="${param.clientId}" />
</c:url>

<script type="text/javascript">
var label;
var errormsg;
	$(document).ready(function() {

$.validator.addMethod("alphabetsOnly", function(value,element) {
	return this.optional(element)|| /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
}, "Please enter a valid Name.");

$.validator.addMethod("alphaNumeric", function(value,element) {
	return this.optional(element)|| /^[0-9A-Z-]+$/i.test(value);
}, "Please enter valid Number.");

$.validator.addMethod("webUrl",function(value, element) {
	return this.optional(element)|| /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i.test(value);
}, "Please enter valid Web URL.");

$.validator.addMethod("phoneValidaion", function(value,element) {
	return this.optional(element)|| /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
}, "Please enter valid Phone Number. For Ex: 646-222-3333");

$.validator.addMethod("faxValidaion", function(value,element) {
	return this.optional(element)|| /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
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
	return this.optional(element)|| /^[0-9A-Z-_#&{},.;\s]+$/i.test(value);
}, "No Special Character allowed.");

});
$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
});

$().ready(function() {
	var locId = $("#id").val();
	    var status = new Boolean();
	    if(locId != ""){
	    	status = true;
	    }

	$("#save").click(function() {
		if ($("#partySite").validate({
					rules : {
						'name' : {
							required:true,
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
							required:true,
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
						'address.countryCode' : {},
						'address.stateCode' : {},
						'address.postalCode' : {
							postalCode : true,
							maxlength : 10
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
							phoneValidaion : "Please enter valid Phone 1st Number. For Ex: 646-222-3333"
						},
						'defaultPointOfContact.phoneList[0].subType' : "Select one Phone Type for 1st Phone No.",
						'defaultPointOfContact.phoneList[1].contactDetail' : {
							required : "2nd Phone No. is required",
							phoneValidaion : "Please enter valid Phone 2nd Number. For Ex: 646-222-3333"
						},
						'defaultPointOfContact.phoneList[1].subType' : "Select one Phone Type for 2nd Phone No.",
						'defaultPointOfContact.phoneList[2].contactDetail' : {
							required : "3rd Phone No. is required",
							phoneValidaion : "Please enter valid Phone 3rd Number. For Ex: 646-222-3333"
						},
						'defaultPointOfContact.phoneList[2].subType' : "Select one Phone Type for 3rd Phone No.",
						'defaultPointOfContact.phoneList[3].contactDetail' : {
							required : "4th Phone No. is required",
							phoneValidaion : "Please enter valid Phone 4th Number. For Ex: 646-222-3333"
						},
						'defaultPointOfContact.phoneList[3].subType' : "Select one Phone Type for 4th Phone No.",
						'defaultPointOfContact.phoneList[4].contactDetail' : {
							required : "5th Phone No. is required",
							phoneValidaion : "Please enter valid Phone 5th Number. For Ex: 646-222-3333"
						},
						'defaultPointOfContact.phoneList[4].subType' : "Select one Phone Type for 5th Phone No.",
						'address.addressLine1' : {
							required : "Address Line 1 is required",
							addressValidation : "No Special Character allowed in Address Line 1.",
							minlength : "Enter Address Line 1 with at least {0} characters.",
							maxlength : "Enter Address Line 1 with no more than {0} characters."
						},
						'address.addressLine2' : {
							required : "Address Line 2 is required",
							addressValidation : "No Special Character allowed in Address Line 2.",
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
							postalCode : "Please enter a valid postal code."
									+ errormsg,
							minlength : "Enter Postal Code with at least {0} characters.",
							maxlength : "Enter Postal Code with no more than {0} characters."
						}
					}
				}).form()) {
	$.ajax({
				dataType : 'json',
				type : 'POST',
				data : $('#partySite').serialize(),
				url : 'mobileclientLocation.do',
				success : function(id) {
					if (id != -1) {
						$.jGrowl("Record saved successfully");
						if (status == true) {
							var clientId = ${clientId};
							window.location = 'mobilecLocation.do?clientId='+ clientId+ '&id='+ locId;
						} else {
							var clientId = ${clientId};
							$("#getAllLoc").dataTable().fnReloadAjax('mobileLocationList.do?clientId='+ clientId);
							document.getElementById("partySite").reset();
						}
					} else {
						$.jGrowl("As Error has happened while process. ");
					}
				}
			});
	return false;
} else {
	return false;
}
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

<div class="error_container">
	<h7> <b>Please correct the following errors </b></h7>
	<ol></ol>
</div>
<form:form modelAttribute="partySite" method="POST"
	action="mobileclientLocation.do">
	<input type="hidden" name="inValidClientId"
		value="${param.inValidClientId }" />
	<b><form:errors path="*" class="errorblock" element="div" /> </b>
	<b><strong>${inValidClientId}</strong> </b>
	<br />
	<form:hidden path="id" />
	<input type="hidden" name="clientId" id="clientId"
		value="${param.clientId}" />
	<form:hidden path="party.id" />

	<div data-role="fieldcontain">
		<form:label path="name">Location Name</form:label>
		<form:input path="name" cssClass="input_full" tabindex="1" />
	</div>
	<div data-role="fieldcontain">
		<form:label path="partySiteType">Type of Location</form:label>
		<form:select path="partySiteType" tabindex="2" style="width: 100%">
			<form:option value="-1" label="Select" />
			<form:options items="${partySiteTypeCodeSet}" itemValue="id"
				itemLabel="name" />
		</form:select>
	</div>

	<div data-role="fieldcontain">

		<form:label path="address.addressLine1">Address Line 1</form:label>
		<form:input cssClass="input_full" path="address.addressLine1"
			class="input" tabindex="3" />
	</div>

	<div data-role="fieldcontain">
		<form:label path="address.addressLine2">Address Line 2</form:label>
		<form:input cssClass="input_full" path="address.addressLine2"
			class="input" tabindex="4" />
	</div>


	<div data-role="fieldcontain">
		<form:label path="address.city">City</form:label>
		<form:input cssClass="input_full" path="address.city" class="input"
			tabindex="5" />
	</div>
	<div data-role="fieldcontain">
		<form:label path="address.countryCode">Country</form:label>
		<form:select path="address.countryCode" cssClass="input_full"
			tabindex="6">
			<form:option value="-1" label="Select" />
			<form:options items="${countryCodeSet}" itemValue="key"
				itemLabel="value" />
		</form:select>
	</div>
	<div data-role="fieldcontain">
		<form:label path="address.stateCode">State/Province</form:label>
		<form:select path="address.stateCode" cssClass="input_full"
			tabindex="7">
			<form:option value="-1" label="Select" />
			<form:options items="${statesSet}" itemValue="key" itemLabel="value" />
		</form:select>
	</div>

	<div data-role="fieldcontain">
		<form:label path="address.postalCode" cssClass="input_full">Postal Code</form:label>
		<form:input path="address.postalCode" cssClass="input_full"
			tabindex="8" />
	</div>

	<div data-role="fieldcontain">
		<form:label path="defaultPointOfContact.contactName">Contact Name</form:label>
		<form:input cssClass="input_full"
			path="defaultPointOfContact.contactName" class="input" tabindex="9" />
	</div>
	<div data-role="fieldcontain">
		<form:label path="defaultPointOfContact.contactTitle">Contact Title</form:label>
		<form:input cssClass="input_full"
			path="defaultPointOfContact.contactTitle" class="input" tabindex="10" />
	</div>

	<c:forEach items="${partySite.defaultPointOfContact.emailList}"
		var="email" varStatus="cStatus">
		<div data-role="fieldcontain">
			<form:label class ="ui-input-text" path="defaultPointOfContact.emailList"
				>Email Address</form:label>
			<form:hidden
				path="defaultPointOfContact.emailList[${cStatus.index}].id" />
			<form:hidden
				path="defaultPointOfContact.emailList[${cStatus.index}].pointOfContact" />
			<form:input
				path="defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
				tabindex="11" cssClass="input_full" />
		</div>
	</c:forEach>


	<c:forEach items="${partySite.defaultPointOfContact.faxList}"
		var="contact" varStatus="cStatus">
		<div data-role="fieldcontain">
			<form:label class ="ui-input-text" path="defaultPointOfContact.faxList"
				>Fax Number</form:label>
			<form:hidden
				path="defaultPointOfContact.faxList[${cStatus.index}].id" />
			<form:hidden
				path="defaultPointOfContact.faxList[${cStatus.index}].pointOfContact" />
			<form:input
				path="defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
				tabindex="12" cssClass="input_full" />
		</div>
	</c:forEach>

	<div data-role="fieldcontain">

		<form:label class ="ui-input-text" path="defaultPointOfContact.phoneList">Phone No.</form:label>

		<c:set var="phoneCount" value="0" />
		<c:set var="tabOrder" value="13" />
		<c:forEach items="${partySite.defaultPointOfContact.phoneList}"
			var="contact" varStatus="cStatus">
			<table width="100%">
				<tr class="phonerow">
					<td width="20%"><form:input
							path="defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"
							cssClass="input phoneField" tabindex="${tabOrder}" />
					</td>
					<form:hidden
						path="defaultPointOfContact.phoneList[${cStatus.index}].id"
						class="input_h1_id" />
					<form:hidden
						path="defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"
						class="input_h1" />
					<td width="3%"></td>
					<%
						/** Phone Type **/
					%>
					<td width="7%" class="grid_4 right"
						style="text-align: center; color: #00498F">Type</td>
					<c:set var="displayStyle" value="display:show;" />
					<c:if test="${phoneCount == 0}">
						<c:set var="displayStyle" value="display:none;" />
					</c:if>
					<c:set var="tabOrder" value="${tabOrder}++" />
					<td class="row-nav1"><form:select
							path="defaultPointOfContact.phoneList[${cStatus.index}].subType"
							id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
							<form:option value="-1" label="Select" />
							<form:options items="${phoneCommunicationTypeSet}"
								itemValue="value" itemLabel="key" />
						</form:select> <a href="javascript:;" class="addphone"
						style="text-decoration: none;"><img
							src="<c:url value='/images/add_icon.gif'/>" width="20"
							height="15" alt="Add Phone Number" title="Add Phone Number"
							class="addicon" /> </a> &nbsp; <a href='javascript:;'
						class='removeicon' style="${displayStyle}"><img
							src='<c:url value='/images/remove_icon.gif'/>' width='20'
							height='15' alt='Remove Phone Number' title='Remove Phone Number' />
					</a>
					</td>
				</tr>
				<c:set var="phoneCount" value="${phoneCount}++" />
			</table>
		</c:forEach>
	</div>
	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
		<button type="button" id="save"
			class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
			role="button" aria-disabled="false" data-inline="true"
			data-mini="true">
			<c:if test="${partySite.id == null}">
				<span class="ui-button-text" tabindex="16">Save</span>
			</c:if>
			<c:if test="${partySite.id != null}">
				<span class="ui-button-text" tabindex="16">Update</span>
			</c:if>
		</button>
						&nbsp;&nbsp;
            	</security:authorize>
	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
		<c:if test="${partySite.id != null}">
			<button type="button" id="save"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				role="button" aria-disabled="false" data-inline="true"
				data-mini="true">
				<span class="ui-button-text" tabindex="16">Update</span>
			</button>
		</c:if>
	</security:authorize>
	<a href="<c:out value='${mobileLocationModuleUrl}'/>"
		style="text-decoration: none;">
		<button type="button" id="form" onclick="hideLocationForm()"
			class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
			role="button" aria-disabled="false" data-inline="true"
			data-mini="true">
			<span class="ui-button-text">Back</span>
		</button> </a>&nbsp;&nbsp;
</form:form>

<script type="text/javascript">
	$(document).ready(function() {
	//alert('Hello Sai');    
	firmId = ${firm.id};
	$("#address\\.countryCode").change(function() {
			
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
	if(partySiteTypeId == 1)
		document.getElementById('partySiteType').disabled= true;
	else
		document.getElementById('partySiteType').disabled = false;
});

function populateDropdown(select, data) {
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
$('.addicon').click(
function() {
if ($("tr.phonerow").length < 5) {
var x = $("input[class^='input phoneField']").length;

$("table tbody").find("tr.phonerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr(
	{name : 'defaultPointOfContact.phoneList['+ (x)+ '].contactDetail',
	id : 'defaultPointOfContact.phoneList['+ (x)+ '].contactDetail'}).val("");

$("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr(
	{name : 'defaultPointOfContact.phoneList['+ (x)+ '].subType',
	id : 'defaultPointOfContact.phoneList['+ (x)+ '].subType'}).val("");

$("table tbody").find("tr.phonerow:last").find("input[class='input_h1_id']").attr(
	{name : 'defaultPointOfContact.phoneList['+ (x) + '].id',
	id : 'defaultPointOfContact.phoneList['+ (x) + '].id'}).val("");

$("table tbody").find("tr.phonerow:last").find("input[class='input_h1']").attr(
	{name : 'defaultPointOfContact.phoneList['+ (x)+ '].pointOfContact',
	id : 'defaultPointOfContact.phoneList['+ (x)+ '].pointOfContact'});
	firstrowLength();
};
});

$(".removeicon").click(function() {
	$(this).parent().parent().remove();
});

function firstrowLength() {
	if ($("tr.phonerow").length > 1) {
		$("tr.phonerow:last").find("td:last").find("a.removeicon").show();
		}
}
</script>


