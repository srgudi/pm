<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<script type="text/javascript">
    $(document).ready(function() {      
        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name");
    });
    </script>
<style type="text/css">
    .party fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        border: 2px solid red;

    }

    div.error_container ol li {
        list-style-type: disc;

    }

    div.error_container {
        display: none
    }

    .error_container label.error {
        display: inline;
    }

    form.party {
        width: 30em;
    }

    form.party label.error {
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
  <script type="text/javascript">
  $.validator.setDefaults({
	    submitHandler: function(form) {
	        form.submit();
	    }
	});
  $().ready(function() {
 	 $("#save").click(function() {
 		 var container = $('div.error_container');
         var validator = $("#taskDocuments").validate({
 			rules: { 
 				'title': {required:true,alphabetsOnly:true},
 				'author': {required:true,alphabetsOnly:true},
 				'description': {required:false,alphabetsOnly:true},
 				'file': {required:true}
 			},
 			messages: {
 				'title': {required: "Title is required",alphabetsOnly: "No Special Charcters/Numbers allowed. Please enter a valid Title"},
 				'author': {required: "Author is required",alphabetsOnly: "No Special Charcters/numbers allowed. Please enter a valid  Name of Author"},
 				'description': {alphabetsOnly: "No Special Charcters/numbers allowed. Please enter a valid Description"},
 				'file': {
             		required: "Please upload image"}
 			},
 			errorContainer: container,
 			errorLabelContainer: $("ol", container),
 			wrapper: 'li',
 			meta: "validate"
         });
 		$("#taskDocuments").submit();
     });

});
 </script>
<style>
    .error {
        color: red;
    }

    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 2px solid red;
        width: auto;
    }
</style>			   
  
  
  <div class="ml20 mr20 mt10">
  <div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>
  <div class="fieldset">
<span class="legend b">Task Related Documents</span>
    <div class="f13">
    <form:form modelAttribute="taskDocuments" method="POST" action="taskDocuments.do" enctype="multipart/form-data">
     <input type="hidden" name="clientId" value="${param.clientId }"/>
  <input type="hidden" name="taskId" value="${param.taskId }"/>
  <input type="hidden" name="baseURL" id="baseURL" value="taskDocuments.do"/>
  <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
  
 <%--  <form:hidden path="id"/> --%>
  
  <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px"></h4></div>
                <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="title">Title</form:label></div>
                    <div class="grid_3 right"><form:input path="title" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="description">Discription</form:label></div>
                    <div class="grid_3 right"><form:input path="description" cssClass="input_full" tabindex="2"/></div>
                     
                </div>
                <div class="container_12 pt5">
                <div class="grid_2 right"><form:label   path="author">Author</form:label></div>
                    <div class="grid_3 right"><form:input path="author" cssClass="input_full" tabindex="2"/></div>
 </div>
  <br></br>
 <div class="container_12 pt5">
                     <div class="grid_2 right"><form:label   path="file">Select File</form:label></div>
                     <div class="grid_3 right"><form:input path ="file" type="file"  cssClass="input_full" tabindex="6"/></div>
                    </div>
                    <div class="container_12" style="margin:10px;"></div>

            <div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">             	
	
	                	<button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">	
	    	                <span class="ui-button-text" tabindex="16">Upload</span>
						</button>
						&nbsp;&nbsp;
	                	
	                    	<button type="reset"
	                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Cancel</span>
	                    	</button>
		        </div>
        	</div>
        	<div class="container_12" style="margin:10px;"></div>
        </form:form>
        	</div>
    </div>

</div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>




		 