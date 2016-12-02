<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<c:url value="/mobilefirmadmin/manageTaxModuleMobile.do" var="mobileFirmtaxTypeUrl"/> 
<div>
<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteRecord">Delete</button>
</div>
<a href="<c:out value='${mobileFirmtaxTypeUrl}'/>" style="text-decoration:none;">
<button id="showTaxform" onclick="showTaxform()"
	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	<span class="ui-button-text">New TaxType</span>
</button>
</a>

<div id="confirmDeleteRec" class="modal" style="display: none; margin-top:10">
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

<div id="selectDelRow" class="modal" style="display: none; margin-top:10">
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

<div style="width: 100%;">

<div data-role="content" style="overflow:auto;"> 
	<table cellpadding="2" cellspacing="0" border="2" class="table table-striped table-hover table-bordered mb20" id="getTax">
	<!-- <caption title="" class="captionFont">Tax Type List</caption> -->
		<colgroup>
					<col style="width: 5%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
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
			
		</thead>
		<tbody></tbody>
	</table>

 </div>
</div>
<script type="text/javascript">

var firmPracticeID = $('input[name="firmPracticeID"]').val();

var taxtable = $('#getTax').dataTable( {
	/* "bJQueryUI": true, */
	"bJQueryMobileUI" : true,
	"bLengthChange": true,
	"sAjaxSource": '/pm-new/firmadmin/manageTaxList.do',
	"bFilter": true,
    "bAutoWidth": false,
    "sInfoFiltered": " ",
    /* "aLengthMenu": [ 5, 10, 25, 50, 100 ],
    "iDisplayLength": 5, */
    "sPaginationType": "bootstrap", 
    "bInfo": true,
    "bProcessing": 'true',
    "bServerSide": 'true',
    "bDeferRender": 'false',
    "bRetrieve": 'true',
    "bDestory" : 'true',
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
              
	]/* ,
	"bDeferRender": true */
} );	
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
		URL = '/pm-new/mobilefirmadmin/saveTax.do?id=' + selectedItems;
	}

	$.ajax({
		type : "POST",
		url : URL,
		data : $('#organization').serialize(),
		success : function(data) {
			if (data) {
				$('#getTax').dataTable().fnDraw();
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
function editTaxType(entityKey) {
	window.location = '/pm-new/mobilefirmadmin/manageTaxModuleMobile.do?id=' + entityKey;
	//showTaxform();
	return false;
}
</script>
</div>