c<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<!-- <div class="container_12 mt15 mb15 gridWrap"> -->
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />
<style>
.del_clientGrid{
    background-color: #BFCFFE;
}
</style>
	
	<!-- <div class="well">	                	
					<button type="button" id="listButton" class="btn btn-primary">List</button>
                     	   </div> -->
		<div class="well">
			<div id="grid_wrapper">
				<table id="clientGrid"></table>
				<div id="pager" class="scroll"></div>
			</div>
		</div>
		<!--  END GRID BUCKET -->
	
<!--  JQ GRID -->
<script>
jQuery(document).ready(function() 
	{
		var firmPracticeId = $("#firmPracticeId").val();

		var mygrid = jQuery("#clientGrid")
				.jqGrid(
			{
				url : 'clientAjaxList.do',
				datatype : 'json',
				height : 300,
				mtype : 'GET',
				colNames : [ 'Client ID',
						'Client Name',
						'Partner-In-Charge',
						'Office Contact',
						'Email','Edit'],
				colModel : [
						{
							name : 'partyId',
							index : 'partyId'

						},
						{
							name : 'name',
							index : 'name',

							formatter : 'showlink',
						//	formatter :clientSelect,
							formatoptions : {
								baseLinkUrl : 'clientDetail.do',
								idName : 'clientId'
								}
						},
						{
							name : 'inChargePerson',
							index : 'inChargePerson'

						},
						{
							name : 'officeNumber',
							index : 'officeNumber'

						},
						{
							name : 'emailAddress',
							index : 'emailAddress'

						},
						{
					    name:'partyId',
					    index:'partyId', 
					    width:40, 
					    search:false,
					    formatter : clientEdit
					    }
				],
				jsonReader : {
					root : "rows",
					page : "page",
					total : "total",
					records : "records",
					repeatitems : false,
					cell : "cell",
					id : "partyId",
					userdata : "userdata"
				},
				pager : jQuery('#pager'),
				rowNum : 10,
				//loadonce : true,
				rowList : [ 10, 20, 40 ],
				sortname : 'name',
				sortorder : 'asc',
				viewrecords : true,
			//	onSelectRow: neweditrow,
				autowidth : true,
				caption : 'CLIENT LIST'
	
			});
			
		jQuery("#clientGrid").jqGrid('navGrid', '#pager', {
			del : true,
			add : false,
			edit : false,
			search : false
		});
		
			jQuery("#clientGrid").jqGrid('navButtonAdd',
					"#pager", {
						caption : "Apply Filter",
						title : "Toggle Search Toolbar",
						buttonicon : 'ui-icon-pin-s',
						onClickButton : function() {
							mygrid[0].toggleToolbar();
						}
					});
			jQuery("#clientGrid").jqGrid('filterToolbar', {
				stringResult : true,
				searchOnEnter : false
			});								

			$("#clientDetail").click(function(){
				$('#edit').load('clientDetail.do');
				$('#mainClientTabs a:last').tab('show');
				});

		});


	 // resize the grid if needed
	 $(window).bind('resize', function() {
	jQuery("#clientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
		}).trigger('resize');

	 $(window).bind('load', function() {
		jQuery("#clientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
			}).trigger('load');	

	 function clientEdit(cellvalue, options, rowObject) {
		return"<a style='text-decoration: underline; cursor: pointer;' class='ui-icon ui-icon-pencil' href='javascript:editClient(&quot;" + cellvalue + "&quot;)'>edit</a>";
		}
		
	/*  function clientSelect(cellvalue, options, rowObject) {
		return"<a style='text-decoration: underline; cursor: pointer;'  href='javascript:editClient(&quot;" + rowObject.partyId + "&quot;)'>"+rowObject.name+"</a>";
		} */
		

		function editClient(partyId){
			$("#leftmenufiller").hide();
			$("#leftmenumain").show();
			$('#edit').load('clientDetail.do?clientId='+partyId);
			$('#mainClientTabs a:last').tab('show');
			
		}
		function neweditrow(cellvalue){ 
			var id = cellvalue; $('#edit').load('clientDetail.do?clientId='+id);$('#clientBankTabs a:last').tab('show');}
		
		/* $().ready(function() {
       	 $("#listButton").click(function() {
       		$("#clientGrid").setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
       	 });
		}); */
		
		</script>
		<!-- </div> -->
