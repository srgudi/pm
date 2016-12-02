<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="locationTabs">       
        <li><a href="#locationhome" onclick="locList()" data-toggle="tab"><spring:message code="label.locationList"/></a></li>
        <li><a data-target="#locationfoo"  onClick=Location(); data-toggle="tab"><spring:message code="label.locationAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="locationhome">
        <%@ include file="clientLocList.jsp" %> 
        </div>
        <div class="tab-pane" id="locationfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#locationTabs").tab(); // initialize tabs
	$("#locationTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#locationTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#locationTabs a:first').tab("show"); // Load and display content for first tab

	});
function Location(){
	$('#locationfoo').load('clientLocation.do');
	$('#locationTabs a:last').tab('show');
	 $('#locationhome').hide();
	 $('#locationfoo').show();
}
function locList(){
	 $('#locationhome').show();
	 $('#locationfoo').hide();
}
</script>