<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.taskNotificationRecipient fieldset p.error label {
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

form.taskNotificationRecipient {
	width: 30em;
}

form.taskNotificationRecipient label.error {
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
<script type="text/javascript">

	$(document).ready(function() {

		$.validator.addMethod("alphaNumeric", function(value, element) {  
		    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
		},"Please enter valid Number.");
		
		$.validator.addMethod("alphabetsOnly", function(value, element) {  
		    return this.optional(element) || /^\s*[0-9a-zA-Z-.,@:%\s]+\s*$/i.test(value);  
		},"No Special characters are allowed. Please enter a valid.");
		
		$.validator.addMethod("multiemail", function(value, element) {  
		    return this.optional(element) || /^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$/i.test(value);  
		}," Please enter a valid Email ids..");

		
	});

		// only for demo purposes
		$.validator.setDefaults({
			submitHandler: function(form) {
			   	form.submit();
			}
		});

		$().ready(function() {
			$("#save").click(function() {
				if($("#taskNotificationRecipient").validate({
					
					rules: { 
					'recipient': {required: true,alphabetsOnly:true,minlength: 0,maxlength: 30},
					'emailType': {required: true,alphabetsOnly:true,minlength: 0,maxlength: 300},
					'notificationTemplateId': {required: true,min:1}
	        		}, 
	        	messages: { 
	        		'recipient': {
	            		required: "Recipient is required",
	            		alphabetsOnly:"No Special characters are allowed. Please enter a valid Recipient Name.",
	            		minlength: "Enter Recipient with at least {0} characters.",
	            		maxlength: "Enter Recipient with no more than {0} characters."},
	        		'emailType': {
	            		required: "Email Text is required",
	            		alphabetsOnly:"No Special characters are allowed. Please enter a valid EmailType.",
	            		minlength: "Enter Email Text with at least {0} characters.",
	            		maxlength: "Enter Email Text with no more than {0} characters."},
					'notificationTemplateId': "Select one Type Of Template"
	        		}
				}).form()){
				
					$.ajax({
				           dataType: 'json',
				         type: 'POST',
			               data: $('#taskNotificationRecipient').serialize(),
					       url: 'mobileAdminTaskNotificationRecepient.do',
					       success: function(recipientId) {
					           	if(recipientId != -1){
					        		$.jGrowl("Record saved successfully");
					        		if($("#id").val()!=""){
				        				window.location.href="mobileadminTaskNotificationRecipientHome.do";
			            			}else{
				        				document.getElementById("taskNotificationRecipient").reset();
				        			}
					        		/* var tabl = $("#getrecipientwmob").dataTable();
					        		tabl.fnDraw(); */
			       				}else{
					           		 $.jGrowl("As Error has happened while process. ");	
				            	 } 
				           }

					});
					 return false;
				}else{
					return false;
				}
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
</style>

<!--  BUCKET -->
<%-- <c:url value="/mobileadmin/mobileAdminTaskNotificationRecepient.do" var="mobilerecepientUrl"/>    --%>
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

					<%-- 	<a href="<c:out value='${mobilerecepientUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showformRecepient" onclick="showformRecepient()"
	                    	 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Recipient</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;  --%>
	                	
<body >
<div id="formRecepient">
	<form:form modelAttribute="taskNotificationRecipient">
		<input type="hidden" name="baseURL" id="baseURL"
			value="mobileAdminTaskNotificationRecipient.do" />
		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>
		
		<form:hidden path="id" />

				<div data-role="fieldcontain" >
                    <form:label path="recipient">Recipient</form:label>
                    <form:input path="recipient" cssClass="input_full" tabindex="1"/>
                    
                    <form:label   path="emailType">Email Type</form:label>
                    <form:input path="emailType" cssClass="input_full" tabindex="2"/>
                </div>
                
                <div data-role="fieldcontain" >
                    <form:label path="notificationTemplateId">Relative Parent Code</form:label>
                   		<form:select path="notificationTemplateId" tabindex="3" cssClass="input_full">
							<form:option value="-1" label="Select" />
							<form:options items="${templateSet}" itemValue="id" itemLabel="subject" />
						</form:select>
                </div>


				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					
					<c:if test="${taskNotificationRecipient.id == null}">
						<span class="ui-button-text" tabindex="4">Save</span>
					</c:if>
					<c:if test="${taskNotificationRecipient.id != null}">
						<span class="ui-button-text" tabindex="4">Update</span>
    	            </c:if>
				</button>
				&nbsp;&nbsp;
				<!-- <button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text">Cancel</span>
				</button> -->
				
				<button type="button" id="showformRecepient"
					onclick="window.location='mobileadminTaskNotificationRecipientHome.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text">Back</span>
					</button>
	</form:form>
	</div>

