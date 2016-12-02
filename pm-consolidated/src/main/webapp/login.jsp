<%@ include file="/WEB-INF/tiles2/layout/PM-INCLUDES.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Practice Management - Login</title>
        <link rel="shortcut icon" href="/_images/favicon1.ico" />
        <link href="resources/css/facebox.css" rel="stylesheet" type="text/css"/>
        <meta name="author" content="Survs" />
		<meta name="keywords" content="Survs, surveys, online surveys, collaborative, share" />
		<meta name="description" content="Survs is a collaborative tool that enables you to create online surveys with simplicity and elegance." />
		<meta name="robots" content="noodp,noydir" />
 		<link href="resources/css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="resources/css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src= 'resources/jquery/jquery-1.8.3.min.js'></script>
		<script type="text/javascript" src="resources/js/jquery.facebox.js"></script>
        <script type="text/javascript" src="resources/js/jquery.validationEngine.js"></script>
        <script type="text/javascript" src="resources/js/jquery.validationEngine-en.js"></script>
	   	<script>
        	function submitFormWithUserId(userId, password) {
            	var form = document.forms["loginForm"];
                form.username.value = userId;
                form.password.value = password;
                form.submit();
            }
        	
        	function forgotPassword(){
        	    jQuery.facebox({ div: '#forgotPassword-modal' })
                
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
                    } 
                    
                });
        	}
        	
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
            		$("#emailID").validationEngine('showPrompt', 'This Email ID does not exist or text entered is incorrect.', 'error', true);
            	}
            }
        </script> 			 
		<style type="text/css">
					
			body {
			padding: 0;
			margin: 0;
			background: center url('images/dark_blue.png') no-repeat;
			background-size: 1400px 1000px;
			text-align: center;
			font-family: Helvetica, Arial, sans-serif;
			margin-bottom: 2em;
			}
		
			/* ***************************
			       Content
			**************************** */
			
			div#content {
			padding: 30px 50px 10px 50px;
			color: #FFFFFF;
			font-size: 76%;
			line-height: 1.6em;
			height: 1%;
			background: #4770B0;
			box-shadow: 0 0 40px #FFFFFF;
			border-radius: 10px 10px 10px 10px;
    		border: 1px solid;
			}
			
			div#infomation {
			padding: 20px 20px 133px 20px;
			color: #FFFFFF;
			font-size: 76%;
			line-height: 1.6em;
			height: 1%;
			background: #4770B0;
			box-shadow: 0 0 40px #FFFFFF;
			border-radius: 10px 10px 10px 10px;
    		border: 1px solid;
			}
			
			div#education {
			padding: 20px 20px 300px 20px;
			color: #FFFFFF;
			font-size: 76%;
			line-height: 1.6em;
			height: 1%;
			background: #4770B0;
			box-shadow: 0 0 40px #FFFFFF;
			border-radius: 10px 10px 10px 10px;
    		border: 1px solid;
			}
			
			/* ***************************
			       Footer
			**************************** */
			div#footer {
			color: #FFFFFF;
			text-align: center;
			font-size: 12px;
			margin: 80px 0 30px 0;
			}

			div#footer a {
			color: #FFFFFF;
			border-bottom: 1px solid #cca;
			padding: 0;
			}

			/* ***************************
			       Login
			**************************** */
			
			body.login div#wrapper { 
			width: 1200px;
			height: 500px; 
			}
			
			body.small div#wrapper {
			text-align: left;
			margin: 0 auto;
			}
			body.small div#header {
			margin-bottom: 30px;
			padding: 0 0 0 0;
			}
			
			body.small div#space {
			margin-bottom: 15px;
			padding: 0 0 0 0;
			}
			
			ul#products a {
			    color: #FFFFFF;
			    text-decoration: none;
			    font-size: 11px;
			}
			forSave{
			  width: 10px;
			}
		</style>
	</head>
    <body class="small login">
    	<div id="wrapper">
			<div id="header"></div>
			<div class="row-fluid">
				<div class="span6">
					<div id="infomation">
							<h5>I don't have Practice Management account</h5>
							<input class="btn  btn-small btn-success" type="submit" value="Create an Account" />
							
		    				<h5>I want to sign in to my Practice Management online product :</h5>	
		    				<ul id="products">
		    					<li><a href="#">All Your Clients in One Place</a></li>
		    					<li><a href="#">All Your Work in One Place</a></li>
		    					<li><a href="#">Simplified Time & Billing</a></li>
		    					<li><a href="#">Powerful Reporting</a></li>
		    					<li><a href="#">Send Notification Mail</a></li>
		    				</ul>					
					</div>
				</div>
				<div class="span6">
					<div id="content">
						<form id="loginForm" class="form-signin" name="loginForm" action="<c:url value='j_spring_security_check'/>" method="POST">
						<center>
								<table class="login" style="margin-left: auto; margin-right: auto; margin-top: auto;">
								            <br/>
							                <br/>
							                <br/>
									<tr>
										<td><h3><img src="<c:url value='/images/pmNew7.png'/>"></h3></td>
									</tr>
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
									<tr>
										<td>
											<input type='text' id="username" placeholder = "Email Address"
							        				class="validate[required,length[6,11]] text-input"
							                		name='j_username' tabindex="1"   
							                		value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'/>
										</td>
									</tr>
									<tr>
										<td>
											<input type='password' tabindex="2" placeholder="Password" 
													class="validate[required,length[6,11]] text-input" id="password" name='j_password'>
										</td>
									</tr>
		
									<tr>
										<td>
											<input class="btn  btn-large btn-success" type="submit" value="Sign In" />
												&nbsp;&nbsp;
											<a href="#" style="color:white;font-size:24" onclick="forgotPassword();" >
			                    						Forgot Password ?</a><br/>
										</td>
									</tr>
									<tr>
										<td>
											
											<br/>
							                <br/>
							                <br/>
											<br/>
							                
											
										</td>
									</tr>
								</table>
								</center>
																    <div class="hidden">
       
        <div id="forgotPassword-modal">
            <div id="modalCtr">
                <div class="modalHeader">
                    <div class="header left">Forgot Password</div>
                    <a title="close window" class="closeIcon" href=""></a>
                    <span class="clearFix">&nbsp;</span>
                </div>
                <div class="mbody">
                   <form id="forgotPassword" name="forgotpassword-form" method="post" >                    
                        <label>Enter your email id</label>
                        <input type="text" name="emailID" id="emailID" value="" class="validate[required,custom[email]]"/>
                        
                         <label>Please enter the word given below</label>&nbsp;
                         <table cellpadding=2 cellspacing=2 bgcolor="#0066B3" width ="10px" height="10px" border="2px" border-style="solid;" border-color="#0066B3;">
                         <tr>
                        <td style="padding: 2px;" width="2"><img src="captcha.do" id="captcha" width ="150" height="50"></td>
                        <td>
                        </td>
                        </tr></table><br/>
                        <input type="text" name="j_captcha_response" id="j_captcha_response" value=""size="25" /><br/>
                         
                          <br/>
                           <div class="forSave">
                          <input class="btn btn-primary" value="save" id="forgotSubmit"/>
                          </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
							</form>		  					
					</div>
				</div>
			</div>
			<div id="space"></div>
			<div class="row-fluid">
					<div id="education">
							<div class="span3">
							<h5>Professional Accounting Software</h5>	
		    				<ul id="products">
		    					<li><a href="#">QuickBooks Products for Accountants</a></li>
		    					<li><a href="#">QuickBooks ProAdvisor Program</a></li>
		    					<li><a href="#">QuickBooks Premier Accountant Edition</a></li>
		    					<li><a href="#">Financial Statement Software</a></li>
		    				</ul>
		    				
							<h5>Payroll Solutions</h5>	
		    				<ul id="products">
		    					<li><a href="#">After-the-Fact Payroll Service</a></li>
		    					<li><a href="#">Payroll Direct Deposit</a></li>
		    					<li><a href="#">Online Payroll Solution</a></li>
		    					<li><a href="#">Payroll Outsourcing</a></li>
		    					<li><a href="#">File Payroll Taxes</a></li>
		    				</ul>
		    				
							</div>
							<div class="span3">
							<h5>ProSeries Tax Solutions</h5>	
		    				<ul id="products">
		    					<li><a href="#">Professional Tax Software</a></li>
		    					<li><a href="#">Professional Tax Resources</a></li>
		    					<li><a href="#">Tax Document Management</a></li>
		    					<li><a href="#">E-File Resources</a></li>
		    					<li><a href="#">More Tax Practice Management Tools</a></li>
		    				</ul>
							<h5>Lacerte Tax Solutions </h5>	
		    				<ul id="products">
		    					<li><a href="#">Professional Tax Preparation Software</a></li>
		    					<li><a href="#">Professional Tax Software Resources</a></li>
		    					<li><a href="#">Tax Document Management</a></li>
		    					<li><a href="#">Tax Analysis Software</a></li>
		    					<li><a href="#">More Tax Practice Management Tools</a></li>
		    				</ul>
							</div>
							<div class="span3">
							<h5>More Products & Solutions</h5>	
		    				<ul id="products">
		    					<li><a href="#">Marketplace</a></li>
		    					<li><a href="#">Product Discounts</a></li>
		    					<li><a href="#">Accept Credit Cards, Checks & More</a></li>
		    					<li><a href="#">Product Resources for Educators</a></li>
		    					<li><a href="#">Tax Professionals Wiki</a></li>
		    					<li><a href="#">More Tax & Accounting Services</a></li>
		    				</ul>
							<h5>Additional Resources</h5>	
		    				<ul id="products">
		    					<li><a href="#">Support</a></li>
		    				</ul>
							</div>
							<div class="span3">
							<h5>Training Resources</h5>	
		    				<ul id="products">
		    					<li><a href="#">QuickBooks Certification</a></li>
		    					<li><a href="#"> Tax & Accounting Software Training </a></li>
		    					<li><a href="#">ProSeries Professional Tax Software Training</a></li>
		    				</ul>
							<h5>Featured Products and Solutions</h5>	
		    				<ul id="products">
		    					<li><a href="#">Document Organizer</a></li>
		    					<li><a href="#">Professional Online Tax Software</a></li>
		    					<li><a href="#">Professional Tax Research</a></li>
		    					<li><a href="#">Accounting Employment</a></li>
		    				</ul>		    				
		    				
		    				
							</div>
						
					</div>
				
			</div>
			<div class="row-fluid">
				<div class="span4"></div>
				<div class="span4">
					<div id="footer">
						<p>
							<a href="#">Home</a> <span>|</span>
							<a href="/privacy/">Privacy Policy</a> <span>|</span>
							<a href="/tos/">Terms of Service</a>
						</p>
					</div>
				</div>
				<div class="span4"></div>
			</div>			
    </body>
</html>
