<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="firmTabs">       
        <li><a href="#firmhome" onclick="firmList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.firmList"/></a></li>
        <li><a data-target="#firmfoo"  onClick=Firm(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.firmAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="firmhome">
        <%@ include file="adminList.jsp" %> 
        </div>
        <div class="tab-pane" id="firmfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#firmTabs").tab(); // initialize tabs
	$("#firmTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#firmTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#firmTabs a:first').tab("show"); // Load and display content for first tab

	});
function Firm(){
	$('#firmfoo').load('adminFirmModule.do');
	$('#firmTabs a:last').tab('show');
	$('#firmhome').hide();
	$('#firmfoo').show();
}
function firmList(){
	$('#firmhome').show();
	$('#firmfoo').hide();
}
</script>