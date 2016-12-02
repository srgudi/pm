<div class="tabbable">
   <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="insuranceTabs">   
        <li><a href="#insurancehome" onclick="inscList()" data-toggle="tab"><spring:message code="label.insuranceList"/></a></li>
        <li><a data-target="#insurancefoo"  onClick=Insurance(); data-toggle="tab"><spring:message code="label.insuranceAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="insurancehome">
        <%@ include file="clientInsList.jsp" %> 
        </div>
        <div class="tab-pane" id="insurancefoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#insuranceTabs").tab(); // initialize tabs
	$("#insuranceTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#insuranceTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#insuranceTabs a:first').tab("show"); // Load and display content for first tab

	});
function Insurance(){
	$('#insurancefoo').load('clientInsurance.do');
	$('#insuranceTabs a:last').tab('show');
	$('#insurancehome').hide();
	$('#insurancefoo').show();
}

function inscList(){
	$('#insurancehome').show();
	$('#insurancefoo').hide();
}
</script>