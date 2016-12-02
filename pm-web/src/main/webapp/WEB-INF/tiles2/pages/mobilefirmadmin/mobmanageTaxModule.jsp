<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->

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
						$("#save").click(function() {
						var container = $('div.error_container');
						// validate the form when it is submitted
						var validator = $("#firmPracticeType")
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
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 100
												}
											},
											messages : {
												'taxApplicationPracticeType.name' : {
													required : "Name is required",
													alphabetsOnly : "No Special characters are allowed. Please enter a valid Name.",
													minlength : "Enter Name with at least {0} characters.",
													maxlength : "Enter Name with no more than {0} characters."
												},
												'taxApplicationPracticeType.description' : {
													required : "Description is required",
													alphabetsOnly : "No Special characters are allowed. Please enter a valid Description.",
													minlength : "Enter Description with at least {0} characters.",
													maxlength : "Enter Description with no more than {0} characters."
												}
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate"
										});
						$("#firmPracticeType").submit();
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


<c:url value="/mobilefirmadmin/manageTaxModuleMobile.do" var="mobileFirmtaxTypeUrl"/> 
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<!-- 
<span class="legend b">Tax</span> -->
<a href="<c:out value='${mobileFirmtaxTypeUrl}'/>" style="text-decoration:none;">
<button id="showTaxform" onclick="showTaxform()"
	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	<span class="ui-button-text">New TaxType</span>
</button>
</a>
<body onload="hideTaxTypeform()">
 <div id="divTaxType">

			<form:form modelAttribute="firmPracticeType" method="POST"
				action="manageTaxModuleMobile.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="manageTaxModuleMobile.do" />
				<input type="hidden" name="inValidClientId"
					value="${param.inValidClientId }" />
				<i><b><form:errors path="*" class="errorblock" element="div" />
				</b>
				</i>
				<form:hidden path="id" />
				
				<center> <b><strong>${inValidClientId}</strong> </b> </center> 
				
				<div data-role="fieldcontain" >
                    <form:label path="taxApplicationPracticeType.name">Name</form:label>
                    <form:input path="taxApplicationPracticeType.name" cssClass="input_full" tabindex="1"/></div>
                 <div data-role="fieldcontain" >
                    <form:label   path="taxApplicationPracticeType.description">Description</form:label>
                    <form:input path="taxApplicationPracticeType.description" cssClass="input_full" tabindex="2"/>
                </div>

				
				
				
				    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
				       
				       <button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<c:if test="${firmPracticeType.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
						</c:if>
						<c:if test="${firmPracticeType.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;
				        <button type="reset"
				                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				                data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
				            <span class="ui-button-text">Cancel</span>
				        </button>
				        </security:authorize>
				        
				        <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${firmPracticeType.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
				<button id="showTaxTypeGrid" onclick="window.location='manageTaxModuleMobile.do';return false;"
	                 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                 role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                 <span class="ui-button-text">Back</span>
	                 </button>

			</form:form>
</div>
</body>
<br/><br/>

<!-- BUCKET -->

<!-- <span class="legend b">Tax List</span> -->
    <!--  GRID PLACEHOLDER Ids -->
    <div id="gridTaxType" style="width:300px;">	  
    		<div id="grid_wrapper" class="ml10 mr10 mt20"  style="width:300px;">
			<table id="taxtypelist"  style="width:300px;"></table>
			<div id="taxtypepager" class="scroll"></div>
		</div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
			jQuery(document).ready(function() {
				firmPracticeID = $("#firmPracticeID").val();
				taxId = $("#taxId").val();

				var mygrid = jQuery("#taxtypelist").jqGrid({
					url : '<c:url value="/firmadmin/manageTaxList.do"/>?firmPracticeID=' + firmPracticeID,
					datatype : 'json',
					"height":200,
					mtype : 'GET',
					colNames : [ 'Name', 'Description', 'Status' ],
					colModel : [ {
						name : 'name',
						index : 'name',
						formatter : 'showlink',
						formatoptions : {
							baseLinkUrl : 'manageTaxModuleMobile.do',
							idName : 'id'
						}
					}, {
						name : 'description',
						index : 'description'
					}, {
						name : 'status',
						index : 'status'
							,width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
				   		 	formatter:'select', stype: 'select', sorttype:
					   		 	function(cell) {return status[cell];},
					   		 edittype:'select', editoptions: { value: statusStr }, 
					   		searchoptions:{ sopt:['eq'] }},
					 ],
					jsonReader : {
						root : "rows",
						page : "page",
						total : "total",
						records : "records",
						repeatitems : false,
						cell : "cell",
						id : "taxId",
						userdata : "userdata"
					},
					pager : jQuery('#taxtypepager'),
					rowNum : 10,
					rowList : [ 10, 25, 50 ],
				//	loadonce : true,
					sortname : 'name',
					sortorder : 'asc',
					viewrecords : true,
					autowidth: true,
					caption : 'Tax List',
					editurl : '<c:url value="/firmadmin/saveTax.do"/>'
				});
				
				jQuery("#taxtypelist").jqGrid('navButtonAdd', "#taxtypepager", {
					caption : "Apply Filter",
					title : "Toggle Search Toolbar",
					buttonicon : 'ui-icon-pin-s',
					onClickButton : function() {
						mygrid[0].toggleToolbar()
					}
				});
				jQuery("#taxtypelist").jqGrid('filterToolbar', {
					stringResult : true,
					searchOnEnter : false
				});
				
				<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
                jQuery("#taxtypelist").jqGrid('navGrid', '#taxtypepager', {
                 del : true,
                 add : false,
                 edit : false,
                 search : false
                });
                
                </security:authorize>

			});
			  $('#taxtypepager').css("width", "200px");
			  $('#taxtypelist').css("width", "200px");
			// resize the grid if needed
			 $(window).bind('resize', function() {
				jQuery("#taxtypelist").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('resize');
			 
			 $(window).bind('load', function() {
					jQuery("#taxtypelist").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('load');	 
		</script>

 <script type="text/javascript">
function hideTaxTypeform(){	
	$("#divTaxType").hide();	
	$("#gridTaxType").show();
}

function showTaxform(){
	$("#divTaxType").show();
	$("#gridTaxType").hide();	
}

</script> 

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
