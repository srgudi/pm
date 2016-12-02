<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.taskNotificationRecipient fieldset p.error label {
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

form.taskNotificationRecipient {
	width: 30em;
}

form.taskNotificationRecipient label.error {
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
			var validator = $("#taskNotificationRecipient").validate({
		
				rules: { 
				'recipient': {required: true,alphabetsOnly:true,minlength: 0,maxlength: 30},
				'emailType': {required: true,alphabetsOnly:true,minlength: 0,maxlength: 300},
				'notificationTemplateId': {required: true,min:1}
        		}, 
        	messages: { 
        		'recipient': {
            		required: "Recipient is required",
            		alphabetsOnly:"No Special characters are allowed. Please enter a valid Recipient Name.",
            		minlength: "Enter Recipient with at least {0} characters.",
            		maxlength: "Enter Recipient with no more than {0} characters."},
        		'emailType': {
            		required: "Email Text is required",
            		alphabetsOnly:"No Special characters are allowed. Please enter a valid EmailType.",
            		minlength: "Enter Email Text with at least {0} characters.",
            		maxlength: "Enter Email Text with no more than {0} characters."},
				'notificationTemplateId': "Select one Type Of Template"
        		}, 
			errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				meta: "validate"
				});
			$("#taskNotificationRecipient").submit();
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

<!--  BUCKET -->
<c:url value="/mobileadmin/mobileAdminTaskNotificationRecepient.do" var="mobilerecepientUrl"/>   
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

						<a href="<c:out value='${mobilerecepientUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showformRecepient" onclick="showformRecepient()"
	                    	 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Recipient</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp; 
	                	
<body onload="hideformRecepient()">
<div id="formRecepient">
	<form:form modelAttribute="taskNotificationRecipient" method="POST"
		action="mobileAdminTaskNotificationRecepient.do">
		<input type="hidden" name="baseURL" id="baseURL"
			value="mobileAdminTaskNotificationRecipient.do" />
		<i><b><form:errors path="*" class="errorblock" element="div" />
		</b> </i>
		
		<form:hidden path="id" />

				<div data-role="fieldcontain" >
                    <form:label path="recipient">Recipient</form:label>
                    <form:input path="recipient" cssClass="input_full" tabindex="1"/>
                    
                    <form:label   path="emailType">Email Type</form:label>
                    <form:input path="emailType" cssClass="input_full" tabindex="2"/>
                </div>
                
                <div data-role="fieldcontain" >
                    <form:label path="notificationTemplateId">Relative Parent Code</form:label>
                   		<form:select path="notificationTemplateId" tabindex="3" cssClass="input_full">
							<form:option value="-1" label="Select" />
							<form:options items="${templateSet}" itemValue="id" itemLabel="subject" />
						</form:select>
                </div>


				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					
					<c:if test="${taskNotificationRecipient.id == null}">
						<span class="ui-button-text" tabindex="4">Save</span>
					</c:if>
					<c:if test="${taskNotificationRecipient.id != null}">
						<span class="ui-button-text" tabindex="4">Update</span>
    	            </c:if>
				</button>
				&nbsp;&nbsp;
				<button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text">Cancel</span>
				</button>
				
				<button type="button" id="showformRecepient"
					onclick="window.location='mobileAdminTaskNotificationRecepient.do';return false;"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<span class="ui-button-text">Back</span>
					</button>
	</form:form>
	</div>

<!-- BUCKET -->
<div id="gridRecepient">
<div id="grid_wrapper">
 <table id='mobileRecepient'></table>
    <div id='recepientPager'></div>
</div> 
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
		jQuery(document).ready(function(){ 
			var firmId = $("#firmId").val();
			
			var mygrid = jQuery("#mobileRecepient").jqGrid({
				url:'<c:url value="/appadmin/taskNotificationRecipientList.do"/>?firmId='+firmId,
			    datatype: 'json',
			    
				height :'100%',
			    mtype: 'GET',
			    colNames:['Recipient', 'Email Type', 'Type Of Template', 'Status'],
			    colModel :[ 
					{name:'recipient', index:'recipient',formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileAdminTaskNotificationRecepient.do', 
   						idName:'id'}},
					{name:'emailType', index:'emailType'},
					{name:'typeOfNotificationTemplate', index:'typeOfNotificationTemplate'},
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
			    pager: '#recepientPager',
			    rowNum:10,
			    loadonce:true,
			    rowList:[10,25,50],
			    sortname: 'name',
			    sortorder: 'asc',
			    viewrecords: true,
			    autowidth: false,
			    caption: 'Task Notification Recipient List',
			    editurl:'<c:url value="/appadmin/saveTaskNotificationRecipient.do"/>'
			  });

			  jQuery("#mobileRecepient").jqGrid('navGrid','#recepientPager',{del:true,add:false,edit:false,search:false});
			  jQuery("#mobileRecepient").jqGrid('navButtonAdd',
						"#recepientPager", {
							caption : "Apply Filter",
							title : "Toggle Search Toolbar",
							buttonicon : 'ui-icon-pin-s',
							onClickButton : function() {
								mygrid[0].togglemobileRecepient();
							}
						});
				jQuery("#mobileRecepient").jqGrid('filterToolbar', {
					stringResult : true,
					searchOnEnter : false
				});
		});
		$('#recepientPager').css("height", "50px");	
	</script>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
</script>


<script type="text/javascript">
function showformRecepient(){
	$("#gridRecepient").hide();	
	$("#formRecepient").show();
}
function hideformRecepient(){
	
	$("#formRecepient").hide();	
	$("#gridRecepient").show();
}

</script> 

