<%@ include file="../../layout/PM-INCLUDES.jsp" %>

<!-- <style>
    .error {
        color: red;
    }

    .errorblock {
        color: #000;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin: 5px;
        padding: 5px;
        width: auto;
    }
</style>
<style type="text/css">
    .jurisdiction fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin-bottom: 20px;
        padding: 5px;
        width: 40em;
    }

    div.error_container ol li {
        list-style-type: disc;
        margin-left: 20px;
    }

    div.error_container {
        display: none
    }

    .error_container label.error {
        display: inline;
    }

    form.jurisdiction {
        width: 30em;
    }

    form.jurisdiction label.error {
        display: block;
        margin-left: 1em;
        width: auto;
    }

    input:focus {
        border: 1px dotted black;
    }

    select:focus {
        border: 1px dotted black;
    }

    input.error {
        border: 1px solid red;
    }

    select.error {
        border: 1px solid red;
    }

    label.error {
        /* remove the next line when you have trouble in IE6 with labels in list */
        color: red;
        font-style: italic
    }
</style> -->
<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
    <button data-role='button' data-theme='a' data-action="delete" id="deleteIts">Delete</button>
</div>
<c:url value="/mobileadmin/EditMobileAdminJurisdiction.do" var="mobileJurisdictionModuleUrl">
    </c:url>
<a href="<c:out value='${mobileJurisdictionModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="showform" onclick="showform()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Jurisdiction</span>
	                    	</button> 
	                	</a>
	                	<div id="confirmDeltin" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> Delete Estimates</span>
    </div>
    <div class="modal-body">
        <span class="f12em">The selected estimates will be deleted. Deleted estimates can be restored again, worry not. Do you want to continue?</span>

    </div>
    <div class="modal-footer">
        <span id="deleteConfrmd" data-action="deleteConfrmd" class="btn btn-success">Yes</span>
        <span data-dismiss="modal" class="btn btn-success">Cancel</span>
    </div>
</div>

<div id="selectIt" class="modal" style="display: none; ">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">X</a>

        <span class="f12em b red"><i class="icon-book blue"></i> No data selected</span>
    </div>
    <div class="modal-body">
        <span class="f12em">Please select one or more rows</span>

    </div>
    <div class="modal-footer">
        <span id="selected" data-action="deletedRecord" class="btn btn-success">Ok</span>
        <!-- <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
    </div>
</div>


  <div id="grid_wrapper" style="overflow:auto;">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getJurid">
	<caption title="" class="captionFont">Jurisdictions List</caption>
		<colgroup>
					<col style="width: 5%;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 5%;">
		</colgroup>
		<thead>
			<tr>		
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Country</th>
			  <th class="cyan b center">State/Province</th>
			  <th class="cyan b center">City</th>
			  <th class="cyan b center">Global Timezone Name</th>
			  <th class="cyan b center">GMT Deviation Hours</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">Edit</th>
			</tr>
			 <tr>
			  <th class="cyan b center" ></th>
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
	</table>

 </div>


<script>
	$(function(){
		/* var firmId = $('input[name="firmId"]').val();
		var jurisdictionId = $('input[name="jurisdictionId"]').val(); */
		//alert("di"+jurisdictionId);
	      $("#getJurid").dataTable({
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
           "bInfo": true,
           "bAutoWidth": false,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No category added. Click 'Add New' button above to get started."
           },
           "sAjaxSource": 'mobileAdminJuridList.do',
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
			                    "sWidth": "10%"
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
                       { type: "select", values: [ 'ACTIVE','INACTIVE'] }, 
                       null
                    
          ]
});
	});

	$('#deleteIts').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
        	$('#selectIt').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDeltin').modal();
        }
    });
	$('#selected').click(function(){
		$('#selectIt').modal('hide');
	}); 
    $('#deleteConfrmd').click(function () {
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());
       });
        var URL;
			if ($(this).data('action') == 'deleteConfrmd') {
            $('#confirmDeltin').modal('hide');
            URL = 'saveJurisdictions.do?id=' + selectedItems;
        }   
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#jurisdiction').serialize(),
            success: function (data) {
                if (data) {
                	$('#getJurid').dataTable().fnDraw();
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
	/* $(document).ready(function() {
		$(".colorBoxDemoJurid").colorbox({});
	}); */
	function editJurid(jurisdictionId){
		window.location = 'EditMobileAdminJurisdiction.do?id='+jurisdictionId;
    	return false;
		/* $('#jurifoo').load('EditMobileAdminJurisdiction.do?id='+jurisdictionId);
		$('#juriTabs a:last').tab('show');
		$('#jurihome').hide();
		$('#jurifoo').show(); */
	}
</script>

<!--      GRID PLACEHOLDER Ids
<div class="well">
	<div id="grid_wrapper">
		<table id="toolbar"></table>
		<div id="ptoolbar" class="scroll"></div>
	</div>
</div>
<script type="text/javascript">
		
		jQuery(document).ready(function(){
			var firmId = $("#firmId").val();
			var clientId = $("#clientId").val();
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";

			var mygrid = jQuery("#toolbar").jqGrid({
			     url:'jurisdictionsList.do?firmId='+firmId,
				 datatype: 'json', 
				 height : 300,
				 mtype: 'GET', 
				 colNames:['ID','Country', 'State/Province', 'City', 'Global Timezone Name','GMT Deviation Hours', 'Status', 'Edit'],
				   	colModel:[
				   		{name:'id',index:'id', width:50, editoptions:{readonly:true, size:10}},
				   		{name:'country',index:'country', width:200, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'state',index:'state', width:200,formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminJurisdiction.do', 
								idName:'id'}},
				   		{name:'city',index:'city', width:200, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'globalTimezoneName',index:'globalTimezoneName', width:200, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'gmtDeviationHours',index:'gmtDeviationHours', width:200, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'status',index:'status', width:50, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
				   		 	formatter:'select', stype: 'select', sorttype:
				   		 	function(cell) {return status[cell];},
				   		 edittype:'select', editoptions: { value: statusStr }, 
				   		searchoptions:{ sopt:['eq'] }},
				   		{name:'id', index:'id', search:false, width:50, formatter: juridEdit}
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
			      gridComplete: function(){
			  		var ids = jQuery("#toolbar").jqGrid('getDataIDs');
			  		for(var i=0;i < ids.length;i++){
			  			var cl = ids[i];
			  			var closeJs = "setJurisdictionAndClose("+ cl+ ");";
			  			be = "<input style='height:22px;width:100px;' type='button' value='Select' onclick="+closeJs+"  />"; 
			  			jQuery("#toolbar").jqGrid('setRowData',ids[i],{act:be});
			  		}	
			  	},
			      	rowNum:10,
				   	rowList:[10,20,30],
					loadonce:true,
				   	mtype: "GET",
					rownumbers: false,
					rownumWidth: 40,
					gridview: true,
				   	pager: '#ptoolbar',
				   	sortname: 'country',
				    viewrecords: true,
				    autowidth : true,
				   // onSelectRow: neweditrow,
				    sortorder: "asc",
				    caption: 'Jurisdictions List',
				    editurl:'<c:url value="/appadmin/saveJurisdictions.do"/>'
				});
			 jQuery("#toolbar").jqGrid('navGrid','#ptoolbar',{del:true,add:false,edit:false,search:false});
			jQuery("#toolbar").jqGrid('navButtonAdd',
					"#ptoolbar", {
						caption : "Apply Filter",
						title : "Toggle Search Toolbar",
						buttonicon : 'ui-icon-pin-s',
						onClickButton : function() {
							mygrid[0].toggleToolbar();
						}
					});
			jQuery("#toolbar").jqGrid('filterToolbar', {
				stringResult : true,
				searchOnEnter : false
			}); 
				
		});
		
		 // resize the grid if needed
				
		
				 function juridEdit(cellvalue, options, rowObject) {
						return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editJurid(&quot;" + cellvalue + "&quot;)'>edit</a>";
						}

						function editJurid(jurisdictionId){
							$('#jurifoo').load('adminJurisdiction.do?id='+jurisdictionId);$('#juriTabs a:last').tab('show');
						}
						
						 function neweditrow(cellvalue){ var id = cellvalue; $('#jurifoo').load('adminJurisdiction.do?id='+id);$('#juriTabs a:last').tab('show');}
		</script>
		 END BUCKET -->