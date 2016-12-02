<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.code fieldset p.error label {
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

form.code {
	width: 30em;
}

form.code label.error {
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
						}, "Please enter valid data.");

						$.validator
								.addMethod("alphabetsOnly", function(value,
										element) {
									return this.optional(element)
											|| /^\s*[a-zA-Z.\s]+\s*$/i
													.test(value);
								},
										"No Special characters are allowed. Please enter valid data.");
						});

	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});

	$().ready(function() {
						$("#save").click(function() {
							if($("#code")
									.validate(
											{

												rules : {
													'shortName' : {
														required : true,
														alphabetsOnly : true,
														minlength : 0,
														maxlength : 50
													},
													'longDescription' : {
														alphabetsOnly : true,
														minlength : 0,
														maxlength : 100
													},
													'codeType' : {
														required : true,
														min : 1
													},
													'parentCode' : {},
													'sortOrder' : {
														range : [ 0, 50 ],
														required : true,
														digits : true
													}
												},
												messages : {
													'shortName' : {
														required : "Name is required",
														alphabetsOnly : "No Special characters are allowed. Please enter a valid Name.",
														minlength : "Enter Name with at least {0} characters.",
														maxlength : "Enter Name with no more than {0} characters."
													},
													'longDescription' : {
														required : "Description is required",
														alphabetsOnly : "No Special characters are allowed. Please enter a valid Description.",
														minlength : "Enter Description with at least {0} characters.",
														maxlength : "Enter Description with no more than {0} characters."
													},
													'codeType' : "Select one Code Type",
													'parentCode' : "",
													'sortOrder' : {
														digits : "Enter Sort Order Number only digits.",
														range : "Please enter Sort Order Number between range {0} and {1}."
													}
												}
											}).form()){

							$.ajax({
						           dataType: 'json',
						         type: 'POST',
					               data: $('#code').serialize(),
							       url: 'mobileAdminCode.do',
							       success: function(recipientId) {
							           	if(recipientId != -1){
							        		$.jGrowl("Record saved successfully");
							        		var tabl = $("#getcodewmob").dataTable();
							        		tabl.fnDraw();
					       				}else{
							           		 $.jGrowl("As Error has happened while process. ");	
						            	 } 
						           }

							});
							 return false;
							}else{
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
<div id="div2"  >
<!--  BUCKET -->
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>


			<form:form modelAttribute="code">
				<input type="hidden" name="baseURL" id="baseURL"
					value="mobileAdminCode.do" />
                <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
				<form:hidden path="id" />
				<center> 
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}"/></font></b>
					</c:if>
				</center>
				<div data-role="fieldcontain" >
                 <form:label class="ui-input-text" path="codeType">Type Of Code</form:label>
                   		<form:select id="adminCodeId" path="codeType" cssClass="input_full" tabindex="1" onChange="GetSelectedItem(this.value)">
							<form:option value="-1" label="Select" />
							 <form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                  <div data-role="fieldcontain" >
					<form:label path="sortOrder">Sort Order</form:label>
                    <form:input path="sortOrder" cssClass="input_full"  tabindex="2"/>
                </div>
				
				    <div data-role="fieldcontain" >
                    <form:label path="shortName">Name</form:label>
                    <form:input path="shortName" cssClass="input_full" tabindex="3"/>
                    </div>
                     <div data-role="fieldcontain" >
                  <form:label   path="longDescription">Description</form:label>
                   <form:input path="longDescription" cssClass="input_full" tabindex="4"/>
                </div>
                
                 <div data-role="fieldcontain" >
                <form:label path="parentCode">Relative Parent Code</form:label>
                   		<form:select path="parentCode" cssClass="input_full" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                    </div>
                   <div data-role="fieldcontain" >
                    <form:label   path="applicationLevelIndicator">Application Level Indicator</form:label>
						<form:radiobutton path="applicationLevelIndicator" value="true" label="Yes" tabindex="6"/> 
						<form:radiobutton path="applicationLevelIndicator" value="false" label="No" tabindex="7"/>
					
                </div>
                
                  <div data-role="fieldcontain" >
                  <form:label   path="activeFlag">Status</form:label>                  
						<form:radiobutton path="activeFlag" value="true" label="Active" tabindex="8" /> 
						<form:radiobutton path="activeFlag" value="false" label="Inactive" tabindex="9" />					
                </div>
						        <!-- <a href="mobileAdminCode.do"
						           style="text-decoration: none;">
						            <button type="button" id="refesh"
						            onclick="window.location='mobileAdminCode.do';return false;"
						                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                    role="button" aria-disabled="false" data-inline="true" data-mini="true">
						                <span class="ui-button-text">New Code</span>
						            </button>
						        </a> --> &nbsp;&nbsp;
						
						        <button type="button" id="save"
						                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                role="button" aria-disabled="false" data-inline="true" data-mini="true">
						                <c:if test="${code.id == null}">
						            <span class="ui-button-text"tabindex="10">Save</span>
						            </c:if>
						            <c:if test="${code.id != null}">
						            <span class="ui-button-text" tabindex="10">Update</span>
    	                             </c:if>
						        </button>
						        &nbsp;&nbsp;
						
						
						        <!-- <button type="reset"
						                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                role="button" aria-disabled="false" data-inline="true" data-mini="true">
						            <span class="ui-button-text">Cancel</span>
						        </button> -->
	<br/><br/>		

</form:form>
</div>

<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteCode">Delete</button>
</div>			
						   	
	<div id="confirming" class="modal" style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
				class="icon-book blue"></i> Delete Estimates</span>
		</div>
		<div class="modal-body">
			<span class="f12em">The selected estimates will be deleted.
				Deleted estimates can be restored again, worry not. Do you want to
				continue?</span>

		</div>
		<div class="modal-footer">
			<span id="confirmed" data-action="confirmed" class="btn btn-success">Yes</span>
			<span class="btn btn-success" data-dismiss="modal">Cancel</span>
		</div>
	</div>
	<div id="selectin" class="modal" style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
				class="icon-book blue"></i> No data selected</span>
		</div>
		<div class="modal-body">
			<span class="f12em">Please select one or more rows</span>

		</div>
		<div class="modal-footer">
			<span id="selectdRecod" data-action="deleteConfirmed"
				class="btn btn-success">Ok</span> 
		</div>
	</div>

 <div data-role="content" style="overflow:auto;">  
	<table  border="0" class="table table-striped table-hover table-bordered mb20" id="getcodewmob">
	<colgroup>
						<col style="width: 05%;">
						<col style="width: 20%;">
						<col style="width: 20%;">
						<col style="width: 20%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 05%;">
					</colgroup>
					<thead>
						<tr>
							<th class="cyan b center">ID</th>
							<th class="cyan b center">Short Name</th>
							<th class="cyan b center">Long Description</th>
							<th class="cyan b center">Type Of Name</th>
							<th class="cyan b center">App Level Indicator</th>
							<th class="cyan b center">Parent Code Name</th>
							<th class="cyan b center">Status</th>
							<th class="cyan b center">Edit</th>
						</tr>
		</thead>
		<tbody></tbody>
	</table>

 </div>
 
<script>
$(function(){
	var applicationLevelId;
    var appLevelIndicator1 = $("input[id='applicationLevelIndicator1']:checked").val();
	if(appLevelIndicator1){
		applicationLevelId="true";
	}else{
		applicationLevelId="false";
	}
	var codeTypeId = $("#adminCodeId").val();
$('#getcodewmob').dataTable( {
	/* "bJQueryUI": true, */
	"bJQueryMobileUI" : true,
	"sPaginationType" : "bootstrap",
	"bLengthChange": true,
	"sAjaxSource": '/pm-new/appadmin/retriveAdminCode.do?codeType=' + codeTypeId +'&applicationLevelId='+applicationLevelId,
	"bFilter": true,
    "bAutoWidth": false,
    "sInfoFiltered": " ",
    /* "aLengthMenu": [ 5, 10, 25, 50, 100 ], */
   /*  "iDisplayLength": 5, */
   /*  "sPaginationType": "bootstrap", */
    "bInfo": true,
    "bProcessing": 'true',
    "bServerSide": 'true',
    "bDeferRender": 'false',
    "bRetrieve": 'true',
    "bDestory" : 'true',
	"aoColumns": [
	              {
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                     	  var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
		                        return retVal; 
		                    },
		                    "sWidth": "5%"
                  },
                  {
                      "bUseRendered": "false",
                      "sClass": "center",
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
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                          return obj.aData[3];
                      }
                  },
                  {
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                          return obj.aData[4];
                      }
                  },
                  {
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                          return obj.aData[5];
                      }
                  },
                  {
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                          return obj.aData[6];
                      }
                  },
                  {
                      "bUseRendered": "false",
                      "sClass": "center",
                      "fnRender": function (obj) {
                          return obj.aData[7];
                      }
                  }
	]/* ,
	"bDeferRender": true */
});
});

$(function() {
$('#deleteCode').click(function () {
    var selectedItems = [];
    $('input[name="selectGridRow"]:checked').each(function () {
        selectedItems.push($(this).val());
    });
    if (selectedItems.length == 0) {
    	$('#selectin').modal();
    } else if ($(this).data('action') == 'delete') {
        $('#confirming').modal();
    }
});
});
$('#selectdRecod').click(function(){
	$('#selectin').modal('hide');
});
$('#confirmed').click(function () {
	var selectedItems = [];
   $('input[name="selectGridRow"]:checked').each(function () {
       selectedItems.push($(this).val());
   });
    var URL;
		if ($(this).data('action') == 'confirmed') {
        $('#confirming').modal('hide');
        URL = 'saveCode.do?id=' + selectedItems;
    }   
    $.ajax({
        type: "POST",
        url: URL,
        data: $('#code').serialize(),
        success: function (data) {
            if (data) {
            	$('#getcodewmob').dataTable().fnDraw();
                 $.jGrowl('Record Deleted Sucessfully');
            }else {
                $.pnotify({
                    title: 'Error',
                    text: 'Please contact system support with details.',
                    type: 'error',
                    animation: 'fade'
                });
            } 
        },
        error: function () {
            $.pnotify({
                title: 'Error',
                text: 'Error occurred during operation',
                type: 'error',
                animation: 'fade'
            });
        }
    });
});
function adminCodeEdit(partyId) {
	//alert("hi");
	window.location = '/pm-new/mobileadmin/mobileAdminCode.do?id=' + partyId;
	//showTaxform();
	return false;
}
</script>	
	<script type="text/javascript">
    $(document).ready(function() {
    	firmId = ${firm.id};
    	$("#adminCodeId").change(function() { 
    		var codeTypeId = $(this).val();
        	if(codeTypeId == -1){
        		populateDropdown($("#parentCode"), '');
        	}else{
        		$.post("<c:url value='/appadmin/getRelativeParentCode.do'/>", { codeTypeId: codeTypeId, firmId:firmId }, function(data) {
                    populateDropdown($("#parentCode"), data);
                });	
        	}
        });
    });
    function populateDropdown(select, data) {
    	select.html('');
    	select.append($('<option></option>').val("-1").html("None"));
        $.each(data, function(id, option) {
        	$.each(option, function(id, option) {
        	select.append($('<option></option>').val(option.key).html(option.value));
            
        });
        });
    }

</script>
	<script type="text/javascript">

$(document).ready(function() {
	 $(function () {
		 $('input[name="applicationLevelIndicator"]').live("click", (function () {
			 relaodDataTable();
         }));
    });
});

function GetSelectedItem(codeType) {
	if ($("#adminCodeId").val() != -1) {
    	relaodDataTable();
    }
};

function relaodDataTable() {
	var applicationLevelId;
    var appLevelIndicator1 = $("input[id='applicationLevelIndicator1']:checked").val();
	if(appLevelIndicator1){
		applicationLevelId="true";
	}else{
		applicationLevelId="false";
	}
	var codeId=$("#adminCodeId").val();
	$('#getcodewmob').dataTable().fnReloadAjax('/pm-new/appadmin/retriveAdminCode.do?codeType=' + codeId +'&applicationLevelId='+applicationLevelId);	

};
</script>
<!-- <div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteCode">Delete</button>
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
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>

 <div data-role="content" style="overflow:auto;">  
	<table  border="0" class="table table-striped table-hover table-bordered mb20" id="getcodewmob">
	<colgroup>
						<col style="width: 05%;">
						<col style="width: 20%;">
						<col style="width: 20%;">
						<col style="width: 20%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 05%;">
					</colgroup>
					<thead>
						<tr>
							<th class="cyan b center">ID</th>
							<th class="cyan b center">Short Name</th>
							<th class="cyan b center">Long Description</th>
							<th class="cyan b center">Type Of Name</th>
							<th class="cyan b center">App Level Indicator</th>
							<th class="cyan b center">Parent Code Name</th>
							<th class="cyan b center">Status</th>
							<th class="cyan b center">Edit</th>
						</tr>
		</thead>
		<tbody></tbody>
	</table>

 </div> -->



