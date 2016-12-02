<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<!-- MAIN CONTENT SECTION -->

    <input type="hidden" name="inValidClientId" id="firmId"	value="${firmId}" />
<div>

	<div id="yui-g" style="text-align:right;margin-right:2px;">
	    <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
			<a href="taskModule.do"  style="text-decoration:none;">
				<button type="button" id="newTask"
				onclick="window.location='taskModule.do';return false;"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">New Task</span>
				</button> 
			</a>
	  </security:authorize>
		</div>
	<br/>

    <div class="container_12">
        <div id="grid_wrapper">
             <table id="list"></table>
             <div id="pager" class="scroll"></div>
        </div>
    </div>

</div>


<script>
    jQuery(document)
            .ready(
            function() {
                var firmId = $("#firmId").val();

                var mygrid = jQuery("#list")
                        .jqGrid(
                        {
                            url : '<c:url value="/task/taskajaxlist.do"/>?firmId='
                                    + firmId,
                            datatype: 'json',
                            height:'100%',
                            mtype: 'GET',
                            colNames : [ 'Task ID',
                                'Client Name',
                                'Practice Type',
                                'Filing Type', 'Due Date',
                                'Assigned To',
                                'Client Staff In Charge',
                                'Partner In Charge',
                                'Task Type ',
                                'Status' ],
                            colModel : [
                                {
                                    name : 'taskId',
                                    index : 'taskId',
                                    width : 40
                                },
                                {
                                    name : 'clientName',
                                    index : 'clientName',
                                    formatter : 'showlink',
                                    formatoptions : {
                                        baseLinkUrl : '<c:url value="/task/taskModule.do"/>',
                                        idName : 'taskId'
                                    }
                                },
                                {
                                    name : 'practiceType',
                                    index : 'practiceType'
                                },
                                {
                                    name : 'filingType',
                                    index : 'filingType'
                                },
                                {
                                    name : 'formattedDueDate',
                                    index : 'formattedDueDate'
                                },
                                {
                                    name : 'assignedTo',
                                    index : 'assignedTo'
                                },
                                {
                                    name : 'clientStaffInCharge',
                                    index : 'clientStaffInCharge'
                                },
                                {
                                    name : 'partnerInCharge',
                                    index : 'partnerInCharge'
                                },
                                {
                                    name : 'taskType',
                                    index : 'taskType'
                                },
                                {
                                    name : 'status',
                                    index : 'status'
                                }
                            ],
                            jsonReader : {
                                root : "rows",
                                page : "page",
                                total : "total",
                                records : "records",
                                repeatitems : false,
                                cell : "cell",
                                id : "taskId",
                                userdata : "userdata"
                            },
                      //      loadonce : true,
                            mtype : "GET",
                            rownumWidth : 40,
                            pager : jQuery('#pager'),
                            rowNum : 10,
                            rowList : [ 10, 25, 50 ],
                            sortname : 'clientName',
                            sortorder : 'asc',
                            viewrecords : true,
                            autowidth : true,
                            caption : 'Task List',
                            editurl:'<c:url value="/task/savetaskAjaxList.do"/>'
                            
                            
                        });
                
                <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
                jQuery("#list").jqGrid('navGrid', '#pager', {
                    del : true,
                    add : false,
                    edit : false,
                    search : false
                });
                </security:authorize>
                
              <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
                jQuery("#list").jqGrid('navGrid', '#pager', {
                 del : false,
                 add : false,
                 edit : false,
                 search : false
                });
                </security:authorize> 
                
                jQuery("#list").jqGrid('navButtonAdd',
						"#pager", {
							caption : "Apply Filter",
							title : "Toggle Search Toolbar",
							buttonicon : 'ui-icon-pin-s',
							onClickButton : function() {
								mygrid[0].toggleToolbar();
							}
						});
                
                 jQuery("#list").jqGrid('filterToolbar', {
                    stringResult : true,
                    searchOnEnter : false
                });
                
            });
    // resize the grid if needed
    $(window).bind('resize', function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

     $(window).bind('load', function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load'); 
</script>
