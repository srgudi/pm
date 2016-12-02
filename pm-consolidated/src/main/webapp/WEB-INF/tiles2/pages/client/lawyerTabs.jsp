<div class="tabbable">
   <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="lawyerTabs">       
        <li><a href="#lawyerhome" onclick="lawList()" data-toggle="tab"><spring:message code="label.lawyersList"/></a></li>
        <li><a data-target="#lawyerfoo"  onClick=Lawyer(); data-toggle="tab"><spring:message code="label.lawyersAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="lawyerhome">
        <%@ include file="clientLawList.jsp" %> 
        </div>
        <div class="tab-pane" id="lawyerfoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#lawyerTabs").tab(); // initialize tabs
	$("#lawyerTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#lawyerTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#lawyerTabs a:first').tab("show"); // Load and display content for first tab

	});
function Lawyer(){
	$('#lawyerfoo').load('clientLawyer.do');
	$('#lawyerTabs a:last').tab('show');
	$('#lawyerhome').hide();
	$('#lawyerfoo').show();
}
function lawList(){
	 $('#lawyerhome').show();
	 $('#lawyerfoo').hide();
}
</script>