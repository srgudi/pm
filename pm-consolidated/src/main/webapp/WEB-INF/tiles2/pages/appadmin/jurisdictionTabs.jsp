<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="juriTabs">       
        <li><a href="#jurihome" onclick="juriList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.jurisdictionList"/></a></li>
        <li><a data-target="#jurifoo"  onClick=Juri(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.jurisdictionAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="jurihome">
        <%@ include file="juridList.jsp" %> 
        </div>
        <div class="tab-pane" id="jurifoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#juriTabs").tab(); // initialize tabs
	$("#juriTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#juriTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#juriTabs a:first').tab("show"); // Load and display content for first tab

	});
function Juri(){
	$('#jurifoo').load('adminJurisdiction.do');
	$('#juriTabs a:last').tab('show');
	$('#jurihome').hide();
	$('#jurifoo').show();
}
function juriList(){
	$('#juriTabs a:first').tab('show');
	$('#jurihome').show();
	$('#jurifoo').hide();
}
</script>