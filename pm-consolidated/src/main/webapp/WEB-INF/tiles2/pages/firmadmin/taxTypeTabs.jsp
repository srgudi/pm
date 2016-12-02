<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="taxTypeTabs">    
        <li><a href="#taxTypehome"  onClick=TaxList(); data-toggle="tab"> <i class="icon-list-ol"></i><spring:message code="label.taxTypeList"/></a></li>
        <li><a data-target="#taxTypeFoo"  onClick=TaxEdit(); data-toggle="tab"><i class="icon-save"></i><spring:message code="label.taxTypeAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="taxTypehome">
        <%@ include file="taxTypeList.jsp" %> 
        </div>
        <div class="tab-pane" id="taxTypeFoo"></div>
    </div>
</div>

<script>
$(function() {
	$("#taxTypeTabs").tab(); // initialize tabs
	$("#taxTypeTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#taxTypeTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#taxTypeTabs a:first').tab("show"); // Load and display content for first tab

	});
function TaxEdit(){
	$('#taxTypeFoo').load('manageTaxModule.do');
	$('#taxTypeTabs a:last').tab('show');
	 $('#taxTypeFoo').show();
	 $('#taxTypehome').hide();
	
}

function TaxList(){
	 $('#taxTypehome').show();
	 $('#taxTypeFoo').hide();
	}
</script>