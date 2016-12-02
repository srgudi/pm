 <%@ include file="PM-INCLUDES.jsp" %>
<!DOCTYPE html> 
<html> 
 
<head>
	 <meta name="viewport" content="width=device-width, initial-scale=1"> 
   <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/redmond/jquery-ui.css" />
  <link rel="stylesheet" type="text/css" href="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/css/ui.jqgrid.css" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" /> 
     <link rel="stylesheet"   href="<c:url value='/NEW_UI/jqmobile/css/jquery.ui.datepicker.mobile.css'/>"  type="text/css" /> 
     <link rel="stylesheet"   href="<c:url value='/NEW_UI/jgrowl/jquery.jgrowl.css'/>" type="text/css" /> 
	<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="<c:url value='/ui/js/jqgrid/src/i18n/grid.locale-en.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/ui/js/jqgrid/js/jquery.jqGrid.min.js'/>"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/plugin/ui.multiselect.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/jquery.jqGrid.src.js"></script>
	 <script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>  
	    <script type="text/javascript"   src="<c:url value='/NEW_UI/validate/jquery.validate.js'/>"></script>
        <script src="jQuery.ui.datepicker.js"></script>
        <script type="text/javascript"   src="<c:url value='/NEW_UI/jqmobile/js/jquery-ui-datepicker.js'/>"></script>
        <script type="text/javascript"   src="<c:url value='/NEW_UI/jqmobile/js/jquery.ui.datepicker.mobile.js'/>"></script>
         <script type="text/javascript" src="<c:url value='/NEW_UI/jgrowl/jquery.jgrowl.js'/>"></script>
	
<style type="text/css">

    /* disable shadows for better android performance */
    .ui-body-a,
    .ui-bar-a,
    .ui-btn-up-a,
    .ui-btn-hover-a,
    .ui-btn-down-a,

    .ui-body-b,
    .ui-bar-b,
    .ui-btn-up-b,
    .ui-btn-hover-b,
    .ui-btn-down-b,

    .ui-body-c,
    .ui-bar-c,
    .ui-btn-up-c,
    .ui-btn-hover-c,
    .ui-btn-down-c,

    .ui-body-d,
    .ui-bar-d,
    .ui-btn-up-d,
    .ui-btn-hover-d,
    .ui-btn-down-d,

    .ui-body-e,
    .ui-bar-e,
    .ui-btn-up-e,
    .ui-btn-hover-e,
    .ui-btn-down-e,

    .ui-shadow-inset,
    .ui-icon-shadow,
    .ui-focus,
    .ui-overlay-shadow,
    .ui-shadow,
    .ui-btn-active,
    * {
        text-shadow: none !important;
        box-shadow: none !important;
        -moz-box-shadow: none !important;
        -webkit-box-shadow: none !important;
    }




</style>            
	


    <title><tiles:getAsString name="title"/></title>
  </head>
  <body>
  <c:if test="${not empty param.clientId}">
  <c:url value="/mobileclient/mobileclientStaff.do" var="mobilestaffModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do" var="mobileclientOfficersAndShareHoldersUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileclientLocation.do" var="mobileLocationUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientBank.do" var="mobilebankModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/clientLawyerMobile.do" var="mobileLawyerModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientInsurance.do" var="mobileInsurModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientTAgent.do" var="mobileTransferModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobiletax/mobileTaxModule.do?clientId=${param.clientId}&firmPracticeId=${firmPracticeId}" var="mobileTaxModuleUrl"/>
     <c:url value="/mobileclient/mobileClientList.do" var="mobileClientListUrl">  
    </c:url>
  
 </c:if>
 
       <div data-role="page">
        
       <div data-role="header">
        <tiles:insertAttribute name="banner"/> 
      	<div data-role="controlgroup" data-role="popup" data-type="horizontal" class="ui-btn-left" style="margin-left: 100px;">
         <a href="#clientPopupMenu" data-role="button" data-icon="arrow-d" data-rel="popup"  data-rel="dialog" data-inline="true" data-mini="true">Client</a>
        </div> 
        
       </div>
       
       <div  data-role="content">
        <div data-role="popup" id="clientPopupMenu" data-theme="a">
				<ul data-role="listview" data-inset="true" style="min-width:210px;" data-theme="b">
					<li data-role="divider" data-theme="a">Choose</li> 
					 <li><a onClick='location.href="<c:out value='${mobilestaffModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window">Staff</a></li>
					 <li><a onClick='location.href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Officers & Shareholders</a></li>
					<li><a onClick='location.href="<c:out value='${mobileLocationUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Locations</a></li>
					<li><a onClick='location.href="<c:out value='${mobilebankModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Banks</a></li>
					<li><a onClick='location.href="<c:out value='${mobileLawyerModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Lawyers</a></li>
					<li><a onClick='location.href="<c:out value='${mobileInsurModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Insurence</a></li>
					<li><a onClick='location.href="<c:out value='${mobileTransferModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Transfer Agent</a></li> 
					<li><a onClick='location.href="<c:out value='${mobileTaxModuleUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Taxes</a></li> 
					<li><a onClick='location.href="<c:out value='${mobileClientListUrl}'/>"' href="#" data-rel="popup" data-position-to="window">Client List</a></li>
				</ul>
		</div>
        <tiles:insertAttribute name="body"/> 
       
       </div> 
      
       </div>
	
	

  </body>
</html>
 
 
 