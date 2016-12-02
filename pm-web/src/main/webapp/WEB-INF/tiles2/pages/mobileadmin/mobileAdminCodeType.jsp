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
<c:url value="/mobileadmin/mobileAdminCodeType.do" var="mobileAdminCodeTypeModuleUrl">
    </c:url>
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
<a href="<c:out value='${mobileAdminCodeTypeModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showform" onclick="showform()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Code Type</span>
	                    	</button> 
	                	</a>
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

				<button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text" tabindex="13">Cancel</span>
				</button>
		
				<a href="mobileAdminCodeType.do" style="text-decoration: none;">
					<button type="button" id="refesh"
					onclick="window.location='mobileAdminCodeType.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text" tabindex="10" >Back</span>
					</button> </a> &nbsp;&nbsp;
		

	</form:form>
	</div>

<!-- BUCKET -->

    <!--  GRID PLACEHOLDER Ids -->
     <div id="grid">	
    		<div id="grid_wrapper">
			<table id="adminCodeType"></table>
			<div id="codeTypePager" class="scroll"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
								firmId = $("#firmId").val();
								jQuery("#adminCodeType")
										.jqGrid(
												{
													 "hoverrows":false,
											         "viewrecords":true,
											         "jsonReader": {root : "rows",
											         page : "page",
											         total : "total",
											         records : "records",
											         repeatitems : false,
											         cell : "cell",
											         id : "id",
											         userdata : "userdata"},
											         "gridview":true,
											         "loadonce":true,
											         "url" : 'codeTypeList.do',
											         pager : jQuery('#pager'),
											         "rowNum":10,
											         "rowList" : [20,40,60],
											         "sortname":"globalCodeTypeName",
											         "height":200,
											         "width" :300,
											         "mtype" : "GET",
											         "datatype":"json",
											         caption : 'Code Type List',
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
																width: 30,
																formatter : 'showlink',
																formatoptions : {
																	baseLinkUrl : '<c:url value="/mobileadmin/mobileAdminCodeType.do"/>',
																	idName : 'id'
																}
															},
															{
																name : 'description',
																width: 30,
																index : 'description'
															},
															{
																name : 'parentCodeTypeName',
																width: 30,
																index : 'parentCodeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																width: 30,
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'status',
																index : 'status',width:30, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
													   		 	formatter:'select', stype: 'select', sorttype:
														   		 	function(cell) {return status[cell];},
														   		 edittype:'select', editoptions: { value: statusStr }, 
														   		searchoptions:{ sopt:['eq'] }},
															 ],
															    "pager":"#codeTypePager"
												});
								 jQuery("#adminCodeType").jqGrid('filterToolbar', {
							         stringResult : true,
							         searchOnEnter : false
							     });
								 $('#codeTypePager').css("height", "50px");
		</script>
		</div>


<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
 <script type="text/javascript">
function hideform(){
	$("#div2").hide();	
	$("#grid").show();
}

function showform(){
	$("#grid").hide();	
	$("#div2").show();
}
</script>
 
 
