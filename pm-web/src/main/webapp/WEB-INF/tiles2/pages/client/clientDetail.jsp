<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<!-- MAIN CONTENT SECTION -->

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

<style type="text/css">
    .party fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        border: 2px solid red;

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
    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
    	$("#save").click(function() {

        var container = $('div.error_container');
        // validate the form when it is submitted
        var validator = $("#organization").validate({

            rules: {
                'legalName': {required: true, alphabetsOnly: true, minlength: 0, maxlength: 50},
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
            },
            errorContainer: container,
            errorLabelContainer: $("ol", container),
            wrapper: 'li',
            meta: "validate"
        });
        $("#organization").submit();
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
        width: auto;
    }
</style>

<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Client Details </span>
<div class="f13">
    <form:form name="organization" modelAttribute="organization" method="POST" action="clientDetail.do">
        <input type="hidden" name="clientId" value="${param.clientId }"/>
        <input type="hidden" name="baseURL" id="baseURL" value="clientDetail.do"/>
        <input type="hidden" name="clientPartyName" value="${param.clientPartyName }"/>
        <input type="hidden" name="inValidClientId" value="${param.inValidClientId }"/>
        <input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${firmPracticeId}"/>

        <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>

        <form:hidden path="id"/>
        <b><strong>${inValidClientId}</strong></b>
			
				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="legalName">Legal Name of Client</form:label></div>
                    <div class="grid_3 right"><form:input path="legalName" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="operatingName">Operating Name</form:label></div>
                    <div class="grid_3 right"><form:input path="operatingName" cssClass="input_full" tabindex="2"/></div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label  path="formOfBusiness">Form of Business</form:label></div>
                    <div class="grid_3 right"><form:select path="formOfBusiness" tabindex="3" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${formOfBusinessCodeSet}" itemValue="key"
										itemLabel="value" />
                   		</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="businessIdentificationNumber">Business Number</form:label></div>
                    <div class="grid_3 right"><form:input path="businessIdentificationNumber" cssClass="input_full" tabindex="4"/></div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="incorporationNumber">Incorporation Number</form:label></div>
                    <div class="grid_3 right"><form:input path="incorporationNumber" cssClass="input_full" tabindex="5"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="inChargePerson">Partner In Charge</form:label></div>
                    <div class="grid_3 right"><form:select path="inChargePerson" tabindex="6" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${partnerList}" itemValue="key" itemLabel="value"/>
                   		</form:select>
                    </div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="yearEndDate">Year End Date</form:label></div>
                    <div class="grid_3 right"><form:input path="yearEndDate" cssClass="input_full" tabindex="7"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="industryType">Industry</form:label></div>
                    <div class="grid_3 right"><form:select path="industryType" tabindex="8" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${industryCodeSet}" itemValue="key"
										itemLabel="value" />
                   		</form:select>
                    </div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label  path="party.defaultPartySite.address.countryCode">Country</form:label></div>
                    <div class="grid_3 right"><form:select path="party.defaultPartySite.address.countryCode" tabindex="9" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${countryCodeSet}" itemValue="key"
                                      itemLabel="value"/>
                   		</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="party.defaultPartySite.address.stateCode">State</form:label></div>
                    <div class="grid_3 right"><form:select path="party.defaultPartySite.address.stateCode" tabindex="10" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${statesSet}" itemValue="key"
                                      itemLabel="value"/>
                   		</form:select>
                    </div>
                </div>
                
            <%-- <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="emailAddress">Email Address</form:label></div>
                    <div class="grid_3 right"><form:input path="emailAddress" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="contactNumber">Contact Number</form:label></div>
                    <div class="grid_3 right"><form:input path="contactNumber" cssClass="input_full" tabindex="2"/></div>
                </div> --%>
                
		<div class="container_12 pt5">

            <div class="grid_2 right"><form:label path="issuedCaptial" cssClass="input_full">Issued Capital</form:label>      </div>
            <div class="grid_5 right"><form:textarea path="issuedCaptial"
				                           rows="3" cssClass="input_full" tabindex="13"/>      </div>
                        
             <div class="s1"></div>
                    
             <div class="grid_2 right">   </div>
            <div class="grid_3 right">    </div>
      </div>
      
		<div class="container_12 pt5">

            <div class="grid_2 right"><form:label path="authorizedCapital" cssClass="input_full">Authorized Capital</form:label>      </div>
            <div class="grid_5 right"><form:textarea path="authorizedCapital"
				                           rows="3" cssClass="input_full" tabindex="14"/>      </div>
                        
             <div class="s1"></div>
                    
             <div class="grid_2 right">   </div>
            <div class="grid_3 right">    </div>
      </div>

				<div class="container_12" style="margin: 10px;"></div>
			<div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
					<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="clientDetail.do" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	onclick="window.location='clientDetail.do';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">New Client</span>
	                    	</button>
	                	</a>&nbsp;&nbsp;
	
	                	<button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<c:if test="${organization.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${organization.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>&nbsp;&nbsp;
						
				        <button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text">Cancel</span>
				        </button>
            		</security:authorize>
            		<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            			<c:if test="${organization.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>&nbsp;&nbsp;
							
				             <button type="reset"
				                   	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				                   	role="button" aria-disabled="false">
				                 	<span class="ui-button-text">Cancel</span>
				             </button>
				             
	            		</c:if>
            		</security:authorize>
            		&nbsp;
            		<a href="clientList.do" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	onclick="window.location='clientList.do';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Back To Client List</span>
	                    	</button>
	                </a>
		        </div>
            </div>
				<div class="container_12" style="margin: 10px;"></div>
		</form:form>
</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 