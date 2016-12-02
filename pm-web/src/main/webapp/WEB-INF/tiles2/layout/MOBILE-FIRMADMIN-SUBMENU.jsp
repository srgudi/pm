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

 <c:url value="/mobilefirmadmin/manageTaxModuleMobile.do" var="mobileFirmtaxTypeUrl"/>  
 <c:url value="/mobilefirmadmin/managePartyCodeMobile.do" var="mobileFirmManageCodeUrl"/> 
  <c:url value="/mobilefirmadmin/manageFirmStaffMobile.do" var="mobileFirmAdminStaffUrl"/> 
 
  
 
       <div data-role="page">
        
       <div data-role="header">
        <tiles:insertAttribute name="banner"/> 
      	<div data-role="controlgroup" data-role="popup" data-type="horizontal" class="ui-btn-left" style="margin-left: 100px;">
         <a href="#adminPopupMenu" data-role="button" data-icon="arrow-d" data-rel="popup"  data-rel="dialog" data-inline="true" data-mini="true">Firm Admin</a>
        </div> 
        
        
       </div>
       
       <div  data-role="content">
     
        <div data-role="popup" id="adminPopupMenu" data-theme="a">
				<ul data-role="listview" data-inset="true" style="min-width:210px;" data-theme="b">
					<li data-role="divider" data-theme="a">Choose</li> 
					 <li><a onClick='location.href="<c:out value='${mobileFirmAdminStaffUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Firm Staff</a></li>
					<li><a onClick='location.href="<c:out value='${mobileFirmtaxTypeUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Tax Type</a></li>
					<li><a onClick='location.href="<c:out value='${mobileFirmManageCodeUrl}'/>"' href="#" data-rel="popup" data-position-to="window" >Manage Code</a></li>
				</ul>
		</div>
        <tiles:insertAttribute name="body"/> 
       
       </div> 
      
       </div>
	
	

  </body>
</html>
 
 
 