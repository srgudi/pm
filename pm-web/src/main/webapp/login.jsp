<%@ include file="/WEB-INF/tiles2/layout/PM-INCLUDES.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Transforce Software Services</title>
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
    <link href="css/formvalidation.css" rel="stylesheet" type="text/css"/>
    <link href="css/facebox.css" rel="stylesheet" type="text/css"/>
    <!--[if IE 6]>
    <style type="text/css">
        label.remember {
            width: 200px;
            margin-left: 40px;
        }

        label.txt-field {
            margin-right: 5px
        }
    </style>
    <![endif]-->
   
    
    
     <script type="text/javascript"
            src= 'NEW_UI/jquery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src="NEW_UI/validate/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="NEW_UI/validate/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="NEW_UI/js/jquery.facebox.js"></script>
     
    <script type="text/javascript">
        $(document).ready(function() {
        	
            /*form validation */
            $("#login").validationEngine()

            $("#forgotPopup").click(function() {

                jQuery.facebox({ div: '#forgotPassword-modal' })

                /*click handler for closing modalwindow*/
                $(".closeIcon").click(function() {
                    $.facebox.close()
                });
                $("#forgotSubmit").click(function() {
                    if ($("#emailID").val() == '') {
                        $("#emailID").focus();
                        $("#forgotPassword").validationEngine()
                    }else {
						$.post("<c:url value='/user/forgotPassword.do'/>", { userName: $("#emailID").val(), response: $("#j_captcha_response").val() }, function(data) {
							 procesMessageFromServer(data);
                    });
                    } //end of else
                    
                });
        });
            
        });
        
        function procesMessageFromServer(data)
        {
        	var successFlag = data.successFlag;
        	if( successFlag == true)
        		{
        		$("#message_container").html("<font color='white'><b>Forgot Password:</b> Please check your email for instructions</font><br><br>");
                $.facebox.close(); 
        		}
        	else{
        		$("#emailID").focus();
        		$("#emailID").validationEngine('showPrompt', 'This Email ID does not exist.', 'error', true);
        	}
        }
        
        function processRememberMeFromServer(data)
        {
        	var successFlag = data.successFlag;
        	if( successFlag == true)
        		{
        		$("#message_container").html("<font color='white'><b>Forgot Password:</b> Successful login</font><br><br>");
 
        		}
        	else{
        		$("#j_username").focus();
        		$("#j_username").validationEngine('showPrompt', 'You are not an authenticated user.', 'error', true);
        	}
        }
    </script>
       
</head>

<body onLoad="document.loginForm.username.focus()">
<div id="distance"></div>
<div id="container">
    <div class="hidden">
       
        <div id="forgotPassword-modal">
            <div id="modalCtr">
                <div class="modalHeader">
                    <div class="header left">Forgot Password</div>
                    <a title="close window" class="closeIcon" href="">close window</a>
                    <span class="clearFix">&nbsp;</span>
                </div>
                <div class="mbody">
                   <form id="forgotPassword" name="forgotpassword-form" method="post" >                    
                        <label>Enter your email id</label><br/>
                        <input type="text" name="emailID" id="emailID" value="" class="validate[required,custom[email]]"/>
                        <br/>&nbsp;
                         <label>Please enter the word given below</label>&nbsp;
                         <table cellpadding=2 cellspacing=2 bgcolor="#6699cc" width ="10px" height="10px">
                         <tr>
                        &nbsp;&nbsp;&nbsp;&nbsp;<td style="padding: 2px;" width="2"><img src="captcha.do" id="captcha" width ="150" height="50"></td>
                        <td>
                        <br/></td>
                        </tr></table><br/>
                        <input type="text" name="j_captcha_response" id="j_captcha_response" value=""size="25" /><br/>
                          <div class="inner-nav">
                            <div class="align-right"><a href="javascript:;" id="forgotSubmit"><span>Submit</span></a>
                            </div>
                            <span class="clearFix">&nbsp;</span>
                          </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- end of hidden -->
    <div id="top" style="margin-top:-125px;"><h1>
    <!-- <a href="#"><img src="images/LOGO1.jpg" alt="Login" border="0"/></a> -->	</h1></div>
    <br/><br/>
    <div id="form-container">
    <div id="message_container">
     <c:if test="${ param.error eq 'login_error'}">
            <font color="red">
                Your login attempt was not successful, try again.<br/>
                Reason: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.<br/>
            </font>
        </c:if>
     </div>  
        <form id="loginForm" name="loginForm" action="<c:url value='j_spring_security_check'/>" method="POST">
     </div>  
       
            <fieldset>
                <legend>Login</legend>
                <ol>
                <li>&nbsp;</li><br></br>
                <li><label class="field-title">User name:</label>
                        <label class="txt-field">

                            <input type='text' id="username" class="validate[required,length[6,11]] text-input"
                                   name='j_username' tabindex="1" 
                                   value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'/>

                        </label>
                        </li>
					<br></br>
                    <li><label class="field-title">Password:</label><label class="txt-field">
                        <input type='password' tabindex="2" class="validate[required,length[6,11]] text-input" id="password"
                               name='j_password'>
                    </label>
                    </li>
                    <br></br>
                  
                    <c:if test="${ param.error eq 'login_error'}">
                      <input  type="hidden" name="validatCaptcha" value="yes"/><br/><br/><br/>&nbsp;&nbsp;
                    <center>
                    <table cellpadding=2 cellspacing=2 bgcolor="#6699cc" width ="10px" height="10px">
                    <tr bgcolor="#336699">
                    <td colspan="2"><font color="#FFFFFF" face="Verdana" size="2"><b>Word Verification</b></font></td>
                    </tr>
                    <tr>
                    <td style="padding: 1px;" width="1"><img src="captcha.do" id="captcha" width ="150" height="50"></td>
                     <td valign="right"><font color="#FFFFFF"><b>Please enter the text from the image</b></font> 
                     <br><input type="text" name="j_captcha_response" size="20" />
                     </br></td></tr></table></center>
                    </li>
                    </c:if>
                    
                    <li><div class="align-right"><input type="image" name="submit" src="images/bt-login.gif"/></div></li>
					<li><label class="field-title"><a href="javascript:;" class="forgot" id="forgotPopup">Forgot Password</a></label></li>                        
                </ol>
            </fieldset>

            <script>
                function submitFormWithUserId(userId, password) {
               	
                		var form = document.forms["loginForm"];
                        form.username.value = userId;
                        form.password.value = password;
                        form.submit();
                	
                }

            </script>
           <!--  <script>
            $captcha_text_color="#0099ff";
            </script> -->
            
            <center>
				<span style="color:#ffffff">
				
				<br/>
				<br/>
				<B> Test Logins</B>
				<br/>
				<a href="#" onclick="submitFormWithUserId('sa@tss.com','password');" style="color:#ffffff">Super Admin :
                    TTS - India Pvt Lmt </a>
				<br/>
				<a href="#" onclick="submitFormWithUserId('anand_patil@tsssoft.com','password');" style="color:#ffffff">Firm Admin:
                    Ramesh and Co. </a>
				<br/>
				<a href="#" onclick="submitFormWithUserId('patil.anand677@gmail.com','password');" style="color:#ffffff">Firm Partner
                    : Ramesh and Co. </a>
				
				<br/>
				<a href="#" onclick="submitFormWithUserId('patilanand143@gmail.com','password');" style="color:#ffffff">Firm Staff :
                    Ramesh and Co. </a>
				
				<br/>
				<!-- 
				<a href="#" onclick="submitFormWithUserId('anandp_c@yahoo.com','password');"
                   style="color:#ffffff">Client Staff : Butchaiah </a>
				
				<br/>
				
				<a href="#" onclick="submitFormWithUserId('sagar_bannikal_098@yahoo.com','password');"
                   style="color:#ffffff">Sagar : Bannikal Brothers </a>
				
				<br/>
				<a href="#" onclick="submitFormWithUserId('savitrisp@gmail.com','password');" style="color:#ffffff">Savitri
                    : Savitri Tax Consultants </a>
				-->
				</span>
                <br/>
                <br/>
                <br/>
                <br/>
                <br/>
                <div style="margin-top:-35px;">
                <!--<a href="#" onclick="submitFormWithUserId('admin@firm.com','password');" style="color:#ffffff">Click here
                    to login as admin</a>
                <br/>
                <a href="#" onclick="submitFormWithUserId('guest','password');" style="color:#ffffff">Click here to login
                    as guest</a>
                    -->
                    </div>
            </center>
            <span class="clearFix">&nbsp;</span>
        </form>
    </div>
</div>
<div align="right" style="margin-top:10px;"><img src="images/login_lock.gif" border="0" alt=""/></div>
</body>
</html>