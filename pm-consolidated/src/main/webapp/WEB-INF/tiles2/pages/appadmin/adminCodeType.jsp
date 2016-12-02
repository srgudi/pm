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
	
	</script>
 <script type="text/javascript">
$().ready(function() {
/* 	var editId = $("#id").val();
    var editStatus=new Boolean();
	console.log(editStatus);
	  if (editId != "")
		{
		  editStatus = true;
		} */
	 $("#codeTypeSave").click(function() {
		 //alert("save");
		 var container = $('div.error_container');
						// validate the form when it is submitted
						var validator = $("#codeType")
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
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate",
											submitHandler: function(form) {
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#codeType').serialize(),
				        url: 'adminCodeType.do',
				        success: function(codeTypeId) {
			              	if(codeTypeId != -1){
		            		$.jGrowl("Record saved successfully");
		        			$('#getCodeType').dataTable().fnReloadAjax('codeTypeList.do');
		        			if($("#id").val()!=""){
		        				$('#codeTypehome').show();
		        				$('#codeTypefoo').hide();	
		        				$('#codeTypeTabs a:first').tab('show');
	            				 
		        			}
		        			else
		        				{
		        			document.getElementById("codeType").reset();
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
											
	 });
	 
	 $("#newAdminCodetype").click(function(){
			$('#codeTypefoo').load('adminCodeType.do');
	 }); 
	 
	 
	      /*   $("#backToList").click(function(){
			$('#list').load('codeTypeList.do');
			$('#codeTypeTab a:last').tab('show');
			});  */
	 });


function codeTypeList(){
	$('#codeTypeTabs a:first').tab('show');
	$('#codeTypehome').show();
	$('#codeTypefoo').hide();
}
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
<!-- <span class="legend b">Code Type</span> -->
<div class="f13">
	<form:form modelAttribute="codeType">
	<!-- 	<input type="hidden" name="baseURL" id="baseURL" value="adminCodeType.do" /> -->

		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>

		<form:hidden path="id" />
		
				<div class="container_12 mt20">
				</br>
				</br>
				<div class="row">
				<div class="span3">
                    <form:label path="name"><spring:message code="label.name"/></form:label>
                    <form:input path="name" cssClass="formInput" tabindex="1"/>
                </div>
                <div class="span3">    
                    <form:label   path="description"><spring:message code="label.description"/></form:label>
                    <form:input path="description" cssClass="formInput" tabindex="2"/>
                </div>
                <form:label path="parentCodeType"><spring:message code="label.parentCodeType"/></form:label>
                   		<form:select path="parentCodeType" cssClass="formSelect" tabindex="3">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeTypeSet}" itemValue="id" itemLabel="name" />
				</form:select> 
                </div>
               
					<div class="row">
                    <div class="span3" >
                    <form:label   path="activeFlag"><spring:message code="label.status"/></form:label>
					<label style="display:inline;"><form:radiobutton path="activeFlag" style="width: 30px;" value="true" tabindex="4" />Active</label>
					<label style="display:inline;"><form:radiobutton path="activeFlag" value="false"  tabindex="5" style="width: 30px;"/>Inactive</label>
					</div>

                <div class="span3">
                    <form:label   path="applicationLevelIndicator"><spring:message code="label.applicationLevelIndicator"/></form:label>
						<label style="display:inline;"><form:radiobutton path="applicationLevelIndicator" style="width: 30px;" value="true" tabindex="6" />Yes</label>
						<label style="display:inline;"><form:radiobutton path="applicationLevelIndicator"  style="width: 30px;" value="false"  tabindex="7" />No</label>
				</div>   
				</div>
		<div class="container_12" style="margin:10px;"></div>
		</br>
		<div class="row">
		<div class="span">
					<%-- <button type="button" id="newAdminCodetype" class="btn btn-primary">
						<span class="ui-button-text" tabindex="10" ><spring:message code="label.newCodeType"/></span>
					</button> &nbsp;&nbsp;
 --%>
				<button  id="codeTypeSave"
					class="btn btn-success">
					<c:if test="${codeType.id == null}">
					<span class="ui-button-text" tabindex="8"><spring:message code="label.save"/></span>
					</c:if>
					<c:if test="${codeType.id != null}">
    	                <span class="ui-button-text" tabindex="8"><spring:message code="label.update"/></span>
    	                </c:if>
				</button>
				&nbsp;&nbsp;


				<%-- <button type="reset"
					class="btn btn-success">
					<span class="ui-button-text" tabindex="13"><spring:message code="label.cancel"/></span>
				</button>  --%>
				
					&nbsp;&nbsp;
        	          
	                    	<button type="button" id="backToList" onclick="codeTypeList()"
	                        	    class="btn btn-success">
	                        	<span class="ui-button-text">Back To List</span>
	                    	</button>
			</div>
			</div>
		</div>

	</form:form>
</div>
	</div>
</div>

 
