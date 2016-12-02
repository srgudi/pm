    <!--  GRID PLACEHOLDER Ids -->
    <div class="well">
    		<div id="grid_wrapper">
			<table id="codeGrid"></table>
			<div id="codePager" class="scroll"></div>
		</div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";

			jQuery(document)
					.ready(
							function() {

								var mygrid = jQuery("#codeGrid")
										.jqGrid(
												{
													url : 'codeList.do',
													datatype : 'local',
													height : 300,
													mtype : 'GET',
													colNames : [
															'Short Name', 'Long Description', 'Type Of Name', 'App Level Indicator', 'Parent Code Name', 'Status', 'Edit' ],
													colModel : [
															{
																name : 'shortName',
																index : 'shortName',
																formatter : 'showlink',
																formatoptions : {
																	baseLinkUrl : '/adminCode.do',
																	idName : 'id'
																}
															},
															{
																name : 'longDescription',
																index : 'longDescription'
															},
															{
																name : 'codeTypeName',
																index : 'codeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'parentCodeShortName',
																index : 'parentCodeShortName'
															},
															{
																name : 'status',
																index : 'status',
																	 width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
															   		 	formatter:'select', stype: 'select', sorttype:
															   		 	function(cell) {return status[cell];},
															   		 edittype:'select', editoptions: { value: statusStr }, 
															   		searchoptions:{ sopt:['eq'] }},
															 {
															   	name : 'id',
															   	index: 'id',
															   	search: false,
															   	width: 40,
															   	formatter: codeEdit
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
													pager : jQuery('#codePager'),
													rowNum : 10,
													//loadonce : true,
													rowList : [ 10, 25, 50 ],
													sortname : 'firstName',
													sortorder : 'asc',
													viewrecords : true,
													onSelectRow: neweditrow,
													autowidth : false,
													caption : 'Code List',
													editurl : '<c:url value="/appadmin/saveCode.do"/>'

												});
								jQuery("#codeGrid").jqGrid('navGrid', '#codePager', {
									del : true,
									add : false,
									edit : false,
									search : false
								});
								jQuery("#codeGrid").jqGrid('navButtonAdd',
										"#codePager", {
											caption : "Apply Filter",
											title : "Toggle Search Toolbar",
											buttonicon : 'ui-icon-pin-s',
											onClickButton : function() {
												mygrid[0].toggleToolbar();
											}
										});
								jQuery("#codeGrid").jqGrid('filterToolbar', {
									stringResult : true,
									searchOnEnter : false
								});
							});
			
			 // resize the grid if needed
			 $(window).bind('resize', function() {
				jQuery("#codeGrid").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('resize');
			 
			 $(window).bind('load', function() {
					jQuery("#codeGrid").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('load');
			 
			 $(window).bind('reload', function() {
				 jQuery("#codeGrid").setGridParam({url:'retriveAdminCode.do'}); 
				 jQuery("#codeGrid").trigger("reloadGrid"); 
					}).trigger('reload');
			 
			 function codeEdit(cellvalue, options, rowObject){
				 return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editCode(&quot;" + cellvalue + "&quot;)'>edit</a>";
			 }
			 
			 function editCode(partyId){
				 $('#edit').load('adminCode.do?id='+partyId);$('#codeTab a:last').tab('show');
				}
		</script>