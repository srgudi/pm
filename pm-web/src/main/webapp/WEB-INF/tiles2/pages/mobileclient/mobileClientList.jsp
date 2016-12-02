
<%@ include file="../../layout/PM-INCLUDES.jsp" %>
 <input type="hidden" name="firmPracticeId" id="firmPracticeId"	value="${firmPracticeId}" />
   <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
  <c:url value="/mobileclient/mobileClientDetail.do" var="mobileClientModuleUrl">
    </c:url>
    
    <a href="<c:out value='${mobileClientModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" 	                    	 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Client</span>
	                    	</button> 
	                	</a>
	  </security:authorize> 

 <div id="grid_wrapper">
    <table id='mobileClientGrid'></table>
    <div id='clientPager'></div>
</div>
    <!-- Java Script Code -->
    <script type='text/javascript'>
    var firmPracticeId = $("#firmPracticeId").val();
        jQuery('#mobileClientGrid').jqGrid({
            "hoverrows":false,
            "viewrecords":true,
            "jsonReader": {root : "rows",
            page : "page",
            total : "total",
            records : "records",
            repeatitems : false,
            cell : "cell",
            id : "partyId",
            userdata : "userdata"},
            "gridview":true,
            "loadonce":true,
            "url" : 'mobileClientGetList.do',
            //"scrollPaging":true,
            pager : jQuery('#pager'),
            //"autowidth":true,
           /// "footerrow": true,
           /// "userDataOnFooter": true,
            "rowNum":10,
            "rowList" : [20,40,60],
            "sortname":"clientName",
            "height":200,
            "width" :300,
            //shrinkToFit: false,
            "mtype" : "GET",
            "datatype":"json",
            caption : 'Client List',
            //editurl:'<c:url value="/saveClientAjaxList.do"/>',
            colNames : [ 
							'Client Name',
							'Partner-In-Charge',
							'Office Contact',
							'Email'],
							colModel : [
										
										{
											name : 'name',
											index : 'name',
											width: 30,
											
											formatter : 'showlink',
											formatoptions : {
												baseLinkUrl : 'mobileClientDetail.do',
												idName : 'clientId'
											}
										},
										{
											name : 'inChargePerson',
											index : 'inChargePerson',
										    width: 30
										},
										{
											name : 'officeNumber',
											index : 'officeNumber',
										    width: 30
										},
										{
											name : 'emailAddress',
											index : 'emailAddress',
											 width: 30
												
											
										}

								],
            
          
                    
            "pager":"#clientPager"
        });
      /*  // $("#grid").jqGrid('footerData', 'set', { "ShipName":"Total:"}, true); */
    $('#clientPager').css("height", "50px");
   
   
    </script>

 
  