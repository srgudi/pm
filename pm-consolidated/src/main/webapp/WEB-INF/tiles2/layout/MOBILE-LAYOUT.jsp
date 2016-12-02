 

<%@ include file="PM-INCLUDES.jsp" %>
<!DOCTYPE html> 
<html> 
 
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
   <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700' rel='stylesheet' type='text/css'>
   <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css">
   <link href="<c:url value="/resources/custom/jquery.jgrowl.css" />" rel="stylesheet" type="text/css" />
  <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
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
	    <script type="text/javascript"   src="<c:url value='/resources/js/jquery.validate.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/resources/js/jquery.jgrowl.js'/>"></script>
        <script src="jQuery.ui.datepicker.js"></script>
        <script type="text/javascript"   src="<c:url value='/resources/js/jquery-ui-datepicker.js'/>"></script>
        <script type="text/javascript"   src="<c:url value='/resources/js/jquery.ui.datepicker.mobile.js'/>"></script>
       <script language="javascript" type="text/javascript" 
            src="<c:url value='/resources/flot/js/excanvas.js'/>"></script>   
            <script language="javascript" type="text/javascript" 
            src="<c:url value='/resources/flot/js/jquery.flot.js'/>"></script> 
            
            <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.columnFilter.js'/>"></script>    
	 <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.min.js'/>"></script>
	<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.js'/>"></script>  --%>
	<script type="text/javascript" src="<c:url value='/resources/js/DT_bootstrap.js'/>"></script>
	<link href="<c:url value="/resources/css/bs-override.css" />" rel="stylesheet" type="text/css" />
    <link href='<c:url value="/resources/css/common.css" />' rel='stylesheet' type='text/css' />  
             <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.columnFilter.js'/>"></script>    
	 <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.js'/>"></script>  
	<script type="text/javascript" src="<c:url value='/resources/js/DT_bootstrap.js'/>"></script>
	<link href="<c:url value="/resources/css/bs-override.css" />" rel="stylesheet" type="text/css" />
    <link href='<c:url value="/resources/css/common.css" />' rel='stylesheet' type='text/css' />
	<script type="text/javascript" src="<c:url value='/resources/jquery/jquery-ui-1.9.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/colorbox/jquery.colorbox-min.js'/>"></script>

    <!-- google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Arimo' rel='stylesheet' type='text/css' />
	 <%--    <script type="text/javascript" src="<c:url value='/NEW_UI/jqmobile/js/iscroll.js'/>"></script>  --%>
	 <!--  <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/redmond/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/css/ui.jqgrid.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/js/jquery.jqGrid.min.js"></script>  -->
   
<!-- <script type="text/javascript">

var myScroll;
function loaded() {
	myScroll = new iScroll('wrapper');
}

document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

document.addEventListener('DOMContentLoaded', loaded, false);

</script> -->	 
 <%-- <link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" /> 
	 <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/redmond/jquery-ui.css" />
  <link rel="stylesheet" type="text/css" href="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-3.8.2/css/ui.jqgrid.css" />
   
     <link rel="stylesheet"   href="<c:url value='/NEW_UI/jqmobile/css/jquery.ui.datepicker.mobile.css'/>"  type="text/css" /> 
	
	 <script type="text/javascript" src="<c:url value='/ui/js/jqgrid/js/jquery.jqGrid.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/ui/js/jqgrid/src/i18n/grid.locale-en.js'/>"></script>
   <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.3.1/js/jquery.jqGrid.src.js"></script>
   
	 <script type="text/javascript" src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>  
	    <script type="text/javascript"   src="<c:url value='/NEW_UI/validate/jquery.validate.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/NEW_UI/jgrowl/jquery.jgrowl.js'/>"></script>
        <script src="jQuery.ui.datepicker.js"></script>
        <script type="text/javascript"   src="<c:url value='/NEW_UI/jqmobile/js/jquery-ui-datepicker.js'/>"></script>
        <script type="text/javascript"   src="<c:url value='/NEW_UI/jqmobile/js/jquery.ui.datepicker.mobile.js'/>"></script>
        <script language="javascript" type="text/javascript" 
            src="<c:url value='/NEW_UI/flot/js/excanvas.js'/>"></script>   
            <script language="javascript" type="text/javascript" 
            src="<c:url value='/NEW_UI/flot/js/jquery.flot.js'/>"></script>  --%>
            
	
    <title><tiles:getAsString name="title"/></title>
  </head>
  <body>
  

<c:url value="/mobiletask/mobileTaskmodule.do" var="mobiletaskModuleUrl"/>   
 
       <div data-role="page">
        
       <div data-role="header">
        <tiles:insertAttribute name="banner"/> 
       </div>
       
       <div data-role="content">
      <!--  <div data-role="navbar" id="navbar" >
        <ul>
          <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Detail</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Staff</a></li>
          <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Office and shareholders</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Locatins</a></li>
           <li><a href="#" class="ui-btn-active"  data-tab-class="tab1">Banks</a></li>
           
           
        </ul>
        </div>
         <div data-role="navbar" id="navbar">
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
 
 
 