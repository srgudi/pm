<table class="table-long" >
         <tbody>
         <h3>Communication Details </h3>
        <tr class="odd">
                  <td class="col-first">Contact Name</td>
                  <td class="col-second">
                  <form:input path="defaultPointOfContact.contactName" class="input" tabindex="1" /></td>
                  
                  <td class="col-first">Title</td>
                  <td class="col-second">
                  <form:input path="defaultPointOfContact.contactTitle" class="input" tabindex="2" /></td>
         </tr>
         <tr class="odd">
                  <td class="col-first">Email Address</td>
                  <td class="col-second">
                  
                  <c:forEach items="${account.defaultPointOfContact.emailList}" var="email" varStatus="cStatus">
                    <form:hidden path="defaultPointOfContact.emailList[${cStatus.index}].id"/>
                    <form:hidden path="defaultPointOfContact.emailList[${cStatus.index}].pointOfContact"/> 
                    <form:input path="defaultPointOfContact.emailList[${cStatus.index}].contactDetail" tabindex="1" class="input align-left"/>
                  
                    
                    </c:forEach>
                    <a href="javascript:;" class='sendEmail align-left'><img src='<c:url value='/images/email_send.png'/>' alt='Send Email' title='Send Email'/></a>
                    </td>
                   
                  <td class="col-first">Fax</td>
                   <td class="col-second">
                    <c:forEach items="${account.defaultPointOfContact.faxList}" var="contact" varStatus="cStatus">
                     <form:hidden path="defaultPointOfContact.faxList[${cStatus.index}].id"/>
                    <form:hidden path="defaultPointOfContact.faxList[${cStatus.index}].pointOfContact"/> 
                    <form:input path="defaultPointOfContact.faxList[${cStatus.index}].contactDetail" tabindex="1" class="input align-left"/>
                    </c:forEach>
                    </td>
              
         </tr>
         
         <tr class="odd">
                  <td class="col-first">Web</td>
                  <td class="col-second">
                 <c:forEach items="${account.defaultPointOfContact.webUrlList}" var="contact" varStatus="cStatus">
                    <form:hidden path="defaultPointOfContact.webUrlList[${cStatus.index}].id"/>
                    <form:hidden path="defaultPointOfContact.webUrlList[${cStatus.index}].pointOfContact"/> 
                    <form:input path="defaultPointOfContact.webUrlList[${cStatus.index}].contactDetail" tabindex="1" class="input align-left"/>
                   </c:forEach>
                    </td>
              </tr>
				<c:set var="phoneCount" value="0"/>
				<c:forEach items="${account.defaultPointOfContact.phoneList}" var="contact" varStatus="cStatus">
			  			<tr class="phonerow">
                  			<td class="col-first">Phone</td>
                  			<td class="col-second">
                  				<form:input path="defaultPointOfContact.phoneList[${cStatus.index}].contactDetail" class="input phoneField" tabindex="1" />
                  			</td>
                  			<form:hidden path="defaultPointOfContact.phoneList[${cStatus.index}].id" class="input_h1_id"/>
                  			<form:hidden path="defaultPointOfContact.phoneList[${cStatus.index}].pointOfContact" class="input_h1"/>
			                <td class="row-nav ptype">Phone Type</td>
                  			<c:set var="displayStyle" value="display:show;"/>
			                <c:if test="${phoneCount == 0}">
                  				<c:set var="displayStyle" value="display:none;"/>
                  			</c:if>
                   			<td class="row-nav1">
                   				<form:select path="defaultPointOfContact.phoneList[${cStatus.index}].subType" style="width:110px;" id="phone_type" class="phone_type">
				                    <form:option value="-1" label="Select" />
									<form:options items="${phoneCommunicationTypeSet}" itemValue="value" itemLabel="key" />
                    			</form:select>
								&nbsp;
								<a href="javascript:;" class="addphone"><img src="<c:url value='/images/add_icon.gif'/>" width="20" height="20" alt="Add Phone Number" title="Add Phone Number"  class="addicon"/></a>
								&nbsp;
								<a href='javascript:;'  class='removeicon' style="${displayStyle}" ><img src='<c:url value='/images/remove_icon.gif'/>' width='20' height='20'  alt='Remove Phone Number'  title='Remove Phone Number'/></a>				  
							</td>
                		</tr>         
                		<c:set var="phoneCount" value="${phoneCount}++"/>
                	
               </c:forEach>
 		
         </tbody>
         </table>
         
<script type="text/javascript" charset="utf-8">
$('.addicon').click(function() {
if($("tr.phonerow").length < 5) {
var x = $("input[class^='input phoneField']").length ;

$("table tbody").find("tr.phonerow:last").clone(true).insertAfter("tr.phonerow:last").find("input[class^='input phoneField']").attr({
		name: 'defaultPointOfContact.phoneList[' + (x) +'].contactDetail', 
		id: 'defaultPointOfContact.phoneList[' + (x) +'].contactDetail'})
		.val("");	

$("table tbody").find("tr.phonerow:last").find("select[class^='phone_type']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].subType',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].subType'})
	.val("");

$("table tbody").find("tr.phonerow:last").find("input[class='input_h1_id']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].id',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].id'})
	.val("");


$("table tbody").find("tr.phonerow:last").find("input[class='input_h1']").attr({
	name: 'defaultPointOfContact.phoneList[' + (x) +'].pointOfContact',
	id: 'defaultPointOfContact.phoneList[' + (x) +'].pointOfContact'});


firstrowLength();
};

$(".removeicon").click(function () {
	$(this).parent().parent().remove();
});		 
});

function firstrowLength () {
	if($("tr.phonerow").length > 1) {	
		$("tr.phonerow:last").find("td:last").find("a.removeicon").show();				
	}
}
</script>
