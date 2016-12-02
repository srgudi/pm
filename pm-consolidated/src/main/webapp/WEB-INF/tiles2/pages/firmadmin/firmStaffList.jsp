<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
 input, textarea {
width: 150px;
} 
select {
width: 155px;
}
.fsTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="confirmDltng" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfmed" data-action="deleteConfmed" class="btn btn-success">Yes</span>
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
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getFirmStaff">
		<colgroup>
					<col style="width: 05%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 05%;">
		</colgroup>
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Title</th>
			  <th class="cyan b center">Role</th>
			  <th class="cyan b center">Relationship Type</th>
			  <th class="cyan b center">Email Address</th>
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

<input type="hidden" id="userRole" value="${urole}" />
 </div>
</div>

<script>
	$(function(){
		var partyId = $('input[name="partyId"]').val();
	   $("#getFirmStaff").dataTable({
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
           "sDom": '<"H"<"fsTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No staff found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'manageFirmStaffList.do?partyId='+partyId,
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
                         }]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'PARTNER','STAFF'] }, 
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	   $("div.fsTools").html('<button type="submit" class="btn" data-action="delete" id="deleteStaff"> <i class="icon-trash icon-white"></i> </button>');
});

	$(function() {
	$('#deleteStaff').click(function () {
		var ro = $('#userRole').val();
		if(ro=="ROLE_APP_ADMIN"){
			 $('#message').modal(); 
		 }
	    var selectedItems = [];
	    $('input[name="selectGridRow"]:checked').each(function () {
	        selectedItems.push($(this).val());
	    });
	    if (selectedItems.length == 0 && (ro!="ROLE_APP_ADMIN")) {
	    	$('#selectRow').modal();
	    } else if ($(this).data('action') == 'delete' && (ro!="ROLE_APP_ADMIN")) {
	        $('#confirmDltng').modal();
	    }
	});
	});
	$('#selectConfirmed').click(function(){
		$('#selectRow').modal('hide');
	});
	$('#deleteConfmed').click(function () {
		var selectedItems = [];
		   $('input[name="selectGridRow"]:checked').each(function () {
		       selectedItems.push($(this).val());
		   });
		   var URL;
			if ($(this).data('action') == 'deleteConfmed') {
	        $('#confirmDltng').modal('hide');
	        URL = 'saveClientAjaxList.do?id=' + selectedItems ;
	    }
			$.ajax({
		        type: "POST",
		        url: URL,
		        data: $('#party').serialize(),
		        success: function (data) {
		            if (data) {
		            	 $('#getFirmStaff').dataTable().fnDraw();
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
</div>
<script>
	function editFirmStaff(partyId){
		$('#firmStaffFoo').load('manageFirmStaff.do?id='+partyId);
		$('#firmStaffTabs a:last').tab('show');
		 $('#firmStaffhome').hide();
		 $('#firmStaffFoo').show();
	} 
</script>
