<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.codeType fieldset p.error label {
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

form.codeType {
	width: 30em;
}

form.codeType label.error {
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
<%-- <c:url value="/mobileadmin/mobileAdminCodeType.do" var="mobileAdminCodeTypeModuleUrl">
    </c:url> --%>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$.validator.addMethod("alphaNumeric", function(value,
								element) {
							return this.optional(element)
									|| /^[0-9A-Z-]+$/i.test(value);
						}, "Please enter valid Number.");

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

	$().ready(
					function() {
						$("#save").click(function() {
							if($("#codeType")
									.validate(
											{

												rules : {
													'name' : {
														required : true,
														alphabetsOnly : true,
														minlength : 0,
														maxlength : 50
													},
													'description' : {
														alphabetsOnly : true,
														minlength : 0,
														maxlength : 100
													},
													'parentCodeType' : {}
												},
												messages : {
													'name' : {
														required : "Name is required",
														alphabetsOnly : "No Special characters are allowed. Please enter a valid Name.",
														minlength : "Enter Name with at least {0} characters.",
														maxlength : "Enter Name with no more than {0} characters."
													},
													'description' : {
														required : "Description is required",
														alphabetsOnly : "No Special characters are allowed. Please enter a valid Description.",
														minlength : "Enter Description with at least {0} characters.",
														maxlength : "Enter Description with no more than {0} characters."
													},
													'parentCodeType' : "Select Parent Code Type"
												}
												}).form()){
							$.ajax({
						           dataType: 'json',
						         type: 'POST',
					               data: $('#codeType').serialize(),
							       url: 'mobileAdminCodeType.do',
							       success: function(codeTypeId) {
							           	if(codeTypeId != -1){
							        		$.jGrowl("Record saved successfully");
							        		if($("#id").val()!=""){
						        				window.location.href="mobileadminCodeTypeHome.do";
					            			}else{
						        				document.getElementById("codeType").reset();
						        			}
							        		/* var tabl = $("#getcodetypemob").dataTable();
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
<%-- <a href="<c:out value='${mobileAdminCodeTypeModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showform" onclick="showform()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Code Type</span>
	                    	</button> 
	                	</a> --%>
<!--  BUCKET -->
<body onload="hideform()">
 <div id="div2"  >
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>
	<form:form modelAttribute="codeType" method="POST"
		action="mobileAdminCodeType.do">
		<input type="hidden" name="baseURL" id="baseURL"
			value="mobileAdminCodeType.do" />

		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>

		<form:hidden path="id" />
		
			<div data-role="fieldcontain" >
                  <form:label path="name">Name</form:label>
               <form:input path="name" cssClass="input_full" tabindex="1"/>
                  </div>
                  <div data-role="fieldcontain" >
                   <form:label   path="description">Description</form:label>
                   <form:input path="description" cssClass="input_full" tabindex="2"/>
                </div>
                
               <div data-role="fieldcontain" >
                <form:label path="parentCodeType">Parent Code Type</form:label>
                   		<form:select path="parentCodeType" cssClass="input_full" tabindex="3">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                  <div data-role="fieldcontain" >
                    <form:label   path="activeFlag">Status</form:label>
						<form:radiobutton path="activeFlag" value="true" label="Active" tabindex="4" />
						&nbsp;
						<form:radiobutton path="activeFlag" value="false" label="Inactive" tabindex="5" />
                </div>
                
                 <div data-role="fieldcontain" >
                  <form:label   path="applicationLevelIndicator">Application Level Indicator</form:label>
						<form:radiobutton path="applicationLevelIndicator" value="true" label="Yes" tabindex="6" />
						<form:radiobutton path="applicationLevelIndicator" value="false" label="No" tabindex="7" />
					</div>
                
				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<c:if test="${codeType.id == null}">
					<span class="ui-button-text" tabindex="8">Save</span>
					</c:if>
					<c:if test="${codeType.id != null}">
    	                <span class="ui-button-text" tabindex="8">Update</span>
    	                </c:if>
				</button>
				&nbsp;&nbsp;

				<!-- <button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text" tabindex="13">Cancel</span>
				</button> -->
		
				<a href="mobileadminCodeTypeHome.do" style="text-decoration: none;">
					<button type="button" id="refesh"
					onclick="window.location='mobileadminCodeTypeHome.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text" tabindex="10" >Back</span>
					</button> </a> &nbsp;&nbsp;
		

	</form:form>
	</div>

<!-- BUCKET -->
