<%@ include file="PM-INCLUDES.jsp" %>
<!DOCTYPE html> 
<html> 
 
<head>
	 <meta name="viewport" content="width=device-width, initial-scale=1"> 
   <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/redmond/jquery-ui.css" />
  <link rel="stylesheet" type="text/css" href="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/css/ui.jqgrid.css" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" /> 
     <link rel="stylesheet"   href="<c:url value='/resources/css/jquery.ui.datepicker.mobile.css'/>"  type="text/css" />
     <link href="<c:url value="/resources/css/bootstrap.min.css" />" 			rel="stylesheet" type="text/css" /> 
	<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/jqgrid/js/i18n/grid.locale-en.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/jqgrid/js/jquery.jqGrid.min.js'/>"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/plugin/ui.multiselect.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js" />"></script>
	 <script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>  
	    <script type="text/javascript"   src="<c:url value='/resources/validate/jquery.validate.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/resources/jgrowl/jquery.jgrowl.js'/>"></script>
        <script src="jQuery.ui.datepicker.js"></script>
        <script type="text/javascript"   src="<c:url value='/resources/js/jquery-ui-datepicker.js'/>"></script>
        <script type="text/javascript"   src="<c:url value='/resources/js/jquery.ui.datepicker.mobile.js'/>"></script>
	
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.columnFilter.js'/>"></script>    
	 <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.min.js'/>"></script>
	<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.js'/>"></script>  --%>
	<script type="text/javascript" src="<c:url value='/resources/js/DT_bootstrap.js'/>"></script>
	<link href="<c:url value="/resources/css/bs-override.css" />" rel="stylesheet" type="text/css" />
    <link href='<c:url value="/resources/css/common.css" />' rel='stylesheet' type='text/css' />
 <!-- <script type="text/javascript">
		
		$('#staffmobile').click(function() {
			document.getElementById('showgrid');
			   $('#showgrid').show(); 
			});
		
		</script> -->
		

<script type="text/javascript">
$(function() {
    $("#viewClienteditForm").click(function() {
        $.mobile.changePage("../mobileclient/mobileClientDetail.do","slideup");
    });        
});
</script> 		
    <title><tiles:getAsString name="title"/></title>
  </head>
  <body>
  <c:if test="${not empty param.clientId}">
  	 <c:url value="/mobileclient/mobileclientLocation.do" var="mobileclientLocationUrl">  
    	<c:param name="clientId" value="${param.clientId}"/>
     </c:url>
    </c:if>
  <c:if test="${not empty param.clientId}">
  	 <c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do" var="mobileclientOfficersAndShareHoldersUrl">  
    	<c:param name="clientId" value="${param.clientId}"/>
     </c:url>
    </c:if>
   <c:if test="${not empty param.clientId}">
  	 <c:url value="/mobileclient/mobileclientStaff.do" var="mobilestaffModuleUrl">  
    	<c:param name="clientId" value="${param.clientId}"/>
     </c:url>
    </c:if>
	<c:url value="/mobileclient/mobileClientDetail.do" var="mobiledetailModuleUrl">  
    	<c:param name="clientId" value="${param.clientId}"/>
    </c:url>
    <c:url value="/mobileclient/mobileClientBank.do" var="mobilebankModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientLawyer.do" var="mobileLawyerModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientInsurance.do" var="mobileInsurModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
     <c:url value="/mobileclient/mobileClientTAgent.do" var="mobileTransferModuleUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
    </c:url>
       <div data-role="page">
        
       <div data-role="header">
        <tiles:insertAttribute name="banner"/> 
       </div>
       
       <div data-role="content">
       <c:if test="${empty inValidClientId}">
                <div class="container_12 bg-light-orange blue">
                    <span style="font-size:105%;font-weight:bold;color:DarkGray ;font-style: italic;">Client Name:${clientPartyName}</span>
                </div>
            </c:if>
       <div data-role="navbar">
        <ul>
         <%--  <li><a href="<c:out value='${mobiledetailModuleUrl}'/>"    class="ui-btn-active"  data-theme="a" data-tab-class="tab1">Detail</a></li> --%>
           <li> <a  id="viewClienteditForm" data-theme="a" >Detail</a> </li>
         <%--  <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab2" onClick='location.href="<c:out value='${mobilestaffModuleUrl}'/>"'>Staff</a></li>
          <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab3" onClick='location.href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>"'>Office and shareholders</a></li>
          <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab4" onClick='location.href="<c:out value='${mobileclientLocationUrl}'/>"'>Locations</a></li>
           <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab5" onClick='location.href="<c:out value='${mobilebankModuleUrl}'/>"'>Banks</a></li>
          <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab6" onClick='location.href="<c:out value='${mobileLawyerModuleUrl}'/>"'>Lawyers</a></li>
		  <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab7" onClick='location.href="<c:out value='${mobileInsurModuleUrl}'/>"'>Insurence</a></li>
		 <li><a href="<c:out value='${mobiledetailModuleUrl}'/>" data-theme="a" data-tab-class="tab8" onClick='location.href="<c:out value='${mobileTransferModuleUrl}'/>"'>Transfer Agent</a></li> --%>  
        </ul>
        </div>
         <!-- <div data-role="navbar" id="navbar">
         <ul>
         <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Lawyers</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Insurance</a></li>
          <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Transfer Agents</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Documents</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Documents Search</a></li>
           </ul>
         </div> -->
        <tiles:insertAttribute name="body"/> 
       
       </div> 
      
       </div>
	
	

  </body>
</html>
 
 
 