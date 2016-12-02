 <div class="tabbable">
     <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="stfTabs">     
        <li><a href="#stfhome"  onclick="StaffList()"  data-toggle="tab"><spring:message code="label.staffList"/></a></li>
        <li><a data-target="#stffoo"  onClick=Staff(); data-toggle="tab"><spring:message code="label.staffAddOrEdit"/></a></li>
    </ul>
 
    <div class="tab-content">
        <div class="tab-pane active" id="stfhome">
       <%@ include file="clientStaffList.jsp" %> 
        </div>
        <div class="tab-pane" id="stffoo"></div>
    </div>
</div>


<script>
$(function() {
	$("#stfTabs").tab(); // initialize tabs
	$("#stfTabs").bind("show", function(e) {
	//	alert("event");
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");

	if (typeof(contentURL) != 'undefined') {
	// state: has a url to load from
	$(contentID).load(contentURL, function(){
	$("#stfTabs").tab(); // reinitialize tabs
	});

	} else {
	//state: no url, to show static data
	$(contentID).tab('show');
	}
	});
	$('#stfTabs a:first').tab("show"); // Load and display content for first tab

	});
function Staff(){
	//alert("staff");
	$('#stffoo').load('clientStaff.do');
	$('#stfTabs a:last').tab('show');
	 $('#stfhome').hide();
	 $('#stffoo').show();
}

function StaffList(){
	//alert("slist");
	 $('#stfhome').show();
	 $('#stffoo').hide();
	}
</script>