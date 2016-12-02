<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags'%>

<div class="well">
 <form:form modelAttribute="documentSerach" method="POST" action="">
 <input type="hidden" id="fileName"  name="fileName" value="${param.fn}" />
</form:form>
</div>

  <script type="text/javascript"></script>

<!--  <div class="fieldset mt25 ml20 mr20">
<span class="legend b">Documents Searched List</span>

    
    <div id="grid_wrapper" class="ml10 mr10 mt20">
         <table id="list"></table>
         <div id="pager" class="scroll"></div>
    </div>
   
    <script type="text/javascript">
        jQuery(document).ready(function() {
        	var fileName = $('#fileName').val();
        	console.log(fileName); 
	var mygrid = jQuery("#list").jqGrid({
                url:'documentSearchList.do?fileName='+fileName,
                datatype: 'json',
                height : '100',
                mtype: 'GET',
                colNames:['Id','Client Name', 'Document Name','Title','Author','Uploaded Date'],
                colModel :[
                            {name:'docId', index:'docId',hidden:true}, 
                           {name:'clientName', index:'clientName',  width:200},
                           {name:'fileName', index:'fileName',  width:200, formatter: 'showlink', 
                        	formatoptions: {baseLinkUrl: '<c:url value="/document/download.do"/>', target:"_blank", idName:'docId'}},
                           {name:'title', index:'title',  width:150},
                           {name:'author', index:'author',  width:150},
                           {name:'formattedDate', index:'formattedDate',  width:150}
                       ],
                       jsonReader : {
                           root: "rows",
                           page: "page",
                           total: "total",
                           records: "records",
                           repeatitems: false,
                           cell: "cell",
                           id: "docId",
                           userdata: "userdata"
                       },
                       pager: jQuery('#pager'),
                       rowNum:10,
                       loadonce: true,
                       rowList:[10,25,50],
                       ignoreCase: true,
                       sortname: 'formattedDate',
                       sortorder: 'desc', 
                       viewrecords: true,
                       autowidth: true,
                       caption: 'Documents Searched',
                       editurl:'<c:url value="/deleteDocument.do"/>'
                   });
	                    	
	           
	jQuery("#list").jqGrid('navGrid', '#pager', {
		del : true,
		add : false,
		edit : false,
		search : false
	});
	
	 jQuery("#list").jqGrid('navButtonAdd',
             "#pager", {
                 caption : "Apply Filter",
                 title : "Toggle Search Toolbar",
                 buttonicon : 'ui-icon-pin-s',
                 onClickButton : function() {
                     mygrid[0].toggleToolbar();
                 }
             });
	 
	 jQuery("#list").jqGrid('filterToolbar', {
         stringResult : true,
         searchOnEnter : false
     });
             
            /*  $().ready(function() {
            	 $("#docSearch").click(function() {
            		 var documentSearchFilter = { groupOp: "AND", rules: []};
	           		documentSearchFilter.rules.push({field:"fileName",op:"eq",data:$("#fileName").val()}); 
	           	    documentSearchFilter.rules.push({field:"clientName",op:"eq",data:$("#clientName").val()}); 
	           	    documentSearchFilter.rules.push({field:"date",op:"eq",data:$("#docDatepickerCrtFrom").val()}); 
	           	    documentSearchFilter.rules.push({field:"fileExtension",op:"eq",data:$("#fileExtension").val()}); 
	           	    documentSearchFilter.rules.push({field:"to",op:"eq",data:$("#docDatepickerCrtTo").val()}); 
	           	    documentSearchFilter.rules.push({field:"clientId",op:"eq",data:$("#clientId").val()}); 
	           	    documentSearchFilter.rules.push({field:"author",op:"eq",data:$("#author").val()}); 
	           		
	          // 	 	mygrid[0].p.search = documentSearchFilter.rules.length>0;
	        		$.extend(mygrid[0].p.postData,{filters:JSON.stringify(documentSearchFilter)}); 
	        		$("#list").setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
            	 });
            }); */
        });
    </script>

</div> 
 -->
 
 <div style="width: 120%;">
  <div id="grid_wrapper">  
	<table border="0" class="table table-striped table-hover table-bordered mb20" id="getAllDocuments">
	          <caption title="" class="captionFont">Searched Documents List</caption>
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
		var fileName = $('#fileName').val();
		console.log(fileName); 
		$("#getAllDocuments").dataTable({
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
               "sZeroRecords": "No documents found. Search with another keyword."
           }, 
           "sAjaxSource": 'documentSearchList.do?fileName='+fileName,
           "bProcessing": 'true',
         //  "bServerSide": 'true',
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
