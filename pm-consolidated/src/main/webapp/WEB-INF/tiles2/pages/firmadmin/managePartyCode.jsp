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

	$()
			.ready(
					function() {
						$("#save")
								.click(
										function() {
											var container = $('div.error_container');
											// validate the form when it is submitted
											var validator = $("#partyCode")
													.validate(
															{

																rules : {
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
																		range : [
																				0,
																				20 ],
																		digits : true
																	}

																},
																messages : {
																	'code.shortName' : {
																		required : "Name is required",
																		alphabetsOnly : "Please enter a Valid Name ,No special characters are allowed .",
																		minlength : "Enter Short Name with at least {0} characters.",
																		maxlength : "Enter Short Name with no more than {0} characters."
																	},
																	'code.longDescription' : {
																		required : "Description is required",
																		alphabetsOnly : "Please enter a Valid Description ,No special characters are allowed .",
																		minlength : "Enter Description with at least {0} characters.",
																		maxlength : "Enter Description with no more than {0} characters."
																	},
																	'code.codeType' : "Select Code-Type",
																	'code.parentCode' : "",
																	'sortOrder' : {
																		required : "Sort Order is required",
																		digits : "Enter Sort Order only digits.",
																		range : "Please enter Sort Order between range {0} and {1}."
																	}

																},
																errorContainer : container,
																errorLabelContainer : $(
																		"ol",
																		container),
																wrapper : 'li',
																meta : "validate",
																submitHandler : function(form) {
																	$
																			.ajax({
																				dataType : 'json',
																				type : 'POST',
																				data : $(
																						'#partyCode')
																						.serialize(),
																				url : 'managePartyCode.do',
																				success : function(
																						codeId) {

																					if (codeId != -1) {
																						$.jGrowl("Record saved successfully");
																						var partyCode = $("#code\\.codeType").val();
																						if(partyCode != -1){
																							$('#getFirmCode').dataTable().fnReloadAjax('retriveCodeType.do?codeTypeId=' +partyCode);
																						}
																						document.getElementById("partyCode").reset();
																						
																					} else {
																						$.jGrowl("As Error has happened while process. ");
																					}
																				}

																			});
																	return false;
																}

															});
										});
						$("#newCode").click(function() {
							//	alert("new");
							$('#codehme').load('managePartyCode.do');
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
.pCTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>
<div class="well" style="margin-top: 0px;">
<div class="well" style="margin-bottom: 0px;"">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<!-- <span class="legend b">Code</span> -->
				<form:form modelAttribute="partyCode" method="POST"
					action="managePartyCode.do">
					<input type="hidden" name="baseURL" id="baseURL"
						value="managePartyCode.do" />
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
                <div class="container_12 mt20">
                </br>
                </br>
<div class="row">	
<div class="span3">
<div class="grid_2 right"><form:label path="code.codeType"><spring:message code="label.typeOfCode"/></form:label></div>
<div class="grid_3 right"><form:select path="code.codeType" cssClass="formSelect" tabindex="1" onChange="GetSelectedItem(this.value)">
							<form:option value="-1" label="Select" />
							<form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select></div>
</div>
<div class="span3">
<form:label path="code.shortName"><spring:message code="label.name"/></form:label>
<form:input path="code.shortName" cssClass="formInput" tabindex="1"/>
</div>
<div class="span3">
<form:label   path="code.longDescription"><spring:message code="label.description"/></form:label>
<form:input path="code.longDescription" cssClass="formInput" tabindex="2"/>
</div>
</div>
<div class="row">	
<div class="span3">
<form:label path="code.parentCode"><spring:message code="label.relativeParentCode"/></form:label>
<form:select path="code.parentCode" tabindex="4" cssClass="formSelect">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
</div>
<div class="span3">
<form:label path="sortOrder"><spring:message code="label.sortOrder"/></form:label>
<form:input path="sortOrder" cssClass="formInput"  tabindex="5"/>
</div>
</div>


    <div class="grid_3">&nbsp;</div>
    <div class="grid_8">
    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
    
        <button  id="save"
						class="btn btn-success"
						role="button" aria-disabled="false">
						<c:if test="${partyCode.id == null}">
						<span class="ui-button-text" tabindex="13"><spring:message code="label.save"/></span>
						</c:if>
						<c:if test="${partyCode.id != null}">
    	                <span class="ui-button-text" tabindex="12"><spring:message code="label.update"/></span>
    	                </c:if>
					</button>
         </security:authorize>
         
         <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyCode.id != null}">
		                	<button type="button" id="save"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
	            	</c:if>
            	</security:authorize>
            </div>
</div>
				</form:form>
		
	</div>
</div>
<script type="text/javascript">
function GetSelectedItem(partyCode) {
	if(partyCode == -1){
		$('#getFirmCode').dataTable().fnReloadAjax('retriveCodeType.do');	
	}else{
		$('#getFirmCode').dataTable().fnReloadAjax('retriveCodeType.do?codeTypeId=' +partyCode);
	}
};
</script>
<div id="confmDltn" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="dltCnfrmed" data-action="dltCnfrmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="messageDelete" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Sorry, You are not authorised to delete</span>

    </div>
    <div class="modal-footer">
        <!-- <span id="deleteConfirmed" data-action="deleteConfirmed" class="btn btn-success">Yes</span> -->
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>
<div id="selctRw" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="slctCnfrmed" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getFirmCode">
		<colgroup>
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
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
			<tr>       
			  <th class="cyan b center"></th>
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
   <input type="hidden" id="userRole" value="${urole}" />
 </div>
</div>

<script type="text/javascript">
$(function() {
	   var partyCode = $("#code\\.codeType").val();
	   $("#getFirmCode").dataTable({
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
           "bAutoWidth": false,
           "sDom": '<"H"<"pCTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No code found. Please select a type of code from above."
           },
           "sAjaxSource": 'retriveCodeType.do?codeTypeId=' +partyCode,
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
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	   $("div.pCTools").html('<button type="submit" class="btn" data-action="delete" id="deleteCode"> <i class="icon-trash icon-white"></i> </button>');
	});

$(function() {
$('#deleteCode').click(function () {
	var ro = $('#userRole').val();
	if(ro=="ROLE_APP_ADMIN"){
		 $('#messageDelete').modal(); 
	 }
    var selectedItems = [];
    $('input[name="selectGridRow"]:checked').each(function () {
        selectedItems.push($(this).val());
    });
    if (selectedItems.length == 0 && (ro!="ROLE_APP_ADMIN")) {
    	$('#selctRw').modal();
    } else if ($(this).data('action') == 'delete' && (ro!="ROLE_APP_ADMIN")) {
        $('#confmDltn').modal();
    }
});
});
$('#slctCnfrmed').click(function(){
	$('#selctRw').modal('hide');
});
$('#dltCnfrmed').click(function () {
	 var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
	 if ($(this).data('action') == 'dltCnfrmed') {
        $('#confmDltn').modal('hide');
        URL = 'savePartyCode.do?id=' + selectedItems;
    } 
	 $.ajax({
        type: "POST",
        url: URL,
        data: $('#partyCode').serialize(),
        success: function (data) {
            if (data) {
            	$('#getFirmCode').dataTable().fnDraw();
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
            function CodeEdit(id) {
      			$('#codehme').load('managePartyCode.do?id='+id); 
      			$("#codeTab").tab().show();
              } 
        </script>
</div>
<script type="text/javascript">
    $(document).ready(function() {
    	//alert('Hello Sai');    
    	firmId = ${firm.id};
        $("#code\\.codeType").change(function() {     
        	codeTypeId = $(this).val();
        	if(codeTypeId == -1){
        		populateDropdown($("#code\\.parentCode"), '');
        	}else{
                $.get("<c:url value='/firmadmin/getRelativeParentCodeWhereAppFalse.do'/>", { codeTypeId: codeTypeId, firmId:firmId }, function(data) {
                    populateDropdown($("#code\\.parentCode"), data);
                });        		
        	}
        });
    });
 
    function populateDropdown(select, data) {
    	//$("#list").jqGrid('clearGridData');
    	select.html('');
    	select.append($('<option></option>').val("-1").html("None"));
        $.each(data, function(id, option) {
        	$.each(option, function(id, option) {
        	select.append($('<option></option>').val(option.key).html(option.value));
            
        });
        });       
    }

</script>

 

