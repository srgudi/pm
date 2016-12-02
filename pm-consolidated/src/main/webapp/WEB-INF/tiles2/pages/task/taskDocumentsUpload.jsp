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
 <!--  <script type="text/javascript">
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
</style>			    -->
  
  <script type="text/javascript">
/*  $.validator.setDefaults({
	    submitHandler: function(form) {
	        form.submit();
	    }
	}); */
$().ready(function() {
	 $("#taskDocSave").click(function() {
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
	 			meta: "validate",
		 submitHandler: function(form) {
	        $(form).ajaxSubmit({
		    dataType:  'text', 
	        url: 'taskDocuments.do',
	        beforeSubmit:  showRequest,
	        iframe: true,
	        success: function (text) {
	        	console.log(text);
	            var data = $.parseJSON(text);
	            console.log(data);
	            console.log(data.id);
	            if(data.id != "-1"){
	            	$.jGrowl('File Uploaded Sucessfully');
	        }else{
	        	$.jGrowl('File was not uploaded correctly. Please upload file once more'); 
	        	
	        	/* $("#title").val(""); */
	        }
	            document.getElementById("taskDocuments").reset();
	            return false;
	        },
	        error: function (xmlRequest, textStatus, errorThrown) {
	            alert(errorThrown);
	        }
	});
		 }
		 });
//	$("#taskDocuments").submit();
	 });
});

function showRequest(formData, jqForm, options) { 
    var queryString = $.param(formData); 
   return true; 
} 
</script> 
  <div class="well">
  <div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>
  <div class="fieldset">

    <div class="f13">
    <form:form modelAttribute="taskDocuments" method="POST"  enctype="multipart/form-data">
     <input type="hidden" name="clientId" value="${param.clientId}"/>
  <input type="hidden" name="taskId" value="${taskId}"/>
<!--   <input type="hidden" name="baseURL" id="baseURL" value="taskDocuments.do"/> -->
  <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
  
 <%--  <form:hidden path="id"/> --%>
  
 
                <div class="container_12 mt20">
                 <div class="row">	
                  <div class="span3">
                   <form:label path="title"><spring:message code = "label.title"/></form:label>
                    <form:input path="title" cssClass="input_full" tabindex="1"/>
                   </div>
                    <div class="span3">
                    <form:label   path="description"><spring:message code = "label.description"/></form:label>
                   <form:input path="description" cssClass="input_full" tabindex="2"/>
                   </div>
                   <div class="span3">
                     <form:label   path="author"><spring:message code = "label.author"/></form:label>
                   <form:input path="author" cssClass="input_full" tabindex="2"/>
                   </div>
                   </div>  
             
                     <div class="row">	
				 <div class="span3">
                     <form:label   path="file"><spring:message code = "label.selectfile"/></form:label>
                     <form:input path ="file" type="file"  cssClass="input_full" tabindex="6"/>
                    </div>
                    </div>
                    <br></br>
	                	<div class="row">	
			     <div class="span3">  
			           <c:choose>
                  			<c:when test="${not empty taskId}">
			     	<c:if test="${taskStatus != 'Completed'}">
					<button  id="taskDocSave" class="btn btn-success" role="button" aria-disabled="false"><spring:message code = "label.upload"/></button>&nbsp;&nbsp;
					<button type="reset" class="btn btn-success" role="button" aria-disabled="false"><spring:message code = "label.cancel"/></button>
			     </c:if>
			     <c:if test="${taskStatus == 'Completed'}">
			     <p style="color: red;">You Cant upload a document for a completed Task</p>
			     </c:if>
			     	</c:when>
			     	<c:otherwise>
			     	<p style="color: red;"> Please select a task to upload Documents</p>
			     	</c:otherwise>
			     	 </c:choose>
			    
			    </div>
        	</div>
		        </div>
        	</div>
        	  </div>
        	<div class="container_12" style="margin:10px;"></div>
        </form:form>
        	</div>
 






		 