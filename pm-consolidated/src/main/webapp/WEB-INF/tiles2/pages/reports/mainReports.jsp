<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<br/>
<div class="yui3-u-1-5" style="margin-top: 5px;width:200px">

<script type="text/javascript">
		$(document).ready(function() {
		
		$("#accordion").accordion({
				header : "h3",
				autoHeight : false,
				collapsible : true,
				active : false
			});
			
			$( "#tabs" ).tabs();
			    
		});
	 
</script>

<div id="accordion" style="min-width: 150px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"> 
			</span>
              <ul class="nav nav-tabs nav-stacked"> 
                <li><a href="#" onclick=TabHide();><i class="icon-right"></i><spring:message code="label.clientListByFirm"/></a>
                <li><a href="#" onclick=TabTaskListPartnerHide();><i class="icon-right"></i><spring:message code="label.taskListByPartner"/></a>
                 <li><a href="#" onclick=TabTaskDueDateHide();><i class="icon-right"></i><spring:message code="label.taskReportByDueDate"/></a>
                <li><a href="#" onclick=TabClientListByPartnerHide();><i class="icon-right"></i><spring:message code="label.clientListByPartner"/></a>
                <li><a href="#" onclick=TabFilingsByClientHide();><i class="icon-right"></i><spring:message code="label.filingsByClient"/></a>
                <li><a href="#" onclick=TabTaskListByStatusHide();><i class="icon-right"></i><spring:message code="label.taskListByStatus"/></a>
                <li><a href="#" onclick=TabTaskListByFirmHide();><i class="icon-right"></i><spring:message code="label.taskListByFirm"/></a>
                <li><a href="#" onclick=clientTabHide();><i class="icon-right"></i><spring:message code="label.clientListWithDetails"/></a>
                <li><a href="#" onclick=MDLTabHide();><i class="icon-right"></i><spring:message code="label.listByMissedDeadlines"/></a>
                <li><a href="#" onclick=tlbeTabHide();><i class="icon-right"></i><spring:message code="label.taskListByEmployee"/></a>
                <li><a href="#" onclick=ddbtTabHide();><i class="icon-right"></i><spring:message code="label.taskListByTaxType"/></a>
                <li><a href="#" onclick=tlbsTabHide();><i class="icon-right"></i><spring:message code="label.workLoadSummary"/></a>
                <li><a href="#" onclick=tlbftTabHide();><i class="icon-right"></i><spring:message code="label.taskListByFilingType"/></a>
               </ul>  
		</form:form>
	</div>   	

</div>

<div class="yui3-u-19-24" style="min-width:150px;">
<br/>
<div class="headerCap"></div>
  <div class="span6">  
</div>
<div class="tabbable">

 <ul class="nav nav-tabs" id="mainTaxTabs"> 
  
        <li><a data-target="#list"  href="clientByFirm.do" class="active" data-toggle="tab">Report</a></li>
   </ul> 
 
   <ul class="nav nav-tabs" id="taskListByPartnerTabs"> 
        <li><a data-target="#list"  href="taskListByPartner.do" class="active" data-toggle="tab">Report</a></li>
        <!-- <li><a data-target="#edit"  onClick=TabClk(); data-toggle="tab">Add/Edit</a></li> -->
   </ul> 
  								
   <ul class="nav nav-tabs" id="taskByDueDateTabs"> 
        <li><a data-target="#list"  href="taskByDueDate.do" class="active" data-toggle="tab">Report</a></li>
   </ul> 
   <ul class="nav nav-tabs" id="clientListByPartnerTabs"> 
        <li><a data-target="#list"  href="clientListbyPartner.do" class="active" data-toggle="tab">Report</a></li>
   </ul> 
   <ul class="nav nav-tabs" id="filingsByClientTabs"> 
        <li><a data-target="#list"  href="filingsByClient.do" class="active" data-toggle="tab">Report</a></li>
   </ul>   
   <ul class="nav nav-tabs" id="taskListByStatusTabs"> 
        <li><a data-target="#list"  href="taskListByStatus.do" class="active" data-toggle="tab">Report</a></li>
   </ul>  
   <ul class="nav nav-tabs" id="taskListByFirmTabs"> 
        <li><a data-target="#list"  href="taskListByFirm.do" class="active" data-toggle="tab">Report</a></li>
   </ul>
 <ul class="nav nav-tabs" id="mainRepTabs"> 
  
        <li><a data-target="#list"  href="clientListwithDetails.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
 <ul class="nav nav-tabs" id="MDLRepTabs"> 
  
        <li><a data-target="#list"  href="clientListByMisDeadLines.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
 <ul class="nav nav-tabs" id="tlbeRepTab"> 
  
        <li><a data-target="#list"  href="taskListByEmp.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
 <ul class="nav nav-tabs" id="ddbtRepTab"> 
  
        <li><a data-target="#list"  href="dueDateByTask.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
  <ul class="nav nav-tabs" id="tlbsRepTab"> 
  
        <li><a data-target="#list"  href="newTaxListByStaff.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
 <ul class="nav nav-tabs" id="tlbftRepTab"> 
  
        <li><a data-target="#list"  href="taskListByFilingType.do" class="active" data-toggle="tab">Report</a></li>
      
 </ul>
 <div class="tab-content">
        <div class="tab-pane" id="list"></div>
    </div>
 </div>
 </div>
 
 <script>
$(function() {
	
	$("#taskListByFilingTabs").tab().hide(); 
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide();
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide();
	$("#taskListByPartnerTabs").tab().hide(); 
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#ddbtRepTab").tab().hide(); 
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#mainTaxTabs").tab().show(); // initialize tabs
	$("#mainTaxTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	$("#mainTaxTabs").tab(); // reinitialize tabs
	});
	});
	$('#mainTaxTabs a:first').tab("show"); // Load and display content for first tab

 
});
function TabHide(){
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide();
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide();
	$("#taskListByPartnerTabs").tab().hide(); 
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainTaxTabs").tab().show(); 
	$("#mainTaxTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	  	$("#mainTaxTabs").tab();
	});
	});
	$('#mainTaxTabs a:first').tab("show"); 
	
}
function TabTaskListPartnerHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide();
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide();
	$("#taskListByPartnerTabs").tab().show(); // initialize tabs
	 $("#taskListByPartnerTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#taskListByPartnerTabs").tab(); // reinitialize tabs
	});
	});
	$('#taskListByPartnerTabs a:first').tab("show"); 	
}
function TabTaskDueDateHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide(); 
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide();
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#taskByDueDateTabs").tab().show(); // initialize tabs
	 $("#taskByDueDateTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#taskByDueDateTabs").tab(); // reinitialize tabs
	});
	});
	$('#taskByDueDateTabs a:first').tab("show"); 	
}
function TabClientListByPartnerHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide();
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#clientListByPartnerTabs").tab().show(); // initialize tabs
	 $("#clientListByPartnerTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#clientListByPartnerTabs").tab(); // reinitialize tabs
	});
	});
	$('#clientListByPartnerTabs a:first').tab("show"); 	
}
function TabFilingsByClientHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#filingsByClientTabs").tab().show(); // initialize tabs
 	$("#filingsByClientTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
   	$("#filingsByClientTabs").tab(); // reinitialize tabs
});
});
$('#filingsByClientTabs a:first').tab("show");
}
function TabTaskListByStatusHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#taskListByStatusTabs").tab().show(); // initialize tabs
 	$("#taskListByStatusTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
   	$("#taskListByStatusTabs").tab(); // reinitialize tabs
});
});
$('#taskListByStatusTabs a:first').tab("show");
}
function TabTaskListByFirmHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#taskListByFirmTabs").tab().show(); // initialize tabs
 	$("#taskListByFirmTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
   	$("#taskListByFirmTabs").tab(); // reinitialize tabs
	});
	});
	$('#taskListByFirmTabs a:first').tab("show");	
}
function clientTabHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#MDLRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#mainRepTabs").tab().show(); 
	 $("#mainRepTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#mainRepTabs").tab(); 
	});
	});
	$('#mainRepTabs a:first').tab("show"); 
	
}
function MDLTabHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();
	$("#mainTaxTabs").tab().hide(); 
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#MDLRepTabs").tab().show();
	 $("#MDLRepTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#MDLRepTabs").tab(); 
	});
	});
	$('#MDLRepTabs a:first').tab("show"); 
	
}
function tlbeTabHide(){
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#ddbtRepTab").tab().hide(); 
	$("#MDLRepTabs").tab().hide();
	$("#mainTaxTabs").tab().hide(); 
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#tlbeRepTab").tab().show();
	 $("#tlbeRepTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#tlbeRepTab").tab(); 
	});
	});
	$('#tlbeRepTab a:first').tab("show"); 
	
}
function ddbtTabHide(){
	$("#tlbeRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide(); 
	$("#MDLRepTabs").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#tlbftRepTab").tab().hide(); 
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide(); 
	$("#ddbtRepTab").tab().show();
	 $("#ddbtRepTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#ddbtRepTab").tab(); 
	});
	});
	$('#ddbtRepTab a:first').tab("show"); 
	
}
function tlbsTabHide(){
	$("#MDLRepTabs").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbftRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide();  
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide();
	$("#tlbsRepTab").tab().show();
	 $("#tlbsRepTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#tlbsRepTab").tab(); 
	});
	});
	$('#tlbsRepTab a:first').tab("show"); 
	
}
function tlbftTabHide(){
	$("#MDLRepTabs").tab().hide();
	$("#mainTaxTabs").tab().hide();
	$("#ddbtRepTab").tab().hide(); 
	$("#tlbeRepTab").tab().hide(); 
	$("#tlbsRepTab").tab().hide();
	$("#mainRepTabs").tab().hide();
	$("#taskListByFirmTabs").tab().hide(); 
	$("#taskListByStatusTabs").tab().hide(); 
	$("#filingsByClientTabs").tab().hide(); 
	$("#clientListByPartnerTabs").tab().hide(); 
	$("#taskByDueDateTabs").tab().hide(); 
	$("#taskListByPartnerTabs").tab().hide(); 
	$("#tlbftRepTab").tab().show(); 
	 $("#tlbftRepTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#tlbftRepTab").tab(); 
	});
	});
	$('#tlbftRepTab a:first').tab("show"); 
	
}
</script>