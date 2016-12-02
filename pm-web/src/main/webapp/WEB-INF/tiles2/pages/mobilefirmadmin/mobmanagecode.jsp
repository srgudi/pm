<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->
<style type="text/css">
.partyCode fieldset p.error label {
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

form.partyCode {
	width: 30em;
}

form.partyCode label.error {
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

						$.validator
								.addMethod("alphabetsOnly", function(value,
										element) {
									return this.optional(element)
											|| /^\s*[a-zA-Z.\s]+\s*$/i
													.test(value);
								},
										"No Special characters are allowed. Please enter a valid.");

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
						var validator = $("#partyCode")
								.validate(
										{

											rules : {
												'code.shortName' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'code.longDescription' : {
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 100
												},
												'code.codeType' : {
													required : true,
													min : 1
												},
												'code.parentCode' : {},
												'sortOrder' : {
													range : [ 0, 20 ],
													digits : true
												}

											},
											messages : {
												'code.shortName' : {
													required : "Name is required",
													alphabetsOnly : "Please enter a Valid Name ,No special characters are allowed .",
													minlength : "Enter Short Name with at least {0} characters.",
													maxlength : "Enter Short Name with no more than {0} characters."
												},
												'code.longDescription' : {
													required : "Description is required",
													alphabetsOnly : "Please enter a Valid Description ,No special characters are allowed .",
													minlength : "Enter Description with at least {0} characters.",
													maxlength : "Enter Description with no more than {0} characters."
												},
												'code.codeType' : "Select Code-Type",
												'code.parentCode' : "",
												'sortOrder' : {
													required : "Sort Order is required",
													digits : "Enter Sort Order only digits.",
													range : "Please enter Sort Order between range {0} and {1}."
												}

											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate"
										});
						$("#partyCode").submit();
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

<!--  BUCKET -->
 <c:url value="/mobilefirmadmin/managePartyCodeMobile.do" var="mobileFirmManageCodeUrl"/> 
<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
<a href="<c:out value='${mobileFirmManageCodeUrl}'/>" style="text-decoration:none;">
            <button type="button" id="showCodeform" onclick="showCodeform()"
                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                    role="button" aria-disabled="false" data-inline="true" data-mini="true">
                <span class="ui-button-text">New Code</span>
            </button>
        </a>

</security:authorize>

<body onload="hideCodeform()">
 <div id="divCode">
				<form:form modelAttribute="partyCode" method="POST"
					action="managePartyCodeMobile.do">
					<input type="hidden" name="baseURL" id="baseURL"
						value="managePartyCodeMobile.do" />
					<input type="hidden" name="inValidClientId"
						value="${param.inValidClientId }" />
					<i><b><form:errors path="*" class="errorblock"
								element="div" />
					</b>
					</i>
						<form:hidden path="id" />
						<center> <b><strong>${inValidClientId}</strong> </b> </center> 
				<center> 
					<c:if test="${not empty invalidCode}">
						<b><font color="red"><c:out value="${invalidCode}"/></font></b>
					</c:if>
				</center>
                
                <div data-role="fieldcontain">
                    <form:label path="code.codeType">Type Of Code</form:label>
                   
                   		<form:select path="code.codeType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							<form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                   
                </div>
                
				<div data-role="fieldcontain" >
                    <form:label path="code.shortName">Name</form:label>
                    <form:input path="code.shortName" cssClass="input_full" tabindex="1"/>
                </div>
                  
                 <div data-role="fieldcontain" >
                    <form:label   path="code.longDescription">Description</form:label>
                    <form:input path="code.longDescription" cssClass="input_full" tabindex="2"/>
                </div>
                
                <div data-role="fieldcontain" >
                    <form:label path="code.parentCode">Relative Parent Code</form:label>
                   		<form:select path="code.parentCode" tabindex="4" cssClass="input_full">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                </div>
                  
                <div data-role="fieldcontain" >
                    <form:label path="sortOrder">Sort Order</form:label>
                    <form:input path="sortOrder" cssClass="input_full"  tabindex="5"/>
                </div>
                

<br/>

    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
    
        <button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false" data-inline="true" data-mini="true">
						<c:if test="${partyCode.id == null}">
						<span class="ui-button-text" tabindex="13">Save</span>
						</c:if>
						<c:if test="${partyCode.id != null}">
    	                <span class="ui-button-text" tabindex="12">Update</span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;

        <button type="reset"
                class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                role="button" aria-disabled="false" data-inline="true" data-mini="true">
            <span class="ui-button-text">Cancel</span>
        </button>
         </security:authorize>
         
         <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyCode.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false" data-inline="true" data-mini="true">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false" data-inline="true" data-mini="true">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
          			<button id="hideCodeform" onclick="window.location='managePartyCodeMobile.do';return false;"
	                 class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                 role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                 <span class="ui-button-text">Back</span>
	                 </button>
	                 
				</form:form>
	</div>
</body>
<!-- BUCKET -->
<br/><br/>
<div id="codeListdiv"style="width:300px;"> 
<form:form modelAttribute="partyCode">
<div data-role="fieldcontain">
                    <form:label path="code.codeType">Type Of Code</form:label>
                   
                   		<form:select path="code.codeType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							<form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                   
                </div>
</form:form>

    		<div id="grid_wrapper" class="ml10 mr10 mt20"style="width:300px;">
				<table id="partycodelist"style="width:300px;"></table>
				<div id="partycodepager" class="scroll" style="text-align: center;"></div>
			</div>
</div>

			<script type="text/javascript">
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";
				jQuery(document)
						.ready(
								function() {
									var mygrid = jQuery("#partycodelist")
											.jqGrid(
													{
														datatype : 'local',
														"height":200,
												        "width" :100,
														mtype : 'GET',
														colNames : [
																'ID',
																'Code Name',
																'Code Type Name',
																'Code ParentCode Name',
																'Sort Order',
																'status' ],
														colModel : [
																{
																	name : 'partyCodeId',
																	index : 'partyCodeId',
																	 width: 30
																},
																{
																	name : 'codeShortName',
																	index : 'codeShortName',
																	formatter: 'showlink', formatoptions: {baseLinkUrl: 
																		'managePartyCodeMobile.do',idName:'id'},
																		 width: 30
																},
																{
																	name : 'codeCodeTypeName',
																	index : 'codeCodeTypeName',
																	 width: 30
																},
																
																{
																	name : 'codeParentCodeShortName',
																	index : 'codeParentCodeShortName',
																	 width: 30
																},
																{
																	name : 'sortOrder',
																	index : 'sortOrder',
																	 width: 30
																},
																{
																	name : 'status',
																	index : 'status'
																		,width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
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
															id : "partyCodeId",
															userdata : "userdata"
														},
														pager : jQuery('#partycodepager'),
														rowNum : 10,
														loadonce : true,
														rowList:[10,25,50],
														sortname : 'id',
														sortorder : 'asc',
														viewrecords : true,
														autowidth : false,
														caption : 'Party Code List',
														editurl : '<c:url value="/firmadmin/savePartyCode.do"/>'
													   
													});
									<security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
					                jQuery("#partycodelist").jqGrid('navGrid', '#partycodepager', {
					                 del : true,
					                 add : false,
					                 edit : false,
					                 search : false
					                });
					                </security:authorize>
									 jQuery("#partycodelist")
											.jqGrid(
													'navButtonAdd',
													"#partycodepager",
													{
														caption : "Apply Filter",
														title : "Toggle Search Toolbar",
														buttonicon : 'ui-icon-pin-s',
														onClickButton : function() {
															mygrid[0]
																	.toggleToolbar()
														}
													});
									jQuery("#partycodelist").jqGrid('filterToolbar', {
										stringResult : true,
										searchOnEnter : false
									}); 
									
								});
									
				
				// resize the grid if needed
				 $(window).bind('resize', function() {
					jQuery("#partycodelist").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('resize');
				 
				 $(window).bind('load', function() {
						jQuery("#partycodelist").setGridWidth($('#grid_wrapper').width()-5, true);
						}).trigger('load');	
				 
				 $(window).bind('reload', function() {
					 jQuery("#partycodelist").setGridParam({url:'retriveCodeType.do'}); 
					 jQuery("#partycodelist").trigger("reloadGrid"); 
						}).trigger('reload');	
			</script>
			
</div>

<script type="text/javascript">
    $(document).ready(function() {
    	//alert('Hello Sai');    
    	firmId = ${firm.id};
        $("#code\\.codeType").change(function() {     
            $.get("<c:url value='/firmadmin/getRelativeParentCodeWhereAppFalse.do'/>", { codeTypeId: $(this).val(), firmId:firmId }, function(data) {
                populateDropdown($("#code\\.parentCode"), data);
            });
            
            if ($("#code\\.codeType").val() != -1) {
            	$.get('<c:url value="/firmadmin/retriveCodeType.do"/>',  { codeTypeId: $(this).val(), firmId:firmId }, function(data) {
            		populateGrid(data);
                });
            }
        });
    });
 
    function populateDropdown(select, data) {
    	//$("#list").jqGrid('clearGridData');
    	select.html('');
    	select.append($('<option></option>').val("-1").html("None"));
        $.each(data, function(id, option) {
        	$.each(option, function(id, option) {
        	select.append($('<option></option>').val(option.key).html(option.value));
            
        });
        });       
    }
    function populateGrid(data){
    	$("#partycodelist").jqGrid('clearGridData');
    	//alert("populateGrid is called data= "+ data.rows); //method to populate the grid
    	var rowdata = data.rows;
    	//$("#list").jqGrid('setData', rowdata);
    //	$("#list").trigger("reloadGrid");
    	for (var i = 0; i < rowdata.length; i++) {
    	var code = rowdata[i];
    	$('#partycodelist').jqGrid('addRowData', code.partyCodeId, {
         partyCodeId : code.partyCodeId,
         codeShortName : code.codeShortName,
         codeCodeTypeName: code.codeCodeTypeName,
         codeParentCodeShortName: code.codeParentCodeShortName,
         sortOrder: code.sortOrder,
         status: code.status
    	});
    }
    }
</script>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
<script type="text/javascript">
function hideCodeform(){
	$("#codeListdiv").show();
	$("#divCode").hide();
}

function showCodeform(){
	$("#codeListdiv").hide();
	$("#divCode").show();
}
</script>
