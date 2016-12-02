<%@ include file="../../layout/PM-INCLUDES.jsp" %>

<style type="text/css">
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


</style>

<script type="text/javascript">
$(document).ready(function(){
$('#save').click(function(){
	var container = $('div.error_container');
    var validator = $("#user")
	//alert('save new password');
    .validate(
			{

				rules : {
					'oldPassword' : {
						required : true,
						minlength : 8,
						maxlength : 20
					},
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
					'oldPassword' : {
						required : "Old password is required For you to change your password.",
						minlength : "Enter password with at least {0} characters.",
						maxlength : "Enter password with no more than {0} characters."
					},
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
    	{
    	$("#user").submit();
    	}
    else{$.jGrowl('Please enter the same password again.'); }
    //else alert("Enter same password again");
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
<script language="javascript">
function passwordChanged() {
var strength = document.getElementById('strength');
var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
var enoughRegex = new RegExp("(?=.{6,}).*", "g");
var pwd = document.getElementById("newPassword");
if (pwd.value.length==0) {
strength.innerHTML = '';
} else if (false == enoughRegex.test(pwd.value)) {
strength.innerHTML = '<span style="color:red">Atlest 8 Character!</span>';
} else if (strongRegex.test(pwd.value)) {
strength.innerHTML = '<span style="color:green">Your Password is Strong!</span>';
} else if (mediumRegex.test(pwd.value)) {
strength.innerHTML = '<span style="color:orange">Your Password is Medium!</span>';
} else {
strength.innerHTML = '<span style="color:red">Your Password is Weak!</span>';
}
}
</script>


 <div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<form:form modelAttribute="user" method="POST" action="mobileChangePassword.do">
<input type="hidden" name="baseURL" id="baseURL" value="mobileChangePassword.do" />
					
	<div data-role="fieldcontain">
		<form:label path="oldPassword">Enter Current Password</form:label>
		<form:input path="oldPassword" type="password"  size="8" maxlength="20" class="input"/>
	</div>
	
	<div data-role="fieldcontain">
		<form:label path="newPassword">Enter New Password</form:label>
		<form:input path="newPassword" type="password"  size="8" maxlength="20" onkeyup="return passwordChanged();"  class="input"/>
		<div id='strength'></div>
	</div>

	<div data-role="fieldcontain">
		<form:label path="resetPassword">Confirm New Password</form:label>
		<form:input path="resetPassword" type="password" class="input" />
	</div>
	<button type="button" id="save"
		data-mini="true" data-inline="true"
		data-role="button">
		<span class="ui-button-text">Save</span>
	</button>

	<button type="reset" id="cancel"
		data-role="button" data-mini="true" data-inline="true">
		<span class="ui-button-text">Cancel</span>
	</button>
</form:form>