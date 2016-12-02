<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<style>
    .error {
        color: red;
    }

    .errorblock {
        color: #000;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin: 5px;
        padding: 5px;
        width: auto;
    }
</style>
<style type="text/css">
    .party fieldset p.error label {
        color: red;
    }

    div.error_container {
        background-color: #eee;
        -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
        border: 1px solid red;
        margin-bottom: 20px;
        padding: 5px;
        width: 40em;
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

    form.party {
        width: 30em;
    }

    form.party label.error {
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
        border: 1px solid red;
    }

    select.error {
        border: 1px solid red;
    }

    label.error {
        /* remove the next line when you have trouble in IE6 with labels in list */
        color: red;
        font-style: italic
    }
</style>
<%-- <c:url value="/mobiletax/mobileTaxModule.do?clientId=${param.clientId}&firmPracticeId=${firmPracticeId}" var="mobileTaxModuleUrl"/> --%>
<security:authorize access="hasRole('ROLE_STAFF')">
	                	
	                	
	                	<a href="mobileTaxModule.do?clientId=${param.clientId }&firmPracticeId=${param.firmPracticeId}" style="text-decoration:none;">
	                    	<button type="button" id="showTaxForm" onclick="showTaxForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-mini="true" data-inline="true">
	                        	<span class="ui-button-text">New Tax</span>
	                    	</button>
	                	</a>&nbsp;&nbsp;
	                	
</security:authorize>

<body onload="hideTaxForm()">
<div id="mobileTaxForm" >

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<form:form modelAttribute="clientPracticeInfo" method="POST" action="mobileTaxModule.do">
<input type="hidden" name="clientId" id="clientId" value="${param.clientId }"/>
<input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${param.firmPracticeId}"/>
<input type="hidden" name="baseURL" id="baseURL" value="mobileTaxModule.do"/>
<input type="hidden" name="inValidClientId" value="${param.inValidClientId }"/>


<b><strong>${inValidClientId}</strong></b>
<form:hidden path="id"/>
  <div data-role="fieldcontain" >
 
    <form:label path="jurisdiction">Jurisdiction</form:label>
               <fieldset data-role="controlgroup" data-mini="true">      
                    <form:select path="jurisdiction" >
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${jurisdictionList}"
										itemValue="id" itemLabel="name" />
                   		</form:select>
       </fieldset>             
    </div>
    <div data-role="fieldcontain">
    <form:label path="filingFrequency" >Filing Frequency</form:label>
                    
                    <form:select path="filingFrequency" id="filingFreqField" tabindex="1" cssClass="input_full" data-mini="true" >
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${filingFrequency}" 
										itemValue="id" itemLabel="shortName" />
                   		</form:select>
                    
    </div>
    <div  data-role="fieldcontain">
     <div class="filing_month_date">
    <c:forEach items="${clientPracticeInfo.filingDueDateRules}" var="dateRule" varStatus="cStatus">
    <form:label path="filingDueDateRules[${cStatus.index}].dueMonth"><div class="filing_due_month_label">Due Month</div></form:label>
                    
                    <form:select path="filingDueDateRules[${cStatus.index}].dueMonth" title="filingMonthField" name="filingMonthField" tabindex="3" cssClass="input_full" data-mini="true">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${monthList}" 
										 itemValue="value" itemLabel="key"/>
                   		</form:select>
                   		
                   <form:label path="filingDueDateRules[${cStatus.index}].dueDay"><div class="filing_due_day_label">Due Date</div></form:label>
                    
                      <form:select path="filingDueDateRules[${cStatus.index}].dueDay" title="filingDayField" name = "filingDayField" tabindex="3" cssClass="input_full" data-mini="true">
                        	<form:option value="-1" label="Select"/>
                            <c:forEach var="i" begin="1" end="31" step="1">
	                           <form:option value="${i}" label="${i}"/>
	                        </c:forEach>
	                         <form:option value="-100" label="Last Day"/> 
                      </form:select>
                      
                     <form:hidden path="filingDueDateRules[${cStatus.index}].id" class="filingDateId"/>
      </c:forEach>
      </div>
    </div>
   
     <div data-role="fieldcontain">
     <form:label path="filingDateReminder">Filing Reminders</form:label>
       
      <form:select path="filingDateReminder" id="filingDateReminderField" tabindex="1" cssClass="input_full" data-mini="true">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>
           
    </div>
     <c:if test="${! clientPracticeInfo.filingDateReminder}">
        <c:set var="filing_reminder_display" value="display:none"/>
    </c:if>
    
    
    <div   data-role="fieldcontain">
     <div class="reminder_days_row" style="<c:out value='${filing_reminder_display}'/>"> 
    <form:label path="filingDateReminder">Reminders Days</form:label>
     <fieldset data-role="controlgroup" data-mini="true" data-type="horizontal" >
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
	
	                     <%-- <c:out value="${reminderCode.shortName}"/> --%>
	                   
	                   <input  type="checkbox" id="filingReminderRules${cStatus.index}.reminderDayCode" 
	                           name="filingReminderRules[${cStatus.index}].reminderDayCode" value="${reminderCode.id }" class="custom"
	                            <c:out
	                                    value="${checked}"/>/> 
	                                    <label style="width: 60px;" for="filingReminderRules${cStatus.index}.reminderDayCode" ><c:out value="${reminderCode.shortName}"/></label>
	                                     
	                    <input type="hidden" id="filingReminderRules${cStatus.index}" class="custom"
	                           name="filingReminderRules[${cStatus.index}]" value="${id }"/>
	                           
	                </c:forEach>
	                </fieldset>
    </div>
    </div>
    
    <div data-role="fieldcontain">
    <form:label path="instalmentFrequency" >Installment Frequency</form:label>
                    
                    <form:select path="instalmentFrequency" id="instalmentFreqField" tabindex="1" cssClass="input_full" data-mini="true" >
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${instalmentFrequency}" 
										itemValue="id" itemLabel="shortName" />
                   		</form:select>
                    
    </div>
    
    <div  data-role="fieldcontain">
     <div class="instalment_month_date">
    <c:forEach items="${clientPracticeInfo.installmentDueDateRules}" var="dateRule" varStatus="cStatus">
    <form:label path="installmentDueDateRules[${cStatus.index}].dueMonth"><div class="installment_due_month_label">Due Month</div></form:label>
                    
                    <form:select path="installmentDueDateRules[${cStatus.index}].dueMonth" title="installmentMonthField"  tabindex="3" cssClass="input_full" data-mini="true">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${monthList}" 
										 itemValue="value" itemLabel="key"/>
                   		</form:select>
                   		
                   <form:label path="installmentDueDateRules[${cStatus.index}].dueDay"><div class="installment_due_day_label">Due Date</div></form:label>
                    
                      <form:select path="installmentDueDateRules[${cStatus.index}].dueDay" title="installmentDayField"  tabindex="3" cssClass="input_full" data-mini="true">
                        	<form:option value="-1" label="Select"/>
                            <c:forEach var="i" begin="1" end="31" step="1">
	                           <form:option value="${i}" label="${i}"/>
	                        </c:forEach>
	                         <form:option value="-100" label="Last Day"/> 
                      </form:select>
                      
                     <form:hidden path="installmentDueDateRules[${cStatus.index}].id" class="installmentDateId"/>
      </c:forEach>
      </div>
    </div>
    
    <div data-role="fieldcontain">
     <form:label path="instalmentReminder">Installment Reminders</form:label>
       
      <form:select path="instalmentReminder" id="instalmentDateReminderField" tabindex="1" cssClass="input_full" data-mini="true">
                <form:options items="${yesNoList}" itemValue="value" itemLabel="key"/>
            </form:select>
           
    </div>
    
     <c:if test="${! clientPracticeInfo.instalmentReminder}">
        <c:set var="installment_reminder_display" value="display:none"/>
    </c:if>
    
    <div data-role="fieldcontain">
     <div class="installment_days_row" style="<c:out value='${installment_reminder_display}'/>"> 
    <form:label path="filingDateReminder">Reminders Days</form:label>
     <fieldset data-role="controlgroup" data-mini="true" data-type="horizontal" >
    <c:forEach items="${instalmentReminderDays}" var="reminderCode" varStatus="cStatus" > 
	                    <c:set var="checked" value=""/>
	                    <c:set var="id" value="-1"/>
	                    <c:forEach items="${clientPracticeInfo.installmentReminderRules}" var="reminderRule"
	                               varStatus="ruleIndex">
	
	                        <c:if test="${reminderRule.reminderDayCode eq reminderCode}">
	                            <c:set var="checked" value="checked=true"/>
	                            <c:set var="id" value="${reminderRule.id}"/>
	                        </c:if>
	                    </c:forEach>
	
	                     <%-- <c:out value="${reminderCode.shortName}"/> --%>
	                   
	                   <input  type="checkbox" id="installmentReminderRules${cStatus.index}.reminderDayCode" 
	                           name="installmentReminderRules[${cStatus.index}].reminderDayCode" value="${reminderCode.id }" class="custom"
	                            <c:out
	                                    value="${checked}"/>/> 
	                                    <label style="width: 60px;" for="installmentReminderRules${cStatus.index}.reminderDayCode" ><c:out value="${reminderCode.shortName}"/></label>
	                                     
	                    <input type="hidden" id="installmentReminderRules${cStatus.index}" class="custom"
	                           name="installmentReminderRules[${cStatus.index}]" value="${id }"/>
	                           
	                </c:forEach>
	                </fieldset>
    </div>
    </div>
    
     <div data-role="fieldcontain">
    <form:label path="staffInCharge">Staff In charge</form:label>
    <form:select path="staffInCharge" cssClass="input_full" tabindex="1" data-mini="true">
                <form:option value="-1" label="Select"/>
                <form:options items="${staffList}" itemValue="id" itemLabel="name"/>
            </form:select>
    </div>
    
    <div data-role="fieldcontain">
    <form:label path="clientStaffInCharge">Client Staff In-charge</form:label>
    <form:select path="clientStaffInCharge" cssClass="input_full" tabindex="1" data-mini="true">
                <form:option value="-1" label="Select"/>
                <form:options items="${clientStaffList}" itemValue="id" itemLabel="name"/>
            </form:select>
    </div>
    
     <div data-role="fieldcontain">
    <form:label path="partnerInCharge">Partner In charge</form:label>
    <form:select path="partnerInCharge" cssClass="input_full" tabindex="1" data-mini="true">
                <form:option value="-1" label="Select"/>
                <form:options items="${partnerList}" itemValue="id" itemLabel="name"/>
            </form:select>
    </div>
    <div data-role="fieldcontain">
    <form:label path="preparerNotes" cssClass="input_full">Preparer Notes</form:label>
         <form:textarea path="preparerNotes" rows="3" cssClass="input_full"  tabindex="16"/>          
                                                                           
    </div>  
    
    <security:authorize access="hasRole('ROLE_STAFF')">
    <button type="button" id="save"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false" data-inline="true" data-mini="true">
							<c:if test="${clientPracticeInfo.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${clientPracticeInfo.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>&nbsp;&nbsp;
						
						<button type="reset"
	                            	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">Cancel</span>
	                    	</button>
    </security:authorize>
     <a href="mobileTaxModule.do?clientId=${param.clientId }&firmPracticeId=${param.firmPracticeId}" style="text-decoration:none;">
	                    	 <button type="button" id="form" onclick="hideTaxForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">Back</span>
	                    	</button> 
	                	</a>
    
    </form:form>
</div>

<div id="mobileTax"> 
<div id="grid_wrapper">
 <table id='mobileTaxmoduleGrid'></table>
    <div id='mobileTaxmodulePager'></div>
</div> 
<%-- <input type="hidden" name="clientId" id="clientId" value="${param.clientId }"/>
<input type="hidden" name="firmPracticeId" id="firmPracticeId" value="${param.firmPracticeId}"/> --%>
<script type='text/javascript'>
jQuery(document).ready(function() {
    var clientId = $("#clientId").val();
    var firmPracticeId = $("#firmPracticeId").val();
    //alert("clientid=" +clientId);
        jQuery('#mobileTaxmoduleGrid').jqGrid({
            "hoverrows":false,
            "viewrecords":true,
            "jsonReader": {root : "rows",
            page : "page",
            total : "total",
            records : "records",
            repeatitems : false,
            cell : "cell",
            id : "clientPracticeInfoId",
            userdata : "userdata"},
            "gridview":true,
            "loadonce":true,
            //"url":'<c:url value="/mobileclient/mobileClientGetStaff.do"/>?clientId=' + clientId,
            //"url":'mobiletaxModuleList.do?clientId=' + clientId + '&firmPracticeId=' + firmPracticeId,
            		"url" : '<c:url value="/mobiletax/mobiletaxModuleList.do"/>?clientId=' + clientId + '&firmPracticeId=' + firmPracticeId,
            "scrollPaging":true,
            pager : jQuery('#pager'),
            //"autowidth":true,
           /// "footerrow": true,
           /// "userDataOnFooter": true,
            "rowNum":10,
            "rowList" : [20,40,60],
            "sortname":"firstName",
            "height":200,
            "width" :300,
            "mtype" : "GET",
            "datatype":"json",
            caption : 'Tax List',
            //editurl:'<c:url value="/saveClientAjaxList.do"/>',
             colNames:['ID','Client Name','Jurisdiction','Staff In Charge','Client Staff In-Chager','Tax Return Type', 'Tax Creator','Tax created Date', 'Status'],
             colModel :[
                        {name:'clientPracticeInfoId', index:'clientPracticeInfoId',  width:15},
                        {name:'clientName', index:'clientName',  width:40,formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileTaxModule.do',
                            idName:'id', addParam:'&clientId=' + clientId + '&firmPracticeId=' + firmPracticeId}},
                        {name:'jurisdictionName', index:'jurisdictionName',  width:60},
                        {name:'staffInChargeName', index:'staffInChargeName',  width:60},
                        {name:'clientStaffInChargeName', index:'clientStaffInChargeName',  width:60},
                        {name:'taxReturn', index:'taxReturn',  width:60},
                        {name:'taskCreator', index:'taskCreator',  width:80},
                        {name:'formatedtaskCreatedDate', index:'formatedtaskCreatedDate',  width:60},
                        {name:'status',index:'status', width:40}
                    ],
								
                    
            "pager":"#mobileTaxmodulePager"
        });  	
      
        jQuery("#mobileTaxmoduleGrid").jqGrid('filterToolbar', {
            stringResult : true,
            searchOnEnter : false
        });
});
      /*  // $("#grid").jqGrid('footerData', 'set', { "ShipName":"Total:"}, true); */
    $('#mobileTaxmodulePager').css("height", "50px");
   
    </script>
 </div>  
 </body>
 
 <script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	
	$("#filingDateReminderField").change(function() { 
	    var reminder = $("#filingDateReminderField").val();
	    if (reminder == 'true') {
	        $('.reminder_days_row').show();
	        } else {
	        $('.reminder_days_row').hide();
	    }
	});
	
$("#filingDueDateRules0\\.dueMonth").change(function() {
		
		$.get("<c:url value='/tax/getDays.do'/>", { monthId: $(this).val()}, function(data) {
			
            populateStateDropdown($("#filingDueDateRules0\\.dueDay"), data);
       
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
			name: 'filingDueDateRules[' + (i) +'].dueMonth', 
			id: 'filingDueDateRules[' + (i) +'].dueMonth'})
			.val("");	
        
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
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
<script type="text/javascript">
$.validator.setDefaults({
    submitHandler: function(form) {
        form.submit();
    }
});
$().ready(function() {
    $("#save").click(function() {
    	//alert("save");
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
         //alert("conclude="+conclude);
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
         //alert("conclude="+conclude);
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
/* $().ready(function() {
	//$("#div2").hide();
		$("#showTaxForm").click(function() {
			$("#mobileTax").hide();	
			$("#mobileTaxForm").show();
			    
			});
}); */

function showTaxForm(){
	
	$("#mobileTax").hide();	
	$("#mobileTaxForm").show();
}

function hideTaxForm(){
	
	$("#mobileTaxForm").hide();	
	$("#mobileTax").show();
}

</script>