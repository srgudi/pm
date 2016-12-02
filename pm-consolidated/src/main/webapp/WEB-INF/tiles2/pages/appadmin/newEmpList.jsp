<%@ include file="../../layout/PM_NEW_INCLUDES.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
 input, textarea {
width: 160px;
} 
select {
width: 150px;
}
.empTools{
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
        <span class="f12em">The selected staff will be deleted. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="empDeleteConfirmed" data-action="empDeleteConfirmed" class="btn btn-success">Yes</span>
        <span class="btn" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="empSelectRow" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="empSelectConfrmed" data-action="empDeleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllClient">
		<colgroup>
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;"> 
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Title</th>
			  <th class="cyan b center">Role</th>
			  <th class="cyan b center">Relationship Type</th>
			  <th class="cyan b center">Email</th>
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

	<input type="hidden" name="inValidClientId" id="firmId" value="${firmId}" />
 </div>
</div>

<script>
	$(function(){
	firmId = ${sessionfirmId};
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
           "bAutoWidth": false,
           "sDom": '<"H"<"empTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No employee found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'mainEmployeeList.do?newfirmId='+firmId,
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
                       { type: "select", values: ['FIRM ADMIN','PARTNER','STAFF'] }, 
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	   $("div.empTools").html('<button type="submit" class="btn" data-action="delete" id="deleteEmp"> <i class="icon-trash icon-white"></i> </button>');
	});
	
	$(function() {
	$('#deleteEmp').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#empSelectRow').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeleting').modal();
        }
    });
	});
	$('#empSelectConfrmed').click(function(){
		$('#empSelectRow').modal('hide');
	});
	
	  $('#empDeleteConfirmed').click(function () {
	    	var selectedItems = [];
	       $('input[name="selectGridRow"]:checked').each(function () {
	           selectedItems.push($(this).val());
	       });
	        var URL;
				if ($(this).data('action') == 'empDeleteConfirmed') {
	            $('#confirmDeleting').modal('hide');
	            URL = 'saveClientAjaxList.do?id=' + selectedItems;
	        }   
	        $.ajax({
	            type: "POST",
	            url: URL,
	            data: $('#party').serialize(),
	            success: function (data) {
	            	 if (data) {
	                 	$('#getAllClient').dataTable().fnDraw();
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
            function EmpEdit(parytId) {
            	//alert(id);
            	$('#empaddedit').load('adminFirmEmployee.do?id='+parytId);
           	 	$('#newempTabs a:last').tab('show');
           	    $('#emplist').hide();
     		    $('#empaddedit').show();
              } 
        </script>
</div>
