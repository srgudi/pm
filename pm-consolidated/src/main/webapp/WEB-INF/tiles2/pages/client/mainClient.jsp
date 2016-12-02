<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8" %>
<br/>
<br/>
<c:url var="clientBankUrl" value="/client/clientBank.do">
     <c:param name="clientId" value="${clientId}"/>
</c:url>
 
<div class="yui3-u-1-6" id="leftmenufiller">&nbsp;</div>
<div class="yui3-u-1-6" id="leftmenumain" style="display:none;">
	<script type="text/javascript">
		$(document).ready(function() 
		{
		
		$("#leftmenufiller").show();
		$("#leftmenumain").hide();		
		$("#accordion").accordion({
				header : "h3",
				autoHeight : false,
				collapsible : true,
				active : false
			});
			
			$("#tabs").tabs();
			//hideShowTabsPanes("#mainClientTabs","#clientTabs",false);
			hideShowTabsPanes("#mainClientTabs","#clienttabsContainer",false);
			    
		});
	</script>
	
	
	
	
	<!-- new accordion begins -->
	<span class="menuCap"></span>	
	
	<!-- sample code begins here -->
      <div class="bs-docs-sidebar">
        <!--<ul class="nav nav-list bs-docs-sidenav">-->

	<ul class="nav nav-tabs nav-stacked">
	  <li><a href="#" id="CliList" onclick="hideShowTabsPanes('#mainClientTabs','#clienttabsContainer',false);"><i class="icon-chevron-right"></i>Client List </a>  
	  <li><a href="#" id="CliBank" onclick="hideShowTabsPanes('#clientBankTabs','#banktabsContainer',true);"><i class="icon-chevron-right"></i>Banks </a> 
	  <li><a href="#" id="ClientStaff" onclick="hideShowTabsPanes('#clientStaffTabs','#stafftabsContainer',true);"><i class="icon-chevron-right"></i>Staff</a> 
	  <li><a href="#" id="CliLoc" onclick="hideShowTabsPanes('#clientLocationTabs','#locationtabsContainer',true);"><i class="icon-chevron-right"></i>Locations</a> 
	  <li><a href="#" id="CliOff" onclick="hideShowTabsPanes('#clientOfficersTabs','#shareholdertabsContainer',true);"><i class="icon-chevron-right"></i>Officers And Share Holders</a>
	  <li><a href="#" id="CliTA" onclick="hideShowTabsPanes('#clientTATabs','#trnsfrtabsContainer',true);"><i class="icon-chevron-right"></i>Transfer Agents </a> 
	  <li><a href="#" id="CliIN" onclick="hideShowTabsPanes('#clientINTabs','#insurancetabsContainer',true);"><i class="icon-chevron-right"></i>Insurances </a> 
	  <li><a href="#" id="CliDoc" onclick="hideShowTabsPanes('#clientDocumentTabs','#documentstabsContainer',true);"><i class="icon-chevron-right"></i>Documents </a> 
	  <li><a href="#" id="CliLaw" onclick="hideShowTabsPanes('#clientLawyersTabs','#lawyerstabsContainer',true);"><i class="icon-chevron-right"></i>Lawyers</a> 
	</ul>

      </div>	
	<!-- client left navigation ends here -->

</div>


<div class="yui3-u-19-24" style="margin-top: 5px;">
	<div id="headerBand" class="headerCap"></div>
	
  <!-- tabbable div is parent container for jqgrid -->
<div class="tabbable" id="clientTabs">
    <ul class="nav nav-tabs reducedBottom" style="margin-bottom:0px;" id="mainClientTabs">    
        <li><a data-target="#list"  href="clientListPage.do" onClick=HideLeftMenu(); class="active" data-toggle="tab"> <%-- <spring:message code="label.addoredit"> --%>List</a></li>
        <li><a data-target="#edit"  href="clientDetail.do" data-toggle="tab">Add/Edit</a></li>
		<security:authorize access="hasRole('ROLE_FIRM_PARTNER')">
		<li id="yui-g">
			<button type="button" href="clientDetail.do" onClick=HideLeftMenu(); id="clientDetail" class="btn btn-primary nav nav-tabs reducedBottom">New Client</button>
		</li>   			
		</security:authorize>
	</ul> 	
  </div>
<div class="tabbable" id="bankTabs">  
    <ul class="nav nav-tabs reducedBottom" id="clientBankTabs">    
        <li><a data-target="#listBank"  href="clientBankList.do" class="active" data-toggle="tab"><spring:message code="label.list"/></a></li>
        <li><a data-target="#editBank"  data-toggle="tab" onClick="showTabs('#clientBankTabs','#editBank','clientBank.do');">Add/Edit</a></li> 
    </ul> 
</div>    
<div class="tabbable" id="staffTabs">      
    <ul class="nav nav-tabs reducedBottom" id="clientStaffTabs">    
        <li><a data-target="#listStaff"  href="clientStaffList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editStaff"  onClick="showTabs('#clientStaffTabs','#editStaff','clientStaff.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>  
</div>    
<div class="tabbable" id="locTabs">          
    <ul class="nav nav-tabs reducedBottom" id="clientLocationTabs">    
        <li><a data-target="#listLoc"  href="clientLocList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editLoc"  onClick="showTabs('#clientLocationTabs','#editLoc','clientLocation.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>
</div>    
<div class="tabbable" id="TaTabs">          
    <ul class="nav nav-tabs reducedBottom" id="clientTATabs">    
        <li><a data-target="#listTrnsfr"  href="clientTAList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editTrnsfr"  onClick="showTabs('#clientTATabs','#editTrnsfr','clientTransferAgent.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>
</div>    
<div class="tabbable" id="InTabs">        
    <ul class="nav nav-tabs reducedBottom" id="clientINTabs">    
        <li><a data-target="#listInsu"  href="clientINList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editInsu"  onClick="showTabs('#clientINTabs','#editInsu', 'clientInsurance.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>
</div>    
<div class="tabbable" id="OffTabs">          
     <ul class="nav nav-tabs reducedBottom" id="clientOfficersTabs">    
        <li><a data-target="#listShrholdr"  href="clientOfficersList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editShrholdr"  onClick="showTabs('#clientOfficersTabs','#editShrholdr', 'clientOfficersAndShareHolders.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>
</div>    
<div class="tabbable" id="docTabs">          
     <ul class="nav nav-tabs reducedBottom" id="clientDocumentTabs">    
        <li><a data-target="#list"  href="clientDocuments.do" class="active" data-toggle="tab">Upload</a></li>
        <li><a data-target="#editDoc" onClick="showTabs('#clientDocumentTabs','#editDoc', 'clientDocumentSearch.do');" data-toggle="tab">Search</a></li> 
    </ul>
</div>    
<div class="tabbable" id="lawyerTabs">           
     <ul class="nav nav-tabs reducedBottom" id="clientLawyersTabs">    
        <li><a data-target="#listLawyr"  href="clientLawyersList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#editLawyr"  onClick="showTabs('#clientLawyersTabs','#editLawyr', 'clientLawyer.do');" data-toggle="tab">Add/Edit</a></li> 
    </ul>
</div>    


    <!-- Client container start here --> 
    <div class="tab-content" id="clienttabsContainer"> 
    <div class="tab-pane" id="list"></div>
    <div class="tab-pane" id="edit"></div> </div>
    
	<!-- Client container end  here -->    

    <!-- Bank container start here -->
    <div class="tab-content" id="banktabsContainer">
        <div class="tab-pane" id="listBank"></div>
        <div class="tab-pane" id="editBank"></div>
    </div>    
    
    <!-- Staff container start here -->
    <div class="tab-content" id="stafftabsContainer">
        <div class="tab-pane" id="listStaff"></div>
        <div class="tab-pane" id="editStaff"></div>
    </div>    
    
    <!-- Locations container start here -->
    <div class="tab-content" id="locationtabsContainer"  style="height:auto;width:auto;border:5px solid green;">
        <div class="tab-pane" id="listLoc"></div>
        <div class="tab-pane" id="editLoc"></div>
    </div>    
    
    <!-- Officers And Share Holders container start here -->
    <div class="tab-content" id="shareholdertabsContainer">
        <div class="tab-pane" id="listShrholdr"></div>
        <div class="tab-pane" id="editShrholdr"></div>
    </div>        
    
    <!-- Transfer Agents container start here -->
    <div class="tab-content" id="trnsfrtabsContainer">
        <div class="tab-pane" id="listTrnsfr"></div>
        <div class="tab-pane" id="editTrnsfr"></div>
    </div>            
   
	<!-- Insurance container start here -->
	<div class="tab-content" id="insurancetabsContainer">
	    <div class="tab-pane" id="listInsu"></div>
	    <div class="tab-pane" id="editInsu"></div>
	</div>            

	<!-- Documents container start here -->
	<div class="tab-content" id="documentstabsContainer">
	    <div class="tab-pane" id="listDoc"></div>
	    <div class="tab-pane" id="editDoc"></div>
	</div>            

	<!-- Documents container start here -->
	<div class="tab-content" id="lawyerstabsContainer">
	    <div class="tab-pane" id="listLawyr"></div>
	    <div class="tab-pane" id="editLawyr"></div>
	</div> 
	
</div>
</div>
	<script type="text/javascript">
	function hideShowTabsPanes(tabName,parentContainer, showLeftMenu)
	{
		//hide all tabs, ie hiding the <ul>s containing list and add/edit tabs. 
		$("#clientBankTabs").tab().hide();
		$("#clientDocumentTabs").tab().hide();
		$("#clientINTabs").tab().hide();
		$("#clientLawyersTabs").tab().hide();
		$("#clientLocationTabs").tab().hide();
		$("#clientOfficersTabs").tab().hide();
		$("#clientStaffTabs").tab().hide();
		$("#clientTATabs").tab().hide();
		$("#mainClientTabs").tab().hide();
		
		//hide all the tabs tabbable classes are parents of tabs
		$(".tabbable").hide();
		
		$(".tab-content").hide();
		//show the one needed
		//alert("hiding all containers");
		//alert("showing container "+parentContainer);
		$(parentContainer).show();
		
		$(tabName).tab().show();		
		
		$(tabName).bind("show", function(e) 
			{
				var contentID = $(e.target).attr("data-target");
				var contentURL = $(e.target).attr("href");
				//alert("going to show " + tabName+ " in "+ contentID);				
				$(contentID).load(contentURL, function()
							{
							$(tabName).tab(); 
							});
			});
			
		// Load and display content for first tab
		var clickedTabId = tabName+ "  a:first";			
		$(clickedTabId).tab("show");
		
		//show or hide left menu accordingly
		if(showLeftMenu)
		{
			$("#leftmenumain").show(); 
			$("#leftmenufiller").hide(); 
		}
		else
		{
			$("#leftmenumain").hide(); 
			$("#leftmenufiller").show(); 
		}
	}
	</script>

<script type="text/javascript">
	function showTabs(showPane,editTabName, reqURL)
	{
		//alert("inside showTabs trying to load "+reqURL+ " inside "+editTabName + " of "+ ShowPane);
		//$('#edit').load(reqURL); 
		$(editTabName).load(reqURL);
		var clickedTabId = showPane+ "  a:last";			
		$(clickedTabId).tab("show");
	}
</script>	

<script type="text/javascript">
 function HideLeftMenu(){
		$("#leftmenufiller").show();
		$("#leftmenumain").hide();
			}
			
</script>