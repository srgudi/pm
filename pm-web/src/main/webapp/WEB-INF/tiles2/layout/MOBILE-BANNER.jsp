<%@ include file="PM-INCLUDES.jsp" %>
<c:url value="/mobile/home.do" var="homeurl"/>  
<!--  /mobileuser/mobileChangePassword.do -->
<c:url value="/mobileuser/mobileChangePassword.do" var ="passwordURL"/>
<c:url value="/mobileuser/userProfileMobile.do" var ="userprofileURL"/>
<h1></h1>

        <div data-role="popup" id="popupMenu" data-theme="a">
				<ul data-role="listview" data-inset="true" style="min-width:210px;" data-theme="b">
					<li data-role="divider" data-theme="a">Choose</li> 
					<li><a onClick='location.href="<c:out value='${userprofileURL}'/>"' href="#" data-rel="popup" data-position-to="window">Profile</a></li>
					<li><a onClick='location.href="<c:out value='${passwordURL}'/>"' href="#" data-rel="popup" data-position-to="window" >Change Password</a></li>
					
				</ul>
		</div>
		
		<%-- <div data-role="popup" id="popupLogin" data-theme="a" class="ui-corner-all">
			<form>
				<div style="padding:10px 20px;">
				  <h3>Please sign in</h3>
		          <label for="un" class="ui-hidden-accessible">Username:</label>
		          <input type="text" name="user" id="un" value="" placeholder="username" data-theme="a" />

		          <label for="pw" class="ui-hidden-accessible">Password:</label>
		          <input type="password" name="pass" id="pw" value="" placeholder="password" data-theme="a" />

		    	  <button type="submit" data-theme="b">Sign in</button>
				</div>
			</form>
		</div>
		
		<div data-role="popup" id="popupPassowrd" data-theme="a" class="ui-corner-all">
			<form:form name="user" modelAttribute="user" method="POST"
				action="changePassword.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="changePassword.do" />
				<div style="padding:10px 20px;">
				  <h3>Change Your Password</h3>
		          <label for="un" class="ui-hidden-accessible">Enter Old Password:</label>
		          <input type="text" name="user" id="un" value="" placeholder="Enter Old Password" data-theme="a" />

		          <label for="pw" class="ui-hidden-accessible">Enter New Password</label>
		          <input type="password" name="pass" id="pw" value="" placeholder="Enter New Password" data-theme="a" />
		          
                   <label for="pw" class="ui-hidden-accessible">Confirm Password:</label>
		          <input type="password" name="pass" id="pw" value="" placeholder="Confirm Password" data-theme="a" />
		          
		    	  <button type="submit" id="save" data-theme="b">Save</button>
				</div>
			</form:form>
		</div> --%>
		
	   	<div data-role="controlgroup" data-role="popup" data-type="horizontal" class="ui-btn-right">
         <a href="#popupMenu" data-role="button" data-icon="gear" data-rel="popup"  data-rel="dialog">Settings</a>
          
         
         <a href="<c:url value='/mobile_login.jsp'/>" data-role="button" >Logout</a>
         
        </div> 
        
        	<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
        	 <%--  <img src="<c:url value='/NEW_UI/images/config-users.png'/>" />&nbsp;<b style="font-style:italic;">Welcome,</b><security:authentication property="principal.username" /> --%>
        	  &nbsp; &nbsp;<a href="#" data-icon="home" data-role='button' data-theme='a'
               onClick='location.href="<c:out value='${homeurl}'/>"'>Home</a>
        	</div>
 
    
    
    	 

