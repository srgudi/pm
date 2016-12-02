<%@ include file="PM-INCLUDES.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script type = "text/javascript" >
$(function() {				  
	
	var opts = {
	    	autoOpen: false,
	    	height: 320,
	        width: 360,
	        modal: true
		};
	$("#passwordmob").live("click",function() {
	   $("#password-form").dialog(opts).dialog("open");
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
		resetFields();
	}
	
	function resetFields() {
		$('#password-form').find("input[id='oldPassword']").val("");
		$('#password-form').find("input[id='newPassword']").val("");
		$('#password-form').find("input[id='confirmPassword']").val("");
	}
});
</script>
<c:url value="/mobile/home.do" var="homeurl"/>  
<c:url value="/mobileuser/mobileChangePassword.do" var ="passwordURL"/>
<c:url value="/mobileuser/userProfileMobile.do" var ="userprofileURL"/>
<h1></h1>

        <div data-role="popup" id="popupMenu" data-theme="a">
				<ul data-role="listview" data-inset="true" style="min-width:210px;" data-theme="b">
					<li data-role="divider" data-theme="a">Choose</li> 
					<li><a href="#popupCP" data-rel="popup">Change Password</a></li>
					<li><a onClick='location.href="<c:out value='${userprofileURL}'/>"' href="#" data-rel="popup" data-position-to="window" >User Profile</a></li>
					
				</ul>
		</div>


<div data-role="popup" id="popupCP" data-theme="b" class="ui-corner-all">
			<form>
				<div style="padding:10px 20px;">
				  <h3>Change Password</h3>
		          <label for="un" class="ui-hidden-accessible">Old Password:</label>
		          <input type="password"  id="oldPassword" value="" data-theme="b"/>

		          <label for="pw" class="ui-hidden-accessible">New Password:</label>
		          <input type="password"  id="newPassword" value=""  data-theme="b"/>
		          
		          <label for="pw" class="ui-hidden-accessible">Confirm Password:</label>
		          <input type="password"  id="confirmPassword" value=""  data-theme="b"/>

		    	  <button type="submit" data-theme="c" id="savePassword">Submit</button>
		    	  <button type="reset" data-theme="c" onclick="CancelPasswordForm(this)">Reset</button>
				</div>
			</form>
		</div>

	   	<div data-role="controlgroup" data-type="horizontal" class="ui-btn-right">
          <a href="#popupMenu" data-role="button" data-icon="gear" data-rel="popup"  data-rel="dialog">Settings</a>
         
         <a href="<c:url value='/mobile_login.jsp'/>" data-role="button" >Logout</a>
         
        </div> 
        
        	<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
        	 <%--  <img src="<c:url value='/NEW_UI/images/config-users.png'/>" />&nbsp;<b style="font-style:italic;">Welcome,</b><security:authentication property="principal.username" /> --%>
        	  &nbsp; &nbsp;<a href="#" data-icon="home" data-role='button' data-theme='a'
               onClick='location.href="<c:out value='${homeurl}'/>"'>Home</a>
               <i class="ui-btn-left" style="background-position: 4px 4px;"></i>&nbsp;${username}</a>
        	</div>
  

