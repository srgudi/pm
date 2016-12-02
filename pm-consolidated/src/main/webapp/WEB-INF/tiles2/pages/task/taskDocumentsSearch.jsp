 <%@ include file="../../layout/PM-INCLUDES.jsp" %>
 
  <div class="well" style="margin-bottom: 0px;">
  <div class="fieldset">

    <div class="f13">
    <form:form modelAttribute="taskDocumentSerach" method="POST" action="">
          <input type="hidden" id="taskId" name="taskId" value="${taskId}"/>
          <input type="hidden" id="link" name="link" value="link"/> 
            <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
            
       
                <div class="container_12 mt20">
                <div class="row">
                <div class="span3">
                   <form:label path="fileName"><spring:message code = "label.filename"/></form:label>
                   <form:input path="fileName" cssClass="input_full" tabindex="1"/>
                    </div>
                    <div class="span3">
                    <form:label   path="clientName"><spring:message code = "label.clientname"/></form:label>
                    <form:input path="clientName" cssClass="input_full" tabindex="2"/>
                     </div>
               
                <div class="span3">
                   <form:label path="docAuthor"><spring:message code = "label.author"/></form:label>
                   <form:input path="docAuthor" cssClass="input_full" tabindex="3"/>
                    </div>
                    </div>
                    
                    <div class="row">
                    <div class="span3">
                     <form:label path="fileExtension"><spring:message code = "label.fileextentiontype"/></form:label>
                  <form:input path="fileExtension" cssClass="input_full" tabindex="4"/>              
               
                </div>
                     <div class="span3">
                   <form:label path="taskDate"> File Uploaded Date From :</form:label>
                    <form:input path="taskDate" cssClass="input_full" id="docDatepickerCrtFrom" tabindex="6"/>
                   </div>
                        <div class="span3">
                    <form:label path="taskDateTo"><spring:message code = "label.to"/></form:label>
                   <form:input path="taskDateTo" cssClass="input_full" id="docDatepickerCrtTo" tabindex="6"/>
                     </div>
                  </div>
                <div class="row">
                  <div class="span3">
                   <form:label path="taskDueDate"><spring:message code = "label.dueDateFrom"/></form:label>
                   <form:input path="taskDueDate" cssClass="input_full" id="docDatepickerDueFrom"  tabindex="7"/>
                    </div>
                     <div class="span3">
                   <form:label path="dueDateTo"><spring:message code = "label.to"/></form:label>
                  <form:input path="dueDateTo" cssClass="input_full" id="docDatepickerDueTo" tabindex="8"/>
                     
                     </div>
                     </div>

</br>
					<div class="row">
						<div class="span3">
						 <c:choose>
                  			<c:when test="${not empty taskId}">
							<button type="button" id="docSearch" class="btn btn-success"><spring:message code = "label.search"/></button>
						<a href="#home" onclick=docUpload(); data-toggle="tab" style="text-decoration:none;"> 
	                    <button type="button"
	                        	class="btn btn-success"
	                     	<span class="ui-button-text"><spring:message code="label.backToDocumentUpload"/></span>
	                    </button>
	                     </a>&nbsp;&nbsp;
							<%-- <button type="reset" class="btn btn-success"><spring:message code = "label.backToDocumentUpload"/></button> --%>
							</c:when>
							<c:otherwise>
							<p style="color: red;"> Please select a task to search Documents</p>
							</c:otherwise>
							 </c:choose>
						</div>
					</div>
				</div>
	                    
        </form:form>
        	</div>
    </div>

</div>

<script>
               $("#docSearch").click(function(){
            	   var fileName = $("#fileName").val(); 
                   var clentName = $("#clientName").val(); 
               	   var docAuthor = $("#docAuthor").val(); 
            	   var fileExtension = $("#fileExtension").val(); 
            	   var frmDate = $("#docDatepickerCrtFrom").val(); 
            	   var to = $("#docDatepickerCrtTo").val(); 
            	   var dDate = $("#docDatepickerDueFrom").val(); 
            	   var dDateTo = $("#docDatepickerDueTo").val(); 
            	   var taskId = $("#taskId").val(); 
            	   $('#getTaskDocuments').dataTable().fnReloadAjax('taskDocumentSearchList.do?fileName='+fileName+'&clentName='+clentName+'&frmDate='+frmDate+'&fileExtension='+fileExtension+'&to='+to+'&docAuthor='+docAuthor+'&dDate='+dDate+'&dDateTo='+dDateTo+'&taskId='+taskId);
               }); 
               
               $(function() {
               	$("#docDatepickerCrtFrom").datepicker({
               		dateFormat: 'yy-mm-dd',
               		 changeMonth: true,
                        changeYear: true,
                        yearRange: '-40:+20'
               		});
               	});
               $(function() {
               	$("#docDatepickerCrtTo").datepicker({
               		dateFormat: 'yy-mm-dd',
               		 changeMonth: true,
                        changeYear: true,
                        yearRange: '-40:+20'
                        });
               	});
               $(function() {
               	$("#docDatepickerDueFrom").datepicker({
               		dateFormat: 'yy-mm-dd',
               		 changeMonth: true,
                        changeYear: true,
                        yearRange: '-40:+20'
                        });
               	});
               $(function() {
               	$("#docDatepickerDueTo").datepicker({
               		dateFormat: 'yy-mm-dd',
               		 changeMonth: true,
                        changeYear: true,
                        yearRange: '-40:+20'});
               	});
               function docUpload(){
          		 $('#documentTabs a:first').tab("show");
          		 $('#documenthome').show();
          		 $('#documentfoo').hide();
          	}
           
</script>

 <div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getTaskDocuments">
		<colgroup>
					<col style="width: 17%;">
					<col style="width: 17%;">
					<col style="width: 17%;">
					<col style="width: 17%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					
		</colgroup>
		<thead>
			<tr>
			  <th class="cyan b center">ID</th>
			  <th class="cyan b center">Client Name</th>
			  <th class="cyan b center">Document Name</th>
			  <th class="cyan b center">Title</th>
			  <th class="cyan b center">Author</th>
			  <th class="cyan b center">Uploaded Date</th>
			 
			</tr>
		</thead>
		<tbody></tbody>
	</table>
 </div>
</div>

<script>
	$(function(){
		//alert("di"+partyId);
		$("#getTaskDocuments").dataTable({
		   "fnPreDrawCallback": function () {
               return true;
           },
           "fnDrawCallback": function () {
        	  
           },
           "aaSorting": [
               [0, "desc"]
           ],
           "bLengthChange": false,
           "bFilter": false,
           "sPaginationType": "bootstrap",
           "bInfo": true,
           "oLanguage": {
               "sLengthMenu": "_MENU_ records per page",
               "sProcessing": "Loading.....",
               "sZeroRecords": "No documents Serached . Enter keyword and click on Search."
           }, 
           "sAjaxSource": 'taskDocumentSearchList.do',
         //  "bProcessing": 'true',
           "bServerSide": 'true',
           "bDeferRender": 'false',
           "aoColumns": [
                         {
                             "bUseRendered": "false",
                             "sClass": "hide",
                             "fnRender": function (obj) {
                             	return obj.aData[0];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                return obj.aData[1];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                            //	return"<a href='javascript:docDownload(" + obj.aData[0] + ")'>"+obj.aData[2]+"</a>";
                             return"<a href='/pm-new/document/download.do?docId="+obj.aData[0]+"'>"+obj.aData[2]+"</a>";
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[3];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[4];
                             }
                         },
                         {
                             "bUseRendered": "false",
                             "sClass": "center",
                             "fnRender": function (obj) {
                                 return obj.aData[5];
                             }
                         }
                     ]
	   });
	});
	 

</script>


   