<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<style>
.ctTools{
    float: left;
    width: 50px;
    margin-left: -14px;
}
</style>

<div id="confirmDeltn" class="modal" style="display: none;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
			class="icon-book blue"></i> Delete Estimates</span>
	</div>
	<div class="modal-body">
		<span class="f12em">The selected estimates will be deleted.
			Deleted estimates can be restored again, worry not. Do you want to
			continue?</span>

	</div>
	<div class="modal-footer">
		<span id="deleteConfmd" data-action="deleteConfmd"
			class="btn btn-success">Yes</span> <span class="btn btn-success"
			data-dismiss="modal">Cancel</span>
	</div>
</div>
<div id="selectRecord" class="modal" style="display: none;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
			class="icon-book blue"></i> No data selected</span>
	</div>
	<div class="modal-body">
		<span class="f12em">Please select one or more rows</span>

	</div>
	<div class="modal-footer">
		<span id="selectedRecord" data-action="deleteConfirmed"
			class="btn btn-success">Ok</span> 
	</div>
</div>
<div class="yui3-u-19-24" style="margin-left: 2px;">
	<div style="width: 120%;">
		<div id="grid_wrapper">
			<table border="0"
				class="table table-striped table-hover table-bordered mb20"
				id="getCodeType">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 25%;">
					<col style="width: 35%;">
					<!-- <col style="width: 10%;"> -->
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
				</colgroup>
				<thead>
					<tr>
						<th class="cyan b center">ID</th>
						<th class="cyan b center">Name</th>
						<th class="cyan b center">Description</th>
						<!--  <th class="cyan b center">Parent CodeType Name</th> -->
						<th class="cyan b center">Application Level Indicator</th>
						<th class="cyan b center">Status</th>
						<th class="cyan b center">Edit</th>
					</tr>
					<tr>
						<th class="cyan b center"></th>
						<th class="gridFilter"></th>
						<th class="gridFilter"></th>
						<!--  <th class="cyan b center"></th> -->
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
	      $("#getCodeType").dataTable({
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
           "sDom": '<"H"<"ctTools">lpir>t',
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'codeTypeList.do',
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
                         /* {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[3];
                             }
                         }, */
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
                            	/*  var demoTaskPage = '<a class="colorBoxDemoCodeType cboxElement" href="/pm-new/appadmin/adminCodeTypeColor.do?id=' + obj.aData[0] +'">Edit</a>';
                                 return demoTaskPage; */
                             }
                         }
                     ]
	   }).columnFilter({ sPlaceHolder: "head:after",
           aoColumns: [  
                       null,
                       { type: "text"},
                       { type: "text"},
                       { type: "select", values: [ 'true','false'] }, 
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
}); 
	      $("div.ctTools").html('<button type="submit" class="btn" data-action="delete" id="deleteCt"> <i class="icon-trash icon-white"></i> </button>');
	});

	$(function() {
	$('#deleteCt').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#selectRecord').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeltn').modal();
        }
    });
	});
	$('#selectedRecord').click(function(){
		$('#selectRecord').modal('hide');
	}); 
    $('#deleteConfmd').click(function () {
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
        var URL;
			if ($(this).data('action') == 'deleteConfmd') {
            $('#confirmDeltn').modal('hide');
            URL = 'saveCodeType.do?id=' + selectedItems;
        }   
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#codeType').serialize(),
            success: function (data) {
                if (data) {
                	$('#getCodeType').dataTable().fnDraw();
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
/* 	$(document).ready(function() {
		$(".colorBoxDemoCodeType").colorbox({});
	}); */
	function editcodeType(partyId){
		 $('#codeTypefoo').load('adminCodeType.do?id='+partyId);
		 $('#codeTypeTabs a:last').tab('show');
		 $('#codeTypehome').hide();
	     $('#codeTypefoo').show();
		}
</script>

<!--      GRID PLACEHOLDER Ids
    <div class="well">
    		<div id="grid_wrapper">
			<table id="codeTypeGrid"></table>
			<div id="codeTypePager" class="scroll"></div>
		</div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
			jQuery(document)
					.ready(
							function() {
								firmId = $("#firmId").val();
								var mygrid = jQuery("#codeTypeGrid")
										.jqGrid(
												{
													url : 'codeTypeList.do',
													datatype : 'json',
													height : 300,
													mtype : 'GET',
													colNames : ['Name', 'Description', 'Parent CodeType Name', 'Application Level Indicator', 'Status','Edit' ],
													colModel : [
															{
																name : 'name',
																index : 'name',
																
																formatter : 'showlink',
																formatter:codeTypeSelect,
																formatoptions : {
																	baseLinkUrl : '/adminCodeType.do',
																	idName : 'id'
																}
															},
															{
																name : 'description',
																index : 'description'
															},
															{
																name : 'parentCodeTypeName',
																index : 'parentCodeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'status',
																index : 'status',width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
													   		 	formatter:'select', stype: 'select', sorttype:
														   		 	function(cell) {return status[cell];},
														   		 edittype:'select', editoptions: { value: statusStr }, 
														   		searchoptions:{ sopt:['eq'] }
														   	},
														   	{
														   		name : 'id',
														   		index: 'id',
														   		search: false,
														   		width: 40,
														   		formatter: codeTypeEdit
														   	}
															 ],
													jsonReader : {
														root : "rows",
														page : "page",
														total : "total",
														records : "records",
														repeatitems : false,
														cell : "cell",
														id : "id",
														userdata : "userdata"
													},
													pager : jQuery('#codeTypePager'),
													rowNum : 10,
													loadonce : true,
													rowList : [ 10, 25, 50 ],
													sortname : 'globalCodeTypeName',
													sortorder : 'asc',
													viewrecords : true,
													autowidth : false,
													caption : 'CodeType List',
													rownumbers : false,
													onSelectRow: neweditrow,
													rownumWidth : 40,
													gridview : true,
													caption : 'Code Type List88888888',
													editurl : '<c:url value="/appadmin/saveCodeType.do"/>'
												});

								jQuery("#codeTypeGrid").jqGrid('navGrid', '#codeTypePager', {
									del : true,
									add : false,
									edit : false,
									search : false
								});
								jQuery("#codeTypeGrid").jqGrid('navButtonAdd',
										"#codeTypePager", {
											caption : "Apply Filter",
											title : "Toggle Search Toolbar",
											buttonicon : 'ui-icon-pin-s',
											onClickButton : function() {
												mygrid[0].toggleToolbar();
											}
										});
								jQuery("#codeTypeGrid").jqGrid('filterToolbar', {
									stringResult : true,
									searchOnEnter : false
								});
							});
			
			 				// resize the grid if needed
						 $(window).bind('resize', function() {
							jQuery("#codeTypeGrid").setGridWidth($('#grid_wrapper').width()-5, true);
							}).trigger('resize');
						 
						 $(window).bind('load', function() {
								jQuery("#codeTypeGrid").setGridWidth($('#grid_wrapper').width()-5, true);
								}).trigger('load');
						 
						 function codeTypeEdit(cellvalue, options, rowObject){
							 return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editcodeType(&quot;" + cellvalue + "&quot;)'>edit</a>";
						 }
						 function codeTypeSelect(cellvalue, options, rowObject) {
							 return"<a style='text-decoration: underline; cursor: pointer;' href='javascript:coTyEdit(&quot;" + rowObject.id + "&quot;)'>"+rowObject.name+"</a>";
				         }
						 function editcodeType(partyId){
							 $('#codeTypefoo').load('adminCodeType.do?id='+partyId);$('#codeTypeTabs a:last').tab('show');
							}
						 
						 function neweditrow(cellvalue){ var id = cellvalue; $('#codeTypefoo').load('adminCodeType.do?id='+id);$('#codeTypeTabs a:last').tab('show');}
						 
						 function coTyEdit(id) {
					  			$('#codeTypefoo').load('adminCodeType.do?id='+id);
					  			$('#codeTypeTabs a:last').tab('show');
					          }  
						 
		</script>

 
 -->