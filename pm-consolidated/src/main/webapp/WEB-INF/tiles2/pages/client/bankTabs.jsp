<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="myTabs">    
        <li><a href="#home" onclick="bankList()" data-toggle="tab"><spring:message code="label.bankList"/> <!-- Bank List --></a></li>
        <li><a data-target="#foo"  onClick=Bank(); data-toggle="tab"><spring:message code="label.bankAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="home">
        <%@ include file="clientBankList.jsp" %> 
        </div>
        <div class="tab-pane" id="foo"></div>
    </div>
</div>


<script>
$(function() {
	$("#myTabs").tab(); // initialize tabs
	$("#myTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#myTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#myTabs a:first').tab("show"); // Load and display content for first tab

	});
function Bank(){
	$('#foo').load('clientBank.do');
	$('#myTabs a:last').tab('show');
	$('#home').hide();
	 $('#foo').show();
}
function bankList(){
	 $('#home').show();
	 $('#foo').hide();
}
</script>