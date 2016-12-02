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

.adminTools{
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
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getFirm">
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

 </div>
</div>

<script>
	$(function(){
	      $('#getFirm').dataTable({
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
           "sDom": '<"H"<"adminTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'firmList.do',
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
	      $("div.adminTools").html('<button type="submit" class="btn" data-action="delete" id="deleteFirm"> <i class="icon-trash icon-white"></i> </button>');
				});
	
	$ (function () {
	$('#deleteFirm').click(function () {
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
                	$('#getFirm').dataTable().fnDraw();
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
		$('#firmfoo').load('adminFirmModule.do?id='+partyId);
		$('#firmTabs a:last').tab('show');
		$('#firmhome').hide();
		$('#firmfoo').show();
	}
</script>

 <!--  GRID PLACEHOLDER Ids -->
<%-- <div class="well">
<div id="grid_wrapper" >
     <input type="hidden" name="party" id="party" value="${party}"/>	
  	<input type="hidden" name="partyId" id="partyId" value="${party.id}"/>
	<table id="listAdmin"></table>
	<div id="adminPager" class="scroll"></div>
</div>
</div>
<script type="text/javascript">
var status = ["All", "Active", "Inactive"];
var statusStr = ":All;Active:Active;Inactive:Inactive";
jQuery(document).ready(function(){ 
	firmId = $("#firmId").val();
	partyId = $("#partyId").val();	
	var mygrid = jQuery("#listAdmin").jqGrid({
		url:'firmList.do?partyId='+partyId,
        datatype : 'json',
		height : 300,
		mtype : 'GET',
		colNames:['Name', 'Office Number','Home Number','Email Address', 'Status', 'Edit'],
		colModel :[
				{name:'name', index:'name',  formatter: 'showlink',formatter:adminSelect, formatoptions: {baseLinkUrl: 'adminFirmModule.do', idName:'id'}},
				{name:'officeNumber', index:'officeNumber'},
				{name:'homeNumber', index:'homeNumber'},
				{name:'emailAddress', index:'emailAddress'},
				{name:'status',index:'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
		   		 	formatter:'select', stype: 'select', sorttype:
			   		 	function(cell) {return status[cell];},
			   		 edittype:'select', editoptions: { value: statusStr }, 
			   		searchoptions:{ sopt:['eq'] }},
			   	{name:'id', index:'id', search:false, width:40, formatter: adminEdit}
	    ],
		jsonReader : {
			root: "rows",
			page: "page",
			total: "total",
			records: "records",  
			repeatitems: false,
			cell: "cell",
			id: "id",
			userdata: "userdata"  
			},
			pager: jQuery('#adminPager'),
			rowNum:10,
		//	loadonce:true,
			rowList:[10,25,50],
			sortname: 'firstName',
			sortorder: 'asc',
			viewrecords: true,
			autowidth: false,
			onSelectRow: neweditrow,
			caption: 'Firm List',
			editurl:'saveClientAjaxList.do?firmId='+firmId 
			});

	  jQuery("#listAdmin").jqGrid('navGrid','#adminPager',{del:true,add:false,edit:false,search:false});
	  jQuery("#listAdmin").jqGrid('navButtonAdd',"#adminPager",{caption:"Apply Filter",title:"Toggle Search Toolbar", buttonicon :'ui-icon-pin-s', 
		  onClickButton:function(){ 
		  	mygrid[0].toggleToolbar()
		  } 
	  }); 
	  jQuery("#listAdmin").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});	
		// resize the grid if needed
		 $(window).bind('resize', function() {
			jQuery("#listAdmin").setGridWidth($('#grid_wrapper').width()-5, true);
			}).trigger('resize');
		 
		 $(window).bind('load', function() {
				jQuery("#listAdmin").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('load');	
});

function adminEdit(cellvalue, options, rowObject) {
	return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editAdmin(&quot;" + cellvalue + "&quot;)'>edit</a>";
	}

function adminSelect(cellvalue, options, rowObject) {
	return"<a style='text-decoration: underline; cursor: pointer;'  href='javascript:editAdmin(&quot;" + rowObject.id + "&quot;)'>"+rowObject.name+"</a>";
	}
	function editAdmin(partyId){
		//alert(partyId);
		$('#firmfoo').load('adminFirmModule.do?id='+partyId);
		$('#firmTabs a:last').tab('show');
	}
function neweditrow(cellvalue){ var id = cellvalue;  $('#firmfoo').load('adminFirmModule.do?id='+id);$('#firmTabs a:last').tab('show');}
</script> --%>