<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<!-- MAIN CONTENT SECTION -->
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />
<div>

		<div id="yui-g" style="text-align:right;margin-right:2px;">
		
		<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
			<a href="clientDetail.do"  style="text-decoration:none;">
				<button type="button" id="clientDetail"
				onclick="window.location='clientDetail.do';return false;"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">New Client </span>
				</button> 
			</a>
		</security:authorize>
		</div>
	<br/>
	<!-- BUCKET -->
		<div class="container_12">
			<div id="grid_wrapper">
				<table id="clientGrid"></table>
				<div id="pager" class="scroll"></div>
			</div>
		</div>
		
		
	</div>
	<!--  END BUCKET -->
	
	
		<!--  JQ GRID -->
		<script>
			jQuery(document)
					.ready(
							function() {
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
															'Email'],
													colModel : [
															{
																name : 'partyId',
																index : 'partyId'
																
															},
															{
																name : 'name',
																index : 'name',
																
																formatter : 'showlink',
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
											//		loadonce : true,
													rowList : [ 10, 20, 40 ],
													sortname : 'name',
													sortorder : 'asc',
													viewrecords : true,
													autowidth : true,
													caption : 'CLIENT LIST',
													editurl : '<c:url value="/saveClientAjaxList.do"/>'
												});
								
								
								<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
									jQuery("#clientGrid").jqGrid('navGrid', '#pager', {
										del : true,
										add : false,
										edit : false,
										search : false
									});
								</security:authorize>
								<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
									jQuery("#clientGrid").jqGrid('navGrid', '#pager', {
										del : false,
										add : false,
										edit : false,
										search : false
									});
								</security:authorize>
								
								
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
							
								
							});
			
							 
							 // resize the grid if needed
							 $(window).bind('resize', function() {
    							jQuery("#clientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
								}).trigger('resize');
							 
							 $(window).bind('load', function() {
	    							jQuery("#clientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
									}).trigger('load');			
			
		</script>



