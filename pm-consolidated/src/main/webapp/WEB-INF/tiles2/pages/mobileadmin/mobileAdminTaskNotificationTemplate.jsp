<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.taskNotificationTemplate fieldset p.error label {
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

form.taskNotificationTemplate {
	width: 30em;
}

form.taskNotificationTemplate label.error {
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
			$("#saveTemp").click(function() {
				if($("#taskNotificationTemplate").validate({
					
					rules: { 
					'subject': {required: true,minlength: 0,maxlength: 4000},
					'bodyText': {required: true,minlength: 0,maxlength: 4000},
					'adminEmailId': {required: true,multiemail: true,minlength: 0,maxlength: 400}
	        		}, 
	        	messages: { 
	        		'subject': {
	            		required: "Subject is required",
	            		alphabetsOnly:"No Special characters are allowed. Please enter a valid Subject.",
	            		minlength: "Enter Subject with at least {0} characters.",
	            		maxlength: "Enter Subject with no more than {0} characters."},
	        		'bodyText': {
	            		required: "Body Text is required",
	            		minlength: "Enter Body Text with at least {0} characters.",
	            		maxlength: "Enter Body Text with no more than {0} characters."},
					'adminEmailId': {
	            		required: "Email Id is required",
	            		multiemail:"Please enter a valid Email ids..",
	            		minlength: "Enter Email Id with at least {0} characters.",
	            		maxlength: "Enter Email Id with no more than {0} characters."}
	        		}
				}).form()){
				$.ajax({
			           dataType: 'json',
			         type: 'POST',
		               data: $('#taskNotificationTemplate').serialize(),
				       url: 'mobileadminTaskNotificationTemplate.do',
				       success: function(templateId) {
				           	if(templateId != -1){
				        		$.jGrowl("Record saved successfully");
				        		if($("#id").val()!=""){
				        			window.location.href="mobileadminTaskNotificationTemplateHome.do";
				        		}else{
				        			document.getElementById("taskNotificationTemplate").reset();
				        		}
				        		/* var tabl = $("#gettemplatewmob").dataTable();
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
<%--  <c:url value="/mobileadmin/mobileadminTaskNotificationTemplate.do" var="mobiletemplateUrl"/>  --%>
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

	                	<%-- <a href="<c:out value='${mobiletemplateUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showformTemplate" onclick="showformTemplate()"	                    	 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Template</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;  --%>

<body>
<div id="formTemplate">
	<form:form modelAttribute="taskNotificationTemplate" >
		<input type="hidden" name="baseURL" id="baseURL"
			value="mobileadminTaskNotificationTemplate.do" />
		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>
		
		<form:hidden path="id" />
				<div data-role="fieldcontain" >
                    <form:label path="subject">Subject</form:label>
                    <form:input path="subject" cssClass="input_full" tabindex="1"/>
                   
                    <form:label   path="adminEmailId">Email Id</form:label>
                    <form:input path="adminEmailId" cssClass="input_full" tabindex="2"/>
                </div>
                
                <div data-role="fieldcontain" >
		            <form:label path="bodyText" cssClass="input_full">Body Text</form:label> 
		            <form:textarea path="bodyText" rows="3" cssClass="input_full" tabindex="3"/>
		      </div>
			
				<button type="button" id="saveTemp"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<c:if test="${taskNotificationTemplate.id == null}">
					<span class="ui-button-text" tabindex="4">Save</span>
					</c:if>
					<c:if test="${taskNotificationTemplate.id != null}">
    	                <span class="ui-button-text" tabindex="4">Update</span>
    	                </c:if>
				</button>
				&nbsp;&nbsp;

				<!-- <button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text">Cancel</span>
				</button> -->
				
				<button type="button" id="hideformTemplate"
					onclick="window.location='mobileadminTaskNotificationTemplateHome.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text">Back</span>
					</button>
	</form:form>
</div>

<!-- BUCKET -->

</body>
