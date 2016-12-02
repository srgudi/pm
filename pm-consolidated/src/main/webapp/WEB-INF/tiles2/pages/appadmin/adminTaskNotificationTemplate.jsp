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

		$.validator.addMethod("alphabetsOnly", function(value, element) {  
		    return this.optional(element) || /^\s*[0-9a-zA-Z-.,@:%\s]+\s*$/i.test(value);  
		},"No Special characters are allowed. Please enter a valid.");
		
		$.validator.addMethod("multiemail", function(value, element) {  
		    return this.optional(element) || /^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$/i.test(value);  
		}," Please enter a valid Email ids..");

		
	});

	
		
	</script>
 <script type="text/javascript">
$().ready(function() {
	
	/* var editId = $("#newTemplateId").val();
	//alert("hi"+editId); 
	var editStatus=new Boolean();
	console.log(editId);
	  if (editId != "")
		{
		  editStatus = true;
		} */
	 $("#templateSave").click(function() {
		// alert("saving");
		 		var container = $('div.error_container');
		// validate the form when it is submitted
	 	var validator = $("#taskNotificationTemplate").validate({
		
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
            		},
            		errorContainer: container,
    				errorLabelContainer: $("ol", container),
    				wrapper: 'li',
    				meta: "validate",
    				 submitHandler: function(form){
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#taskNotificationTemplate').serialize(),
				       url: 'adminTaskNotificationTemplate.do',
				        success: function(templateId) {
				        //	$('#cboxClose').click();
			            if(templateId != " "){
		            		$.jGrowl("Record saved successfully");
		            		$('#getTemplate').dataTable().fnReloadAjax('taskNotificationTemplateList.do');
		            		if($("#newTemplateId").val()!=""){
		            			//alert("hello");
	            				 $('#templatehome').show();
	            				 $('#templateTabs a:first').tab('show');
	            				 $('#templatefoo').hide();
	            			}else{
	            				document.getElementById("taskNotificationTemplate").reset();
	            			}
		            		/* $('#subject').val("");
		            		$('#bodyText').val("");
		            		$('#adminEmailId').val(""); */
		            	}else{
		            		 $.jGrowl("As Error has happened while process. ");	
		            	 } 
		            }
	
				});
		 return false;
    	}
	 });
		//$("#taskNotificationTemplate").submit();
   }); 

	  $("#newTaskNotification").click(function(){
			$('#templatefoo').load('adminTaskNotificationTemplate.do');
			
	 }); 
	 
	/*   $("#templateCancel").click(function(){
		 $('#cboxClose').click();
		 return false;
		
	 });   */
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

<div class="well">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<!-- <h6><span class="legend b">Notification Template</span></h6> -->
<div class="f13">
	<form:form modelAttribute="taskNotificationTemplate" method="POST" action="">
<!-- 	<input type="hidden" name="baseURL" id="baseURL" value="adminTaskNotificationTemplate.do" /> -->
	<i><b><form:errors path="*" class="errorblock" element="div" /></b></i>
	<input type="hidden" id="newTemplateId" value="${param.id}"/>
	   <form:hidden path="id" />
				<div class="container_12 mt20">
				</br>
				</br>
				  <div class="row">
				  	<div class="span4">
                    	<div class="grid_8"><form:label path="subject"><spring:message code="label.subject"/></form:label></div>
                    	<div class="grid_8"><form:input path="subject" cssClass="formInput" tabindex="1"/></div>
                    </div>
                    <div class="span4">	
                    	<form:label path="adminEmailId"><spring:message code="label.emailaddress"/></form:label>
                    	<form:input path="adminEmailId" cssClass="formInput" tabindex="2"/>
                    </div>
                  </div>
                
                <div class="row">
                <div class="span4">
		            <form:label path="bodyText" cssClass="input_full"><spring:message code="label.bodyText"/></form:label>
		            <form:textarea path="bodyText" style="width: 400px;height:100px;" cssClass="formInput" tabindex="3"/>
		         </div>   
		        </div> 
		        </div>
                           
		<div class="container_12" style="margin: 10px;"></div>

		<div class="container_12">
			<div class="grid_3">&nbsp;</div>
			<div class="grid_8">
				
					<%--  <button type="reset" id="newTaskNotification"
						class="btn btn-primary">
						<span class="ui-button-text"><spring:message code="label.newTaskNotification"/></span>
					</button> 	&nbsp;&nbsp; --%>

				<button  id="templateSave"
					class="btn btn-success" 
					role="button" aria-disabled="false">
					<c:if test="${taskNotificationTemplate.id == null}">
					<span class="ui-button-text" tabindex="4"><spring:message code="label.save"/></span>
					</c:if>
					<c:if test="${taskNotificationTemplate.id != null}">
    	                <span class="ui-button-text" tabindex="4"><spring:message code="label.update"/></span>
    	                </c:if>
				</button>
				&nbsp;&nbsp;
				 <button type="button" id="backList"
								class="btn btn-success"
								role="button" aria-disabled="false" onclick="templateList()">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.backToList"/></span>
                              </button>   

				<%--  <button type="reset"
					class="btn btn-success"
					role="button" aria-disabled="false">
					<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				</button>  --%>
			</div>
		</div>
	</form:form>
</div>
	</div>
</div>
<script>
function templateList(){
	$('#templateTabs a:first').tab('show');
	$('#templatehome').show();
	$('#templatefoo').hide();	
}
	</script>


