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
<div id="div2"  >
<!--  BUCKET -->
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>


			<form:form modelAttribute="code" method="POST" action="mobileAdminCode.do">
				<input type="hidden" name="baseURL" id="baseURL"
					value="mobileAdminCode.do" />
                <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
				<form:hidden path="id" />
				<center> 
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}"/></font></b>
					</c:if>
				</center>
				<div data-role="fieldcontain" >
                 <form:label path="codeType">Type Of Code</form:label>
                   		<form:select path="codeType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							 <form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                  <div data-role="fieldcontain" >
					<form:label path="sortOrder">Sort Order</form:label>
                    <form:input path="sortOrder" cssClass="input_full"  tabindex="2"/>
                </div>
				
				    <div data-role="fieldcontain" >
                    <form:label path="shortName">Name</form:label>
                    <form:input path="shortName" cssClass="input_full" tabindex="3"/>
                    </div>
                     <div data-role="fieldcontain" >
                  <form:label   path="longDescription">Description</form:label>
                   <form:input path="longDescription" cssClass="input_full" tabindex="4"/>
                </div>
                
                 <div data-role="fieldcontain" >
                <form:label path="parentCode">Relative Parent Code</form:label>
                   		<form:select path="parentCode" cssClass="input_full" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                    </div>
                   <div data-role="fieldcontain" >
                    <form:label   path="applicationLevelIndicator">Application Level Indicator</form:label>
						<form:radiobutton path="applicationLevelIndicator" value="true" label="Yes" tabindex="6"/> 
						<form:radiobutton path="applicationLevelIndicator" value="false" label="No" tabindex="7"/>
					
                </div>
                
                  <div data-role="fieldcontain" >
                  <form:label   path="activeFlag">Status</form:label>                  
						<form:radiobutton path="activeFlag" value="true" label="Active" tabindex="8" /> 
						<form:radiobutton path="activeFlag" value="false" label="Inactive" tabindex="9" />					
                </div>
						        <a href="mobileAdminCode.do"
						           style="text-decoration: none;">
						            <button type="button" id="refesh"
						            onclick="window.location='mobileAdminCode.do';return false;"
						                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                    role="button" aria-disabled="false" data-inline="true" data-mini="true">
						                <span class="ui-button-text">New Code</span>
						            </button>
						        </a> &nbsp;&nbsp;
						
						        <button type="button" id="save"
						                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						                role="button" aria-disabled="false" data-inline="true" data-mini="true">
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
						                role="button" aria-disabled="false" data-inline="true" data-mini="true">
						            <span class="ui-button-text">Cancel</span>
						        </button>
						   	
</form:form>
</div>

<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
    		<div id="grid_wrapper">
			<table id="adminCodeList"></table>
			<div id="adminCodePager" class="scroll"></div>
		</div>
		<script type="text/javascript">
		var status = ["All", "Active", "Inactive"];
		var statusStr = ":All;Active:Active;Inactive:Inactive";
								jQuery("#adminCodeList")
										.jqGrid(
												{
													 "hoverrows":false,
											            "viewrecords":true,
											            "jsonReader": {root : "rows",
											            page : "page",
											            total : "total",
											            records : "records",
											            repeatitems : false,
											            cell : "cell",
											            id : "id",
											            userdata : "userdata"},
											            "gridview":true,
											            "loadonce":true,
											          //  "url":'<c:url value="/tax/jurisdictionsList.do"/>?firmId='+firmId,
											            "scrollPaging":true,
											            pager : jQuery('#pager'),
											            "rowNum":10,
											            "rowList" : [20,40,60],
											            "sortname":"firstName",
											            "height":200,
											            "width" :300,
											            "mtype" : "GET",
											            "datatype":"local",
											            caption : 'Code List',
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
																 width:30,
																formatter : 'showlink',
																formatoptions : {
																	baseLinkUrl : '<c:url value="/mobileadmin/mobileAdminCode.do"/>',
																	idName : 'id'
																}
															},
															{
																name : 'longDescription',
																 width:30,
																index : 'longDescription'
															},
															{
																name : 'codeTypeName',
																 width:30,
																index : 'codeTypeName'
															},
															{
																name : 'strApplicationLevelIndicator',
																 width:30,
																index : 'strApplicationLevelIndicator'
															},
															{
																name : 'parentCodeShortName',
																 width:30,
																index : 'parentCodeShortName'
															},
															{
																name : 'status',
																index : 'status',
																	 width:30, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
															   		 	formatter:'select', stype: 'select', sorttype:
															   		 	function(cell) {return status[cell];},
															   		 edittype:'select', editoptions: { value: statusStr }, 
															   		searchoptions:{ sopt:['eq'] }},
															 ],
															 "pager":"#adminCodePager"
												});
								jQuery("#adminCodeList").jqGrid('filterToolbar', {
									stringResult : true,
									searchOnEnter : false
								});
							    $('#adminCodePager').css("height", "50px");
		
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
    	        	
    	           	$.get('retriveMobileAdminCode.do',  { codeTypeId: codeId, applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {       		
    	                
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
        	$.get('retriveMobileAdminCode.do',  { codeTypeId: $(this).val(), applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {        		
        		
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
    	$.get('<c:url value="/mobileadmin/retriveMobileAdminCode.do"/>',  { codeTypeId: codeId, applicationLevelId:applicationLevelId ,firmId:firmId }, function(data) {       		
	        
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
        	$("#adminCodeList").jqGrid('clearGridData');
        	var rowdata = data.rows;
        	for (var i = 0; i < rowdata.length; i++) {
        	var code = rowdata[i];    
        	
        	$('#adminCodeList').jqGrid('addRowData', code.id, {
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
 

