<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
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

<!-- <script type="text/javascript">
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
    	 $("#save").click(function() {

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
</script> -->
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
/* 	var editId = $("#id").val();
	//alert("hi"+editId); 
	var editStatus=new Boolean();
	console.log(editId);
	  if (editId != "")
		{
		  editStatus = true;
		} */
	$("#offSave").click(function(){
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
            meta: "validate",
            submitHandler: function(form) {
	//	alert("save");
		$.ajax({
			dataType: 'json',
            type: 'POST',
		    data: $('#party').serialize(),
            url: 'clientOfficersAndShareHolders.do',
            success: function(clientId) {
	        if(clientId != -1){
        		$.jGrowl("Record saved successfully");	
        		//$("#officersStaffList").setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
    			var clientId = ${clientId};
    			console.log(clientId);
    			/* var tableName = '#getAllOff';
    			var gridURL = 'partyList.do?mainParty=' + clientId + '&relation=7';
    			reloadGrid(tableName, gridURL); */
    			$('#getAllOff').dataTable().fnReloadAjax('partyList.do?mainParty=' + clientId + '&relation=7');
    			if($("#id").val()!="")
    				{
    				 $('#officerhome').show();
       				 $('#officerTabs a:first').tab('show');
       				 $('#foo').hide();
    				}
    			else{
        			/* document.getElementById("party").reset(); */
    				$('#officerfoo').load('clientOfficersAndShareHolders.do');
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
   });
	$("#newOfficer").click(function(){
		$('#officerfoo').load('clientOfficersAndShareHolders.do');
		});
	  $(function() {
          $("#officerDatepicker").datepicker({
              changeMonth: true,
              changeYear: true,
              yearRange: '-40:+20'
          });
      });

});
</script>

<div class="well">
<!--  BUCKET -->

<div class="error_container">
	<h7><b>Please correct the following errors</b></h7>
    <ol></ol>
</div> 

<div class="fieldset">
<div class="f13">
    <form:form modelAttribute="party" method="POST" action="">
    <input type="hidden" id="firmId" name="firmId" value="${firm.id}"/>
    <input type="hidden" id="newPartyId" name="newPartyId" value="${party.id}"/>
    <input type="hidden" id="clientId" name="clientId" value="${clientId}"/>
    <input type="hidden" id="relationType" name="relationType" value="7"/>
    <input type="hidden" name="baseURL" id="baseURL" value="clientOfficersAndShareHolders.do"/>
    <input type="hidden" name="inValidClientId" value="${inValidClientId}"/>
    <form:hidden path="person.personDetails.isStaff"/>

    <form:hidden path="id"/>
    <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
	<b><strong>${inValidClientId}</strong> </b>
			      <div class="container_12 mt20">
			      </br>
				  <div class="row">	
				 <div class="span3">
            <form:label path="person"><spring:message code="label.staff"/></form:label>
            <form:select path="person" tabindex="1" cssClass="formSelect">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${staffListByClientId}" itemValue="key" itemLabel="value"/>
                   		</form:select>
            </div>
             <div class="span3">
            <form:label path="person.firstName"><spring:message code="label.firstname"/></form:label>
            <form:input cssClass="formInput" path="person.firstName" class="input"
                        tabindex="2"/>
                        </div>
            <div class="span3">
           <form:label path="person.lastName"><spring:message code="label.lastname"/></form:label>
            <form:input cssClass="formInput" path="person.lastName" class="input"
                        tabindex="3"/>
                        </div>
            </div>
            
                 <div class="row">	
				 <div class="span3">
           <form:label path="person.dateOfBirth"><spring:message code="label.dateofbirth"/></form:label>
            <form:input cssClass="formInput" path="person.dateOfBirth" id="officerDatepicker" class="input"
                        tabindex="4"/>
                        </div>
           <div class="span3">
           <form:label path="person.personDetails.annualCompensation"><spring:message code="label.annualcompensation"/></form:label>
           <form:input cssClass="formInput" path="person.personDetails.annualCompensation" class="input"
                        tabindex="5"/>
            </div>
            
             <div class="span3">
            <form:label path="person.personDetails.codeTypeOfShare"><spring:message code="label.typeofshares"/></form:label>
           <form:select path="person.personDetails.codeTypeOfShare" tabindex="6" cssClass="formSelect">
                        	<form:option value="-1" label="Select"/>
                             <form:options items="${sharesTypes}" itemValue="key" itemLabel="value"/>
                   		</form:select>
                   		 </div>
                   		  </div>
                <div class="row">	   		  
               <div class="span3">
            <form:label path="person.personDetails.noOfSharesOwned"><spring:message code="label.numberofshares"/></form:label>
           <form:input cssClass="formInput" path="person.personDetails.noOfSharesOwned" class="input"
                        tabindex="7"/>
            </div>
             </div> </br>

                      <div class="row">	
				     <div class="spa">
            	    <security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                    	<%-- <button type="button" id="newOfficer" class="btn btn-primary">
	                        	<span class="ui-button-text"><spring:message code="label.newofficersandshareholders"/></span>
	                    	</button> --%>
	                    	&nbsp;&nbsp;
	
	                	<button  id="offSave"
							class="btn btn-success">
							<c:if test="${party.id == null}">
							<span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</c:if>
							<c:if test="${party.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;	                	
	                    <a href="#home" onclick=offList(); data-toggle="tab" style="text-decoration:none;"> 
	                    <button type="button"
	                        	class="btn btn-success" aria-disabled="false">
	                     	<span class="ui-button-text"><spring:message code="label.backToList"/></span>
	                    </button>
	                    </a>

            	</security:authorize>
            	<%-- <security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${party.id != null}">
		                	<button type="button" id="offSave"
								class="btn btn-success">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                	
		                    <button type="reset"
		                        	class="btn btn-success">
		                       	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
		                    </button>
	            	</c:if>
            	</security:authorize> --%>
		        </div>
        	</div>
        	</div>    	
    	
</form:form>
</div>
    </div>
</div>

<div class="fieldset mt25 ml20 mr20">    
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
        function offList(){
         $('#officerTabs a:first').tab("show");
       	 $('#officerhome').show();
       	 $('#officerfoo').hide();
       }
    </script>

        
    <script type="text/javascript">
        $(document).ready(function() {
        	var partyId = $("#newPartyId").val();
        	console.debug(partyId);
        	if(partyId){
        		 $("#person\\.firstName").attr('disabled', true);
                 $("#person\\.lastName").attr('disabled', true);
                 $("#person\\.personDetails\\.annualCompensation").attr('disabled', true);
                 $("#officerDatepicker").attr('disabled', true);
        	}
            $("#staffYes").click(function() {
                $("#staff-div").show();
                //$("#nonstaff-div").hide();
                //$("#nonstaff-div-2").hide();
                $("#person\\.firstName").attr('disabled', true);
                $("#person\\.lastName").attr('disabled', true);
                $("#person\\.personDetails\\.annualCompensation").attr('disabled', true);
                $("#officerDatepicker").attr('disabled', true);


            });
            $("#staffNo").click(function() {
                $("#staff-div").hide();
                //$("#nonstaff-div").show();
                //$("#nonstaff-div-2").show();
                $("#person\\.firstName").removeAttr("disabled");
                $("#person\\.lastName").removeAttr("disabled");
                $("#person\\.personDetails\\.annualCompensation").removeAttr("disabled");
                $("#officerDatepicker").removeAttr("disabled");
                $("#person\\.firstName").val('');
                $("#person\\.lastName").val('');
                $("#person\\.personDetails\\.annualCompensation").val('');
                $("#officerDatepicker").val('');
            });


            $("#person").change(function() {
                if ($("#person").val() == -1) {
                    //enable fields
                    $("#person\\.firstName").removeAttr("disabled");
                    $("#person\\.lastName").removeAttr("disabled");
                    $("#person\\.personDetails\\.annualCompensation").removeAttr("disabled");
                    $("#officerDatepicker").removeAttr("disabled");
                    $("#person\\.firstName").val('');
                    $("#person\\.lastName").val('');
                    $("#person\\.personDetails\\.annualCompensation").val('');
                    $("#officerDatepicker").val('');
                    $("#person\\.personDetails\\.isStaff").val('false');
                } else {
                    $.get('<c:url value="/bank/getPersonDetails.do"/>', { id: $(this).val()}, function(data) {
                        var details = data.personDetails;
                        $("#person\\.firstName").val(details.firstName);
                        $("#person\\.lastName").val(details.lastName);
                        $("#person\\.personDetails\\.annualCompensation").val(details.annualCompensation);
                        $("#officerDatepicker").val(details.dateOfBirth);
                        $("#person\\.personDetails\\.isStaff").val('true');

                        //disable fields
                        $("#person\\.firstName").attr('disabled', true);
                        $("#person\\.lastName").attr('disabled', true);
                        $("#person\\.personDetails\\.annualCompensation").attr('disabled', true);
                        $("#officerDatepicker").attr('disabled', true);
                    });
                }
            });

        });
        $(function() {
            $("#officerDatepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-40:+20'
            });
        });

    </script>


</div>
<!--  END BUCKET --></div>
<script type="text/javascript">
$(document).ready(function(){
<c:if test="${statusMessageKey eq 'save.msg.success'}">
   $.jGrowl('Record Saved Sucessfully'); 
</c:if>
   
 });
 </script>
 
