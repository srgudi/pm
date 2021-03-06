<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.locTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="confirmDeletin" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfirmd" data-action="deleteConfirmd" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="alertmessage" class="modal" style="display: none; ">
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
<div id="selctRo" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectConfirmd" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<!-- DataTable -->
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllLoc">
	 <colgroup>
					<col style="width: 5%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 5%;">
		</colgroup> 
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Type</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Home Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>
			  <th class="cyan b center"></th>
			  <th class="gridFilter">Client Name</th>
			  <th class="gridFilter">Name</th>
			  <th class="gridFilter">Type</th>
			  <th class="gridFilter">Office Number</th>
			  <th class="gridFilter">Home Number</th>
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
	   $("#getAllLoc").dataTable({
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
           "sDom": '<"H"<"locTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "bAutoWidth": false,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No location found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'locationList.do?clientId='+ clientId,
           "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
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
									} ]
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
	   $("div.locTools").html('<button type="submit" class="btn" data-action="delete" id="deleteLoc"> <i class="icon-trash icon-white"></i> </button>');
	});
	
	$(document).ready(function() { 
	$('#deleteLoc').click(function () {
		var ro = $('#usrole').val();
		if(ro=="ROLE_CLIENT_STAFF" || ro == "ROLE_STAFF"){
			 $('#alertmessage').modal(); 
		 }
         var selectedItems = [];
         $('input[name="selectGridRow"]:checked').each(function () {
             selectedItems.push($(this).val());
         });
         if (selectedItems.length == 0 && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
        	 $('#selctRo').modal();
         } else if ($(this).data('action') == 'delete' && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
             $('#confirmDeletin').modal();
         }
     });
	 });
	 $('#selectConfirmd').click(function(){
			$('#selctRo').modal('hide');
		});
     $('#deleteConfirmd').click(function () {
     	var clientId = ${clientId};
     	var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());

        });
         var URL;
			if ($(this).data('action') == 'deleteConfirmd') {
             $('#confirmDeletin').modal('hide');
             URL = 'saveLocationList.do?id=' + selectedItems;
         }
			 
	          
         $.ajax({
             type: "POST",
             url: URL,
             data: $('#partySite').serialize(),
             success: function (data) {
                 if (data) {
                	 $('#getAllLoc').dataTable().fnDraw();
                 	 $.jGrowl('Record Deleted Sucessfully');
                 } else {
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
       // $(document).ready(function(){
       // 	$(".colorBoxDemoLoc").colorbox({});
       // }); 
        
            function LocationEdit(id) {
	        	//  alert(id);
	    			var clientId = ${clientId};
	    		//	alert(clientId);
	  			$('#locationfoo').load('clientLocation.do?clientId='+clientId+'&id='+id);
	  			$('#locationTabs a:last').tab('show');
	  			 $('#locationhome').hide();
	        	 $('#locationfoo').show();
	          } 
        </script>
</div>

		
	
	
	