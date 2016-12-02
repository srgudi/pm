<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="transferTabs">  
        <li><a href="#transferhome" onclick="tranList()" data-toggle="tab"><spring:message code="label.agentList"/></a></li>
        <li><a data-target="#transferfoo"  onClick=Transfer(); data-toggle="tab"><spring:message code="label.agentAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="transferhome">
        <%@ include file="clientTransferAgentList.jsp" %> 
        </div>
        <div class="tab-pane" id="transferfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#transferTabs").tab(); // initialize tabs
	$("#transferTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#transferTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#transferTabs a:first').tab("show"); // Load and display content for first tab

	});
function Transfer(){
	$('#transferfoo').load('clientTransferAgent.do');
	$('#transferTabs a:last').tab('show');
	$('#transferhome').hide();
	$('#transferfoo').show();
}

function tranList(){
	$('#transferhome').show();
	$('#transferfoo').hide();
}
</script>