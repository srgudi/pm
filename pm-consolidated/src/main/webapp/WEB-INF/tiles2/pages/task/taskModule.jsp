<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<style type="text/css">
.task fieldset p.error label {
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

form.task {
	width: 30em;
}

form.task label.error {
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
	color: red;
	font-style: italic
}

</style>
<!-- <script type="text/javascript">
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
	</script> -->


<script type="text/javascript">
	//var previous;
	var previousStaff;
	var intRegex = /^\d+(?:\.\d\d?)?$/;
	$(document).ready(
			function() {

				$.validator.addMethod("alphabetsOnly",
						function(value, element) {
							return this.optional(element)
									|| /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
						}, "Please enter a valid Note.");

				$.validator.addMethod("alphaNumeric", function(value, element) {
					return this.optional(element)
							|| /^[0-9A-Z-]+$/i.test(value);
				}, "Please enter valid Number.");
				
				$.validator.addMethod("amount", function(value, element) {
					return this.optional(element)
							|| /^\d+(?:\.\d\d?)?$/i.test(value);
				}, "Please enter valid Amount.");


			});
	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});
	$()
			.ready(
					function() {
						$("#save")
								.click(
										function() {
											var container = $('div.error_container');
											//alert(previousStaff);
											$("#previousStaff").val(
													previousStaff);
											$("#errMsg").text("");
											var sortType = $("#status").val();
											var acd = $(
													"#incorporationDatepicker1")
													.val();

											if (sortType == 1 & acd == "") {

												$("#errMsg")
														.text(
																"Please select actual completion date");
												$("#errMsg")
														.css('color', 'red');
												$("#incorporationDatepicker1")
														.css('border',
																'2px solid red');
												return false;
											}
											// validate the form when it is submitted
											var validator = $("#task")
													.validate(
															{

																rules : {
																	'client' : {
																		required : true,
																		min : 1
																	},
																	'filingType' : {
																		required : true,
																		min : 1
																	},
																	'status' : {
																		required : true,
																		min : 1
																	},
																	'practiceId' : {
																		required : true,
																		min : 1
																	},
																	'dueDate' : {
																		required : true,
																		date : true
																	},
																	'actualCompletionDate' : {
																		date : true
																	},
																	'staffInCharge' : {
																		required : true,
																		min : 1
																	},
																	'clientStaffInCharge' : {
																		min : 1
																	},
																	'partnerInCharge' : {
																		required : true,
																		min : 1
																	},
																	'taskNoteWithOutTimeStamp' : {
																		required : true
																	},
																	'paymentType.id' : {
																		required : true
																	},
																	'acknowledgementNo':{
																		min : 20,
																		max : 20,
																		alphaNumeric : true
																	},
																	'amountPaid':{
																		amount:true
																	}
															
																},
																messages : {
																	'client' : "Select one Client Name",
																	'filingType' : "Select one Filing Type",
																	'status' : "Select one Status of Task",
																	'practiceId' : "Select one Tax Type",
																	'dueDate' : {
																		required : "Due Date is required",
																		date : "Enter a valid Due Date in the format dd/mm/yyyy"
																	},
																	'actualCompletionDate' : {
																		required : "Actual Completion Date is required",
																		date : "Enter a valid Actual Completion Date in the format dd/mm/yyyy"
																	},
																	'staffInCharge' : "Select one Assigned To",
																	'clientStaffInCharge' : "Select one Client Staff In-charge",
																	'partnerInCharge' : "Select one Partner In Charge",
																	'taskNoteWithOutTimeStamp' : {
																		required : "Note is required"
																	},
																	'paymentType.id' : {
																		required : "Please select a payment Type."
																	},
																	'acknowledgementNo':{
																		min : "Please enter a minimum of 20 charecters.",
																		max : "Please enter a maximum of 20 charecters.",
																		alphaNumeric : "Please do not enter any special charecters."
																	},
																	'amountPaid':{
																		amount:"Please enter valid amount"
																	}
																},

																errorContainer : container,
																errorLabelContainer : $(
																		"ol",
																		container),
																wrapper : 'li',
																meta : "validate",
																submitHandler : function(
																		form) {
																	$
																			.ajax({
																				dataType : 'json',
																				type : 'POST',
																				data : $(
																						'#task')
																						.serialize(),
																				url : 'taskModule.do',
																				success : function(
																						data) {
																					var updateEntityKey = data.entityKey;
																					if (updateEntityKey != "-1") {
																						/* if(updateEntityKey == "-2"){
																							 $.jGrowl("Few or All The Email Ids are Invalid..");	
																						}else{ */

																						$
																								.jGrowl("Record saved successfully");

																						if ($(
																								"#entityKey")
																								.val() != '') {
																							timedmsg();
																						}

																						/* $("#entityKey").val(updateEntityKey); */
																						/*  $("#client").enable(false);
																						 $("#filingType").enable(false); */

																						document
																								.getElementById(
																										"task")
																								.reset();
																						$(
																								'#getAllTask')
																								.dataTable()
																								.fnReloadAjax(
																										'taskajaxlist.do');

																						// }
																					} else {
																						$
																								.jGrowl("As Error has happened while process. ");
																					}
																				}

																			});
																	return false;
																}
															});
											//$("#organization").submit();
										});

						$("#newTask").click(function() {
							$('#edit').load('taskModule.do');

						});

						$("#backToList").click(function() {
							$('#list').load('taskList.do');
							$('#mainTaskTabs a:first').tab('show');
						});
					});
</script>

<div class="tabbable" id="taskTabs">
	<ul class="nav nav-tabs reducedBottom" style="margin-bottom: 0px;"
		id="mainTaskTabs">
		<li><a data-target="#list" href="mainTask.do"
			onclick="window.location='mainTask.do';return false;"
			data-toggle="tab"> <i class="icon-list-ol"></i>
			<spring:message code="label.taskList" /></a></li>
		<li class="active"><a data-target="#edit"
			style="background-color: #F5F5F5;" class="active"
			href="taskModule.do"
			onclick="window.location='taskModule.do';return false;"
			data-toggle="tab"> <i class="icon-save"></i>
			<spring:message code="label.taskAddOrEdit" /></a></li>
	</ul>
</div>
<div class="well">
	<!--  BUCKET -->
	<span id="errMsg"></span><br />
	<br />&nbsp;
	<div class="error_container">
		<h7>
		<b>Please correct the following errors</b></h7>
		<ol></ol>
	</div>

	<div class="fieldset">
		<div class="f13">
			<form:form modelAttribute="task" method="POST" action="">

				<form:hidden path="entityKey" />
				<form:hidden path="previousStaff" />
				<div class="container_12 mt20">
					<div class="row">
						<div class="span3">
							<form:label path="client">
								<spring:message code="label.clientname" />
							</form:label>
							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey}">
										<form:input path="client.name" cssClass="input_full"
											tabindex="1" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="client" tabindex="3" cssClass="input_full"
											readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${clientList}" itemValue="id"
												itemLabel="name" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<c:choose>
									<c:when test="${not empty task.entityKey}">
										<form:input path="client.name" cssClass="input_full"
											tabindex="1" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="client" tabindex="3" cssClass="input_full">
											<form:option value="-1" label="Select" />
											<form:options items="${clientList}" itemValue="id"
												itemLabel="name" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
						</div>


						<div class="span3">
							<form:label path="filingType">
								<spring:message code="label.filingType" />
							</form:label>
							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="filingTitle" cssClass="input_full"
											tabindex="2" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="filingType" tabindex="3"
											cssClass="input_full" readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${filingTypeList}" itemValue="id"
												itemLabel="name" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="filingTitle" cssClass="input_full"
											tabindex="2" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="filingType" tabindex="3"
											cssClass="input_full">
											<form:option value="-1" label="Select" />
											<form:options items="${filingTypeList}" itemValue="id"
												itemLabel="name" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
						</div>
						<div class="span3">
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:label path="status">
									<spring:message code="label.statusOfTask" />
								</form:label>
								<c:choose>
									<c:when test="${not empty task.entityKey }">
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
							</security:authorize>
							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<form:label path="status">
									<spring:message code="label.statusOfTask" />
								</form:label>

								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:select path="status" tabindex="5" cssClass="input_full">
											<form:option value="-1" label="Select" />
											<form:option value="1" disabled="true">Completed</form:option>
											<form:option value="2" disabled="true">Awaiting Client Response</form:option>
											<form:option value="3" disabled="true">New</form:option>
											<form:option value="4">Processed</form:option>
											<%-- <form:options items="${statusCodeList}" itemValue="id" itemLabel="statusName" /> --%>
										</form:select>
									</c:when>
									<c:otherwise>
										<%-- <form:input path="status.statusName" class="input" tabindex="5" readonly="true" disabled="true" cssClass="input_full"/>  --%>
										<form:select path="status" tabindex="3" cssClass="input_full"
											readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${statusCodeList}" itemValue="id"
												itemLabel="statusName" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
						</div>
					</div>

					<div class="row">
						<div class="span3">
							<form:label path="practiceId">
								<spring:message code="label.taxType" />
							</form:label>
							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="practiceId.name" cssClass="input_full"
											tabindex="4" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="practiceId" tabindex="4"
											cssClass="input_full" readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${taxTypeList}" itemValue="key"
												itemLabel="value" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="practiceId.name" cssClass="input_full"
											tabindex="4" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="practiceId" tabindex="4"
											cssClass="input_full">
											<form:option value="-1" label="Select" />
											<form:options items="${taxTypeList}" itemValue="key"
												itemLabel="value" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
						</div>

						<div class="span3">
							<form:label path="dueDate">
								<spring:message code="label.duedate" />
							</form:label>
							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="dueDate" cssClass="input_full" tabindex="5"
											readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:input path="dueDate" id="incorporationDatepicker"
											cssClass="input_full" tabindex="5" readonly="true"
											disabled="true" />
									</c:otherwise>
								</c:choose>
							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="dueDate" cssClass="input_full" tabindex="5"
											readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:input path="dueDate" id="incorporationDatepicker"
											cssClass="input_full" tabindex="5" />
									</c:otherwise>
								</c:choose>
							</security:authorize>
						</div>

						<div class="span3">
							<form:label path="actualCompletionDate">
								<spring:message code="label.actaulCompletionDate" />
							</form:label>

							<security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="dueDate" cssClass="input_full" tabindex="6"
											readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:input path="dueDate" cssClass="input_full" tabindex="6"
											readonly="true" disabled="true" />
									</c:otherwise>
								</c:choose>
							</security:authorize>

							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:input path="actualCompletionDate"
									id="incorporationDatepicker1" cssClass="input_full"
									tabindex="6" />
							</security:authorize>
						</div>
					</div>



					<div class="row">
						<div class="span3">
							<form:label path="staffInCharge">
								<spring:message code="label.assignedTo" />
							</form:label>
							<security:authorize access="hasAnyRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="staffInChargeName" cssClass="input_full"
											tabindex="7" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="staffInCharge" id="staff"
											cssClass="input_full" readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${staffList}" itemValue="key"
												itemLabel="value" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>

							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:select path="staffInCharge" id="staff"
									cssClass="input_full" tabindex="7">
									<form:option value="-1" label="Select" />
									<form:options items="${staffList}" itemValue="key"
										itemLabel="value" />
								</form:select>
							</security:authorize>
						</div>

						<div class="span3">
							<form:label path="clientStaffInCharge">
								<spring:message code="label.clientstaffInCharge" />
							</form:label>
							<security:authorize access="hasAnyRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="clientStaffInChargeName"
											cssClass="input_full" tabindex="7" readonly="true"
											disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="clientStaffInCharge" cssClass="input_full"
											tabindex="7" readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${clientStaffList}" itemValue="key"
												itemLabel="value" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>

							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:select path="clientStaffInCharge" tabindex="8"
									cssClass="input_full">
									<form:option value="-1" label="Select" />
									<form:options items="${clientStaffList}" itemValue="key"
										itemLabel="value" />
								</form:select>
							</security:authorize>
						</div>

						<div class="span3">
							<form:label path="partnerInCharge">
								<spring:message code="label.partnerInCharge" />
							</form:label>
							<security:authorize access="hasAnyRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:input path="partnerInChargeName" cssClass="input_full"
											tabindex="7" readonly="true" disabled="true" />
									</c:when>
									<c:otherwise>
										<form:select path="partnerInCharge" cssClass="input_full"
											tabindex="7" readonly="true" disabled="true">
											<form:option value="-1" label="Select" />
											<form:options items="${partnerList}" itemValue="key"
												itemLabel="value" />
										</form:select>
									</c:otherwise>
								</c:choose>
							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:select path="partnerInCharge" tabindex="9"
									cssClass="input_full">
									<form:option value="-1" label="Select" />
									<form:options items="${partnerList}" itemValue="key"
										itemLabel="value" />
								</form:select>
							</security:authorize>
						</div>
					</div>

<div class="row">
<div class="span3">
<form:label path="paymentType.id" cssClass="input_full">
Payment Type
</form:label>
<form:select path="paymentType.id" tabindex="5" cssClass="input_full">
<form:option value="-1" label="Select" />
<form:options items="${paymentTypeList}" itemValue="id" itemLabel="type" />
</form:select>
</div>
<div class="span3">
<form:label path="amountPaid" cssClass="input_full">
Amount Paid
</form:label>
<form:input path="amountPaid"/>
</div>
<div class="span3">
<form:label path="acknowledgementNo" cssClass="input_full">
Acknowledgement Number
</form:label>
<form:input path="acknowledgementNo"/>
</div>
</div>
<div class="row">
<div class="span3" id="chequeDiv" hidden="true">
<form:label path="chqNo" cssClass="input_full">
Cheque Number
</form:label>
<form:input path="chqNo"/>
</div>
<div class="span3">
<form:label path="paidDate">
Payment Date								
</form:label>
<form:input path="paidDate"
id="incorporationDatepicker2"/>
</div>

<div class="span3" ">
</div>

</div>
					<div class="row">
						<div class="span3">
							<form:label path="taskNoteWithOutTimeStamp" cssClass="input_full">
								<spring:message code="label.note" />
							</form:label>
							<security:authorize access="hasAnyRole('ROLE_CLIENT_STAFF')">
								<c:choose>
									<c:when test="${not empty task.entityKey }">
										<form:textarea path="taskNoteWithOutTimeStamp" rows="3"
											style="width:510px; height:80px;" cssClass="input_full"
											tabindex="17" />
									</c:when>
									<c:otherwise>
										<form:textarea path="taskNoteWithOutTimeStamp" rows="3"
											style="width:510px; height:80px;" cssClass="input_full"
											tabindex="17" readonly="true" disabled="true" />
									</c:otherwise>
								</c:choose>
							</security:authorize>

							<security:authorize
								access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
								<form:textarea path="taskNoteWithOutTimeStamp" rows="3"
									style="width:510px; height:80px;" cssClass="input_full"
									tabindex="17" />
							</security:authorize>
						</div>
					</div>
					</br>


					<div class="row">

						<div class="span">
							<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
								<%-- <a href="taskModule.do" style="text-decoration:none;"> 
	                    	<button type="button" id="newTask"
	                    	
	                        	     class="btn btn-primary"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.newTask"/></span>
	                    	</button>&nbsp;&nbsp;
	                </a> --%>

								<button id="save" class="btn btn-success">
									<c:if test="${task.id == null}">
										<span class="ui-button-text" tabindex="16"><spring:message
												code="label.save" /></span>
									</c:if>

									<c:if test="${task.id != null}">
										<span class="ui-button-text" tabindex="16"><spring:message
												code="label.update" /></span>
									</c:if>
								</button>&nbsp;&nbsp;
						
				       <%--  <button type="reset"
				              	class="btn btn-success"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				        </button> --%>
								<!-- &nbsp;&nbsp; -->

								<a href="mainTask.do" style="text-decoration: none;">
									<button type="button" id="backToList" class="btn btn-success"
										role="button" aria-disabled="false">
										<span class="ui-button-text"><spring:message
												code="label.backToList" /></span>
									</button>
								</a>

							</security:authorize>
							<security:authorize
								access="hasAnyRole('ROLE_CLIENT_STAFF','ROLE_STAFF')">
								<c:choose>
									<c:when test="${task.status.id != 1}">
										<c:if test="${task.id != null}">
											<button id="save" class="btn btn-success">
												<span class="ui-button-text" tabindex="16"><spring:message
														code="label.update" /></span>
											</button>&nbsp;&nbsp;
							
				             <%-- <button type="reset"
				              	class="btn btn-success"
				               	role="button" aria-disabled="false">
				             	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
				        </button> --%>&nbsp;&nbsp;
				        
				         <a href="mainTask.do" style="text-decoration: none;">
												<button type="button" id="backToList"
													class="btn btn-success">
													<span class="ui-button-text"><spring:message
															code="label.backToList" /></span>
												</button>
											</a>

										</c:if>
									</c:when>
								</c:choose>
							</security:authorize>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<table border="1" width="100%">
		<tr>
			<td rowspan="2">
				<div style="height: 100px; width: inherit; overflow-y: scroll;">${taskNote}</div>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//alert('Hello Sai'); 
		
		$("#paymentType\\.id").change(function() {
			var payment_types = document.getElementById('paymentType.id');
			var type_content = payment_types.options[payment_types.selectedIndex];
			if(type_content.label == 'Cheque'){
				$("#chequeDiv").show();
			}else{
				$("#chequeDiv").hide();
			}
			
		});
		var newchequenumber = $("#chqNo").val();
		if(newchequenumber !== null & newchequenumber !== ""){
			$("#chequeDiv").show();
		} 
		var firmId = ${firm.id};
		$("#client").change(function() {
			$.get("<c:url value='/getClientStaffInCharge.do'/>", {
				clientId : $(this).val(),
				firmId : firmId
			}, function(data) {
				populateDropdown($("#clientStaffInCharge"), data);
			});
		});
	});

	function timedmsg() {
		setTimeout("window.location.href='mainTask.do'", 1000);
	}

	function populateDropdown(select, data) {
		select.html('');
		select.append($('<option></option>').val("-1").html("Select"));
		$.each(data, function(id, option) {
			$.each(option, function(id, option) {
				select.append($('<option></option>').val(option.key).html(
						option.value));

			});
		});
	}

	(function() {
		var previous;
		$("select[name=staffInCharge]").focus(function() {
			// Store the current value on focus, before it changes
			previousStaff = this.value;
		}).change(function() {
			previous = this.value;
		});
	})();
</script>
<!-- <script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script> -->

