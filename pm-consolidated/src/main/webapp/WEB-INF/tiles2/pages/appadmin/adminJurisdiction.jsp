<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<!-- MAIN CONTENT SECTION -->

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

<style type="text/css">
.jurisdiction fieldset p.error label {
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

form.jurisdiction {
	width: 30em;
}

form.jurisdiction label.error {
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
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$.validator.addMethod("alphaNumeric", function(value,
								element) {
							return this.optional(element)
									|| /^[A-Z-]+$/i.test(value);
						}, "Please enter valid Number.");

						$.validator
								.addMethod("alphabetsOnly", function(value,
										element) {
									return this.optional(element)
											|| /^[a-zA-Z ]*$/i.test(value);
											/* || /^\s*[a-zA-Z ]+\s*$/i
													.test(value); */
								},
										"No Special characters are allowed. Please enter a valid.");

					});

	// only for demo purposes
	$.validator.setDefaults({
		submitHandler : function(form) {
			form.submit();
		}
	});
	
	
</script>	

<script type="text/javascript">
/* $().ready(function() {
	var editId = $("#id").val();
	//alert("hi"+editId); 
	var editStatus=new Boolean();
	console.log(editId);
	  if (editId != "")
		{
		  editStatus = true;
		} */
	 $("#save").click(function() {
		 //alert("save");
		 var container = $('div.error_container');
						// validate the form when it is submitted
						var validator = $("#jurisdiction")
								.validate(
										{
											rules : {
												'country' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'state' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'county' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'city' : {
													required : true,
													alphabetsOnly : true,
													minlength : 0,
													maxlength : 50
												},
												'timezone' : {
													required : true,
													min : 1
												}
											},
											messages : {
												'country' : {
													required : "Country is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid Country Name.",
													minlength : "Enter Country with at least {0} characters.",
													maxlength : "Enter Country with no more than {0} characters."
												},
												'state' : {
													required : "State is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid State Name.",
													minlength : "Enter State with at least {0} characters.",
													maxlength : "Enter State with no more than {0} characters."
												},
												'county' : {
													required : "County is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid County Name.",
													minlength : "Enter County with at least {0} characters.",
													maxlength : "Enter County with no more than {0} characters."
												},
												'city' : {
													required : "City is required",
													alphabetsOnly :"No Special characters are allowed. Please enter a valid City Name.",
													minlength : "Enter City with at least {0} characters.",
													maxlength : "Enter City with no more than {0} characters."
												},
												'timezone' : "Select Timezone"
											},
											errorContainer : container,
											errorLabelContainer : $("ol",
													container),
											wrapper : 'li',
											meta : "validate",
											submitHandler: function(form) {
										
	                	$.ajax({
			            dataType: 'json',
			            type: 'POST',
		                data: $('#jurisdiction').serialize(),
				        url: 'adminJurisdiction.do',
				        success: function(data) {
			             if(clientId != -1){
		            		$.jGrowl("Record saved successfully");
		        			$('#getJurid').dataTable().fnReloadAjax('jurisdictionsList.do');
		        			if($("#id").val()!=""){
		        				$('#jurihome').show();
	            				 $('#juriTabs a:first').tab('show');
	            				 $('#jurifoo').hide();
	            			}else{
		        				document.getElementById("jurisdiction").reset();
		        			}
		        			
		            	 }else{
		            		 
		            		 $.jGrowl("As Error has happened while process. ");	
		            		 
		            	 } 
			             
			            	 
		            }
	
				});
		 return false;
											}
										});
	 });
	 
	 $("#newJurisdiction").click(function(){
			$('#jurifoo').load('adminJurisdiction.do');
	 });
	 
	 
	 $("#backToList").click(function(){
			$('#list').load('adminJurisdiction.do');
			$('#juridTab a:first').tab('show');
			});

	 
function juriList(){
	$('#juriTabs a:first').tab('show');
	$('#jurihome').show();
	$('#jurifoo').hide();
}

</script>



<div class="well">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<!-- <span class="legend b">Jurisdiction</span> -->
<div class="f13">
		<form:form modelAttribute="jurisdiction">
			<i><b><form:errors path="*" class="errorblock" element="div" /></b></i>
			<input type="hidden" name="clientId" id="clientId" value="${param.clientId }" />
			<input type="hidden" name="baseURL" id="baseURL" value="adminJurisdiction.do" />

			<form:hidden path="id" />

				<div class="container_12 mt20">
				</br>
				</br>
				<div class="row">	
				 <div class="span3">
                    <form:label path="country"><spring:message code="label.country"/></form:label>
                    <form:input path="country" cssClass="formInput" tabindex="1"/>
                 </div>
                 <div class="span3">
                    <form:label   path="state"><spring:message code="label.state/province"/></form:label>
                    <form:input path="state" cssClass="formInput" tabindex="2"/>
                </div>
                 <div class="span3">
                    <div class="grid_2 right"><form:label   path="city"><spring:message code="label.city"/></form:label></div>
                    <div class="grid_3 right"><form:input path="city" cssClass="formInput" tabindex="4"/></div>
                </div>   
                </div>
                <div class="row">
				<div class="span3">
                    <form:label path="county"><spring:message code="label.county"/></form:label>
                    <form:input path="county" cssClass="formInput" tabindex="3"/>
                </div>
                <div class="span3">
                 	<form:label path="timezone"><spring:message code="label.timeZone"/></form:label>
                   		<form:select path="timezone" cssClass="formSelect" tabindex="5">
							<form:option value="-1" label="Select" />
							<form:options items="${timezoneSet}" itemValue="id" itemLabel="globalTimezoneName" />
						</form:select>
                </div>
             
                   <div class="span3" >
                   <form:label   path="activeFlag"><spring:message code="label.status"/></form:label>
                   <div class="row-fluid">
                   		<div class="span5">
							<form:label path="activeFlag"><form:radiobutton path="activeFlag"  value="true" style="width: 30px;" />Active</form:label>
						</div>
						<div class="span5">	
					        <form:label path="activeFlag"><form:radiobutton path="activeFlag"  value="false"  style="width: 30px;" tabindex="7" />InActive</form:label>
					    </div>    
				   </div>	         
                 </div> 
   
						
					</div>
					</br>
              
				<div class="row">
                 <div class="span">
					
						<%-- <button type="button" id="newJurisdiction" class="btn btn-primary">
							<span class="ui-button-text" tabindex="8"><spring:message code="label.newJurisdiction"/></span>
						</button> &nbsp;&nbsp; --%>

					<button  id="save" class="btn btn-success">
						<c:if test="${jurisdiction.id == null}">
						<span class="ui-button-text" tabindex="9"><spring:message code="label.save"/></span>
						</c:if>
						<c:if test="${jurisdiction.id != null}">
    	                <span class="ui-button-text" tabindex="9"><spring:message code="label.update"/></span>
    	                </c:if>
					</button>
					&nbsp;&nbsp;

					<%-- <button type="reset" class="btn btn-success">
						<span class="ui-button-text"tabindex="10"><spring:message code="label.cancel"/></span>
					</button> --%>
					
						&nbsp;&nbsp;
        	          
	                    	<button type="button" id="backToList" onclick="juriList()"
	                        	    class="btn btn-success">
	                        	<span class="ui-button-text">Back To List</span>
	                    	</button>
	                  
				</div>
			</div>
			</div>
		</form:form>
</div>
	</div>
</div>
<!-- BUCKET -->
<!-- <div class="fieldset mt25 ml20 mr20">
<span class="legend b">Jurisdiction List</span> -->
    <!--  GRID PLACEHOLDER Ids -->
    		<!-- <div id="grid_wrapper" class="ml10 mr10 mt20">
				<table id="toolbar"></table>
				<div id="ptoolbar" class="scroll"></div>
			</div>
			<script type="text/javascript">
		
		jQuery(document).ready(function(){
			var firmId = $("#firmId").val();
			var clientId = $("#clientId").val();
			var status = ["All", "Active", "Inactive"];
			var statusStr = ":All;Active:Active;Inactive:Inactive";

			var mygrid = jQuery("#toolbar").jqGrid({
			   	url:'<c:url value="../tax/jurisdictionsList.do"/>?firmId='+firmId,
				 datatype: "json",
				  
					height : 300,
				 mtype: 'GET', 
				
				 colNames:['ID','Country', 'State/Province', 'City', 'Global Timezone Name','GMT Deviation Hours', 'Status'],
				   	colModel:[
				   		{name:'id',index:'id', width:20, editoptions:{readonly:true, size:10}},
				   		{name:'country',index:'country', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'state',index:'state', width:100,formatter: 'showlink', formatoptions: {baseLinkUrl: 'adminJurisdiction.do', 
								idName:'id'}},
				   		{name:'city',index:'city', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'globalTimezoneName',index:'globalTimezoneName', width:130, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'gmtDeviationHours',index:'gmtDeviationHours', width:100, editrules:{required:true}, editable: true,editoptions:{size:25}},
				   		{name:'status',index:'status', width:40, editrules:{required:true}, editable: true,edittype:"checkbox",editoptions:{value:"Active:Inactive"},
				   		 	formatter:'select', stype: 'select', sorttype:
				   		 	function(cell) {return status[cell];},
				   		 edittype:'select', editoptions: { value: statusStr }, 
				   		searchoptions:{ sopt:['eq'] }},
				   	],
				   	jsonReader : {
			            root: "rows",
			            page: "page",
			            total: "total",
			            records: "records",  
			            repeatitems: false,
			            cell: "cell",
			            id: "id",
			            userdata: "userdata"  
			      },
			      gridComplete: function(){
			  		var ids = jQuery("#toolbar").jqGrid('getDataIDs');
			  		for(var i=0;i < ids.length;i++){
			  			var cl = ids[i];
			  			var closeJs = "setJurisdictionAndClose("+ cl+ ");";
			  			be = "<input style='height:22px;width:100px;' type='button' value='Select' onclick="+closeJs+"  />"; 
			  			jQuery("#toolbar").jqGrid('setRowData',ids[i],{act:be});
			  		}	
			  	},
			      	rowNum:10,
				   	rowList:[10,20,30],
					loadonce:true,
				   	mtype: "GET",
					rownumbers: false,
					rownumWidth: 40,
					gridview: true,
				   	pager: '#ptoolbar',
				   	sortname: 'country',
				    viewrecords: true,
				    sortorder: "asc",
				    caption: 'Jurisdictions List',
				    editurl:'<c:url value="/appadmin/saveJurisdictions.do"/>'
				});

			jQuery("#toolbar").jqGrid('navGrid','#ptoolbar',{del:true,add:false,edit:false,search:false});
			jQuery("#toolbar").jqGrid('navButtonAdd',
					"#ptoolbar", {
						caption : "Apply Filter",
						title : "Toggle Search Toolbar",
						buttonicon : 'ui-icon-pin-s',
						onClickButton : function() {
							mygrid[0].toggleToolbar();
						}
					});
			jQuery("#toolbar").jqGrid('filterToolbar', {
				stringResult : true,
				searchOnEnter : false
			});
				
		});
		
		 // resize the grid if needed
				 $(window).bind('resize', function() {
					jQuery("#toolbar").setGridWidth($('#grid_wrapper').width()-5, true);
					}).trigger('resize');
				 
				 $(window).bind('load', function() {
						jQuery("#toolbar").setGridWidth($('#grid_wrapper').width()-5, true);
						}).trigger('load');		
		
		</script>

		</div>
		 END BUCKET

	</div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
  -->