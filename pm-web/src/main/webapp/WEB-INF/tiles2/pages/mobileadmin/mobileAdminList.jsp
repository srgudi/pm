<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<c:url value="/mobileadmin/mobileAdminFirmModule.do" var="mobileAdminFirmModuleUrl">
    </c:url>
    
    <a href="<c:out value='${mobileAdminFirmModuleUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" 	                    	 
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Firm</span>
	                    	</button> 
	                	</a>

 <div id="grid">	
<div id="grid_wrapper">
	<table id="mobileFirmList"></table>
	<div id="firmPager" class="scroll"></div>
</div>

<script type="text/javascript">
var status = ["All", "Active", "Inactive"];
var statusStr = ":All;Active:Active;Inactive:Inactive";

	firmId = $("#firmId").val();
	partyId = $("#partyId").val();				
	
	 jQuery("#mobileFirmList").jqGrid({
		 
		 
		 "hoverrows":false,
         "viewrecords":true,
         "jsonReader": {root : "rows",
         page : "page",
         total : "total",
         records : "records",
         repeatitems : false,
         cell : "cell",
         id : "id",
         userdata : "userdata"},
         "gridview":true,
         "loadonce":true,
         "url" : 'mobilefirmList.do?partyId='+partyId,
         pager : jQuery('#pager'),
         "rowNum":10,
         "rowList" : [20,40,60],
         "sortname":"firstName",
         "height":200,
         "width" :300,
         "mtype" : "GET",
         "datatype":"json",
         caption : 'Firm List',
		colNames:['Name', 'Office Number','Home Number','Email Address', 'Status'],
		colModel :[
			{name:'name', index:'name',  width: 30, formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileAdminFirmModule.do', 
					idName:'id'}},
				{name:'officeNumber', index:'officeNumber',  width: 30},
				{name:'homeNumber', index:'homeNumber',  width: 30},
				{name:'emailAddress', index:'emailAddress',  width: 30},
				{name:'status',index:'status',width:30, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
		   		 	formatter:'select', stype: 'select', sorttype:
			   		 	function(cell) {return status[cell];},
			   		 edittype:'select', editoptions: { value: statusStr }, 
			   		searchoptions:{ sopt:['eq'] }},
	    ],
	    "pager":"#firmPager"
			});
	 
	 jQuery("#mobileFirmList").jqGrid('filterToolbar', {
         stringResult : true,
         searchOnEnter : false
     });
	 $('#firmPager').css("height", "50px");
</script>
</div>