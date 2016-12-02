<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<!-- MAIN CONTENT SECTION -->
<div id="bd" style="margin: 10px;">
<div>
<script type="text/javascript">
$(document).ready(function() {
	$("#save_continue").click(function() {
		$("#clientmenu li").removeClass('hidemenu');
		window.location.href="clients_bankers.html";
	});
	$("#save").click(function() {		
		$("#party").submit();
	});
$("#content").find('.table-long').find('tr:last').find("td").css('background-image', 'none');	


$.validator.addMethod("alphabetsOnly", function(value, element) {  
    return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);  
},"Please enter a valid Name. For Ex: John William.P");


$.validator.addMethod("alphaNumeric", function(value, element) {  
    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
},"Please enter valid Number.");


});



</script>
<script type="text/javascript">
    $(document).ready(function() {
    	//alert('Hello Sai');    
    	firmId = ${firm.id};
        $("#defaultPartySite\\.address\\.countryCode").change(function() {     
            $.get("<c:url value='/getStates.do'/>", { countryId: $(this).val(), firmId:firmId }, function(data) {
                populateDropdown($("#defaultPartySite\\.address\\.stateCode"), data);
            });
        });
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
	
			var container = $('div.error_container');
			// validate the form when it is submitted
			var validator = $("#party").validate({
		
				rules: { 
				'organization.legalName': {required: true, alphabetsOnly: true, minlength: 0, maxlength: 50},
				'organization.operatingName': {required: true, alphabetsOnly: true, minlength: 0, maxlength: 50},
				'organization.formOfBusiness': {required: true,min:1},
				'organization.businessIdentificationNumber': {required: true, alphaNumeric: true, minlength: 0, maxlength: 15},
				'organization.incorporationDate': {required: true,date: true},
				'organization.incorporationNumber': {required: true, alphaNumeric: true, minlength: 0, maxlength: 15},
				'organization.industryType': {required: true,min:1},
				'organization.yearEndDate': {required: true,date: true},
				'defaultPartySite.address.countryCode': {required: true,min:1},
				'defaultPartySite.address.stateCode': {required: true,min:1},
				'organization.authorizedCapital': {minlength: 0, maxlength: 1000},
				'organization.issuedCaptial': {minlength: 0, maxlength: 1000}
        		}, 
        	messages: { 
        		'organization.legalName': {
            		required: "Legal Name of Client is required",
            		minlength: "Enter Legal Name of Client at least {0} characters.",
            		maxlength: "Enter Legal Name of Client no more than {0} characters."},
        		'organization.operatingName': {
            		required: "Operating Name is required",
            		minlength: "Enter Operating Name at least {0} characters.",
            		maxlength: "Enter Operating Name no more than {0} characters."},
				'organization.formOfBusiness': "Select one Form of Business",
				'organization.businessIdentificationNumber': {
            		required: "Business Number is required",
            		minlength: "Enter Business Number at least {0} characters.",
            		maxlength: "Enter Business Number no more than {0} characters."},
				'organization.incorporationDate': {
            		required: "Incorporation Date is required",
            		date: "Invalid! Please Enter valid DATE."},
				'organization.incorporationNumber': {
            		required: "Incorporation Number is required",
            		minlength: "Enter Incorporation Number at least {0} characters.",
            		maxlength: "Enter Incorporation Number no more than {0} characters."},
				'organization.industryType': "Select one Industry",
				'organization.yearEndDate': {
            		required: "Year End Date is required",
            		date: "Invalid! Please Enter valid DATE."},
				'defaultPartySite.address.countryCode': "Select one Country",
				'defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
				'organization.authorizedCapital': {
                		required: "Authorized capital is required",
                		minlength: "Enter Authorized capital with at least {0} characters.",
                		maxlength: "Enter Authorized capital with no more than {0} characters."},
				'organization.issuedCaptial': {
                		required: "Issued capital is required",
                		minlength: "Enter Issued capital with at least {0} characters.",
                		maxlength: "Enter Issued capital with no more than {0} characters."}
        		}, 
			errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate"
				});
	
			$(".cancel").click(function() {
				validator.resetForm();
			});
		});
	</script>

<div>
  <form:form modelAttribute="party" method="POST" action="clientModule.do">
  <input type="hidden" name="clientId" value="${param.clientId }"/>
  <input type="hidden" name="baseURL" id="baseURL" value="/client/clientModule.do"/>
  <input type="hidden" name="clientPartyName" value="${param.clientPartyName }"/>
      <div class="tableContainerone">
      		<h3>Client Name: <b><strong>${clientPartyName}</strong></b></h3>
			<h3>Client Details </h3>
			<%-- <c:if test="${not empty statusMessageKey}">
    		<span class="message"><fmt:message key="${statusMessageKey}"/></span>
  			</c:if> --%>
			 <form:hidden path="id"/>
            <table class="table-long" >
              <tbody>
                <tr class="odd">
                  <td class="col-first">Legal Name of Client</td>
                  <td class="col-second">
                  <form:input path="organization.legalName" class="input" tabindex="1"/>
                 </td>
                  <td class="col-first">Operating Name</td>
                  <td class="col-second">
                  <form:input path="organization.operatingName" class="input" tabindex="2" />
                  </td>
                </tr>                
                <tr class="odd">
                  <td class="col-first">Form of Business</td>
                  <td class="col-second"><form:select path="organization.formOfBusiness" tabindex="3" width="150" style="width: 150px">
                  <form:option value="-1" label="Select" />
				  <form:options items="${formOfBusinessCodeSet}" itemValue="id" itemLabel="shortName" />
                  </form:select>
                  </td>
                  <td class="col-first">Business Number</td>
                  <td class="col-second">
                   <form:input path="organization.businessIdentificationNumber" class="input" tabindex="4" />
                  </td>
                </tr>
                <tr class="odd">
                  <td class="col-first">Incorporation Date</td>
                  <td class="col-second">
                 <form:input path="organization.incorporationDate" id="datepicker" class="input" tabindex="5" />
                 
                 </td>
                  <td class="col-first">Incorporation Number</td>
                  <td class="col-second">
                 <form:input path="organization.incorporationNumber" class="input" tabindex="6" />
                  </td>
                </tr>
               
                <tr class="odd">
                  <td class="col-first">Industry </td>
                  <td class="col-second">
                  <form:select path="organization.industryType" tabindex="7" width="150" style="width: 150px">
                  <form:option value="-1" label="Select" />
					<form:options items="${industryCodeSet}" itemValue="id" itemLabel="shortName" />
				</form:select>
				</td>
                  <td class="col-first">Year End Date</td>
                  <td class="col-second">
                  <form:input path="organization.yearEndDate" id="datepicker1" class="input" tabindex="8" />
                  </td>
                </tr>
               
               
               <tr class="odd">
                <td class="col-first">Country</td>
                <td class="col-second">
					 <form:select path="defaultPartySite.address.countryCode" tabindex="9" width="150" style="width: 150px">
                  <form:option value="-1" label="Select" />
				<form:options items="${countryCodeSet}" itemValue="id" itemLabel="shortName"/>
				</form:select>
				</td>
				 <td class="col-first">State/Province</td>
                 <td class="col-second">
                 <form:select path="defaultPartySite.address.stateCode" tabindex="10" width="150" style="width: 150px">
                  <form:option value="-1" label="Select" />
				<form:options items="${statesSet}" itemValue="id" itemLabel="shortName"/>	
				</form:select>
                 </td>
				</tr>
               
                <tr class="odd">
                  <td class="col-first" valign="top">Authorized capital</td>
                  <td class="col-second">
                 <form:textarea path="organization.authorizedCapital"  tabindex="11"  style="width:380px;" rows="3"  class="input"/>
                  </td>
				  <td class="col-first">Issued capital</td>
                  <td class="col-second">
                   <form:textarea path="organization.issuedCaptial"  tabindex="12"  style="width:380px;" rows="3"  class="input"/>
                   </td>
                </tr>
                
               
              </tbody>
            </table>
            
            <table class="table-long" >
              <tbody>
              	  <tr class="odd">
                  <td class="col-first">&nbsp;</td>
                  
                  <td class="col-button" colspan="3">
                   <a href="clientModule.do"><img src="<c:url value='/images/add.gif'/>" border="0" alt="Add New" tabindex="13"/>
                  </a>&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="image" name="save" id="save" src="<c:url value='/images/bt-save.gif'/>" tabindex="14" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="image" name="save" id="save_continue" src="<c:url value='/images/save_continue.gif'/>" tabindex="15" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="image" name="cancel" src="<c:url value='/images/bt-cancel.gif'/>" tabindex="16" /></td>
                </tr>
              </tbody>
         </table>
      </div>
      
      
</form:form>

</div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 