<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.tTTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>
<div id="confirmDltn" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="dltConfrmed" data-action="dltConfrmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="messagepopup" class="modal" style="display: none; ">
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
<div id="selectRw" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="slctConfrmed" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getTax">
		<colgroup>
					<col style="width: 5%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
					<col style="width: 35%;">
					<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>       
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Description</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>       
			  <th class="cyan b center"></th>
			  <th class="gridFilter"></th>
			  <th class="gridFilter"></th>
			  <th class="gridFilter"></th>
			  <th class="cyan b center"></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
    <input type="hidden" id="loginRole" value="${urole}" />
 </div>
</div>

<script>
	$(function(){
		var firmPracticeID = $('input[name="firmPracticeID"]').val();
	   $("#getTax").dataTable({
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
           "sDom": '<"H"<"tTTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No tax found. Click 'Add/Edit' tab to get started."
           },
           "sAjaxSource": 'manageTaxList.do?firmPracticeID=' + firmPracticeID,
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
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	   $("div.tTTools").html('<button type="submit" class="btn" data-action="delete" id="deleteTax"> <i class="icon-trash icon-white"></i> </button>');
	});

	$(function() {
	$('#deleteTax').click(function () {
		var ro = $('#loginRole').val();
		if(ro=="ROLE_APP_ADMIN"){
			 $('#messagepopup').modal(); 
		 }
         var selectedItems = [];
         $('input[name="selectGridRow"]:checked').each(function () {
             selectedItems.push($(this).val());
         });
         if (selectedItems.length == 0 && (ro!="ROLE_APP_ADMIN")) {
        	 $('#selectRw').modal();
         } else if ($(this).data('action') == 'delete' && (ro!="ROLE_APP_ADMIN")) {
             $('#confirmDltn').modal();
         }
     });
	}); 
	 $('#slctConfrmed').click(function(){
			$('#selectRw').modal('hide');
		});
	 $('#dltConfrmed').click(function () {
		 var selectedItems = [];
	        $('input[name="selectGridRow"]:checked').each(function () {
	            selectedItems.push($(this).val());
	        });
		 if ($(this).data('action') == 'dltConfrmed') {
             $('#confirmDltn').modal('hide');
             URL = 'saveTax.do?id=' + selectedItems;
         } 
		 $.ajax({
             type: "POST",
             url: URL,
             data: $('#firmPracticeType').serialize(),
             success: function (data) {
                 if (data) {
                	 $('#getTax').dataTable().fnDraw();
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
	function editTaxType(entityKey){
		$('#taxTypeFoo').load('manageTaxModule.do?entityKey='+entityKey);
		$('#taxTypeTabs a:last').tab('show');
		$('#taxTypeFoo').show();
		$('#taxTypehome').hide();
	}
</script>
