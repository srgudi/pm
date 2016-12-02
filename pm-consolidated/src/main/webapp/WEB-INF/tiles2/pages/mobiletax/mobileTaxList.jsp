<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
$(function() {
    $("#viewNewTaxForm").click(function() {
        $.mobile.changePage("../mobiletax/mobileTaxModule.do","slideup");
    });        
});
</script> 
<%-- <c:url value="/mobiletask/mobileTaskmodule.do" var="mobiletaskModuleUrl"/> --%>
<security:authorize access="hasAnyRole('ROLE_FIRM_PARTNER','ROLE_STAFF')">
	                	<a id="viewNewTaxForm" style="text-decoration:none;">
	                    	 <button type="button" id="viewNewTaxForm"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Tax</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
			
	  </security:authorize> 
 
<input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />
  <div id="grid_wrapper" style="overflow:auto;">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getTaxList">
	<caption title="" class="captionFont">TaxList</caption>
	 <colgroup>
	 <col style="width: 5%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 5%;">
		</colgroup> 
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Jurisdiction</th>
			  <th class="cyan b center">Staff In Charge</th>
			  <th class="cyan b center">Client Staff In-Chager</th>
			  <th class="cyan b center">Tax Return Type</th>
			  <th class="cyan b center">Tax Creator</th>
			  <th class="cyan b center">FormatedtaskCreatedDate</th>
			  <th class="cyan b center">Status</th>
			  <th class="cyan b center">edit</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	</div>
	<input type="hidden" name="inValidClientId" id="firmId"	value="${firmId}" />
	<script>
	$(function(){
		var clientId = ${clientId};
		var firmPracticeId = ${firmPracticeId};
		  $("#getTaxList").dataTable({
					"bJQueryMobileUI" : true,
					"bFilter" : true,
					"sPaginationType" : "bootstrap",
					"aaSorting" : [ [ 0, "desc" ] ],
					"bInfo" : true,
					"oLanguage" : {
						"sLengthMenu" : "_MENU_ records per page",
						"sProcessing" : "Loading.....",
						"sZeroRecords" : "No client is found. Click 'Add/Edit' tab to get started."
					},
					"sAjaxSource": 'mobileTaxModuleList.do?clientId=' + clientId + '&firmPracticeId=' + firmPracticeId,
					"bProcessing" : 'true',
					"bServerSide" : 'true',
					"bDeferRender" : 'false',
					"oTableTools" : {
						"sRowSelect" : "single"
					},
			    "aoColumns": [
								{
									"bSortable" : false,
									"fnRender" : function(obj) {
										var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
				                        return retVal;
				                    }
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[1];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[2];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[3];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[4];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[5];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[6];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[7];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[8];
									}
								},
								{
									"sClass" : "jqmSorter",
									"fnRender" : function(obj) {
										return obj.aData[9];
									}
								}]
		       
		         });
	});

</script>
<script>
function TaxEdit(entityKey) {
		window.location = '../mobiletax/mobileTaxModule.do?taxId=' + entityKey;
}	
</script>
