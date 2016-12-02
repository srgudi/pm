<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="firmStaffTabs">    
        <li><a href="#firmStaffhome" onclick="firmStaffList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.staffList"/></a></li>
        <li><a data-target="#firmStaffFoo"  onClick=FirmStaff(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.staffAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="firmStaffhome">
        <%@ include file="firmStaffList.jsp" %> 
        </div>
        <div class="tab-pane" id="firmStaffFoo"></div>
    </div>
</div>

<script>
$(function() {
	$("#firmStaffTabs").tab(); // initialize tabs
	$("#firmStaffTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#firmStaffTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#firmStaffTabs a:first').tab("show"); // Load and display content for first tab

	});
function FirmStaff(){
	$('#firmStaffFoo').load('manageFirmStaff.do');
	$('#firmStaffTabs a:last').tab('show');
	$('#firmStaffhome').hide();
	$('#firmStaffFoo').show();
}
function firmStaffList(){
	$('#firmStaffhome').show();
	$('#firmStaffFoo').hide();	
}
</script>