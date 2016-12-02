<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->

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

<style type="text/css">
.jurisdiction fieldset p.error label {
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

form.jurisdiction {
	width: 30em;
}

form.jurisdiction label.error {
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
									|| /^[A-Z-]+$/i.test(value);
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
						var validator = $("#jurisdiction")
								.validate(
										{

											rules : {
												'country' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'state' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'county' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'city' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'timezone' : {
													required : true,
													min : 1
												}
											},
											messages : {
												'country' : {
													required : "Country is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid Country Name.",
													minlength : "Enter Country with at least {0} characters.",
													maxlength : "Enter Country with no more than {0} characters."
												},
												'State/Province' : {
													required : "State is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid State Name.",
													minlength : "Enter State with at least {0} characters.",
													maxlength : "Enter State with no more than {0} characters."
												},
												'county' : {
													required : "County is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid County Name.",
													minlength : "Enter County with at least {0} characters.",
													maxlength : "Enter County with no more than {0} characters."
												},
												'city' : {
													required : "City is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid City Name.",
													minlength : "Enter City with at least {0} characters.",
													maxlength : "Enter City with no more than {0} characters."
												},
												'timezone' : "Select Timezone"
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate"
										});
						$("#jurisdiction").submit();

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
<span class="legend b">Jurisdiction</span>
<div class="f13">
		<form:form name="jurisdiction" modelAttribute="jurisdiction"
			method="POST" action="adminJurisdiction.do">
			<i><b><form:errors path="*" class="errorblock" element="div" /></b></i>
			<input type="hidden" name="clientId" id="clientId" value="${param.clientId }" />
			<input type="hidden" name="baseURL" id="baseURL" value="adminJurisdiction.do" />

			<form:hidden path="id" />

				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="country">Country</form:label></div>
                    <div class="grid_3 right"><form:input path="country" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="state">State/Province</form:label></div>
                    <div class="grid_3 right"><form:input path="state" cssClass="input_full" tabindex="2"/></div>
                </div>
                
				<div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="county">County</form:label></div>
                    <div class="grid_3 right"><form:input path="county" cssClass="input_full" tabindex="3"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="city">City</form:label></div>
                    <div class="grid_3 right"><form:input path="city" cssClass="input_full" tabindex="4"/></div>
                </div>
                
                <div class="container_12 pt5">
                 	<div class="grid_2 right"><form:label path="timezone">Timezone</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="timezone" cssClass="input_full" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${timezoneSet}" itemValue="id" itemLabel="globalTimezoneName" />
						</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="activeFlag">Status</form:label></div>
                    <div class="grid_3">
						<form:radiobutton path="activeFlag" value="true" label="Active"
							tabindex="6" />
						<form:radiobutton path="activeFlag" value="false" label="Inactive"
							tabindex="7" />
					</div>
                </div>
			
			<div class="container_12" style="margin: 10px;"></div>
			
			<div class="container_12">
				<div class="grid_3">&nbsp;</div>
				<div class="grid_8">

					<a href="adminJurisdiction.do" style="text-decoration: none;">
						<button type="button" id="refesh"
						onclick="window.location='adminJurisdiction.do';return false;"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<span class="ui-button-text" tabindex="8">New Jurisdiction</span>
						</button> </a> &nbsp;&nbsp;

					<button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<c:if test="${jurisdiction.id == null}">
						
						<span class="ui-button-text" tabindex="9">Save</span>
						</c:if>
						<c:if test="${jurisdiction.id != null}">
    	                <span class="ui-button-text" tabindex="9">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;


					<button type="reset"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span class="ui-button-text"tabindex="10">Cancel</span>
					</button>
				</div>
			</div>
		</form:form>
</div>
	</div>
</div>
<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Jurisdiction List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
				<table id="toolbar"></table>
				<div id="ptoolbar" class="scroll"></div>
			</div>
			<script type="text/javascript">
		
		jQuery(document).ready(function(){
			var firmId = $("#firmId").val();
			var clientId = $("#clientId").val();
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";

			var mygrid = jQuery("#toolbar").jqGrid({
			   	url:'<c:url value="../tax/jurisdictionsList.do"/>?firmId='+firmId,
				 datatype: "json",
				  
					height : 300,
				 mtype: 'GET', 
				
				 colNames:['ID','Country', 'State/Province', 'City', 'Global Timezone Name','GMT Deviation Hours', 'Status'],
				   	colModel:[
				   		{name:'id',index:'id', width:20, editoptions:{readonly:true, size:10}},
				   		{name:'country',index:'country', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'state',index:'state', width:100,formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminJurisdiction.do', 
								idName:'id'}},
				   		{name:'city',index:'city', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'globalTimezoneName',index:'globalTimezoneName', width:130, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'gmtDeviationHours',index:'gmtDeviationHours', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'status',index:'status', width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
				   		 	formatter:'select', stype: 'select', sorttype:
				   		 	function(cell) {return status[cell];},
				   		 edittype:'select', editoptions: { value: statusStr }, 
				   		searchoptions:{ sopt:['eq'] }},
				   	],
				   	jsonReader : {
			            root: "rows",
			            page: "page",
			            total: "total",
			            records: "records",  
			            repeatitems: false,
			            cell: "cell",
			            id: "id",
			            userdata: "userdata"  
			      },
			      gridComplete: function(){
			  		var ids = jQuery("#toolbar").jqGrid('getDataIDs');
			  		for(var i=0;i < ids.length;i++){
			  			var cl = ids[i];
			  			var closeJs = "setJurisdictionAndClose("+ cl+ ");";
			  			be = "<input style='height:22px;width:100px;' type='button' value='Select' onclick="+closeJs+"  />"; 
			  			jQuery("#toolbar").jqGrid('setRowData',ids[i],{act:be});
			  		}	
			  	},
			      	rowNum:10,
				   	rowList:[10,20,30],
					loadonce:true,
				   	mtype: "GET",
					rownumbers: false,
					rownumWidth: 40,
					gridview: true,
				   	pager: '#ptoolbar',
				   	sortname: 'country',
				    viewrecords: true,
				    sortorder: "asc",
				    caption: 'Jurisdictions List',
				    editurl:'<c:url value="/appadmin/saveJurisdictions.do"/>'
				});

			jQuery("#toolbar").jqGrid('navGrid','#ptoolbar',{del:true,add:false,edit:false,search:false});
			jQuery("#toolbar").jqGrid('navButtonAdd',
					"#ptoolbar", {
						caption : "Apply Filter",
						title : "Toggle Search Toolbar",
						buttonicon : 'ui-icon-pin-s',
						onClickButton : function() {
							mygrid[0].toggleToolbar();
						}
					});
			jQuery("#toolbar").jqGrid('filterToolbar', {
				stringResult : true,
				searchOnEnter : false
			});
				
		});
		
		 // resize the grid if needed
				 $(window).bind('resize', function() {
					jQuery("#toolbar").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('resize');
				 
				 $(window).bind('load', function() {
						jQuery("#toolbar").setGridWidth($('#grid_wrapper').width()-5, true);
						}).trigger('load');		
		
		</script>

		</div>
		<!--  END BUCKET -->

	</div>
	<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 