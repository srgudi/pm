
<%@ include file="../../layout/PM-INCLUDES.jsp" %>

 <input type="hidden" name="inValidClientId" id="firmId"	value="${firmId}" />
<script type="text/javascript">
$(function() {
    $("#viewNewTaskForm").click(function() {
        $.mobile.changePage("../mobiletask/mobileTaskmodule.do","slideup");
    });        
});
</script> 
<%-- <c:url value="/mobiletask/mobileTaskmodule.do" var="mobiletaskModuleUrl"/> --%>

  <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
			<!-- <a href="mobileTaskmodule.do"  style="text-decoration:none;">
				<button type="button" id="newTask"
				onclick="window.location='mobileTaskmodule.do';return false;"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					data-role="button" aria-disabled="false" data-inline="true" data-mini="true">
					<span class="ui-button-text">New Task</span>
				</button> 
			</a> -->
			 <a  id="viewNewTaskForm" data-role="button" data-inline="true" data-mini="true">New Task</a> 
	  </security:authorize>
 
 <div id="grid_wrapper">
    <table id='mobileTaskGrid'></table>
    <div id='pager'></div>
 </div>
    <!-- Java Script Code -->
    <script type='text/javascript'>
    var firmId = $("#firmId").val();
        jQuery('#mobileTaskGrid').jqGrid({
            "hoverrows":false,
            "viewrecords":true,
            "jsonReader": {root : "rows",
            page : "page",
            total : "total",
            records : "records",
            repeatitems : false,
            cell : "cell",
            id : "taskId",
            userdata : "userdata"},
            "gridview":true,
            "loadonce":true,
            "url":'<c:url value="/mobiletask/mobiletaskajaxlist.do"/>?firmId=' + firmId,
            "scrollPaging":true,
            pager : jQuery('#pager'),
            //"autowidth":true,
           /// "footerrow": true,
           /// "userDataOnFooter": true,
            "rowNum":10,
            "rowList" : [20,40,60],
            "sortname":"clientName",
            "height":200,
            "width" :300,
            "mtype" : "GET",
            "datatype":"json",
            caption : 'Task List',
            editurl:'<c:url value="/mobiletask/saveMobiletaskAjaxList.do"/>',
            colNames : [ 
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
                             name : 'clientName',
                             index : 'clientName',
                             formatter : 'showlink',
                             formatoptions : {
                            	 
                                 baseLinkUrl : '<c:url value="/mobiletask/mobileTaskmodule.do"/>',
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
            
          
                    
            "pager":"#pager"
        });
        jQuery("#mobileTaskGrid").jqGrid('filterToolbar', {
            stringResult : true,
            searchOnEnter : false
        });
      /*  // $("#grid").jqGrid('footerData', 'set', { "ShipName":"Total:"}, true); */
    $('#pager').css("height", "50px");
   
    </script>
 










 
 
 
 
 