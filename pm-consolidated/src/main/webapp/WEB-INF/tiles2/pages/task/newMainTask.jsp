<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<div class="yui3-u-1-5" style="margin-top: 22px;width:200px">
<div id="accordion" style="min-width: 150px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"></span>

 <div class="bs-docs-sidebar" style="width:200px;" id="MainTaskTab" > 
<ul class="nav nav-tabs nav-stacked"> 
<li><a href="mainTask.do" onclick="window.location='mainTask.do';return false;" data-toggle="tab"><spring:message code="label.taskList"/></a></li>
 <!-- <li><a href="#editTask" data-toggle="tab" class="active">Add/Edit Client</a></li> -->
     <li><a href="#documentList"  data-toggle="tab"><spring:message code="label.documents"/></a></li>
 </ul> 
 </div>
 
		</form:form>
	</div>
	</div>
	
	<div class="yui3-u-19-24" style="min-width:150px; margin-top: 22px;">
<br/>
<div id="headerBand" class="headerCap"></div>
 <!--  <div class="span6">  
</div> -->
 <div class="tab-content">
 <div class="tab-pane active" id="editTask">
 <%@ include file="taskModule.jsp" %> 
  </div> 
  <div class="tab-pane" id="documentList">
 <%@ include file="documentTabs.jsp" %> 
  </div>  
  </div>
  </div>
  
  
  <script>
$(function() {
	//$('.navActive').hide().removeClass('navActive');
$("#MainTaskTab").tab(); // initialize tabs
$("#MainTaskTab").bind("show", function(e) {
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");

if (typeof(contentURL) != 'undefined') {
// state: has a url to load from
$(contentID).load(contentURL, function(){
$("#MainTaskTab").tab(); // reinitialize tabs
});

} else {
//state: no url, to show static data
$(contentID).tab('show');
}
});
$('#MainTaskTab a:first').tab("show"); // Load and display content for first tab

});
</script>