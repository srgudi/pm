<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<html>
 <head>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <title>Dashboard</title>
	
	 <style type="text/css">
    #placeholder .button {
        position: absolute;
        cursor: pointer;
    }
    .ui-jqgrid-view{
        width: 600px;
    }
    .ui-jqgrid-titlebar ui-widget-header ui-corner-top ui-helper-clearfix{
        width: 600px;
    }
    .ui-state-default ui-jqgrid-hdiv{
        width: 600px;
    }
    .ui-jqgrid-bdiv{
        width: 600px;
    }
   </style>
 </head>
    <body>
    <!-- <h1>Dashboard</h1> -->
<!-- <div>
    <center><div id="placeholder" style="width:600px;height:300px"></div></center>
	<br>
	
	<div class="fieldset mt25 ml20 mr20">
	<div class="container_12">
		<span class="legend b" id="filesText"><b>Files Due Today</b></span>
		
    	 GRID PLACEHOLDER Ids
    	<div id="grid_wrapper" class="ml10 mr10 mt20">
    	<br/>
			<table id="list"></table>
			<div id="pager" class="scroll" style="text-align: center;"></div>
		</div>
		</div>
	</div>
</div>
 -->
<input type="hidden" name="missedDeadLines" id="missedDeadLines" value="${missedDeadLines}"/>
<input type="hidden" name="dueForToday" id="dueForToday" value="${dueForToday}"/>
<input type="hidden" name="dueForWeek" id="dueForWeek" value="${dueForWeek}"/>
<input type="hidden" name="dueForMonth" id="dueForMonth" value="${dueForMonth}"/>
<input type="hidden" name="dueForTwoMonth" id="dueForTwoMonth" value="${dueForTwoMonth}"/>
<input type="hidden" name="dueForThreeMonth" id="dueForThreeMonth" value="${dueForThreeMonth}"/>
<input type="hidden" name="dynamicGridName" id="dynamicGridName" value="${dynamicGridName}"/>
<input type="hidden" name="filesWaitingForClientReply" id="filesWaitingForClientReply" value="${filesWaitingForClientReply}"/>

<!-- <script type="text/javascript">
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
<script>
    jQuery(document)
            .ready(
            function() {
                var firmId = $("#firmId").val();
                jQuery("#list")
                        .jqGrid(
                        {
                            url : '<c:url value="/dashboard/filesDueTodayList.do"/>?firmId='+ firmId,
                            datatype: 'json',
                            height:'100%',
                            width:'75%',
                            mtype: 'GET',
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
                                        baseLinkUrl : '<c:url value="/task/taskModule.do"/>',
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
                            loadonce : true,
                            mtype : "GET",
                            rownumbers : false,
                            rownumWidth : 40,
                            gridview : false,
                            pager : jQuery('#pager'),
                            rowNum : 5,
                            rowList : [ 5, 10, 25, 50 ],
                            sortname : 'clientName',
                            sortorder : 'asc',
                            viewrecords : true,
                            autowidth : false,
                            caption : 'DashBoard',
                            editurl:''
                            
                        });
                jQuery("#list").jqGrid('navGrid', '#pager', {
                    del : false,
                    add : false,
                    edit : false,
                    search : false
                });

                jQuery("#list").jqGrid('filterToolbar', {
                    stringResult : true,
                    searchOnEnter : false
                });
            });
    // resize the grid if needed
    $(window).bind('resize',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

    $(window).bind('load',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load');
    
</script> -->
<!-- <script type="text/javascript">
 $("#placeholder").bind("plotclick", function (event, pos, item) {
	//alert("U clicked");
	var count = item.datapoint[0];
	firmId = ${firm.id};
	$.get('<c:url value="/dashboard/filesDueTodayList.do"/>',  {count: count, firmId:firmId }, function(data) {
		populateGrid(data);
    });
	switch(count){
	
	case 0 : $('#filesText').html("<b>List of Files that have Missed Deadlines</b>");
	           break;
	case 1: $('#filesText').html("<b>List of Files Due Today</b>");
	           break;
	case 2 : $('#filesText').html("<b>List of Files Due this week</b>");
	           break;
	case 3 : $('#filesText').html("<b>List of Files Due this month</b>");
	           break;
	case 4 : $('#filesText').html("<b>List of Files Due in two months</b>");
	           break;
	case 5 : $('#filesText').html("<b>List of Files Due in three months</b>");
	          break;
	case 6 : $('#filesText').html("<b>List of Files Waiting for clients Input</b>");
	          break;
	}
}); 

function populateGrid(data){
	$("#list").jqGrid('clearGridData');
	var rowdata = data.rows;
	for (var i = 0; i < rowdata.length; i++) {
	var task = rowdata[i];
	$('#list').jqGrid('addRowData', task.taskId, {
		clientName : task.clientName,
		taskType : task.taskType,
		formattedDueDate: task.formattedDueDate,
		status: task.status,
		emailAddress: task.emailAddress,
		officeNumber: task.officeNumber
	});
	}
	jQuery("#list").setGridParam({rowNum:5}).trigger("reloadGrid");
}

</script>
 </body>
</html> -->

 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


    <title>Dashboard </title>
    <br/>
    <br/><br></br>
    <link rel="stylesheet" type="text/css" href="../resources/jqChart/css/jquery.jqChart.css" />
    <link rel="stylesheet" type="text/css" href="../resources/jqChart/css/jquery.jqRangeSlider.css" />
    <!-- <link rel="stylesheet" type="text/css" href="/resources/themes/smoothness/jquery-ui-1.8.21.css" /> -->
   <!--  <script src="../resources/jqChart/js/jquery-1.5.1.min.js" type="text/javascript"></script> -->
    <script src="../resources/jqChart/js/jquery.jqChart.min.js" type="text/javascript"></script>
    <script src="../resources/jqChart/js/jquery.jqRangeSlider.min.js" type="text/javascript"></script>
    <script lang="javascript" type="text/javascript" src="../resources/jqChart/js/excanvas.js"></script>
    <script lang="javascript" type="text/javascript">
        $(document).ready(function () {
        	var d1 = $("#missedDeadLines").val();
            var d2 = $("#dueForToday").val();
        	var d3 = $("#dueForWeek").val();
        	var d4= $("#dueForMonth").val();
        	var d5= $("#dueForTwoMonth").val();
        	var d6= $("#dueForThreeMonth").val();
        	var d7= $("#filesWaitingForClientReply").val();
        	var data;
        	var newval,newval1,newval2,newval3,newval4;
        	var array;
        	var background = {
          		  type: 'linearGradient',
          		  x0: 0,
          		  y0: 0,
          		  x1: 0,
          		  y1: 1,
          		  colorStops: [{ offset: 0, color: '#80c8fe' },
          		               { offset: 1, color: 'white'}]
          		};
      	var fillStyle = {
                  type: 'linearGradient',
                  x0: 0,
                  y0: 0,
                  x1: 1,
                  y1: 0,
                  colorStops: [{ offset: 0, color: '#65c2e8' },
                               { offset: 0.49, color: '#55b3e1' },
                               { offset: 0.5, color: '#3ba6dc' },
                               { offset: 1, color: '#2794d4'}]
              };
      	
      	
        	 $.get("<c:url value='/dashboard/dashboardClientList.do'/>", {}, function(dataNew) {
        		/* alert("hi"); */
				 data = dataNew.dashboardclientDetails;
				/*  alert("data:"+data); */
				 newval = data[0];
				 newval1 = data[1];
				 newval2 = data[2];
				 newval3 = data[3];
				 newval4 = data[4];
				 /* if(newval.contains(',')){alert("data1:"+newval);} */
				 $('#jqNewChart').jqChart({
		                title: { text: 'Top Clients' },
		                legend: { title: 'Client List' },
		                border: {
		                    strokeStyle: '#00477d', 
		                    lineWidth: 1
		                },
		                watermark: {
		                    text: '  TSS',
		                    fillStyle: '#00477d',
		                    font: '20px sans-serif',
		                    hAlign: 'left',
		                    vAlign: 'bottom'
		                },
		                background: background,
		                top: 10, 
		                position: top,
		                width : 300, 
		                height : 300,
		                animation: { duration: 1 },
		                series: [
		                            {
		                                type: 'pie',
		                                labels: {
		                                    stringFormat: '%.1f%%',
		                                    valueType: 'percentage',
		                                    font: '15px sans-serif',
		                                    fillStyle: 'white'
		                                },
		                                data: [newval, newval1, newval2, newval3, newval4]

		                            }
		                        ]
		            });
				 $('#jqNewChart').bind('tooltipFormat', function (e, data) {
		                var percentage = data.series.getPercentage(data.value);
		                percentage = data.chart.stringFormat(percentage, '%.2f%%');

		                return '<b>' + data.dataItem[0] + '</b></br>' +
		                       data.value + ' (' + percentage + ')';
		            });
				 $("#jqNewChart").attr('top', 0);

				 var elem = document.getElementById('newmdl');
				 elem.style.width = $("#missedDeadLines").val() + "%";
				 elem = document.getElementById('newtod');
				 elem.style.width = $("#dueForToday").val() + "%";
				 elem = document.getElementById('newweek');
				 elem.style.width = $("#dueForWeek").val() + "%";
				 elem = document.getElementById('newmonth');
				 elem.style.width = $("#dueForMonth").val() + "%";
				 elem = document.getElementById('newtwomonth');
				 elem.style.width = $("#dueForTwoMonth").val() + "%";
				 elem = document.getElementById('newthreemonth');
				 elem.style.width = $("#dueForThreeMonth").val() + "%";
				 elem = document.getElementById('newwaitmonth');
				 elem.style.width = $("#filesWaitingForClientReply").val() + "%";
            }); 
        	
          
            $('#jqChart').jqChart({
                title: { text: 'DashBoard' },
                animation: { duration: 1.5 },
                width : 600, 
                height : 300,
                background: background,
                border: {
                    strokeStyle: '#00477d', 
                    lineWidth: 1, 
                    lineCap: 'butt', 
                    lineJoin: 'bevel', 
                    miterLimit: 10,
                    cornerRadius: 10, 
                    padding: 20
                },
                watermark: {
                    text: '  TSS',
                    fillStyle: '#00477d',
                    font: '20px sans-serif',
                    hAlign: 'left',
                    vAlign: 'bottom'
                },
                axes: [
                        {
                            location: 'left',
                            minimum: 5,
                            maximum: 100,
                            interval: 5
                        }
                      ],
                     /*  crosshairs: {
                          enabled: true, 
                          snapToDataPoints: true, 
                          hLine: { visible: true, strokeStyle: '#00477d' }, 
                          vLine: { visible: true, strokeStyle: '#00477d' } 
                      }, */
                series: [
                            {
                                type: 'column',
                                title: 'Tasks',
                                fillStyle: '#0066b3',
                                fillStyle: fillStyle,
                                cursor: 'pointer',
                                data: [[' Missed ', d1], [' Due Today ', d2], [' Due this week ', d3], [' Due this month ', d4], [' Due in 60 days ', d5], [' Due in 90 days ', d6], ['Waiting', d7]],
                                markers: { size: 5, type: 'rectangle', 
                                    strokeStyle: 'black', lineWidth: 1 },
                              labels: { 
                                         stringFormat: '%d', 
                                         font: '12px sans-serif' 
                                      }
                            }
                        ]
            });
            $('#jqChart').bind('dataPointMouseUp', function (e, data) {
            	//alert("Hi");
            	var count = data.index;
            	//alert("hello"+count);
            	firmId = ${firm.id};
            	//alert("hi"+firmId);
            	$.get('<c:url value="/dashboard/filesDueTodayList.do"/>',  {count: count, firmId:firmId }, function(data) {
            		populateGrid(data);
                });
            	switch(count){
            	
            	case 0 : $('#filesText').html("<b>List of Files that have Missed Deadlines</b>");
            	           break;
            	case 1: $('#filesText').html("<b>List of Files Due Today</b>");
            	           break;
            	case 2 : $('#filesText').html("<b>List of Files Due this week</b>");
            	           break;
            	case 3 : $('#filesText').html("<b>List of Files Due this month</b>");
            	           break;
            	case 4 : $('#filesText').html("<b>List of Files Due in two months</b>");
            	           break;
            	case 5 : $('#filesText').html("<b>List of Files Due in three months</b>");
            	          break;
            	case 6 : $('#filesText').html("<b>List of Files Waiting for clients Input</b>");
            	          break;
            	}
            	
            	 function populateGrid(data){
                 	$("#list").jqGrid('clearGridData');
                 	var rowdata = data.rows;
                 	for (var i = 0; i < rowdata.length; i++) {
                 	var task = rowdata[i];
                 	$('#list').jqGrid('addRowData', task.taskId, {
                 		clientName : task.clientName,
                 		taskType : task.taskType,
                 		formattedDueDate: task.formattedDueDate,
                 		status: task.status,
                 		emailAddress: task.emailAddress,
                 		officeNumber: task.officeNumber
                 	});
                 	}
                 	jQuery("#list").setGridParam({rowNum:5}).trigger("reloadGrid");
                 }

            });
           
            $('#jqChart').resizable();
            
            $('#jqChart').bind('shapeRendering', function (e, shape) {

                if (shape.context.y > 50) {
                    shape.fillStyle = '#00477d';
                }
            });


          /*   $('#jqChart').jqChart({
                title: { text: 'Dash Board' },
                axes: [
                        {
                            type: 'Tax Filing DueDates',
                            location: 'bottom',
                            categories: ['Missed', 'Due Today', 'Due this week', 'Due this month', 'Due in 60 days', 'Due in 90 days', 'Waiting']
                        }
                      ],
                series: [
                            {
                                type: 'column',
                                title: 'T-Tasks',
                                data: [d1, d2, d3, d4, d5, d6, d7],
                                fillStyle: '#00477d',
                                strokeStyle: 'black',
                                lineWidth: 1,
                                pointWidth: 0.8,
                                markers: { size: 5, type: 'circle', 
                                      strokeStyle: 'black', lineWidth: 1 },
                                labels: { 
                                           stringFormat: '%d T', 
                                           font: '12px sans-serif' 
                                        }
                            }
                        ]
            }); */
        });
    </script>
    <script>
    jQuery(document)
            .ready(
            function() {
                var firmId = $("#firmId").val();
                jQuery("#list")
                        .jqGrid(
                        {
                            url : '<c:url value="/dashboard/filesDueTodayList.do"/>?firmId='+ firmId,
                            datatype: 'json',
                            height:'100%',
                            width:'50%',
                            mtype: 'GET',
                            colNames : [ 'Client Name',
                                'Type Of Return',
                                'Due Date',
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
                                        baseLinkUrl : '<c:url value="/task/taskModule.do"/>',
                                        idName : 'taskId'
                                    }
                                },
                                {
                                    name : 'formattedDueDate',
                                    index : 'formattedDueDate'
                                },
                                /* {
                                    name : 'status',
                                    index : 'status'
                                }, */
                                {
                                    name : 'emailAddress',
                                    index : 'emailAddress'
                                },
                                {
                                    name : 'officeNumber',
                                    index : 'officeNumber'
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
                            loadonce : true,
                            mtype : "GET",
                            rownumbers : false,
                            rownumWidth : 40,
                            gridview : false,
                            pager : jQuery('#pager'),
                            rowNum : 5,
                            rowList : [ 5, 10, 25, 50 ],
                            sortname : 'clientName',
                            sortorder : 'asc',
                            viewrecords : true,
                            autowidth : false,
                            caption : 'DashBoard',
                            editurl:''
                            
                        });
                jQuery("#list").jqGrid('navGrid', '#pager', {
                    del : false,
                    add : false,
                    edit : false,
                    search : false
                });

                jQuery("#list").jqGrid('filterToolbar', {
                    stringResult : true,
                    searchOnEnter : false
                });
                jQuery("#newClientlist")
                .jqGrid(
                {
                	url:'dashboardClientList.do',
                    datatype: 'json',
                    height : '100',
                    mtype: 'GET',
                    colNames:['Id','Client Name', 'No Of Tasks','%'],
                    colModel :[
                                {name:'id', index:'id',hidden:true}, 
                               {name:'clientName', index:'clientName',  width:200},
                               {name:'nooftasks', index:'nooftasks',  width:150},
                               {name:'percent', index:'percent',  width:150}
                           ],
                           jsonReader : {
                               root: "rows",
                               page: "page",
                               total: "total",
                               records: "records",
                               repeatitems: false,
                               cell: "cell",
                               id: "docId",
                               userdata: "userdata"
                           },
                           pager: jQuery('#newpager'),
                           rowNum:10,
                           loadonce: true,
                           rowList:[10,25,50],
                           ignoreCase: true,
                           sortname: 'formattedDate',
                           sortorder: 'desc', 
                           viewrecords: true,
                           autowidth: true,
                           caption: 'Documents'
                });
        jQuery("#newDocumentlist").jqGrid('navGrid', '#newpager', {
            del : false,
            add : false,
            edit : false,
            search : false
        });

        jQuery("#newDocumentlist").jqGrid('filterToolbar', {
            stringResult : true,
            searchOnEnter : false
        });
        
            });
    // resize the grid if needed
    $(window).bind('resize',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

    $(window).bind('load',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load');
    $(window).bind('resize',
            function() {
                jQuery("#newDocumentlist").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

    $(window).bind('load',
            function() {
                jQuery("#newDocumentlist").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load');
   
</script>

</head>
<body>
   	<div class="container_12" style="margin-left: 10px;top:0;">
	<div class="span3">
	<div class="hero-unit">
	<h5> Tasks :</h5>  
	1. Tasks That Missed Deadlines<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newmdl"></div>
    </div>
    2. Tasks Due for the Day<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newtod"></div>
    </div>
    3. Tasks Due for the Week<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newweek"></div>
    </div>
    4. Tasks Due for this Month<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newmonth"></div>
    </div>
    5. Tasks Due for next Two Months<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newtwomonth"></div>
    </div>
    6. Tasks Due for next Three Months<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newthreemonth"></div>
    </div>
    7. Tasks in Waiting For Client's Reply<br/><br/>
	<div class="progress progress-info progress-striped active" style="height:10px">
     <div class="bar" style="height:10px" id="newwaitmonth"></div>
    </div>
	</div>
	</div>
    </div>
  
      <div id="jqChart" style="margin-left:350px;float:center;">
        </div><br/>
        <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
        <div id="jqNewChart" style="margin-right:20px;float:right;">
        </div>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_CLIENT_STAFF')">
        <img src="<c:url value='../resources/img/dashboard_img.jpg'/>" style="margin-left:750px;margin-right:20px;position:absolute;top:150px;"/>
        </security:authorize>
        <br/>
    <br/>
	<div class="container_12" style="margin-left:50px;width:600px;float:left;">
	
		<span class="legend b" id="filesText"><b>Files Due Today</b></span>
    	<div id="grid_wrapper">
    	<br/>
			<table id="list"></table>
			<div id="pager" class="scroll" style="text-align: center;"></div>
		</div>
		<br/>	<br/>	
	 </div>
	 <br/><br/>	
	<br/>	<br/>
	

<style>
.hero-unit {
border-radius: 4px 4px 4px 4px;
padding: 20px;
}
div#jqNewChart{
  width: 300px;
  left: 1000px;
  top: 80px;
  position: absolute;
}
</style>


</body>
</html>
 