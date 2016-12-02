<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PM - RESET_PASSWORD</title>
<link href="<c:url value="/resources/css/bootstrap-responsive.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<script language="javascript">
function passwordChanged() {
var strength = document.getElementById('strength');
var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
var enoughRegex = new RegExp("(?=.{6,}).*", "g");
var pwd = document.getElementById("newuser.newPassword");
if (pwd.value.length==0) {
strength.innerHTML = 'Type Your Password Above !';
} else if (false == enoughRegex.test(pwd.value)) {
strength.innerHTML = 'More Characters';
} else if (strongRegex.test(pwd.value)) {
strength.innerHTML = '<span style="color:green">Strong!</span>';
} else if (mediumRegex.test(pwd.value)) {
strength.innerHTML = '<span style="color:orange">Medium!</span>';
} else {
strength.innerHTML = '<span style="color:red">Weak!</span>';
}
}
</script>
<style type="text/css">
.navbar-inverse{color:#ffffff;}.navbar-inverse .navbar-inner{background-color:#0066B3;background-image:-moz-linear-gradient(top, #BFE3FE, #00477D);background-image:-webkit-gradient(linear, 0 0, 0 100%, from(#BFE3FE), to(#00477D));background-image:-webkit-linear-gradient(top, #BFE3FE, #00477D);background-image:-o-linear-gradient(top, #BFE3FE, #00477D);background-image:linear-gradient(to bottom, #BFE3FE, #00477D);background-repeat:repeat-x;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#BFE3FE', endColorstr='#00477D', GradientType=0);border-color:#0066B3;}
.navbar-inverse .brand {
    color: #ffffff;
}
.hero-unit {margin-left: 150px;width:300px;}
</style>
 </head>
 <body>
 
 <div class="navbar navbar-inverse navbar-fixed-top" style="color : #00477D">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">PRACTICE MANAGEMENT</a>
        </div>
      </div>
    </div>
	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>
	<div class="span3"> 
	&nbsp;&nbsp;
	</div>
	
	 <div class="span9">
	 <br/><br/><br/><br/><br/> 
 <form modelAttribute="newuser" action="receivePassword.do" method="POST" class="hero-unit">
      
	<h3>Password Reset</h3>
 
          <fieldset>
          <div class="clearfix">
          <label for="newPassword"><span>Enter Your Password:</span></label>
          <div class="input-xlarge">
           <input type='password' tabindex="2" id="newuser.newPassword" name='newpassword' onkeyup="return passwordChanged();">
          </div>
           <span id="strength" style="font-size:12px;">Type Your Password Above !</span>
          </div>
          <div class="clearfix">
          <label for="resetPassword"><span>Confirm Password:</span></label>
          <div class="input-xlarge">
           <input type='password' tabindex="2" id="newuser.resetPassword" name='resetPassword'>
          </div>
         </div>
         
            <div class="actions">
				<input tabindex="3" class="btn btn-large btn-success" type="submit"
					value="Save">
            </div>
          </div>

</fieldset>
</form>
</div>
<div id="footer">
      <div class="container">
        <p class="muted credit">&copy; TSS INDIA PVT LTD 2010</p>
      </div>
</div>
<div class="span3"> 
	&nbsp;&nbsp;
</div>
	 

</body>
 
  
</html>