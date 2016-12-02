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
			 <a  id="viewNewTaskForm" data-role="button" data-inline="true" data-mini="true">New Task</a> 
  </security:authorize>
 

<meta name="viewport" content="width=100px, initial-scale=1">
<div data-role="content" style="overflow:auto;">
<table cellpadding="2" cellspacing="0" border="2" class="table table-striped table-hover table-bordered mb20" id="mobileTaskGrid">
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
            <tr>
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
			</thead>
	<tbody>
	</tbody>
</table>
    </div> 
<!-- <style>
table.pretty {
    width: 50%;
    clear: both;
}
 
table.pretty td,
table.pretty th {
    padding: 5px;
    border: 1px solid #fff;
}
table.pretty thead th {
    text-align: center;
    background: #66a9bd;
}
table.pretty tbody th {
    text-align: left;
}
     
table.pretty tbody td {
    text-align: center;
    background: #d5eaf0;
}
         
table.pretty tbody tr.odd td {
    background: #bcd9e1;
}
table.pretty tfoot th {
    background: #b0cc7f;
    text-align: left;
}
     
table.pretty tfoot td {
    background: #d7e1c5;
    text-align: center;
    font-weight: bold;
}
div.dataTables_wrapper {
   /*  background-color: #719ba7; */
}
</style> -->

<script type="text/javascript">

//var iTotalDisplayRecords = data.Count();

$('#mobileTaskGrid').dataTable( {
	/* "bJQueryUI": true, */
	"bLengthChange": true,
	"sAjaxSource": '/pm-new/mobiletask/mobiletaskajaxlist.do',
	"bFilter": true,
    "bAutoWidth": false,
    "sInfoFiltered": " ",
    "aLengthMenu": [ 5, 10, 25, 50, 100 ],
    "iDisplayLength": 5,
   /*  "sPaginationType": "bootstrap", */
    "bInfo": true,
    "bProcessing": 'true',
    "bServerSide": 'true',
    "bDeferRender": 'false',
    "bRetrieve": 'true',
    "bDestory" : 'true',
	"aoColumns": [
                  {
                        "bUseRendered": "false",
                        "sClass": "center",
                        "fnRender": function (obj) {
                        	var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
	                        return retVal; 
                        	//return obj.aData[0];
                        }
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
                    },
                    {
                        "bUseRendered": "false",
                        "sClass": "center",
                        "fnRender": function (obj) {
                            return obj.aData[8];
                        }
                    },
                    {
                        "bUseRendered": "false",
                        "sClass": "center",
                        "fnRender": function (obj) {
                            return obj.aData[9];
                        }
                    },
                    {
                        "bUseRendered": "false",
                        "sClass": "center",
                        "fnRender": function (obj) {
                           return obj.aData[10];
                        	/* var demoTaskPage = '<a class="colorBoxDemoTask cboxElement" href="/pm-new/task/demoTaskModule.do?taskId=' + obj.aData[0] +'">Edit</a>';
                            return demoTaskPage; */
                        }
                    }
              
	]/* ,
	"bDeferRender": true */
} );	
function editTask(entityKey) {
	window.location = '/pm-new/mobiletask/mobileTaskmodule.do?taskId=' + entityKey;
	return false;
}
</script>










 
 
 
 
 