<%@ include file="../../layout/PM-INCLUDES.jsp"%>
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
	adminCodeList-style-type: disc;
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

	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});

	$()
			.ready(
					function() {
						$("#adminCodeSave").click(function() {
						var container = $('div.error_container');
						var validator = $("#code")
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
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate",
											submitHandler: function(form) {
												
							                	$.ajax({
									            dataType: 'json',
									            type: 'POST',
								                data: $('#code').serialize(),
										        url: 'adminCode.do',
										        success: function(clientId) {
										             if(clientId != -1){
									            		$.jGrowl("Record saved successfully");
									            		document.getElementById("code").reset();
									            		$('#getAdmnCode').dataTable()._fnAjaxUpdate();
									            	}else{
									            		 $.jGrowl("As Error has happened while process. ");	
									            	 } 
									            }
								
										});
								 return false;
											}
										});
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

.acTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>
<div class="well" style="margin-top: 0px;">
	<div class="well" style="margin-bottom: 0px;"">
		<!--  BUCKET -->

		<div class="error_container">
			<h7> <b>Please correct the following errors</b></h7>
			<ol></ol>
		</div>

		<div class="fieldset">
			<!-- <span class="legend b">Code</span> -->

			<form:form modelAttribute="code" method="POST" action="adminCode.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="adminCode.do" />
				<i><b><form:errors path="*" class="errorblock" element="div" />
				</b> </i>
				<form:hidden path="id" />
				<center>
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}" />
						</font> </b>
					</c:if>
				</center>
				<div class="container_12 mt20">
					<div class="row">
						<div class="span3">
							<form:label path="codeType">
								<spring:message code="label.typeOfCode" />
							</form:label>
							<form:select id="adminCodeId" path="codeType"
								cssClass="formSelect" tabindex="1"
								onChange="GetSelectedItem(this.value)">
								<form:option value="-1" label="Select" />
								<form:options items="${codeTypeSet}" itemValue="id"
									itemLabel="name" />
							</form:select>
						</div>
						<div class="span3">
							<form:label path="sortOrder">
								<spring:message code="label.sortOrder" />
							</form:label>
							<form:input path="sortOrder" cssClass="formInput" tabindex="2" />
						</div>
						<div class="span3">
							<form:label path="shortName">
								<spring:message code="label.name" />
							</form:label>
							<form:input path="shortName" cssClass="formInput" tabindex="3" />
						</div>
					</div>
					<div class="row">
						<div class="span3">
							<form:label path="longDescription">
								<spring:message code="label.description" />
							</form:label>
							<form:input path="longDescription" cssClass="formInput"
								tabindex="4" />
						</div>
						<div class="span3">
							<form:label path="parentCode">Relative Parent Code</form:label>
							<form:select path="parentCode" cssClass="formSelect" tabindex="5">
								<form:option value="-1" label="Select" />
								<form:options items="${parentCodeSet}" itemValue="id"
									itemLabel="shortName" />
							</form:select>
						</div>
						<div class="span3">
							<form:label path="applicationLevelIndicator">Application Level Indicator</form:label>

							<div class="row-fluid">
								<div class="span3">
									<label style="display: inline;"><form:radiobutton
											path="applicationLevelIndicator" value="true" tabindex="6" />Yes</label>
								</div>
								<div class="span3">
									<label style="display: inline;"><form:radiobutton
											path="applicationLevelIndicator" value="false" tabindex="7" />No</label>
								</div>
							</div>

						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<form:label path="activeFlag">Status</form:label>
							<div class="row-fluid">
								<div class="span5">

									<label><form:radiobutton path="activeFlag" value="true"
											style="width: 30px;" tabindex="8" />Active</label>
								</div>
								<div class="span5">
									<label path="activeFlag"><form:radiobutton
											path="activeFlag" value="false" style="width: 30px;"
											tabindex="9" />InActive</label>
								</div>

							</div>
						</div>
					</div>

					<div class="row">
						<div class="span">

							<button id="adminCodeSave" class="btn btn-success" role="button"
								aria-disabled="false">
								<c:if test="${code.id == null}">
									<span class="ui-button-text" tabindex="10"><spring:message
											code="label.save" /> </span>
								</c:if>
								<c:if test="${code.id != null}">
									<span class="ui-button-text" tabindex="10"><spring:message
											code="label.update" /> </span>
								</c:if>
							</button>
							&nbsp;&nbsp;

<%-- 
							<button type="reset" class="btn btn-success" role="button"
								aria-disabled="false">
								<span class="ui-button-text"><spring:message
										code="label.cancel" /> </span>
							</button> --%>
						
            		<!--  <a href="codeList.do" style="text-decoration:none;"> 
	                    	<button type="button" id="backToList"
	                        	    class="btn btn-primary">
	                        	<span class="ui-button-text">Back To List</span>
	                    	</button>
	              </a> -->
						</div>
					</div>
				</div>

			</form:form>
		</div>
	</div>

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
    var appLevelIndicator2 = $("input[id='applicationLevelIndicator2']:checked").val();
	if(appLevelIndicator1){
		applicationLevelId="true";
	}else{
		applicationLevelId="false";
	}
	var codeId=$("#adminCodeId").val();
	$('#getAdmnCode').dataTable().fnReloadAjax('retriveAdminCode.do?codeType=' + codeId +'&applicationLevelId='+applicationLevelId);	

};
</script>
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
	<div class="yui3-u-19-24" style="margin-left: 2px;">
		<div style="width: 120%;">
			<div id="grid_wrapper">
				<table border="0"
					class="table table-striped table-hover table-bordered mb20"
					id="getAdmnCode">
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
						<tr>
							<th class="cyan b center"></th>
							<th class="gridFilter"></th>
							<th class="gridFilter"></th>
							<th class="gridFilter"></th>
							<th class="gridFilter"></th>
							<th class="gridFilter"></th>
							<th class="gridFilter"></th>
							<th class="cyan b center"></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>

			</div>
		</div>

		<script>
	$(function(){
		var applicationLevelId;
	    var appLevelIndicator1 = $("input[id='applicationLevelIndicator1']:checked").val();
	    var appLevelIndicator2 = $("input[id='applicationLevelIndicator2']:checked").val();
		if(appLevelIndicator1){
			applicationLevelId="true";
		}else{
			applicationLevelId="false";
		}
		var codeTypeId = $("#adminCodeId").val();
		$("#getAdmnCode").dataTable({
		   "fnPreDrawCallback": function () {
               return true;
           },
           "fnDrawCallback": function () {
        	  
           },
           "aaSorting": [
               [0, "desc"]
           ],
           "bLengthChange": true,
           "bFilter": true,
           "sDom": '<"H"<"acTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "bAutoWidth": false,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No code found. Please select a type of code from above."
           },
           "sAjaxSource": 'retriveAdminCode.do?codeType=' + codeTypeId +'&applicationLevelId='+applicationLevelId,
           "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
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
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'true','false'] }, 
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
		 $("div.acTools").html('<button type="submit" class="btn" data-action="delete" id="deleteCode"> <i class="icon-trash icon-white"></i> </button>');
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
                	$('#getAdmnCode').dataTable().fnDraw();
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
</script>
		<script>
            /* $(document).ready(function(){
            	$(".colorBoxDemoBank").colorbox({});
            }); */
            function adminCodeEdit(id) {
      			$('#codehome').load('adminCode.do?id='+id); 
      			$("#codehome").tab().show();
              } 
        </script>
	</div>


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