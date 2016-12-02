<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<!-- <meta name="viewport" content="width=100px, initial-scale=1"> -->
<style type="text/css">
.firmPracticeType fieldset p.error label {
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

form.firmPracticeType {
	width: 30em;
}

form.firmPracticeType label.error {
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

element.style {
	width: 200px;
}
</style>
<!-- <style>
table.pretty {
    width: 50%;
    clear: both;
}
 
table.pretty td,
table.pretty th {
    padding: 5px;
    border: 1px solid #fff;
}
table.pretty thead th {
    text-align: center;
    background: #66a9bd;
}
table.pretty tbody th {
    text-align: left;
}
     
table.pretty tbody td {
    text-align: center;
    background: #d5eaf0;
}
         
table.pretty tbody tr.odd td {
    background: #bcd9e1;
}
table.pretty tfoot th {
    background: #b0cc7f;
    text-align: left;
}
     
table.pretty tfoot td {
    background: #d7e1c5;
    text-align: center;
    font-weight: bold;
}
div.dataTables_wrapper {
   /*  background-color: #719ba7; */
}
</style> -->
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$.validator
								.addMethod("alphabetsOnly", function(value,
										element) {
									return this.optional(element)
											|| /^\s*[a-zA-Z.\s]+\s*$/i
													.test(value);
								},
										"No Special characters are allowed. Please enter a valid.");

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
						$("#saveTaxType")
								.click(
										function() {
											/* $.ajax({
											dataType: 'json',
											type: 'POST',
											data: $('#firmPracticeType').serialize(),
											url: 'manageTaxModuleMobile.do',
											success: function(data){
											var updateEntityKey = data.entityKey;
											if(updateEntityKey != "-1"){
											$.jGrowl("Record saved successfully");
											}else{
											  $.jGrowl("As Error has happened while process. ");	
											} 
											}
											});
											return false;  */

											if ($('#firmPracticeType')
													.validate(
															{
																rules : {
																	'taxApplicationPracticeType.name' : {
																		required : true,
																		alphabetsOnly : true,
																		minlength : 0,
																		maxlength : 50
																	},
																	'taxApplicationPracticeType.description' : {
																		required : true,
																		alphabetsOnly : true,
																		minlength : 0,
																		maxlength : 100
																	}
																},
																message : {
																	'taxApplicationPracticeType.name' : {
																		required : "Name is required",
																		alphabetsOnly : "No special characters and numbers allowed",
																		minlength : "Enter Tax Name with at least {0} characters.",
																		maxlength : "Enter Tax Name with no more than {0} characters."
																	},
																	'taxApplicationPracticeType.description' : {
																		required : "Description is required",
																		alphabetsOnly : "No special characters and numbers allowed",
																		minlength : "Enter Tax Description with at least {0} characters.",
																		maxlength : "Enter Tax Description with no more than {0} characters."
																	}
																}
															}).form()) {
												//alert("success");
												$.ajax({
															dataType : 'json',
															type : 'POST',
															data : $('#firmPracticeType').serialize(),
															url : 'manageTaxModuleMobile.do',
															success : function(
																	data) {
																var updateEntityKey = data.entityKey;
																if (updateEntityKey != "-1") {
																	$.jGrowl("Record saved successfully");
																	if($("#id").val()!=""){
												        				window.location.href="taxtypeMobileList.do";
											            			}else{
												        				document.getElementById("firmPracticeType").reset();
												        			}
																} else {
																	$.jGrowl("As Error has happened while process. ");
																}
															}
														});
												return false;
											} else {
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



<div class="error_container">
	<h7>
	<b>Please correct the following errors</b></h7>
	<ol></ol>
</div>

<!-- 
<span class="legend b">Tax</span> -->

<body>

	<div>

		<form:form modelAttribute="firmPracticeType">
			<input type="hidden" name="baseURL" id="baseURL"
				value="manageTaxModuleMobile.do" />
			<input type="hidden" name="inValidClientId"
				value="${param.inValidClientId }" />
			<i><b><form:errors path="*" class="errorblock" element="div" />
			</b> </i>
			<form:hidden path="id" />

			<center>
				<b><strong>${inValidClientId}</strong> </b>
			</center>

			<div data-role="fieldcontain">
				<form:label path="taxApplicationPracticeType.name">Name</form:label>
				<form:input path="taxApplicationPracticeType.name"
					cssClass="input_full" tabindex="1" />
			</div>
			<div data-role="fieldcontain">
				<form:label path="taxApplicationPracticeType.description">Description</form:label>
				<form:input path="taxApplicationPracticeType.description"
					cssClass="input_full" tabindex="2" />
			</div>
			<security:authorize
				access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">

				<button type="button" id="saveTaxType"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					data-role="button" aria-disabled="false" data-inline="true"
					data-mini="true">
					<c:if test="${firmPracticeType.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
					</c:if>
					<c:if test="${firmPracticeType.id != null}">
						<span class="ui-button-text" tabindex="12">Update</span>
					</c:if>
				</button>
					&nbsp;&nbsp;
				        <!-- <button type="reset"
				                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				                data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
				            <span class="ui-button-text">Cancel</span>
				        </button> -->
			</security:authorize>

			<security:authorize
				access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
				<c:if test="${firmPracticeType.id != null}">
					<button type="button" id="saveTaxType"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						data-role="button" aria-disabled="false" data-inline="true"
						data-mini="true">
						<span class="ui-button-text" tabindex="16">Update</span>
					</button>
							&nbsp;&nbsp;
		                	
		                    <!-- <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button> -->
				</c:if>
			</security:authorize>
			<button id="showTaxTypeGrid"
				onclick="window.location='taxtypeMobileList.do';return false;"
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				role="button" aria-disabled="false" data-inline="true"
				data-mini="true">
				<span class="ui-button-text">Back</span>
			</button>

		</form:form>
	</div>
</body>
<br />


