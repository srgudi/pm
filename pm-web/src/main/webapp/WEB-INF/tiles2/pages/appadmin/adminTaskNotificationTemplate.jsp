<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.taskNotificationTemplate fieldset p.error label {
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

form.taskNotificationTemplate {
	width: 30em;
}

form.taskNotificationTemplate label.error {
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
<script type="text/javascript">

	$(document).ready(function() {

		$.validator.addMethod("alphaNumeric", function(value, element) {  
		    return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);  
		},"Please enter valid Number.");
		
		$.validator.addMethod("alphabetsOnly", function(value, element) {  
		    return this.optional(element) || /^\s*[0-9a-zA-Z-.,@:%\s]+\s*$/i.test(value);  
		},"No Special characters are allowed. Please enter a valid.");
		
		$.validator.addMethod("multiemail", function(value, element) {  
		    return this.optional(element) || /^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$/i.test(value);  
		}," Please enter a valid Email ids..");

		
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
			var validator = $("#taskNotificationTemplate").validate({
		
				rules: { 
				'subject': {required: true,minlength: 0,maxlength: 4000},
				'bodyText': {required: true,minlength: 0,maxlength: 4000},
				'adminEmailId': {required: true,multiemail: true,minlength: 0,maxlength: 400}
        		}, 
        	messages: { 
        		'subject': {
            		required: "Subject is required",
            		alphabetsOnly:"No Special characters are allowed. Please enter a valid Subject.",
            		minlength: "Enter Subject with at least {0} characters.",
            		maxlength: "Enter Subject with no more than {0} characters."},
        		'bodyText': {
            		required: "Body Text is required",
            		minlength: "Enter Body Text with at least {0} characters.",
            		maxlength: "Enter Body Text with no more than {0} characters."},
				'adminEmailId': {
            		required: "Email Id is required",
            		multiemail:"Please enter a valid Email ids..",
            		minlength: "Enter Email Id with at least {0} characters.",
            		maxlength: "Enter Email Id with no more than {0} characters."}
        		}, 
			errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate"
				});
			$("#taskNotificationTemplate").submit();
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
<span class="legend b">Notification Template</span>
<div class="f13">
	<form:form modelAttribute="taskNotificationTemplate" method="POST"
		action="adminTaskNotificationTemplate.do">
		<input type="hidden" name="baseURL" id="baseURL"
			value="adminTaskNotificationTemplate.do" />
		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>
		
		<form:hidden path="id" />
				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="subject">Subject</form:label></div>
                    <div class="grid_3 right"><form:input path="subject" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="adminEmailId">Email Id</form:label></div>
                    <div class="grid_3 right"><form:input path="adminEmailId" cssClass="input_full" tabindex="2"/></div>
                </div>
                
                <div class="container_12 pt5">
		            <div class="grid_2 right"><form:label path="bodyText" cssClass="input_full">Body Text</form:label>      </div>
		            <div class="grid_5 right"><form:textarea path="bodyText" rows="3" cssClass="input_full" tabindex="3"/>      </div>
		      </div>
                

		<div class="container_12" style="margin: 10px;"></div>

		<div class="container_12">
			<div class="grid_3">&nbsp;</div>
			<div class="grid_8">
				<a href="adminTaskNotificationTemplate.do"
					style="text-decoration: none;">
					<button type="button" id="newClient"
					onclick="window.location='adminTaskNotificationTemplate.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span class="ui-button-text">New TaskNotification</span>
					</button> </a>&nbsp;&nbsp;

				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<c:if test="${taskNotificationTemplate.id == null}">
					<span class="ui-button-text" tabindex="4">Save</span>
					</c:if>
					<c:if test="${taskNotificationTemplate.id != null}">
    	                <span class="ui-button-text" tabindex="4">Update</span>
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
	</div>
</div>
<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Notification Template List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
			<table id="toolbar"></table>
			<div id="ptoolbar" class="scroll"></div>
		</div>
		<script type="text/javascript">
var status = ["All", "Active", "Inactive"];
var statusStr = ":All;Active:Active;Inactive:Inactive";
jQuery(document).ready(function(){
	var firmId = $("#firmId").val();
	
		var mygrid = jQuery("#toolbar").jqGrid({
		    url:'taskNotificationTemplateList.do',
		    datatype: 'json',
		  
			height :'100%',
			mtype : 'GET',
		    colNames:['Subject', 'Body Text', 'Admin EmailId', 'Status'],
		    colModel :[ 
				{name:'subject', index:'subject',formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminTaskNotificationTemplate.do', 
						idName:'id'}},
				{name:'bodyText', index:'bodyText'},
				{name:'adminEmailId', index:'adminEmailId'},
				{name:'status', index:'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
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
		    pager: jQuery('#ptoolbar'),
		    rowNum:10,
		    rowList:[10,25,50],
		    loadonce:true, 
            sortname: 'globalTaskNotificationTemplateName',
		    sortorder: 'asc',
		    viewrecords: true,
		    autowidth:  false,
		    caption: 'Task Notification Template List',
		    editurl:'<c:url value="/appadmin/saveTaskNotificationTemplate.do"/>'
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
	
		//resize the grid if needed
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


