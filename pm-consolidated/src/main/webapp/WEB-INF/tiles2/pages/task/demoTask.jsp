<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

	<style type="text/css">
		.task fieldset p.error label { color: red; }
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
			form.task { width: 30em; }
			form.task label.error {
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
$(document).ready(function() {

	$.validator.addMethod("alphabetsOnly", function(value, element) {  
	    return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);  
	},"Please enter a valid Note.");
	
	$.validator.addMethod("alphaNumeric", function(value, element) {  
	    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
	},"Please enter valid Number.");

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
			var validator = $("#task").validate({
		
				rules: { 
					'client': {required: true,min:1},
					'filingType':{required: true,min:1},
					'status': {required: true,min:1},
					'practiceId': {required: true,min:1},
					'dueDate': {required: true,date: true},
			        'actualCompletionDate': {required: true,date: true},
					'staffInCharge': {required: true,min:1},
			        'clientStaffInCharge': {min:1},
			        'partnerInCharge': {required: true,min:1},
					'taskNote': {alphabetsOnly: true,minlength: 0,maxlength: 50}
        		}, 
        		messages: { 
        			'client': "Select one Client Name",
        			'filingType': "Select one Filing Type", 
	        		'status': "Select one Status of Task",
	        		'practiceId': "Select one Tax Type",
	        		'dueDate': {
	        			required: "Due Date is required",
	            		date: "Enter a valid Due Date in the format dd/mm/yyyy"},
	        		'actualCompletionDate': {
	            		required: "Actual Completion Date is required",
	            		date: "Enter a valid Actual Completion Date in the format dd/mm/yyyy"},
	        		'staffInCharge': "Select one Assigned To",
	        		'clientStaffInCharge': "Select one Client Staff In-charge",
	        		'partnerInCharge': "Select one Partner In Charge",
	        		'taskNote': {
	                    	required: "Note is required",
	                    	alphabetsOnly: "No Special characters are allowed. Please enter a valid Note.",
	                    	minlength: "Enter Note with at least {0} characters.",
	                    	maxlength: "Enter Note with no more than {0} characters."
		            }
        		}, 
        		
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate",
				submitHandler: function(form) {
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#task').serialize(),
				        url: 'taskModule.do',
				        success: function(taskId) {
				        	$('#cboxClose').click();
				              	if(taskId != -1){
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
	 
	 $("#newTask").click(function(){
			$('#edit').load('taskModule.do');
			
			});
	 
	 
	 $("#backToList").click(function(){
			$('#list').load('taskList.do');
			$('#mainTaskTabs a:first').tab('show');
			});
	 });

$().ready(function() {
	$("#cancel").click(function() {
		$('#cboxClose').click();
		 return false;
	});	
});

</script>

<div class="row-fluid">
	<div class="span1"></div>
	<div class="span10">
<form:form name="task" modelAttribute="task" method="POST" action="">
  <input type="hidden" name="clientId" value="${param.clientId }"/>
  <input type="hidden" name="taskId" value="${param.taskId }"/>
  <input type="hidden" name="baseURL" id="baseURL" value="/task/taskModule.do"/>
  
  		<form:hidden path="id"/>
  		
			<div class="container_12 mt20">
                    <div class="row">
                    <div class="span3">
                    <form:label  path="client"><spring:message code="label.clientname"/></form:label>
                    	<c:choose>
                  			<c:when test="${not empty param.taskId }">
                   				<form:input path="client.name" cssClass="input_full" tabindex="1" readonly="true" disabled="true"/> 
                   			</c:when>
                   			<c:otherwise>
		                  		<form:select path="client" tabindex="3" cssClass="input_full">
		                        	<form:option value="-1" label="Select"/>
		                            <form:options items="${clientList}" itemValue="id" itemLabel="name" />	
		                   		</form:select>
		                  	</c:otherwise>
		                 </c:choose>
                    </div>
                   
                 
                    <div class="span3">
                       <form:label  path="filingType"><spring:message code="label.filingType"/></form:label>
                    	<c:choose>
                  			<c:when test="${not empty param.taskId }">
                   				<form:input path="filingTitle" cssClass="input_full" tabindex="2" readonly="true" disabled="true"/> 
                   			</c:when>
                   			<c:otherwise>
                   				<form:select path="filingType" tabindex="3" cssClass="input_full">
		                        	<form:option value="-1" label="Select"/>
		                            <form:options items="${filingTypeList}" itemValue="id" itemLabel="name" />	
		                   		</form:select>
		                  	</c:otherwise>
		                 </c:choose>
                    </div>
                     <div class="span3">
                     <form:label path="status"><spring:message code="label.statusOfTask"/></form:label>
                   
						<c:choose>
	                  		<c:when test="${not empty param.taskId }">
	                   			<form:select path="status" tabindex="5" cssClass="input_full">
	                  				<form:option value="-1" label="Select" />
					  				<form:options items="${statusCodeList}" itemValue="id" itemLabel="statusName" />	
	                  			</form:select>
	                  		</c:when>
	                  		<c:otherwise>
	                  			 <%-- <form:input path="status.statusName" class="input" tabindex="5" readonly="true" disabled="true" cssClass="input_full"/>  --%> 
	                 		     <form:select path="status" tabindex="3" cssClass="input_full">
	                  				<form:option value="-1" label="Select" />
					  				<form:options items="${statusCodeList}"  itemValue="id" itemLabel="statusName"/>	
	                  			</form:select> 
	                  		</c:otherwise>
	                  	</c:choose>
                     </div>
              </div>

                <div class="row">
                    <div class="span3">
                    <form:label  path="practiceId"><spring:message code="label.taxType"/></form:label>
						<c:choose>
	                  		<c:when test="${not empty param.taskId }">
	                  			<form:input path="practiceId.name" cssClass="input_full" tabindex="4" readonly="true" disabled="true"/> 
	                  		</c:when>
	                  		<c:otherwise>
	                   			<form:select path="practiceId" tabindex="4"  cssClass="input_full">
	                 				<form:option value="-1" label="Select" />
					  				<form:options items="${taxTypeList}" itemValue="key" itemLabel="value" />
	                  			</form:select>
	                  		</c:otherwise>
	                  	</c:choose>
                    </div>
                    
                    <div class="span3">
                    <form:label   path="dueDate"><spring:message code="label.duedate"/></form:label>
                    <c:choose>
		                  <c:when test="${not empty param.taskId }">
		                  	<form:input path="dueDate" cssClass="input_full" tabindex="5" readonly="true" disabled="true"/>
		                  </c:when>
		                  <c:otherwise>
		                  	 <form:input path="dueDate"  id="incorporationDatepicker" cssClass="input_full" tabindex="5"/>
		                  </c:otherwise>
		                </c:choose>
                    </div>
                    
                     <div class="span3">
                     <form:label   path="actualCompletionDate"><spring:message code="label.actaulCompletionDate"/></form:label>
                     <form:input   path="actualCompletionDate" id="incorporationDatepicker1"   cssClass="input_full" tabindex="6"/>
                     </div>
                      
                    
                </div>
                
               
                
                 <div class="row">
                    <div class="span3">
                     <form:label   path="staffInCharge"><spring:message code="label.assignedTo"/></form:label>
                    	<form:select path="staffInCharge" id="staff" cssClass="input_full" tabindex="7">
                        	<form:option value="-1" label="Select"/>
                       	 	<form:options items="${staffList}" itemValue="key" itemLabel="value" />	
                    	</form:select>
					</div>
					
                    <div class="span3">
                    <form:label  path="clientStaffInCharge"><spring:message code="label.clientstaffInCharge"/></form:label>
						<form:select path="clientStaffInCharge" tabindex="8" cssClass="input_full">
			                <form:option value="-1" label="Select" />
							<form:options items="${clientStaffList}" itemValue="key" itemLabel="value" />	
						</form:select>
                    </div>
                     <div class="span3">
                     <form:label  path="partnerInCharge"><spring:message code="label.partnerInCharge"/></form:label>
                     <form:select path="partnerInCharge" tabindex="9" cssClass="input_full">
			                <form:option value="-1" label="Select" />
							<form:options items="${partnerList}" itemValue="key" itemLabel="value" />	
						</form:select>
                     </div>
             </div>
                
                
                
                <div class="row">
                
		            <div class="span3" >
		            <form:label path="taskNote" cssClass="input_full"><spring:message code="label.note"/></form:label>    
		            <form:textarea path="taskNote" rows="3" style="width:300px; height:100px;" cssClass="input_full" tabindex="17"/>
		              </div>
		      </div>
  
		
        	
        	<div class="row">
            	
	            <div class="span">
            		
            			<c:if test="${task.id != null}">
		                	<button  id="save"
								class="btn btn-success" >
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</button>&nbsp;&nbsp;

				             <button id="cancel"
				              	class="btn btn-success"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				        	</button>&nbsp;&nbsp;	
	                	
	            		</c:if>
            		
		        </div>
            </div>
              </div>
	</form:form>	

							

	</div>
	<div class="span1"></div>
</div>
