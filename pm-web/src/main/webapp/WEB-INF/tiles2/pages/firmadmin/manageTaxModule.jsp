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

<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Tax</span>
<div class="f13">
			<form:form modelAttribute="firmPracticeType" method="POST"
				action="manageTaxModule.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="manageTaxModule.do" />
				<input type="hidden" name="inValidClientId"
					value="${param.inValidClientId }" />
				<i><b><form:errors path="*" class="errorblock" element="div" />
				</b>
				</i>
				<form:hidden path="id" />
				
				<center> <b><strong>${inValidClientId}</strong> </b> </center> 
				
				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="taxApplicationPracticeType.name">Name</form:label></div>
                    <div class="grid_3 right"><form:input path="taxApplicationPracticeType.name" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="taxApplicationPracticeType.description">Description</form:label></div>
                    <div class="grid_3 right"><form:input path="taxApplicationPracticeType.description" cssClass="input_full" tabindex="2"/></div>
                </div>

				<div class="container_12" style="margin:10px;"></div>
				
				<div class="container_12">
				    <div class="grid_3">&nbsp;</div>
				    <div class="grid_8">
				    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
				        <a href="manageTaxModule.do"
				           style="text-decoration: none;">
				            <button type="button" id="refesh"
				            onclick="window.location='manageTaxModule.do';return false;"
				                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
				                    role="button" aria-disabled="false">
				                <span class="ui-button-text">New Tax</span>
				            </button>
				        </a> &nbsp;&nbsp;
				   
				       <button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
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
				                role="button" aria-disabled="false">
				            <span class="ui-button-text">Cancel</span>
				        </button>
				        </security:authorize>
				        
				        <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${firmPracticeType.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
				    </div>
				</div>

			</form:form>
	</div>
	</div>
</div>
<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Tax List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
			<table id="list" ></table>
			<div id="pager" class="scroll"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
			jQuery(document).ready(function() {
				firmPracticeID = $("#firmPracticeID").val();
				taxId = $("#taxId").val();

				var mygrid = jQuery("#list").jqGrid({
					url : 'manageTaxList.do?firmPracticeID=' + firmPracticeID,
					datatype : 'json',
					height : 300,
					mtype : 'GET',
					colNames : [ 'Name', 'Description', 'Status' ],
					colModel : [ {
						name : 'name',
						index : 'name',
						formatter : 'showlink',
						formatoptions : {
							baseLinkUrl : 'manageTaxModule.do',
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
					pager : jQuery('#pager'),
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
				
				jQuery("#list").jqGrid('navButtonAdd', "#pager", {
					caption : "Apply Filter",
					title : "Toggle Search Toolbar",
					buttonicon : 'ui-icon-pin-s',
					onClickButton : function() {
						mygrid[0].toggleToolbar()
					}
				});
				jQuery("#list").jqGrid('filterToolbar', {
					stringResult : true,
					searchOnEnter : false
				});
				
				<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
                jQuery("#list").jqGrid('navGrid', '#pager', {
                 del : true,
                 add : false,
                 edit : false,
                 search : false
                });
                </security:authorize>

			});
			
			// resize the grid if needed
			 $(window).bind('resize', function() {
				jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('resize');
			 
			 $(window).bind('load', function() {
					jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('load');	
		</script>

	</div>

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
