<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<script type="text/javascript">
$(function() {
    $("#viewclientList").click(function() {
       // $.mobile.changePage("/pm-new/mobileclient/mobileClientList.do","slideup");
    	 $.mobile.changePage("/pm-new/mobileclient/mainMobileClient.do","slideup");
    });        
});
$(function() {
    $("#viewtaskList").click(function() {
        $.mobile.changePage("/pm-new/mobiletask/mobileTaskList.do","slideup");
    });        
});
$(function() {
    $("#viewfirmadminList").click(function() {
        $.mobile.changePage("/pm-new/mobilefirmadmin/firmStaffMobileList.do","slideup");
    });        
});
$(function() {
    $("#viewcalendar").click(function() {
        $.mobile.changePage("/pm-new/calendar/calendarMobile.do","slideup");
    });        
});
/* $(function() {
    $("#viewreports").click(function() {
        $.mobile.changePage("/pm/mobilereports/clientByFirmJASPERMobile.do","slideup");
    });        
}); */
$(function() {
    $("#viewadminList").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileAdminList.do","slideup");
    });        
});
</script>
 <script type="text/javascript">
$(window).bind('orientationchange','load', function(event){
    if(event.orientation) {
          if(event.orientation == 'portrait') {
				jQuery("#mobileClientGrid").setGridWidth($('#grid_wrapper').width()+5, true);
				jQuery("#mobileClientStaff").setGridWidth($('#grid_wrapper').width()+5, true);
				jQuery("#mobileTaskGrid").setGridWidth($('#grid_wrapper').width()+5, true);
				//jQuery("#mobileDashboardGrid").setGridWidth($('#grid_wrapper').width()+5, true);
				//alert("portrait");
				jQuery("#'mobileTaxmoduleGrid'").setGridWidth($('#grid_wrapper').width()+5, true);
	          } else if (event.orientation == 'landscape') {
	        	  jQuery("#mobileClientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#mobileClientStaff").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#mobileTaskGrid").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  //jQuery("#mobileDashboardGrid").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#'mobileTaxmoduleGrid'").setGridWidth($('#grid_wrapper').width()-5, true);
                     } 
          } else {
                // optional... PC-version javascript for example
                
                }

    }).trigger('load');	
</script>

<body>  
<c:url value="/mobiletask/mobileTaskList.do" var="mobiletaskListUrl"/>
 <c:url value="/mobileclient/mainMobileClient.do" var="mobileClientListUrl"/> 
<c:url value="/mobiletask/mobileTaskmodule.do" var="mobiletaskModuleUrl"/>  
 <c:url value="/mobiledashboard/mobiledashboard.do" var="mobiledashboardUrl"/>   

  <div data-role="content">
       
	<%--  <a href="#" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'
        onClick='location.href="<c:out value='${mobileClientListUrl}'/>"'>Client</a>  --%>
        <a  id="viewclientList" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'>Client</a> 
        
	 <%--  <a href="#" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' 
	  onClick='location.href="<c:out value='${mobiletaskListUrl}'/>"'>Task</a> --%>
	   <a  id="viewtaskList" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Task</a>
	
	   <a href="#" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' 
	  onClick='location.href="<c:out value='${mobiledashboardUrl}'/>"'>DashBoard</a> 
	  <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
	  <a  id="viewfirmadminList" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Firm Admin</a>
	  </security:authorize>
	  <a  id="viewcalendar" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Calendar</a>
	  
	  <!-- <a  id="viewreports" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Reports</a> -->
	 <security:authorize access="hasAnyRole('ROLE_APP_ADMIN')">
     	<a  id="viewadminList" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Administration</a>
     </security:authorize>
      <%--  <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
        <a href="#" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${manageFirmStaffUrl}'/>"'/>Firm Admin</a>
    </security:authorize>
    <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
        <a href="#"    data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' style="display:none; " onClick='location.href="<c:out value='${manageFirmStaffUrl}'/>"'/>Firm
            Admin</a>
    </security:authorize> --%>
</div>

</body> 


 
