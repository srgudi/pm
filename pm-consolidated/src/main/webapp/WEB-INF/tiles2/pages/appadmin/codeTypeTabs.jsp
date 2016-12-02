<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="codeTypeTabs">       
        <li><a href="#codeTypehome" onclick="codeTypeList()" data-toggle="tab"><i class="icon-list-ol"></i><spring:message code="label.codeTypelist"/></a></li>
        <li><a data-target="#codeTypefoo"  onClick=codeType(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.codeTypeAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="codeTypehome">
        <%@ include file="codeTypeList.jsp" %> 
        </div>
        <div class="tab-pane" id="codeTypefoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#codeTypeTabs").tab(); // initialize tabs
	$("#codeTypeTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#codeTypeTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#codeTypeTabs a:first').tab("show"); // Load and display content for first tab

	});
function codeType(){
	$('#codeTypefoo').load('adminCodeType.do');
	$('#codeTypeTabs a:last').tab('show');
	$('#codeTypehome').hide();
	$('#codeTypefoo').show();
}

function codeTypeList(){
	$('#codeTypehome').show();
	$('#codeTypefoo').hide();	
}
</script>