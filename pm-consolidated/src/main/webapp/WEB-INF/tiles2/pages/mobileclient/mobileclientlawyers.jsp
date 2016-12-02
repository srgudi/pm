<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<c:url value="/mobileclient/mobileClientLawyer.do" var="mobileLawyerModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
</c:url>

<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="del">Delete</button>
</div>

    <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="<c:out value='${mobileLawyerModuleUrl}'/>" style="text-decoration:none;"> 
	                    	 <button type="button" id="showLawyerForm" onclick="showLawyerForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Lawyer</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp; 
			
	  </security:authorize>  
	  
<div id="confirm" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteCd" data-action="deleteCd" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="select" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selectCd" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
       <!--  <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
    </div>
</div>
<!-- BUCKET -->
  <div id="grid_wrapper" style="overflow:auto;">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllLaw">
	<caption title="" class="captionFont">Lawyers List</caption>
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
			  <th class="cyan b center">Law Firm Name</th>
			  <th class="cyan b center">Type Of Account</th>
			  <th class="cyan b center">Account Number</th>
			  <th class="cyan b center">Contact Name</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center">Edit</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<input type="hidden" name="inValidClientId" id="firmId" value="${firmId}" />
		<!-- <table id="taskGridlist"></table>
	 	<div id="pager" class="scroll"></div> -->
 </div>
	<script>
	$(function(){
		//alert("hi");
		var clientId = ${clientId};
		//var partyId = $('#partyId').val();
	   $("#getAllLaw").dataTable({
		   "bJQueryMobileUI" : true,
			"bFilter" : true,
			"sPaginationType" : "bootstrap",
			"aaSorting" : [ [ 0, "desc" ] ],
			"bInfo" : true,
			"oLanguage" : {
				"sLengthMenu" : "_MENU_ records per page",
				"sProcessing" : "Loading.....",
				"sZeroRecords" : "No client is found. Click 'Add/Edit' tab to get started."
			},
			"sAjaxSource": 'mobileAccountAjaxList.do?clientId=' + clientId + '&accountCategory=703',
			"bProcessing" : 'true',
			"bServerSide" : 'true',
			"bDeferRender" : 'false',
			"oTableTools" : {
				"sRowSelect" : "single"
			},
           "aoColumns": [
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
					                        return retVal;
					                    }
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[1];
										}
									},

									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[2];
										}
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[3];
										}
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[4];
										}
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[5];
										}
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[6];
										}
									},
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[7];
										}
									} ]
						});
	});

	$('#del').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#select').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirm').modal();
        }
    });
	$('#selectCd').click(function(){
		$('#select').modal('hide');
	}); 
    $('#deleteCd').click(function () {
    	var clientId = ${clientId};
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deleteCd') {
            $('#confirm').modal('hide');
            URL = 'saveAccountAjaxList.do?id=' + selectedItems+ '&clientId' + clientId + '&accountCategory=703';
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#lawyerPartyAccount').serialize(),
            success: function (data) {
                if (data) {
                	$('#getAllLaw').dataTable().fnDraw();
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
function editLaw(id){
     	var clientId = ${clientId};
			window.location='mobileClientLawyer.do?clientId='+clientId+'&id='+id;
		}
</script>
 
