<%-- <%@ include file="../../layout/PM-INCLUDES.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<!-- <script type="text/javascript">
var label;
var errormsg;
    $(document).ready(function() {

        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name.");

        $.validator.addMethod("alphaNumeric", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);
        }, "Please enter valid Number.");

        $.validator.addMethod("webUrl", function(value, element) {
            return this.optional(element) || /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i.test(value);
        }, "Please enter valid Web URL.");

        $.validator.addMethod("phoneValidaion", function(value, element) {
            return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
        }, "Please enter valid Phone Number. For Ex: 646-222-3333");

        $.validator.addMethod("faxValidaion", function(value, element) {
            return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
        }, "Please enter valid Fax Number. For Ex: 123-456-7890");

        $.validator.addMethod('postalCode', function(value, element) {
        	errormsg = 'Please enter a valid postal code.';
        	if(label == 'CANADA'){
        		errormsg = 'Please enter a valid postal code. Ex: A1B 2C3';
               return this.optional(element) || /^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/i.test(value);
        	}
        	else if(label == 'INDIA'){
        		errormsg = 'Please enter a valid postal code. Ex: 123456';
        	    return this.optional(element) || /^(\d{6})$/i.test(value);	
        	}
        	else if(label == 'USA'){
        		errormsg = 'Please enter a valid postal code. Ex: 12345';
        	    return this.optional(element) || /^(\d{5})$/i.test(value);		
        	}else{
        		errormsg = 'Please enter a valid postal code.';
        		return this.optional(element) || /^[0-9]+$/i.test(value);		
        	}
        }, "Please enter a valid postal code.");
        
        $.validator.addMethod("addressValidation", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-_#&{},.;\s]+$/i.test(value);
        }, "No Special Character allowed.");

    });
    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
    	 $("#save").click(function() {
        
        partyId = $("#partyId").val();
        var container = $('div.error_container');
        // validate the form when it is submitted
        var validator = $("#party").validate({

            rules: {
                'person.personType': {required: true,min:1},
                'person.firstName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
                'person.lastName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
                'person.personDetails.codeByJobTitleCode': {min:1},
                'person.personDetails.comittee': {alphabetsOnly: true,minlength: 0,maxlength: 50},
                'person.dateOfBirth': {required: true,date: true},
                'person.personDetails.annualCompensation': {required: true,digits: true,minlength: 1,maxlength: 15},

                'defaultPartySite.defaultPointOfContact.webUrlList[0].contactDetail': {webUrl:true},
                'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {required: true,email:true},
                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {faxValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {required: true, phoneValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[0].subType': {required: true,min:1},
                'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {required: true, phoneValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[1].subType': {required: true,min:1},
                'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {required: true, phoneValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[2].subType': {required: true,min:1},
                'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {required: true, phoneValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[3].subType': {required: true,min:1},
                'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {required: true, phoneValidaion: true},
                'defaultPartySite.defaultPointOfContact.phoneList[4].subType': {required: true,min:1},

                'defaultPartySite.address.addressLine1': {addressValidation:true,minlength: 0,maxlength: 100},
                'defaultPartySite.address.addressLine2': {addressValidation:true,minlength: 0,maxlength: 100},
                'defaultPartySite.address.countryCode': {},
                'defaultPartySite.address.stateCode': {},
                'defaultPartySite.address.city': {alphabetsOnly:true,minlength: 0,maxlength: 50},
                'defaultPartySite.address.postalCode': {postalCode:true,maxlength: 10}, 


                'organization.legalName': {alphabetsOnly: true,minlength: 0,maxlength: 50}
            },
            messages: {
                'person.personType': "Select one Role",
                'person.firstName': {
                    required: "First Name is required",
                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid First Name",
                    minlength: "Enter First Name with at least {0} characters.",
                    maxlength: "Enter First Name with no more than {0} characters."},
                'person.lastName': {
                    required: "Last Name is required",
                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid 	Last Name",
                    minlength: "Enter Last Name with at least {0} characters.",
                    maxlength: "Enter Last Name with no more than {0} characters."},
                'person.personDetails.codeByJobTitleCode': "Select one Title",
                'person.personDetails.comittee': {
                    required: "Committee is required",
                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid Committee Name",
                    minlength: "Enter Committee with at least {0} characters.",
                    maxlength: "Enter Committee with no more than {0} characters."},
                'person.dateOfBirth': {
                    required: "Date Of Birth is required",
                    date:"No Special Charcters allowed. please enter a valid Date Of Birth in the format dd/mm/yyyy"},
                'person.personDetails.annualCompensation': {
                    required: "Annual Compensation is required",
                    digits: "Please enter valid Annual Compensation with numeric only.",
                    minlength: "Enter Annual Compensation with at least {0} characters.",
                    maxlength: "Enter Annual Compensation with no more than {0} characters."},


                'defaultPartySite.defaultPointOfContact.webUrlList[0].contactDetail': {
                    required: "Web is required"},
                'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {
                    required: "Email Address is required",
                    email: "Please enter valid Email Address."},
                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {
                    required: "Fax is required",
                    faxValidaion:"No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890",
                    digits: "Enter Fax only digits."},
                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {
                    required: "1st Phone No. is required",
                    phoneValidaion:"Please enter valid Phone 1st Number. For Ex: 646-222-3333"},
                'defaultPartySite.defaultPointOfContact.phoneList[0].subType': "Select one Phone Type for 1st Phone No.",
                'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {
                    required: "2nd Phone No. is required",
                    phoneValidaion:"Please enter valid Phone 2nd Number. For Ex: 646-222-3333"
                },
                'defaultPartySite.defaultPointOfContact.phoneList[1].subType': "Select one Phone Type for 2nd Phone No.",
                'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {
                    required: "3rd Phone No. is required",
                    phoneValidaion:"Please enter valid Phone 3rd Number. For Ex: 646-222-3333"
                },
                'defaultPartySite.defaultPointOfContact.phoneList[2].subType': "Select one Phone Type for 3rd Phone No.",
                'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {
                    required: "4th Phone No. is required",
                    phoneValidaion:"Please enter valid Phone 4th Number. For Ex: 646-222-3333"},

                'defaultPartySite.defaultPointOfContact.phoneList[3].subType': "Select one Phone Type for 4th Phone No.",
                'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {
                    required: "5th Phone No. is required",
                    phoneValidaion:"Please enter valid Phone 5th Number. For Ex: 646-222-3333"},
                'defaultPartySite.defaultPointOfContact.phoneList[4].subType': "Select one Phone Type for 5th Phone No.",




                'defaultPartySite.address.addressLine1': {
                    required: "Address Line 1 is required",
                    addressValidation:"No Special Character allowed in Address Line 1.",
                    minlength: "Enter Address Line 1 with at least {0} characters.",
                    maxlength: "Enter Address Line 1 with no more than {0} characters."},
                'defaultPartySite.address.addressLine2': {
                    required: "Address Line 2 is required",
                    addressValidation:"No Special Character allowed in Address Line 2.",
                    minlength: "Enter Address Line 2 with at least {0} characters.",
                    maxlength: "Enter Address Line 2 with no more than {0} characters."},
                'defaultPartySite.address.countryCode': "Select one Country",
                'defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
                'defaultPartySite.address.city': {
                    required: "City is required",
                    alphabetsOnly:"Please enter a valid City Name.No Special Charcters allowed. ",
                    minlength: "Enter City with at least {0} characters.",
                    maxlength: "Enter City with no more than {0} characters."},
                'defaultPartySite.address.postalCode': {
                    required: "Postal Code is required",
                    postalCode: "Please enter a valid postal code."+errormsg,
                    digits: "Enter Postal Code only digits.",
                    maxlength : "Enter Postal Code with no more than {0} characters."},



                'organization.legalName': {
                    required: "Firm Name is required",
                    minlength: "Enter Firm Name with at least {0} characters.",
                    maxlength: "Enter Firm Name with no more than {0} characters."}

            },
            errorContainer: container,
            errorLabelContainer: $("ol", container),
            wrapper: 'li',
            meta: "validate"
        });
        $("#party").submit();
         });

    });
</script> -->
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
<script type="text/javascript">
var label;
var errormsg;
    $(document).ready(function() {

        $.validator.addMethod("alphabetsOnly", function(value, element) {
            return this.optional(element) || /^\s*[a-zA-Z.\s]+\s*$/i.test(value);
        }, "Please enter a valid Name.");

        $.validator.addMethod("alphaNumeric", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-]+$/i.test(value);
        }, "Please enter valid Number.");

        $.validator.addMethod("webUrl", function(value, element) {
            return this.optional(element) || /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&amp;?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/i.test(value);
        }, "Please enter valid Web URL.");

        $.validator.addMethod("phoneValidaion", function(value, element) {
            return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
        }, "Please enter valid Phone Number. For Ex: 646-222-3333");

        $.validator.addMethod("faxValidaion", function(value, element) {
            return this.optional(element) || /^(\d{3}-\d{3}-\d{4})*$/i.test(value);
        }, "Please enter valid Fax Number. For Ex: 123-456-7890");

        $.validator.addMethod('postalCode', function(value, element) {
        	errormsg = 'Please enter a valid postal code.';
        	if(label == 'CANADA'){
        		errormsg = 'Please enter a valid postal code. Ex: A1B 2C3';
               return this.optional(element) || /^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/i.test(value);
        	}
        	else if(label == 'INDIA'){
        		errormsg = 'Please enter a valid postal code. Ex: 123456';
        	    return this.optional(element) || /^(\d{6})$/i.test(value);	
        	}
        	else if(label == 'USA'){
        		errormsg = 'Please enter a valid postal code. Ex: 12345';
        	    return this.optional(element) || /^(\d{5})$/i.test(value);		
        	}else{
        		errormsg = 'Please enter a valid postal code.';
        		return this.optional(element) || /^[0-9]+$/i.test(value);		
        	}
        }, "Please enter a valid postal code.");
        
        $.validator.addMethod("addressValidation", function(value, element) {
            return this.optional(element) || /^[0-9A-Z-_#&{},.;\s]+$/i.test(value);
        }, "No Special Character allowed.");

    });
    // only for demo purposes
    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });


$().ready(function() {
	$("#staffSave").click(function(){
		  partyId = $("#partyId").val();
	        var container = $('div.error_container');
	        // validate the form when it is submitted
	        var validator = $("#party").validate({

	            rules: {
	                'person.personType': {required: true,min:1},
	                'person.firstName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.lastName': {required: true,alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.personDetails.codeByJobTitleCode': {min:1},
	                'person.personDetails.comittee': {alphabetsOnly: true,minlength: 0,maxlength: 50},
	                'person.dateOfBirth': {required: true,date: true},
	                'person.personDetails.annualCompensation': {required: true,digits: true,minlength: 1,maxlength: 15},

	                'defaultPartySite.defaultPointOfContact.webUrlList[0].contactDetail': {webUrl:true},
	                'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {required: true,email:true},
	                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {faxValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].subType': {required: true,min:1},
	                'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[1].subType': {required: true,min:1},
	                'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[2].subType': {required: true,min:1},
	                'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[3].subType': {required: true,min:1},
	                'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {required: true, phoneValidaion: true},
	                'defaultPartySite.defaultPointOfContact.phoneList[4].subType': {required: true,min:1},

	                'defaultPartySite.address.addressLine1': {addressValidation:true,minlength: 0,maxlength: 100},
	                'defaultPartySite.address.addressLine2': {addressValidation:true,minlength: 0,maxlength: 100},
	                'defaultPartySite.address.countryCode': {},
	                'defaultPartySite.address.stateCode': {},
	                'defaultPartySite.address.city': {alphabetsOnly:true,minlength: 0,maxlength: 50},
	                'defaultPartySite.address.postalCode': {postalCode:true,maxlength: 10}, 


	                'organization.legalName': {alphabetsOnly: true,minlength: 0,maxlength: 50}
	            },
	            messages: {
	                'person.personType': "Select one Role",
	                'person.firstName': {
	                    required: "First Name is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid First Name",
	                    minlength: "Enter First Name with at least {0} characters.",
	                    maxlength: "Enter First Name with no more than {0} characters."},
	                'person.lastName': {
	                    required: "Last Name is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid 	Last Name",
	                    minlength: "Enter Last Name with at least {0} characters.",
	                    maxlength: "Enter Last Name with no more than {0} characters."},
	                'person.personDetails.codeByJobTitleCode': "Select one Title",
	                'person.personDetails.comittee': {
	                    required: "Committee is required",
	                    alphabetsOnly: "No Special Charcters allowed. Please enter a valid Committee Name",
	                    minlength: "Enter Committee with at least {0} characters.",
	                    maxlength: "Enter Committee with no more than {0} characters."},
	                'person.dateOfBirth': {
	                    required: "Date Of Birth is required",
	                    date:"No Special Charcters allowed. please enter a valid Date Of Birth in the format dd/mm/yyyy"},
	                'person.personDetails.annualCompensation': {
	                    required: "Annual Compensation is required",
	                    digits: "Please enter valid Annual Compensation with numeric only.",
	                    minlength: "Enter Annual Compensation with at least {0} characters.",
	                    maxlength: "Enter Annual Compensation with no more than {0} characters."},


	                'defaultPartySite.defaultPointOfContact.webUrlList[0].contactDetail': {
	                    required: "Web is required"},
	                'defaultPartySite.defaultPointOfContact.emailList[0].contactDetail': {
	                    required: "Email Address is required",
	                    email: "Please enter valid Email Address."},
	                'defaultPartySite.defaultPointOfContact.faxList[0].contactDetail': {
	                    required: "Fax is required",
	                    faxValidaion:"No Special Charcters allowed. Please enter a Valid Fax Number. For Ex: 123-456-7890",
	                    digits: "Enter Fax only digits."},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].contactDetail': {
	                    required: "1st Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 1st Number. For Ex: 646-222-3333"},
	                'defaultPartySite.defaultPointOfContact.phoneList[0].subType': "Select one Phone Type for 1st Phone No.",
	                'defaultPartySite.defaultPointOfContact.phoneList[1].contactDetail': {
	                    required: "2nd Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 2nd Number. For Ex: 646-222-3333"
	                },
	                'defaultPartySite.defaultPointOfContact.phoneList[1].subType': "Select one Phone Type for 2nd Phone No.",
	                'defaultPartySite.defaultPointOfContact.phoneList[2].contactDetail': {
	                    required: "3rd Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 3rd Number. For Ex: 646-222-3333"
	                },
	                'defaultPartySite.defaultPointOfContact.phoneList[2].subType': "Select one Phone Type for 3rd Phone No.",
	                'defaultPartySite.defaultPointOfContact.phoneList[3].contactDetail': {
	                    required: "4th Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 4th Number. For Ex: 646-222-3333"},

	                'defaultPartySite.defaultPointOfContact.phoneList[3].subType': "Select one Phone Type for 4th Phone No.",
	                'defaultPartySite.defaultPointOfContact.phoneList[4].contactDetail': {
	                    required: "5th Phone No. is required",
	                    phoneValidaion:"Please enter valid Phone 5th Number. For Ex: 646-222-3333"},
	                'defaultPartySite.defaultPointOfContact.phoneList[4].subType': "Select one Phone Type for 5th Phone No.",




	                'defaultPartySite.address.addressLine1': {
	                    required: "Address Line 1 is required",
	                    addressValidation:"No Special Character allowed in Address Line 1.",
	                    minlength: "Enter Address Line 1 with at least {0} characters.",
	                    maxlength: "Enter Address Line 1 with no more than {0} characters."},
	                'defaultPartySite.address.addressLine2': {
	                    required: "Address Line 2 is required",
	                    addressValidation:"No Special Character allowed in Address Line 2.",
	                    minlength: "Enter Address Line 2 with at least {0} characters.",
	                    maxlength: "Enter Address Line 2 with no more than {0} characters."},
	                'defaultPartySite.address.countryCode': "Select one Country",
	                'defaultPartySite.address.stateCode': "Select any one Country to get State/Province",
	                'defaultPartySite.address.city': {
	                    required: "City is required",
	                    alphabetsOnly:"Please enter a valid City Name.No Special Charcters allowed. ",
	                    minlength: "Enter City with at least {0} characters.",
	                    maxlength: "Enter City with no more than {0} characters."},
	                'defaultPartySite.address.postalCode': {
	                    required: "Postal Code is required",
	                    postalCode: "Please enter a valid postal code."+errormsg,
	                    digits: "Enter Postal Code only digits.",
	                    maxlength : "Enter Postal Code with no more than {0} characters."},



	                'organization.legalName': {
	                    required: "Firm Name is required",
	                    minlength: "Enter Firm Name with at least {0} characters.",
	                    maxlength: "Enter Firm Name with no more than {0} characters."}

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
            url: 'clientStaff.do',
            success: function(clientId) {
            	$('#cboxClose').click();
	            if(clientId != -1){
        		$.jGrowl("Record saved successfully");	
        		$("#clientStaff").setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
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
	  $("#newStaff").click(function(){
		 //alert("fghhg");
			$('#stffoo').load('clientStaff.do');
	}); 
	 
	 $("#cancel").click(function(){
		 $('#cboxClose').click();
		 return false;
	 })

});
</script>
<div class="row-fluid">
<div class="span1"></div>
<div class="span10">
        <form:form modelAttribute="party" method="POST" action="">
       <input type="hidden" id="clientId" name="clientId" value="${clientId }"/> 
            <input type="hidden" name="baseURL" id="baseURL" value="clientStaff.do"/>
            <input type="hidden" name="partyId" id="partyId" value="${party.id}"/>
            <input type="hidden" name="inValidClientId" value="${inValidClientId }" />
            <i><b><form:errors path="*" class="errorblock" element="div"/></b></i>
             <c:if test="${not empty statusMessageKey}">
                <span class="message"><fmt:message key="${statusMessageKey}"/></span>
            </c:if> 
            <form:hidden path="id"/>
            <form:hidden path="createUserId" value="system"/>
			<b><strong>${inValidClientId}</strong></b>
			   <center> 
					<c:if test="${not empty invalidEmilId}">
						<b><font color="red"><c:out value="${invalidEmilId}"/></font></b>
					</c:if>
				</center>
                <!-- Sample code just for one row in client staff -->
                </br>
                </br>
               <div class="container_12 mt20">
				 <div class="row">	
				<div class="span3">
                    <form:label path="person.firstName"><spring:message code="label.firstname"/></form:label>
                    <form:input path="person.firstName" cssClass="input_full" tabindex="1"/>
                 </div>  
                 <div class="span3">
                  <form:label   path="person.lastName"><spring:message code="label.lastname"/></form:label>
                  <form:input path="person.lastName" cssClass="input_full" tabindex="2"/>
                </div>
                   <div class="span3">
                    <form:label  path="person.personDetails.codeByJobTitleCode"><spring:message code="label.title"/></form:label>
                    <form:select path="person.personDetails.codeByJobTitleCode" tabindex="3" cssClass="input_full">
                        	<form:option value="-1" label="Select"/>
                            <form:options items="${titleCodeList}" itemValue="key" itemLabel="value"/>
                   		</form:select>
                    </div>
                    </div>
                     <div class="row">	
				     <div class="span3">
                   <form:label   path="person.personDetails.comittee" ><spring:message code="label.com"/></form:label> 
                     <form:label   path="person.personDetails.comittee" >Committee</form:label>
                    <form:input path="person.personDetails.comittee" cssClass="input_full" tabindex="4"/>
                    </div>
                    <div class="span3">
                    <form:label   path="person.dateOfBirth"><spring:message code="label.dateofbirth"/></form:label>
                    <form:input path="person.dateOfBirth" cssClass="input_full" id="datepicker" tabindex="5"/>
                    </div>
                    <div class="span3">
                    <form:label   path="person.personDetails.annualCompensation"><spring:message code="label.annualcompensation"/></form:label>
                    <form:input path="person.personDetails.annualCompensation" cssClass="input_full" tabindex="6"/>
                </div>
                </div>
                     <div class="row">	
				     <div class="span3">
                    <form:label   path="defaultPartySite.address.addressLine1"><spring:message code="label.addressline1"/></form:label>
                   <form:input path="defaultPartySite.address.addressLine1" cssClass="input_full" tabindex="7"/>
                    </div>
                   <div class="span3">
                   <form:label   path="defaultPartySite.address.addressLine2"><spring:message code="label.addressline2"/></form:label>
                   <form:input path="defaultPartySite.address.addressLine2" cssClass="input_full" tabindex="8"/>
                   </div>
                            <div class="span3">
                       <form:label   path="defaultPartySite.address.city"><spring:message code="label.city"/></form:label>
                    <form:input path="defaultPartySite.address.city" cssClass="input_full" tabindex="9"/>
                    </div>
                    </div>
                     <div class="row">	
				     <div class="span3">
                    <form:label   path="defaultPartySite.address.countryCode"><spring:message code="label.country"/></form:label>
                    <form:select path="defaultPartySite.address.countryCode" cssClass="input_full" tabindex="10">
                        	<form:option value="-1" label="Select"/>
                       	 	<form:options items="${countryCodeSet}" itemValue="key" itemLabel="value"/>
                    	</form:select>
                    </div>
                    <div class="span3">
                    <form:label  path="defaultPartySite.address.stateCode"><spring:message code="label.state"/></form:label>
                    <form:select path="defaultPartySite.address.stateCode" cssClass="input_full" tabindex="11">
                        	<form:option value="-1" label="Select"/>
                        	<form:options items="${statesSet}" itemValue="key" itemLabel="value"/>
                    	</form:select>
                    </div>
                    <div class="span3">
                    <form:label   path="defaultPartySite.address.postalCode"><spring:message code="label.postelcode"/></form:label>
                   <form:input path="defaultPartySite.address.postalCode" cssClass="input_full" tabindex="12"/>
                  </div>
                  </div>

                     <div class="row">	
				     <div class="span3">
                    <c:forEach items="${party.defaultPartySite.defaultPointOfContact.emailList}" var="email"
                                   varStatus="cStatus">
                      <form:label 
            						path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"><spring:message code="label.emailaddress"/></form:label>
                     
                         <form:hidden path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.emailList[${cStatus.index}].contactDetail"
                                    tabindex="13" id= "email" cssClass="input_full"/>
                      
                    </c:forEach>
                      </div>
                    <div class="span3">
                    <c:forEach items="${party.defaultPartySite.defaultPointOfContact.faxList}" var="email"
                                   varStatus="cStatus">
                       <form:label 
            						path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"><spring:message code="label.faxnumber"/></form:label>
                        
                         <form:hidden path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].id"/>
                            <form:hidden
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/>
                            <form:input
                                    path="defaultPartySite.defaultPointOfContact.faxList[${cStatus.index}].contactDetail"
                                    tabindex="14" cssClass="input_full"/>
                       
                    </c:forEach>
                </div>

                  <div class="span6">
            			<form:label path="defaultPartySite.defaultPointOfContact.phoneList"><spring:message code="label.phoneno"/></form:label>
                       
                     <div class="grid_4">
            			<c:set var="phoneCount" value="0"/>
            			<c:set var="tabOrder" value="15"/>
            			<c:forEach items="${party.defaultPartySite.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			                <table width="100%">
			                    <tr class="phonerow">
			                        <!-- <td width="10%" align="right"><b>No.</b></td> -->
			                        <td width="20%"><form:input style="width: 150px;"
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].contactDetail"
			                                cssClass="input phoneField" tabindex="${tabOrder}"/>
			                        </td>
			                        <form:hidden
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].id"
			                                class="input_h1_id"/>
			                        <form:hidden
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact"
			                                class="input_h1"/>
									<td width="3%"></td>
			                        <% /** Phone Type **/ %>
			                         <td width="7%" class="grid_4 right" style="text-align:top;"><spring:message code="label.phonetype"/></td>
			                        <c:set var="displayStyle" value="display:show;"/>
			                        <c:if test="${phoneCount == 0}">
			                            <c:set var="displayStyle" value="display:none;"/>
			                        </c:if>
			                        <c:set var="tabOrder" value="${tabOrder}++"/>
			                        <td class="row-nav1"><form:select style="width: 120px;"
			                                path="defaultPartySite.defaultPointOfContact.phoneList[${cStatus.index}].subType"
			                                id="phone_type" cssClass="phone_type" tabindex="${tabOrder}">
			                            <form:option value="-1" label="Select"/>
			                            <form:options items="${phoneCommunicationTypeSet}"
			                                          itemValue="value" itemLabel="key"/>
			                        </form:select>
			
			                            <a href="javascript:;" class="addphone" style="text-decoration:none;"><img
			                                src="<c:url value='/images/add_icon.gif'/>" width="20"
			                                height="15" alt="Add Phone Number" title="Add Phone Number"
			                                class="addicon" />
			                        </a> &nbsp; 
			                        <a href='javascript:;' class='removeicon'
			                                       style="${displayStyle}"><img
			                                src='<c:url value='/images/remove_icon.gif'/>' width='20'
			                                height='15' alt='Remove Phone Number'
			                                title='Remove Phone Number'/>
			                        </a>
			                        </td>
			                    </tr>
			                    <c:set var="phoneCount" value="${phoneCount}++"/>
			                </table>
			            </c:forEach>

            		</div>
            	</div>
            	</div>
            
            <form:hidden path="defaultPartySite.defaultPointOfContact.contactName" class="input"
                             value="${party.name}"/>
            <form:hidden path="defaultPartySite.defaultPointOfContact.contactTitle" class="input"
                             value="${party.name}"/>

                     <div class="row">	
				     <div class="span">
            	<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	                    	<button type="button" id="newStaff"
	                        	    class="btn btn-primary"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.newstaff"/></span>
	                    	</button>&nbsp;&nbsp;
	
	                	<button  id="staffSave" class="btn btn-success">
							<c:if test="${party.id == null}">
							<span class="ui-button-text" tabindex="16"><spring:message code="label.save"/></span>
							</c:if>
							<c:if test="${party.id != null}">
	    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
	    	                </c:if>
						</button>
						&nbsp;&nbsp;
	                	
	                    	<button id="cancel"
	                            	class="btn btn-success"
	                            	role="button" aria-disabled="false">
	                        	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
	                    	</button>
            	</security:authorize>
            	<security:authorize access="hasAnyRole('ROLE_STAFF','ROLE_FIRM_ADMIN')">
            		<c:if test="${party.id != null}">
		                	<button type="button" id="staffSave"
								class="btn btn-success"
								role="button" aria-disabled="false">
		    	                <span class="ui-button-text" tabindex="16"><spring:message code="label.update"/></span>
							</button>
							&nbsp;&nbsp;
		                    <button id="cancel"
		                        	class="btn btn-success"
		                           	role="button" aria-disabled="false">
		                       	<span class="ui-button-text"><spring:message code="label.cancel"/></span>
		                    </button>
	            	</c:if>
            	</security:authorize>
		        </div>
        	</div>
        	</div>
        </form:form>
</div>
<div class="span1"></div>
</div>

<!-- <script type="text/javascript" charset="utf-8">
    $('.addicon').click(function() {
        if ($("tr.phonerow").length < 5) {
            var x = $("input[class^='input phoneField']").length;

            $("table tbody").find("tr.phonerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr({
                name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].contactDetail',
                id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].contactDetail'})
                    .val("");

            $("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr({
                name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].subType',
                id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].subType'})
                    .val("");

            $("table tbody").find("tr.phonerow:last").find("input[class='input_h1_id']").attr({
                name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].id',
                id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].id'})
                    .val("");


            $("table tbody").find("tr.phonerow:last").find("input[class='input_h1']").attr({
                name: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].pointOfContact',
                id: 'defaultPartySite.defaultPointOfContact.phoneList[' + (x) + '].pointOfContact'});


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
        //alert('Hello Sai');
        firmId = ${firm.id};
        $("#defaultPartySite\\.address\\.countryCode").change(function() {
        	label = $('#defaultPartySite\\.address\\.countryCode option:selected').text();
        	 if(label == 'CANADA'){
     			errormsg = 'Ex: A1B 2C3';
     		}
     		else if(label == 'INDIA'){
     			errormsg = ' Ex: 123456';
     		}
     		else if(label == 'USA'){
     			errormsg = 'Ex: 12345';
     		}else{
     			errormsg = '';	
     		}
        	 
            $.get("<c:url value='/getStates.do'/>", { countryId: $(this).val(), firmId:firmId }, function(data) {
                populateDropdown($("#defaultPartySite\\.address\\.stateCode"), data);
            });
        });
    });

    function populateDropdown(select, data) {
        select.html('');
        select.append($('<option></option>').val("-1").html("Select"));
        $.each(data, function(id, option) {
            $.each(option, function(id, option) {
                select.append($('<option></option>').val(option.key).html(option.value));

            });
        });
    }
</script>
  <script type="text/javascript">
	$(document).ready(function() {
			 if($("#partyId").val() == "")  {
				 $("#person\\.personType").removeAttr("disabled");
				 $("#email").removeAttr("disabled");
			 }else{
				 $("#person\\.personType").attr('disabled', true);
				 $("#email").attr('disabled', true);
			 }
	});
	 $(function() {
         $("#datepicker").datepicker({
             changeMonth: true,
             changeYear: true,
             yearRange: '-40:+20'
         });
     });
</script> 
 -->
 
		 --%>