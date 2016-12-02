<%-- <%@ include file="PM-INCLUDES.jsp" %>

 <tiles:insertAttribute name="html-header"/> 
	<c:set var="mainTabIndex" value="0"/>
	<c:set var="subTabIndex" value="0"/>
	<body>
	<tiles:insertAttribute name="banner"/>		
<div class="container_12" style="margin-top:-15px;">

<div id="maintabs" class="ui-tabs-hide">
                    <c:url value="/dashboard/dashboard.do" var="dashboardUrl"/>
					<c:url value="/task/taskList.do" var="taskListUrl" />
					<c:url value="/client/clientList.do" var="clientUrl" />
					<c:url value="/firmadmin/manageFirmStaff.do" var="manageFirmStaffUrl" />
					<c:url value="/appadmin/adminFirmModule.do" var="adminFirmModuleUrl" />
					<c:url value="/tax/taxModule.do?clientId=${param.clientId}&firmPracticeId=${firmPracticeId}" var="taxModuleUrl" />
					<c:url value="/calendar/calendar.do" var="calendarUrl" />
					<c:url value="/reports/index.do" var="reportUrl" />
					<c:url value="/reports/filingsByClientReport.do" var="filingsByClientReportUrl" />
					  <ul style="font-size:105%"> 
 					    <li><a href="#tabs-1"><img src="<c:url value='/NEW_UI/images/house.png'/>" height="12px" />&nbsp;&nbsp;Dashboard&nbsp;&nbsp;</b></a></li>  
					    <li><a href="#tabs-2" onClick='location.href="<c:out value='${taskListUrl}'/>"'/>Tasks</a></li>
					    <li><a href="#tabs-3" onClick='location.href="<c:out value='${clientUrl}'/>"'/>Clients</a></li>
					    <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER','ROLE_APP_ADMIN')">
                        <c:if test="${not empty param.clientId}">
                        <li><a href="#tabs-8" onClick="location.href='<c:out value="${taxModuleUrl}"/>'">Taxes</a></li>
                        </c:if>
                        </security:authorize>
                        <c:if test="${empty param.clientId}">
                        <li style="display:none; "><a href="#tabs-8" onClick="location.href='<c:out value="${taxModuleUrl}"/>'">Taxes</a></li>
                        </c:if>
					    <c:if test="${empty param.clientId}">
					    <li style="display:none; "><a href="#tabs-8"  onClick="location.href='<c:out value="${taxModuleUrl}"/>'">Tax Info</a></li>
					    </c:if>
					    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
                        <li><a href="#tabs-4" onClick='location.href="<c:out value='${manageFirmStaffUrl}'/>"'/>Firm Admin</a></li>
                        </security:authorize>
                        <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
                        <li style="display:none; "><a href="#tabs-4" onClick='location.href="<c:out value='${manageFirmStaffUrl}'/>"'/>Firm
                         Admin</a></li>
                        </security:authorize>
					    <security:authorize access="hasAnyRole('ROLE_APP_ADMIN')">
    	                 <li><a href="#tabs-5" onClick="location.href='<c:out value="${adminFirmModuleUrl}"/>'">Administration</a></li>
                        </security:authorize>
					    <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER','ROLE_FIRM_ADMIN')">
					    <li style="display:none; "><a href="#tabs-5"  onClick="location.href='<c:out value="${adminFirmModuleUrl}"/>'">Administration</a></li>
					    </security:authorize>
					    <li><a href="#tabs-6"  onClick="location.href='<c:out value="${calendarUrl}"/>'">Calendar</a></li>
    <li><c:url value="/reports/index.do" var="reportUrl"/><a href="#tabs-7"  onClick="location.href='<c:out value="${reportUrl}"/>'">Reports</a>  </li>

                <!--        <li><a href="#tabs-7" onClick="location.href='<c:out value="${reportUrl}"/>'">Reports</a></li>  -->
	
  </ul> 
  <div id="tabs-1">
  </div> 
  <div id="tabs-2"> 
    
      
    </div> 
  </div> 
  <div id="tabs-3"> 
     
   
  </div>
  <div id="tabs-3"> 
   
  </div> 
</div> 
<div id="tabs-7">

<c:choose>


 <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'report')}">
 
 
  <div id="subtabs-report"> 
   		 <ul>
   			<c:url  value="/reports/index.do" var="reportUrl" />
   			<c:url value="/reports/filingsByClientReport.do" var="filingsByClientReportUrl"></c:url>
      	<!-- 	<li><a href="#subtabs-1"  onClick='location.href="<c:out value='${filingsByClientReportUrl}'/>"'>Filings By Client </a></li>   -->      		
    		</ul> 
   		 <div id="subtabs-1"></div> 
		<br/>
		<tiles:insertAttribute name="body"/>
  </div>
  </c:when>    
  
  

 <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'filingsByClientReport')}">
 
 
  
		<tiles:insertAttribute name="body"/>
  
  </c:when> 
  <c:otherwise />
  </c:choose>
  
</div>
<div id="tabs-4"> 
   
</div>

<div id="tabs-5"> 
  
</div>
<div id="tabs-8"> 
   
</div>


  
  <c:choose>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'index')}">
		<c:set var="mainTabIndex" value="7"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		


 
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'filingsByClientReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientListByMisDeadLinesReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskByDueDateReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'dueDatebytaskReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskModuleReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskListByFirmReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskListByEmpReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientListByFirmReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskListByFilingTypeReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskListByStatusReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientListwithDetailsReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientListbyPartnerReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		<c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'newTaxListByStaffReport')}">
		<c:set var="mainTabIndex" value="8"/>
		<c:set var="subTabIndex" value="0"/>
		</c:when>
		
		
		
		
		<c:otherwise>
		
		</c:otherwise>
</c:choose>
<!-- end try -->
<input type="hidden" name="tabId" id="tabId"
	value="0" />
<script> 
//$("#maintabs, #subtabs").tabs();
 $("#maintabs").tabs({
	selected: <c:out value="${mainTabIndex}"/>,
	
         // which tab to start on when page loads
    select: function(e, ui) {
        var t = $(e.target);
        // alert("data is " +  t.data('load.tabs'));  // undef
        // alert("data is " +  ui.data('load.tabs'));  // undef

        // This gives a numeric index...
       // alert( "selected main is " + t.data('selected.tabs') );
        // ... but it's the index of the PREVIOUSLY selected tab, not the
        // one the user is now choosing.  
        return true;

        // eventual goal is: 
        // ... document.location= extract-url-from(something); return false;
    } 
});
 $('#subtabs-task').tabs({selected: <c:out value="${subTabIndex}"/>});
 $('#subtabs-client').tabs({selected: <c:out value="${subTabIndex}"/>});
 $('#subtabs-manage').tabs({selected: <c:out value="${subTabIndex}"/>});
 $('#subtabs-admin').tabs({selected: <c:out value="${subTabIndex}"/>});
 $('#subtabs-tax').tabs({selected: <c:out value="${subTabIndex}"/>}); 
 $('#subtabs-calendar').tabs({selected: <c:out value="${subTabIndex}"/>});
 $('#subtabs-report').tabs({selected: <c:out value="${subTabIndex}"/>});

//$('#maintabs'.tabs('select', ':contains("Client")');
</script> 



<script>

/* $(document).ready(function() {
	$('#maintabs'.tabs('select', ':contains("client")');
	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});
	
}); */
	</script>
	
	<!-- FOOTER -->
		<div id="ft"
			style="background: #33A1DE; height: 25px; color: white; position: fixed; bottom: 0; width: 100%;">
		</div>
	
	
</body>
</html> --%>