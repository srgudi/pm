<%@ include file="../../layout/PM-INCLUDES.jsp"%>

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
				meta: "validate"
				});
			$("#task").submit();
			});
	
			$(".cancel").click(function() {
				validator.resetForm();
			});
		});
	</script>

<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Task Details</span>
<div class="f13">
   <form:form modelAttribute="task" method="POST" action="taskModule.do">
  <input type="hidden" name="clientId" value="${param.clientId }"/>
  <input type="hidden" name="taskId" value="${param.taskId }"/>
  <input type="hidden" name="baseURL" id="baseURL" value="/task/taskModule.do"/>
  
  		<form:hidden path="id"/>
  		
			<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label  path="client">Client Name</form:label></div>
                    <div class="grid_3 right">
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
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="filingType">Filing Type</form:label></div>
                    <div class="grid_3 right">
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
                </div>

                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="status">Status of Task</form:label></div>
                    <div class="grid_3 right">
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
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="practiceId">Tax Type</form:label></div>
                    <div class="grid_3 right">
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
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="dueDate">Due Date</form:label></div>
                    <div class="grid_3 right">
						<c:choose>
		                  <c:when test="${not empty param.taskId }">
		                  	<form:input path="dueDate" cssClass="input_full" tabindex="5" readonly="true" disabled="true"/>
		                  </c:when>
		                  <c:otherwise>
		                  	 <form:input path="dueDate"  id="incorporationDatepicker" cssClass="input_full" tabindex="5"/>
		                  </c:otherwise>
		                </c:choose>
					</div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="actualCompletionDate">Actual Completion Date</form:label></div>
                    <div class="grid_3 right"><form:input path="actualCompletionDate" id="incorporationDatepicker1" cssClass="input_full" tabindex="6"/></div>
                </div>
                
                 <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="staffInCharge">Assigned To</form:label></div>
                    <div class="grid_3 right">
                    	<form:select path="staffInCharge" id="staff" cssClass="input_full" tabindex="7">
                        	<form:option value="-1" label="Select"/>
                       	 	<form:options items="${staffList}" itemValue="key" itemLabel="value" />	
                    	</form:select>
					</div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label  path="clientStaffInCharge">Client Staff In-charge</form:label></div>
                    <div class="grid_3 right">
						<form:select path="clientStaffInCharge" tabindex="8" cssClass="input_full">
			                <form:option value="-1" label="Select" />
							<form:options items="${clientStaffList}" itemValue="key" itemLabel="value" />	
						</form:select>
                    </div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label  path="partnerInCharge">Partner In Charge</form:label></div>
                    <div class="grid_3 right">
						<form:select path="partnerInCharge" tabindex="9" cssClass="input_full">
			                <form:option value="-1" label="Select" />
							<form:options items="${partnerList}" itemValue="key" itemLabel="value" />	
						</form:select>
                    </div>
                </div>
                
                <div class="container_12 pt5">
		            <div class="grid_2 right"><form:label path="taskNote" cssClass="input_full">Note</form:label>      </div>
		            <div class="grid_5 right"><form:textarea path="taskNote" rows="3" cssClass="input_full" tabindex="17"/>      </div>
		      </div>
  
			<div class="container_12" style="margin:10px;"></div>
        	
        	<div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
					<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="taskModule.do" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	onclick="window.location='taskModule.do';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">New Task</span>
	                    	</button>
	                	</a>&nbsp;&nbsp;
	
	                	<button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<c:if test="${task.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${task.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>&nbsp;&nbsp;
						
				        <button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text">Cancel</span>
				        </button>&nbsp;&nbsp;
				        
				        <a href="taskList.do" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	onclick="window.location='taskList.do';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Back To Task List</span>
	                    	</button>
	                	</a>
	
            		</security:authorize>
            		<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            			<c:if test="${task.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>&nbsp;&nbsp;
							
				             <button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text">Cancel</span>
				        </button>&nbsp;&nbsp;
				        
				        <a href="taskList.do" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Back To Task List</span>
	                    	</button>
	                	</a>
	            		</c:if>
            		</security:authorize>
		        </div>
            </div>
	</form:form>
	</div>
	</div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
    	//alert('Hello Sai');    
    	firmId = ${firm.id};
        $("#client").change(function() {     
            $.get("<c:url value='/getClientStaffInCharge.do'/>", { clientId: $(this).val(), firmId:firmId }, function(data) {
                populateDropdown($("#clientStaffInCharge"), data);
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
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>

