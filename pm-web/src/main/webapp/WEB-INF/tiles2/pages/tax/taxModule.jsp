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
                meta: "validate"
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

        $(".cancel").click(function() {
            validator.resetForm();
        });
    });
</script>

<div class="ml20 mr20 mt10">
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
<span class="legend b">Tax</span>

<div class="f13">
<form:form modelAttribute="clientPracticeInfo" method="POST" action="taxModule.do">
<input type="hidden" name="clientId" id="clientId" value="${param.clientId }"/>
<input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${param.firmPracticeId}"/>
<input type="hidden" name="baseURL" id="baseURL" value="taxModule.do"/>
<input type="hidden" name="inValidClientId" value="${param.inValidClientId }"/>
<input type="hidden" name="month1" value="${param.inValidClientId }"/>

<b><strong>${inValidClientId}</strong></b>
<form:hidden path="id"/>
<div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;margin-top:-3px">Practice
    Details</h4></div>
<div class="container_12 mt20">
    <div class="grid_2 right"><form:label path="jurisdiction">Jurisdiction</form:label></div>
    <div class="grid_3 right">
        <form:select path="jurisdiction" cssClass="input_full" tabindex="1">
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
</div>

<div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;">Filing Details</h4></div>

<div class="container_12 pt5">
    <div class="grid_2 right"><form:label path="filingFrequency">Filing Frequency</form:label></div>
    <div class="grid_3 right">
        <form:select path="filingFrequency" id="filingFreqField" tabindex="1" cssClass="input_full" onChange="modify()">
            <form:option value="-1" label="Select"/>
            <form:options items="${filingFrequency}" itemValue="id" itemLabel="shortName"/>
        </form:select>
         <c:set value="${filingDueDateRules0.dueMonth}" var="month1"></c:set>  
    </div>
</div>

<div class="container_12 pt5">
  <div class="filing_month_date">
    <c:forEach items="${clientPracticeInfo.filingDueDateRules}" var="dateRule" varStatus="cStatus">
        <div class="grid_2 right"><form:label path="filingDueDateRules[${cStatus.index}].dueMonth"><div class="filing_due_month_label">Due Month</div></form:label></div>
        <div class="grid_3 right">
	            <form:select path="filingDueDateRules[${cStatus.index}].dueMonth" title="filingMonthField" tabindex="3" cssClass="input_full" name="filingMonthField">
	                 <form:option value="-1" label="Select"/> 
	                <form:options items="${monthList}" itemValue="value" itemLabel="key"/>
	            </form:select>
        </div>
       
        <div class="s1"></div>
        <div class="grid_2 right"><form:label path="filingDueDateRules[${cStatus.index}].dueDay"><div class="filing_due_day_label">Due Date</div></form:label></div>
        <div class="grid_3 right">
	            <form:select path="filingDueDateRules[${cStatus.index}].dueDay" title="filingDayField" tabindex="4" cssClass="input_full" name = "filingDayField">
	                <form:option value="-1" label="Select"/> 
	           		<!-- <form name="frm" method="post" onSubmit="return ValidateDate()"> -->
	               <%--  <c:forEach var="i" begin="1" end="<%= fontSize %>" step="1"> --%>
	                <c:forEach var="i" begin="1" end="31" step="1">
	                    <form:option value="${i}" label="${i}"/>
	                </c:forEach>
	                <form:option value="-100" label="Last Day"/>  
	            </form:select> 
               
        </div>
         <form:hidden path="filingDueDateRules[${cStatus.index}].id" class="filingDateId"/>
    </c:forEach>
   </div>
</div>

    <div class="container_12 pt5">
        <div class="grid_2 right"><form:label path="filingDateReminder">Filing Reminders</form:label></div>
        <div class="grid_3 right">
            <form:select path="filingDateReminder" id="filingDateReminderField" tabindex="1" cssClass="input_full">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>
        </div>
    </div>
    <c:if test="${! clientPracticeInfo.filingDateReminder}">
        <c:set var="filing_reminder_display" value="display:none"/>
    </c:if>
    
    <div class="container_12 pt5">
    	<div class="reminder_days_row" style="<c:out value='${filing_reminder_display}'/>">
	        <div class="grid_2 right"><form:label path="filingDateReminder">Reminders Days</form:label></div>
	        <div class="grid_3 right">
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
    </div>
    
    <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;">Installment Details</h4></div>

    <div class="container_12 pt5">
        <div class="grid_2 right"><form:label path="instalmentFrequency">Installment Frequency</form:label></div>
        <div class="grid_3 right">
            <form:select path="instalmentFrequency" id="instalmentFreqField" cssClass="input_full" tabindex="1" >
                <form:option value="-1" label="Select"/>
                <form:options items="${instalmentFrequency}" itemValue="id" itemLabel="shortName"/>
            </form:select>
        </div>
    </div>
    
<div class="container_12 pt5">
  <div class="instalment_month_date">
    <c:forEach items="${clientPracticeInfo.installmentDueDateRules}" var="dateRule" varStatus="cStatus">
        <div class="grid_2 right">
        	<form:label path="installmentDueDateRules[${cStatus.index}].dueMonth">
        		<div class="installment_due_month_label">Due Month</div>
        	</form:label>
        </div>
        <div class="grid_3 right">
	            <form:select path="installmentDueDateRules[${cStatus.index}].dueMonth" title="installmentMonthField" tabindex="3" cssClass="input_full">
	                <form:option value="-1" label="Select"/>
	                <form:options items="${monthList}" itemValue="value" itemLabel="key"/>
	            </form:select>
        </div>
        
        <div class="s1"></div>
        <div class="grid_2 right"><form:label path="installmentDueDateRules[${cStatus.index}].dueDay"><div class="installment_due_day_label">Due Date</div></form:label></div>
        <div class="grid_3 right">
	            <form:select path="installmentDueDateRules[${cStatus.index}].dueDay" title="installmentDayField" tabindex="4" cssClass="input_full">
	                 <form:option value="-1" label="Select"/> 
	           		<!-- <form name="frm" method="post" onSubmit="return ValidateDate()"> -->
	                <c:forEach var="i" begin="1" end="31" step="1">
	                    <form:option value="${i}" label="${i}"/>
	                </c:forEach>
	                <form:option value="-100" label="Last Day"/>  
	            </form:select>
        </div>
         <form:hidden path="installmentDueDateRules[${cStatus.index}].id" class="installmentDateId"/>
    </c:forEach>
   </div>
</div>

    <div class="container_12 pt5">
    	<div class="instalment_reminders">
        <div class="grid_2 right"><form:label path="instalmentReminder">Installment Reminders</form:label></div>
        <div class="grid_3 right">
            <form:select path="instalmentReminder" id="instalmentDateReminderField" cssClass="input_full" tabindex="1">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>
        </div>
        </div>
    </div>
    
    <c:if test="${! clientPracticeInfo.instalmentReminder}">
        <c:set var="installment_reminder_display" value="display:none"/>
    </c:if>
    
    <div class="container_12 pt5">
    	<div class="installment_days_row" style="<c:out value='${installment_reminder_display}'/>">
	        <div class="grid_2 right"><form:label path="filingDateReminder">Reminders Days</form:label></div>
	        <div class="grid_3 right">
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
    </div> 
    
    <div class="grid_12 blue"><h4 style="border-bottom:1px solid #ccc;padding-bottom:5px;">Staff Assignment</h4></div>

    <div class="container_12 pt5">
        <div class="grid_2 right"><form:label path="staffInCharge">Staff In charge</form:label></div>
        <div class="grid_3 right">
            <form:select path="staffInCharge" cssClass="input_full" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${staffList}" itemValue="id" itemLabel="name"/>
            </form:select>
        </div>
        <div class="s1"></div>
        <div class="grid_2 right"><form:label path="clientStaffInCharge">Client Staff In-charge</form:label></div>
        <div class="grid_3 right">
            <form:select path="clientStaffInCharge" cssClass="input_full" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${clientStaffList}" itemValue="id" itemLabel="name"/>
            </form:select>
        </div>
    </div>

    <div class="container_12 pt5">
        <div class="grid_2 right"><form:label path="partnerInCharge">Partner In charge</form:label></div>
        <div class="grid_3 right">
            <form:select path="partnerInCharge" cssClass="input_full" tabindex="1">
                <form:option value="-1" label="Select"/>
                <form:options items="${partnerList}" itemValue="id" itemLabel="name"/>
            </form:select>
        </div>
    </div>
    <div class="container_12 pt5">
        <div class="grid_2 right"><form:label path="preparerNotes"
                                              cssClass="input_full">Preparer Notes</form:label></div>
        <div class="grid_5 right"><form:textarea path="preparerNotes" rows="3" cssClass="input_full"
                                                 tabindex="16"/></div>
    </div>

    <div class="container_12" style="margin:10px;"></div>

			<div class="container_12">
            	<div class="grid_3">&nbsp;</div>
	            <div class="grid_8">
            	<security:authorize access="hasRole('ROLE_STAFF')">
	                	<a href="taxModule.do?clientId=${param.clientId }&firmPracticeId=${param.firmPracticeId}" style="text-decoration:none;">
	                    	<button type="button" id="newClient"
	                    	 onclick="window.location='taxModule.do?clientId=${param.clientId }&firmPracticeId=${param.firmPracticeId}';return false;"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">New Tax</span>
	                    	</button>
	                	</a>&nbsp;&nbsp;
	
	                	<button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false">
							<c:if test="${clientPracticeInfo.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${clientPracticeInfo.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    	<button type="reset"
	                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text">Cancel</span>
	                    	</button>
            	</security:authorize>
            	
		        </div>
        	</div>

    </form:form>
</div>
</div>
</div>

<!-- BUCKET -->
<div class="fieldset mt25 ml20 mr20">
<span class="legend b">Tax List</span>
    <!--  GRID PLACEHOLDER Ids -->
    <div id="grid_wrapper" class="ml10 mr10 mt20">
		<table id="list"></table>
		<div id="pager" class="scroll"></div>
	</div>
<script type="text/javascript">
jQuery(document).ready(function() {
    var clientId = $("#clientId").val();
    var firmPracticeId = $("#firmPracticeId").val();

    var mygrid = jQuery("#list").jqGrid({
        url:'taxModuleList.do?clientId=' + clientId + '&firmPracticeId=' + firmPracticeId,
        datatype: 'json',
        mtype: 'GET',
        colNames:['ID','Client Name','Jurisdiction','Staff In Charge','Client Staff In-Chager', 'Tax Return Type','Tax Creator','Tax created Date', 'Status'],
        colModel :[
            {name:'clientPracticeInfoId', index:'clientPracticeInfoId',  width:15},
            {name:'clientName', index:'clientName',  width:40,formatter: 'showlink', formatoptions: {baseLinkUrl: 'taxModule.do',
                idName:'id', addParam:'&clientId=' + clientId + '&firmPracticeId=' + firmPracticeId}},
            {name:'jurisdictionName', index:'jurisdictionName',  width:60},
            {name:'staffInChargeName', index:'staffInChargeName',  width:60},
            {name:'clientStaffInChargeName', index:'clientStaffInChargeName',  width:60},
            {name:'taxReturn', index:'taxReturn',  width:60},
            {name:'taskCreator', index:'taskCreator',  width:80},
            {name:'formatedtaskCreatedDate', index:'formatedtaskCreatedDate',  width:60},
            {name:'status',index:'status', width:40}
        ],
        jsonReader : {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: false,
            cell: "cell",
            id: "clientPracticeInfoId",
            userdata: "userdata"
        },
        pager: jQuery('#pager'),
        rowNum:10,
        loadonce : true,
        rowList:[10,25,50],
        sortname: 'name',
        sortorder: 'asc',
        viewrecords: true,
        autowidth: true,
        caption: 'Tax List',
        editurl:'<c:url value="saveTaxModuleList.do"/>'
    });
    <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
		jQuery("#list").jqGrid('navGrid', '#pager', {
			del : true,
			add : false,
			edit : false,
			search : false
		});
	</security:authorize>
	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
		jQuery("#list").jqGrid('navGrid', '#pager', {
			del : false,
			add : false,
			edit : false,
			search : false
		});
	</security:authorize>

	jQuery("#list").jqGrid('navButtonAdd',
			"#pager", {
				caption : "Apply Filter",
				title : "Toggle Search Toolbar",
				buttonicon : 'ui-icon-pin-s',
				onClickButton : function() {
					mygrid[0].toggleToolbar();
				}
	    
			});
	 
    jQuery("#list").jqGrid('filterToolbar', {stringResult: true,searchOnEnter : false});
    $(window).bind('resize',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('resize');

    $(window).bind('load',
            function() {
                jQuery("#list").setGridWidth($('#grid_wrapper').width() - 5, true);
            }).trigger('load');
});	

jQuery(document).ready(function() {
	var mygrid = jQuery("#toolbar").jqGrid({
	   	url:'jurisdictionsList.do',
		datatype: "json",
		height : 300,
		colNames:['ID','Country', 'State/Province', 'Select'],
	   	colModel:[
	   		{name:'id',index:'id'},
	   		{name:'country',index:'country'},
	   		{name:'state',index:'state'},
	   		{name:'act',index:'act', width:140,sortable:false, stype: 'select'}
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
  			be = "<input style='height:22px;width:136px;' type='button' value='Select' onclick="+closeJs+"  />"; 
  			jQuery("#toolbar").jqGrid('setRowData',ids[i],{act:be});
  		}	
  	},
      	rowNum:7,
	   	rowList:[7,14,21],
		loadonce:true,
	   	mtype: "GET",
		gridview: true,
	   	pager: '#ptoolbar',
	   	sortname: 'country',
	    viewrecords: true,
	    sortorder: "asc"
	});

	jQuery("#toolbar").jqGrid('navGrid','#ptoolbar',{del:false,add:false,edit:false,search:false});
	jQuery("#toolbar").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});
	
});
</script>

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
        $('.instalment_month_date').show();
        $('.instalment_reminders').show();
        if(filingFields == 0){
        	filingFields = 1;
        }
        var count = 1;
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
		//$('.instalment_month_date').remove();
		 $('.instalment_month_date').hide();
		//$('.instalment_reminders').remove();
		 $('.instalment_reminders').hide();
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
	

</script>

</div>
<script type="text/javascript">
    $(document).ready(function() {
        <c:if test="${statusMessageKey eq 'save.msg.success'}">
        $.jGrowl('Record Saved Sucessfully');
        </c:if>

    });
</script>

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


