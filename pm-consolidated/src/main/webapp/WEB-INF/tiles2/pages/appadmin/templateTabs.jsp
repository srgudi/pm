<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="templateTabs">       
        <li><a href="#templatehome" onclick="templateList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.templateList"/></a></li>
        <li><a data-target="#templatefoo"  onClick=Template(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.templateAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="templatehome">
        <%@ include file="templateList.jsp" %> 
        </div>
        <div class="tab-pane" id="templatefoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#templateTabs").tab(); // initialize tabs
	$("#templateTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#templateTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#templateTabs a:first').tab("show"); // Load and display content for first tab

	});
function Template(){
	$('#templatefoo').load('adminTaskNotificationTemplate.do');
	$('#templateTabs a:last').tab('show');
	$('#templatehome').hide();
	$('#templatefoo').show();
}
function templateList(){
	$('#templateTabs a:last').tab('show');
	$('#templatehome').show();
	$('#templatefoo').hide();	
}
</script>