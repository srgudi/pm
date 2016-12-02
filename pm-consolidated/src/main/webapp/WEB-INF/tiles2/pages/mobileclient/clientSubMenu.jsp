<%@ include file="../../layout/PM-INCLUDES.jsp" %>

<body>
	<c:if test="${not empty param.clientId}">
		<c:url value="/mobileclient/mobilecLocation.do"
			var="mobileclientLocationUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>

		<c:url value="/mobileclient/mobileOfficersAndShareHolders.do"
			var="mobileclientOfficersAndShareHoldersUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>

		<c:url value="/mobileclient/mobilecStaff.do"
			var="mobilestaffModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>

		<c:url value="/mobileclient/mobileClientDetail.do"
			var="mobiledetailModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>
		<c:url value="/mobileclient/mobilecBank.do"
			var="mobilebankModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>
		<c:url value="/mobileclient/mobilecLawyer.do"
			var="mobileLawyerModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>
		<c:url value="/mobileclient/mobilecInsurance.do"
			var="mobileInsurModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>

		<c:url value="/mobileclient/mobilecTAgent.do"
			var="mobileTransferModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>
		<c:url value="/mobiletax/mobileTaxList.do"
			var="mobileTaxModuleUrl">
			<c:param name="clientId" value="${param.clientId}" />
		</c:url>
	</c:if>


	<div data-role="content">
       <c:if test="${empty inValidClientId}">
                <div class="container_12 bg-light-orange blue">
                    <span style="font-size:105%;font-weight:bold;color:DarkGray ;font-style: italic;">Client Name:${clientPartyName}</span>
                </div>
            </c:if>
          <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobilestaffModuleUrl}'/>"'>Staff</a>
          <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileclientOfficersAndShareHoldersUrl}'/>"'>Officers and shareholders</a>
          <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileclientLocationUrl}'/>"'>Locations</a>
          <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobilebankModuleUrl}'/>"'>Banks</a>
          <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileLawyerModuleUrl}'/>"'>Lawyers</a>
		  <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileInsurModuleUrl}'/>"'>Insurance</a>
		  <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileTransferModuleUrl}'/>"'>Transfer Agent</a>
		   <a data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a' onClick='location.href="<c:out value='${mobileTaxModuleUrl}'/>"'>Taxes</a>
       
       </div> 
</body> 


 
