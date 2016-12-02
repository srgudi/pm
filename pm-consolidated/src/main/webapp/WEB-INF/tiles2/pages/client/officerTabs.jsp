<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="officerTabs">   
        <li><a href="#officerhome" onclick="offList()" data-toggle="tab"><spring:message code="label.officersList"/></a></li>
        <li><a data-target="#officerfoo"  onClick=Officer(); data-toggle="tab"><spring:message code="label.officresAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="officerhome">
        <%@ include file="ClientOfficersAndShareHolderList.jsp" %> 
        </div>
        <div class="tab-pane" id="officerfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#officerTabs").tab(); // initialize tabs
	$("#officerTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#officerTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#officerTabs a:first').tab("show"); // Load and display content for first tab

	});
function Officer(){
	$('#officerfoo').load('clientOfficersAndShareHolders.do');
	$('#officerTabs a:last').tab('show');
	 $('#officerhome').hide();
	 $('#officerfoo').show();
}
function offList(){
	 $('#officerhome').show();
	 $('#officerfoo').hide();
}
</script>