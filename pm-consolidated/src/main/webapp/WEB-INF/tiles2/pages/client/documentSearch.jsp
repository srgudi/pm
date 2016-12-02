 <%@ include file="../../layout/PM-INCLUDES.jsp" %>
  <div class="well reducedBottom">
  <div class="fieldset">
    <div class="f13">
    <form:form modelAttribute="documentSerach" method="POST" action="">
            <input type="hidden" id="clientId" name="clientId" value="${clientId}"/>
          <input type="hidden" id="link" name="link" value="link"/> 
            <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
                    <div class="container_12 mt20">
                    <div class="row">	
		            <div class="span3">
                    <form:label path="fileName"><spring:message code="label.filename"/></form:label>
                    <form:input path="fileName" cssClass="formInput" tabindex="1"/>
                    </div>
                    <div class="span3">
                    <form:label   path="clientName"><spring:message code="label.clientname"/></form:label>
                    <form:input path="clientName" cssClass="formInput" tabindex="2"/>                     
                    </div>
                    <div class="span3">
                    <form:label path="docAuthor"><spring:message code="label.author"/></form:label>
                    <form:input path="docAuthor" cssClass="formInput" tabindex="3"/>
                    </div>
                    </div>
                    <div class="row">	
				    <div class="span3">
                    <form:label path="fileExtension"><spring:message code="label.fileType"/></form:label>
                    <form:input path="fileExtension" cssClass="formInput" tabindex="4"/>                 
                    </div>
                    <div class="span3">
                    <form:label path="date"><spring:message code="label.uploadedFrom"/></form:label>
                    <form:input path="date" cssClass="formInput" id="docDatepickerCrtFrom"  tabindex="5"/>
                    </div>
                    <div class="span3">
                    <form:label path="to"><spring:message code="label.to"/></form:label>
                    <form:input path="to" cssClass="formInput" id="docDatepickerCrtTo" tabindex="6"/>
                    </div>
                    </div>
                    </br>
                     <div class="row">	
			    <div class="span3">	 
			     <c:choose>
	                  		<c:when test="${not empty clientId }">               	
					<button type="button" id="docSearch" class="btn btn-success"><spring:message code = "label.search"/></button>
					<a href="#home" onclick=docUpload(); data-toggle="tab" style="text-decoration:none;"> 
	                    <button type="button"
	                        	class="btn btn-success" aria-disabled="false">
	                     	<span class="ui-button-text"><spring:message code="label.backToDocumentUpload"/></span>
	                    </button>
	                     </a><%-- <button type="reset" class="btn btn-success"><spring:message code="label.backToDocumentUpload"/></button> --%>
					 </c:when>
			    <c:otherwise>
			    <p style="color: red;"> Please select a client to search Documents</p>
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
         var clientId = $("#clientId").val(); 
    	 var fileName = $("#fileName").val(); 
    	 var clientName = $("#clientName").val(); 
    	 var docDatepickerCrtFrom = $("#docDatepickerCrtFrom").val(); 
    	 var fileExtension = $("#fileExtension").val(); 
    	 var docDatepickerCrtTo = $("#docDatepickerCrtTo").val(); 
    	 var docAuthor = $("#docAuthor").val(); 
    	 $('#getDocuments').dataTable().fnReloadAjax('clientDocumentSearchList.do?clientId='+clientId+'&fileName='+fileName+'&clientName='+clientName+'&docDatepickerCrtFrom='+docDatepickerCrtFrom+'&fileExtension='+fileExtension+'&docDatepickerCrtTo='+docDatepickerCrtTo+'&docAuthor='+docAuthor);
 	
	 });
	 $().ready(function() { 
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
 });
	 function docUpload(){
		 $('#documentTabs a:first').tab("show");
		 $('#documenthome').show();
		 $('#documentfoo').hide();
	}

</script>
 


<span class="legend b">${docseli}</span> 
  <div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getDocuments">
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
	      $("#getDocuments").dataTable({
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
           "sAjaxSource": 'clientDocumentSearchList.do',
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

