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
<c:url value="/mobileadmin/mobileAdminJurisdiction.do" var="mobileJurisdictionModuleUrl">
    </c:url>
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
	<a href="<c:out value='${mobileJurisdictionModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showform" onclick="showform()"
	                    	 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Jurisdiction</span>
	                    	</button> 
	                	</a>
	                	
<!--  BUCKET -->
<body onload="hideform()">
 <div id="div2"  >
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>
		<form:form name="jurisdiction" modelAttribute="jurisdiction"
			method="POST" action="mobileAdminJurisdiction.do">
			<i><b><form:errors path="*" class="errorblock" element="div" /></b></i>
			<input type="hidden" name="clientId" id="clientId" value="${param.clientId }" />
			<input type="hidden" name="baseURL" id="baseURL" value="mobileAdminJurisdiction.do" />

			<form:hidden path="id" />

				 <div data-role="fieldcontain" >
                  <form:label path="country">Country</form:label>
                  <form:input path="country" cssClass="input_full" tabindex="1"/>
                  </div>
                   <div data-role="fieldcontain" >
                    <form:label   path="state">State/Province</form:label>
                    <form:input path="state" cssClass="input_full" tabindex="2"/>
                </div>
                
				 <div data-role="fieldcontain" >
                    <form:label path="county">County</form:label>
                   <form:input path="county" cssClass="input_full" tabindex="3"/>
                    </div>
                    <div data-role="fieldcontain" >
                   <form:label   path="city">City</form:label>
                   <form:input path="city" cssClass="input_full" tabindex="4"/>
                </div>
                
               <div data-role="fieldcontain" >
                 <form:label path="timezone">Timezone</form:label>
                   		<form:select path="timezone" cssClass="input_full" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${timezoneSet}" itemValue="id" itemLabel="globalTimezoneName" />
						</form:select>
                    </div>
                    <div data-role="fieldcontain" >
                    <form:label   path="activeFlag">Status</form:label>
						<form:radiobutton path="activeFlag" value="true" label="Active"
							tabindex="6" />
						<form:radiobutton path="activeFlag" value="false" label="Inactive"
							tabindex="7" />
				
                </div>
					<button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
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
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text"tabindex="10">Cancel</span>
					</button>
					<a href="mobileAdminJurisdiction.do" style="text-decoration:none;">
                    	<button type="button" id="newJurisdiction"
                    	onclick="window.location='mobileAdminJurisdiction.do';return false;"
                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
                        	<span class="ui-button-text">Back</span>
                    	</button>
                	</a>
			
		</form:form>
		</div>

<!-- BUCKET -->

    <!--  GRID PLACEHOLDER Ids -->
     <div id="grid">	
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
				<table id="jurisdictionList"></table>
				<div id="jurisdictionPager" class="scroll"></div>
			</div>
			<script type="text/javascript">
			var firmId = $("#firmId").val();
			var clientId = $("#clientId").val();
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";

			jQuery("#jurisdictionList").jqGrid({
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
		            "url":'<c:url value="/tax/jurisdictionsList.do"/>?firmId='+firmId,
		            "scrollPaging":true,
		            pager : jQuery('#pager'),
		            "rowNum":10,
		            "rowList" : [20,40,60],
		            "sortname":"country",
		            "height":200,
		            "width" :300,
		            "mtype" : "GET",
		            "datatype":"json",
		            caption : 'Jurisdictions List',
				 colNames:['ID','Country', 'State/Province', 'City', 'Global Timezone Name','GMT Deviation Hours', 'Status'],
				   	colModel:[
				   		{name:'id',index:'id', width:30, editoptions:{readonly:true, size:10}},
				   		{name:'country',index:'country', width:30, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'state',index:'state', width:30,formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileAdminJurisdiction.do', 
								idName:'id'}},
				   		{name:'city',index:'city', width:30, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'globalTimezoneName',index:'globalTimezoneName', width:30, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'gmtDeviationHours',index:'gmtDeviationHours', width:30, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'status',index:'status', width:30, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
				   		 	formatter:'select', stype: 'select', sorttype:
				   		 	function(cell) {return status[cell];},
				   		 edittype:'select', editoptions: { value: statusStr }, 
				   		searchoptions:{ sopt:['eq'] }},
				   	],
				    "pager":"#jurisdictionPager"
			 });
			  jQuery("#jurisdictionList").jqGrid('filterToolbar', {
		            stringResult : true,
		            searchOnEnter : false
		        });
		  
		    $('#jurisdictionPager').css("height", "50px");
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
 
 
 