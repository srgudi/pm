<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>
<br/>
<br/>

<div class="yui3-u-1-6" id="leftmenufiller">&nbsp;</div>
<div class="yui3-u-1-6" id="leftmenumain">
	<script type="text/javascript">
		$(document).ready(function() 
		{
		
		$("#leftmenufiller").show();
		$("#leftmenumain").hide();		
		
		$("#accordion").accordion({
				header : "h3",
				autoHeight : false,
				collapsible : true,
				active : false
			});
			
			$( "#tabs" ).tabs();
			    
		});
	</script>
	
	
	
	
	<!-- new accordion begins -->
	<span class="menuCap"></span>	
	
	<!-- sample code begins here -->
      <div class="bs-docs-sidebar">
        <!--<ul class="nav nav-list bs-docs-sidenav">-->

	<ul class="nav nav-tabs nav-stacked">
	  <li><a href="#" id="TaskList"  onclick=MainTabHide();><i class="icon-right"></i>Task List </a>  
	  <li><a href="#" id="CliDoc"	  onclick=DocTabCtrl();><i class="icon-right"></i>Task Documents </a> 
	</ul>

      </div>	
	<!-- client left navigation ends here -->

</div>


<div class="yui3-u-19-24" style="margin-top: 5px;">
	<div id="headerBand" class="headerCap"></div>
	
  <!-- tabbable div is parent container for New client button & jqgrid -->
<div class="tabbable">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="mainTaskTabs">    
        <li><a data-target="#list"  href="taskList.do"  class="active" data-toggle="tab"><spring:message code="label.list"/></a></li>
        <li><a data-target="#edit"  href="taskModule.do" data-toggle="tab"><spring:message code="label.addoredit"/></a></li>
		<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
		<li id="yui-g">
			<button type="button" id="taskDetail" class="btn btn-primary nav nav-tabs reducedBottom"><spring:message code="label.newTask"/></button>
		</li>   			
		</security:authorize>
	</ul> 	
     <ul class="nav nav-tabs reducedBottom" id="taskDocumentTabs">    
        <li><a data-target="#list"  href="taskDocuments.do" class="active" data-toggle="tab"><spring:message code="label.upload"/></a></li>
        <li><a data-target="#edit" onClick=SearchClk(); data-toggle="tab"><spring:message code="label.search"/></a></li> 
    </ul>
     
    <div class="tab-content">
    	<!-- list is the div containing jqgrid & New client button -->
        <div class="tab-pane" id="list"></div>
        <div class="tab-pane" id="edit"></div>
    </div>
</div>
</div>




<script>
$(function() {

$("#taskDocumentTabs").tab().hide();

$("#mainTaskTabs").tab().show(); // initialize tabs
$("#mainTaskTabs").bind("show", function(e) {
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");
$(contentID).load(contentURL, function(){
$("#mainTaskTabs").tab(); // reinitialize tabs
});
});
$('#mainTaskTabs a:first').tab("show"); // Load and display content for first tab
$("#leftmenumain").hide(); // hide the left menu when list is displayed
$("#leftmenufiller").show(); 


 // Load and display content for first tab

});


 function MainTabHide(){
	 $("#leftmenufiller").show();
	 $("#leftmenumain").hide(); 	
	
	 $("#taskDocumentTabs").tab().hide();
	
	 $("#mainTaskTabs").tab().show(); 
	 $("#mainTaskTabs").bind("show", function(e) {
	 var contentID = $(e.target).attr("data-target");
	 var contentURL = $(e.target).attr("href");
	 $(contentID).load(contentURL, function(){
	 $("#mainTaskTabs").tab();
	 });
	 });
	 $('#mainTaskTabs a:first').tab("show"); 
 }
 
 
 
 
 
 
 function DocTabCtrl(){
		$("#mainTaskTabs").tab().hide();
		
		$("#taskDocumentTabs").tab().show();
		
		 $("#taskDocumentTabs").bind("show", function(e) {
		var contentID = $(e.target).attr("data-target");
		var contentURL = $(e.target).attr("href");
		$(contentID).load(contentURL, function(){
		   $("#taskDocumentTabs").tab(); // reinitialize tabs
		});
		});
		$('#taskDocumentTabs a:first').tab("show"); 
		
	}




 function SearchClk(){
	 $('#edit').load('taskDocumentSearch.do');
	 $('#taskDocumentTabs a:last').tab('show');
 }

 function HideLeftMenu(){
	$("#leftmenufiller").show();
	$("#leftmenumain").hide();
			}
 
</script>