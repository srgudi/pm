<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ page isELIgnored="false" %> 

 <c:url value="/mobileclient/mobileclientLocation.do" var="mobileLocationModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
</c:url> 

<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteItem">Delete</button>
</div>
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
       <!--  <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
    </div>
</div>

<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="<c:out value='${mobileLocationModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showLocationForm" onclick="showLocationForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Location</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
</security:authorize>  
	  
<div id="grid_wrapper" style="overflow:auto;">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllLoc" >
	        <caption title="" class="captionFont">Location List</caption>
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
			  <th class="cyan b center"></th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Type</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Home Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center"></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<input type="hidden" name="inValidClientId" id="firmId" value="${firmId}" />
	
 </div>

<script>
	$(function(){
		var clientId = ${clientId};
	var oTable =   $("#getAllLoc").dataTable({
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
		"sAjaxSource" : 'mobileLocationList.do?clientId='+clientId,
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
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[2];
										}
									},
									{
										"bSortable" : false,
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
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[7];
										}
									}]
						});
	   
	});

	$('#deleteItem').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
       	 $('#selctRo').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeletin').modal();
        }
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
function LocationEdit(id) {
	   var clientId = ${clientId};
	   window.location = 'mobileclientLocation.do?clientId='+clientId+'&id='+id;
} 
</script>

