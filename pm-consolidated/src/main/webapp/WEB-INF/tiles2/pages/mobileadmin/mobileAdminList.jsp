<%@ include file="../../layout/PM-INCLUDES.jsp"%>
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
</style>
<!-- <div id="yui-g" style="text-align:right;margin-right:2px;"> -->
<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteItems">Delete</button>
    </div> 
<c:url value="/mobileadmin/mobileAdminFirmModule.do" var="mobileAdminFirmModuleUrl">
    </c:url>
    
    <a href="<c:out value='${mobileAdminFirmModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showform" onclick="showform()"	                    	 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Firm</span>
	                    	</button> 
	</a>

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
<div id="selectItems" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="seletConfirmed" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<br/>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 100%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getFirmMobile">
	<caption title="" class="captionFont">Firm List</caption>
		<colgroup>
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Name</th>
			  <th class="cyan b center">Office Number</th>
			  <th class="cyan b center">Home Number</th>
			  <th class="cyan b center">Email Address</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			 <tr>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			  <th class="cyan b center"></th>
			</tr> 
		</thead>
		<tbody></tbody>
		<!-- <tfoot>
		<tr>
			<th></th>
			<th>Name</th>
			<th>Office Number</th>
			<th>Home Number</th>
			<th>Email Address</th>
			<th>Status</th>
			<th></th>
		</tr>
	</tfoot> -->
		
	</table>

 </div>
</div>

<script>
	$(function(){
		/* var firmId = $('input[name="firmId"]').val();
		var partyId = $('input[name="partyId"]').val(); */
		//alert("di"+partyId);
	      $('#getFirmMobile').dataTable({
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
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'mobileFirmList.do',
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
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});

	});
	$('#deleteItems').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#selectItems').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeleting').modal();
        }
    });
	$('#seletConfirmed').click(function(){
		$('#selectItems').modal('hide');
	});
    $('#deleteConfirmed').click(function () {
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
        var URL;
			if ($(this).data('action') == 'deleteConfirmed') {
            $('#confirmDeleting').modal('hide');
            URL = 'saveClientAjaxList.do?id=' + selectedItems;
        }   
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#party').serialize(),
            success: function (data) {
                if (data) {
                	$('#getFirmMobile').dataTable().fnDraw();
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
	/* $(document).ready(function() {
		$(".colorBoxDemoFirmList").colorbox({});
	}); */
	function editAdmin(partyId){
		//alert(partyId);
		window.location = '/pm-new/mobileadmin/mobileAdminFirmModule.do?id=' + partyId;
		return false;
	}
</script>
	                	

<!--  <div id="grid">	
<div id="grid_wrapper">
	<table id="mobileFirmList"></table>
	<div id="firmPager" class="scroll"></div>
</div>

<script type="text/javascript">
var status = ["All", "Active", "Inactive"];
var statusStr = ":All;Active:Active;Inactive:Inactive";

	firmId = $("#firmId").val();
	partyId = $("#partyId").val();				
	
	 jQuery("#mobileFirmList").jqGrid({
		 
		 
		 "hoverrows":false,
         "viewrecords":true,
         "jsonReader": {root : "rows",
         page : "page",
         total : "total",
         records : "records",
         repeatitems : false,
         cell : "cell",
         id : "id",
         userdata : "userdata"},
         "gridview":true,
         "loadonce":true,
         "url" : 'mobilefirmList.do?partyId='+partyId,
         pager : jQuery('#pager'),
         "rowNum":10,
         "rowList" : [20,40,60],
         "sortname":"firstName",
         "height":200,
         "width" :300,
         "mtype" : "GET",
         "datatype":"json",
         caption : 'Firm List',
		colNames:['Name', 'Office Number','Home Number','Email Address', 'Status'],
		colModel :[
			{name:'name', index:'name',  width: 30, formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileAdminFirmModule.do', 
					idName:'id'}},
				{name:'officeNumber', index:'officeNumber',  width: 30},
				{name:'homeNumber', index:'homeNumber',  width: 30},
				{name:'emailAddress', index:'emailAddress',  width: 30},
				{name:'status',index:'status',width:30, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
		   		 	formatter:'select', stype: 'select', sorttype:
			   		 	function(cell) {return status[cell];},
			   		 edittype:'select', editoptions: { value: statusStr }, 
			   		searchoptions:{ sopt:['eq'] }},
	    ],
	    "pager":"#firmPager"
			});
	 
	 jQuery("#mobileFirmList").jqGrid('filterToolbar', {
         stringResult : true,
         searchOnEnter : false
     });
	 $('#firmPager').css("height", "50px");
</script>
</div> -->