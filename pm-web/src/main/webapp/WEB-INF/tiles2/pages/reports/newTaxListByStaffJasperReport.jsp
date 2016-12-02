<%@page import="com.chiguru.pm.crm.dto.PartyDTO"%>
<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<!-- MAIN CONTENT SECTION -->

<script type="text/javascript">
    $(document).ready(function() {
    $("#save").click(function() {
    	$("#errMsg").text("");
    	var sortType=$("#sort").val();
    	
    	if(sortType==-1){
    		$("#errMsg").text("Please select Sort Type");
    		$("#errMsg").css('color','red');
    		return;
    	}
    	firmid = ${firm.id};
    	$("#firmid").val(firmid);
    	var type=$("#sort").val();
    	//alert(type);
    	//finalMeth(firmid);
    	if($("#view").val()!="xls" ){
    		  if($("#view").val()!="csv" ){
    			   
    		  $("#report").show();
    	    	//document.getElementById("controls1").style.visibility= "hidden";
    	    	//document.getElementById("content").style.visibility= "hidden";
    	    	$("#controls1").hide();
    	    	$("#content").hide();
    		  }
    	  }
    	//var type=document.getElementById("sort").value;
    	
    	/*if(type==0){
    		document.getElementById("report").src="../../reports/frameset?__report=newtaxbystaff.rptdesign&firmId="+firmid+"&__format=pdf";
    	}else{
    		document.getElementById("report").src="../../reports/frameset?__report=newtaxbypartner.rptdesign&firmId="+firmid+"&__format=pdf";
    	}*/
    	if(type==0){
    		$("#ReportName").val("newtaxbystaff.rptdesign");
    	}else{
    		$("#ReportName").val("newtaxbypartner.rptdesign");
    	}
    	//document.getElementById("report").src="../../reports/frameset?__report=barchart.rptdesign";
    	//var url="../../reports/frameset?__report=clientlistbyfirmid.rptdesign&dueDate="+document.test.dueDate2.value+"&dueDate1="+document.test.dueDate1.value+"&partnerId="+document.test.partnerId.value+"&firmId="+document.test.firmId.value+"&srt="+document.test.srt.value;
    	
    	
    	//window.location="../../reports/frameset?__report=barchart.rptdesign";
		$("#taskRep").submit();
	});
    });
 
</script>
<style type="text/css">
		.account fieldset p.error label { color: red; }
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
			div.error_container { display: none }
			.error_container label.error {
				display: inline;
			}
			form.account { width: 30em; }
			form.account label.error {
				display: block;
				margin-left: 1em;
				width: auto;
			}

			input:focus { border: 1px dotted black; }
			select:focus { border: 1px dotted black; }
			input.error { border: 2px solid red; }
			select.error {border: 2px solid red;}
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
.errorblock{
	color: #000;
	background-color: #ffEEEE;
	border: 2px solid red;
	margin: 5px;
	padding: 5px;
	width: auto;
}
</style>
<div id="yui-main"><!--  BUCKET -->
<span id="errMsg"></span>
<div id="mid-col" class="full-col">
	  <div class="error_container">
    	 <h4><b>Please correct the following errors</b></h4>
    	  <ol>		</ol>
	  </div>
<div class="yui-g">
<div style="padding: 0.5em"
	class="ui-widget ui-widget-content ui-widget-header ui-corner-top ui-helper-clearfix">
Work Load Summary Report </div>

<iframe id="report" name="report" width="100%" height="800">
  
</iframe>

</div>
<script type="text/javascript">
window.onload = function(){
	 $("#report").hide();
	   
	}

</script>
<div class="ui-widget ui-widget-content ui-corner-bottom" id="content">

<div class="yui-g" >
	<form:form modelAttribute="taskRep" method="POST" action="newTaxListByStaffJasperReport.do" name="test" target="report">
	<input type="hidden" id="firmid" name="firmid" value="<c:out value='${firm.id}'/>">
	 <input type="hidden" name="clientId" value="1"/>
  <input type="hidden" name="taskId" value="2"/>
	<input type="hidden" name="baseURL" id="baseURL" value="newTaxListByStaffJasperReport.do" />
	<INPUT TYPE="HIDDEN" id="ReportName" NAME="ReportName" Value="taskbyemployee.rptdesign"> 	
				 
	
	<table class="ui-widget" border="0" id="controls1"
		style="width: 700px; margin-left: 100px; margin-right: 150px;"
		cellspacing="20" cellpadding="2">
		<tbody>		
		
			 <tr class="odd" style="display: none;">
                  <td class="col-first">Firm :</td>
                  <td class="col-second">
                  		<form:select path="firmList" id="partner" tabindex="7"  style="width: 150px">
                  			<form:option value="-1" label="Select" />
							<form:options items="${orglist}" itemValue="id" itemLabel="legalName" />	
						</form:select>
                  </td>
                   <td class="col-first" style="vertical-align:top;">&nbsp;</td>
                  <td class="col-second" style="vertical-align:top;">&nbsp;
                 </td>
                 </tr>
			<tr>
				<td>In Charge Type:</td>
				<td>
				<form:select path="InCharge" id="sort" tabindex="3" width="150" style="width: 150px">
					<form:option value="-1" label="Select" />
					<form:option value="staff">Staff In Charge</form:option>
					<form:option value="partner">Partner In Charge</form:option>					
				</form:select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>View As:</td>
				<td>
				<form:select path="viewAs" id="view" tabindex="4" width="150" style="width: 150px">					
					<%-- <form:option value="html">HTML Format</form:option> --%>
					<form:option value="xls">Excel Format</form:option>
					<form:option value="pdf">PDF Format</form:option>
					<%--<form:option value="csv">CVS Format</form:option>--%>
				</form:select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</tbody>

	</table>
	<br />
	<br />

	<table border="0" id="controls" style="width:960px;margin-left:100px;margin-right:150px;">
		<tbody>
			<tr class="odd">
				<td width="50px;">&nbsp;</td>
				<td width="50px;">&nbsp;</td>
				<td colspan="3">
				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false" ><span
					class="ui-button-text">Generate Report</span></button>
				&nbsp;&nbsp;

				<button type="reset"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false"><span
					class="ui-button-text">Cancel</span></button>
                &nbsp;&nbsp;

                    <a href="../reports/index.do" style="text-decoration:none;">
	                    	<button type="button" id="newreport"
	                    	onclick="window.location='../reports/index.do';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Back To Reports</span>
	                    	</button>
	                </a>
				</td>
			</tr>
			<tr>
				<tr><td><br/><br/></td></tr>
		</tbody>
	</table>
	
	<br />
	
</form:form></div>
</div>

<br />
<!-- BUCKET -->
<div class="yui-g"><!--  GRID PLACEHOLDER Ids -->
<table id="list" style="margin: 10px;"></table>
<div id="pager" class="scroll" style="text-align: center;"></div>



<script type="text/javascript" charset="utf-8">
function HideOrShowStuff(controlToHide)
{
    /*if (document.getElementById)
    {
         document.getElementById('region1').style.display = 'none';
        document.getElementById('region2').style.display = 'none';
        document.getElementById('region3').style.display = 'none';

        document.getElementById
            ('region' + controlToHide).style.display = 'block';
        document.getElementById
            ('region' + controlToHide).disabled = false;
    }
    else
    {
        alert('Sorry, your browser doesn\'t support this');
    }*/
    if(controlToHide==1){
    	document.getElementById
        ('region' + controlToHide).disabled = false;
    	document.getElementById
        ('dueDatepicker').disabled = true;
    	document.getElementById
        ('datepicker').disabled = true;
    	
    }else{
    	document.getElementById
        ('region1').disabled = true;
    	document.getElementById
        ('dueDatepicker').disabled = false;
    	document.getElementById
        ('datepicker').disabled = false;
    }
}
function hello(){
	var value1=document.getElementById("region1").value;
	
	var d = addDays(new Date(),value1);
	var dueDate2=(d.getMonth()+1)+"/"+d.getDate()+"/"+d.getFullYear();
	
	document.test.dueDate1.value=dueDate2;
	document.test.firmId.value=1;
	document.test.partnerId.value=2;
	document.test.srt.value=document.getElementById("sort").value;
}

function finalMeth(firmid){
	
		
		document.test.firmId.value=document.getElementById('partner').value;
		document.test.partnerId.value=document.getElementById('partner').value;
		document.test.srt.value=document.getElementById("sort").value;
		
	
	
}

function addDays(myDate,days) {	
    return new Date(myDate.getTime() + days*24*60*60*1000);
}

</script>
		
		
		</div>
<!--  END BUCKET --></div>
<!-- END yui-main-->


