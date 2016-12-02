<%@ include file="/WEB-INF/tiles2/layout/PM-INCLUDES.jsp" %>
<!DOCTYPE html> 
<html> 
    <head> 
    <title>Chiguru InfoSystems</title> 
   <link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>
 
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
</head> 
<body onLoad="document.mobileloginform.username.focus()">


<!-- start header -->
	<div data-role="header" data-nobackbtn="true">
		<h4>Practice Management</h4>
	</div>	<!-- end header -->
	
	 <div data-role="content" style="background: url(images/bg-login.jpg)">
	 <div id="message_container">
                    <c:if test="${ param.error eq 'login_error'}">
                    <font color="red">
                     Your login attempt was not successful, try again.<br/>
                     Reason: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.<br/>
                     </font>
                     </c:if>
                     <c:if test="${ param.user eq 'genuine'}">
                     <font color="white">
                       Please Enter Your username and new password to login.Thank You !<br/>
                      </font>
                     </c:if>
                      <c:if test="${ param.user eq 'hacker'}">
                      <font color="red">
                        Sorry ! You dont have an account. <br/>
                       </font>
                       </c:if>
                     </div>
	  
	  <form name="mobileloginform" id="mobileloginform" action="<c:url value='j_spring_security_check' />" method='POST' data-ajax="false">
		

            <div data-role="fieldcontain" style="width: 50%;">
             <label for="username" style="color:white">Username:</label>
             <input type='text' id="username" class="validate[required,length[6,11]] text-input"
                                   name='j_username' tabindex="1" 
                                   value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'/>
             <!-- <input type="text" name="j_username" id="username" value='' /> -->
            </div>    

            <div data-role="fieldcontain" style="width: 50%;">
             <label for="password" style="color:white">Password:</label>
             <input type='password' tabindex="2" class="validate[required,length[6,11]] text-input" id="password"
                                    name='j_password'>
             <!-- <input type="password" name="j_password" id="password" /> -->
            </div>    

   <input data-inline="true" value="Login" data-mini="true" type="submit">
         <!--    <input type="submit" name="login" value="Login" data-inline="true" /> -->
        
           
        </form>
            
  </div>
<script>
                function submitFormWithUserId(userId, password) {
               	
                		var form = document.forms["mobileloginform"];
                        form.username.value = userId;
                        form.password.value = password;
                        form.submit();
                	
                }

            </script>
   <div data-role="footer">
        <h4>Transforce Software Servcices Pvt Ltd.</h4>
    </div>
	
	</body>
	</html>
	 

	 
	