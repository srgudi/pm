<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ page isELIgnored="false" %>
 <%! int fontSize = 31; %>
<%--  <%! int month = 1; %> --%>
 <%! int month = 1;%>
 <%! java.util.Date d = new java.util.Date(); %>
 <%! java.util.Calendar c = java.util.Calendar.getInstance(); %>
 <% c.setTime(d); %>
 <%! int year = c.get(java.util.Calendar.YEAR); %>
 <% if (month == 3 | month == 5 | month == 8 | month == 10) { fontSize = 30;} else { fontSize = 31; } %>
 <% if (month == 1) { fontSize = (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 ); } %>
<script type="text/javascript">
    $(document).ready(function() {
        /* $("#save").click(function() {
         $("#clientPracticeInfo").submit();
         }); */


        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name.");
    });

    $(document).ready(function() {
        $("#dialog").dialog({
            autoOpen: false,
            modal: true,
            width: 620,
            height: 300,
            modal: true,
            resizable: false,
            zIndex: 100
        });

    });

    function openDialog(title, text) {
        $("#dialog").html(text).dialog('option', 'title', title).dialog('open');
    }

    function openDialog() {
        $("#dialog").dialog('open');
    }
    function setJurisdictionAndClose(value) {
        //alert("Jurisdiction value1:"+ $("#jurisdiction").val());
        $("#jurisdiction").val(value);
        //alert("Jurisdiction value2:"+ $("#jurisdiction").val());
        $("#dialog").dialog('close');
    }
    
</script>
<style type="text/css">
    .clientPracticeInfo fieldset p.error label {
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

    form.clientPracticeInfo {
        width: 30em;
    }

    form.clientPracticeInfo label.error {
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

 <script language = "Javascript">
var separator= "/";
var minYear=1900;
var maxYear=2500;

function isInteger(s){
var i;
for (i = 0; i < s.length; i++){ 
// Check that current character is a number or not.
var c = s.charAt(i);
if (((c < "0") || (c > "9"))) return false;
}
// All characters are numbers.
return true;
}

function stripCharsInBag(s, bag){
var i;
var returnString = "";
// Search through string's characters one by one.
// If character is not in bag, append to returnString.
for (i = 0; i < s.length; i++){ 
var c = s.charAt(i);
if (bag.indexOf(c) == -1) returnString += c;
}
return returnString;
}

function daysInFebruary (year){
// February has 29 days in any year evenly divisible by four,
// EXCEPT for centurial years which are not also divisible by 400.
return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
for (var i = 1; i <= n; i++) {
this[i] = 31;
if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
if (i==2) {this[i] = 29;}
} 
return this;
}

function isDate(dtStr){
var daysInMonth = DaysArray(12);
var pos1=dtStr.indexOf(separator);
var pos2=dtStr.indexOf(separator,pos1+1);
var strMonth=dtStr.substring(0,pos1);
pos1 = pos1 + 1;
var strDay=dtStr.substring(pos1,pos2);
var strYear=dtStr.substring(pos2+1);
strYr=strYear;
strDay=strDay.substring(1);
strMonth=strMonth.substring(1);
for (var i = 1; i <= 3; i++) {
if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
}
month=parseInt(strMonth);
day=parseInt(strDay);
year=parseInt(strYr);
if (pos1==-1 || pos2==-1){
$.jGrowl('The date format should be : MM/DD/YYYY');
return false;
} 
if (strMonth.length<1 || month<1 || month>12){
$.jGrowl('Please enter a valid month');
return false;
}
if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
$.jGrowl('Please enter a valid day');
return false;
}
if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
$.jGrowl('Please enter a valid 4 digit year between '+minYear+' and'+maxYear);
return false;
}
if (dtStr.indexOf(separator,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, separator))==false){
$.jGrowl('Please enter a valid date');
return false;
}
/* $.jGrowl('Entered date is valid');
return true; */
}

function ValidateDate(txtDate){

if (isDate(txtDate)==false){
return 1;
}
return 2;
}
</script>

<script type="text/javascript">
 

$.validator.setDefaults({
    submitHandler: function(form) {
        form.submit();
    }
});

    $().ready(function() {
    	var editId = $("#id").val();
    	//alert("hi"+editId); 
    	var editStatus=new Boolean();
    	console.log(editId);
    	  if (editId != "")
    		{
    		  editStatus = true;
    		}
        $("#save").click(function() {
            var container = $('div.error_container');
            var validator = $("#clientPracticeInfo").validate({
                rules: {
                    'jurisdiction': {required: true,min:1},
                    'Filing Reminders': {min:1},
                    'staffInCharge': {required: true,min:1},
                    'filingFrequency': {required: true,min:1},
                    'instalmentFrequency': {required: true,min:1},
                    'clientStaffInCharge': {required: true,min:1},
                    'partnerInCharge': {required: true,min:1},
                    'preparerNotes':{required: true,minlength: 0, maxlength: 2000},
                    'filingDueDateRules0.dueMonth': {required: true, min:0},
    				'filingDueDateRules0.dueDay': {required: true, min:1},
    				'filingDueDateRules[1].dueMonth': {required: true, min:0},
    				'filingDueDateRules[1].dueDay': {required: true, min:1},
    				'filingDueDateRules[2].dueMonth': {required: true, min:0},
    				'filingDueDateRules[2].dueDay': {required: true, min:1},
    				'filingDueDateRules[3].dueMonth': {required: true, min:0},
    				'filingDueDateRules[3].dueDay': {required: true, min:1},
    				'installmentDueDateRules0.dueMonth': {required: true, min:0},
    				'installmentDueDateRules0.dueDay': {required: true, min:1},
    				'installmentDueDateRules[1].dueMonth': {required: true, min:0},
    				'installmentDueDateRules[1].dueDay': {required: true, min:1},
    				'installmentDueDateRules[2].dueMonth': {required: true, min:0},
    				'installmentDueDateRules[2].dueDay': {required: true, min:1},
    				'installmentDueDateRules[3].dueMonth': {required: true, min:0},
    				'installmentDueDateRules[3].dueDay': {required: true, min:1}	
                },
                messages: {
                    'jurisdiction': "Select one Jurisdiction",
                    'Filing Reminders': "Select one Filing Reminder",
                    'staffInCharge': "Select one Staff In charge",
                    'filingFrequency': "Select one Filing Frequency",
                    'instalmentFrequency': "Select one Installment Frequency",
                    'clientStaffInCharge': "Select one Client Staff In-charge",
                    'partnerInCharge': "Select one Partner In charge",
                    'filingDueDateRules[0].dueMonth': "Select a month in 1st Due Month under Filing Frequency",
            		'filingDueDateRules[0].dueDay': "Select a day in 1st Due Day under Filing Frequency",
            		'filingDueDateRules[1].dueMonth': "Select a month in 2nd Due Month under Filing Frequency",
            		'filingDueDateRules[1].dueDay': "Select a day in 2nd Due Day under Filing Frequency",
            		'filingDueDateRules[2].dueMonth': "Select a month in 3rd Due Month under Filing Frequency",
            		'filingDueDateRules[2].dueDay': "Select a day in 3rd Due Day under Filing Frequency",
            		'filingDueDateRules[3].dueMonth': "Select a month in 4th Due Month under Filing Frequency",
            		'filingDueDateRules[3].dueDay': "Select a day in 4th Due Day under Filing Frequency",
            		'installmentDueDateRules[0].dueMonth': "Select a month in 1st Due Month under Installment Frequency",
            		'installmentDueDateRules[0].dueDay': "Select a day in 1st Due Day under Installment Frequency",
            		'installmentDueDateRules[1].dueMonth': "Select a month in 2nd Due Month under Installment Frequency",
            		'installmentDueDateRules[1].dueDay': "Select a day in 2nd Due Day under Installment Frequency",
            		'installmentDueDateRules[2].dueMonth': "Select a month in 3rd Due Month under Installment Frequency",
            		'installmentDueDateRules[2].dueDay': "Select a day in 3rd Due Day under Installment Frequency",
            		'installmentDueDateRules[3].dueMonth': "Select a month in 4th Due Month under Installment Frequency",
            		'installmentDueDateRules[3].dueDay': "Select a day in 4th Due Day under Installment Frequency",
                    'preparerNotes':{
                        required: "Preparer Notes is required",
                        alphabetsOnly: "No Special Character allowed. Please enter a valid Preparer Notes.",
                        minlength: "Enter Preparer Notes with at least {0} characters.",
                        maxlength: "Enter Preparer Notes with no more than {0} characters."
                        }
                },

                errorContainer: container,
                errorLabelContainer: $("ol", container),
                wrapper: 'li',
                meta: "validate",
                submitHandler: function(form) {
                	//alert("savin");
                	$.ajax({
		            dataType: 'json',
		            type: 'POST',
	                data: $('#clientPracticeInfo').serialize(),
			        url: 'taxModule.do',
			        success: function(firmPracticeId) {
			        	var clientNewId = ${clientId};
			    		var firmPracticeNewId = ${firmPracticeId};
			              	if(firmPracticeNewId != -1){
		            		$.jGrowl("Record saved successfully");
		            		
            				$('#getTaxList').dataTable().fnReloadAjax('taxModuleList.do?clientId=' + clientNewId + '&firmPracticeId=' + firmPracticeNewId);
            				
            				if($("#id").val()!=""){
	            				 $('#list').show();
	            				 $('#mainTaxTabs a:first').tab('show');
	            				 $('#update').hide();
	            			}else{
	            				$('#update').load('taxModule.do');
	            			}
		            		}
		            	 else{
		            		 $.jGrowl("As Error has happened while process. ");	
		            	 } 
		            }
	
			});
	 return false;
				}
            });
            
            var currentTime = new Date();
            var month11 = document.getElementById("filingDueDateRules0.dueMonth");
            var month1=month11.value;
            var date11=document.getElementById("filingDueDateRules0.dueDay");
            var date1 = date11.value;
            var year1 = currentTime.getFullYear();
            var conclude=null;
            
            if(month1 == -1 && $("date1").val() != -1){
            	var month2 = currentTime.getMonth();
            	month1 = month2;
            }
            
            if (month1 != -1 && $("date1").val() != -1) {
            	var numZeropad = ++month1; 
            	var monthLength = $("month1").length;
            	var dayLength = $("date1").length;
            	
            if(monthLength < 1) {
                            	numZeropad = '0' + numZeropad;
            }
            if(dayLength < 1) {
            	date1 = '0' + date1;
              }
            var  txtDate = numZeropad+"/"+date1+"/"+year1;
            var conclude= ValidateDate(txtDate); 
             }
            if(conclude==2){
              $("#clientPracticeInfo").submit();
            }
        });

        /* $("#cancel").click(function() {
            $("#cboxClose").click();
            return false;
        }); */
        
        $("#newTax").click(function(){
        	//alert("new");
			$('#update').load('taxModule.do');
        	//$("#cbox").removeData('colorbox');
			});
    });
</script>

<div class="well">
<!--  BUCKET -->

<div id="dialog" title="Choose Jurisdiction">
    <div class="box">
        <div class="box-container">
            <table id="toolbar"></table>
            <div id="ptoolbar" class="scroll" style="text-align:center;"></div>
        </div>
    </div>
</div>

<div class="error_container">
    <h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<div class="fieldset">
<div class="f13">
<form:form modelAttribute="clientPracticeInfo" method="POST" action="">
<input type="hidden" name="clientId" id="clientId" value="${clientId}"/>
<%-- <input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${firmPracticeId}"/> --%>
<input type="hidden" name="baseURL" id="baseURL" value="taxModule.do"/>
<input type="hidden" name="inValidClientId" value="${param.inValidClientId}"/>
<input type="hidden" name="month1" value="${param.inValidClientId}"/>

<b><strong>${inValidClientId}</strong></b>
<form:hidden path="id"/>

<div class="container_12 mt20">
<div class="row">	
<div class="span3">
    <form:label path="jurisdiction"><spring:message code="label.jurisdiction"/></form:label>
        <form:select path="jurisdiction" cssClass="formSelect" tabindex="1">
            <form:option value="-1" label="Select"/>
            <form:options items="${jurisdictionList}" itemValue="id" itemLabel="name"/>
        </form:select>
</div>
    <!-- <a href="#" id="manage_bank" class="ui-widget" onclick="openDialog();return false;" style="text-decoration:none;">
        <button type="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                role="button" aria-disabled="false">
            <span class="ui-button-text">Manage</span>
        </button>
    </a> -->

<div class="span3">
  <form:label path="firmPracticeType.id"><spring:message code="label.taxType"/></form:label>
       <c:choose>
       <c:when test="${clientPracticeInfo.id != null}">
        <form:select path="firmPracticeType.id" cssClass="formSelect" tabindex="1" readonly="true" disabled="true">
        <form:option value="-1" label="Select"/>
            <form:options items="${taxModules}" itemValue="id" itemLabel="taxApplicationPracticeType.name"/>
        </form:select>
          </c:when>
            <c:otherwise>
              <form:select path="firmPracticeType.id" cssClass="formSelect" tabindex="1">
            <form:option value="-1" label="Select"/>
            <form:options items="${taxModules}" itemValue="id" itemLabel="taxApplicationPracticeType.name"/>
        </form:select>
          </c:otherwise> 
          </c:choose>
</div>
<div class="span3">
</div>
</div>


<div class="row">
<div class="span3">
    <form:label path="filingFrequency"><spring:message code="label.filingFrequency"/></form:label>
    
        <form:select path="filingFrequency" id="filingFreqField" tabindex="1" cssClass="formSelect" onChange="modify()">
            <form:option value="-1" label="Select"/>
            <form:options items="${filingFrequency}" itemValue="id" itemLabel="shortName"/>
        </form:select>
         <c:set value="${filingDueDateRules0.dueMonth}" var="month1"></c:set>  
   </div>
   <div class="filing_month_date">
    <c:forEach items="${clientPracticeInfo.filingDueDateRules}" var="dateRule" varStatus="cStatus">
<div class="span3">
  
        <form:label path="filingDueDateRules[${cStatus.index}].dueMonth"><div class="filing_due_month_label"><spring:message code="label.dueMonth"/></div></form:label>
        
	            <form:select path="filingDueDateRules[${cStatus.index}].dueMonth" title="filingMonthField" tabindex="3" cssClass="formSelect" name="filingMonthField">
	                 <form:option value="-1" label="Select"/> 
	                <form:options items="${monthList}" itemValue="value" itemLabel="key"/>
	            </form:select>
       
       
</div>
<div class="span3">
        <form:label path="filingDueDateRules[${cStatus.index}].dueDay"><div class="filing_due_day_label"><spring:message code="label.duedate"/></div></form:label>
       
	            <form:select path="filingDueDateRules[${cStatus.index}].dueDay" title="filingDayField" tabindex="4" cssClass="formSelect" name = "filingDayField">
	                <form:option value="-1" label="Select"/> 
	           		<!-- <form name="frm" method="post" onSubmit="return ValidateDate()"> -->
	               <%--  <c:forEach var="i" begin="1" end="<%= fontSize %>" step="1"> --%>
	                <c:forEach var="i" begin="1" end="31" step="1">
	                    <form:option value="${i}" label="${i}"/>
	                </c:forEach>
	                <form:option value="-100" label="Last Day"/>  
	            </form:select> 
               
        
         <form:hidden path="filingDueDateRules[${cStatus.index}].id" class="filingDateId"/>
  </div> 
</div>
 </c:forEach>
   </div>
<div class="row">
<div class="span3">
<form:label path="filingDateReminder"><spring:message code="label.filingReminders"/></form:label>
     
            <form:select path="filingDateReminder" id="filingDateReminderField" tabindex="1" cssClass="formSelect">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>

</div>
<c:if test="${! clientPracticeInfo.filingDateReminder}">
        <c:set var="filing_reminder_display" value="display:none"/>
</c:if>
<div class="span3">
<div class="reminder_days_row" style="<c:out value='${filing_reminder_display}'/>">
	       <form:label path="filingDateReminder"><spring:message code="label.remindersDays"/></form:label>
	       
	            <c:forEach items="${filingReminderDays}" var="reminderCode" varStatus="cStatus" >
	                    <c:set var="checked" value=""/>
	                    <c:set var="id" value="-1"/>
	                    <c:forEach items="${clientPracticeInfo.filingReminderRules}" var="reminderRule"
	                               varStatus="ruleIndex">
	
	                        <c:if test="${reminderRule.reminderDayCode eq reminderCode}">
	                            <c:set var="checked" value="checked=true"/>
	                            <c:set var="id" value="${reminderRule.id}"/>
	                        </c:if>
	                    </c:forEach>
	
	                    <c:out value="${reminderCode.shortName}"/>
	                   
	                    <input type="checkbox" id="filingReminderRules${cStatus.index}.reminderDayCode"
	                           name="filingReminderRules[${cStatus.index}].reminderDayCode" value="${reminderCode.id }"
	                            <c:out
	                                    value="${checked}"/>/>
	                    <input type="hidden" id="filingReminderRules${cStatus.index}"
	                           name="filingReminderRules[${cStatus.index}]" value="${id }"/>
	                           
	                </c:forEach>
	       
        </div>
</div>
<div class="span3">
</div>
</div>

     
     <div class="row">
    <div class="span3">
     <form:label path="instalmentFrequency"><spring:message code="label.installmentFrequency"/></form:label>
      
            <form:select path="instalmentFrequency" id="instalmentFreqField" cssClass="formSelect" tabindex="1" onChange="modifyinst()">
                <form:option value="-1" label="Select"/>
                <form:options items="${instalmentFrequency}" itemValue="id" itemLabel="shortName"/>
            </form:select>
</div>
 <div class="instalment_month_date">
    <c:forEach items="${clientPracticeInfo.installmentDueDateRules}" var="dateRule" varStatus="cStatus">
<div class="span3">
 
        
        	<form:label path="installmentDueDateRules[${cStatus.index}].dueMonth">
        		<div class="installment_due_month_label"><spring:message code="label.dueMonth"/></div>
        	</form:label>
       
        
	            <form:select path="installmentDueDateRules[${cStatus.index}].dueMonth" title="installmentMonthField" tabindex="3" cssClass="formSelect">
	                <form:option value="-1" label="Select"/>
	                <form:options items="${monthList}" itemValue="value" itemLabel="key"/>
	            </form:select>
  </div>     
        
<div class="span3">        
       <form:label path="installmentDueDateRules[${cStatus.index}].dueDay"><div class="installment_due_day_label"><spring:message code="label.duedate"/></div></form:label>
        
	            <form:select path="installmentDueDateRules[${cStatus.index}].dueDay" title="installmentDayField" tabindex="4" cssClass="formSelect">
	                 <form:option value="-1" label="Select"/> 
	           		<!-- <form name="frm" method="post" onSubmit="return ValidateDate()"> -->
	                <c:forEach var="i" begin="1" end="31" step="1">
	                    <form:option value="${i}" label="${i}"/>
	                </c:forEach>
	                <form:option value="-100" label="Last Day"/>  
	            </form:select>
       
         <form:hidden path="installmentDueDateRules[${cStatus.index}].id" class="installmentDateId"/>
         
 </div>        
    </c:forEach>
   </div>
</div>
 
<div class="row">	
<div class="span3">
<div class="instalment_reminders">
        <form:label path="instalmentReminder"><spring:message code="label.installmentReminders"/></form:label>
            <form:select path="instalmentReminder" id="instalmentDateReminderField" cssClass="formSelect" tabindex="1">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>
        </div>
</div>
<div class="span3">
<c:if test="${! clientPracticeInfo.instalmentReminder}">
        <c:set var="installment_reminder_display" value="display:none"/>
</c:if>
    	<div class="installment_days_row" style="<c:out value='${installment_reminder_display}'/>">
	       <form:label path="filingDateReminder">Reminders Days</form:label>
	            <c:forEach items="${instalmentReminderDays}" var="reminderCode" varStatus="cStatus">
	                    <c:set var="checked" value=""/>
	                    <c:set var="id" value="-1"/>
	                    <c:forEach items="${clientPracticeInfo.installmentReminderRules}" var="reminderRule"
	                               varStatus="ruleIndex">
	
	                        <c:if test="${reminderRule.reminderDayCode eq reminderCode}">
	                            <c:set var="checked" value="checked=true"/>
	                            <c:set var="id" value="${reminderRule.id}"/>
	                        </c:if>
	                    </c:forEach>
	
	                    <c:out value="${reminderCode.shortName}"/>
	                    <input type="checkbox" id="installmentReminderRules${cStatus.index}.reminderDayCode"
	                           name="installmentReminderRules[${cStatus.index}].reminderDayCode" value="${reminderCode.id }"
	                            <c:out
	                                    value="${checked}"/>/>
	                    <input type="hidden" id="installmentReminderRules${cStatus.index}"
	                           name="installmentReminderRules[${cStatus.index}]" value="${id }"/>
	                </c:forEach>
        </div>
</div>
<div class="span3">
</div>
</div>
  
<div class="row">	
<div class="span3">
<form:label path="staffInCharge"><spring:message code="label.staffIncharge"/></form:label>
            <form:select path="staffInCharge" cssClass="formSelect" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${staffList}" itemValue="id" itemLabel="name"/>
            </form:select>
</div>
<div class="span3">
<form:label path="clientStaffInCharge"><spring:message code="label.clientStaffIncharge"/></form:label>
            <form:select path="clientStaffInCharge" cssClass="formSelect" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${clientStaffList}" itemValue="id" itemLabel="name"/>
            </form:select>
</div>
<div class="span3">
<form:label path="partnerInCharge"><spring:message code="label.partnerIncharge"/></form:label>
            <form:select path="partnerInCharge" cssClass="formSelect" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${partnerList}" itemValue="id" itemLabel="name"/>
            </form:select>
</div>
</div>
<div class="row">	
<div class="span3">
<form:label path="preparerNotes" cssClass="input_full"><spring:message code="label.preparerNotes"/></form:label>
<form:textarea path="preparerNotes" rows="3" cssClass="input_full" style="width: 500px;" tabindex="16"/>
</div>
<div class="span3">
</div>
<div class="span3">
</div>
</div>
  
    <div class="container_12" style="margin:10px;"></div>

			<div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
            	<security:authorize access="hasRole('ROLE_STAFF')">
	                	
	                	<button type="button" id="save"
							class="btn btn-success"
							role="button" aria-disabled="false">
							<c:if test="${clientPracticeInfo.id == null}">
							<span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</c:if>
							<c:if test="${clientPracticeInfo.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    	<a data-target="#list" onclick=taxList(); href="taxList.do" class="active" data-toggle="tab" style="text-decoration:none;">
	                    	<button type="button"
	                            	class="btn btn-success"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
	                    	</button>
	                    	</a>
            	</security:authorize>
            	
		        </div>
        	</div>

    </form:form>
</div>
</div>
</div>


<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	
	$("#filingDueDateRules1\\.dueMonth").change(function() {
		alert("hello");
		$.get("<c:url value='/tax/getDays.do'/>", { monthId: $(this).val()}, function(data) {
			
            populateStateDropdown($("#filingDueDateRules0\\.dueDay"), data);
       
    });
		
		$('[name^=filingDueDateRules0\\.dueMonth]').live('change', function(){
			alert("hello");
		});
});

function populateStateDropdown(select, data) {
    select.html('');
    select.append($('<option></option>').val("-1").html("Select"));
    $.each(data, function(id, option) {
        $.each(option, function(id, option) {
            select.append($('<option></option>').val(option.key).html(option.value));

        });
    });
}
	
	$("#filingFreqField").change(function() {   
		var label = $('#filingFreqField option:selected').text();
        var freq = $("#filingFreqField").val();
        var filingFields = $("div[class='filing_month_date']").length;

        var count = 0;
        if (label == "Quarterly") {
            count = 4;
            enableFilingFrqRduemonth();
            enableFilingFrqReminderField();
        } else if (label == "Yearly") {
            count = 1;
            enableFilingFrqRduemonth();
            enableFilingFrqReminderField();
        } else if (label == "Semi Yearly") {
            count = 2;
            enableFilingFrqRduemonth();
            enableFilingFrqReminderField();
        } else if (label == "Monthly") {        	
            count = 1;
            disableFilingFrqRduemonth();
            disableFilingFrqReminderField();
        } else if (label == "Select") {
            count = 1;
            enableFilingFrqRduemonth();
            enableFilingFrqReminderField();
        }
        
        if (filingFields < count) {
            addFilingField(count, filingFields);
        } else if (filingFields > count) {
            removeFilingFrequencyField(filingFields - count);
        }
	});
	

	
	if ($('#instalmentFreqField option:selected').text() == "None") {
    	removeInstFrqReminderFields();
    }
	
	if ($('#instalmentFreqField option:selected').text() == "Monthly") {
		disableInstFrqduemonth();
    	disableInstFrqReminderField();
    } 
	if ($('#filingFreqField  option:selected').text() == "Monthly") {
		disableFilingFrqRduemonth();
		disableFilingFrqReminderField();
    } 
	
	
	$("#instalmentFreqField").change(function() {   
		var label = $('#instalmentFreqField option:selected').text();
        var freq = $("#instalmentFreqField").val();
        var filingFields = $("div[class='instalment_month_date']").length;

        var count = 0;
        if (label == "Quarterly") {
            count = 4;
            enableInstFrqduemonth();
        } else if (label == "Yearly") {
            count = 1;
            enableInstFrqduemonth();
        } else if (label == "Semi Yearly") {
            count = 2;
            enableInstFrqduemonth();
        } else if (label == "Monthly") {
            count = 1;
            disableInstFrqduemonth();
            disableInstFrqReminderField();
        } else if (label == "Select") {
            count = 1;
            enableInstFrqduemonth();
        } else if (label == "None") {
        	removeInstFrqReminderFields();
        }
        
        if (filingFields < count) {
        	addInstallmentField(count, filingFields);
        } else if (filingFields > count) {
        	removeInstallmentFrequencyField(filingFields - count);
        }
	});
	 
	$("#filingDateReminderField").change(function() { 
	    var reminder = $("#filingDateReminderField").val();
	    if (reminder == 'true') {
	        $('.reminder_days_row').show();
	        } else {
	        $('.reminder_days_row').hide();
	    }
	});
	
	$("#instalmentDateReminderField").change(function() { 
	    var reminder = $("#instalmentDateReminderField").val();
	    if (reminder == 'true') {
	        $('.installment_days_row').show();
	    } else {
	        $('.installment_days_row').hide();
	    }
	});

});

	function removeInstFrqReminderFields(){
		$('.instalment_month_date').remove();
		$('.instalment_reminders').remove();
	}
	
	function disableInstFrqduemonth(){
		$("#installmentDueDateRules0\\.dueMonth").attr('disabled', true);
	}
	
	function enableInstFrqduemonth(){
		$("#installmentDueDateRules0\\.dueMonth").attr('disabled', false);
	}
	
	function disableFilingFrqRduemonth(){
		$("#filingDueDateRules0\\.dueMonth").attr('disabled', true);
	}
	
	function enableFilingFrqRduemonth(){
		$("#filingDueDateRules0\\.dueMonth").attr('disabled', false);
	}
	
	function disableInstFrqReminderField(){		
		$("#installmentReminderRules5\\.reminderDayCode").attr('disabled', true);
		$("#installmentReminderRules6\\.reminderDayCode").attr('disabled', true);
	} 
	function disableFilingFrqReminderField(){
		$("#filingReminderRules5\\.reminderDayCode").attr('disabled', true);
		$("#filingReminderRules6\\.reminderDayCode").attr('disabled', true);
	}
	function disableFilingFrqReminderField(){
		$("#filingReminderRules5\\.reminderDayCode").attr('disabled', true);
		$("#filingReminderRules6\\.reminderDayCode").attr('disabled', true);
	}
	function enableFilingFrqReminderField(){
		$("#filingReminderRules5\\.reminderDayCode").attr('disabled', false);
		$("#filingReminderRules6\\.reminderDayCode").attr('disabled', false);
	}
	
	
	function addFilingField(newCount, existingFields) {
    	$('.filing_month_date:first').find("div[class='filing_due_month_label']").text('Due Month 1');		
        $('.filing_month_date:first').find("div[class='filing_due_day_label']").text('Due Date 1');	
        filingFieldCount = existingFields;
        for (var i = existingFields; i < newCount; i = i + 1) {
            filingFieldCount = filingFieldCount + 1;
        	
            $('.filing_month_date:last').clone().insertAfter(".filing_month_date:last").find("select[title='filingMonthField']").attr({
    			name: 'filingDueDateRules' + (i) +'.dueMonth', 
    			id: 'filingDueDateRules' + (i) +'.dueMonth'})
    			.val("").insertBefore("#end_of_form"); ;	
            
            $('.filing_month_date:last').find("div[class='filing_due_month_label']").text('Due Month '+filingFieldCount);	
            $('.filing_month_date:last').find("div[class='filing_due_day_label']").text('Due Date '+filingFieldCount);	
            
            $('.filing_month_date:last').find("select[title='filingDayField']").attr({
        		name: 'filingDueDateRules[' + (i) +'].dueDay', 
        		id: 'filingDueDateRules[' + (i) +'].dueDay'})
        		.val("");	

            $('.filing_month_date:last').find("input[class='filingDateId']").attr({
        		name: 'filingDueDateRules[' + (i) +'].id', 
        		id: 'filingDueDateRules[' + (i) +'].id'})
        		.val(""); 

        }
    }
	
	function removeFilingFrequencyField(count) {
        for (var i = 1; i <= count; i = i + 1) {
        	 $('.filing_month_date:last').remove();
        }
    }
	
	function addInstallmentField(newCount, existingFields) {
    	$('.instalment_month_date:first').find("div[class='installment_due_month_label']").text('Due Month 1');		
        $('.instalment_month_date:first').find("div[class='installment_due_day_label']").text('Due Date 1');	
        filingFieldCount = existingFields;
        for (var i = existingFields; i < newCount; i = i + 1) {
            filingFieldCount = filingFieldCount + 1;
        	
            $('.instalment_month_date:last').clone().insertAfter(".instalment_month_date:last").find("select[title='installmentMonthField']").attr({
    			name: 'installmentDueDateRules[' + (i) +'].dueMonth', 
    			id: 'installmentDueDateRules[' + (i) +'].dueMonth'})
    			.val("");	
            
            $('.instalment_month_date:last').find("div[class='installment_due_month_label']").text('Due Month '+filingFieldCount);	
            $('.instalment_month_date:last').find("div[class='installment_due_day_label']").text('Due Date '+filingFieldCount);	
            
            $('.instalment_month_date:last').find("select[title='installmentDayField']").attr({
        		name: 'installmentDueDateRules[' + (i) +'].dueDay', 
        		id: 'installmentDueDateRules[' + (i) +'].dueDay'})
        		.val("");	

            $('.instalment_month_date:last').find("input[class='installmentDateId']").attr({
        		name: 'installmentDueDateRules[' + (i) +'].id', 
        		id: 'installmentDueDateRules[' + (i) +'].id'})
        		.val(""); 

        }
    }
	
	function removeInstallmentFrequencyField(count) {
        for (var i = 1; i <= count; i = i + 1) {
        	 $('.instalment_month_date:last').remove();
        }
    }
	
	function taxList(){
		$('#mainTaxTabs a:first').tab("show");
    	}

</script>

</div>

<script type="text/javascript">
/* 
function daysInMonth(month,year1) {
	
	var dd = new Date(year1, month, 0);
	return dd.getDate();     }
	
function setDayDrop(dmonth, dday) {
	var currentTime = new Date();
     var year1 = currentTime.getFullYear(); 
  
	var month = dmonth.options[dmonth.selectedIndex].value;
	month = parseInt(month);
	month = month + 1;
	var day = dday.options[dday.selectedIndex].value;
	if (day == -1) {
	var days = ( year1 == null || month == -1 )
	    ? 31 : daysInMonth(month,year1);
	dday.options.length = 0;
	dday.options[dday.options.length] = new Option(' ',' ');
	for (var i = 1; i <= days; i++)
	dday.options[dday.options.length] = new Option(i,i);}
	                                   }
function filingsetDay() {

	var month = document.getElementById('filingDueDateRules0.dueMonth');
	var day = document.getElementById('filingDueDateRules0.dueDay');
	setDayDrop(month,day);}
	document.getElementById('filingDueDateRules0.dueMonth').onchange = filingsetDay;
	              
function installmentsetDay() {

	      var month = document.getElementById('installmentDueDateRules0.dueMonth');
	      var day = document.getElementById('installmentDueDateRules0.dueDay');
	      setDayDrop(month,day);}
	      document.getElementById('installmentDueDateRules0.dueMonth').onchange = installmentsetDay;
	     	 */
</script>


