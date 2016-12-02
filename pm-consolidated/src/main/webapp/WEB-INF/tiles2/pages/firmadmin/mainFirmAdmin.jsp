<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<div class="tabbable">
<!-- MAIN CONTENT SECTION -->

<div class="yui3-u-1-5" style="margin-top: 22px;width:200px">

<div id="accordion" style="min-width: 150px;">  
		<%-- <form:form action=""> --%>
		<br/>
			<span class="menuCap"></span>

 <div class="bs-docs-sidebar" style="width:200px;" id="MainFirmTab" > 
<ul class="nav nav-tabs nav-stacked"> 
 <li><a data-target="#firmStaffList" onclick="mainFirmStaff()" data-toggle="tab"><spring:message code="label.firmStaff"/></a></li>
 <li><a data-target="#taxTypeList" onclick="mainTaxType()" data-toggle="tab"><spring:message code="label.taxType"/></a></li>
 <li><a href="#partyCodeList" data-toggle="tab"><spring:message code="label.code"/></a></li>
 </ul> 
 </div>
 
		<%-- </form:form> --%>
	</div>   	

</div>
<div class="yui3-u-19-24" style="min-width:150px; margin-top: 22px;">
<br/>
<div id="headerBand" class="headerCap"></div>
  <div class="span6">  
</div>
 <div class="tab-content">
 <div class="tab-pane" id="firmStaffList">
 <%@ include file="firmStaffTabs.jsp" %> 
  </div> 
   <div class="tab-pane" id="taxTypeList">
 <%@ include file="taxTypeTabs.jsp" %> 
  </div>
 <div class="tab-pane" id="partyCodeList">
  <%@ include file="codeTab.jsp" %> 
  </div> 
  </div>
  </div>
  
  
  <script>
$(function() {
	//$('.navActive').hide().removeClass('navActive');
$("#MainFirmTab").tab(); // initialize tabs
$("#MainFirmTab").bind("show", function(e) {
//	alert("event");
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");

if (typeof(contentURL) != 'undefined') {
// state: has a url to load from
$(contentID).load(contentURL, function(){
$("#MainFirmTab").tab(); // reinitialize tabs
});

} else {
//state: no url, to show static data
$(contentID).tab('show');
}
});
$('#MainFirmTab a:first').tab("show"); // Load and display content for first tab

});

function mainFirmStaff(){
	$('#firmStaffhome').show();
	$('#firmStaffTabs a:first').tab('show');
	$('#firmStaffFoo').hide();
}
function mainTaxType(){
	$('#taxTypehome').show();
	$('#taxTypeTabs a:first').tab('show');
	$('#taxTypeFoo').hide();
}
</script>