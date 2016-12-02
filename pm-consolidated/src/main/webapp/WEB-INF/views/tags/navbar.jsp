<!-- navbar begins here -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="../tags/banner.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>
<style type="text/css">
label.popupLabel {
	display:block;
	font-weight:bold
}
input.popupInput {
	margin-bottom:12px;
	width:95%;
	padding: .4em;
	display:block;
}
div#users-contain {
	width: 350px;
	margin: 20px 0;
}
div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}
div#users-contain table td, div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}
.ui-dialog .ui-state-error {
	padding: .3em;
}
.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}
</style> 

     <!--<div class="row">&nbsp;</div>-->
<!--<div class="row">&nbsp;</div>-->
<!-- nav bar ends here -->
<script type = "text/javascript" >
$(document).ready(function () 
{	
	$.ajaxSetup({
		        headers: {"X-Requested-With":"XMLHttpRequest"}
		  });
	
	$('#HeadMenuBar li').hover(
		function () {
			$('ul', this).slideDown(100);
			}, 
		function () {
			$('ul', this).slideUp(100);			
			}
				);	
});

	/*  $("#assign_to").typeahead({
		var oldPassword = $("#oldPassword").val();
	    var newPassword = $("#newPassword").val();
	    var confirmPassword = $("#confirmPassword").val();
	   // source: [{value: 'Charlie'}, {value: 'Gudbergur'}]              
	});  */
	
$(document).ready(function () {
      $('.dropdown-toggle').dropdown({ trigger : 'hover' });     
}); 
		
$(function() {				  
		
		var opts = {
		    	autoOpen: false,
		    	height: 320,
		        width: 360,
		        modal: true
			};
		var opt = {
				autoOpen: false,
				height: 220,
				width: 360,
				modal: true
				};
		
		$("#password").live("click",function() {
		   $("#password-form").dialog(opts).dialog("open");
		});
		$("#language").live("click",function() {
			// alert("Hello");
		   $("#language-form").dialog(opt).dialog("open");
			//$dialog.dialog("open");
		});
	});
$('#savePassword').live('click',function(){	
	var oldPassword = $("#oldPassword").val();
    var newPassword = $("#newPassword").val();
    var confirmPassword = $("#confirmPassword").val();  
    if(newPassword == confirmPassword){
    	$.get("<c:url value='/changePassword.do'/>", {newPassword: newPassword,oldPassword:oldPassword}, function(data) {
    		if(data.id == "1"){
	    		$.jGrowl('New password is updated sucessfully');
	    		$("#password-form").dialog("close");
            }else{
            	$.jGrowl('Invalid old Password. Please try again !'); 
            }
    	});
    }else{
    	$.jGrowl('New password and confirm password mismatch. Please try again !');
    }
    resetFields();
})

 function CancelPasswordForm(){
	/* $("#password-form").dialog("close"); */
	resetFields();
}
/* $('#cancelPassword').live('click',function(){	
	$("#password-form").reset();
}); */

function LanguageSubmitForm(){
	var newLanguage = $("#newLanguage").val();
	if(newLanguage != '-1'){
		$.get("<c:url value='/saveLanguage.do'/>", {newLanguage: newLanguage}, function(data) {
    		if(data.id == "1"){
	    		$.jGrowl('Language is updated sucessfully');
	    		$("#language-form").dialog("close");
	    		location.reload();
            }else{
            	$.jGrowl('As Error has happened while process. Please contact Administrator'); 
            }
    	});
	}else{
    	$.jGrowl('Plese select anyone language!');
    }
}

function CancelLanguageForm(){
	 $("#language-form").dialog("close");
}

function resetFields() {
	$('#password-form').find("input[id='oldPassword']").val("");
	$('#password-form').find("input[id='newPassword']").val("");
	$('#password-form').find("input[id='confirmPassword']").val("");
}
</script>

 <div style="display: none;">
 <div id="password-form" title="Change Password" class="passwordForm">
  <!-- <div id="testdiv" class="myclass" style="height:50px;width:150px;border: 2px solid red">
  </div> -->
  <label for="oldPassword" class="popupLabel">Old Password</label>
  <input type="password" name="oldPassword" id="oldPassword" class="popupInput ui-widget-content ui-corner-all" />
  <label for="newPassword" class="popupLabel">New Password</label>
  <input type="password" name="newPassword" id="newPassword" class="popupInput ui-widget-content ui-corner-all" />
  <label for="confirmPassword" class="popupLabel">Confirm Password</label>
  <input type="password" name="confirmPassword" id="confirmPassword" class="popupInput ui-widget-content ui-corner-all" />
  <a class="button_red10"  href="javascript:;"> <button  id="savePassword"
						class="btn btn-success">Save</button> </a> 
  <a class="button_red10"  href="javascript:;" onclick="CancelPasswordForm(this)"> <button id="cancelPassword" type="reset"
                            	class="btn btn-success"
                            	 aria-disabled="false">Cancel</button> </a> 
</div>
 <div id="language-form" title="Language" class="headerCap">
<label class="popupLabel" for="newLanguage"><b>Language</b></label> 
  <select name="newLanguage" id="newLanguage" class="text ui-widget-content ui-corner-all" style="width:312px;">
    <option value="en" <c:if test="${lang eq 'en'}">selected</c:if>> English</option>
    <%-- <option value="hi" <c:if test="${lang eq 'hi'}">selected</c:if>> Hindi</option> --%>
    <option value="sp" <c:if test="${lang eq 'sp'}">selected</c:if>> Spanish</option>
  </select>
  <a class="button_red10" id="saveLanguage" href="javascript:;" onClick="LanguageSubmitForm(this);"> <button id="saveLanguage" type="submit"
                            	class="btn btn-success"
                            	 aria-disabled="false">Save</button></a> 
  <a class="button_red10" id="cancelLanguage" href="javascript:;" onClick="CancelLanguageForm(this);"> <button id="cancelLanguage" type="reset"
                            	class="btn btn-success"
                            	 aria-disabled="false">Cancel</button> </a> 
</div>

</div>		      		 
<!--<div class="row">&nbsp;</div>-->
	
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"  style="width:auto;padding:0px 5px 5px;">
    <!--navigation begins here-->
		<ul class="nav">
		  <li class="active"><a class="brand" href="#">Practice Management</a></li>
		  
		<li><a href="../dashboard/dashboard.do"><i class="icon-dashboard"></i> &nbsp;&nbsp;<spring:message code="label.dashboard"></spring:message></a></li>
		<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
		  <li><a href="../client/mainClient.do"><spring:message code="label.clients"/></a></li>
		  </security:authorize>
		  <li><a href="../task/mainTask.do"><i class="icon-tasks" style="background-position: 14px 14px; margin-right: 3px;"></i><spring:message code="label.tasks"/></a></li>
		   <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
		  <c:if test="${not empty clientId}">
		  <li><a href="../tax/mainTax.do"><spring:message code="label.taxes"/></a></li>
		  </c:if>
		  </security:authorize>
		  <security:authorize access="hasAnyRole('ROLE_APP_ADMIN')">
		  <li><a href="../appadmin/mainAdmin.do"><spring:message code="label.administration"/></a></li>
		  </security:authorize>
		   <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
		  <li><a href="../firmadmin/mainFirmAdmin.do"><spring:message code="label.firmAdmin"/></a></li>
		  </security:authorize>
		  	 <!-- <li><a href="/pm-new/reports/mainReport.do">Reports</a></li>  -->
		  	 <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_FIRM_PARTNER','ROLE_STAFF','ROLE_APP_ADMIN')">
		 <li class="dropdown" id="accountmenu">  
                        <a class="dropdown-toggle" data-toggle="dropdown" href=""><i class="icon-file" style="background-position: 14px 14px;"></i><spring:message code="label.reports"/><b class="caret"></b></a>  
                        <ul class="dropdown-menu">  
                        	<li><a href="../reports/taskPaymentDetails.do"><spring:message code="label.paymentDetails"/></a></li>
                        	<li><a href="../reports/clientListwithDetails.do"><spring:message code="label.clientListWithDetails"/></a></li>
                        	 <li><a href="../reports/clientListByMisDeadLines.do"><spring:message code="label.listByMissedDeadlines"/></a></li>
                        	<li><a href="../reports/taskListByEmp.do"><spring:message code="label.taskListByEmployee"/></a></li>
                        	<li><a href="../reports/dueDateByTask.do"><spring:message code="label.taskListByTaxType"/></a></li>
                        	<li><a href="../reports/newTaxListByStaff.do"><spring:message code="label.workLoadSummary"/></a></li>
                            <li><a href="../reports/clientByFirm.do"><spring:message code="label.clientListByFirm"/></a></li> 
                            <li><a href="../reports/taskListByFilingType.do"><spring:message code="label.taskListByFilingType"/></a></li>
                            <li><a href="../reports/taskListByFirm.do"><spring:message code="label.taskListByFirm"/></a></li>
                            <li><a href="../reports/taskListByStatus.do"><spring:message code="label.taskListByStatus"/></a></li>
                            <li><a href="../reports/filingsByClient.do"><spring:message code="label.filingsByClient"/></a></li>
                            <li><a href="../reports/clientListbyPartner.do"><spring:message code="label.clientListByPartner"/></a></li>  
                            <li><a href="../reports/taskByDueDate.do"><spring:message code="label.taskReportByDueDate"/></a></li>
                            <li><a href="../reports/taskListByPartner.do"><spring:message code="label.taskListByPartner"/></a></li>  
                        </ul>  
                    </li>
	      <li><a href="../calendar/calendar.do"><i class="icon-calendar" style="background-position: 14px 14px; margin-right: 3px"></i><spring:message code="label.calendar"/></a></li>
		 <li> 
		  <form class="navbar-search pull-left" action="../document/searchDocument.do" method="get" > 
		      <input type="text" name="fn" id="fn" class="search-query" placeholder="Search">
		  </form> 
		  </li>
</security:authorize>
<%-- <security:authorize access="hasRole('ROLE_CLIENT_STAFF)">
           <li class="dropdown" id="accountmenu">  
                        <a class="dropdown-toggle" data-toggle="dropdown" href=""><i class="icon-file" style="background-position: 14px 14px;"></i><spring:message code="label.reports"/><b class="caret"></b></a>  
                        <ul class="dropdown-menu">  
                        	<li><a href="../reports/clientListwithDetails.do"><spring:message code="label.clientListWithDetails"/></a></li>
                        	 <li><a href="../reports/clientListByMisDeadLines.do"><spring:message code="label.listByMissedDeadlines"/></a></li>
                        	<li><a href="../reports/taskListByEmp.do"><spring:message code="label.taskListByEmployee"/></a></li>
                        	<li><a href="../reports/dueDateByTask.do"><spring:message code="label.taskListByTaxType"/></a></li>
                        	<li><a href="../reports/newTaxListByStaff.do"><spring:message code="label.workLoadSummary"/></a></li>
                            <li><a href="../reports/clientByFirm.do"><spring:message code="label.clientListByFirm"/></a></li> 
                            <li><a href="../reports/taskListByFilingType.do"><spring:message code="label.taskListByFilingType"/></a></li>
                            <li><a href="../reports/taskListByFirm.do"><spring:message code="label.taskListByFirm"/></a></li>
                            <li><a href="../reports/taskListByStatus.do"><spring:message code="label.taskListByStatus"/></a></li>
                            <li><a href="../reports/filingsByClient.do"><spring:message code="label.filingsByClient"/></a></li>
                            <li><a href="../reports/clientListbyPartner.do"><spring:message code="label.clientListByPartner"/></a></li>  
                            <li><a href="../reports/taskByDueDate.do"><spring:message code="label.taskReportByDueDate"/></a></li>
                            <li><a href="../reports/taskListByPartner.do"><spring:message code="label.taskListByPartner"/></a></li>  
                        </ul>  
                    </li>
</security:authorize> --%>
    </ul>

  <ul class="nav pull-right">
	<!--   btn group begins -->
			<div class="btn-group">
			  <a class="btn btn-primary" href="#"><i class="icon-user" style="background-position: 14px 14px;"></i>&nbsp;${username}</a>
			  <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="icon-caret-down"></span></a>
			  <ul class="dropdown-menu">
				<li><a href="javascript:;" id="password"><i class="icon-key"></i> Change Password</a></li>
				<!-- <li><a href="#" id="settings"><i class="icon-cogs"></i> Settings</a></li> -->
				<li><a href="javascript:;" id="language" class="myClass"><i class="icon-cogs"></i> Language</a></li>
				<li><a href="../user/userProfile.do" id="myprofile"><i class="icon-user" style="background-position: 14px 14px;"></i> My Profile</a></li>
				<li class="divider"></li>
				<li><a href="../j_spring_security_logout"><i class="icon-signout"></i> Signout</a></li>
			  </ul>
			</div>
	<!-- btn group ends -->
	</ul>
    <!-- navigation ends here -->
    </div>
  </div>
</div>
