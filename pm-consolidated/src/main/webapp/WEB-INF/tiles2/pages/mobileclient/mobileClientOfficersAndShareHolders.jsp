<%@ include file="../../layout/PM-INCLUDES.jsp"%>

<!--  BUCKET -->
<c:url value="/mobileclient/mobileClientOfficersAndShareHolders.do"
	var="mobileclientOfficersAndShareHoldersUrl">
	<c:param name="clientId" value="${param.clientId}" />
</c:url>
<input type="hidden" id="clientId" name="clientId"
	value="${param.clientId }" />

<div data-role="controlgroup" data-type="horizontal" class="ui-btn-left">
	<button data-role='button' data-theme='a' data-action="delete"
		id="deleteRec">Delete</button>
</div>
<div id="confirmDelete" class="modal" style="display: none;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
			class="icon-book blue"></i> Delete Estimates</span>
	</div>
	<div class="modal-body">
		<span class="f12em">The selected estimates will be deleted.
			Deleted estimates can be restored again, worry not. Do you want to
			continue?</span>

	</div>
	<div class="modal-footer">
		<span id="deletedRec" data-action="deletedRec" class="btn btn-success">Yes</span>
		<span data-dismiss="modal" class="btn btn-success">Cancel</span>
	</div>
</div>

<div id="selectDelRec" class="modal" style="display: none;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">X</a> <span class="f12em b red"><i
			class="icon-book blue"></i> No data selected</span>
	</div>
	<div class="modal-body">
		<span class="f12em">Please select one or more rows</span>

	</div>
	<div class="modal-footer">
		<span id="selectedRe" data-action="deletedRec" class="btn btn-success">Ok</span>
		<span data-dismiss="modal" class="btn btn-success">Cancel</span>
	</div>
</div>

<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
	<a href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>"
		style="text-decoration: none;">
		<button type="button" id="show" onclick="showOfficerForm()"
			class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
			role="button" aria-disabled="false" data-inline="true"
			data-mini="true">
			<span class="ui-button-text">New Officers&ShareHolders</span>
		</button>
	</a>&nbsp;&nbsp;
</security:authorize>

<div id="grid_wrapper" style="overflow: auto;">
	<table border="0"
		class="table table-striped table-hover table-bordered mb20"
		id="getAllOff">
		<caption title="" class="captionFont">Officers And Share
			Holders List</caption>
		<colgroup>
			<col style="width: 5%;">
			<col style="width: 30%;">
			<col style="width: 25%;">
			<col style="width: 20%;">
			<col style="width: 20%;">
		</colgroup>
		<thead>
			<tr>
				<th class="cyan b center"></th>
				<th class="cyan b center">Name</th>
				<th class="cyan b center">Type Of Share</th>
				<th class="cyan b center">No Of Shares</th>
				<th class="cyan b center"></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<input type="hidden" name="inValidClientId" id="firmId"
		value="${firmId}" />
	<!-- <table id="taskGridlist"></table>
	 	<div id="pager" class="scroll"></div> -->
</div>
<script>
	$(function(){
		var clientId = ${clientId};
	var oTable =   $("#getAllOff").dataTable({
		"bJQueryMobileUI" : true,
		"bFilter" : true,
		"sPaginationType" : "bootstrap",
		"aaSorting" : [ [ 0, "desc" ] ],
		"bInfo" : true,
		"oLanguage" : {
			"sLengthMenu" : "_MENU_ records per page",
			"sProcessing" : "Loading.....",
			"sZeroRecords" : "No client is found. Click 'Add/Edit' tab to get started."
		},
		"sAjaxSource" : 'mobilePartyList.do?mainParty=' + clientId + '&relation=7',
		"bProcessing" : 'true',
		"bServerSide" : 'true',
		"bDeferRender" : 'false',
		"oTableTools" : {
			"sRowSelect" : "single"
		},
           "aoColumns": [
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											var retVal = '<input class="chcktbl" type="checkbox" name="selectGridRow" id="selectGridRow' + obj.aData[0] +'" value="' + obj.aData[0] + '"/>';
					                        return retVal;
					                    }
									},

									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[1];
										}
									},
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[2];
										}
									},
									{
										"bSortable" : false,
										"fnRender" : function(obj) {
											return obj.aData[3];
										}
									},
									{
										"sClass" : "jqmSorter",
										"fnRender" : function(obj) {
											return obj.aData[4];
										}
									} ]
						});
	});
	
	$('#deleteRec').click(function () {
        var selectedItems = [];
        $('input[name="selectGridRow"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        if (selectedItems.length == 0) {
             $('#selectDelRec').modal();
        } else if ($(this).data('action') == 'delete') {
            $('#confirmDelete').modal();
        }
    });
	$('#selectedRe').click(function(){
		$('#selectDelRec').modal('hide');
	});
    $('#deletedRec').click(function () {
    	
    	var selectedItems = [];
       $('input[name="selectGridRow"]:checked').each(function () {
           selectedItems.push($(this).val());

       });
        var URL;
			if ($(this).data('action') == 'deletedRec') {
            $('#confirmDelete').modal('hide');
            URL = 'saveOfficerAjaxList.do?id=' + selectedItems ;
        }
			 
	          
        $.ajax({
            type: "POST",
            url: URL,
            data: $('#party').serialize(),
            success: function (data) {
                if (data) {
               	$('#getAllOff').dataTable().fnDraw();
               	$.jGrowl('Record Deleted Sucessfully');
                }  else {
                    $.pnotify({
                        title: 'Error',
                        text: 'Please contact system support with details.',
                        type: 'error',
                        animation: 'fade'
                    });
                } 
            },
            error: function () {
                $.pnotify({
                    title: 'Error',
                    text: 'Error occurred during operation',
                    type: 'error',
                    animation: 'fade'
                });
            } 
        });


    });	
</script>

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

        function OfficerEdit(id){
        	var clientId = ${clientId};
        	window.location = 'mobileClientOfficersAndShareHolders.do?clientId='+clientId+'&id='+id;
        	return false;
        }
</script>

<!--  END BUCKET -->
</div>

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
    					$.ajax({
    						dataType: 'json',
    			            type: 'POST',
    					    data: $('#party').serialize(),
    			            url: 'mobileClientOfficersAndShareHolders.do',
    			            success: function(clientId) {
    				        if(clientId != -1){
    			        		$.jGrowl("Record saved successfully");	
    			    			var clientId = ${clientId};
    			    			console.log(clientId);
    			    			$('#getAllOff').dataTable().fnReloadAjax('partyList.do?mainParty=' + clientId + '&relation=7');
    			    			if($("#id").val()!="")
    			    				{
    			    				 $('#officerhome').show();
    			       				 $('#officerTabs a:first').tab('show');
    			       				 $('#foo').hide();
    			    				}
    			    			else{
    			        			document.getElementById("party").reset();
    			    			}
    			    			
    			        	}
    			        	 else{
    			        		 $.jGrowl("As Error has happened while process. ");	
    			        	 } 
    			        }
    				});
    					 return false;
         });

    });
</script>