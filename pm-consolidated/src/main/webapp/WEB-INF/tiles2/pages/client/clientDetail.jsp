<!-- <script>
            $(document).ready(function () {
            	alert("Hi");
            	 $('a', '#gallery').colorbox();
            });
</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
 <body>
        <a class='gallery' href='resources/jquery/colorbox/image1.jpg'>Photo_1</a>
        <a class='gallery' href="resources/jquery/colorbox/image2.jpg">Photo_2</a>
        <a class='gallery' href='resources/jquery/colorbox/image3.jpg'>Photo_3</a>
</body> -->

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>

<!-- MAIN CONTENT SECTION -->

<div class="yui3-u-1-5" style="margin-top: 22px;width:200px">
<div id="accordion" style="min-width: 150px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"></span>

 <div class="bs-docs-sidebar" style="width:200px;" id="MainTab" > 
<ul class="nav nav-tabs nav-stacked"> 
<%-- <li><a href="mainClient.do" onclick="window.location='mainClient.do';return false;" data-toggle="tab"><spring:message code="label.clientList"/></a></li> --%>
 <!-- <li><a href="#editClient" data-toggle="tab" class="active">Add/Edit Client</a></li> -->
 <li><a data-target="#staffList" onclick="mainStaff()" data-toggle="tab"><spring:message code="label.staff"/></a></li>
 <li><a href="#offList" onclick="mainOff()"  data-toggle="tab"><spring:message code="label.officersAndShareHolders"/></a></li>
 <li><a href="#locationList" onclick="mainLoc()" data-toggle="tab"><spring:message code="label.location"/></a></li>
 <li><a data-target="#bankList" onclick="mainBank()" data-toggle="tab"><spring:message code="label.bank"/></a></li> 
 <li><a href="#lawyerList" onclick="mainLaw()" data-toggle="tab"><spring:message code="label.lawyers"/></a></li>
 <li><a href="#insuranceList" onclick="mainInsc()"  data-toggle="tab"><spring:message code="label.insurances"/></a></li>
 <li><a href="#transferList" onclick="mainTran()" data-toggle="tab"><spring:message code="label.transferAgents"/></a></li> 
 <li><a href="#documentList" onclick="mainDoc()" data-toggle="tab"><spring:message code="label.documents"/></a></li>     
 </ul> 
 </div>
 
		</form:form>
	</div>   	

</div>
<div class="yui3-u-19-24" style="min-width:150px; margin-top: 22px;">
<br/>
<div id="headerBand" class="headerCap">&nbsp;${clientName}</div>
  <div class="span6">  
</div>
 <div class="tab-content">
<%--  <div class="tab-pane active" id="editClient">
 <%@ include file="editClient.jsp" %> 
  </div>  --%>
   <div class="tab-pane" id="bankList">
 <%@ include file="bankTabs.jsp" %> 
  </div>
 <div class="tab-pane" id="staffList">
 <%@ include file="staffTabs.jsp" %> 
  </div> 
  <div class="tab-pane" id="locationList">
 <%@ include file="locationTabs.jsp" %> 
  </div> 
  <div class="tab-pane" id="offList">
 <%@ include file="officerTabs.jsp" %> 
  </div>
  <div class="tab-pane" id="transferList">
 <%@ include file="transferTabs.jsp" %> 
  </div>
  <div class="tab-pane" id="insuranceList">
 <%@ include file="insuranceTabs.jsp" %> 
  </div>
   <div class="tab-pane" id="lawyerList">
 <%@ include file="lawyerTabs.jsp" %> 
  </div> 
  <div class="tab-pane" id="documentList">
 <%@ include file="documentTabs.jsp" %> 
  </div>  
  </div>
  </div>
  
<script>
$(function() {
$("#MainTab").tab(); // initialize tabs
$("#MainTab").bind("show", function(e) {
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");

if (typeof(contentURL) != 'undefined') {
// state: has a url to load from
$(contentID).load(contentURL, function(){
$("#MainTab").tab(); // reinitialize tabs
});

} else {
//state: no url, to show static data
$(contentID).tab('show');
}
});
$('#MainTab a:first').tab("show"); // Load and display content for first tab

});
function mainStaff(){
	$('#stfhome').show();
	$('#stfTabs a:first').tab('show');
	$('#stffoo').hide();
}

function mainOff(){
    $('#officerhome').show();
    $('#officerTabs a:first').tab('show');
    $('#officerfoo').hide();
}
function mainLoc(){
	 $('#locationhome').show();
	 $('#locationTabs a:first').tab('show');
	 $('#locationfoo').hide();
}
function mainBank(){
	 $('#home').show();
	 $('#myTabs a:first').tab('show');
	 $('#foo').hide();
}
function mainLaw(){
	 $('#lawyerhome').show();
	 $('#lawyerTabs a:first').tab('show');
	 $('#lawyerfoo').hide();
}
function mainInsc(){
	 $('#insurancehome').show();
	 $('#insuranceTabs a:first').tab('show');
	 $('#insurancefoo').hide();
}
function mainTran(){
	 $('#transferhome').show();
	 $('#transferTabs a:first').tab('show');
	 $('#transferfoo').hide();
}
function mainDoc(){
	$('#documenthome').load('clientDocuments.do');
	$('#documentTabs a:first').tab('show');
	$('#documenthome').show();
	$('#documentfoo').hide();
}
</script>