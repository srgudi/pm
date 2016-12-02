<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<style>
input,textarea {
	width: 95px;
}
.dl {
	position: fixed;
	margin-top: -167px;
}
dt {
	width:125px;
	cursor: pointer;
	background: aliceblue;
	font-weight: bold;
	border-bottom: 1px solid #c5c5c5;
	border-top: 1px solid white;
}
#contact{
	margin-top:-25px;
	position:fixed;
    width:168px;
    height:392px;
    background: url(/pm-new/images/flashnew1.png);
    overflow:hidden;
    margin-left: -65px;
} 
select {
	width: 100px;
}
</style>
<!-- BUCKET -->
<br />
<br />
<br />
<body>
<div class="container">
	<TABLE id="contact" BORDER="0" cellpadding="20" CELLSPACING="0" >
		<script lang="javascript" type="text/javascript">
	        $(document).ready(function () {
	        	 $.get('<c:url value="/task/filesDueTodayList.do"/>',  {}, function(dataNew) {
					var rowdata = dataNew.rows;
					var original=document.getElementById("newdl");
					var dtvalue=original.cloneNode(true);
					if(rowdata.length==0){
						$("<dt></dt>",{
	                 		text:'No tasks available today'
	                 	}).appendTo('dl');
					}
	                 for (var i = 0; i < rowdata.length; i++) {
	                	 if(i<5){
		                 	var task = rowdata[i];
		                 	var taskId=task.taskId;
		                 	var tag=task.taskType+":"+task.flashFilingType;
		                 	$("<dt></dt>",{
		                 		text:tag,
		                 		id:taskId,
		                 		onClick:"window.location.href = 'taskModule.do?taskId="+taskId+"'"
		                 	}).appendTo('dl');
	                	 }
	                 }
	            }); 
	        });
	    </script>
		<TR>
			<TD id="simple">
				<dl class="dl" id="newdl">
					<dt></dt> 	
				</dl>
			</TD>
		</TR> 
	</TABLE>
</div>

<script type="text/javascript">
var clicked = false;
$("#contact").click(function() {
    if(clicked == true){
     $(this).animate({top: '60px'}, 500);
     $("#newdl").animate({top: '230px'}, 500);
        clicked = false;
    }else{
	    $(this).animate({top: '-250px'}, 500);
	    $("#newdl").animate({top: '-325px'}, 500);
	     	clicked = true;
     }
});
</script>
</body>

<div id="list"></div> 
<div id="menu-spacing" class="hide-for-medium-down nav-margin-top"></div>
	<div class="headerCap" style="margin-left: 220px;  margin-top: 10px">${firm.name}</div>
	<div class="yui3-u-19-24" style="margin-left: 220px;">
		<div class="tabbable" id="taskTabs">
			<ul class="nav nav-tabs reducedBottom" style="margin-bottom: 0px;"
				id="mainTaskTabs">
				<li class="active"><a data-target="#list" href="mainTask.do"
					onclick="window.location='mainTask.do';return false;"
					style="background-color: #F5F5F5;" class="active" data-toggle="tab">
						<i class="icon-list-ol"></i> <spring:message code="label.taskList" />
				</a>
				</li>
				<li><a data-target="#edit" href="taskModule.do"
					onclick="window.location='taskModule.do';return false;"
					data-toggle="tab"> <i class="icon-save"></i> <spring:message
							code="label.taskAddOrEdit" /> </a>
				</li>
			</ul>
		</div>

		<div style="width: 100%;">
			<div id="confirmDeleting" class="modal" style="display: none;">
				<div class="modal-header">
					<a class="close" data-dismiss="modal">X</a> <span
						class="f12em b red"><i class="icon-book blue"></i> Delete
						Estimates</span>
				</div>
				<div class="modal-body">
					<span class="f12em">The selected estimates will be deleted.
						Deleted estimates can be restored again, worry not. Do you want to
						continue?</span>

				</div>
				<div class="modal-footer">
					<span id="deleteConfirmed" data-action="deleteConfirmed"
						class="btn btn-success">Yes</span> <span data-dismiss="modal"
						class="btn btn-success">Cancel</span>
				</div>
			</div>

			<div id="message" class="modal" style="display: none;">
				<div class="modal-header">
					<a class="close" data-dismiss="modal">X</a> <span
						class="f12em b red"><i class="icon-book blue"></i> Delete
						Estimates</span>
				</div>
				<div class="modal-body">
					<span class="f12em">Sorry, You are not authorised to delete</span>

				</div>
				<div class="modal-footer">
					<!-- <span id="deleteConfirmed" data-action="deleteConfirmed" class="btn btn-success">Yes</span> -->
					<span data-dismiss="modal" class="btn btn-success">Cancel</span>
				</div>
			</div>

			<div id="selectRow" class="modal" style="display: none;">
				<div class="modal-header">
					<a class="close" data-dismiss="modal">X</a> <span
						class="f12em b red"><i class="icon-book blue"></i> No data
						selected</span>
				</div>
				<div class="modal-body">
					<span class="f12em">Please select one or more rows</span>

				</div>
				<div class="modal-footer">
					<span id="selectConfirmed" data-action="deleteConfirmed"
						class="btn btn-success">Ok</span>
					<!--  <span data-dismiss="modal" class="btn btn-success">Cancel</span> -->
				</div>
			</div>
			<div id="grid_wrapper">
				<table border="0"
					class="table table-striped table-hover table-bordered mb20"
					id="getAllTask">
					<!-- <caption title="" class="captionFont">Task List</caption> -->
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 5%;">
					</colgroup>
					<thead>
						<tr id="due">
							<th class="cyan b center">Task</th>
							<th class="cyan b center">Client Name</th>
							<th class="cyan b center">Practice Type</th>
							<th class="cyan b center">Filling Type</th>
							<th class="cyan b center">Due Date</th>
							<th class="cyan b center">Assigned To</th>
							<th class="cyan b center">Client Staff <br> In Charge</th>
							<th class="cyan b center">Partner <br> In Charge</th>
							<th class="cyan b center">Task Type</th>
							<th class="cyan b center">Status</th>
							<th class="cyan b center">Edit</th>
						</tr>
						<tr>
							<th class="cyan b center"><input type="checkbox"
								id="selectGridRow" /></th>
							<th class="gridFilter">Client Name</th>
							<th class="gridFilter">Practice Type</th>
							<th class="gridFilter">Filling Type</th>
							<th class="gridFilter">Due Date</th>
							<th class="gridFilter">Assigned To</th>
							<th class="gridFilter">Client Staff <br> In Charge</th>
							<th class="gridFilter">Partner <br> In Charge</th>
							<th class="gridFilter">Task Type</th>
							<th class="gridFilter">Status</th>
							<th class="cyan b center"></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>

				<input type="hidden" name="inValidClientId" id="firmId"
					value="${firmId}" /> <input type="hidden" id="usrole"
					value="${urole}" />
					<input type="hidden" id="taskId" value="${entityKey}"/>
				<!-- <table id="taskGridlist"></table>
			<div id="pager" class="scroll"></div> -->
			</div>
		</div>

		<script>
			$(function() {
				$('#getAllTask')
						.dataTable(
								{
									"fnPreDrawCallback" : function() {
										return true;
									},
									"fnDrawCallback" : function() {

									},
									"aaSorting" : [ [ 0, "desc" ] ],
									"bLengthChange" : true,
									"bFilter" : true,
									"bAutoWidth" : false,
									//  "sDom": '<"H"lpir>t',
									"sDom" : '<"H"<"tools">lpir>t',
									"sPaginationType" : "bootstrap",
									/* "iDisplayLength": 5, */
									"bInfo" : true,
									"oLanguage" : {
										"sLengthMenu" : "_MENU_ records per page",
										"sProcessing" : "Loading.....",
										"sZeroRecords" : "No task found. Click 'Add/Edit' tab to get started."
									},
									"sAjaxSource" : 'taskajaxlist.do',
									"bProcessing" : 'true',
									"bServerSide" : 'true',
									"bDeferRender" : 'false',
									"fnInitComplete" : function() {
										$('#selectGridRow').click(
													function() {
														$('input',oTable.fnGetNodes()).attr('checked',this.checked);
													});
									},
									"aoColumns" : [
											{
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
													return retVal;
													//return obj.aData[0];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[1];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[2];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[3];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[4];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[5];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[6];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[7];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[8];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[9];
												}
											}, {
												"bUseRendered" : "false",
												"sClass" : "center",
												"fnRender" : function(obj) {
													return obj.aData[10];
													/* var demoTaskPage = '<a class="colorBoxDemoTask cboxElement" href="/pm-new/task/demoTaskModule.do?taskId=' + obj.aData[0] +'">Edit</a>';
													return demoTaskPage; */
												}
											} ]
								})
						.columnFilter(
								{
									sPlaceHolder : "head:after",
									aoColumns : [
											null,
											{
												type : "text"
											},
											{
												type : "text"
											},
											{
												type : "select",
												values : [ 'Installment','Filing' ]
											},
											{
												type : "text"
											},
											{
												type : "text"
											},
											{
												type : "text"
											},
											{
												type : "text"
											},
											{
												type : "select",
												values : [ 'ADHOC', 'SCHEDULED' ]
											},
											{
												type : "select",
												values : [
														'New',
														'Completed',
														'Awaiting Client Response',
														'Processed' ]
											}, null

									]
								});
				$("div.tools").html('<button type="submit" class="btn" data-action="delete" id="deleteItems"> <i class="icon-trash icon-white"></i> </button>');
			});
		</script>
		<script type="text/javascript">
			$(document).ready(function() {
								$('#deleteItems').click(
									function() {
										var ro = $('#usrole').val();
										if (ro == "ROLE_CLIENT_STAFF"
												|| ro == "ROLE_STAFF"
												|| ro == "ROLE_APP_ADMIN") {
											$('#message').modal();
										}
										var selectedItems = [];
										$('input[name="selectGridRow"]:checked')
												.each(function() {
															selectedItems.push($(this).val());
														});
										if (selectedItems.length == 0
												&& (ro != "ROLE_CLIENT_STAFF")
												&& (ro != "ROLE_STAFF")
												&& (ro != "ROLE_APP_ADMIN")) {
											$('#selectRow').modal();
										} else if ($(this).data(
												'action') == 'delete'
												&& (ro != "ROLE_CLIENT_STAFF")
												&& (ro != "ROLE_STAFF")
												&& (ro != "ROLE_APP_ADMIN")) {
											$('#confirmDeleting').modal();
										}
									});
							});
			$('#selectConfirmed').click(function() {
				$('#selectRow').modal('hide');
			});

			$('#deleteConfirmed').click(function() {
						var selectedItems = [];
						$('input[name="selectGridRow"]:checked').each(
								function() {
									selectedItems.push($(this).val());

								});
						var URL;
						if ($(this).data('action') == 'deleteConfirmed') {
							$('#confirmDeleting').modal('hide');
							URL = 'savetaskAjaxList.do?id='+ selectedItems;
						}

						$.ajax({
							type : "POST",
									url : URL,
									data : $('#task').serialize(),
									success : function(data) {
										if (data) {
											$('#getAllTask').dataTable().fnDraw();
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
		</script>
	</div>
	<script>
		$(document).ready(function() {
			$(".colorBoxDemoTask").colorbox({});
		});
		function editTask(entityKey) {
			window.location = 'taskModule.do?taskId=' + entityKey;
			return false;
		}

		/*  $('#selectGridRow').click( function() {
		    $('input', oTable.fnGetNodes()).attr('checked',this.checked);
		} ); */
	</script>