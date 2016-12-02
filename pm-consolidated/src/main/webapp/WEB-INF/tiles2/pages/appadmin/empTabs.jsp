 <div class="tabbable">
     <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="newempTabs">     
        <li><a href="#emplist"  onclick=EmployeeList(); data-toggle="tab"><spring:message code="label.staffList"/></a></li>
        <li><a data-target="#empaddedit"  onClick=Employee(); data-toggle="tab"><spring:message code="label.staffAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="emplist">
       <%@ include file="newEmpList.jsp" %> 
        </div>
        <div class="tab-pane" id="empaddedit"></div>
    </div>
</div>


<script>
$(function() {
	$("#newempTabs").tab(); // initialize tabs
	$("#newempTabs").bind("show", function(e) {
	//	alert("event");
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#newempTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#newempTabs a:first').tab("show"); // Load and display content for first tab

	});
function Employee(){
	 //alert("employee");
	 $('#empaddedit').load('adminFirmEmployee.do?firmId='+${sessionfirmId});
	 $('#newempTabs a:last').tab('show');
	 $('#emplist').hide();
	 $('#empaddedit').show();
}

function EmployeeList(){
	 //alert("emplist");
	 $('#emplist').show();
	 $('#empaddedit').hide();
	}
</script>