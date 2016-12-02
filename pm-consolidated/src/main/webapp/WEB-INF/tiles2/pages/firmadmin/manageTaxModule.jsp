<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<!-- MAIN CONTENT SECTION -->

<style type="text/css">
.firmPracticeType fieldset p.error label {
	color: red;
}

div.error_container_firmTax {
	background-color: #eee;
	border: 2px solid red;
	margin: 5px;
	padding: 5px;
}

div.error_container_firmTax ol li {
	list-style-type: disc;
	margin-left: 20px;
}

div.error_container_firmTax {
	display: none
}

.error_container_firmTax label.error {
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
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$.validator.addMethod("alphabetsOnly", function(value, element){
			return this.optional(element)|| /^\s*[a-zA-Z.\s]+\s*$/i.test(value); 
		},"Please enter a valid Name. No numbers allowed");
		
		$.validator.addMethod("alphaOnly", function(value, element){
			return this.optional(element)|| /^\s*[a-zA-Z.\s]+\s*$/i.test(value); 
		},"Please enter a valid Description. No  numbers allowed");
		
		
	});
	
	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});
</script>

<script type = "text/javascript">
		$().ready(function(){
			/* var eId= $("#id").val(); */
			var eId = $("#entityKey").val();
			//alert("hi"+eId); 
			var editStatus=new Boolean();
			//alert("hi"+editStatus);
			console.log(editStatus);
			  if (eId != "")
				{
				  editStatus = true;
				}
			 $("#tSave").click(function(){
				// alert("hi");
				 var container = $('div.error_container_firmTax');
				 var validator = $("#firmPracticeType").validate({
					 rules:{
						 'taxApplicationPracticeType.name' : {required: true, alphabetsOnly: true, minlength: 0, maxlength: 50},
						 'taxApplicationPracticeType.description' : {required: true, alphaOnly: true, minlength: 0, maxlength: 100}
					 }, 
					 message: {
						 'taxApplicationPracticeType.name' : {
						required: "Name is required",
						alphabetsOnly: "No special characters and numbers allowed",
						minlength: "Enter Tax Name with at least {0} characters.",
	            		maxlength: "Enter Tax Name with no more than {0} characters."},
	            		 'taxApplicationPracticeType.description' :{
	            			 required: "Description is required",
	            			 alphaOnly: "No special characters and numbers allowed",
	 						minlength: "Enter Tax Description with at least {0} characters.",
	 	            		maxlength: "Enter Tax Description with no more than {0} characters."}
					 }, 
					 errorContainer : container,
					 errorLabelContainer : $("ol", container),
					 wrapper: 'li',
						meta: "validate",
						 submitHandler: function(form) {
						$.ajax({
				            dataType: 'json',
				            type: 'POST',
			                data: $('#firmPracticeType').serialize(),
					        url: 'manageTaxModule.do',
					        success: function(data){
					        	var updateEntityKey = data.entityKey;
					        	if(updateEntityKey != "-1"){
				            		$.jGrowl("Record saved successfully");
				            		var tabl = $("#getTax").dataTable();
				            		tabl.fnDraw();
				            		if(editStatus == true){
				            			
				            			 $('#taxTypehome').show();
				            			 $('#taxTypeFoo').hide();
				            			 $('#taxTypeTabs a:last').tab('show');
				            				
			            			       }
				            		/* $("#entityKey").val(updateEntityKey); */
				            		else
				            			{
				            		document.getElementById("firmPracticeType").reset();
				            			}
			            		}else{
			            		 $.jGrowl("As Error has happened while process. ");	
			            	 	} 
			            	}
		
					});
						return false;
						 }
			}); 
			 }); 
			
			 $("#managTax").live("click",function(){
				// alert("new");
					$('#taxTypeFoo').load('manageTaxModule.do');
					
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

<div class="well">
<!--  BUCKET -->

<div class="error_container_firmTax">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<!-- <span class="legend b">Tax</span> -->
<div class="f13">
			<form:form modelAttribute="firmPracticeType">
				<input type="hidden" name="baseURL" id="baseURL"
					value="manageTaxModule.do" />
				<input type="hidden" name="inValidClientId"
					value="${param.inValidClientId }" />
				<i><b><form:errors path="*" class="errorblock" element="div" />
				</b>
				</i>
				<form:hidden path="entityKey" />
				
				<center> <b><strong>${inValidClientId}</strong> </b> </center> 
				

<div class="container_12 mt20">
</br>
</br>
<div class="row">	
<div class="span4">
<form:label path="taxApplicationPracticeType.name"><spring:message code="label.name"/></form:label>
<form:input path="taxApplicationPracticeType.name" cssClass="formInput" tabindex="1"/>
</div>
<div class="span4">
<form:label   path="taxApplicationPracticeType.description"><spring:message code="label.description"/></form:label>
<form:input path="taxApplicationPracticeType.description" cssClass="formInput" tabindex="2"/>
</div>
<div class="span4">
</div>
</div>
</div>
				<div class="container_12" style="margin:10px;"></div>
				
				<div class="container_12">
				    <div class="grid_3">&nbsp;</div>
				    <div class="grid_8">
				    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
				       
				       <button  id="tSave"
						class="btn btn-success"
						role="button" aria-disabled="false">
						<c:if test="${firmPracticeType.id == null}">
						<span class="ui-button-text" tabindex="13"><spring:message code="label.save"/></span>
						</c:if>
						<c:if test="${firmPracticeType.id != null}">
    	                <span class="ui-button-text" tabindex="12"><spring:message code="label.update"/></span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;
					<a href="#taxTypehome"  onClick=TaxList(); data-toggle="tab">
				        <button type="reset"
				               class="btn btn-success"
				                role="button" aria-disabled="false">
				            <span class="ui-button-text"><spring:message code="label.backToList"/></span>
				        </button>
				        </a>
				        </security:authorize>
				        
				        <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${firmPracticeType.id != null}">
		                	<button id="tSave"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <a href="#taxTypehome"  onClick=TaxList(); data-toggle="tab">
		                    <button type="button"
		                        	class="btn btn-success"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
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
function TaxList(){
	$('#taxTypeTabs a:first').tab("show");
	 $('#taxTypehome').show();
	 $('#taxTypeFoo').hide();
	}
</script>