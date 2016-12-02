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
											meta : "validate"
										});
						$("#codeType").submit();
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
<span class="legend b">Code Type</span>
<div class="f13">
	<form:form modelAttribute="codeType" method="POST"
		action="adminCodeType.do">
		<input type="hidden" name="baseURL" id="baseURL"
			value="adminCodeType.do" />

		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>

		<form:hidden path="id" />
		
				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="name">Name</form:label></div>
                    <div class="grid_3 right"><form:input path="name" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="description">Description</form:label></div>
                    <div class="grid_3 right"><form:input path="description" cssClass="input_full" tabindex="2"/></div>
                </div>
                
                <div class="container_12 pt5">
                 	<div class="grid_2 right"><form:label path="parentCodeType">Parent Code Type</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="parentCodeType" cssClass="input_full" tabindex="3">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="activeFlag">Status</form:label></div>
                    <div class="grid_3">
						<form:radiobutton path="activeFlag" value="true" label="Active" tabindex="4" />
						&nbsp;
						<form:radiobutton path="activeFlag" value="false" label="Inactive" tabindex="5" />
					</div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="applicationLevelIndicator">Application Level Indicator</form:label></div>
                    <div class="grid_3 ">
						<form:radiobutton path="applicationLevelIndicator" value="true" label="Yes" tabindex="6" />
						<form:radiobutton path="applicationLevelIndicator" value="false" label="No" tabindex="7" />
					</div>
                </div>
		
		<div class="container_12">
			<div class="grid_3">&nbsp;</div>
			<div class="grid_8">

				<a href="adminCodeType.do" style="text-decoration: none;">
					<button type="button" id="refesh"
					onclick="window.location='adminCodeType.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span class="ui-button-text" tabindex="10" >New CodeType</span>
					</button> </a> &nbsp;&nbsp;

				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<c:if test="${codeType.id == null}">
					<span class="ui-button-text" tabindex="8">Save</span>
					</c:if>
					<c:if test="${codeType.id != null}">
    	                <span class="ui-button-text" tabindex="8">Update</span>
    	                </c:if>
				</button>
				&nbsp;&nbsp;


				<button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text" tabindex="13">Cancel</span>
				</button>
			</div>
		</div>

	</form:form>
</div>
	</div>
</div>
<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Code Type List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
			<table id="list"></table>
			<div id="pager" class="scroll"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
			jQuery(document)
					.ready(
							function() {
								firmId = $("#firmId").val();
								var mygrid = jQuery("#list")
										.jqGrid(
												{
													url : 'codeTypeList.do',
													datatype : 'json',
													
													height : 300,

													mtype : 'GET',
													colNames : [
															'Name',
															'Description',
															'Parent CodeType Name',
															'Application Level Indicator',
															'Status' ],
													colModel : [
															{
																name : 'name',
																index : 'name',
																
																formatter : 'showlink',
																formatoptions : {
																	baseLinkUrl : '<c:url value="/appadmin/adminCodeType.do"/>',
																	idName : 'id'
																}
															},
															{
																name : 'description',
																index : 'description'
															},
															{
																name : 'parentCodeTypeName',
																index : 'parentCodeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'status',
																index : 'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
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
														id : "id",
														userdata : "userdata"
													},
													pager : jQuery('#pager'),
													rowNum : 10,
													loadonce : true,
													rowList : [ 10, 25, 50 ],
													sortname : 'globalCodeTypeName',
													sortorder : 'asc',
													viewrecords : true,
													autowidth : false,
													caption : 'CodeType List',
													rownumbers : false,
													rownumWidth : 40,
													gridview : true,
													caption : 'Code Type List',
													editurl : '<c:url value="/appadmin/saveCodeType.do"/>'
												});

								jQuery("#list").jqGrid('navGrid', '#pager', {
									del : true,
									add : false,
									edit : false,
									search : false
								});
								jQuery("#list").jqGrid('navButtonAdd',
										"#pager", {
											caption : "Apply Filter",
											title : "Toggle Search Toolbar",
											buttonicon : 'ui-icon-pin-s',
											onClickButton : function() {
												mygrid[0].toggleToolbar();
											}
										});
								jQuery("#list").jqGrid('filterToolbar', {
									stringResult : true,
									searchOnEnter : false
								});
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
 
