<%@ include file="PM-INCLUDES.jsp" %>

<tiles:insertAttribute name="html-header"/>
<c:set var="mainTabIndex" value="0"/>
<c:set var="subTabIndex" value="0"/>
<body>
<div>
<tiles:insertAttribute name="banner"/>
<div class="container_12" style="margin-top:-15px;">
<div id="maintabs" class="ui-tabs-hide">
<c:url value="/dashboard/dashboard.do" var="dashboardUrl"/>
<c:url value="/task/taskList.do" var="taskListUrl"/>
<c:url value="/client/clientList.do" var="clientUrl"/>
<c:url value="/firmadmin/manageFirmStaff.do" var="manageFirmStaffUrl"/>
<c:url value="/appadmin/adminFirmModule.do" var="adminFirmModuleUrl"/>
<c:url value="/tax/taxModule.do?clientId=${param.clientId}&firmPracticeId=${firmPracticeId}" var="taxModuleUrl"/>
<c:url value="/calendar/calendar.do" var="calendarUrl"/>
<c:url value="/document/searchDocument.do" var="searchDocumentUrl"/>
<ul style="min-width:500px;">
<%-- <div id="nav0">
  <div id="nav-main0"> 
    <ul class="sf-menu">
      	 <li><a id="menuItemDemo" href="<c:out value='${clientUrl}'/>" <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'dashboard')}"> class="current" </c:if>>
	      	 <img src="../images/icon_home.png" alt="Home" class="home" />
	      	 </a>
         </li>
          <li><a id="menuItemHanuman" href="#" <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'client')}"> class="current" </c:if>>
          Hanuman
         
         <ul>
         <li><a href="<c:out value='${clientUrl}'/>">Hanuman</a></li>
         <li><a href="<c:out value='${clientUrl}'/>">Apoorva</a></li>
         </ul>
          </li>
     </ul>
     
    </div> 
</div> --%>
<style type="text/css">
.liSpacing{
/* width:90px; */
align:center;
}
</style>
    <li style="margin-left:20%"><a href="#tabs-1" onClick='location.href="<c:out value='${dashboardUrl}'/>"'/>DashBoard</a></li>
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
    	<li style="display:none; "><a href="#tabs-5" onClick="location.href='<c:out value="${adminFirmModuleUrl}"/>'">Administration</a></li>
    </security:authorize>
    <li><a href="#tabs-6" onClick="location.href='<c:out value="${calendarUrl}"/>'">Calendar</a></li>
    <li><c:url value="/reports/index.do" var="reportUrl"/><a href="#tabs-7"
                                                             onClick="location.href='<c:out value="${reportUrl}"/>'">Reports</a>
    </li>
   <li><a href="#tabs-9" onClick='location.href="<c:out value='${searchDocumentUrl}'/>"'/>Document Search</a></li>
</ul>

<div id="tabs-1">
    <c:choose>
        <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'dashboard')}">
            <tiles:insertAttribute name="body"/>
        </c:when>
        <c:otherwise/>
    </c:choose>
</div>

<div id="tabs-2">
    <c:choose>
        <c:when test="${not empty param.taskId and fn:contains(requestScope['javax.servlet.forward.request_uri'],'task')}">
            <div id="subtabs-task">
                <ul style="min-width:500px;">
                    <c:url value="/task/taskList.do" var="taskListUrl"/>
                    <c:if test="${not empty param.taskId}">
                        <c:url value="/task/taskModule.do" var="taskModuleUrl">
                            <c:param name="taskId" value="${param.taskId}"/>
                        </c:url>
                        <li style="margin-left:19%"><a href="#subtabs-1" onClick='location.href="<c:out value='${taskModuleUrl}'/>"'>Task
                            Detail</a></li>
                            <c:url value="/task/taskDocuments.do" var="taskDocumentUrl">
                            <c:param name="taskId" value="${param.taskId}"/>
                        </c:url> 
                        <li><a href="#subtabs-2" onClick='location.href="<c:out value='${taskDocumentUrl}'/>"'>Task
                            Document</a></li> 
                          <c:url value="/task/taskDocumentSearch.do" var="taskDocumentSearchUrl">
                            <c:param name="taskId" value="${param.taskId}"/>
                        </c:url> 
                        <li><a href="#subtabs-3" onClick='location.href="<c:out value='${taskDocumentSearchUrl}'/>"'>Document Search</a>
                        </li> 
                             </c:if>                            
                </ul>
                <br/>
                <tiles:insertAttribute name="body"/>
            </div>
        </c:when>
        <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'task')}">
            <tiles:insertAttribute name="body"/>
        </c:when>
        <c:otherwise/>
    </c:choose>
</div>

<div id="tabs-3">
    <c:choose>
        <c:when test="${not empty param.clientId and fn:contains(requestScope['javax.servlet.forward.request_uri'],'client')}">

            <c:if test="${empty inValidClientId}">
                <div class="container_12 bg-light-orange blue">
                    <span style="font-size:125%;font-weight:bold;">${clientPartyName}</span>
                </div>
            </c:if>

            <div id="subtabs-client">
                <ul style="min-width:500px;">
                    <c:url value="/client/clientList.do" var="clientUrl"/>
                    <c:url value="/client/clientDetail.do" var="clientDetailUrl">
                        <c:param name="clientId" value="${param.clientId}"/>
                    </c:url>
                    <li style="margin-left:19%"><a href="#subtabs-1"
                                                   onClick='location.href="<c:out value='${clientDetailUrl}'/>"'>Details</a>
                    </li>


                    <c:if test="${not empty param.clientId}">
                        <c:url var="clientStaffUrl" value="/client/clientStaff.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-2" onClick='location.href="<c:out value='${clientStaffUrl}'/>"'>Staff</a>
                        </li>
                        <c:url var="clientOfficersAndShareHoldersUrl" value="/client/clientOfficersAndShareHolders.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-3"
                               onClick='location.href="<c:out value='${clientOfficersAndShareHoldersUrl}'/>"'>Officers &
                            Shareholders</a></li>

                        <c:url var="clientLocationUrl" value="/client/clientLocation.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-4" onClick='location.href="<c:out value='${clientLocationUrl}'/>"'>Locations</a>
                        </li>
                        <c:url var="clientBankUrl" value="/client/clientBank.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-5" onClick='location.href="<c:out value='${clientBankUrl}'/>"'>Banks</a>
                        </li>

                        <c:url var="clientLawyerUrl" value="/client/clientLawyer.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-6"
                               onClick='location.href="<c:out value='${clientLawyerUrl}'/>"'>Lawyers</a></li>

                        <c:url var="clientInsuranceUrl" value="/client/clientInsurance.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-7" onClick='location.href="<c:out value='${clientInsuranceUrl}'/>"'>Insurance</a>
                        </li>

                        <c:url var="clientTransferAgentUrl" value="/client/clientTransferAgent.do">
                            <c:param name="clientId" value="${param.clientId}"/>
                        </c:url>
                        <li><a href="#subtabs-8" onClick='location.href="<c:out value='${clientTransferAgentUrl}'/>"'>Transfer
                            Agents</a></li>
                            
                            <c:url var="clientDocumentsUrl" value="/client/clientDocuments.do" >
                    <c:param name="clientId" value="${param.clientId}"/>
                    </c:url>
                    <li><a href="#subtabs-9" onClick='location.href="<c:out value='${clientDocumentsUrl}'/>"'>Documents</a>
                    </li>
                     <c:url var="clientDocumentSearchUrl" value="/client/clientDocumentSearch.do" >
                    <c:param name="clientId" value="${param.clientId}"/>
                    </c:url>
                    <li><a href="#subtabs-10" onClick='location.href="<c:out value='${clientDocumentSearchUrl}'/>"'>Document Search</a>
                    </li>
                    </c:if>
                </ul>
                <br/>
                <tiles:insertAttribute name="body"/>
            </div>
        </c:when>
        <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'client')}">
            <tiles:insertAttribute name="body"/>
        </c:when>
        <c:otherwise/>
    </c:choose>
</div>

<div id="tabs-7">
    <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'report')}">
       <div id="subtabs-report">
            <ul style="min-width:500px;">
                <c:url value="/reports/clientListwithDetailsJasperReport.do" var="report1Url"></c:url>
                <c:url value="/reports/clientListByMisDeadLinesJasper.do" var="report2Url"></c:url>
                <c:url value="/reports/taskListByEmpJasperReport.do" var="report3Url"></c:url>
                <c:url value="/reports/dueDateByTaskJASPER.do" var="report4Url"></c:url>
                <c:url value="/reports/newTaxListByStaffJasperReport.do" var="report5Url"></c:url>
                <c:url value="/reports/clientByFirmJASPER.do" var="report6Url"></c:url>
                <c:url value="/reports/taskListByFilingTypeJasperReport.do" var="report7Url"></c:url>
                <c:url value="/reports/taskListByFirmJasperReport.do" var="report8Url"></c:url>
                <c:url value="/reports/taskListByStatusJasperReport.do" var="report9Url"></c:url>
                <c:url value="/reports/filingsByClientJasper.do" var="report10Url"></c:url>
                <c:url value="/reports/clientListbyPartnerJasper.do" var="report11Url"></c:url>
                <c:url value="/reports/taskByDueDateJasperReport.do" var="report12Url"></c:url>
                <c:url value="/reports/taskModuleJasperReport.do" var="report13Url"></c:url>
                <%-- <li><a href="#subtabs-1" onClick='location.href="<c:out value='${reportUrl}'/>"'>Report</a></li> --%>
 <div id="nav-main0"> 
    <ul class="sf-menu">
          <li><a id="menuItemReports" href="#">
          Reports</a>
         <ul>
         <li><a href="<c:out value='${report1Url}'/>">ClientList With Details&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report2Url}'/>">Client By MissingDeadLine</a></li>
         <li><a href="<c:out value='${report3Url}'/>">TaskList By Employee&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report4Url}'/>">Task List By Tax Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report5Url}'/>">Work Load Summary&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report6Url}'/>">Client By Firm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report7Url}'/>">Task List By Filing Type&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report8Url}'/>">Task List By Firm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report9Url}'/>">Task List By Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report10Url}'/>">Filings By Client&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report11Url}'/>">Client List by Partner&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report12Url}'/>">Task By Due Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${report13Url}'/>">Task List by Partner&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        
         </ul>
          </li>
     </ul>
    </div> 
            </ul>
           <!--  <div id="subtabs-1"></div> -->
            <br/>
            <tiles:insertAttribute name="body"/>
        </div> 

    </c:if>

</div>

<div id="tabs-4">
     <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'firmadmin')}"> 
        <div id="subtabs-manage">
        <ul style="min-width:500px;"> 
                <c:url value="/firmadmin/manageFirmStaff.do" var="manageFirmStaffUrl"></c:url>
               <%--  <li style="margin-left:19%"><a href="#subtabs-1" onClick='location.href="<c:out value='${manageFirmStaffUrl}'/>"'>Firm
                  Staff</a></li> --%>

                <c:url value="/firmadmin/manageTaxModule.do" var="manageTaxModuleUrl"></c:url>
               <%--  <li><a href="#subtabs-2" onClick='location.href="<c:out value='${manageTaxModuleUrl}'/>"'>Taxes</a></li> --%>

                <c:url value="/firmadmin/managePartyCode.do" var="managePartyCodeUrl"></c:url>
                <%-- <li><a href="#subtabs-3" onClick='location.href="<c:out value='${managePartyCodeUrl}'/>"'>Codes</a></li> --%>
                <!-- <div id="nav0"> -->
  <div id="nav-main0"> 
    <ul class="sf-menu">
          <li><a id="menuItemFirmAdmin" href="#">
          Firm Admin</a>
         <ul>
         <li class="liSpacing"><a href="<c:out value='${manageFirmStaffUrl}'/>">&nbsp;Firm Staff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li class="liSpacing"><a href="<c:out value='${manageTaxModuleUrl}'/>">&nbsp;Taxes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li class="liSpacing"><a href="<c:out value='${managePartyCodeUrl}'/>">&nbsp;Codes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         </ul>
          </li>
     </ul>
    </div> 
<!-- </div> -->
           </ul> 
            <br/>
            <tiles:insertAttribute name="body"/>
        </div>
   </c:if> 

</div>

<div id="tabs-5">
   <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'appadmin')}"> 
        <div id="subtabs-admin">
            <ul style="min-width:500px;">
                <c:url value="/appadmin/adminFirmModule.do" var="adminFirmModuleUrl"></c:url>
               <%--  <li style="margin-left:19%"><a href="#subtabs-1"
                                               onClick='location.href="<c:out value='${adminFirmModuleUrl}'/>"'>Firm</a>
                </li> --%>

                <c:url value="/appadmin/adminJurisdiction.do" var="adminJurisdictionUrl"></c:url>
                <%-- <li><a href="#subtabs-2"
                       onClick='location.href="<c:out value='${adminJurisdictionUrl}'/>"'>Jurisdiction</a></li> --%>

                    <%-- <c:url  value="/appadmin/adminTimezone.do" var="adminTimezoneUrl"></c:url>
                                       <li><a href="#subtabs-3"  onClick='location.href="<c:out value='${adminTimezoneUrl}'/>"'>Timezone</a></li> --%>

                <c:url value="/appadmin/adminCodeType.do" var="adminCodeTypeUrl"></c:url>
                <%-- <li><a href="#subtabs-3" onClick='location.href="<c:out value='${adminCodeTypeUrl}'/>"'>Code Type</a>
                </li> --%>

                <c:url value="/appadmin/adminCode.do" var="adminCodeUrl"></c:url>
                <%-- <li><a href="#subtabs-4" onClick='location.href="<c:out value='${adminCodeUrl}'/>"'>Code</a></li> --%>

                <c:url value="/appadmin/adminTaskNotificationTemplate.do"
                       var="adminTaskNotificationTemplateUrl"></c:url>
                <%-- <li><a href="#subtabs-5" onClick='location.href="<c:out value='${adminTaskNotificationTemplateUrl}'/>"'>Templates</a>
                </li> --%>

                <c:url value="/appadmin/adminTaskNotificationRecipient.do"
                       var="adminTaskNotificationRecipientUrl"></c:url>
               <%--  <li><a href="#subtabs-6"
                       onClick='location.href="<c:out value='${adminTaskNotificationRecipientUrl}'/>"'>Recipients</a>
                </li> --%>

               
                    <c:url value="/appadmin/adminFirmEmployee.do" var="adminFirmEmployeeUrl"></c:url>
                    <%-- <li><a href="#subtabs-7" onClick='location.href="<c:out value='${adminFirmEmployeeUrl}'/>"'>Firm
                        Staff</a></li> --%>
               
                
              <!--   <div id="nav-main0">  -->
          <ul class="sf-menu">
          <li><a id="menuItemAppAdmin" href="#">
          Administration </a>
         <ul>
        <%--  <li><a href="<c:out value='${adminFirmModuleUrl}'/>">Firm</a></li> --%>
         <li><a href="<c:out value='${adminFirmModuleUrl}'/>">&nbsp;Firm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${adminJurisdictionUrl}'/>">&nbsp;Jurisdiction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${adminCodeTypeUrl}'/>">&nbsp;Code Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${adminCodeUrl}'/>">&nbsp;Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${adminTaskNotificationTemplateUrl}'/>">&nbsp;Templates&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
         <li><a href="<c:out value='${adminTaskNotificationRecipientUrl}'/>">&nbsp;Recipients&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
          <c:if test="${not empty param.firmId}">
          <li><a href="<c:out value='${adminFirmEmployeeUrl}'/>">&nbsp;Firm Staff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
           </c:if>
         </ul>
          </li>
     </ul>
     
    <!-- </div>  -->
            </ul>
            <br/>
            <tiles:insertAttribute name="body"/>
        </div>

    </c:if>
</div>

<div id="tabs-8">
    <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'tax')}">
        <c:if test="${empty inValidClientId}">
            <div class="container_12 bg-light-orange blue">
                <span style="font-size:125%;font-weight:bold;">${clientPartyName}</span>
            </div>
        </c:if>
        <div id="subtabs-tax">
            <ul style="min-width:500px;">
                <c:set var="taxModuleCount" value="0"/>
                <c:forEach items="${taxModules}" var="practiceType" varStatus="cStatus">

                    <c:set var="tax_subtab" value="#subtab_${taxModuleCount}"/>
                    <c:url value="taxModule.do" var="taxModuleURL">
                        <c:param name="clientId" value="${param.clientId}"/>
                        <c:param name="firmPracticeId" value="${practiceType.id}"/>
                    </c:url>
                    <c:if test="${practiceType.id == param.firmPracticeId}">
                        <c:set var="subTabIndex" value="${taxModuleCount}"/>
                    </c:if>
                    <li><a href="tax_subtab" onClick='location.href="<c:out value='${taxModuleURL}'/>"'><c:out
                            value="${practiceType.taxApplicationPracticeType.name}"/></a></li>
                    <c:set var="taxModuleCount" value="${taxModuleCount + 1}"/>
                </c:forEach>
            </ul>
            <tiles:insertAttribute name="body"/>
        </div>
    </c:if>
</div>

<div id="tabs-6">
    <c:if test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'calendar')}">
   
        <div id="subtabs-calendar">
            <ul style="min-width:500px;">
                <c:url value="/calendar/calendar.do" var="calendarUrl"></c:url>
                <li style="margin-left:19%"><a href="#subtabs-1"
                                               onClick='location.href="<c:out value='${calendarUrl}'/>"'>Calendar</a>
                </li>
            </ul>
            <br/>
            <tiles:insertAttribute name="body"/>
        </div>
    </c:if>

</div>
<div id="tabs-9">
    <c:choose>
        <c:when test="${fn:contains(requestScope['javax.servlet.forward.request_uri'],'document')}">
            <tiles:insertAttribute name="body"/>
        </c:when>
        <c:otherwise/>
    </c:choose>
</div>

<c:choose>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'dashboard')}">
        <c:set var="mainTabIndex" value="0"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskList')}">
        <c:set var="mainTabIndex" value="1"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskModule')}">
        <c:set var="mainTabIndex" value="1"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskDocuments')}">
        <c:set var="mainTabIndex" value="1"/>
        <c:set var="subTabIndex" value="1"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taskDocumentSearch')}">
        <c:set var="mainTabIndex" value="1"/>
        <c:set var="subTabIndex" value="2"/>
    </c:when>
    
   
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientList')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientDetail')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientStaff')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="1"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientOfficersAndShareHolders')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="2"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientLocation')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="3"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientBank')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="4"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientLawyer')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="5"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientInsurance')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="6"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientTransferAgent')}">
        <c:set var="mainTabIndex" value="2"/>
        <c:set var="subTabIndex" value="7"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientDocuments')}">
		            <c:set var="mainTabIndex" value="2"/>
		            <c:set var="subTabIndex" value="8"/>
		        </c:when>
		         <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'clientDocumentSearch')}">
		            <c:set var="mainTabIndex" value="2"/>
		            <c:set var="subTabIndex" value="9"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'manageFirmStaff')}">
        <c:set var="mainTabIndex" value="4"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'manageTaxModule')}">
        <c:set var="mainTabIndex" value="4"/>
        <c:set var="subTabIndex" value="1"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'managePartyCode')}">
        <c:set var="mainTabIndex" value="4"/>
        <c:set var="subTabIndex" value="2"/>
    </c:when>

    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminFirmModule')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminJurisdiction')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="1"/>
    </c:when>
    <%-- <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminTimezone')}">
                             <c:set var="mainTabIndex" value="5"/>
                             <c:set var="subTabIndex" value="2"/>
                             </c:when> --%>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminCodeType')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="2"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminCode')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="3"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminTaskNotificationTemplate')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="4"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminTaskNotificationRecipient')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="5"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'adminFirmEmployee')}">
        <c:set var="mainTabIndex" value="5"/>
        <c:set var="subTabIndex" value="6"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'taxModule')}">
        <c:set var="mainTabIndex" value="3"/>
        <!-- Sub tab index is selected above in main tab taxModule selction dynamically -->
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'calendar')}">
        <c:set var="mainTabIndex" value="6"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'index')}">
        <c:set var="mainTabIndex" value="7"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:when test="${ fn:contains(requestScope['javax.servlet.forward.request_uri'],'document')}">
        <c:set var="mainTabIndex" value="8"/>
        <c:set var="subTabIndex" value="0"/>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>
<input type="hidden" name="tabId" id="tabId"
       value="0"/>
<script>
    //$("#maintabs, #subtabs").tabs();
    $("#maintabs").tabs({
        selected: <c:out value="${mainTabIndex}"/>,

        // which tab to start on when page loads
        select: function(e, ui) {
            var t = $(e.target);
            return true;
        }
    });
    $('#subtabs-dashboard').tabs({selected: <c:out value="${subTabIndex}"/>});
    $('#subtabs-task').tabs({selected: <c:out value="${subTabIndex}"/>});
    <c:if test="${not empty param.clientId}">
    $('#subtabs-client').tabs({selected: <c:out value="${subTabIndex}"/>});
    </c:if>
    $('#subtabs-manage').tabs({selected: <c:out value="${subTabIndex}"/>});
    $('#subtabs-admin').tabs({selected: <c:out value="${subTabIndex}"/>});
    $('#subtabs-tax').tabs({selected: <c:out value="${subTabIndex}"/>});
    $('#subtabs-report').tabs({selected: <c:out value="${subTabIndex}"/>}); 
    $('#subtabs-calendar').tabs({selected: <c:out value="${subTabIndex}"/>});
    $('#subtabs-document').tabs({selected: <c:out value="${subTabIndex}"/>});
</script>
</div>
</div>
</div>

<!-- FOOTER -->
<div id="ft"
     style="background: #33A1DE; height: 25px; color: white; position: fixed; bottom: 0; width: 100%;">
</div>
</body>
</html>