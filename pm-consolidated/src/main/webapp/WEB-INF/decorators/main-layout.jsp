<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Practice Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet"  type="text/css" />    
  <link href="<c:url value="/resources/css/bootstrap-responsive.min.css" />" rel="stylesheet"  type="text/css" />    
  
  <style type="text/css">
    body {
      padding-top: 60px;
      padding-bottom: 40px;
    }
    .sidebar-nav {
      padding: 9px 0;
    }
  </style>

  <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

</head>

<body>

   	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
      	<div class="container-fluid">
      		<c:import url="/WEB-INF/views/tags/navbar.jsp"/> 	
        </div>			      		 
      </div>
   	</div>

   	<div class="container-fluid">
	    <%--  <div class="row-fluid">
        <div class="span2">
          <div class="well sidebar-nav">
          	<c:import url="/WEB-INF/views/tags/menu.jsp"/>   
          </div><!--/.well -->
        </div><!--/span--> --%>
        <div class="span12">         
           <%--  <div class="hero-unit">
              <c:import url="/WEB-INF/views/tags/banner.jsp"/>       
            </div> --%>
            <div class="row-fluid">
              <div class="span12">
                  <div class="container" align="center">
                    
                  </div>

                <hr class="soften">
     
                <decorator:body />
                
              </div>
              </div><!--/span-->
            </div><!--/row-->                 
        </div><!--/span-->
      </div><!--/row-->
	   
      <hr>

  	  <footer>
    	 <c:import url="/WEB-INF/views/tags/footer.jsp"/>
  	  </footer>

    </div>

	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.8.0-min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js" />"></script>
  <script type="text/javascript" src="<c:url value="/resources/js/demo.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/json2.js" />"></script> 
  <script type="text/javascript" src="<c:url value="/resources/js/date.format.js" />"></script>
</body>
</html>