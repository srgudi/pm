<%@ include file="../../layout/PM-INCLUDES.jsp" %>
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
    .party fieldset p.error label {
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

<!--  BUCKET -->
<c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do" var="mobileclientOfficersAndShareHoldersUrl">  
    <c:param name="clientId" value="${param.clientId}"/>
</c:url>
<input type="hidden" id="clientId" name="clientId" value="${param.clientId }"/> 

<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	<a href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="show" onclick="showOfficerForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">New Officers&ShareHolders</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
</security:authorize> 

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div>

<body onload="hideOfficerForm()">	  
<div id="formOfficer">
    <form:form modelAttribute="party" method="POST" action="mobileClientOfficersAndShareHolders.do">
    <input type="hidden" id="firmId" name="firmId" value="${firm.id }"/>
    <input type="hidden" id="clientId" name="clientId" value="${param.clientId}"/>
    <input type="hidden" id="relationType" name="relationType" value="7"/>
    <input type="hidden" name="baseURL" id="baseURL" value="mobileClientOfficersAndShareHolders.do"/>
    <input type="hidden" name="inValidClientId" value="${param.inValidClientId}"/>
    <form:hidden path="person.personDetails.isStaff"/>

    <form:hidden path="id"/>
    <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
	<b><strong>${inValidClientId}</strong> </b>
			<div data-role="fieldcontain" >
            <form:label path="person">Staff</form:label>
            <form:select path="person" tabindex="1" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${staffListByClientId}" itemValue="key" itemLabel="value"/>
                   		</form:select>
            </div>

			<div data-role="fieldcontain" >
          <form:label path="person.firstName">First Name</form:label>
            <form:input cssClass="input_full" path="person.firstName" class="input"
                        tabindex="2"/>
                         </div>
         <div data-role="fieldcontain" >
           <form:label path="person.lastName">Last Name</form:label>
           <form:input cssClass="input_full" path="person.lastName" class="input"
                        tabindex="3"/>
            </div>
            
             <div data-role="fieldcontain" >
           <form:label path="person.dateOfBirth">Date Of Birth</form:label>
          <form:input cssClass="input_full" path="person.dateOfBirth" id="datepicker" class="input"
                        tabindex="4"/>
          </div>
            <div data-role="fieldcontain" >
            <form:label path="person.personDetails.annualCompensation">Annual Compensation</form:label>
            <form:input cssClass="input_full" path="person.personDetails.annualCompensation" class="input"
                        tabindex="5"/>
            </div>
            
            <div data-role="fieldcontain" >
            <form:label path="person.personDetails.codeTypeOfShare">Type of Shares</form:label>
            <form:select path="person.personDetails.codeTypeOfShare" tabindex="6" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${sharesTypes}" itemValue="key" itemLabel="value"/>
                   		</form:select>
                   		
              </div>
            <div data-role="fieldcontain" >
            <form:label path="person.personDetails.noOfSharesOwned">Number of shares owned</form:label>
            <form:input cssClass="input_full" path="person.personDetails.noOfSharesOwned" class="input"
                        tabindex="7"/>
            </div>
            	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                	
	                	<button type="button" id="saveOfficers"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
							role="button" aria-disabled="false" data-inline="true" data-mini="true">
							<c:if test="${party.id == null}">
							<span class="ui-button-text" tabindex="16">Save</span>
							</c:if>
							<c:if test="${party.id != null}">
	    	                <span class="ui-button-text" tabindex="16">Update</span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    <button type="reset"
	                        	class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                         	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                     	<span class="ui-button-text">Cancel</span>
	                    </button>
            	</security:authorize>
            	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${party.id != null}">
		                	<button type="button" id="saveOfficers"
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
            	<a href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>" style="text-decoration:none;">
	                    	 <button type="button" id="form" onclick="hideOfficerForm()"
	                        	    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
	                            	role="button" aria-disabled="false" data-inline="true" data-mini="true">
	                        	<span class="ui-button-text">Back</span>
	                    	</button> 
	                	</a>&nbsp;&nbsp;
</form:form>
</div>

<div id="gridOfficer">	
<div id="grid_wrapper">
 <table id='mobileClientOfficers'></table>
    <div id='clientOfficersPager'></div>
</div>  

    <script type="text/javascript">
    firmId = $("#firmId").val();
    clientId = $("#clientId").val();
    jQuery('#mobileClientOfficers').jqGrid({
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
        "url":'<c:url value="/client/partyList.do"/>?mainParty=' + clientId + '&relation=7&delOff=1',
        "scrollPaging":true,
        pager : jQuery('#pager'),
        "rowNum":10,
        "rowList" : [20,40,60],
        "sortname":"firstName",
        "height":200,
        "width" :300,
        "mtype" : "GET",
        "datatype": 'json',
        colNames:['Name','Type Of Share','No Of Shares'],
        colModel :[
                   {name:'name', index:'name',  width:200,formatter: 'showlink', formatoptions: {baseLinkUrl: 'mobileClientOfficersAndShareHolders.do',
                        idName:'id', addParam:'&clientId=' + clientId}},
                   {name:'typeOfShare', index:'typeOfShare',  width:150},
                   {name:'bigIntNoOfSharesOwned', index:'bigIntNoOfSharesOwned',  width:150}
                ],
        "pager":"#clientOfficersPager"
    });
            jQuery("#mobileClientOfficers").jqGrid('filterToolbar', {
            	stringResult: true,searchOnEnter : false
            });

            $('#clientOfficersPager').css("height", "50px");
    </script>
  </div>
</body>   
    <script type="text/javascript" charset="utf-8">
        $('.addicon').click(function() {
            if ($("tr.sharerow").length < 5) {
                var x = $("input[class^='input phoneField']").length;

                $("table tbody").find("tr.sharerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr({
                    name: 'defaultPointOfContact.phoneList[' + (x) + '].contactDetail',
                    id: 'defaultPointOfContact.phoneList[' + (x) + '].contactDetail'})
                        .val("");

                $("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr({
                    name: 'person.personDetails[' + (x) + '].codeTypeOfShare',
                    id: 'person.personDetails[' + (x) + '].codeTypeOfShare'})
                        .val("");
                
                firstrowLength();
            }
            ;
        });

            $(".removeicon").click(function () {
                $(this).parent().parent().remove();
            });

        function firstrowLength() {
            if ($("tr.phonerow").length > 1) {
                $("tr.phonerow:last").find("td:last").find("a.removeicon").show();
            }
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#staffYes").click(function() {
                $("#staff-div").show();
                //$("#nonstaff-div").hide();
                //$("#nonstaff-div-2").hide();
                $("#person\\.firstName").attr('disabled', true);
                $("#person\\.lastName").attr('disabled', true);
                $("#person\\.personDetails\\.annualCompensation").attr('disabled', true);
                $("#datepicker").attr('disabled', true);


            });
            $("#staffNo").click(function() {
                $("#staff-div").hide();
                //$("#nonstaff-div").show();
                //$("#nonstaff-div-2").show();
                $("#person\\.firstName").removeAttr("disabled");
                $("#person\\.lastName").removeAttr("disabled");
                $("#person\\.personDetails\\.annualCompensation").removeAttr("disabled");
                $("#datepicker").removeAttr("disabled");
                $("#person\\.firstName").val('');
                $("#person\\.lastName").val('');
                $("#person\\.personDetails\\.annualCompensation").val('');
                $("#datepicker").val('');
            });


            $("#person").change(function() {
                if ($("#person").val() == -1) {
                    //enable fields
                    $("#person\\.firstName").removeAttr("disabled");
                    $("#person\\.lastName").removeAttr("disabled");
                    $("#person\\.personDetails\\.annualCompensation").removeAttr("disabled");
                    $("#datepicker").removeAttr("disabled");
                    $("#person\\.firstName").val('');
                    $("#person\\.lastName").val('');
                    $("#person\\.personDetails\\.annualCompensation").val('');
                    $("#datepicker").val('');
                    $("#person\\.personDetails\\.isStaff").val('false');
                } else {
                    $.get('<c:url value="/bank/getPersonDetails.do"/>', { id: $(this).val()}, function(data) {
                        var details = data.personDetails;
                        $("#person\\.firstName").val(details.firstName);
                        $("#person\\.lastName").val(details.lastName);
                        $("#person\\.personDetails\\.annualCompensation").val(details.annualCompensation);
                        $("#datepicker").val(details.dateOfBirth);
                        $("#person\\.personDetails\\.isStaff").val('true');

                        //disable fields
                        $("#person\\.firstName").attr('disabled', true);
                        $("#person\\.lastName").attr('disabled', true);
                        $("#person\\.personDetails\\.annualCompensation").attr('disabled', true);
                        $("#datepicker").attr('disabled', true);
                    });
                }
            });

        });


    </script>

<!--  END BUCKET --></div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
  <script type="text/javascript">
  function showOfficerForm(){
		$("#gridOfficer").hide();	
		$("#formOfficer").show();
	}

function hideOfficerForm(){
	$("#formOfficer").hide();	
	$("#gridOfficer").show();
}
</script> 

<script type="text/javascript">
    $(document).ready(function() {

        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name.");

    });

    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
    	 $("#saveOfficers").click(function() {
        var container = $('div.error_container');
        // validate the form when it is submitted
        var validator = $("#party").validate({

            rules: {
                'person': {required: true, min:1},
                'person.firstName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
                'person.lastName':{required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
                'person.dateOfBirth': {date: true},
                'person.personDetails.annualCompensation': {digits: true},
                'person.personDetails.codeTypeOfShare' : {required: true, min:1},
                'person.personDetails.noOfSharesOwned': {digits: true,range:[0,100000]}
            },
            messages: {
                'person': "Select one Staff",
                'person.firstName': {
                    required: "First Name is required",
                    alphabetsOnly:"No Special Charcters allowed. Please enter a First Name",
                    minlength: "Enter First Name with at least {0} characters.",
                    maxlength: "Enter First Name with no more than {0} characters."},
                'person.lastName': {
                    required: "Last Name is required",
                    alphabetsOnly:"No Special Charcters allowed. Please enter a Last Name",
                    minlength: "Enter Last Name with at least {0} characters.",
                    maxlength: "Enter Last Name with no more than {0} characters."},
                'person.dateOfBirth': {
                    required: "Date of Birth is required",
                    date: "No Special Charcters allowed. enter a valid Date Of Birth in the format dd/mm/yyyy"},
                'person.personDetails.annualCompensation': {
                    required: "Annual Compensation is required",
                    digits:"No Special Charcters allowed.Please enter Annual Compensation."},
                'person.personDetails.codeTypeOfShare': "Enter Types of share",
                'person.personDetails.noOfSharesOwned': {
                    required: "Number of Shares Owned is required",
                    digits: "Enter Number of Shares Owned only digits.",
                    range: $.validator.format("Max Number of Shares Owned can be 100000.")}
            },
            errorContainer: container,
            errorLabelContainer: $("ol", container),
            wrapper: 'li',
            meta: "validate"
        });
        $("#party").submit();
         });

        $(".cancel").click(function() {
            validator.resetForm();
        });
    });
</script>