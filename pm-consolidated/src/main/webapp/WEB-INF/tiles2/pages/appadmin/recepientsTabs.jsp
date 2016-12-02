<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="recepientsTabs">       
        <li><a href="#recepienthome" onclick="recepientList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.recepientsList"/></a></li>
        <li><a data-target="#recepientfoo"  onClick=Recepient(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.recepientsAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="recepienthome">
        <%@ include file="recepientList.jsp" %> 
        </div>
        <div class="tab-pane" id="recepientfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#recepientsTabs").tab(); // initialize tabs
	$("#recepientsTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#recepientsTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#recepientsTabs a:first').tab("show"); // Load and display content for first tab

	});
function Recepient(){
	$('#recepientfoo').load('adminTaskNotificationRecipient.do');
	$('#recepientsTabs a:last').tab('show');
	$('#recepienthome').hide();
	$('#recepientfoo').show();
}
function recepientList(){
	$('#recepienthome').show();
	$('#recepientfoo').hide();	
}
</script>