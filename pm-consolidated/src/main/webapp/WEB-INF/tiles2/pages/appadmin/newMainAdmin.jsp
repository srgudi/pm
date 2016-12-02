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
<div class="yui3-u-1-5" style="margin-top: 22px;width:200px">

<div id="accordion" style="min-width: 150px;">  
		<!-- <form:form action=""> -->
		<br/>
			<span class="menuCap"></span>

 <div class="bs-docs-sidebar" style="width:200px;" id="AdminMainTab" > 

  <ul class="nav nav-tabs nav-stacked" id="adminTabs"> 
   <li class="active"><a href="#firmList" onclick="mainFirm()" data-toggle="tab"><spring:message code="label.firmList"/></a></li> 
   <li><a href="#jurisdictionList" onclick="mainJurisdiction()" data-toggle="tab"><spring:message code="label.jurisdiction"/></a></li>
   <li><a href="#codeTypeList" onclick="mainCodeType()" data-toggle="tab"><spring:message code="label.codeType"/></a></li>
   <li><a href="#codeList" onclick="mainCode()" data-toggle="tab"><spring:message code="label.code"/></a></li> 
   <li><a href="#templateList" onclick="mainTemplate()" data-toggle="tab"><spring:message code="label.templates"/></a></li>
   <li><a href="#recepientsList" onclick="mainRecepient()" data-toggle="tab"><spring:message code="label.recepients"/></a></li>
 </ul> 

 </div> 
		<!-- </form:form> -->
	</div>   	

</div>

<div class="yui3-u-19-24" style="min-width:150px; margin-top: 22px;">
<br/>
<div id="headerBand" class="headerCap"></div>
  <div class="span6">  
</div>
 <div class="tab-content">
 <div class="tab-pane active" id="firmList">
 <%@ include file="firmTabs.jsp" %> 
  </div> 
   <div class="tab-pane" id="jurisdictionList">
 <%@ include file="jurisdictionTabs.jsp" %> 
  </div>
 <div class="tab-pane" id="codeTypeList">
 <%@ include file="codeTypeTabs.jsp" %> 
  </div> 
  <div class="tab-pane" id="codeList">
 <%@ include file="codeTabs.jsp" %> 
  </div> 
  <div class="tab-pane" id="templateList">
 <%@ include file="templateTabs.jsp" %> 
  </div>
  <div class="tab-pane" id="recepientsList">
 <%@ include file="recepientsTabs.jsp" %> 
  </div>
  </div>
  </div>

   <!-- tabbable -->
</div>

<script type="text/javascript">
function mainFirm(){
	$('#firmhome').show();
	$('#firmTabs a:first').tab('show');
	$('#firmfoo').hide();
}
function mainJurisdiction(){
	$('#jurihome').show();
	$('#juriTabs a:first').tab('show');
	$('#jurifoo').hide();
}
function mainCodeType(){
	$('#codeTypehome').show();
	$('#codeTypeTabs a:first').tab('show');
	$('#codeTypefoo').hide();
}
function mainCode(){
	$('#codehome').load('adminCode.do');
}
function mainTemplate(){
	$('#templatehome').show();
	$('#templateTabs a:first').tab('show');
	$('#templatefoo').hide();
}
function mainRecepient(){
	$('#recepienthome').show();
	$('#recepientsTabs a:first').tab('show');
	$('#recepientfoo').hide();
}
</script>
