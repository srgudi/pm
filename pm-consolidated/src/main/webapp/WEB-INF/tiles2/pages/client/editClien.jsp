<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

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
		.party fieldset p.error label { color: red; }
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
			div.error_container { display: none }
			.error_container label.error {
				display: inline;
			}
			form.party { width: 30em; }
			form.party label.error {
				display: block;
				margin-left: 1em;
				width: auto;
			}

			input:focus { border: 1px dotted black; }
			select:focus { border: 1px dotted black; }
			input.error { border: 2px solid red; }
			select.error {border: 2px solid red;}
			label.error {
				color: red;
				font-style: italic
			}
	</style>

<script type="text/javascript">
$().ready(function() {
	 $("#clientSave").click(function() {
		 
		 var container = $('div.error_container');
		 var validator = $("#organization").validate({
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
				 },   	
					errorContainer: container,
					errorLabelContainer: $("ol", container),
					wrapper: 'li',
					meta: "validate",	
					submitHandler: function(form) {
	
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#organization').serialize(),
				        url: 'clientDetail.do',
				        success: function(clientId) {
				        	$('#cboxClose').click();
				              	if(clientId != -1){
			            		$.jGrowl("Record saved successfully");
			            		}
			            	 else{
			            		 $.jGrowl("As Error has happened while process. ");	
			            	 } 
			            }
		
				});
		 return false;
					}
		 });
		//$("#organization").submit();
	 });
});
$().ready(function() {
	$("#cancel").live("click",function() {
		//alert("inside cancel");
		$('#cboxClose').click();
		 return false;
	});	
});

</script>

<!--  BUCKET -->
<div class="row-fluid">
<div class="span1"></div>
<div class="span10">
    <form:form name="organization" modelAttribute="organization" method="POST" action="">
        <input type="hidden" name="clientId" value="${param.clientId }"/>
        <input type="hidden" name="baseURL" id="baseURL" value="mainClient.do"/>
        <input type="hidden" name="clientPartyName" value="${param.clientPartyName }"/>
        <input type="hidden" name="inValidClientId" value="${param.inValidClientId }"/>
        <input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${firmPracticeId}"/>

        <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>

        <form:hidden path="id"/>
        <b><strong>${inValidClientId}</strong></b>
			
				<div class="container_12 mt20">
				 <div class="row">	
				<div class="span3">
				  <form:label path="legalName"><spring:message code="label.legalName"/></form:label>
                  <%-- <form:input path="legalName" cssClass="input_full" tabindex="1"/> --%>
                  <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="legalName" cssClass="input_full" tabindex="1" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="legalName" cssClass="input_full" tabindex="1"/>
		                  	</c:otherwise>
		                 </c:choose>
				</div>
				<div class="span3">
				<form:label   path="operatingName"><spring:message code="label.operatingName"/></form:label>
                <%-- <form:input path="operatingName" cssClass="input_full" tabindex="2"/> --%>
                <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="operatingName" cssClass="input_full" tabindex="2" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="operatingName" cssClass="input_full" tabindex="2"/>
		                  	</c:otherwise>
		                 </c:choose>
				</div>
				<div class="span3">
			       <form:label  path="formOfBusiness"><spring:message code="label.formOfBusiness"/></form:label>
                  <%--  <form:select path="formOfBusiness" tabindex="3" cssClass="input_full"> --%>
                  <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="formOfBusiness" cssClass="input_full" tabindex="3" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="formOfBusiness" cssClass="input_full" tabindex="3"/>
		                  		<form:option value="-1" label="Select"/>
                            <form:options items="${formOfBusinessCodeSet}" itemValue="key"
										itemLabel="value" />
		                  	</c:otherwise>
		                 </c:choose>
                   	</div>
                 </div> 
                  <div class="row">	
                	<div class="span3">
				   <form:label   path="businessIdentificationNumber"><spring:message code="label.businessNumber"/></form:label>
                   <%-- <form:input path="businessIdentificationNumber" cssClass="input_full" tabindex="4"/> --%>
                    <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="businessIdentificationNumber" cssClass="input_full" tabindex="4" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="businessIdentificationNumber" cssClass="input_full" tabindex="4"/> 
		                  	</c:otherwise>
		                 </c:choose>
                  </div>
                  <div class="span3"> 
                   <form:label   path="incorporationNumber"><spring:message code="label.incorporationNumber"/></form:label>
                  <%-- <form:input path="incorporationNumber" cssClass="input_full" tabindex="5"/> --%>
                  <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="incorporationNumber" cssClass="input_full" tabindex="5" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="incorporationNumber" cssClass="input_full" tabindex="5"/>
		                  	</c:otherwise>
		                 </c:choose>
                  
                    </div>
                     <div class="span3"> 
                   <form:label  path="inChargePerson"><spring:message code="label.partnerInCharge"/></form:label>
                   <%-- <form:select path="inChargePerson" tabindex="6" cssClass="input_full"> 
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${partnerList}" itemValue="key" itemLabel="value"/>
                   		</form:select>--%>
                   		<c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="inChargePerson" cssClass="input_full" tabindex="6" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:select path="inChargePerson" tabindex="6" cssClass="input_full"> 
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${partnerList}" itemValue="key" itemLabel="value"/>
                   		</form:select>
		                  	</c:otherwise>
		                 </c:choose>
                    </div>
                    </div>
                     <div class="row">	
                   <div class="span3"> 
                    <form:label   path="yearEndDate"><spring:message code="label.yearEndDate"/></form:label>
                    <%-- <form:input path="yearEndDate" cssClass="input_full" tabindex="7"/> --%>
                     <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="yearEndDate" cssClass="input_full" tabindex="7" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="yearEndDate" cssClass="input_full" tabindex="7"/>
		                  	</c:otherwise>
		                 </c:choose>
            </div>
             <div class="span3"> 
                    <form:label  path="industryType"><spring:message code="label.industry"/></form:label>
                   <%--  <form:select path="industryType" tabindex="8" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${industryCodeSet}" itemValue="key"
										itemLabel="value" />
                   		</form:select> --%>
                   		<c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="industryType" cssClass="input_full" tabindex="8" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="industryType" cssClass="input_full" tabindex="8"/>
		                  		<form:option value="-1" label="Select"/>
                            <form:options items="${industryCodeSet}" itemValue="key"
										itemLabel="value" />
		                  	</c:otherwise>
		                 </c:choose>
                     </div>
                  <div class="span3">     
                   <form:label  path="party.defaultPartySite.address.countryCode"><spring:message code="label.country"/></form:label>
                   <%-- <form:select path="party.defaultPartySite.address.countryCode" tabindex="9" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${countryCodeSet}" itemValue="key"
                                      itemLabel="value"/>
                   		</form:select> --%>
                   		<c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="party.defaultPartySite.address.countryCode" cssClass="input_full" tabindex="9" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="party.defaultPartySite.address.countryCode" cssClass="input_full" tabindex="9"/>
		                  		<form:option value="-1" label="Select"/>
                            <form:options items="${countryCodeSet}" itemValue="key"
										itemLabel="value" />
		                  	</c:otherwise>
		                 </c:choose>
                  </div>
                  </div>
                   <div class="row">	
                   <div class="span3">     
                   <form:label  path="party.defaultPartySite.address.stateCode"><spring:message code="label.state"/></form:label>
                  <%-- <form:select path="party.defaultPartySite.address.stateCode" tabindex="10" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${statesSet}" itemValue="key"
                                      itemLabel="value"/>
                   		</form:select> --%>
                   		<c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="party.defaultPartySite.address.stateCode" cssClass="input_full" tabindex="10" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="party.defaultPartySite.address.stateCode" cssClass="input_full" tabindex="10"/>
		                  		<form:option value="-1" label="Select"/>
                            <form:options items="${statesSet}" itemValue="key"
										itemLabel="value" />
		                  	</c:otherwise>
		                 </c:choose>
                   		</div>
                   	 <div class="span3"> 
                   	<form:label path="emailAddress"><spring:message code="label.emailAddress"/></form:label>
                    <%-- <form:input path="emailAddress" cssClass="input_full" tabindex="1"/> --%>
                     <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="emailAddress" cssClass="input_full" tabindex="1" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="emailAddress" cssClass="input_full" tabindex="1"/>
		                  	</c:otherwise>
		                 </c:choose>
                   	 </div>	
                   		 <div class="span3"> 
                   		  <form:label   path="contactNumber"><spring:message code="label.contactNumber"/></form:label>
                          <%-- <form:input path="contactNumber" cssClass="input_full" tabindex="2"/> --%>
                           <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="contactNumber" cssClass="input_full" tabindex="1" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="contactNumber" cssClass="input_full" tabindex="1"/>
		                  	</c:otherwise>
		                 </c:choose>
                   		 </div>
                   		 </div>
                   		 <div class="row">	
                   		  <div class="span3"> 
                   		  <form:label path="issuedCaptial" cssClass="input_full"><spring:message code="label.issuedCapital"/></form:label>
                          <%-- <form:textarea path="issuedCaptial" rows="3" cssClass="input_full" tabindex="13"/> --%>
                          <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="issuedCaptial" cssClass="input_full" tabindex="13" /> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="issuedCaptial" cssClass="input_full" tabindex="13"/>
		                  	</c:otherwise>
		                 </c:choose>
                   		 </div>	
                   		  <div class="span3"> 
                   		  <form:label path="authorizedCapital" cssClass="input_full"><spring:message code="label.authorisedCapital"/></form:label>
                         <%-- <form:textarea path="authorizedCapital" rows="3" cssClass="input_full" tabindex="14"/>  --%>   
                          <c:choose>
                  			<c:when test="${not empty param.clientId }">
                   				<form:input path="authorizedCapital" cssClass="input_full" tabindex="14"/> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:input path="authorizedCapital" cssClass="input_full" tabindex="14"/>
		                  	</c:otherwise>
		                 </c:choose>
                        </div>
                        </div>
                        <br></br>
                        <div class="row">
                        <div class="span">
                        <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="clientDetail.do" style="text-decoration:none;"> 
	                    	<button type="button" id="newClient"
	                        	    class="btn btn-primary">
	                        	<spring:message code="label.newClient" />
	                    	</button>&nbsp;&nbsp;
	                	</a> 
	
	                	<button id="clientSave" class="btn btn-success">
							<c:if test="${organization.id == null}">
							<span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</c:if>
							<c:if test="${organization.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>&nbsp;&nbsp;
						
				        <button id="cancel" class="btn btn-success">
				             	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				        </button>
            		</security:authorize>
            		
            		<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            			<c:if test="${organization.id != null}">
		                	<button type="button" id="clientSave"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>&nbsp;&nbsp;
							
				             <button id="cancel"
				                   	class="btn btn-inverse"
				                   	role="button" aria-disabled="false">
				                 	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				             </button>
				             
	            		</c:if>
            		</security:authorize>
            		&nbsp;
            		 <a href="mainClient.do" style="text-decoration:none;"> 
	                    	<button type="button" id="backToList"
	                        	    class="btn btn-primary">
	                        	<span class="ui-button-text"><spring:message code="label.backToClientList"/></span>
	                    	</button>
	              </a>
                        
                        </div>
                        </div>
                        </div>
		</form:form>
</div>
<div class="span1"></div>
</div>
