<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<style>
.tempTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>
<div id="confming" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="delConfirmed" data-action="delConfirmed" class="btn btn-success">Yes</span>
        <span class="btn btn-success" data-dismiss="modal">Cancel</span>
    </div>
</div>
<div id="selectRecod" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="seletdRecord" data-action="deleteConfirmed" class="btn btn-success">Ok</span>
    </div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;"> 
<div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getTemplate">
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
			  <th class="cyan b center">Subject</th>
			  <th class="cyan b center">Body Text</th>
			  <th class="cyan b center">Admin EmailId</th>
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
	   $("#getTemplate").dataTable({
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
           "sDom": '<"H"<"tempTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'taskNotificationTemplateList.do',
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
	   $("div.tempTools").html('<button type="submit" class="btn" data-action="delete" id="deleteTemp"> <i class="icon-trash icon-white"></i> </button>');
	});

	$(function() {
	$('#deleteTemp').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#selectRecod').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confming').modal();
        }
    });
	});
	$('#seletdRecord').click(function(){
		$('#selectRecod').modal('hide');
	}); 
    $('#delConfirmed').click(function () {
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
        var URL;
			if ($(this).data('action') == 'delConfirmed') {
            $('#confming').modal('hide');
            URL = 'saveTaskNotificationTemplate.do?id=' + selectedItems;
        }   
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#taskNotificationTemplate').serialize(),
            success: function (data) {
                if (data) {
                	$('#getTemplate').dataTable().fnDraw();
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
		$(".colorBoxDemoTemplate").colorbox({});
	}); */
	function editTemplate(partyId){
		$('#templatefoo').load('adminTaskNotificationTemplate.do?id='+partyId);
		$('#templateTabs a:last').tab('show');
		$('#templatehome').hide();
		$('#templatefoo').show();
		}
</script>

<!--      GRID PLACEHOLDER Ids
<div class="well">
	<div id="grid_wrapper">
		<table id="templateGrid"></table>
		<div id="templatePager" class="scroll"></div>
	</div>
</div>
<script type="text/javascript">
var status = ["All", "Active", "Inactive"];
var statusStr = ":All;Active:Active;Inactive:Inactive";
jQuery(document).ready(function(){
	var firmId = $("#firmId").val();
	
		var mygrid = jQuery("#templateGrid").jqGrid({
		    url:'taskNotificationTemplateList.do',
		    datatype: 'json',
		  
			height :'100%',
			mtype : 'GET',
		    colNames:['Subject', 'Body Text', 'Admin EmailId', 'Status','Edit'],
		    colModel :[ 
				{name:'subject', index:'subject',formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminTaskNotificationTemplate.do', 
						idName:'id'}},
				{name:'bodyText', index:'bodyText'},
				{name:'adminEmailId', index:'adminEmailId'},
				{name:'status', index:'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
		   		 	formatter:'select', stype: 'select', sorttype:
			   		 	function(cell) {return status[cell];},
			   		 edittype:'select', editoptions: { value: statusStr }, 
			   		searchoptions:{ sopt:['eq'] }},
			   	{name:'id', index:'id', search:false, width:20, formatter:templateEdit}
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
		    pager: jQuery('#templatePager'),
		    rowNum:10,
		    rowList:[10,25,50],
		    loadonce:true, 
            sortname: 'globalTaskNotificationTemplateName',
		    sortorder: 'asc',
		    viewrecords: true,
		    onSelectRow: neweditrow,
		    autowidth:  false,
		    caption: 'Task Notification Template List',
		    editurl:'<c:url value="/appadmin/saveTaskNotificationTemplate.do"/>'
		  });

		  jQuery("#templateGrid").jqGrid('navGrid','#templatePager',{del:true,add:false,edit:false,search:false});
		  jQuery("#templateGrid").jqGrid('navButtonAdd',
					"#templatePager", {
						caption : "Apply Filter",
						title : "Toggle Search Toolbar",
						buttonicon : 'ui-icon-pin-s',
						onClickButton : function() {
							mygrid[0].toggleToolbar();
						}
					});
			jQuery("#templateGrid").jqGrid('filterToolbar', {
				stringResult : true,
				searchOnEnter : false
			});
		});
	
		//resize the grid if needed
		$(window).bind('resize', function() {
			jQuery("#templateGrid").setGridWidth($('#grid_wrapper').width()-5, true);
			}).trigger('resize');
		
		$(window).bind('load', function() {
				jQuery("#templateGrid").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('load');	
		
		function templateEdit(cellvalue, options, rowObject) {
			return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editTemplate(&quot;" + cellvalue + "&quot;)'>edit</a>";
		}

		function editTemplate(partyId){
			$('#templatefoo').load('adminTaskNotificationTemplate.do?id='+partyId);$('#templateTabs a:last').tab('show');
			}
function neweditrow(cellvalue){ var id = cellvalue; $('#templatefoo').load('adminTaskNotificationTemplate.do?id='+id);$('#templateTabs a:last').tab('show');}
</script>

 -->