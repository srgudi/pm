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
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
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
	

<script type="text/javascript">
$(function() {
    $("#viewClienteditForm").click(function() {
        $.mobile.changePage("../mobileclient/mobileClientDetail.do","slideup");
    });        
});
</script> 

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
    <c:url value="/mobileclient/mobileClientBank.do" var="mobileclientBankUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientInsurance.do" var="mobileInsurModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientTransferAgent.do" var="mobileTransferModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do" var="mobileclientOfficersAndShareHoldersUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
   
<c:url value="/mobileclient/mobileClientDetail.do" var="mobiledetailModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileClientBank.do" var="mobilebankModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do" var="mobileOffAndShareholdersModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileclientLocation.do" var="mobileLocationUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileClientInsurance.do" var="mobileInsurModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    
    <c:url value="/mobileclient/mobileClientTAgent.do" var="mobileTransferModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    
    <c:url value="/mobileclient/clientLawyerMobile.do" var="mobileLawyerModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    
<c:url value="/mobiletax/mobileTaxModule.do?clientId=${param.clientId}&firmPracticeId=${firmPracticeId}" var="mobileTaxModuleUrl"/>
 </c:if>
       <div data-role="page">
        
       <div data-role="header">
        <tiles:insertAttribute name="banner"/> 
        
       </div>
       
       <div  data-role="content">
       <c:if test="${empty inValidClientId}">
                <div class="container_12 bg-light-orange blue">
                    <span style="font-size:105%;font-weight:bold;color:DarkGray ;font-style: italic;">Client Name:${clientPartyName}</span>
                </div>
            </c:if>
       <div  data-role="navbar">
        
        <ul>
          <li><a href="<c:out value='${mobiledetailModuleUrl}'/>"     class="ui-btn-active  ui-state-persist"  >Detail</a></li> 
          <!--  <li> <a  id="viewClienteditForm" data-theme="a" >Detail</a> </li> -->
           <li><a     href="<c:out value='${mobiledetailModuleUrl}'/>"    data-theme="a" data-tab-class="tab2" onClick='location.href="<c:out value='${mobilestaffModuleUrl}'/>"'>Staff</a></li>
           <li><a href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>" data-theme="a" data-tab-class="tab3">Officers and ShareHolders</a></li>
          	<li><a href="<c:out value='${mobileclientBankUrl}'/>" data-theme="a" data-tab-class="tab3">Banks</a></li>
          	<li><a href="<c:out value='${mobileInsurModuleUrl}'/>"   data-theme="a" data-tab-class="tab4">Insurances</a></li>
          	<li><a href="<c:out value='${mobileLocationUrl}'/>"   data-theme="a" data-tab-class="tab5">Location</a></li>
           <li><a href="<c:out value='${mobileTransferModuleUrl}'/>"   data-theme="a" data-tab-class="tab6">Transfer Agents</a></li>
           <li><a href="<c:out value='${mobileLawyerModuleUrl}'/>"   data-theme="a" data-tab-class="tab7">Lawyers</a></li>
           
          <!-- <li><a href="#" class="ui-btn-active"  data-theme="a" data-tab-class="tab3">Office and shareholders</a></li>
           <li><a href="#" class="ui-btn-active"  data-theme="a" data-tab-class="tab4">Locatins</a></li>
           <li><a href="#" class="ui-btn-active"  data-theme="a" data-tab-class="tab5">Banks</a></li> -->
            
					<security:authorize
						access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER','ROLE_APP_ADMIN')">
						<li><a  data-theme="a"   data-tab-class="tab3"	href="#" onClick='location.href="<c:out value='${mobileTaxModuleUrl}'/>"'>Taxes</a></li>
					</security:authorize>
					<%-- <c:if test="${empty param.clientId}">
						<li style="display: none;"><a data-theme="a" href="<c:out value='${mobileTaxModuleUrl}'/>">Taxes</a>
						</li>
					</c:if> --%>
				</ul>
        </div>
        <tiles:insertAttribute name="body"/> 
       
       </div> 
      
       </div>
	
	

  </body>
</html>
 
 
 