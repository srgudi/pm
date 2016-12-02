<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<br/>
<div class="yui3-u-1-5" style="margin-top: 5px;width:200px">

<script type="text/javascript">
		$(document).ready(function() {
			var cId = ${clientId};
			//alert("hi"+cId);
			//var fpId = ${firmPracticeId};
			//alert("hi"+fpId);
		$("#accordion").accordion({
				header : "h3",
				autoHeight : false,
				collapsible : true,
				active : false
			});
			
			$( "#tabs" ).tabs();
			    
		});
	 
</script>

<div id="accordion" style="min-width: 150px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"> 
			</span>
			<ul class="nav nav-tabs nav-stacked"> 
                <li><a href="#" onclick=TabHide();><i class="icon-right"></i><spring:message src="label.taxList"/>Tax List</a>
                </li>
            </ul>
		</form:form>
	</div>   	

</div>

<div class="yui3-u-19-24" style="min-width:150px;">
<br/>
<div class="headerCap">${clientName}</div>
 <!--  <div class="span6">  
</div> -->
<div class="tabbable">

 <ul class="nav nav-tabs" style="margin-bottom:0px;" id="mainTaxTabs"> 
  
        <li><a data-target="#list"  href="taxList.do" class="active" data-toggle="tab"><spring:message src="label.taxList"/>Tax List</a></li>
        <li><a data-target="#update"  onClick=TabClk(); data-toggle="tab"><spring:message src="label.taxAddEdit"/>Tax Add/Edit</a></li>
 </ul> 
 <div class="tab-content">
        <div class="tab-pane" id="list"></div>
        <div class="tab-pane" id="update"></div>
    </div>
 </div>
 </div>
 
 <script>
$(function() {
$("#mainTaxTabs").tab().show(); // initialize tabs
$("#mainTaxTabs").bind("show", function(e) {
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");
$(contentID).load(contentURL, function(){
$("#mainTaxTabs").tab(); // reinitialize tabs
});
});
$('#mainTaxTabs a:first').tab("show"); // Load and display content for first tab

 // Load and display content for first tab

});
function TabHide(){
	$("#mainTaxTabs").tab().show(); // initialize tabs
	 $("#mainTaxTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#mainTaxTabs").tab(); // reinitialize tabs
	});
	});
	$('#mainTaxTabs a:first').tab("show"); 
	
}
function TabClk(){
		$('#update').load('taxModule.do?clientId='+${clientId});
		$('#mainTaxTabs a:last').tab('show');
	}
</script>