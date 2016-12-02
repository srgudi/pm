<%@ include file="../../layout/PM-INCLUDES.jsp" %>
  <script type="text/javascript">
 
			      </script>
  
  
  <div class="ml20 mr20 mt10">
  <div class="fieldset">
<span class="legend b">Documents</span>
    <div class="f13">
    <form:form modelAttribute="searchDocument" method="POST" action="">
          <input type="hidden" id="link" name="link" value="link"/> 
            <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
          <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px"></h4></div>
                <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="fileName">File Name</form:label></div>
                    <div class="grid_3 right"><form:input path="fileName" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="clientName">Client Name</form:label></div>
                    <div class="grid_3 right"><form:input path="clientName" cssClass="input_full" tabindex="2"/></div>
                     
                </div>
                 <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="author">Author</form:label></div>
                    <div class="grid_3 right"><form:input path="author" cssClass="input_full" tabindex="3"/></div>  
                     <div class="s1"></div> 
                     <div class="grid_2 right"><form:label path="fileExtension">File Extension Type</form:label></div>
                    <div class="grid_3 right"><form:input path="fileExtension" cssClass="input_full" tabindex="4"/></div>                    
                </div>
                <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="date">File Uploaded Date From:</form:label></div>
                    <div class="grid_3 right"><form:input path="date" cssClass="input_full" id="docDatepickerCrtFrom"  tabindex="5"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label path="to">To:</form:label></div>
                    <div class="grid_3 right"><form:input path="to" cssClass="input_full" id="docDatepickerCrtTo" tabindex="6"/></div> 
                     
                </div>
                <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="dueDate">Due Date From:</form:label></div>
                    <div class="grid_3 right"><form:input path="dueDate" cssClass="input_full" id="docDatepickerDueFrom"  tabindex="7"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label path="dueDateTo">To:</form:label></div>
                    <div class="grid_3 right"><form:input path="dueDateTo" cssClass="input_full" id="docDatepickerDueTo" tabindex="8"/></div> 
                     
                </div>
               
                 <div class="container_12" style="margin:10px;"></div>
                 <div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
	                	
	                	<button type="button" id="docSearch"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
						<span class="ui-button-text" tabindex="16">Search</span>
	    	          	</button>
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

 <div class="fieldset mt25 ml20 mr20">
<span class="legend b">Documents Searched List</span>

    
    <div id="grid_wrapper" class="ml10 mr10 mt20">
         <table id="list"></table>
         <div id="pager" class="scroll"></div>
    </div>

    <script type="text/javascript">
        jQuery(document).ready(function() {
	var mygrid = jQuery("#list").jqGrid({
                url:'documentSearchList.do',
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
             
             $().ready(function() {
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
            });
        });


        // resize the grid if needed
        $(window).bind('resize',
                function() {
                    jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
                }).trigger('resize');

        $(window).bind('load',
                function() {
                    jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
                }).trigger('load');
    </script>

</div> 
