<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.partyCode fieldset p.error label {
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

form.partyCode {
	width: 30em;
}

form.partyCode label.error {
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

		
	$().ready(function() {
		
						$("#save").click(function() {
											/* $.ajax({
											dataType: 'json',
											type: 'POST',
											data: $('#partyCode').serialize(),
											url: 'managePartyCodeMobile.do',
											success: function(clientId) {
											     if(clientId != -1){
													$.jGrowl("Record saved successfully");
												}else{
													 $.jGrowl("As Error has happened while process. ");	
												 } 
											}
											
											});
											return false; */

											if ($('#partyCode')
													.validate({rules : {
																	'code.shortName' : {
																		required : true,
																		alphabetsOnly : true,
																		minlength : 0,
																		maxlength : 50
																	},
																	'code.longDescription' : {
																		alphabetsOnly : true,
																		minlength : 0,
																		maxlength : 100
																	},
																	'code.codeType' : {
																		required : true,
																		min : 1
																	},
																	'code.parentCode' : {},
																	'sortOrder' : {
																		range : [0,20],
																		digits : true
																	}
																},
																messages : {
																	'code.shortName' : {
																		required : "Name is required",
																		alphabetsOnly : "Please	enter a	Valid Name ,No special characters are allowed .",
																		minlength : "Enter Short Name with at least {0}	characters.",
																		maxlength : "Enter Short Name with no more than	{0} characters."
																	},
																	'code.longDescription' : {
																		required : "Description	is required",
																		alphabetsOnly : "Please	enter a	Valid Description ,No special characters are allowed .",
																		minlength : "Enter Description with at least {0} characters.",
																		maxlength : "Enter Description with no more than {0} characters."
																	},
																	'code.codeType' : "Select The Type of code.",
																	'code.parentCode' : "",
																	'sortOrder' : {
																		required : "Sort Order is required",
																		digits : "Enter	Sort Order only	digits.",
																		range : "Please	enter Sort Order between range {0} and {1}."
																	}
																}
															}).form()) {
												//alert("success");
												$.ajax({
													dataType : 'json',
															type : 'POST',
															data : $('#partyCode').serialize(),
															url : 'managePartyCodeMobile.do',
															success : function(clientId) {
																if (clientId != -1) {
																	$.jGrowl("Record saved successfully");
																	document.getElementById("partyCode").reset();
																	$('#getFirmCodeMobile').dataTable().fnReloadAjax('retriveCodeType.do');
																} else {
																	$.jGrowl("As Error has happened while process. ");
																}
															}
														});
												return false;
											} else {
												return false;
											}
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
 <c:url value="/mobilefirmadmin/managePartyCodeMobile.do" var="mobileFirmManageCodeUrl"/> 
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<%-- <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
<a href="<c:out value='${mobileFirmManageCodeUrl}'/>" style="text-decoration:none;">
            <button type="button" id="showCodeform" onclick="showCodeform()"
                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                    role="button" aria-disabled="false" data-inline="true" data-mini="true">
                <span class="ui-button-text">New Code</span>
            </button>
        </a>

</security:authorize> --%>

<body>
 <div id="divCode">
				<form:form modelAttribute="partyCode">
					<input type="hidden" name="baseURL" id="baseURL"
						value="managePartyCodeMobile.do" />
					<input type="hidden" name="inValidClientId"
						value="${param.inValidClientId }" />
					<i><b><form:errors path="*" class="errorblock"
								element="div" />
					</b>
					</i>
						<form:hidden path="id" />
						<center> <b><strong>${inValidClientId}</strong> </b> </center> 
				<center> 
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}"/></font></b>
					</c:if>
				</center>
                
                <div data-role="fieldcontain">
                    <form:label path="code.codeType">Type Of Code</form:label>
                   
                   		<form:select path="code.codeType" cssClass="input_full" tabindex="1" onChange="GetSelectedItem(this.value)">
							<form:option value="-1" label="Select" />
							<form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                   
                </div>
                
				<div data-role="fieldcontain" >
                    <form:label path="code.shortName">Name</form:label>
                    <form:input path="code.shortName" cssClass="input_full" tabindex="1"/>
                </div>
                  
                 <div data-role="fieldcontain" >
                    <form:label   path="code.longDescription">Description</form:label>
                    <form:input path="code.longDescription" cssClass="input_full" tabindex="2"/>
                </div>
                
                <div data-role="fieldcontain" >
                    <form:label path="code.parentCode">Relative Parent Code</form:label>
                   		<form:select path="code.parentCode" tabindex="4" cssClass="input_full">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                </div>
                  
                <div data-role="fieldcontain" >
                    <form:label path="sortOrder">Sort Order</form:label>
                    <form:input path="sortOrder" cssClass="input_full"  tabindex="5"/>
                </div>
<br/>

    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
        <button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<c:if test="${partyCode.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
						</c:if>
						<c:if test="${partyCode.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;

        <!-- <button type="reset"
                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                role="button" aria-disabled="false" data-inline="true" data-mini="true">
            <span class="ui-button-text">Cancel</span>
        </button> -->
         </security:authorize>
         
         <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyCode.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false" data-inline="true" data-mini="true">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <!-- <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false" data-inline="true" data-mini="true">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button> -->
	            	</c:if>
            	</security:authorize>
          			<button id="hideCodeform" onclick="window.location='managePartyCodeMobile.do';return false;"
	                 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                 role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                 <span class="ui-button-text">Back</span>
	                 </button>
	                 
				</form:form>
	</div>
</body>
<!-- BUCKET -->
<br/>
<div>
<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteRecord">Delete</button>
</div>
<div id="confirmDeleteRec" class="modal" style="display: none; margin-top:10">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deletedRecord" data-action="deletedRecord" class="btn btn-success">Yes</span>
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>

<div id="selectDelRow" class="modal" style="display: none; margin-top:10">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectedRecord" data-action="deletedRecord" class="btn btn-success">Ok</span>
        <!-- <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
    </div>
</div>

<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 100%;">
  <div id="grid_wrapper">  
	<table class="table table-striped table-hover table-bordered mb20" id="getFirmCodeMobile">
	<!-- <caption title="" class="captionFont">Code List</caption> -->
		<colgroup>
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 5%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>       
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Code Name</th>
			  <th class="cyan b center">Code Type Name</th>
			  <th class="cyan b center">Code ParentCode Name</th>
			  <th class="cyan b center">Sort Order</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			
		</thead>
		<tbody></tbody>
	</table>

 </div>
</div>

<script type="text/javascript">

//var firmPracticeID = $('input[name="firmPracticeID"]').val();

var codetable = $('#getFirmCodeMobile').dataTable( {
	/* "bJQueryUI": true, */
	"bJQueryMobileUI" : true,
	"bLengthChange": true,
	"sAjaxSource": '/pm-new/mobilefirmadmin/retriveCodeType.do',
	"bFilter": true,
    "bAutoWidth": false,
    "sInfoFiltered": " ",
    "aLengthMenu": [ 10, 25, 50, 100 ],
    "iDisplayLength": 10,
   /*  "sPaginationType": "bootstrap", */
    "bInfo": true,
    "bProcessing": 'true',
    "bServerSide": 'true',
    "bDeferRender": 'false',
    "bRetrieve": 'true',
    "bDestory" : 'true',
	"aoColumns": [
                   {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                            	 var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
			                        return retVal;
			                    },
			                    "sWidth": "5%"
                         },
                         {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                                return obj.aData[1];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[2];
                             }
                         },
                         {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                                 return obj.aData[3];
                             }
                         },
                         {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                                 return obj.aData[4];
                             }
                         },
                         {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                                 return obj.aData[5];
                             }
                         },
                         {
                        	 "sClass" : "jqmSorter",
                             "fnRender": function (obj) {
                                 return obj.aData[6];
                             }
                         }
	]/* ,
	"bDeferRender": true */
} );	
$('#deleteRecord').click(function() {
	var selectedItems = [];
	$('input[name="selectGridRow"]:checked').each(function() {
		selectedItems.push($(this).val());
	});
	if (selectedItems.length == 0) {
		$('#selectDelRow').modal();
	} else if ($(this).data('action') == 'delete') {
		$('#confirmDeleteRec').modal();
	}
});
$('#selectedRecord').click(function() {
	$('#selectDelRow').modal('hide');
});
$('#deletedRecord').click(function() {
	var selectedItems = [];
	$('input[name="selectGridRow"]:checked').each(function() {
		selectedItems.push($(this).val());

	});
	var URL;
	if ($(this).data('action') == 'deletedRecord') {
		$('#confirmDeleteRec').modal('hide');
		URL = '/pm-new/mobilefirmadmin/savePartyCode.do?id=' + selectedItems;
	}

	$.ajax({
		type : "POST",
		url : URL,
		data : $('#organization').serialize(),
		success : function(data) {
			if (data) {
				$('#getFirmCodeMobile').dataTable().fnDraw();
				$.jGrowl('Record Deleted Sucessfully');
			} else {
				$.pnotify({
					title : 'Error',
					text : 'Please contact system support with details.',
					type : 'error',
					animation : 'fade'
				});
			}
		},
		error : function() {
			$.pnotify({
				title : 'Error',
				text : 'Error occurred during operation',
				type : 'error',
				animation : 'fade'
			});
		}
	});
});
</script>
        <script>
            /* $(document).ready(function(){
            	$(".colorBoxDemoBank").colorbox({});
            }); */
            function CodeEdit(id) {
      			//$('#codehme').load('managePartyCode.do?id='+id); 
      			window.location = '/pm-new/mobilefirmadmin/managePartyCodeMobile.do?id=' + id;
      			return false;
              } 
        </script>
</div>
<script type="text/javascript">
function GetSelectedItem(partyCode) {
	if(partyCode == -1){
		$('#getFirmCodeMobile').dataTable().fnReloadAjax('/pm-new/mobilefirmadmin/retriveCodeType.do');	
	}else{
		$('#getFirmCodeMobile').dataTable().fnReloadAjax('/pm-new/mobilefirmadmin/retriveCodeType.do?codeTypeId=' +partyCode);
	}
};
</script>
</div>