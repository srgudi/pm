<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.bankTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="confirmDeleting" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfirmed" data-action="deleteConfirmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="alertmsg" class="modal" style="display: none; ">
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
<div id="selectRow" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectConfirmed" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>

<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<!-- DataTable -->
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllBank">
		 <colgroup>
					<col style="width: 5%;">
					<col style="width: 10%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 10%;">
		</colgroup> 
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Bank Name</th>
			  <th class="cyan b center">Type Of Account</th>
			  <th class="cyan b center">Account Number</th>
			  <th class="cyan b center">Contact Name</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>
			  <th class="cyan b center"></th>
			  <th class="gridFilter">Bank Name</th>
			  <th class="gridFilter">Type Of Account</th>
			  <th class="gridFilter">Account Number</th>
			  <th class="gridFilter">Contact Name</th>
			  <th class="gridFilter">Office Number</th>
			  <th class="gridFilter">Email Address</th>
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
		var clientId = ${clientId};
	$("#getAllBank").dataTable({
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
           "sDom": '<"H"<"bankTools">lpir>t',
           "bAutoWidth": false,
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No bank found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'accountAjaxList.do?clientId=' + clientId + '&accountCategory=700',
           "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
           "bRetrieve": 'true',
           "aoColumns": [
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
					                        return retVal;
					                    },
					                    "sWidth": "5%"
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[1];
										}
									},

									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[2];
										}
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[3];
										}
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[4];
										}
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[5];
										}
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
											return obj.aData[6];
										}
									},
									{
										"bUseRendered" : "false",
										"sClass" : "center",
										"fnRender" : function(obj) {
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
						                       { type: "text"},
						                       { type: "text"},
						                       { type: "text"},
						                      null
						                    
						          ]
						});
	  $("div.bankTools").html('<button type="submit" class="btn" data-action="delete" id="deleteBank"> <i class="icon-trash icon-white"></i> </button>');
	});
	$(function(){    
	 $('#deleteBank').click(function () {
		 var ro = $('#usrole').val();
			if(ro=="ROLE_CLIENT_STAFF" || ro == "ROLE_STAFF"){
				 $('#alertmsg').modal(); 
			 }
         var selectedItems = [];
         $('input[name="selectGridRow"]:checked').each(function () {
             selectedItems.push($(this).val());
         });
         if (selectedItems.length == 0 && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
        	 $('#selectRow').modal();
         } else if ($(this).data('action') == 'delete' && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
             $('#confirmDeleting').modal();
         }
     });
	 });
	 $('#selectConfirmed').click(function(){
			$('#selectRow').modal('hide');
		});
		
     $('#deleteConfirmed').click(function () {
     	var clientId = ${clientId};
     	var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
         var URL;
			if ($(this).data('action') == 'deleteConfirmed') {
             $('#confirmDeleting').modal('hide');
             URL = 'saveAccountAjaxList.do?id=' + selectedItems+ '&clientId' + clientId + '&accountCategory=700';
         }   
         $.ajax({
             type: "POST",
             url: URL,
             data: $('#bankPartyAccount').serialize(),
             success: function (data) {
                 if (data) {
                	 $('#getAllBank').dataTable().fnDraw();
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
        <script>
            function BankEdit(id) {
            	//  alert(id);
        			var clientId = ${clientId};
        		//	alert(clientId);
      			$('#foo').load('clientBank.do?clientId='+clientId+'&id='+id);
      			$('#myTabs a:last').tab('show');
      			 $('#home').hide();
	        	 $('#foo').show();
    			
              } 
             
             
/*             function BankDelete(id){
            	var clientId = ${clientId};
            	$.ajax({
		            dataType: 'json',
		            type: 'GET',
	                data: $('#partyAccount').serialize(),
			        url: 'deleteBank.do?newId=' + id + '&clientId' + clientId + '&accountCategory=700',
			        success: function(clientId) {
			        	//$("#cboxCancel").click();
		              	if(clientId != -1){
	            			$.jGrowl("Record deleted successfully");
	            			var clientId = ${clientId};
	            			var tableName = '#getAllBank';
	            			var gridURL = 'accountAjaxList.do?clientId=' + clientId + '&accountCategory=700';
	            			reloadGrid(tableName, gridURL);
	            		}
	            	 else{
	            		 $.jGrowl("As Error has happened while process. ");	
	            	 } 
	            }

			});
           } */
            
        </script>
</div>

