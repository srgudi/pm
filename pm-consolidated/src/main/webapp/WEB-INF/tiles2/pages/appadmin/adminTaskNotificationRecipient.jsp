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

	$().ready(function() {
		/* var editId = $("#id").val();
		
		var editStatus=new Boolean();
		
		console.log(editStatus);
		  if (editId != "")
			{
			  editStatus = true;
			} */
		 $("#recipSave").click(function() {
			 //alert("Recip");
			 var id = $("#id").val();
			 var container = $('div.error_container');
				// validate the form when it is submitted
				var validator = $("#taskNotificationRecipient").validate({
			
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
	            		}, 
	            		errorContainer: container,
	    				errorLabelContainer: $("ol", container),
	    				wrapper: 'li',
	    				meta: "validate",
	    				submitHandler: function(form){
		                	$.ajax({
				            dataType: 'json',
				            type: 'POST',
			                data: $('#taskNotificationRecipient').serialize(),
					        url: 'adminTaskNotificationRecipient.do',
					        success: function(id) {
					        	//$('#cboxClose').click();
				              	if(id != -1){
			            		$.jGrowl("Record saved successfully");
			            		$('#getRecepient').dataTable().fnReloadAjax('taskNotificationRecipientList.do');
			            		/* document.getElementById("taskNotificationRecipient").reset(); */
			            		/* document.getElementById("emailType").reset();
			            		document.getElementById("recipient").reset();
			            		document.getElementById("notificationTemplateId").reset(); */
			            		/* var em=getElementById("recipient").value;
			            		alert(em);
			            		em=null; */
			            		if($("#id").val()!=""){
			            			$('#recepienthome').show();
			            			$('#recepientfoo').hide();
			            			$('#recepientsTabs a:last').tab('show');
			            		
			            		}
			            		else
			            			{
			            			document.getElementById("taskNotificationRecipient").reset(); 
			            			}
				              	}
			            	 else{
			            		 $.jGrowl("As Error has happened while process. ");	
			            	 } 
			            }
		
					});
			 return false;
	    	}
		 });
				 $("#getRecepient").dataTable().fnReloadAjax();
		 }); 
		 $("#newTaskNotificationRecepient").click(function(){
				$('#recepientfoo').load('adminTaskNotificationRecipient.do');
		 });
		 
		 
		 $("#backToList").click(function(){
				$('#list').load('recepientList.do');
				$('#recepientsTab a:last').tab('show');
				});
		 
		/*  $("#cancel").live("click",function() {
				//alert("inside cancel");
				$('#cboxClose').click();
				 return false;
			});	 */
		 });
	</script>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
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
<!-- <span class="legend b">Recipient</span> -->
<div class="f13">
	<form:form modelAttribute="taskNotificationRecipient">
	<input type="hidden" name="baseURL" id="baseURL" value="adminTaskNotificationRecipient.do" />
	<i><b><form:errors path="*" class="errorblock" element="div" /></b></i>
		
		<form:hidden path="id" />

				<div class="container_12 mt20" >
				</br>
				</br>
				   <div class="row">
				   	 <div class="span3">
                      <form:label path="recipient"><spring:message code="label.recepient"/></form:label>
                      <form:input path="recipient" cssClass="formInput" tabindex="1"/>
                     </div> 
                  
                   
                   	 <div class="span3">
                      <form:label   path="emailType" ><spring:message code="label.emailType" /></form:label>
                      <form:input path="emailType" cssClass="formInput" tabindex="2"/>
                     </div>   
                     <div class="span3">
                    		<form:label path="notificationTemplateId"><spring:message code="label.relativeParentCode"/></form:label>
                   			<form:select path="notificationTemplateId" tabindex="3" cssClass="formSelect">
							<form:option value="-1" label="Select" />
							<form:options items="${templateSet}" itemValue="id" itemLabel="subject" />
						</form:select>
					  </div>                    
                   </div> 
                   </br>
				<%-- <div class="row">
                 <div class="span">
					<button type="button" id="newTaskNotificationRecepient"
						class="btn btn-primary">
						<span class="ui-button-text"><spring:message code="label.newNotificationRecepient"/></span>
					</button>	&nbsp;&nbsp;  --%>

				<button  id="recipSave" class="btn btn-success">
					<c:if test="${taskNotificationRecipient.id == null}">
						<span class="ui-button-text" tabindex="4"><spring:message code="label.save"/></span>
					</c:if>
					<c:if test="${taskNotificationRecipient.id != null}">
						<span class="ui-button-text" tabindex="4"><spring:message code="label.update"/></span>
    	            </c:if>
				</button>
				&nbsp;&nbsp;
				  <button type="button" id="backList"
								class="btn btn-success"
								role="button" aria-disabled="false" onclick="recepientList()">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.backToList"/></span>
                              </button>   
				<%-- <button type="reset"
					class="btn btn-success">
					<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				</button> --%>
				</div>
				</div>
			</div>
		
		</div>
	</form:form>
	</div>
	</div>
</div>
 <script>
 function recepientList(){
		$('#recepienthome').show();
		$('#recepientsTabs a:first').tab('show');
		$('#recepientfoo').hide();	
	}
</script>  
<script type="text/javascript">
    var clear = true;
    function clear(obj)
    {
        if(clear)
        {
            obj.value = '';
            clear = false;
        }
    }
</script>



