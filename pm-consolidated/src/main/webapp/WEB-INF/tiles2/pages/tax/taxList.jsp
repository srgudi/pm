<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
 input, textarea {
width: 105px;
} 
select {
width: 105px;
}
.taxTools{
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
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfirmed" data-action="deleteConfirmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
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
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />

<!-- DataTable -->
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getTaxList">
		<colgroup>
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Jurisdiction</th>
			  <th class="cyan b center">Staff In Charge</th>
			  <th class="cyan b center">Client Staff In-Chager</th>
			  <th class="cyan b center">Tax Return Type</th>
			  <th class="cyan b center">Tax Creator</th>
			  <th class="cyan b center">Tax created Date</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>
			  <th class="cyan b center"></th>
			  <th class="gridFilter">Client Name</th>
			  <th class="gridFilter">Jurisdiction</th>
			  <th class="gridFilter">Staff In Charge</th>
			  <th class="gridFilter">Client Staff In-Chager</th>
			  <th class="gridFilter">Tax Return Type</th>
			  <th class="gridFilter">Tax Creator</th>
			  <th class="gridFilter">Tax created Date</th>
			  <th class="gridFilter">Status</th>
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
		var clientId = ${clientId};
		/* var firmPracticeId = ${firmPracticeId};
		console.debug(firmPracticeId); */
	   $("#getTaxList").dataTable({
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
           "sPaginationType": "bootstrap",
           "sDom": '<"H"<"taxTools">lpir>t',
           "bInfo": true,
           "bAutoWidth": false,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No Taxes Have been added. Click 'Tax Add/Edit' button above to get started."
           },
           "sAjaxSource": 'taxModuleList.do?clientId=' + clientId,
           "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
           "bRetrieve": 'true',
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
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[8];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                            	 return obj.aData[9];
                             }
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "text"},
	                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
	                      null
	                    
	          ]
	});
	   $("div.taxTools").html('<button type="submit" class="btn" data-action="delete" id="deleteItems"> <i class="icon-trash icon-white"></i> </button>');
		});

	$(function () {	
	$('#deleteItems').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#selectRow').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeleting').modal();
        }
    });
	});
	$('#selectConfirmed').click(function(){
		$('#selectRow').modal('hide');
	});
    $('#deleteConfirmed').click(function () {
    	var clientId = ${clientId};
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deleteConfirmed') {
            $('#confirmDeleting').modal('hide');
           // URL = 'deleteBank.do?id=' + selectedItems+ '&clientId' + clientId + '&accountCategory=700';
            URL = 'saveTaxModuleList.do?id=' + selectedItems+ '&clientId' + clientId;
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#clientPracticeInfo').serialize(),
            success: function (data) {
                if (data) {
                	$('#getTaxList').dataTable().fnDraw();
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
</div>
<script>
	/* $(document).ready(function() {
		$(".colorBoxDemotax").colorbox({});
	}); */
	function TaxEdit(id){
		 // alert(id);
			var clientId = ${clientId};
			/* var firmPracticeId = ${firmPracticeId}; */
		//	alert(clientId);
		$('#update').load('taxModule.do?id='+id+'&clientId='+clientId);
		$('#mainTaxTabs a:last').tab('show');
	 }
</script>

<%-- 
    <!-- BUCKET -->
		<div class="well">
			<div id="grid_wrapper">
			<input type="hidden" name="clientId" id="clientId" value="${clientId}"/>
            <input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${firmPracticeId}"/>
				<table id="TaxGrid"></table>
				<div id="pager" class="scroll"></div>
			</div>
		</div>

<script type="text/javascript">
jQuery(document).ready(function() {
    var clientId = $("#clientId").val();
    var firmPracticeId = $("#firmPracticeId").val();

    var mygrid = jQuery("#TaxGrid").jqGrid({
        url:'taxModuleList.do?clientId=' + clientId + '&firmPracticeId=' + firmPracticeId,
        height:300,
        datatype: 'json',
        mtype: 'GET',
        colNames:['ID','Client Name','Jurisdiction','Staff In Charge','Client Staff In-Chager', 'Tax Return Type','Tax Creator','Tax created Date', 'Status'],
        colModel :[
            {name:'clientPracticeInfoId', index:'clientPracticeInfoId',  width:15},
            {name:'clientName', index:'clientName',  width:40,formatter: 'showlink', formatoptions: {baseLinkUrl: 'taxModule.do',
                idName:'id', addParam:'&clientId=' + clientId + '&firmPracticeId=' + firmPracticeId}},
            {name:'jurisdictionName', index:'jurisdictionName',  width:60},
            {name:'staffInChargeName', index:'staffInChargeName',  width:60},
            {name:'clientStaffInChargeName', index:'clientStaffInChargeName',  width:60},
            {name:'taxReturn', index:'taxReturn',  width:60},
            {name:'taskCreator', index:'taskCreator',  width:80},
            {name:'formatedtaskCreatedDate', index:'formatedtaskCreatedDate',  width:60},
            {name:'status',index:'status', width:40}
        ],
        jsonReader : {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: false,
            cell: "cell",
            id: "clientPracticeInfoId",
            userdata: "userdata"
        },
        pager: jQuery('#pager'),
        rowNum:10,
      //  loadonce : true,
        rowList:[10,25,50],
        sortname: 'name',
        sortorder: 'asc',
        viewrecords: true,
        //onSelectRow: neweditrow,
        autowidth: true,
        caption: 'Tax List',
        editurl:'saveTaxModuleList.do'
    });
   
		jQuery("#TaxGrid").jqGrid('navGrid', '#pager', {
			del : true,
			add : false,
			edit : false,
			search : false
		});
	
	jQuery("#TaxGrid").jqGrid('navButtonAdd',
			"#pager", {
				caption : "Apply Filter",
				title : "Toggle Search Toolbar",
				buttonicon : 'ui-icon-pin-s',
				onClickButton : function() {
					mygrid[0].toggleToolbar();
				}
	    
			});
	 
    jQuery("#TaxGrid").jqGrid('filterToolbar', {stringResult: true,searchOnEnter : false});
    $(window).bind('resize',
            function() {
                jQuery("#TaxGrid").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

    $(window).bind('load',
            function() {
                jQuery("#TaxGrid").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load');
    
    function neweditrow(cellvalue){ $('#edit').load('taxModule.do?clientId='+clientId+'&firmPracticeId='+firmPracticeId);$('#mainTaxTabs a:last').tab('show');}
});
</script> --%>