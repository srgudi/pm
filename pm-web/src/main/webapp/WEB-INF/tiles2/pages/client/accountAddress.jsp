<table  class="table-long">
     <tbody>
     <h3>Address Details </h3>
          <tr class="odd">
                <td class="col-first">Address Line 1</td>
                <td class="col-second">
               	 <form:input path="address.addressLine1" class="input align-left" />
				 <a href='javascript:;' class='align-left print' ><img src='<c:url value='/images/printerIcon.gif'/>' alt='print' title='print'/></a>
				 </td>
				   <td class="col-first">Address Line 2</td>
                <td class="col-second">
               	 <form:input path="address.addressLine2"  class="input align-left"/>
				 <a href='javascript:;' class='align-left print'><img src='<c:url value='/images/printerIcon.gif'/>' alt='print' title='print'/></a>
				 </td>
              </tr>
            
              <tr class="odd">
                <td class="col-first">City</td>
                <td class="col-second">
                 <form:input path="address.city" class="input" /> 
                </td>
                <td class="col-first">Country</td>
                <td class="col-second">
					 <form:select path="address.countryCode">
                  <form:option value="-1" label="Select" />
				<form:options items="${countryCodeSet}" itemValue="id" itemLabel="shortName" />
				</form:select>
				</td>
			</tr>
			  <tr class="odd">
				 <td class="col-first">State/Province</td>
                 <td class="col-second">
                 <form:select path="address.stateCode">
                  <form:option value="-1" label="Select" />
				<form:options items="${statesSet}" itemValue="id" itemLabel="shortName" />	
				</form:select>
				</td>
                
                  <td class="col-first">Postal Code</td>
                 <td class="col-second">
                  <form:input path="address.postalCode" class="input" /> 
                 </td>
                
               </tr>
               
    </tbody>
 </table>
 <script type="text/javascript">
    $(document).ready(function() {
    	//alert('Hello Sai');    
    	firmId = ${firm.id};
        $("#address\\.countryCode").change(function() {     
            $.get("<c:url value='/getStates.do'/>", { countryId: $(this).val(), firmId:firmId }, function(data) {
                populateStateDropdown($("#address\\.stateCode"), data);
            });
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
    </script>