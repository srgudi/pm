<%@page import="com.chiguru.pm.crm.dto.PartyDTO"%>
<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<!-- MAIN CONTENT SECTION -->

<script type="text/javascript">
    $(document).ready(function() {
    $("#save").click(function() {
    	$("#errMsg").text("");
    	var sortType=$("#sType").val();
    	
    	if(sortType==-1){
    		$("#errMsg").text("Please select Partner In Charge.");
    		$("#errMsg").css('color','red');
    		return;
    	}
    	firmid = ${firm.id};
    	finalMeth(firmid);
    	 //var s = document.getElementById("frame");
  	   //s.style.display = "inline";
  	 //var r = document.getElementById("report");
	  // r.style.display = "inline";
    	 if($("#view").val()!="xls" ){
   		  if($("#view").val()!="csv" ){
   			   
   		  $("#report").show();
   	    	//document.getElementById("controls1").style.visibility= "hidden";
   	    	//document.getElementById("content").style.visibility= "hidden";
   	    	$("#controls1").hide();
   	    	$("#content").hide();
   		  }
   	  }
    	
    	//document.getElementById("report").src="../../reports/frameset?__report=barchart.rptdesign";
    	//var url="../../reports/frameset?__report=tasklist.rptdesign&duedate="+document.test.dueDate2.value+"&duedate1="+document.test.dueDate1.value;
    	    	
    	//document.getElementById("report").src="../../reports/frameset?__report=tasklist.rptdesign&duedate="+document.test.dueDate1.value+"&duedate1="+document.test.dueDate2.value+"&firmid="+document.test.firmId.value+"&srt="+document.test.srt.value+"&__format=pdf";
    	//window.location="../../reports/frameset?__report=barchart.rptdesign";
		$("#taskRep").submit();
    	//document.getElementById("report").src="../../reports/frameset?__report=barchart.rptdesign";
    	//var url="../../reports/frameset?__report=taskreportbyfilingtype.rptdesign&dueDate="+document.test.dueDate2.value+"&dueDate1="+document.test.dueDate1.value+"&partnerId="+document.test.partnerId.value+"&firmId="+document.test.firmId.value+"&srt="+document.test.srt.value;
    	//document.getElementById("report").src="../../reports/frameset?__report=clientlistbyinchargeperson.rptdesign&firmid="+firmid+"&partnerid="+document.test.statusid.value+"&__format=pdf";
    	//window.location="../../reports/frameset?__report=barchart.rptdesign";
		//$("#testRep").submit();
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
<div><!--  BUCKET -->
<span id="errMsg"></span>
<div id="mid-col" class="full-col">
	  <div class="error_container">
    	 <h4><b>Please correct the following errors</b></h4>
    	  <ol>		</ol>
	  </div>
<div>
<div style="padding: 0.5em"
	class="ui-widget ui-widget-content ui-widget-header ui-corner-top ui-helper-clearfix">
Client List By Partner</div>

<iframe id="report" name="report" width="100%" height="800">
  
</iframe>
</div>
<script type="text/javascript">
window.onload = function(){
	   //var s = document.getElementById("frame");
	   //s.style.display = "none";
	   //var r = document.getElementById("report");
	   //r.style.display = "none";
	   $("#report").hide();
	   //disablefields();	
	}
	
function disablefields(){	
	//document.getElementById
//('dueDatepicker').disabled = true;
	//document.getElementById
//('datepicker').disabled = true;	
	//document.getElementById
//('region1').disabled = true;
	 $("#dueDatepicker").attr("disabled", "disabled");
	 $("#datepicker").attr("disabled", "disabled");
	 $("#region1").attr("disabled", "disabled");
	
	
}
</script>
<div class="ui-widget ui-widget-content ui-corner-bottom" id="content">

<div>
	<form:form modelAttribute="taskRep" method="POST" action="clientListbyPartnerJasper.do" name="test" target="report">
	<input type="hidden" id="firmid" name="firmid" value="<c:out value='${firm.id}'/>">
	 <input type="hidden" name="clientId" value="1"/>
  <input type="hidden" name="taskId" value="2"/>
<INPUT TYPE="HIDDEN" NAME="ReportName" Value="ClientListByPartnerIncharge.jrxml">	
	<input type="hidden" name="baseURL" id="baseURL" value="clientListbyPartnerJasper.do" /> 	
			<input type="hidden" id="partnerid" name="partnerid" value=" ">
	
	<table class="ui-widget" border="0" id="controls1"
		style="width: 700px; margin-left: 100px; margin-right: 150px;"
		cellspacing="20" cellpadding="2">
		<tbody>		
			
			<tr style="display: none">
				<td>From Date: </td>
				<td><form:input path="dueDate1" id="dueDatepicker" class="input"
					tabindex="5" />
				</td>
				<td>To Date :</td>
				<td> <form:input path="dueDate2" id="datepicker" class="input"
					tabindex="5" /></td>
			</tr>
			 <tr class="odd" >
                  <td class="col-first">Partner In Charge :</td>
                  <td class="col-second">
                  		<form:select path="partnerInCharge" id="sType" tabindex="7"  style="width: 150px">
                  			<form:option value="-1" label="Select" />
							<form:options items="${partnerList}" itemValue="id" itemLabel="name" />	
						</form:select>
                  </td>
                   <td class="col-first" style="vertical-align:top;">&nbsp;</td>
                  <td class="col-second" style="vertical-align:top;">&nbsp;
                 </td>
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

	<table border="0" id="controls" style="width:960px;margin-left:100px;margin-right:150px;" cellspacing="2" cellpadding="2">
		<tbody>
			<tr class="odd">
				<td width="50px;">&nbsp;</td>
				<td width="50px;">&nbsp;</td>
				<td colspan="3">
				<button type="button" id="save"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false"><span
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
<div><!--  GRID PLACEHOLDER Ids -->
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
	//alert(addDays(new Date(),value1));
	var d = addDays(new Date(),value1);
	//alert((d.getMonth()+1)+"/"+d.getDate()+"/"+d.getFullYear());
	var dueDate2=(d.getMonth()+1)+"/"+d.getDate()+"/"+d.getFullYear();
	//alert("Today's Date"+new Date() + "Due Date2 is.. "+dueDate2);
	//alert(document.test.dueDate1.value);
	//alert("Sort Type is "+document.getElementById("sort").value)
	
	document.test.dueDate1.value=dueDate2;
	//alert(document.test.dueDate1.value);
	document.test.firmId.value=1;
	document.test.partnerId.value=2;
	document.test.srt.value=document.getElementById("sort").value;
	//alert(document.test.dueDate1.value+ " "+document.test.firmId.value+" "+document.test.partnerId.value+" "+document.test.srt.value);
}

function finalMeth(firmid){
	
// 		var tempDate1=document.getElementById("dueDatepicker").value;
// 		var tempDate3=document.getElementById("datepicker").value;
// 		document.test.date2.value=tempDate1;
// 		document.test.date1.value=tempDate3;
// 		var d2=new Date(tempDate1);
// 		document.test.firmId.value=firmid;
// 		document.test.statusid.value=document.getElementById("sType").value;
		
		$("#firmid").val(firmid);
		$("#partnerid").val($("#sType").val());
	
}

function addDays(myDate,days) {	
    return new Date(myDate.getTime() + days*24*60*60*1000);
}

</script>
		
		
		</div>
<!--  END BUCKET --></div>



