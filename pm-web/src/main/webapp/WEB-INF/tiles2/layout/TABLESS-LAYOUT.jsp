<%@ include file="PM-INCLUDES.jsp" %>
  
       <tiles:insertAttribute name="html-header"/> 
     
	   	<body>
	   	
		<!--  BEGIN PAGE -->
		<div id="doc3" class="yui-t2">
			<tiles:insertAttribute name="banner"/>		
			
			<div id="bd" class="container_12">	
			
				<tiles:insertAttribute name="body"/>	
			</div>
			
		</div>
		</div>
    
	  <!-- FOOTER -->
		<div id="ft"
			style="background: #33A1DE; height: 25px; color: white; position: fixed; bottom: 0; width: 100%;">
		</div>
	
</body>
</html>