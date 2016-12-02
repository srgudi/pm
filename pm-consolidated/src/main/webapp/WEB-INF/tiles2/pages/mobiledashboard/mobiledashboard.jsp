 <%@ include file="../../layout/PM-INCLUDES.jsp"%>
 <style type="text/css">
    #placeholder .button {
        position: absolute;
        cursor: pointer;
     
    }
   </style>



<input type="hidden" name="missedDeadLines" id="missedDeadLines" value="${missedDeadLines}"/>
<input type="hidden" name="dueForToday" id="dueForToday" value="${dueForToday}"/>
<input type="hidden" name="dueForWeek" id="dueForWeek" value="${dueForWeek}"/>
<input type="hidden" name="dueForMonth" id="dueForMonth" value="${dueForMonth}"/>
<input type="hidden" name="dueForTwoMonth" id="dueForTwoMonth" value="${dueForTwoMonth}"/>
<input type="hidden" name="dueForThreeMonth" id="dueForThreeMonth" value="${dueForThreeMonth}"/>
<input type="hidden" name="dynamicGridName" id="dynamicGridName" value="${dynamicGridName}"/>
<input type="hidden" name="filesWaitingForClientReply" id="filesWaitingForClientReply" value="${filesWaitingForClientReply}"/>

<div>
    <div id="placeholder" style="width:280px;height:200px"></div><br>
   <span class="legend b" style="color: grey"; id="filesText">Files Due Today</span>
   <div  id="grid_wrapper">
     <table id='mobileDashboardGrid'></table>
    <div id='dashboardPager'></div>
    </div>
</div>
  <script type='text/javascript'>
  var firmId = $("#firmId").val();
        jQuery('#mobileDashboardGrid').jqGrid({
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
            "url" : '<c:url value="/mobiledashboard/filesDueTodayList1.do"/>?firmId='+ firmId,
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
            //shrinkToFit: false,
            "mtype" : "GET",
            "datatype":"json",
            caption : '',
            //editurl:'<c:url value="/saveClientAjaxList.do"/>',
             colNames : [ 'Client Name',
                                'Type Of Return',
                                'Due Date',
                                'Status',
                                'Contact Email',
                                'Office Phone'],
                                colModel : [
                                            {
                                                name : 'clientName',
                                                index : 'clientName'
                                            },
                                            {
                                                name : 'taskType',
                                                index : 'taskType',
                                                formatter : 'showlink',
                                                formatoptions : {
                                                	 baseLinkUrl : '<c:url value="/mobiletask/mobileTaskmodule.do"/>',
                                                    idName : 'taskId'
                                                }
                                            },
                                            {
                                                name : 'formattedDueDate',
                                                index : 'formattedDueDate'
                                            },
                                            {
                                                name : 'status',
                                                index : 'status'
                                            },
                                            {
                                                name : 'emailAddress',
                                                index : 'emailAddress'
                                            },
                                            {
                                                name : 'officeNumber',
                                                index : 'officeNumber'
                                            }
                                        ],
            
          
                    
            "pager":"#dashboardPager"
        });
      /*  // $("#grid").jqGrid('footerData', 'set', { "ShipName":"Total:"}, true); */
    $('#dashboardPager').css("height", "50px");
      
  
   
    </script>
<script type="text/javascript">
 $("#placeholder").bind("plotclick", function (event, pos, item) {
	//alert("U clicked");
	var count = item.datapoint[0];
	firmId = ${firm.id};
	$.get('<c:url value="/mobiledashboard/filesDueTodayList1.do"/>',  {count: count, firmId:firmId }, function(data) {
		populateGrid(data);
    });
	switch(count){
	
	case 0 : $('#filesText').text("List of Files that have Missed Deadlines");
	           break;
	case 1: $('#filesText').text("List of Files Due Today");
	           break;
	case 2 : $('#filesText').text("List of Files Due this week");
	           break;
	case 3 : $('#filesText').text("List of Files Due this month");
	           break;
	case 4 : $('#filesText').text("List of Files Due in two months");
	           break;
	case 5 : $('#filesText').text("List of Files Due in three months");
	          break;
	case 6 : $('#filesText').text("List of Files Waiting for clients Input");
	          break;
	}
}); 

function populateGrid(data){
	$("#mobileDashboardGrid").jqGrid('clearGridData');
	var rowdata = data.rows;
	for (var i = 0; i < rowdata.length; i++) {
	var task = rowdata[i];
	$('#mobileDashboardGrid').jqGrid('addRowData', task.taskId, {
		clientName : task.clientName,
		taskType : task.taskType,
		formattedDueDate: task.formattedDueDate,
		status: task.status,
		emailAddress: task.emailAddress,
		officeNumber: task.officeNumber
	});
	}
	jQuery("#mobileDashboardGrid").setGridParam({rowNum:10}).trigger("reloadGrid");
}

</script>

<script type="text/javascript">
$(function () {
    var d1 = [[0, $("#missedDeadLines").val()]];
    var d2 = [[1, $("#dueForToday").val()]];
	var d3 = [[2,  $("#dueForWeek").val()]];
	var d4= [[3,  $("#dueForMonth").val()]];
	var d5= [[4, $("#dueForTwoMonth").val()]];
	var d6= [[5,  $("#dueForThreeMonth").val()]];
	var d7= [[6,  $("#filesWaitingForClientReply").val()]];
	
    var plot = $.plot($("#placeholder"), 
		[
		{label:"Missed",  data:d1, color: '#00477d', lines:{show: true, fill:true}},
        {label:"Due Today", data: d2, color: '#0066b3', lines:{show: true, fill:true}},
		{label:"Due this week", data: d3, color: '#80c8fe', lines:{show: true, fill:true}},
		{label:"Due this month", data: d4, color: '#BFE3FE', lines:{show: true, fill:true}},
		{label:"Due in 60 days", data: d5, color: '#809ffe', lines:{show: true, fill:true}},
		{label:"Due in 90 days", data: d6, color: '#5F9EA0', lines:{show: true, fill:true}},
		{label:"Waiting", data: d7, color: '#6699cc', lines:{show: true, fill:true}}
		],
		
		{
            bars: { barWidth: 0.15, show: true, clickable: true,  fillColor: { colors: [ { opacity: 0.8 }, { opacity: 0.1 } ] }},
			grid: { hoverable: true, clickable: true, backgroundColor: { colors: ["#ffffff", "#ffffff"] } },
			yaxis: {ticks: 4,autoscaleMargin: 1},
			xaxis:{show:false}
        }
    );
	
  
	 $("#placeholder").bind("plotclick", function (event, pos, item) {
		if (item.datapoint[1] == 0 ) {
			 $.jGrowl('Sorry ! There are no files to display . ');
		}
		});
	

    function getBoundingBoxForAxis(plot, axis) {
        var left = axis.box.left, top = axis.box.top,
            right = left + axis.box.width, bottom = top + axis.box.height;

        var cls = axis.direction + axis.n + 'Axis';
        plot.getPlaceholder().find('.' + cls + ' .tickLabel').each(function () {
            var pos = $(this).position();
            left = Math.min(pos.left, left);
            top = Math.min(pos.top, top);
            right = Math.max(Math.round(pos.left) + $(this).outerWidth(), right);
            bottom = Math.max(Math.round(pos.top) + $(this).outerHeight(), bottom);
        });
        
        return { left: left, top: top, width: right - left, height: bottom - top };
    }
    
    $.each(plot.getAxes(), function (i, axis) {
        if (!axis.show)
            return;
        
        var box = getBoundingBoxForAxis(plot, axis);
        
        $('<div class="axisTarget" style="position:absolute;left:' + box.left + 'px;top:' + box.top + 'px;width:' + box.width +  'px;height:' + box.height + 'px"></div>')
            .data('axis.direction', axis.direction)
            .data('axis.n', axis.n)
            .css({ backgroundColor: "#0ff", opacity: 0, cursor: "pointer" })
            .appendTo(plot.getPlaceholder())
            .hover(
                function () { $(this).css({ opacity: 0.10 }) },
                function () { $(this).css({ opacity: 0 }) }
            )
            .click(function () {
                $("#click").text("You clicked the " + axis.direction + axis.n + "axis!")
            });
    });
});
</script>

	