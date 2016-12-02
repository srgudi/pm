<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="documentTabs">    
        <li><a data-target="#documenthome" onclick="docUpload()"  data-toggle="tab"><spring:message code="label.documentUpload"/></a></li>
        <li><a data-target="#documentfoo"  onclick="docSearch()" data-toggle="tab"><spring:message code="label.documentSearch"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="documenthome">
      
        </div>
        <div class="tab-pane" id="documentfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#documentTabs").tab(); // initialize tabs
	$("#documentTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#documentTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#documentTabs a:first').tab("show"); // Load and display content for first tab

	});
	
function docUpload(){
	$('#documenthome').load('clientDocuments.do');
	$('#documentTabs a:first').tab('show');
	$('#documenthome').show();
	$('#documentfoo').hide();
}

function docSearch(){
	$('#documentfoo').load('clientDocumentSearch.do');
	$('#documentTabs a:last').tab('show');
	$('#documenthome').hide();
	$('#documentfoo').show();
}

</script>