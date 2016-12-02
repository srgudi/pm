<%@ include file="../../layout/PM-INCLUDES.jsp" %>

<style>
    .error {
        color: red;
    }

    .errorblock {
        color: #000;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin: 5px;
        padding: 5px;
        width: auto;
    }
</style>
<style type="text/css">
    .party fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin-bottom: 20px;
        padding: 5px;
        width: 40em;
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
        border: 1px solid red;
    }

    select.error {
        border: 1px solid red;
    }

    label.error {
        /* remove the next line when you have trouble in IE6 with labels in list */
        color: red;
        font-style: italic
    }
</style>

<c:url value="/mobileclient/mobileclientStaff.do" var="mobilestaffModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
<input type="hidden" id="clientId" name="clientId" value="${param.clientId }"/> 

 <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="<c:out value='${mobilestaffModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showClientForm" onclick="showClientForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Staff</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
			
	  </security:authorize>  
	  
<body onload="hideClientForm()">
 <div id="div2"  >

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

 <form:form modelAttribute="party"  method="POST" action="mobileclientStaff.do">
            <input type="hidden" id="clientId" name="clientId" value="${param.clientId }"/>
            <input type="hidden" name="baseURL" id="baseURL" value="mobileclientStaff.do"/>
            <input type="hidden" name="partyId" id="partyId" value="${party.id}"/>
            <input type="hidden" name="inValidClientId" value="${param.inValidClientId }" />
 <form:hidden path="id"/>
 <div data-role="fieldcontain" >
    <form:label path="person.firstName">First Name</form:label>
                    
                    <form:input path="person.firstName" cssClass="input_full" tabindex="1"/>
                   
    </div>
    <div data-role="fieldcontain" >
    <form:label path="person.lastName">Last Name</form:label>
                   
                    <form:input path="person.lastName" cssClass="input_full" tabindex="1"/>
                  
    </div>
    <div data-role="fieldcontain" >
    <form:label path="person.personDetails.codeByJobTitleCode">Title</form:label>
                    
                    <form:select path="person.personDetails.codeByJobTitleCode" tabindex="3" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${titleCodeList}" itemValue="key"
										itemLabel="value" />
                   		</form:select>
                    
    </div>
     <div data-role="fieldcontain" >
    <form:label path="person.personDetails.comittee">Committee</form:label>
                    
                    <form:input path="person.personDetails.comittee" cssClass="input_full" tabindex="1"/>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="person.dateOfBirth">Date Of Birth</form:label>
                   
                    <form:input path="person.dateOfBirth" id="date"/>
                   
    </div>
    <div data-role="fieldcontain" >
    <form:label path="person.personDetails.annualCompensation">Annual Compensation</form:label>
                    
                    <form:input path="person.personDetails.annualCompensation" cssClass="input_full" tabindex="1"/>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.addressLine1">Address Line 1</form:label>
                    
                    <form:input path="defaultPartySite.address.addressLine1" cssClass="input_full" tabindex="1"/>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.addressLine2">Address Line 2</form:label>
                    
                    <form:input path="defaultPartySite.address.addressLine2" cssClass="input_full" tabindex="1"/>
                   
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.city">City</form:label>
                    
                    <form:input path="defaultPartySite.address.city" cssClass="input_full" tabindex="1"/>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.countryCode">Country</form:label>
                    
                    <form:select path="defaultPartySite.address.countryCode" tabindex="3" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${countryCodeSet}" itemValue="key"
										itemLabel="value" />
                   		</form:select>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.stateCode">State/Province</form:label>
                    
                    <form:select path="defaultPartySite.address.stateCode" tabindex="3" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${statesSet}" itemValue="key"
										itemLabel="value" />
                   		</form:select>
                    
    </div>
    <div data-role="fieldcontain" >
    <form:label path="defaultPartySite.address.postalCode">Postal Code</form:label>
                    
                    <form:input path="defaultPartySite.address.postalCode" cssClass="input_full" tabindex="1"/>
                   
    </div>
    
    <div data-role="fieldcontain">
    <c:forEach items="${party.defaultPartySite.defaultPointOfContact.emailList}" var="email" 
                                                                   varStatus="cStatus"> 
                                   
      <form:label path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail">Email Address</form:label>
      <form:hidden path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                                      <fieldset data-role="controlgroup" data-mini="true">
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                                     tabindex="13"  cssClass="input_full" />
                                     </fieldset>
                                     
      </c:forEach> 
    </div> 
    
    <div data-role="fieldcontain">
     <c:forEach items="${party.defaultPartySite.defaultPointOfContact.faxList}" var="email"
                                   varStatus="cStatus">
      <form:label path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail">Fax Number</form:label>
      
      <form:hidden path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].id"/>
                           
                            <form:hidden path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                                  <fieldset data-role="controlgroup" data-mini="true">    
                            <form:input  path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                                    tabindex="14" cssClass="input_full"/>
                                </fieldset> 
  </c:forEach>
    </div>
    
    <div data-role="fieldcontain">
   <form:label path="defaultPartySite.defaultPointOfContact.phoneList">Phone No.</form:label>
   <c:forEach items="${party.defaultPartySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
    
   <form:input  path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"     cssClass="input phoneField" tabindex="${tabOrder}"/>
  
	<form:hidden   path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].id" class="input_h1_id"/>
	  <form:hidden  path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"   class="input_h1"/>
	  <%-- <td width="3%"></td>		        		  
			 <td width="7%" class="grid_4 down" style="text-align:center; color : #00498F">Type </td>                                                           
			     <c:set var="displayStyle" value="display:show;"/>
			                        <c:if test="${phoneCount == 0}">
			                            <c:set var="displayStyle" value="display:none;"/>
			                        </c:if>
			                        <c:set var="tabOrder" value="${tabOrder}++"/>
			                        
			                        <form:select
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" cssClass="phone_type" tabindex="${tabOrder} ">
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			                        
			                        <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addicon" />
			                        </a> &nbsp; 
			                        <a href='javascript:;' class='removeicon'
			                                       style="${displayStyle}"><img
			                                src='<c:url value='/images/remove_icon.gif'/>' width='20'
			                                height='15' alt='Remove Phone Number'
			                                title='Remove Phone Number'/>
			                        </a>
			                         <c:set var="phoneCount" value="${phoneCount}++"/>  --%>                           
			                      
			                                                     
			                            
   </c:forEach>
    
    </div>
    
     <%--  <div data-role="fieldcontain" style="width: 20%;">
     <c:forEach items="${party.defaultPartySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
      <form:label path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
       id="phone_type" cssClass="phone_type" tabindex="${tabOrder} ">Type</form:label>
       <fieldset data-role="controlgroup" data-mini="true">
	    <form:select
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" >
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			                        </fieldset>
			                        <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addicon" />
			                        </a> &nbsp; 
			                        <a href='javascript:;' class='removeicon'
			                                       style="${displayStyle}"><img
			                                src='<c:url value='/images/remove_icon.gif'/>' width='20'
			                                height='15' alt='Remove Phone Number'
			                                title='Remove Phone Number'/>
			                        </a>
			                         <c:set var="phoneCount" value="${phoneCount}++"/>
       </c:forEach>
     </div>  --%>
     
    <form:hidden path="defaultPartySite.defaultPointOfContact.contactName" class="input"
                             value="${party.name}"/>
            <form:hidden path="defaultPartySite.defaultPointOfContact.contactTitle" class="input"
                             value="${party.name}"/>
    
                             
                <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
            		 
	    	                
	    	                <button type="button" id="save" 
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false" data-inline="true" data-mini="true">
							<c:if test="${party.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${party.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>&nbsp;&nbsp;
						
	                	<button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
				             	<span class="ui-button-text">Cancel</span>
				        </button>&nbsp;&nbsp;
	
	    	   </security:authorize>
	    	    <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            			<c:if test="${party.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false" data-inline="true" data-mini="true">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>&nbsp;&nbsp;
							
				             <button type="reset" 
				                   	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				                   	role="button" aria-disabled="false" data-inline="true" data-mini="true">
				                 	<span class="ui-button-text">Cancel</span>
				             </button> 
				            
				             
	            		</c:if>
            		</security:authorize>
            		
            		<a href="<c:out value='${mobilestaffModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="form" onclick="hideClientForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">Back</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
    </form:form>
</div>

<div id="grid">	  
<div id="grid_wrapper">
 <table id='mobileClientStaff'></table>
    <div id='clientStaffPager'></div>
</div>    
    <script type='text/javascript'>
     partyId = $("#partyId").val();
    clientId = $("#clientId").val();
    //alert("clientid=" +clientId);
        jQuery('#mobileClientStaff').jqGrid({
            "hoverrows":false,
            "viewrecords":true,
            "jsonReader": {root : "rows",
            page : "page",
            total : "total",
            records : "records",
            repeatitems : false,
            cell : "cell",
            id : "partyId",
            userdata : "userdata"},
            "gridview":true,
            "loadonce":true,
            "url":'<c:url value="/mobileclient/mobileClientGetStaff.do"/>?clientId=' + clientId,
           
            "scrollPaging":true,
            pager : jQuery('#pager'),
            //"autowidth":true,
           /// "footerrow": true,
           /// "userDataOnFooter": true,
            "rowNum":10,
            "rowList" : [20,40,60],
            "sortname":"firstName",
            "height":200,
            "width" :300,
            "mtype" : "GET",
            "datatype":"json",
            caption : 'Staff List',
            //editurl:'<c:url value="/saveClientAjaxList.do"/>',
             colNames:['Name', 'Title', 'Office Number','Home Number','Email Address'],
             colModel :[
                        {name:'name', index:'name',  width:300,formatter: 'showlink', formatoptions: { baseLinkUrl: 'mobileclientStaff.do',
                            idName:'id', addParam:'&clientId=' + clientId} },
                        {name:'jobTitle', index:'jobTitle',  width:200},
                        {name:'officeNumber', index:'officeNumber',  width:150},
                        {name:'homeNumber', index:'homeNumber',  width:150},
                        {name:'emailAddress', index:'emailAddress',  width:200}
                    ],
								
                    
            "pager":"#clientStaffPager"
            	
        });
        jQuery("#mobileClientStaff").jqGrid('filterToolbar', {
            stringResult : true,
            searchOnEnter : false
        });
      /*  // $("#grid").jqGrid('footerData', 'set', { "ShipName":"Total:"}, true); */
    $('#clientStaffPager').css("height", "50px");
   
    </script>
</div>
</body>
 <script type="text/javascript">
    $(document).ready(function() {
        //alert('Hello Sai');
        firmId = ${firm.id};
        $("#defaultPartySite\\.address\\.countryCode").change(function() {
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
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 <script type="text/javascript">
	$(document).ready(function() {
		var queryDate = new Date();
		//queryDate.setFullYear(2009, 11, 01);
		$('#date').datepicker({
			defaultDate : queryDate,
			changeMonth: true,
            changeYear: true,
            yearRange: '-40:+20'
		});

	});
</script>



 <script type="text/javascript">
 
 function showClientForm(){
		$("#grid").hide();	
		$("#div2").show();
	}

function hideClientForm(){
	$("#div2").hide();	
	$("#grid").show();
}
/* function test2(){
	
	$("#div1").hide();	
	$("#div2").show();
} */
		</script> 

<script type="text/javascript">

var label;
var errormsg;
    $(document).ready(function() {

        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name.");

        $.validator.addMethod("alphaNumeric", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);
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

</script>

<script type="text/javascript">
$().ready(function() {
	 $("#save").click(function() {
		 //alert("hi");
		 partyId = $("#partyId").val();
		  var container = $('div.error_container');
		  //$("#div2").hide();	
			//$("#div1").show();
	        // validate the form when it is submitted
	        var validator = $("#party").validate({

	            rules: {
	                'person.personType': {required: true,min:1},
	                'person.firstName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.lastName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.personDetails.codeByJobTitleCode': {min:1},
	                'person.personDetails.comittee': {alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.dateOfBirth': {required: true,date: true},
	                'person.personDetails.annualCompensation': {required: true,digits: true,minlength: 1,maxlength: 15},
	                'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {required: true,email:true},
	                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {faxValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {required: true, phoneValidaion: true}
	                
	                
	            },
	            messages: {
	                'person.personType': "Select one Role",
	                'person.firstName': {
	                    required: "First Name is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid First Name",
	                    minlength: "Enter First Name with at least {0} characters.",
	                    maxlength: "Enter First Name with no more than {0} characters."},
	                'person.lastName': {
	                    required: "Last Name is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid 	Last Name",
	                    minlength: "Enter Last Name with at least {0} characters.",
	                    maxlength: "Enter Last Name with no more than {0} characters."},
	                'person.personDetails.codeByJobTitleCode': "Select one Title",
	                'person.personDetails.comittee': {
	                    required: "Committee is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid Committee Name",
	                    minlength: "Enter Committee with at least {0} characters.",
	                    maxlength: "Enter Committee with no more than {0} characters."},
	                'person.dateOfBirth': {
	                    required: "Date Of Birth is required",
	                    date:"No Special Charcters allowed. please enter a valid Date Of Birth in the format dd/mm/yyyy"},
	                'person.personDetails.annualCompensation': {
	                    required: "Annual Compensation is required",
	                    digits: "Please enter valid Annual Compensation with numeric only.",
	                    minlength: "Enter Annual Compensation with at least {0} characters.",
	                    maxlength: "Enter Annual Compensation with no more than {0} characters."},
	                    'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {
	                        required: "Email Address is required",
	                        email: "Please enter valid Email Address."},
	                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {
	                        required: "Fax is required",
	                        faxValidaion:"No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890",
	                        digits: "Enter Fax only digits."},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {
	                            required: "1st Phone No. is required",
	                            phoneValidaion:"Please enter valid Phone 1st Number. For Ex: 646-222-3333"},
	                    
	                    'organization.legalName': {
	                        required: "Firm Name is required",
	                        minlength: "Enter Firm Name with at least {0} characters.",
	                        maxlength: "Enter Firm Name with no more than {0} characters."}

	            },
	            errorContainer: container,
	            errorLabelContainer: $("ol", container),
	            wrapper: 'li',
	            meta: "validate"
	        });

		 $("#party").submit();
		 //$("#party").reset();
		 
	 });
	 //$("#party").reset();
	 });
</script>

