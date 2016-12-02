<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<!-- <div class="container_12 mt15 mb15 gridWrap"> -->
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />


	<!-- <div class="well">	                	
					<button type="button" id="listButton" class="btn btn-primary">List</button>
                     	   </div> -->
                  	   
<%-- <div class="yui3-u-1-5" style="margin-top: 22px;width:200px">
<div id="accordion" style="min-width: 200px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"></span>

 <div class="bs-docs-sidebar" style="width:200px;" id="MainTab" >
<ul class="nav nav-tabs nav-stacked"> 
<li><a href="mainClient.do" onclick="window.location='mainClient.do';return false;" data-toggle="tab"><spring:message code="label.clientList"/></a></li>
</ul>
</div> 
</form:form>
</div>
</div> --%>
<!-- </div>  --> 
<br/><br/><br/>
   <div class="yui3-u-19-24" style="margin-left: 240px;float:right;">    
  
<div id="headerBand" class="headerCap"></div>
  <div class="span6">  
</div>            	   
     <div class="tabbable" id="clientTabs">
    	<ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="mainClientTabs">    
        	<li class="active"><a data-target="#list"  href="mainClient.do" onclick="window.location='mainClient.do';return false;" style="background-color:#F5F5F5;" class="active" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.clientList"/></a></li>
        	<li><a data-target="#edit" href="newEditclientDetail.do" onclick="window.location='newEditclientDetail.do';return false;" data-toggle="tab"><i class="icon-save"></i><spring:message code="label.clientAddOrEdit"/></a></li>
		</ul> 	
  	</div>
<!--  END GRID BUCKET -->

<!-- DataTable -->
<div style="width: 100%;">

<div id="confirmDeleteRec" class="modal" style="display: none; ">
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
<div id="message" class="modal" style="display: none; ">
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
<div id="selectDelRow" class="modal" style="display: none; ">
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
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllClient">
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
			  <th class="cyan b center">Id</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Partner-In-Charge</th>
			  <th class="cyan b center">Office Contact</th>
			  <th class="cyan b center">Email</th>
			  <th class="cyan b center">Edit</th>
			  <th class="cyan b center">Manage</th>
			</tr>
			<tr>
			  <th class="cyan b center"></th>
			  <th class="gridFilter">Client Name</th>
			  <th class="gridFilter">Partner-In-Charge</th>
			  <th class="gridFilter">Office Contact</th>
			  <th class="gridFilter">Email</th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<input type="hidden" name="inValidClientId" id="firmId" value="${firmId}" />
	<input type="hidden" id="usrole" value="${urole}" />
 </div>
</div>

<script>
	$(function(){
	   $("#getAllClient").dataTable({
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
           "sDom": '<"H"<"tools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No client is found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'clientAjaxList.do',
           "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
           "oTableTools": {
        	   "sRowSelect": "single"
           },
           "aoColumns": [
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                            	var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
     	                        return retVal;
                             } 	 
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
                       null,
                       null,
                    
          ]
});
 $("div.tools").html('<button type="submit" class="btn" data-action="delete" id="deleteRecord"> <i class="icon-trash icon-white"></i> </button>');
	});
	
	$(document).ready(function() {
	$('#deleteRecord').click(function () {
		var ro = $('#usrole').val();
		if(ro=="ROLE_CLIENT_STAFF" || ro == "ROLE_STAFF" || (ro == "ROLE_APP_ADMIN")){
			 $('#message').modal(); 
		 }
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0 && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF") && (ro!="ROLE_APP_ADMIN")) {
             $('#selectDelRow').modal();
        } else if (($(this).data('action') == 'delete') && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF") && (ro!="ROLE_APP_ADMIN")) {
            $('#confirmDeleteRec').modal();
        }
    });
	 });
	$('#selectedRecord').click(function(){
		$('#selectDelRow').modal('hide');
	});
    $('#deletedRecord').click(function () {
    	
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deletedRecord') {
            $('#confirmDeleteRec').modal('hide');
            URL = 'saveClientAjaxList.do?id=' + selectedItems ;
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#organization').serialize(),
            success: function (data) {
                if (data) {
               	$('#getAllClient').dataTable().fnDraw();
               	$.jGrowl('Record Deleted Sucessfully');
                }  else {
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
</div>
<script>	
	function manageClient(partyId){
			window.location='clientDetail.do?clientId='+partyId;
			return false;
		}
	function editClient(partyId){
		window.location='newEditclientDetail.do?clientId='+partyId;
		return false;
	}
</script>


