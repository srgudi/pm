<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

<style type="text/css">
  /*this is what we want the div to look like
    when it is not showing*/
  div.loading-invisible{ 
    /*make invisible*/
     display:none;
  } 

  /*this is what we want the div to look like
    when it IS showing*/
   div.loading-visible{ 
    /*make visible*/
    display:block;  
	position:fixed;
    /*position it 200px down the screen*/
     top:50%;
    left:0%;
    width:500px;
    text-align:center; 
 	z-index:1104;
    width:100%;
    height:100%;
    /*in supporting browsers, make it
      a little transparent*/
    filter: alpha(opacity=75);  /* internet explorer */
     -khtml-opacity: 0.75;      /* khtml, old safari */
     -moz-opacity: 0.75;        /* mozilla, netscape */
     opacity: 0.75;            /* fx, safari, opera */
    border-top:1px solid #ddd;
     }
/*   #loading-visible {
    position:fixed;
    top:50%;
    left:50%;
    z-index:1104;
    width:100%;
    height:100%;

    } */

</style>

<%-- <div id="loading" class="loading-invisible">
  <p><img src="<c:url value='/NEW_UI/images/326.gif'/>" alt= "Loading..." /></p>
</div>
    
<script type="text/javascript">

document.getElementById("loading").className = "loading-visible";
var hideDiv = function(){document.getElementById("loading").className = "loading-invisible";};
var oldLoad = window.onload;
var newLoad = oldLoad ? function(){hideDiv.call(this);oldLoad.call(this);} : hideDiv;
window.onload = newLoad;
$(function(){
$('#loading').fadeOut();
});
</script>   --%>
<script type="text/javascript">
 $(document).ready(function () {	
  						  
						  $.ajaxSetup({
						        headers: {"X-Requested-With":"XMLHttpRequest"}
						  });
							
							$('#HeadMenuBar li').hover(
								function () {
									//show its submenu
									$('ul', this).slideDown(100);

								}, 
								function () {
									//hide its submenu
									$('ul', this).slideUp(100);			
								}
							);	
							
							// initialise plugins
								jQuery(function(){
									jQuery('ui-tabs').jquery-ui-1.8.5.custom({ 
						            delay:       500,                            // one second delay on mouseout 
						            animation:   {opacity:'show',height:'show'},  // fade-in and slide-down animation 
						            speed:       'fast',                          // faster animation speed 
						            dropShadows: false                            // disable drop shadows 
						        });
								});
						}); 
</script> 

<div id="hd" style="background: #33A1DE; height: 50px; color: white;">
<c:url value="/home/home.do" var="homeURL" />
	<table style="margin:0px;width:100%" border="0">
	<tr>
	
	<td valign="top">	
	<a href="<c:url value='/client/clientList.do'/>"><img src="<c:url value='/NEW_UI/images/pmNew7.png'/>"></a>
	</td> 

	<td align="top" width="500px;">
	
		<table style="width:500px;margin-top:-20px; padding:0px;">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>				
				<div style="font-size:100%;" align="right">				
						<img src="<c:url value='/NEW_UI/images/config-users.png'/>" />&nbsp;<b>Welcome,</b>
						<security:authentication property="principal.username" />&nbsp; &nbsp;<a href="<c:url value='/client/clientList.do'/>"><font color="#FFFFFF"><b>Home</b></font></a>
						 &nbsp;&nbsp;<a href="<c:url value='/user/userProfile.do'/>"><font color="#FFFFFF"><b>Settings</b></font></a>&nbsp; &nbsp;<a href="<c:url value='/user/changePassword.do'/>"><font color="#FFFFFF"><b>Change Password</b></font></a>
						 &nbsp;&nbsp;<c:url value="/j_spring_security_logout" var="logoutUrl" /><a href="<c:url value='/j_spring_security_logout'/>"><font color="#FFFFFF"><b>Logout</b></font></a>
						 
					 </div>
				</div>				
				</td>
			</tr>				
		</table>
	</td>
	</tr>
	</table>


<script>
$(document).ready(function () {	
    $.ajaxSetup({
         headers: {"X-Requested-With":"XMLHttpRequest"}
    });
});
	function submitForm(){
		var form = $('themeSelectorForm');
		form.submit();
  	}
	
</script>


