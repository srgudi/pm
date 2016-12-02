<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<!-- <script type="text/javascript">
    $(document).ready(function() {
    $("#save").click(function() {		
		$("#timezone").submit();
	});
        
    });
 
</script> -->
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
.timezone fieldset p.error label {
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

form.timezone {
	width: 30em;
}

form.timezone label.error {
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
	$(document).ready(function() {

		$.validator.addMethod("alphabetsOnly", function(value, element) {  
		    return this.optional(element) || /^\s*[a-zA-Z.()&\s]+\s*$/i.test(value);  
		},"No special characters allowed. Please enter a valid Name.");

		jQuery.validator.addMethod("gmtHoursValidation", function(value, element) {
			return this.optional(element) || (value > -25 && value < +25)
					&& (/^-?[0-9]{0,2}(\.[0-9]{1,2})?$|^-?(100)(\.[0]{1,2})?$/i.test(value));  
		}, "Please enter a valid GMT Deviation Hours between -24.00 to 24.00 hours");

	});
		// only for demo purposes
		$.validator.setDefaults({
			submitHandler: function(form) {
			   	form.submit();
			}
		});

		$().ready(function() {
			$("#save").click(function() {
	
			var container = $('div.error_container');
			// validate the form when it is submitted
			var validator = $("#timezone").validate({
		
				rules: { 
				'globalTimezoneName': {required: true,alphabetsOnly:true,minlength: 0,maxlength: 50},
				'gmtDeviationHours': {required: true,gmtHoursValidation: true},
				'dstBeginMonth': {required: true,range: [0, 12],digits: true},
				'dstBeginDay': {required: true,range: [0, 31],digits: true},
				'dstBeginDayOfWeek': {required: true,range: [0, 4],digits: true},
				'dstBeginHour': {required: true,range: [0, 24],digits: true},
				'dstEndMonth': {required: true,range: [0, 12],digits: true},
				'dstEndDay': {required: true,range: [0, 31],digits: true},
				'dstEndDayOfWeek': {required: true,range: [0, 4],digits: true},
				'dstEndHour': {required: true,range: [0, 24],digits: true},
				'dstStdCd': {alphabetsOnly:true,required: true,minlength: 0,maxlength: 5},
				'dstSavingsCd': {alphabetsOnly:true,required: true,minlength: 0,maxlength: 5}
        		}, 
        	messages: { 
        		'globalTimezoneName': {
            		required: "Global Timezone Name is required",
            		alphabetsOnly:"No special characters allowed. Please enter a valid TimeZone Name.",
            		minlength: "Enter Global Timezone Name with at least {0} characters.",
            		maxlength: "Enter Global Timezone Name with no more than {0} characters."},
        		'gmtDeviationHours': {
            		required: "GMT Deviation Hours is required"},
				'dstBeginMonth': {
            		required: "DST Begin Month is required",
            		digits: "Enter DST Begin Month in only digits.",
            		range: "Please enter DST Begin Month between range {0} and {1}."},
				'dstBeginDay': {
            		required: "DST Begin Day is required",
            		digits: "Enter DST Begin Day only digits.",
            		range: "Please enter DST Begin Day value between range {0} and {1}."},
				'dstBeginDayOfWeek': {
            		required: "DST Begin Day Of Week is required",
            		digits: "Enter DST Begin Day Of Week only digits.",
            		range: "Please enter DST Begin Day Of Week value between range {0} and {1}."},
				'dstBeginHour': {
            		required: "DST Begin Hour is required",
            		digits: "Enter DST Begin Hour only digits.",
            		range: "Please enter DST Begin Hour value between range {0} and {1}."},
				'dstEndMonth': {
            		required: "DST End Month is required",
            		digits: "Enter DST End Month only digits.",
            		range: "Please enter DST End Month value between range {0} and {1}."},
				'dstEndDay': {
            		required: "DST End Day is required",
            		digits: "Enter DST End Day only digits.",
            		range: "Please enter DST End Day value between range {0} and {1}."},
				'dstEndDayOfWeek': {
            		required: "DST End Day Of Week is required",
            		digits: "Enter DST End Day Of Week only digits.",
            		range: "Please enter DST End Day Of Week value between range {0} and {1}."},
				'dstEndHour': {
            		required: "DST End Hour is required",
            		digits: "Enter DST End Hour only digits.",
            		range: "Please enter DST End Hour value between range {0} and {1}."},
				'dstStdCd': {
            		required: "DST Std Cd is required",
            		alphabetsOnly:"No special characters allowed. Please enter a valid DST STD code.",
            		minlength: "Enter DST Std Cd with at least {0} characters.",
            		maxlength: "Enter DST Std Cd with no more than {0} characters."},
				'dstSavingsCd': {
                		required: "DST Savings Cd is required",
                		alphabetsOnly:"No special characters allowed. Please enter a valid DST Savings code.",
                		minlength: "Enter DST Savings Cd with at least {0} characters.",
                		maxlength: "Enter DST Savings Cd with no more than {0} characters."}
        		}, 
			errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate"
				});
			$("#timezone").submit();
			});
	
			$(".cancel").click(function() {
				validator.resetForm();
			});
		});
	</script>

<div>
	<div class="error_container">
		<h7> <b>Please correct the following errors</b></h7>
		<ol>
		</ol>
	</div>
	<div>

		<form:form modelAttribute="timezone" method="POST"
			action="adminTimezone.do">
			<input type="hidden" name="clientId" id="clientId"
				'value="${param.clientId }" />
			<input type="hidden" name="baseURL" id="baseURL"
				value="adminTimezone.do" />
			<input type="hidden" id="listOfTimezone" name="listOfTimezone"
				value="${listOfTimezone}" />
			<input type="hidden" id="listOfTimezoneStr" name="listOfTimezoneStr"
				value="${listOfTimezoneStr}" />

			<i><b><form:errors path="*" class="errorblock" element="div" />
			</b> </i>

			<%-- <c:if test="${not empty statusMessageKey}">
				<span class="message"><fmt:message key="${statusMessageKey}" />
				</span>
			</c:if>
 --%>
			<form:hidden path="id" />

			<%-- <form:hidden path="createUserId" value="system" /> --%>
			<!-- BEGIN ROW 1 -->
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="globalTimezoneName">Global Timezone Name</form:label>
						<form:input cssClass="input_full" path="globalTimezoneName"
							class="input" tabindex="1" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="gmtDeviationHours">GMT Deviation Hours</form:label>
						<form:input cssClass="input_full" path="gmtDeviationHours"
							class="input" tabindex="2" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstBeginHour">DST Begin Hour</form:label>
						<form:input cssClass="input_full" path="dstBeginHour"
							class="input" tabindex="3" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstBeginDay">DST Begin Day</form:label>
						<form:input cssClass="input_full" path="dstBeginDay" class="input"
							tabindex="4" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstBeginDayOfWeek">DST Begin Day Of Week</form:label>
						<form:input cssClass="input_full" path="dstBeginDayOfWeek"
							class="input" tabindex="5" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstBeginMonth">DST Begin Month</form:label>
						<form:input cssClass="input_full" path="dstBeginMonth"
							class="input" tabindex="6" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstEndHour">DST End Hour</form:label>
						<form:input cssClass="input_full" path="dstEndHour" class="input"
							tabindex="7" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstEndDay">DST End Day</form:label>
						<form:input cssClass="input_full" path="dstEndDay" class="input"
							tabindex="8" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstEndDayOfWeek">DST End Day Of Week</form:label>
						<form:input cssClass="input_full" path="dstEndDayOfWeek"
							class="input" tabindex="9" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstEndMonth">DST End Month</form:label>
						<form:input cssClass="input_full" path="dstEndMonth" class="input"
							tabindex="10" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_1">
					<div class="row"></div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstStdCd">DST STD Code</form:label>
						<form:input cssClass="input_full" path="dstStdCd" class="input"
							tabindex="11" />
					</div>
				</div>
				<div class="grid_5">
					<div class="row">
						<form:label path="dstSavingsCd">DST Savings Code</form:label>
						<form:input cssClass="input_full" path="dstSavingsCd"
							class="input" tabindex="12" />
					</div>
				</div>
				<div class="grid_1">
					<div class="row"></div>
				</div>
			</div>
			<div class="container_12" style="margin: 10px;"></div>

			<div class="container_12">
				<div class="grid_3">&nbsp;</div>
				<div class="grid_8">
					<a href="adminTimezone.do" style="text-decoration: none;">
						<button type="button" id="newClient"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<span class="ui-button-text">New Time Zone</span>
						</button> </a>&nbsp;&nbsp;

					<button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<c:if test="${timezone.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
						</c:if>
						<c:if test="${timezone.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;
					<button type="reset"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span class="ui-button-text">Cancel</span>
					</button>
				</div>
			</div>


		</form:form>
	</div>
	<div class="container_12" style="margin: 10px;"></div>

	<!-- 	BUCKET -->
	<div>
		<!-- 		 GRID PLACEHOLDER Ids -->
		<div id="grid_wrapper">
			<table id="users"></table>
			<div id="usersPage" class="scroll"></div>
			<div class="container_12" style="margin: 15px;"></div>
		</div>
		<script type="text/javascript">

jQuery(document).ready(function(){
	var firmId = $("#firmId").val();
	var clientId = $("#clientId").val();
	var status = ["All", "Active", "Inactive"];
	var statusStr = ":All;Active:Active;Inactive:Inactive";
	var listOfTimezone = $("#listOfTimezone").val();
	var listOfTimezoneStr = $("#listOfTimezoneStr").val();

	var mygrid = jQuery("#users").jqGrid({
	 /*   	url:'timeZoneList.do',  */
		 url:'<c:url value="timeZoneList.do"/>?firmId='+firmId, 
		 datatype: 'json',
			height : 300,
		 mtype: 'GET', 
		colNames:['ID','Global Timezone Name', 'GMT Deviation Hours', 'Status'],
	   	colModel:[
	   		{name:'id',index:'id',width:15, editoptions:{readonly:true, size:10}},
	   		{name:'globalTimezoneName',index:'globalTimezoneName',  editrules:{required:true}, editable: true,editoptions:{size:25},
		   		formatter:'select', stype: 'select', sorttype:function(cell) {return listOfTimezone[cell];},
		   	     edittype:'select', editoptions: { value: listOfTimezoneStr },
			   		searchoptions:{ sopt:['eq'] }},
	   		{name:'gmtDeviationHours',index:'gmtDeviationHours', editrules:{required:true}, editable: true,editoptions:{size:25},
		   		formatter: 'showlink',formatoptions: {baseLinkUrl: 'adminTimezone.do',idName:'id', 
		   		addParam:''}},
	   		 {name:'status',index:'status',width:50,editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{size:25},
		   		formatter:'select', stype: 'select', sorttype:function(cell) {return status[cell];},
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
		var ids = jQuery("#users").jqGrid('getDataIDs');
		for(var i=0;i < ids.length;i++){
			var cl = ids[i];
			var closeJs = "setTimezoneAndClose("+ cl+ ");";
			be = "<input style='height:22px;width:100px;' type='button' value='Select' onclick="+closeJs+"  />"; 
			jQuery("#users").jqGrid('setRowData',ids[i],{act:be});
		}	
	},
	pager: jQuery('#pager'),
	    rowNum:10,
	    loadonce:true,
	    rowList:[10,25,50],
	    sortname: 'globalTimezoneName',
	    sortorder: 'asc',
        rownumWidth: 40,
 		rownumbers: false, 
     	pager: '#usersPage',
        gridview: true,	    
	    viewrecords: true,
	    autowidth: false,
	    caption: 'Timezone List',
       /*  editurl:'<c:url value="/appadmin/saveTimezone.do"/>' */
        	  editurl:'<c:url value="/appadmin/saveJurisdictions.do"/>'
	  });	

	  jQuery("#users").jqGrid('navGrid','#usersPage',{del:true,add:false,edit:false,search:false}); 
	jQuery("#users").jqGrid('navButtonAdd',
			"#usersPage", { 
			 	caption : "Apply Filter",
				title : "Toggle Search Toolbar",
				buttonicon : 'ui-icon-pin-s',
				onClickButton : function() {
					mygrid[0].toggleToolbar();
				}
			});
	jQuery("#users").jqGrid('filterToolbar', {
		stringResult : true,
		searchOnEnter : false
	});

});

// resize the grid if needed
$(window).bind('resize', function() {
	jQuery("#users").setGridWidth($('#grid_wrapper').width()-5, true);
	}).trigger('resize');

$(window).bind('load', function() {
		jQuery("#users").setGridWidth($('#grid_wrapper').width()-5, true);
		}).trigger('load');		
 
</script>

	</div>

</div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
