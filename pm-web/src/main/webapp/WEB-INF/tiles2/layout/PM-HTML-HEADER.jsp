<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='security'
           uri='http://www.springframework.org/security/tags' %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <title>Practice Management</title>

   <meta http-equiv="Expires" CONTENT="0">
   <meta http-equiv="Cache-Control" CONTENT="no-cache">
   <meta http-equiv="Pragma" CONTENT="no-cache">

    <link rel="stylesheet"
          href="<c:url value='/NEW_UI/adaptive/css/master.css'/>"
          type="text/css">
 
    <link rel="stylesheet"
          href="<c:url value='/NEW_UI/jqgrid/css/ui.jqgrid.css'/>"
          type="text/css"> 

    <link rel="stylesheet"
          href="<c:url value='/NEW_UI/formalize/css/formalize.css'/>"
          type="text/css"> 
		  
	  <link rel="stylesheet" 
		  href="<c:url value='/NEW_UI/jgrowl/jquery.jgrowl.css'/>" 
		  type="text/css" />  

    
    <link rel="stylesheet" href="<c:url value='/NEW_UI/css/superfish.css'/>" type="text/css" />
      
     
     <link rel="stylesheet"
          href="<c:url value='/NEW_UI/css/pm-common.css'/>"
          type="text/css"/>
		  
    <% /* Please see ThemeController for theme selection */ %>

    <c:set var="themeSelection" value="${theme}"/> 

     <link rel="stylesheet"
          href="<c:url value='/NEW_UI/themes/${themeSelection}/jquery.ui.all.css'/>"
          type="text/css"> 
   
    <script language="javascript" type="text/javascript" 
            src="<c:url value='/NEW_UI/flot/js/excanvas.js'/>"></script>   
		  
    <script type="text/javascript"
            src="<c:url value='/NEW_UI/jquery/jquery-1.8.3.min.js'/>"></script>
    <script type="text/javascript"
            src="<c:url value='/NEW_UI/jqgrid/js/i18n/grid.locale-en.js'/>"></script>
    <script type="text/javascript"
            src="<c:url value='/NEW_UI/jquery/jquery-ui-1.9.1.min.js'/>"></script>
    <script type="text/javascript"
            src="<c:url value='/NEW_UI/jqgrid/js/jquery.jqGrid.min.js'/>"></script>
    <script type="text/javascript"
            src="<c:url value='/NEW_UI/validate/jquery.validate.js'/>"></script>

    <script type="text/javascript"
            src="<c:url value='/NEW_UI/formalize/js/jquery.formalize.js'/>"></script>
			
	<script type="text/javascript" 
			src="<c:url value='/NEW_UI/jgrowl/jquery.jgrowl.js'/>"></script>           
  
    <script language="javascript" type="text/javascript" 
            src="<c:url value='/NEW_UI/flot/js/jquery.flot.js'/>"></script>
    
    <script type="text/javascript" src="<c:url value='/NEW_UI/js/superfish.js'/>"></script>
            
  
   
    <script>
    
    $("head").append("");
        // Edit to suit your needs.
        var ADAPT_CONFIG = {
            // Where is your CSS?
            path: '<c:url value="/NEW_UI/adaptive/css/"/>',

            // false = Only run once, when page first loads.
            // true = Change on window resize and page tilt.
            dynamic: true,

            // First range entry is the minimum.
            // Last range entry is the maximum.
            // Separate ranges by "to" keyword.
            range: [
                '0px    to 760px  = mobile.min.css',
                '760px  to 980px  = 960.min.css',
                '980px  to 1280px = fluid.min.css',
                '1280px to 1600px = fluid.min.css',
                '1600px to 1920px = fluid.min.css',
                '1920px           = fluid.min.css'
            ]
        };
    </script>
    <script src="<c:url value='/NEW_UI/adaptive/js/adapt.min.js'/>"></script>
     
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
            $("#dueDatepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });
        
        $(function() {
        	$("#docDatepickerCrtFrom").datepicker({dateFormat: 'yy-mm-dd'});
        	});
        $(function() {
        	$("#docDatepickerCrtTo").datepicker({dateFormat: 'yy-mm-dd'});
        	});
        $(function() {
        	$("#docDatepickerDueFrom").datepicker({dateFormat: 'yy-mm-dd'});
        	});
        $(function() {
        	$("#docDatepickerDueTo").datepicker({dateFormat: 'yy-mm-dd'});
        	});
    </script>
    
<script type="text/javascript">
 
 if (screen.width <= 800) {
  window.location = "http://192.168.1.11:7865/pm/home/home.do";
 }
 
</script>

    <style>
        body {
            margin: 0px;
            font-size: 70%;
        }

        .pressed {
            border: 1px solid #f7f7f7;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            padding: 5px;
            height: 15px;
            border: 1px solid #ccc;
        }

        .submenu {
            margin-left: 7px;
            margin-top: -1px;
            margin-right: 7px;
            border: 0px;
            border-background: none;
            line-height: 14px;
        }

        .form-table {
            width: 960px;
            margin-left: 150px;
            margin-right: 150px;
        }

        div.row {
            clear: both;
            padding-top: 5px;
            font-weight: bold;
            font-size: 86%;
        }

        div.row span.label {
            float: left;
            width: 100%;
            text-align: right;
        }


    </style>
     
</head>