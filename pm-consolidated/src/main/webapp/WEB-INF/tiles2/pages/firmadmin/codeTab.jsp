<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="codeTab">    
        <li><a data-target="#codehme"  href="managePartyCode.do"  data-toggle="tab"><i class="icon-bookmark"></i><spring:message code="label.code"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="codehme">
       
        </div>
    </div>
</div>

<script>
$(function() {
	$("#codeTab").tab(); // initialize tabs
	$("#codeTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#codeTab").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#codeTab a:first').tab("show"); // Load and display content for first tab

	});

</script>