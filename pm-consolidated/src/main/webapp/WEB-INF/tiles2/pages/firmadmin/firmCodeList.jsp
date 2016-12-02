
<div class="well">
<div id="grid_wrapper">
				<table id="newCodelist"></table>
				<div id="pager" class="scroll"></div>
			</div>
</div>		
<script type="text/javascript">
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";
				jQuery(document)
						.ready(
								function() {
									var mygrid = jQuery("#newCodelist")
											.jqGrid(
													{
														datatype : 'local',
														height : 300,
														mtype : 'GET',
														colNames : [
																'ID',
																'Code Name',
																'Code Type Name',
																'Code ParentCode Name',
																'Sort Order',
																'status' ],
														colModel : [
																{
																	name : 'partyCodeId',
																	index : 'partyCodeId'
																},
																{
																	name : 'codeShortName',
																	index : 'codeShortName',
																	formatter: 'showlink', formatoptions: {baseLinkUrl: 
																		'<c:url value="/firmadmin/managePartyCode.do"/>',idName:'id'}
																},
																{
																	name : 'codeCodeTypeName',
																	index : 'codeCodeTypeName'
																},
																
																{
																	name : 'codeParentCodeShortName',
																	index : 'codeParentCodeShortName'
																},
																{
																	name : 'sortOrder',
																	index : 'sortOrder'
																},
																{
																	name : 'status',
																	index : 'status'
																		,width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
															   		 	formatter:'select', stype: 'select', sorttype:
																   		 	function(cell) {return status[cell];},
																   		 edittype:'select', editoptions: { value: statusStr }, 
																   		searchoptions:{ sopt:['eq'] }},
																 ],
														jsonReader : {
															root : "rows",
															page : "page",
															total : "total",
															records : "records",
															repeatitems : false,
															cell : "cell",
															id : "partyCodeId",
															userdata : "userdata"
														},
														pager : jQuery('#pager'),
														rowNum : 10,
													//	loadonce : true,
														rowList:[10,25,50],
														sortname : 'id',
														sortorder : 'asc',
														viewrecords : true,
														autowidth : true,
														caption : 'Party Code Listsssss',
														editurl : '/pm-new/firmadmin/savePartyCode.do'
													   
													});
									
					                jQuery("#newCodelist").jqGrid('navGrid', '#pager', {
					                 del : true,
					                 add : false,
					                 edit : false,
					                 search : false
					                });
					               
									 jQuery("#newCodelist")
											.jqGrid(
													'navButtonAdd',
													"#pager",
													{
														caption : "Apply Filter",
														title : "Toggle Search Toolbar",
														buttonicon : 'ui-icon-pin-s',
														onClickButton : function() {
															mygrid[0]
																	.toggleToolbar()
														}
													});
									jQuery("#newCodelist").jqGrid('filterToolbar', {
										stringResult : true,
										searchOnEnter : false
									}); 
									
								});
									
				
				// resize the grid if needed
				 $(window).bind('resize', function() {
					jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('resize');
				 
				 $(window).bind('load', function() {
						jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
						}).trigger('load');	
				 
				 $(window).bind('reload', function() {
					 jQuery("#list").setGridParam({url:'retriveCodeType.do'}); 
					 jQuery("#list").trigger("reloadGrid"); 
						}).trigger('reload');	
			</script>
			
</div>