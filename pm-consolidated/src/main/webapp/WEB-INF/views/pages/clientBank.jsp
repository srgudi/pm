<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<!-- MAIN CONTENT SECTION -->

<!-- <style type="text/css">
    .partyAccount fieldset p.error label {
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

    form.partyAccount {
        width: 30em;
    }

    form.partyAccountlabel.error {
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
    	 $("#save").click(function() {
        var container = $('div.error_container');
        // validate the form when it is submitted
        var validator = $("#partyAccount").validate({

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
            meta: "validate"
        });
        $("#partyAccount").submit();
         });

        $(".cancel").click(function() {
            validator.resetForm();
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
</style> -->
<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Bank</span>
<div class="f13">
<form:form modelAttribute="partyAccount" method="POST"
           action="clientBank.do">

<input type="hidden" name="inValidClientId"
       value="${param.inValidClientId }"/>

<input type="hidden" name="clientId" id="clientId"
       value="${param.clientId}"/>
<input type="hidden" name="baseURL" id="baseURL"
       value="clientBank.do"/>
<input type="hidden" name="accountCategory" id="accountCategory"
       value="700"/>
<form:hidden path="id"/>
<%-- <form:hidden path="createUserId" value="system"/> --%>
<form:hidden path="party"/>
<i><b><form:errors path="*" class="errorblock" element="div"/>
</b>
</i>
<b><strong>${inValidClientId}</strong></b>

<!-- BEGIN ROW 1 -->
<div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px">Bank Details</h4></div>
            
            <div class="container_12 mt20">
                    
            <div class="grid_2 right"><form:label path="accountEntityName">Bank Name</form:label></div>
            <div class="grid_3 right"><form:input cssClass="input_full" path="accountEntityName" class="input"
                        tabindex="1"/></div>
             <div class="s1"></div>
             <div class="grid_2 right">   </div>
            <div class="grid_3 right">    </div>
            
            </div>
            
            <div class="container_12 pt5">
            
            <div class="grid_2 right"><form:label path="accountNumber">Account Number</form:label></div>
            <div class="grid_3 right"><form:input cssClass="input_full" path="accountNumber" class="input"
                        tabindex="2"/></div>
            <div class="s1"></div>
            <div class="grid_2 right"> <form:label cssClass="input_full" path="accountType">Account Type</form:label>     </div>
            <div class="grid_3 right">  <form:select path="accountType" tabindex="3" cssClass="input_full">
                <form:option value="-1" label="Select"/>
                <form:options items="${accountTypeCodeSet}" itemValue="id" itemLabel="shortName"/>
            </form:select>    </div>
            </div>
            

             <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;">Address Details</h4></div>
                <div class="container_12 pt5">
                
                   <div class="grid_2 right"><form:label path="address.addressLine1">Address Line 1</form:label></div>
                   <div class="grid_3 right"><form:input cssClass="input_full" path="address.addressLine1" class="input"
                        tabindex="4"/></div>
                <div class="s1"></div>
                    
                   <div class="grid_2 right"><form:label path="address.addressLine2">Address Line 2</form:label></div>
                   <div class="grid_3 right"><form:input cssClass="input_full" path="address.addressLine2" class="input"
                        tabindex="5"/></div>
        
               </div>

            <div class="container_12 pt5">

            <div class="grid_2 right"><form:label path="address.city">City</form:label></div>
            <div class="grid_3 right"><form:input cssClass="input_full" path="address.city" class="input"
                        tabindex="6"/></div>
                        
             <div class="s1"></div>
                    
             <div class="grid_2 right"><form:label path="address.countryCode">Country</form:label></div>
            <div class="grid_3 right"><form:select
                    path="address.countryCode" cssClass="input_full" tabindex="7">
                <form:option value="-1" label="Select"/>
                <form:options items="${countryCodeSet}" itemValue="key"
                              itemLabel="value"/>
            </form:select></div>
            </div>
            
            <div class="container_12 pt5">
            <div class="grid_2 right"> <form:label path="address.stateCode">State/Province</form:label>  </div>
            <div class="grid_3 right"> <form:select path="address.stateCode"
                         cssClass="input_full" tabindex="8">
                <form:option value="-1" label="Select"/>
                <form:options items="${statesSet}" itemValue="key"
                              itemLabel="value"/>
            </form:select>   </div>
             <div class="s1"></div>
             <div class="grid_2 right">  <form:label path="address.postalCode" cssClass="input_full">Postal Code</form:label>    </div>
            <div class="grid_3 right">  <form:input path="address.postalCode"
                        cssClass="input_full" tabindex="9"/>    </div>
             
            </div>
            
            <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;">Communication Details</h4></div>
            
             <div class="container_12 pt5">
             <div class="grid_2 right"><form:label path="defaultPointOfContact.contactName">Contact Name</form:label></div>
             <div class="grid_3 right"><form:input cssClass="input_full" path="defaultPointOfContact.contactName" class="input"
                        tabindex="10"/></div>
             <div class="s1"></div>
                    
            <div class="grid_2 right"><form:label path="defaultPointOfContact.contactTitle">Contact Title</form:label></div>
            <div class="grid_3 right"><form:input cssClass="input_full" path="defaultPointOfContact.contactTitle" class="input"
                        tabindex="11"/></div>
        
            </div>
            <div class="container_12 pt5">
             <c:forEach
                    items="${partyAccount.defaultPointOfContact.emailList}"
                    var="email" varStatus="cStatus">

            <div class="grid_2 right"> <form:label path="defaultPointOfContact.emailList" cssClass="input_full">Email Address</form:label>  </div>
            <div class="grid_3 right"> 
                <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                        tabindex="12" cssClass="input_full"/>
                </div></c:forEach>
                        
             <div class="s1"></div>
             <c:forEach
                    items="${partyAccount.defaultPointOfContact.faxList}"
                    var="contact" varStatus="cStatus">
                    
             <div class="grid_2 right"><form:label path="defaultPointOfContact.faxList" cssClass="input_full">Fax Number</form:label>   </div>
            <div class="grid_3 right"> 
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                        tabindex="13" cssClass="input_full"/>
              </div> </c:forEach> 
          </div>
 
 
          <div class="container_12 pt5">
                    <c:forEach
                    items="${partyAccount.defaultPointOfContact.webUrlList}"
                    var="contact" varStatus="cStatus">
            <div class="grid_2 right"><form:label path="defaultPointOfContact.webUrlList" cssClass="input_full">Web&nbsp;&nbsp;</form:label>      </div>
            <div class="grid_3 right">
                <form:hidden
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].id"/>
                <form:hidden
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].pointOfContact"/>
                <form:input
                        path="defaultPointOfContact.webUrlList[${cStatus.index}].contactDetail"
                        tabindex="14" cssClass="input_full"/>
            </div></c:forEach>      
                        
             <div class="s1"></div>
             
             <div class="grid_2 right">
             <form:label path="defaultPointOfContact.phoneList">Phone No.</form:label>
             </div>
            <div class="grid_4">
            			<c:set var="phoneCount" value="0"/>
            			<c:set var="tabOrder" value="15"/>
            			<c:forEach items="${partyAccount.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			                <table width="100%">
			                    <tr class="phonerow">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
			                        <td width="20%"><form:input
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
			                         <td width="7%" class="grid_5 right" style="text-align:center; color : #00498F">Type </td>
			                        <c:set var="displayStyle" value="display:show;"/>
			                        <c:if test="${phoneCount == 0}">
			                            <c:set var="displayStyle" value="display:none;"/>
			                        </c:if>
			                        <c:set var="tabOrder" value="${tabOrder}++"/>
			                        <td class="row-nav1"><form:select
			                                path="defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			
			                            <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addicon" />
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
			            </c:forEach>

            		</div>
         </div>
       
		<div class="container_12 pt5">

            <div class="grid_2 right"><form:label path="terms" cssClass="input_full">Memo</form:label>      </div>
            <div class="grid_5 right"><form:textarea path="terms"
				                           rows="3" cssClass="input_full" tabindex="16"/>      </div>
                        
             <div class="s1"></div>
                    
             <div class="grid_2 right">   </div>
            <div class="grid_3 right">    </div>
      </div>


<div class="container_12" style="margin:10px;"></div>

			<div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
            	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="clientBank.do?clientId=${param.clientId}" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	onclick="window.location='clientBank.do?clientId=${param.clientId}';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">New Bank</span>
	                    	</button>
	                	</a>&nbsp;&nbsp;
	
	                	<button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<c:if test="${partyAccount.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${partyAccount.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    <button type="reset"
	                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                         	role="button" aria-disabled="false">
	                     	<span class="ui-button-text">Cancel</span>
	                    </button>
            	</security:authorize>
            	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${partyAccount.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
		        </div>
        	</div>

</form:form>
	</div>
	</div>
</div>
<!-- BUCKET -->
<!-- <div class="fieldset mt25 ml20 mr20">
<span class="legend b">Bank List</span>
     GRID PLACEHOLDER Ids
    <div id="grid_wrapper" class="ml10 mr10 mt20">
        <table id="list"></table>
        <div id="pager" class="scroll"></div>
    </div>
    <script type="text/javascript">
        jQuery(document).ready(function() {
            clientId = $("#clientId").val();
            var mygrid = jQuery("#list").jqGrid({
                url:'accountAjaxList.do?clientId=' + clientId + '&accountCategory=700',
                datatype: 'json',
                height : 300,
                mtype: 'GET',
                colNames:['ID','Bank Name', 'Type Of Account', 'Account Number', 'Contact Name', 'Office Number', 'Email Address'],
                colModel :[
                    {name:'id', index:'id',  width:150},
                    {name:'accountFirmName', index:'accountFirmName',  width:200},
                    {name:'accountType', index:'accountType',  width:150,formatter: 'showlink', formatoptions: {baseLinkUrl: 'clientBank.do',
                        idName:'id', addParam:'&clientId=' + clientId}},
                    {name:'accountNumber', index:'accountNumber',  width:180},
                    {name:'contactName', index:'contactName',  width:180},
                    {name:'officeNumber', index:'officeNumber',  width:180},
                    {name:'emailAddress', index:'emailAddress',  width:180}
                ],
                jsonReader : {
                    root: "rows",
                    page: "page",
                    total: "total",
                    records: "records",
                    repeatitems: false,
                    cell: "cell",
                    id: "id",
                    userdata: "userdata"
                },
                pager: jQuery('#pager'),
                rowNum:10,
                loadonce: true,
                rowList:[10,25,50],
                sortname: 'accountFirmName',
                sortorder: 'asc',
                viewrecords: true,
                autowidth: true,
                caption: 'Bank List',
                editurl:'<c:url value="/saveAccountAjaxList.do"/>'
            });
            
			 <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
				jQuery("#list").jqGrid('navGrid', '#pager', {
					del : true,
					add : false,
					edit : false,
					search : false
				});
			</security:authorize>
			<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
				jQuery("#list").jqGrid('navGrid', '#pager', {
					del : false,
					add : false,
					edit : false,
					search : false
				});
			</security:authorize>            
            
            jQuery("#list").jqGrid('navButtonAdd',
                    "#pager", {
                        caption : "Apply Filter",
                        title : "Toggle Search Toolbar",
                        buttonicon : 'ui-icon-pin-s',
                        onClickButton : function() {
                            mygrid[0].toggleToolbar();
                        }
                    });
            jQuery("#list").jqGrid('filterToolbar', {
                stringResult : true,
                searchOnEnter : false
            });
            jQuery("#list").jqGrid('hideCol', "id");
        });

        // resize the grid if needed
        $(window).bind('resize',
                function() {
                    jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
                }).trigger('resize');

        $(window).bind('load',
                function() {
                    jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
                }).trigger('load');

    </script>
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
        $('.addicon').click(function() {
            if ($("tr.phonerow").length < 5) {
                var x = $("input[class^='input phoneField']").length;

                $("table tbody").find("tr.phonerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr({
                    name: 'defaultPointOfContact.phoneList[' + (x) + '].contactDetail',
                    id: 'defaultPointOfContact.phoneList[' + (x) + '].contactDetail'})
                        .val("");

                $("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr({
                    name: 'defaultPointOfContact.phoneList[' + (x) + '].subType',
                    id: 'defaultPointOfContact.phoneList[' + (x) + '].subType'})
                        .val("");

                $("table tbody").find("tr.phonerow:last").find("input[class='input_h1_id']").attr({
                    name: 'defaultPointOfContact.phoneList[' + (x) + '].id',
                    id: 'defaultPointOfContact.phoneList[' + (x) + '].id'})
                        .val("");


                $("table tbody").find("tr.phonerow:last").find("input[class='input_h1']").attr({
                    name: 'defaultPointOfContact.phoneList[' + (x) + '].pointOfContact',
                    id: 'defaultPointOfContact.phoneList[' + (x) + '].pointOfContact'});


                firstrowLength();
            }
            ;
        });

            $(".removeicon").click(function () {
                $(this).parent().parent().remove();
            });

        function firstrowLength() {
            if ($("tr.phonerow").length > 1) {
                $("tr.phonerow:last").find("td:last").find("a.removeicon").show();
            }
        }
    </script> -->

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 