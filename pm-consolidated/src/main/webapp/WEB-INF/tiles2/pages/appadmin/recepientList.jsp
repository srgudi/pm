<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.recpTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="delPopup" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="dltConfirm" data-action="dltConfirm" class="btn btn-success">Yes</span>
        <span class="btn" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="seletRecord" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="seltdRecord" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getRecepient">
		<colgroup>
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 15%;">
					<col style="width: 20%;">
					<col style="width: 05%;">
		</colgroup>
		<thead>
			<tr>	
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Recipient</th>
			  <th class="cyan b center">Email Type</th>
			  <th class="cyan b center">Type Of Template</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			<tr>	
			  <th class="cyan b center"></th>
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
	   $("#getRecepient").dataTable({
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
           "sDom": '<"H"<"recpTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "bAutoWidth": false,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'taskNotificationRecipientList.do',
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
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	   $("div.recpTools").html('<button type="submit" class="btn" data-action="delete" id="deleteRecp"> <i class="icon-trash icon-white"></i> </button>');
});

	$(function() {
	$('#deleteRecp').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#seletRecord').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#delPopup').modal();
        }
    });
	});
	$('#seltdRecord').click(function(){
		$('#seletRecord').modal('hide');
	}); 
    $('#dltConfirm').click(function () {
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
        var URL;
			if ($(this).data('action') == 'dltConfirm') {
            $('#delPopup').modal('hide');
            URL = 'saveTaskNotificationRecipient.do?id=' + selectedItems;
        }   
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#taskNotificationRecipient').serialize(),
            success: function (data) {
                if (data) {
                	$('#getRecepient').dataTable().fnDraw();
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
		$(".colorBoxDemoRec").colorbox({});
	}); */
	function editRecepient(partyId){
		//alert(partyId);
		$('#recepientfoo').load('adminTaskNotificationRecipient.do?id='+partyId);
		$('#recepientsTabs a:last').tab('show');
		$('#recepienthome').hide();
		$('#recepientfoo').show();
		}
</script>

<!--      GRID PLACEHOLDER Ids
    <div class="well">
    	<div id="grid_wrapper" >
			<table id="recepientGrid"></table>
			<div id="recepientPager" class="scroll"></div>
		</div>
	</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
		jQuery(document).ready(function(){ 
			var firmId = $("#firmId").val();
			//alert(firmId);
			var mygrid = jQuery("#recepientGrid").jqGrid({
				url:'taskNotificationRecipientList.do?firmId='+firmId,
			    datatype: 'json',
			    
				height :300,
			    mtype: 'GET',
			    colNames:['Recipient', 'Email Type', 'Type Of Template', 'Status', 'Edit'],
			    colModel :[ 
					{name:'recipient', index:'recipient',formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminTaskNotificationRecipient.do', 
   						idName:'id'}},
					{name:'emailType', index:'emailType'},
					{name:'typeOfNotificationTemplate', index:'typeOfNotificationTemplate'},
					{name:'status', index:'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
			   		 	formatter:'select', stype: 'select', sorttype:
				   		 	function(cell) {return status[cell];},
				   		 edittype:'select', editoptions: { value: statusStr }, 
				   		searchoptions:{ sopt:['eq'] }},
				   	{name:'id', index:'id', search:false, formatter:recepientEdit}
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
			    pager: '#recepientPager',
			    rowNum:10,
			    loadonce:true,
			    rowList:[10,25,50],
			    sortname: 'name',
			    sortorder: 'asc',
			    viewrecords: true,
			    onSelectRow: neweditrow,
			    autowidth: false,
			    caption: 'Task Notification Recipient List',
			    editurl:'<c:url value="/appadmin/saveTaskNotificationRecipient.do"/>'
			  });

			  jQuery("#recepientGrid").jqGrid('navGrid','#recepientPager',{del:true,add:false,edit:false,search:false});
			  jQuery("#recepientGrid").jqGrid('navButtonAdd',
						"#recepientPager", {
							caption : "Apply Filter",
							title : "Toggle Search Toolbar",
							buttonicon : 'ui-icon-pin-s',
							onClickButton : function() {
								mygrid[0].toggleToolbar();
							}
						});
				jQuery("#recepientGrid").jqGrid('filterToolbar', {
					stringResult : true,
					searchOnEnter : false
				});
		});
		
		// resize the grid if needed
		 $(window).bind('resize', function() {
			jQuery("#recepientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
			}).trigger('resize');
		 
		 $(window).bind('load', function() {
				jQuery("#recepientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('load');	
		 
		 function recepientEdit(cellvalue, options, rowObject) {
				return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editRecepient(&quot;" + cellvalue + "&quot;)'>edit</a>";
			}

			function editRecepient(partyId){
				$('#edit').load('adminTaskNotificationRecipient.do?id='+partyId);$('#recepientsTab a:last').tab('show');
				}
			function neweditrow(cellvalue){ var id = cellvalue; $('#edit').load('adminTaskNotificationRecipient.do?id='+id);$('#recepientsTab a:last').tab('show');}
	</script>
 -->