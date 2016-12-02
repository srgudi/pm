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

<script type="text/javascript">
    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
    	 $("#save").click(function() {
        	$("#user").submit();
         });

        $(".cancel").click(function() {
            validator.resetForm();
        });
    });
</script>
 <div class="fieldset">
<span class="legend b">&nbsp;&nbsp; User Information &nbsp;&nbsp;</span>
    <div class="f13">
			<form:form name="user" modelAttribute="user" method="POST"
				action="forgotPassword.do">
			<input type="hidden" name="baseURL" id="baseURL"
					value="forgotPassword.do" />
				<input type="hidden" name="to" id="to"
       value="${param.to}"/>	
       <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px">Please check your Email ID</h4></div>
            
            <div class="container_12 mt20">
            <div class="grid_3 right"><form:label path="username1">User Name</form:label></div>
            <div class="grid_4 right"><form:input cssClass="input_full" path="username1" class="input"
                        tabindex="1"/></div>
                    
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