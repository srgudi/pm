<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<style type="text/css">
div.error_container {
	background-color: #eee;
	border: 2px solid red;
	width: 40em;
}

div.error_container ol li {
	list-style-type: disc;
}

div.error_container {
	display: none
}

.error_container label.error {
	display: inline;
}

form.party label.error {
	display: block;
	margin-left: 1em;
	width: auto;
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
    $(document).ready(function() {
        firmId = ${firm.id};
        $("#party\\.defaultPartySite\\.address\\.countryCode").change(function() {
            $.get("<c:url value='/getStates.do'/>", { countryId: $(this).val(), firmId:firmId }, function(data) {
                populateDropdown($("#party\\.defaultPartySite\\.address\\.stateCode"), data);
            });
        });
      $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name");

        $.validator.addMethod("alphaNumeric", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);
        }, "Please enter valid Number.");

        $.validator.addMethod("yearEndDate", function(value, element) {
            return this.optional(element) || /^(0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/i.test(value);
        }, "Please enter a valid Date in MM-DD format.");

        $.validator.addMethod("businessNumber", function(value, element) {
            return this.optional(element) || /^(\d{9})$/i.test(value);
        }, "Please enter a valid Business Number with 9 digit format."); 

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
<script type="text/javascript">
$().ready(function() {
	$("#mobileSave").click(function() {
		//alert("client save "+$("#id").val());
		if($('#organization').validate({
			 rules:{
					'legalName':{required: true, alphabetsOnly: true, minlength: 0, maxlength: 50},
			        'operatingName': {alphabetsOnly: true, minlength: 0, maxlength: 50},
			        'formOfBusiness': {required: true,min:1},
			        'businessIdentificationNumber': {digits: true,businessNumber: true},
	                'incorporationDate': {date: true},
	                'incorporationNumber': {alphaNumeric: true, minlength: 0, maxlength: 15},
	                'industryType': {required: true,min:1},
	                'yearEndDate': {required: true,yearEndDate: true},
	                'party.defaultPartySite.address.countryCode': {},
	                'party.defaultPartySite.address.stateCode': {},
	                'authorizedCapital': {minlength: 0, maxlength: 1000},
	                'issuedCaptial': {minlength: 0, maxlength: 1000},
	                'inChargePerson': {required: true,min:1}
				},
				 messages: {
			         'legalName': {
			             required: "Legal Name of Client is required",
			             alphabetsOnly: "No Special Charcters allowed. Please enter a valid Legal Name of Client",
			             minlength: "Enter Legal Name of Client at least {0} characters.",
			             maxlength: "Enter Legal Name of Client no more than {0} characters."},
			         'operatingName': {
			             required: "Operating Name is required",
			             alphabetsOnly: "No Special Charcters allowed.please enter a valid 	Operating Name",
			             minlength: "Enter Operating Name at least {0} characters.",
			             maxlength: "Enter Operating Name no more than {0} characters."},
			             'formOfBusiness': "Select one Form of Business",
			                'businessIdentificationNumber': {
			                    required: "Business Number is required",
			                    alphaNumeric:"No Special Charcters allowed.please enter a valid Business Number",
			                    digits: "Enter Business Number only digits.",
			                    range: "Please enter valid Business Number with 9 digits.For Ex: 111222333"},
			                'incorporationDate': {
			                    required: "Incorporation Date is required",
			                    date: "No Special Charcters allowed. Please Enter valid DATE."},
			                'incorporationNumber': {
			                    required: "Incorporation Number is required",
			                    alphaNumeric: "No Special Charcters allowed. Please Enter Incorporation Number.",
			                    minlength: "Enter Incorporation Number at least {0} characters.",
			                    maxlength: "Enter Incorporation Number no more than {0} characters."},
			                'industryType': "Select one Industry",
			                'yearEndDate': {
			                    required: "Year End Date is required",
			                    yearEndDate: "Invalid! Please Enter valid DATE in MM-DD format.For Ex: 01-12"},
			                'party.defaultPartySite.address.countryCode': "Select one Country",
			                'party.defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
			                'authorizedCapital': {
			                    required: "Authorized capital is required",
			                    minlength: "Enter Authorized capital with at least {0} characters.",
			                    maxlength: "Enter Authorized capital with no more than {0} characters."},
			                'issuedCaptial': {
			                    required: "Issued capital is required",
			                    minlength: "Enter Issued capital with at least {0} characters.",
			                    maxlength: "Enter Issued capital with no more than {0} characters."},
			                'inChargePerson': "Select one Partner-In-Charge"
				 }
				 }).form()) { 
                	$.ajax({
		            dataType: 'json',
		            type: 'POST',
	                data: $('#organization').serialize(),
			        url: 'mobileClientDetail.do',
			        complete: function(clientId) {
			        	//alert("hi");
			              	if(clientId != -1){
		            			$.jGrowl("Record saved successfully");
		            			if($("#id").val()!=""){
		            				//alert("hi");
		            				window.location="mainMobileClient.do";
		            			}else{
		            				document.getElementById("organization").reset();
		            				$("#getAllClient").dataTable().fnDraw();
		            			}
		            		}
		            	 else{
		            		 $.jGrowl("As Error has happened while process. ");	
		            	 } 
		            }
			});
	 return false;
		}
		 else{
			return false;
		} 
				//}
	//$("#organization").submit();
 });
	
});
</script>
<%-- 
<c:url value="/mobileclient/mobileClientDetail.do" var="mobileClientDetail"> 
</c:url> --%>

<%-- <a href="<c:out value='${mobileClientDetail}'/>" style="text-decoration:none;">
	                    	 <button type="button" 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Client</span>
	                    	</button> 
	                	</a> --%>
<div class="error_container">
	<h7> <b>Please correct the following errors</b></h7>
	<ol></ol>
</div>
<form:form modelAttribute="organization">
	<input type="hidden" name="clientId" value="${param.clientId }" />
	<input type="hidden" name="baseURL" id="baseURL"
		value="mobileClientDetail.do" />
	<input type="hidden" name="clientPartyName"
		value="${param.clientPartyName }" />
	<input type="hidden" name="inValidClientId"
		value="${param.inValidClientId }" />
	<input type="hidden" name="firmPracticeId" id="firmPracticeId"
		value="${firmPracticeId}" />
	<form:hidden path="id" />

	<%--  <label>${inValidClientId}</label> --%>
	<div data-role="fieldcontain">
		<form:label path="legalName">Client Name</form:label>

		<form:input path="legalName" cssClass="input_full" tabindex="1" />

	</div>

	<div data-role="fieldcontain">
		<form:label path="operatingName">Operating Name</form:label>
		<!--   <fieldset data-role="controlgroup" data-mini="true"> -->
		<form:input path="operatingName" cssClass="input_full" tabindex="2" />
		<!--   </fieldset> -->
	</div>

	<div data-role="fieldcontain">
		<form:label path="formOfBusiness">Form of Business</form:label>

		<form:select path="formOfBusiness" tabindex="3" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${formOfBusinessCodeSet}" itemValue="key"
				itemLabel="value" />
		</form:select>

	</div>

	<div data-role="fieldcontain">
		<form:label path="businessIdentificationNumber">Business Number</form:label>

		<form:input path="businessIdentificationNumber" cssClass="input_full"
			tabindex="4" />

	</div>

	<div data-role="fieldcontain">
		<form:label path="incorporationNumber">Incorporation Number</form:label>

		<form:input path="incorporationNumber" cssClass="input_full"
			tabindex="5" />

	</div>

	<div data-role="fieldcontain">
		<form:label path="inChargePerson">Partner In Charge</form:label>

		<form:select path="inChargePerson" tabindex="6" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${partnerList}" itemValue="key"
				itemLabel="value" />
		</form:select>

	</div>

	<div data-role="fieldcontain">
		<form:label path="yearEndDate">Year End Date</form:label>

		<form:input path="yearEndDate" cssClass="input_full" tabindex="7" />

	</div>

	<div data-role="fieldcontain">
		<form:label path="industryType">Industry</form:label>

		<form:select path="industryType" tabindex="8" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${industryCodeSet}" itemValue="key"
				itemLabel="value" />
		</form:select>

	</div>

	<div data-role="fieldcontain">
		<form:label path="party.defaultPartySite.address.countryCode">Country</form:label>

		<form:select path="party.defaultPartySite.address.countryCode"
			tabindex="9" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${countryCodeSet}" itemValue="key"
				itemLabel="value" />
		</form:select>

	</div>

	<div data-role="fieldcontain">
		<form:label path="party.defaultPartySite.address.stateCode">State</form:label>

		<form:select path="party.defaultPartySite.address.stateCode"
			tabindex="10" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${statesSet}" itemValue="key" itemLabel="value" />
		</form:select>

	</div>

	<div data-role="fieldcontain">
		<form:label path="issuedCaptial">Issued Capital</form:label>

		<form:textarea path="issuedCaptial" name="issuedCaptial" tabindex="11"
			id="issuedCaptial" placeholder=""></form:textarea>

	</div>

	<div data-role="fieldcontain">
		<form:label path="authorizedCapital">Authorized Capital</form:label>

		<form:textarea path="authorizedCapital" name="authorizedCapital"
			tabindex="12" id="authorizedCapital" placeholder=""></form:textarea>

	</div>
	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">


		<button type="button" id="mobileSave"
			class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
			role="button" aria-disabled="false" data-inline="true"
			data-mini="true">
			<c:if test="${organization.id == null}">
				<span class="ui-button-text" tabindex="13">Save</span>
			</c:if>
			<c:if test="${organization.id != null}">
				<span class="ui-button-text" tabindex="13">Update</span>
			</c:if>
		</button>&nbsp;&nbsp;
						
	                	<!-- <button type="reset"
				              	id="btn-reset" 
				               	data-role="button"  data-inline="true" data-mini="true">
				             	<span class="ui-button-text">Cancel</span>
				        </button>&nbsp;&nbsp; -->

	</security:authorize>

	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
		<c:if test="${organization.id != null}">
			<button type="button" id="save"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				role="button" aria-disabled="false" data-inline="true"
				data-mini="true">
				<span class="ui-button-text" tabindex="13">Update</span>
			</button>&nbsp;&nbsp;
							
				             <!-- <button type="reset" 
				                   	id="btn-reset" 
				                   	data-role="button" data-inline="true" data-mini="true">
				                 	<span class="ui-button-text">Cancel</span>
				             </button>  -->


		</c:if>
	</security:authorize>

	<button type="button" id="newClient" tabindex="14"
		onclick="window.location='mainMobileClient.do';return false;"
		class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		data-role="button" aria-disabled="false" data-inline="true"
		data-mini="true">
		<span class="ui-button-text">Back</span>
	</button>
</form:form>

<script type="text/javascript">
$('#btn-reset').live('vclick', function() {
    console.log("reset button clicked");
 
    
    $('select option[value=""]').attr('selected', 'selected');
    $('select').selectmenu();
    $('select').selectmenu('refresh');
 
});
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
 });
</script>

