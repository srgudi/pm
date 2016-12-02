<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Practice Management</title>
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache"> 


<!-- colorbox -->
<link href="<c:url value="/resources/colorbox/colorbox.css" />" rel="stylesheet" type="text/css" />

<!-- bootstrap css for jqgrid -->
<link href="<c:url value="/resources/custom/pm.css" />" 				rel="stylesheet" type="text/css" /> 
 <%-- <link rel="stylesheet" type="text/css" href="<c:url value='/resources/theme/${theme}.css' />"/>  --%>

<link href="<c:url value="/resources/css/bootstrap.min.css" />" 			rel="stylesheet" type="text/css" />

<link href="<c:url value="/resources/css/bootstrap-responsive.min.css"/>"		rel="stylesheet" type="text/css" /> 
 <link href="<c:url value="/resources/custom/font-awesome.css" />" 			rel="stylesheet" type="text/css" /> 
<%-- <link href="<c:url value="/resources/custom/font-awesome-ie7.css" />" 			rel="stylesheet" type="text/css" />  --%>   


<link href="<c:url value='../resources/jqgrid/css/jquery.ui.theme.css'/>" 		rel="stylesheet" type="text/css"> 
<link href="<c:url value="/resources/jqgrid/css/jquery-ui.css" />" 			rel="stylesheet" type="text/css" />
   

<link href="<c:url value='/resources/jqgrid/css/ui.jqgrid.css'/>" 			rel="stylesheet" type="text/css"> 
<link href="<c:url value='/resources/jquery/custom/jquery-ui-1.8.16.custom.css'/>"	rel="stylesheet" type="text/css"/>  
<%-- <link href="<c:url value='/resources/jquery/custom/jquery.ui.1.8.16.ie.css'/>" 		rel="stylesheet" type="text/css"/>  --%>


<link href="<c:url value="/resources/custom/jquery.jgrowl.css" />" rel="stylesheet" type="text/css" />

 <!-- Placed at the end of the document so the pages load faster -->  
 
 <script type="text/javascript" src="<c:url value='/resources/jquery/jquery-1.8.3.min.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/jquery/jquery-ui-1.9.1.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/resources/jqgrid/js/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqgrid/js/i18n/grid.locale-en.js'/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js" />"></script>

<%-- <script type="text/javascript" src="<c:url value="/resources/js/demo.js" />"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resources/js/json2.js" />"></script>  --%>
<%-- <script type="text/javascript" src="<c:url value="/resources/js/date.format.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.validate.js" />"></script>
 <script type="text/javascript" src="<c:url value="/resources/js/jquery.jgrowl.js" />"></script> 
<script language="javascript" type="text/javascript" src="<c:url value='/resources/flot/js/jquery.flot.js'/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value='/resources/flot/js/excanvas.js'/>"></script>  

<!-- Placed at the end of the document so the pages load faster -->
<%-- <script type="text/javascript" src="<c:url value="/resources/js/jquery-1.8.0-min.js" />"></script> --%>
<!-- <script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js" />"></script> -->

 <%--  
	<script type="text/javascript" src="<c:url value="/resources/js/demo.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/json2.js" />"></script> 
	<script type="text/javascript" src="<c:url value="/resources/js/date.format.js" />"></script> 
  --%>
  
  
<!-- MAIN CONTENT SECTION -->
<style>
input.ui-pg-input {width: auto; padding: 0px; margin: 0px; line-height: normal}
select.ui-pg-selbox {width: auto; padding: 0px; margin: 0px; line-height: normal}
</style>

 

    
		  
    <% /* Please see ThemeController for theme selection */ %>

    <%--  <c:set var="themeSelection" value="${theme}"/>  --%>
     <%-- 	<script language="javascript" type="text/javascript"  src="<c:url value='/resources/flot/js/excanvas.js'/>"></script>    
     	<script language="javascript" type="text/javascript" src="<c:url value='/resources/validate/jquery.validate.js'/>"></script>
     	<script type="text/javascript" src="<c:url value='/resources/formalize/js/jquery.formalize.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/jgrowl/jquery.jgrowl.js'/>"></script>           
	<script language="javascript" type="text/javascript" src="<c:url value='/resources/flot/js/jquery.flot.js'/>"></script> 
	<script type="text/javascript" src="<c:url value='/js/jquery.fancybox.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/css/superfish.js'/>"></script>
	<script language="javascript" type="text/javascript" src="<c:url value='/resources/js/bootstrap.js'/>"></script>
	<script src="<c:url value='/resources/adaptive/js/adapt.min.js'/>"></script> --%>
     
    <script type="text/javascript">
          $(function() {
         $('#tabs').tabs();
        });
    </script>


    <script type="text/javascript">
        $(function() {
            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });

        $(function() {
            $("#incorporationDatepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });

        $(function() {
            $("#incorporationDatepicker1").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });

        $(function() {
            $("#incorporationDatepicker2").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });
        
        $(function() {
            $("#dueDatepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });
        
        $(function() {
        	$("#docDatepickerCrtFrom").datepicker({
        		dateFormat: 'yy-mm-dd',
        		 changeMonth: true,
                 changeYear: true,
                 yearRange: '-40:+20'
        		});
        	});
        $(function() {
        	$("#docDatepickerCrtTo").datepicker({
        		dateFormat: 'yy-mm-dd',
        		 changeMonth: true,
                 changeYear: true,
                 yearRange: '-40:+20'
                 });
        	});
        $(function() {
        	$("#docDatepickerDueFrom").datepicker({
        		dateFormat: 'yy-mm-dd',
        		 changeMonth: true,
                 changeYear: true,
                 yearRange: '-40:+20'
                 });
        	});
        $(function() {
        	$("#docDatepickerDueTo").datepicker({
        		dateFormat: 'yy-mm-dd',
        		 changeMonth: true,
                 changeYear: true,
                 yearRange: '-40:+20'});
        	});
    
        </script>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.columnFilter.js'/>"></script>    
	 <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.min.js'/>"></script>
	<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery.dataTables.js'/>"></script>  --%>
	<script type="text/javascript" src="<c:url value='/resources/js/DT_bootstrap.js'/>"></script>
	<link href="<c:url value="/resources/css/bs-override.css" />" rel="stylesheet" type="text/css" />
    <link href='<c:url value="/resources/css/common.css" />' rel='stylesheet' type='text/css' />
	
	<script type="text/javascript" src="<c:url value='/resources/colorbox/jquery.colorbox-min.js'/>"></script>

    <!-- google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Arimo' rel='stylesheet' type='text/css' />

  </head>
  
  
  
  
  
  
  