<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<style type="text/css">
     p.error label {
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
        color: black;
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

 /*   form.partyAccountlabel.error {
        display: block;
        margin-left: 1em;
        width: auto;
    }*/

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

    	     
		 $.validator.addMethod('city', function(value, element) {
            return this.optional(element) || /^([A-Z ]+)$/i.test(value);
        });
		 
		 
		 $.validator.addMethod('firstName', function(value, element) {
	            return this.optional(element) || /^([A-Z ]+)$/i.test(value);
	        });
		 
/*		 $.validator.addMethod('lastName', function(value, element) {
	            return this.optional(element) || /^([A-Z ]+)$/i.test(value);
	        });*/
    	
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
	        
        

    });
	
	
	 // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });
   
    $().ready(function() {
    	  $("#cancel").click(function() {
    	        validator.resetForm();
    	    });
    	  
    	  $("#back").click(function() {
    		  window.history.backward(); 
    	    });
    	    
    	    
        $("#save").click(function() {
        	
        	   var container = $('div.error_container');
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
               // validate the form when it is submitted
               var validator = $("#party").validate({

                   rules: {
              /*         'defaultPartySite.address.postalCode': {required: true,  regexp: /^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/i}
*/
'defaultPartySite.address.addressLine1': {required: true},
'defaultPartySite.address.city': {city:true,required:true},
'defaultPartySite.address.countryCode': {required: true,min:1},
'defaultPartySite.address.stateCode': {required: true,min:1},
'person.firstName': {required: true,firstName:true},
'person.lastName': {required: true,firstName:true},
           'defaultPartySite.address.postalCode':  {required: true,postalCode:true,maxlength: 10}
                   },
                   
                   messages: {
                	   'person.firstName':{
                		   required:"Firstname cannot be empty",
                		   firstName:"Enter the valid firstname"
                	   },
                	   'person.lastName':{
                		   required:"Lastname cannot be empty",
                		   firstName:"Enter the valid Lastname"
                	   },
                	   
                       'defaultPartySite.address.postalCode': {
                    	   required: "Postal Code is required",
                           postalCode: "Please enter a valid postal code."+errormsg,
                           minlength: "Enter Postal Code with at least {0} characters.",
                           maxlength: "Enter Postal Code with no more than {0} characters."},
                           'defaultPartySite.address.city': {
      	        			required: "City field cannot not be empty",
      	        			city: "Please enter the valid city name." },
                           'defaultPartySite.address.countryCode': "Select one Country",
       	        		'defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
       	        		
       	        		'defaultPartySite.address.addressLine1': "Address Line 1 cannot be empty"
                     
                   },
                   errorContainer: container,
                   errorLabelContainer: $("ol", container),
                   wrapper: 'li',
                   meta: "validate"
               });
            	   
        	
		$("#party").submit();
		$("themeSelectorForm").submit();
	});
    });
 
</script>
<script>
	function submitForm(){
  		document.themeSelectorForm.submit();
  	}
</script>

       <div>
	  		<div>
	  		<!--       -->
	  		<!--  BUCKET -->

<div class="error_container">
	<h7><b style="color:black">Please correct the following errors</b></h7>
    <ol></ol>
</div>
	  		<!--  -->
	  		
			<div style="padding:5px;" class="ui-widget ui-widget-content ui-widget-header ui-corner-top ui-helper-clearfix">User Profile</div>
		
		<div class="ui-widget ui-widget-content ui-corner-bottom">
		<div>
			<form:form name="Party" modelAttribute="party" method="POST"
				action="userProfile.do">
			<input type="hidden" name="baseURL" id="baseURL"
					value="userProfile.do" />
			<input type="hidden" name="clientId" id="clientId"
                    value="${param.clientId}"/>
					<%--  <c:if test="${not empty statusMessageKey}"><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                           	 aria-disabled="false">
                         	 <span class="message"><fmt:message key="${statusMessageKey}" /></span>
                   		</button>
					</c:if>  --%>
					<%-- <form:hidden path="id" /> --%>
				
				<div class="container_12">
            	<div class="grid_3">
            		<div class="row">
            			<form:label path="person.userName">User Name</form:label>
                        <form:input cssClass="input_full" path="person.userName" class="input"
                        tabindex="1" readonly="true" disabled="true"/>
            		</div>
            	</div>
            	</div>
            	<%-- <div class="grid_3">
                	<div class="row">
                		<form:label path="password">Password</form:label>
                        <form:input cssClass="input_full" type="password" path="password" class="input"
                        tabindex="2"/>
                	</div>
                </div> --%>
                <div class="container_12">
            	<div class="grid_3">
                	<div class="row">
                		<form:label path="person.firstName">First Name <span style="color:red;margin-left:3px;">*</span></form:label>
                        <form:input cssClass="input_full" path="person.firstName" class="input"
                        tabindex="3"/>
                	</div>
                </div>
                <div class="grid_3">
                	<div class="row">
                		<form:label path="person.lastName">Last Name <span style="color:red;margin-left:3px;">*</span></form:label>
                        <form:input cssClass="input_full" path="person.lastName" class="input"
                        tabindex="4"/>
                	</div>
                </div>
                </div>
              <!--  row 1 -->
                <div class="container_12">
            	<div class="grid_3">
            		<div class="row">
            			<form:label path="defaultPartySite.address.addressLine1">Address Line 1 <span style="color:red;margin-left:3px;">*</span></form:label>
                        <form:input cssClass="input_full" path="defaultPartySite.address.addressLine1" class="input"
                        tabindex="5"/>
            		</div>
            	</div>
            	<div class="grid_3">
                	<div class="row">
                		<form:label path="defaultPartySite.address.addressLine2">Address Line 2</form:label>
                        <form:input cssClass="input_full" path="defaultPartySite.address.addressLine2" class="input"
                        tabindex="6"/>
                	</div>
                </div>
            	<div class="grid_3">
                	<div class="row">
                		<form:label path="defaultPartySite.address.city">City <span style="color:red;margin-left:3px;">*</span></form:label>
                        <form:input cssClass="input_full" path="defaultPartySite.address.city" class="input"
                        tabindex="7"/>
                	</div>
                </div>
                </div>
                
               <div class="container_12">
               <div class="grid_3">
                	<div class="row">
                		<form:label path="defaultPartySite.address.countryCode">Country <span style="color:red;margin-left:3px;">*</span></form:label>
                		<form:select
                            path="defaultPartySite.address.countryCode" cssClass="input_full" tabindex="8">
                            <form:option value="-1" label="Select"/>
                            <form:options items="${countryCodeSet}" itemValue="key"
                              itemLabel="value"/>
                        </form:select>
                	</div>
                </div>

               <div class="container_12">
            	<div class="grid_3">
            		<div class="row">
            			<form:label path="defaultPartySite.address.stateCode">State/Province <span style="color:red;margin-left:3px;">*</span></form:label>
                		<form:select
                            path="defaultPartySite.address.stateCode" cssClass="input_full" tabindex="9">
                            <form:option value="-1" label="Select"/>
                            <form:options items="${statesSet}" itemValue="key"
                              itemLabel="value"/>
                        </form:select>
            		</div>
            	</div> 
            	<div class="grid_3">
                	<div class="row">
                		<form:label path="defaultPartySite.address.postalCode">Postal Code <span style="color:red;margin-left:3px;">*</span></form:label>
                        <form:input cssClass="input_full" path="defaultPartySite.address.postalCode" class="input"
                        tabindex="10"/>
                	</div>
                </div>
            	<!-- <div class="grid_3">
                	<div class="row">
                		
                	</div>
                </div>
                <div class="grid_3">
                	<div class="row">
                		
                	</div>
                </div> -->
                </div>
           <div class="container_12">
            <form style="width:150px;" " name="themeSelectorForm" action="<c:url value='/theme/themeSelect.do'/>" method="POST">

			<div class="container_12">
			<div class="grid_3">
                	<div class="row">
                		<form:label path="">Theme Selector</form:label>
                       
				 <select name="themeValue" onChange="submitForm(this);" tabindex="11" cssClass="input_full" style="width:312px;">
					<option value="south-street" cssClass="input_full"  <c:if test="${theme eq 'south-street'}">selected</c:if>>South Street</option>
					<option value="pepper-grinder" cssClass="input_full" <c:if test="${theme eq 'pepper-grinder'}">selected</c:if>>Pepper Grinder</option>
					<option value="cupertino" cssClass="input_full" <c:if test="${theme eq 'cupertino'}">selected</c:if>>Cupertino</option>
					<option value="start" cssClass="input_full" <c:if test="${theme eq 'start'}">selected</c:if>>Start</option>
					<option value="hot-sneaks" cssClass="input_full"  <c:if test="${theme eq 'hot-sneaks'}">selected</c:if>>Hot-Sneaks</option>
					<option value="blitzer" cssClass="input_full" <c:if test="${theme eq 'blitzer'}">selected</c:if>>Blitzer</option>
					<option value="dark-hive" cssClass="input_full"  <c:if test="${theme eq 'dark-hive'}">selected</c:if>>Dark-Hive</option>
				</select>
			</div>
			</div>
              </div>
               
             </div>
		  <div class="container_12" style="margin:10px;"></div>
                    <div class="container_12">
                    <div class="grid_3">&nbsp;</div>
                     <div class="grid_8">

                    	<!-- <a href="changePassword.do" style="text-decoration:none;">
	                    	<button type="button" id="changePassword"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Change Password</span>
	                    	</button>
	                	</a>&nbsp;&nbsp; -->
	                	
                    	<button type="back"
                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                            	role="button" aria-disabled="false">
                        	<span class="ui-button-text" tabindex="14">Back</span>
                    	</button>
                    	&nbsp;&nbsp;
                    	<button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<!-- bug no 526 -->
						<%-- <c:if test="${Party.id == null}"> --%>
						<span class="ui-button-text" tabindex="13">Update</span>
						<%-- </c:if> --%>
						<%-- <c:if test="${Party.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if> --%>
					</button>
					&nbsp;&nbsp;
                    	<button type="reset"
                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                            	role="button" aria-disabled="false">
                        	<span class="ui-button-text" tabindex="14">Cancel</span>
                    	</button>
                    	</form>
         </form:form>
                	
                    </div>
                    <div class="container_12" style="margin:10px;"></div>
                    </div>
         </div>
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
  </div>
	</div>
	<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>	