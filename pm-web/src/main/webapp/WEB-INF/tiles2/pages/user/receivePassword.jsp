<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<style type="text/css">
    .user fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        border: 2px solid red;
        margin: 5px;
        padding: 5px;
    }

    div.error_container ol li {
        list-style-type: disc;
        margin-left: 20px;
    }

    div.error_container {
        display: none
    }

    .error_container label.error {
        display: inline;
    }

    form.user {
        width: 30em;
    }

    form.userlabel.error {
        display: block;
        margin-left: 1em;
        width: auto;
    }

    input:focus {
        border: 1px dotted black;
    }

    select:focus {
        border: 1px dotted black;
    }

    input.error {
        border: 2px solid red;
    }

    select.error {
        border: 2px solid red;
    }

    label.error {
        /* remove the next line when you have trouble in IE6 with labels in list */
        color: red;
        font-style: italic
    }
</style>
<style>
    .error {
        color: red;
    }

    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 2px solid red;
        margin: 5px;
        padding: 5px;
        width: auto;
    }
</style>
<script language="javascript">
function passwordChanged() {
var strength = document.getElementById('strength');
var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
var enoughRegex = new RegExp("(?=.{6,}).*", "g");
var pwd = document.getElementById("newPassword");
if (pwd.value.length==0) {
strength.innerHTML = 'Type Password';
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
<script type="text/javascript">
    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
    	 $("#save").click(function() {
        var container = $('div.error_container');
        var validator = $("#user")
		.validate(
				{

					rules : {
						'newPassword' : {
							required : true,
							minlength : 8,
							maxlength : 20
						},
						'resetPassword' : {
							required : true,
							minlength : 8,
							maxlength : 20
						}
					},
					messages : {
						'newPassword' : {
							required : "password is required",
							minlength : "Enter password with at least {0} characters.",
							maxlength : "Enter password with no more than {0} characters."
						},
						'resetPassword' : {
							required : "resetPassword is required",
							minlength : "Enter resetPassword with at least {0} characters.",
							maxlength : "Enter resetPassword with no more than {0} characters."
						}
					},
					errorContainer : container,
					errorLabelContainer : $("ol",
							container),
					wrapper : 'li',
					meta : "validate"
				});
        var passwordVal = $("#newPassword").val();
        var checkVal = $("#resetPassword").val();
        if(passwordVal == checkVal)
        	{$("#user").submit();}
        else{$.jGrowl('Please enter the same password again.'); }
         });

        $("#reset").click(function() {
        	  $('#user')[0].reset();
        });
    });
</script>

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
 });
 </script>
 
 <div class="fieldset">
<span class="legend b">&nbsp;&nbsp; User Information &nbsp;&nbsp;</span>
    <div class="f13">
			<form:form name="user" modelAttribute="user" method="POST"
				action="receivePassword.do">
			<input type="hidden" name="baseURL" id="baseURL"
					value="receivePassword.do" />
					<input type="hidden" name="userName" id="userName"
       value="${param.userName}"/>
       <input type="hidden" name="userResetPasswordKey" id="userResetPasswordKey"
       value="${param.userResetPasswordKey}"/>
       
       <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px">Reset Password</h4></div>
            
            <div class="container_12 mt20">
              <br/>      
            <div class="grid_3 right"><form:label path="newPassword">Enter Your Password</form:label></div>
            <div class="grid_3 right"><form:input cssClass="input_full" path="newPassword" type="password" class="input"
                        tabindex="1" size="8" maxlength="20" onkeyup="return passwordChanged();"/></div><span id="strength">Type Password</span>
             <div class="s1"></div>
                    
             <div class="grid_3 right">  </div>
            <div class="grid_4 right">   </div>
            
            </div>
            
            <div class="container_12 mt20">
              <br/>      
            <div class="grid_3 right"> <form:label path="resetPassword">Confirm Password</form:label>  </div>
            <div class="grid_3 right">  <form:input cssClass="input_full" type="password" path="resetPassword" class="input"
                        tabindex="2"/>   </div>
             <div class="s1"></div>
                    
             <div class="grid_3 right">  </div>
            <div class="grid_4 right">   </div>
            
            </div>
            	
         </form:form>
             </div>
            
             
		  <div class="container_12" style="margin:10px;"></div>
                    <div class="container_12">
                    <div class="grid_3">&nbsp;</div>
                     <div class="grid_8">
                     
                    <button type="button" id="save"
                           class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                           role="button" aria-disabled="false">
                          <span class="ui-button-text">Save</span>
                    </button>
                    &nbsp;&nbsp;
                    
                    <button type="reset" id="reset"
                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                            	role="button" aria-disabled="false">
                        	<span class="ui-button-text">Cancel</span>
                    </button>
                	
                    </div>
                    <div class="container_12" style="margin:10px;"></div>
                    </div>
       
	</div>	