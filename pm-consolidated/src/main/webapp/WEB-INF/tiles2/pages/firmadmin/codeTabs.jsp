<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="codeTabs">    
        <li><a data-target="#codehome"  href="managePartyCode.do"  data-toggle="tab"><spring:message code="label.code"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="codehome">
        
        </div>
    </div>
</div>

<script>
$(function() {
	$("#codeTabs").tab(); // initialize tabs
	$("#codeTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#codeTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#codeTabs a:first').tab("show"); // Load and display content for first tab

	});

</script>