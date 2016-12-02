<%@ include file="../../layout/PM-INCLUDES.jsp"%>


<style type="text/css">
div.error_container {
	background-color: #eee;
	border: 2px solid red;
	width: 40em;
}

div.error_container ol li {
	list-style-type: disc;
}

div.error_container {
	display: none
}

.error_container label.error {
	display: inline;
}

form.party label.error {
	display: block;
	margin-left: 1em;
	width: auto;
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

<div class="error_container">
	<h7>
	<b>Please correct the following errors</b></h7>
	<ol></ol>
</div>

<form:form modelAttribute="task">
	<input type="hidden" name="clientId" value="${param.clientId }" />
	<input type="hidden" name="taskId" value="${param.taskId }" />
	<input type="hidden" name="baseURL" id="baseURL"
		value="/mobiletask/mobileTaskmodule.do" />
	<form:hidden path="previousStaff" />
	<form:hidden path="id" />
	<div data-role="fieldcontain">

		<form:label path="client">Client Name </form:label>
		<c:choose>
			<c:when test="${not empty param.taskId }">
				<form:input path="client.name" cssClass="input_full" tabindex="1"
					readonly="true" disabled="true" />
			</c:when>
			<c:otherwise>
				<form:select path="client" tabindex="3" cssClass="input_full">
					<form:option value="-1" label="Select" />
					<form:options items="${clientList}" itemValue="id" itemLabel="name" />
				</form:select>
			</c:otherwise>
		</c:choose>
	</div>

	<div data-role="fieldcontain">
		<form:label path="filingType">  Filing Type</form:label>
		<c:choose>
			<c:when test="${not empty param.taskId }">
				<form:input path="filingTitle" cssClass="input_full" tabindex="2"
					readonly="true" disabled="true" />
			</c:when>
			<c:otherwise>
				<form:select path="filingType" tabindex="3" cssClass="input_full">
					<form:option value="-1" label="Select" />
					<form:options items="${filingTypeList}" itemValue="id"
						itemLabel="name" />
				</form:select>
			</c:otherwise>
		</c:choose>
	</div>

	<div data-role="fieldcontain">
		<form:label path="status">Status of Task </form:label>
		<!-- <input name="status" id="status" placeholder="" value="" type="text"> -->
		<c:choose>
			<c:when test="${not empty param.taskId }">
				<form:select path="status" tabindex="5" cssClass="input_full">
					<form:option value="-1" label="Select" />
					<form:options items="${statusCodeList}" itemValue="id"
						itemLabel="statusName" />
				</form:select>
			</c:when>
			<c:otherwise>
				<%-- <form:input path="status.statusName" class="input" tabindex="5" readonly="true" disabled="true" cssClass="input_full"/>  --%>
				<form:select path="status" tabindex="3" cssClass="input_full">
					<form:option value="-1" label="Select" />
					<form:options items="${statusCodeList}" itemValue="id"
						itemLabel="statusName" />
				</form:select>
			</c:otherwise>
		</c:choose>

	</div>
	<div data-role="fieldcontain">
		<form:label path="practiceId">Tax Type</form:label>
		<c:choose>
			<c:when test="${not empty param.taskId }">
				<form:input path="practiceId.name" cssClass="input_full"
					tabindex="4" readonly="true" disabled="true" />
			</c:when>
			<c:otherwise>
				<form:select path="practiceId" tabindex="4" cssClass="input_full">
					<form:option value="-1" label="Select" />
					<form:options items="${taxTypeList}" itemValue="key"
						itemLabel="value" />
				</form:select>
			</c:otherwise>
		</c:choose>
		<!-- <input name="taxtype" id="practiceId" placeholder="" value="" type="text"> -->

	</div>
	<div data-role="fieldcontain">
		<form:label class="ui-input-text" path="dueDate"> Due Date</form:label>
		<c:choose>
			<c:when test="${not empty param.taskId }">
				<form:input path="dueDate" readonly="true" disabled="true" />
			</c:when>
			<c:otherwise>
				<form:input path="dueDate" id="date" cssClass="input_full"
					tabindex="5" />
			</c:otherwise>
		</c:choose>
		<!--  <input name="dueDate" id="dueDate" placeholder="" value="" type="date"> -->

	</div>
	
	<div data-role="fieldcontain">
		<form:label class="ui-input-text" path="actualCompletionDate">Actual Completion Date</form:label>
		<form:input path="actualCompletionDate" id="completiondate" />
		<!-- <input name="actualCompletionDate" id="actualCompletionDate" placeholder=""
                    value="" type="date"> -->
	</div>
	
	<div data-role="fieldcontain">
		<form:label class="ui-input-text" path="staffInCharge">Assigned To</form:label>
		<form:select path="staffInCharge" id="staff" cssClass="input_full"
			tabindex="7">
			<form:option value="-1" label="Select" />
			<form:options items="${staffList}" itemValue="key" itemLabel="value" />
		</form:select>
		<!--  <input name="staffInCharge" id="staffInCharge" placeholder="" value=""
                    type="text"> -->
	</div>
	
	<div data-role="fieldcontain">
		<form:label path="clientStaffInCharge"> Client Staff InCharge</form:label>
		<form:select path="clientStaffInCharge" tabindex="8"
			cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${clientStaffList}" itemValue="key"
				itemLabel="value" />
		</form:select>
		<!--  <input name="clientStaffInCharge" id="clientStaffInCharge" placeholder=""
                    value="" type="text"> -->
	</div>
	
	<div data-role="fieldcontain">

		<form:label path="partnerInCharge">  Partner In Charge </form:label>

		<form:select path="partnerInCharge" tabindex="9" cssClass="input_full">
			<form:option value="-1" label="Select" />
			<form:options items="${partnerList}" itemValue="key"
				itemLabel="value" />
		</form:select>
		<!--  <input name="partnerInCharge" id="partnerInCharge" placeholder="" value=""
                    type="text"> -->
	</div>
	
	<div data-role="fieldcontain">

		<form:label class="ui-input-text" path="taskNoteWithOutTimeStamp"> Notes  </form:label>
			<form:textarea path="taskNoteWithOutTimeStamp" name="taskNote"
				id="taskNote" placeholder=""></form:textarea>
	</div>
	
	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
		<c:if test="${task.id == null}">
			<button type="button" id="mobtaskSave" data-mini="true"
				data-inline="true"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				data-role="button">
				<span class="ui-button-text">Save</span>
			</button>
		</c:if>
		<c:if test="${task.id != null}">
			<button type="button" id="mobtaskSave" data-mini="true"
				data-inline="true"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				data-role="button">
				<span class="ui-button-text">Update</span>
			</button>
		</c:if>

		<a href="mobileTaskList.do" style="text-decoration: none;">
			<button type="button" id="newClient"
				onclick="window.location='mobileTaskList.do';return false;"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				data-role="button" aria-disabled="false" data-inline="true"
				data-mini="true">
				<span class="ui-button-text">Back</span>
			</button> </a>
		<!-- <button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
				             	<span class="ui-button-text">Cancel</span>
				        </button> -->&nbsp;&nbsp;
      </security:authorize>

	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
		<c:if test="${task.id != null}">
			<button type="button" id="mobtaskSave"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				data-role="button" aria-disabled="false" data-inline="true"
				data-mini="true">
				<span class="ui-button-text" tabindex="16">Update</span>
			</button>&nbsp;&nbsp;
							
				             <!-- <button type="reset"
				              	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				               	data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
				             	<span class="ui-button-text">Cancel</span>
				        </button> -->&nbsp;&nbsp;
				        
				        <a href="mobileTaskList.do" style="text-decoration: none;">
				<button type="button" id="newClient"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					data-role="button" aria-disabled="false" data-inline="true"
					data-mini="true">
					<span class="ui-button-text">Back</span>
				</button> </a>
		</c:if>
	</security:authorize>
</form:form>
<br />

<table border="1" width="70%" align="center">
	<tr>
		<td rowspan="2"><br />
			<div style="height: 100px; width: inherit; overflow-y: scroll;">${taskNote}</div>
			<br /></td>
	</tr>
</table>
<br />
<br />

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
	$(document).ready(function() {
		var queryDate = new Date();
		//queryDate.setFullYear(2009, 11, 01);
		$('#completiondate').datepicker({
			defaultDate : queryDate,
			changeMonth: true,
            changeYear: true,
            yearRange: '-40:+20'
		});
	});
</script>


<script type="text/javascript">
 $(document).ready(function() {

		$.validator.addMethod("alphabetsOnly", function(value, element) {  
		    return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);  
		},"Please enter a valid Note.");
		
		$.validator.addMethod("alphaNumeric", function(value, element) {  
		    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
		},"Please enter valid Number.");

	});
 $.validator.setDefaults({
		submitHandler: function(form) {
		   	form.submit();
		}
	});
 $().ready(function() {
			$("#mobtaskSave").click(function() {
			var container = $('div.error_container');
			/* if($("#task").validate({
		
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
        		} */
			/* }).form()){ */
				$.ajax({
					dataType: 'json',
		            type: 'POST',
				    data: $('#task').serialize(),
		            url: 'mobileTaskmodule.do',
		            success: function(data) {
		            	var updateEntityKey = data.entityKey;
		            	 var t = $("#id").val(); 
			            if(updateEntityKey != -1){
		        		   $.jGrowl("Record saved successfully");
				            if(t!=""){
				            	window.location="mobileTaskList.do";
				            }else{
				            	document.getElementById("task").reset();
				            	$('#mobileTaskGrid').dataTable().fnReloadAjax('mobiletaskajaxlist.do');
				            }   	
			            }else{
		        		   $.jGrowl("As Error has happened while process. ");	
		        	    } 
		        }
			});
				return false;
			/* }else{
				return false; 
			}*/
				/* errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate" */
			});
			//$("#task").submit();
			});
			/* $(".cancel").click(function() {
				validator.resetForm();
			}); */
 </script>

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
    
    (function () {
   	 var previous;
       $("select[name=staffInCharge]").focus(function () {
           // Store the current value on focus, before it changes
           previousStaff = this.value;
       }).change(function() {
          previous = this.value;
       });
   })();
</script>