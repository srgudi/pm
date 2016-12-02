<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %> --%>
<style>
.clientMobile{
    float: left;
    width: 50px;
    margin-left: -14px;
    background-color: #ffffff;
}
</style>

<!-- <div class="container_12 mt15 mb15 gridWrap"> -->
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />

<div>
<!-- DataTable -->
<!-- <div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteRecord">Delete</button>
</div> -->
<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a id="viewClienteditForm" style="text-decoration:none;">
	                    	 <button type="button" id="viewClienteditForm"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Client</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
			
	  </security:authorize> 
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
<script type="text/javascript">
$(function() {
    $("#viewClienteditForm").click(function() {
        $.mobile.changePage("../mobileclient/mobileClientDetail.do","slideup");
    });        
});
</script> 
 
  <div id="grid_wrapper" style="overflow:auto;">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllClient">
	<caption title="" class="captionFont">Client List</caption>
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
			  <th class="cyan b center">Client ID</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Partner-In-Charge</th>
			  <th class="cyan b center">Office Contact</th>
			  <th class="cyan b center">Email</th>
			  <th class="cyan b center">Edit</th>
			  <th class="cyan b center">Manage</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<input type="hidden" name="inValidClientId" id="firmId" value="${firmId}" />
		<!-- <table id="taskGridlist"></table>
	 	<div id="pager" class="scroll"></div> -->
 </div>

<script>
	
	$(function() {
		$("#getAllClient")
				.dataTable(
						{
							"fnPreDrawCallback": function () {
					               return true;
					           },
					           "fnDrawCallback": function () {
					        	   
					           },
							"bJQueryMobileUI" : true,
							"bFilter" : true,
							  "sDom": '<"H"<"clientMobile">lpir>t', 
							"sPaginationType" : "bootstrap",
							"aaSorting" : [ [ 0, "desc" ] ],
							"bInfo" : true,
							"oLanguage" : {
								//"sLengthMenu" : "_MENU_ records per page",
								"sProcessing" : "Loading.....",
								"sZeroRecords" : "No client is found. Click 'Add/Edit' tab to get started."
							},
							"sAjaxSource" : 'mobileClientList.do',
							"bProcessing" : 'true',
							"bServerSide" : 'true',
							"bDeferRender" : 'false',
							"bPaginate": true,
							"oTableTools" : {
								"sRowSelect" : "single"
							},
							"aoColumns" : [
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
											return retVal;
										}
									}, {
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[1];
										}
									}, {
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[2];
										}
									}, {
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[3];
										}
									}, {
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[4];
										}
									}, {
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[5];
										}
									}, {
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[6];
										}
									} ]
						});
		$("div.clientMobile").html('<button type="submit" class="btn" data-action="delete" id="deleteRecord"> <i class="icon-trash icon-white"></i> </button>');
	});

	$(function(){
	$('#deleteRecord').click(function() {
		var selectedItems = [];
		$('input[name="selectGridRow"]:checked').each(function() {
			selectedItems.push($(this).val());
		});
		if (selectedItems.length == 0) {
			$('#selectDelRow').modal();
		} else if ($(this).data('action') == 'delete') {
			$('#confirmDeleteRec').modal();
		}
	});
	});
	$('#selectedRecord').click(function() {
		$('#selectDelRow').modal('hide');
	});
	$('#deletedRecord').click(function() {

		var selectedItems = [];
		$('input[name="selectGridRow"]:checked').each(function() {
			selectedItems.push($(this).val());

		});
		var URL;
		if ($(this).data('action') == 'deletedRecord') {
			$('#confirmDeleteRec').modal('hide');
			URL = 'saveClientAjaxList.do?id=' + selectedItems;
		}

		$.ajax({
			type : "POST",
			url : URL,
			data : $('#organization').serialize(),
			success : function(data) {
				if (data) {
					$('#getAllClient').dataTable().fnDraw();
					$.jGrowl('Record Deleted Sucessfully');
				} else {
					$.pnotify({
						title : 'Error',
						text : 'Please contact system support with details.',
						type : 'error',
						animation : 'fade'
					});
				}
			},
			error : function() {
				$.pnotify({
					title : 'Error',
					text : 'Error occurred during operation',
					type : 'error',
					animation : 'fade'
				});
			}
		});

	});

</script>
</div>
<script>	
	function manageClient(partyId){
			window.location='mobilecStaff.do?clientId='+partyId;
			return false;
		}
	function editClient(partyId){
		window.location='mobileClientDetail.do?clientId='+partyId;
		return false;
	}
</script>

