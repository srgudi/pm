<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.code fieldset p.error label {
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

form.code {
	width: 30em;
}

form.code label.error {
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

	$(document)
			.ready(
					function() {

						$.validator.addMethod("alphaNumeric", function(value,
								element) {
							return this.optional(element)
									|| /^[0-9A-Z-]+$/i.test(value);
						}, "Please enter valid data.");

						$.validator
								.addMethod("alphabetsOnly", function(value,
										element) {
									return this.optional(element)
											|| /^\s*[a-zA-Z.\s]+\s*$/i
													.test(value);
								},
										"No Special characters are allowed. Please enter valid data.");
						});

	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});

	$()
			.ready(
					function() {
						$("#save").click(function() {
						var container = $('div.error_container');
						// validate the form when it is submitted
						var validator = $("#code")
								.validate(
										{

											rules : {
												'shortName' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'longDescription' : {
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 100
												},
												'codeType' : {
													required : true,
													min : 1
												},
												'parentCode' : {},
												'sortOrder' : {
													range : [ 0, 50 ],
													required : true,
													digits : true
												}
											},
											messages : {
												'shortName' : {
													required : "Name is required",
													alphabetsOnly : "No Special characters are allowed. Please enter a valid Name.",
													minlength : "Enter Name with at least {0} characters.",
													maxlength : "Enter Name with no more than {0} characters."
												},
												'longDescription' : {
													required : "Description is required",
													alphabetsOnly : "No Special characters are allowed. Please enter a valid Description.",
													minlength : "Enter Description with at least {0} characters.",
													maxlength : "Enter Description with no more than {0} characters."
												},
												'codeType' : "Select one Code Type",
												'parentCode' : "",
												'sortOrder' : {
													digits : "Enter Sort Order Number only digits.",
													range : "Please enter Sort Order Number between range {0} and {1}."
												}
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate"
										});
						$("#code").submit();
						});

						$(".cancel").click(function() {
							validator.resetForm();
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
	margin: 5px;
	padding: 5px;
	width: auto;
}
</style>

<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Code</span>
<div class="f13">
			<form:form modelAttribute="code" method="POST" action="adminCode.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="adminCode.do" />
                <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
				<form:hidden path="id" />
				<center> 
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}"/></font></b>
					</c:if>
				</center>
				<div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="codeType">Type Of Code</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="codeType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							 <form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                    <div class="s1"></div>
					<div class="grid_2 right"><form:label path="sortOrder">Sort Order</form:label></div>
                    <div class="grid_3 right"><form:input path="sortOrder" cssClass="input_full"  tabindex="2"/></div>
                </div>
				
				<div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="shortName">Name</form:label></div>
                    <div class="grid_3 right"><form:input path="shortName" cssClass="input_full" tabindex="3"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="longDescription">Description</form:label></div>
                    <div class="grid_3 right"><form:input path="longDescription" cssClass="input_full" tabindex="4"/></div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="parentCode">Relative Parent Code</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="parentCode" cssClass="input_full" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="applicationLevelIndicator">Application Level Indicator</form:label></div>
                    <div class="grid_3 left">
						<form:radiobutton path="applicationLevelIndicator" value="true" label="Yes" tabindex="6"/> 
						<form:radiobutton path="applicationLevelIndicator" value="false" label="No" tabindex="7"/>
					</div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label   path="activeFlag">Status</form:label></div>
                    <div class="grid_3 left">
						<form:radiobutton path="activeFlag" value="true" label="Active" tabindex="8" /> 
						<form:radiobutton path="activeFlag" value="false" label="Inactive" tabindex="9" />
					</div>
                </div>
				
				<div class="container_12" style="margin:10px;"></div>
				
						<div class="container_12">
						    <div class="grid_3">&nbsp;</div>
						    <div class="grid_8">
						
						        <a href="adminCode.do"
						           style="text-decoration: none;">
						            <button type="button" id="refesh"
						            onclick="window.location='adminCode.do';return false;"
						                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                    role="button" aria-disabled="false">
						                <span class="ui-button-text">New Code</span>
						            </button>
						        </a> &nbsp;&nbsp;
						
						        <button type="button" id="save"
						                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                role="button" aria-disabled="false">
						                <c:if test="${code.id == null}">
						            <span class="ui-button-text"tabindex="10">Save</span>
						            </c:if>
						            <c:if test="${code.id != null}">
						            <span class="ui-button-text" tabindex="10">Update</span>
    	                             </c:if>
						        </button>
						        &nbsp;&nbsp;
						
						
						        <button type="reset"
						                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                role="button" aria-disabled="false">
						            <span class="ui-button-text">Cancel</span>
						        </button>
						    </div>
						</div>				
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
	<div class="container_12" style="margin:10px;"></div>
<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Code List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
			<table id="list"></table>
			<div id="pager" class="scroll"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";

			jQuery(document)
					.ready(
							function() {

								var mygrid = jQuery("#list")
										.jqGrid(
												{
													datatype : 'local',
													height : 300,
													mtype : 'GET',
													colNames : [
															'Short Name',
															'Long Description',
															'Type Of Name',
															'App Level Indicator',
															'Parent Code Name',
															'Status' ],
													colModel : [
															{
																name : 'shortName',
																index : 'shortName',
																formatter : 'showlink',
																formatoptions : {
																	baseLinkUrl : '<c:url value="/appadmin/adminCode.do"/>',
																	idName : 'id'
																}
															},
															{
																name : 'longDescription',
																index : 'longDescription'
															},
															{
																name : 'codeTypeName',
																index : 'codeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'parentCodeShortName',
																index : 'parentCodeShortName'
															},
															{
																name : 'status',
																index : 'status',
																	 width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
															   		 	formatter:'select', stype: 'select', sorttype:
															   		 	function(cell) {return status[cell];},
															   		 edittype:'select', editoptions: { value: statusStr }, 
															   		searchoptions:{ sopt:['eq'] }},
															 ],
													jsonReader : {
														root : "rows",
														page : "page",
														total : "total",
														records : "records",
														repeatitems : false,
														cell : "cell",
														id : "id",
														userdata : "userdata"
													},
													pager : jQuery('#pager'),
													rowNum : 50,
													loadonce : true,
													rowList : [ 50, 100, 200 ],
													sortname : 'firstName',
													sortorder : 'asc',
													viewrecords : true,
													autowidth : false,
													caption : 'Code List',
													editurl : '<c:url value="/appadmin/saveCode.do"/>'

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
							});
			
			 // resize the grid if needed
			 $(window).bind('resize', function() {
				jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
				}).trigger('resize');
			 
			 $(window).bind('load', function() {
					jQuery("#list").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('load');
			 
			 $(window).bind('reload', function() {
				 jQuery("#list").setGridParam({url:'retriveAdminCode.do'}); 
				 jQuery("#list").trigger("reloadGrid"); 
					}).trigger('reload');
		</script>
		
		
<script type="text/javascript">
    $(document).ready(function() {
    	firmId = ${firm.id};
    	var applicationLevelId;
    	
    	 $(function () {
    		
    		 $('input[name="applicationLevelIndicator"]').live("click", (function () {
    	        
    	        	var id = $("input[name='applicationLevelIndicator1']:checked").attr('id');
            
    	        	if(id=="applicationLevelIndicator1"){
  	        		
    	        		applicationLevelId="Yes";
    	        	}else{
    	        		
    	        		var id1 = $("input[name='applicationLevelIndicator2']:checked").attr('id');
    	        
    	            	if(id1=="applicationLevelIndicator2"){
    	            		
    	            		applicationLevelId="No";
    	            		
    	            	}
    	        		
    	        	}
    	        	var codeId=$("#codeType").val();
    	        	
    	           	$.get('retriveAdminCode.do',  { codeTypeId: codeId, applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {       		
    	                
    	        		populateGrid(data);
    	            });
    	        	
    	        }));
    	       
    	    }); 
    	
        $("#codeType").change(function() { 
        	
        	//This portion is not used and was creating issue (bug no 519) and hence has been commented.
        	/* var id = $("input[@name=applicationLevelIndicator1]:checked").attr('id');
            
        	if(id=="applicationLevelIndicator1"){
        		applicationLevelId="Yes";
        	}else{
        		id1 = $("input[@name=applicationLevelIndicator2]:checked").attr('id');
            	
            	if(id1=="applicationLevelIndicator2"){
            		
            		applicationLevelId="No";
            		
            	}
        		
        	} */
        	
            $.post("getRelativeParentCode.do", { codeTypeId: $(this).val(), firmId:firmId }, function(data) {
            	//alert("Hi");
            	//"#parentCode"
                populateDropdown($("#parentCode"), data);
            });
            
        if ($("#codeType").val() != -1) {
        	
        	 var id = $("input[id='applicationLevelIndicator1']:checked").val();
        
        	if(id=="true"){
        		applicationLevelId="Yes";
        	}else{
        		id1 = $("input[id='applicationLevelIndicator2']:checked").val();
            	
            	if(id1=="applicationLevelIndicator2"){
            		
            		applicationLevelId="No";
            		
            	}
        		
        	} 
        	$.get('retriveAdminCode.do',  { codeTypeId: $(this).val(), applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {        		
        		
        		populateGrid(data);
            });
        }
        });
    });
 
     $(document).ready(function() {
    	var codeId=$("#codeType").val();
    	 if ($("#codeType").val() != -1) {
    	var id = $("input[@name=applicationLevelIndicator1]:checked").attr('id');
        
    	if(id=="applicationLevelIndicator1"){
    		applicationLevelId="Yes";
    	}else{
    		id1 = $("input[@name=applicationLevelIndicator2]:checked").attr('id');
        	
        	if(id1=="applicationLevelIndicator2"){
        		
        		applicationLevelId="No";
        		
        	}
    		
    	}
    	$.get('<c:url value="/appadmin/retriveAdminCode.do"/>',  { codeTypeId: codeId, applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {       		
	        
    		populateGrid(data);
        });
     }
	}); 
    
    function populateDropdown(select, data) {
    	select.html('');
    	/* select.append($('<option></option>').val("-1").html("None")); */
        $.each(data, function(id, option) {
        	$.each(option, function(id, option) {
        	select.append($('<option></option>').val(option.key).html(option.value));
            
        });
        });
    }
        function populateGrid(data)
        {
        	$("#list").jqGrid('clearGridData');
        	var rowdata = data.rows;
        	for (var i = 0; i < rowdata.length; i++) {
        	var code = rowdata[i];    
        	
        	$('#list').jqGrid('addRowData', code.id, {
             id : code.id,
             shortName : code.shortName,
             longDescription: code.longDescription,
             status: code.status,
             codeTypeName: code.codeTypeName,
             strApplicationLevelIndicator: code.strApplicationLevelIndicator,
             parentCodeShortName: code.parentCodeShortName
        	});
        }
        }
    
</script>

</div>
<!-- <script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script> -->
 

