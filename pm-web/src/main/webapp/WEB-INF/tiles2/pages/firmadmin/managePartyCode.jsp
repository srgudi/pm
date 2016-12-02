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
<div class="ml20 mr20 mt10">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<span class="legend b">Code</span>
<div class="f13">
				<form:form modelAttribute="partyCode" method="POST"
					action="managePartyCode.do">
					<input type="hidden" name="baseURL" id="baseURL"
						value="managePartyCode.do" />
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
                
                <div class="container_12 mt20">
                    <div class="grid_2 right"><form:label path="code.codeType">Type Of Code</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="code.codeType" cssClass="input_full" tabindex="1">
							<form:option value="-1" label="Select" />
							<form:options items="${codeTypeSet}" itemValue="id" itemLabel="name" />
						</form:select>
                    </div>
                </div>
                
				<div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="code.shortName">Name</form:label></div>
                    <div class="grid_3 right"><form:input path="code.shortName" cssClass="input_full" tabindex="1"/></div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label   path="code.longDescription">Description</form:label></div>
                    <div class="grid_3 right"><form:input path="code.longDescription" cssClass="input_full" tabindex="2"/></div>
                </div>
                
                <div class="container_12 pt5">
                    <div class="grid_2 right"><form:label path="code.parentCode">Relative Parent Code</form:label></div>
                    <div class="grid_3 right">
                   		<form:select path="code.parentCode" tabindex="4" cssClass="input_full">
							<form:option value="-1" label="Select" />
							<form:options items="${parentCodeSet}" itemValue="id" itemLabel="shortName" />
						</form:select>
                    </div>
                    <div class="s1"></div>
                    <div class="grid_2 right"><form:label path="sortOrder">Sort Order</form:label></div>
                    <div class="grid_3 right"><form:input path="sortOrder" cssClass="input_full"  tabindex="5"/></div>
                </div>
                
<div class="container_12" style="margin:10px;"></div>

<div class="container_12">
    <div class="grid_3">&nbsp;</div>
    <div class="grid_8">
    <security:authorize access="hasAnyRole('ROLE_FIRM_ADMIN','ROLE_APP_ADMIN')">
        <a href="managePartyCode.do"
           style="text-decoration: none;">
            <button type="button" id="refesh"
             onclick="window.location='managePartyCode.do';return false;"
                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                    role="button" aria-disabled="false">
                <span class="ui-button-text">New Code</span>
            </button>
        </a>
    
        <button type="button" id="save"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
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
                role="button" aria-disabled="false">
            <span class="ui-button-text">Cancel</span>
        </button>
         </security:authorize>
         
         <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_PARTNER')">
            		<c:if test="${partyCode.id != null}">
		                	<button type="button" id="save"
								class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16">Update</span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text">Cancel</span>
		                    </button>
	            	</c:if>
            	</security:authorize>
            </div>
          </div>
				</form:form>
		</div>
	</div>
</div>

<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Party Code List</span>
    <!--  GRID PLACEHOLDER Ids -->
    		<div id="grid_wrapper" class="ml10 mr10 mt20">
				<table id="list"></table>
				<div id="pager" class="scroll" style="text-align: center;"></div>
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
																'ID',
																'Code Name',
																'Code Type Name',
																'Code ParentCode Name',
																'Sort Order',
																'status' ],
														colModel : [
																{
																	name : 'partyCodeId',
																	index : 'partyCodeId'
																},
																{
																	name : 'codeShortName',
																	index : 'codeShortName',
																	formatter: 'showlink', formatoptions: {baseLinkUrl: 
																		'<c:url value="/firmadmin/managePartyCode.do"/>',idName:'id'}
																},
																{
																	name : 'codeCodeTypeName',
																	index : 'codeCodeTypeName'
																},
																
																{
																	name : 'codeParentCodeShortName',
																	index : 'codeParentCodeShortName'
																},
																{
																	name : 'sortOrder',
																	index : 'sortOrder'
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
														pager : jQuery('#pager'),
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
					                jQuery("#list").jqGrid('navGrid', '#pager', {
					                 del : true,
					                 add : false,
					                 edit : false,
					                 search : false
					                });
					                </security:authorize>
									 jQuery("#list")
											.jqGrid(
													'navButtonAdd',
													"#pager",
													{
														caption : "Apply Filter",
														title : "Toggle Search Toolbar",
														buttonicon : 'ui-icon-pin-s',
														onClickButton : function() {
															mygrid[0]
																	.toggleToolbar()
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
					 jQuery("#list").setGridParam({url:'retriveCodeType.do'}); 
					 jQuery("#list").trigger("reloadGrid"); 
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
            	$.get('<c:url value="retriveCodeType.do"/>',  { codeTypeId: $(this).val(), firmId:firmId }, function(data) {
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
    	$("#list").jqGrid('clearGridData');
    	//alert("populateGrid is called data= "+ data.rows); //method to populate the grid
    	var rowdata = data.rows;
    	//$("#list").jqGrid('setData', rowdata);
    //	$("#list").trigger("reloadGrid");
    	for (var i = 0; i < rowdata.length; i++) {
    	var code = rowdata[i];
    	$('#list').jqGrid('addRowData', code.partyCodeId, {
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
 

