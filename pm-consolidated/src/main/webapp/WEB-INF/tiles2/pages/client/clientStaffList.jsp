<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
  input, textarea {
width: 150px;
} 
select {
width: 160px;
}
.staffTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="confirmDeletng" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfrmed" data-action="deleteConfrmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
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
<div id="selectRo" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectConfrmed" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
        <!-- <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
    </div>
</div>

<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<!-- DataTable -->
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllStaff" >
		  <colgroup>
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 10%;">
		</colgroup> 
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Title</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Home Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center">Edit</th>
			</tr>
		 	<tr>
			  <th></th>
			  <th class="gridFilter">Name</th>
			  <th class="gridFilter">Title</th>
			  <th class="gridFilter">Office Number</th>
			  <th class="gridFilter">Home Number</th>
			  <th class="gridFilter">Email Address</th>
			  <th></th>
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
	var oTable =   $("#getAllStaff").dataTable({
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
           "sDom": '<"H"<"staffTools">lpir>t',
           "bAutoWidth": false,
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No staff found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'mainClientList.do?clientId=' + clientId,
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
									} ]
						}).columnFilter({ sPlaceHolder: "head:after",
					           aoColumns: [  
                                          null,
					                       { type: "text"},
					                       { type: "text"},
					                       { type: "text"},
					                       { type: "text"},
					                       { type: "text"},
					                      null
					                    
					          ]
					});
	   
	   $(window).bind('resize', function () {
		    oTable.fnAdjustColumnSizing();
		  } );
	   
	   $("div.staffTools").html('<button type="submit" class="btn" data-action="delete" id="deleteItms"> <i class="icon-trash icon-white"></i> </button>');

	});
	
	$(document).ready(function() {
	$('#deleteItms').click(function () {
		var ro = $('#usrole').val();
		if(ro=="ROLE_CLIENT_STAFF" || ro == "ROLE_STAFF"){
			 $('#message').modal(); 
		 }
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0 && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
        	$('#selectRo').modal();
        } else if ($(this).data('action') == 'delete' && (ro!="ROLE_CLIENT_STAFF") && (ro!="ROLE_STAFF")) {
            $('#confirmDeletng').modal();
        }
    });
	});
	$('#selectConfrmed').click(function(){
		$('#selectRo').modal('hide');
	});
    $('#deleteConfrmed').click(function () {
    	var clientId = ${clientId};
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deleteConfrmed') {
            $('#confirmDeletng').modal('hide');
            URL = 'saveClientAjaxList.do?id=' + selectedItems+ '&clientId' + clientId ;
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#party').serialize(),
            success: function (data) {
                if (data) {
                	$('#getAllStaff').dataTable().fnDraw();
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
            	$(".colorBoxDemoTask").colorbox({});
            }); */
            function StaffEdit(id){
//            	alert(id);
            	var clientId = ${clientId};
            	//var partyId = ${partyId};
//            	alert(clientId);
            	$('#stffoo').load('clientStaff.do?clientId='+clientId+'&id='+id);
            	$('#stfTabs a:last').tab('show');
           	 $('#stfhome').hide();
        	 $('#stffoo').show();
            }
        </script>
</div>

	