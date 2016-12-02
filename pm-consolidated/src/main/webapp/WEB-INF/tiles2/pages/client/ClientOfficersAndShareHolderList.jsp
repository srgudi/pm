<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.offTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>
<div id="confirmDelete" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deletedRec" data-action="deletedRec" class="btn btn-success">Yes</span>
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>
<div id="msg" class="modal" style="display: none; ">
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
<div id="selectDelRec" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectedRe" data-action="deletedRec" class="btn btn-success">Ok</span>
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>

<div class="yui3-u-19-24" style="margin-left: 2px;"> 

<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllOff">
		 <colgroup>
					<col style="width: 5%;">
					<col style="width: 30%;">
					<col style="width: 25%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
		</colgroup> 
		<thead>
			<tr>         
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Type Of Share</th>
			  <th class="cyan b center">No Of Shares</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>         
			  <th class="cyan b center"></th>
			  <th class="gridFilter">Name</th>
			  <th class="gridFilter">Type Of Share</th>
			  <th class="gridFilter">No Of Shares</th>
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
	   $("#getAllOff").dataTable({
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
           "sDom": '<"H"<"offTools">lpir>t',
           "bAutoWidth": false,
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No share found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'partyList.do?mainParty=' + clientId + '&relation=7',
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
										}
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
									} ]
						}).columnFilter({ sPlaceHolder: "head:after",
					           aoColumns: [  
	                                          null,
						                       { type: "text"},
						                       { type: "text"},
						                       { type: "text"},
						                      null
						                    
						          ]
						});
	   $("div.offTools").html('<button type="submit" class="btn" data-action="delete" id="deleteRec"> <i class="icon-trash icon-white"></i> </button>');
	});
	
	$(document).ready(function() {
	$('#deleteRec').click(function () {
		var ro = $('#usrole').val();
		if(ro=="ROLE_CLIENT_STAFF" || ro == "ROLE_STAFF"){
			 $('#msg').modal(); 
		 }
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0 && (ro!="ROLE_STAFF")) {
             $('#selectDelRec').modal();
        } else if ($(this).data('action') == 'delete' && (ro!="ROLE_STAFF")) {
            $('#confirmDelete').modal();
        }
    });
	  });
	$('#selectedRe').click(function(){
		$('#selectDelRec').modal('hide');
	});
    $('#deletedRec').click(function () {
    	
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deletedRec') {
            $('#confirmDelete').modal('hide');
            URL = 'saveOfficerAjaxList.do?id=' + selectedItems ;
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#party').serialize(),
            success: function (data) {
                if (data) {
               	$('#getAllOff').dataTable().fnDraw();
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
     /* $(document).ready(function(){
         $(".colorBoxDemoOff").colorbox({});
     }); */
     function OfficerEdit(id) {
       	//  alert(id);
   			var clientId = ${clientId};
   		//	alert(clientId);
 			$('#officerfoo').load('clientOfficersAndShareHolders.do?clientId='+clientId+'&id='+id);
 			$('#officerTabs a:last').tab('show');
 			 $('#officerhome').hide();
        	 $('#officerfoo').show();
         }
  </script>
</div>
