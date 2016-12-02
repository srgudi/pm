<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<br/>
<div class="yui3-u-1-5" style="margin-top: 5px;width:200px">

<script type="text/javascript">
		$(document).ready(function() {
		//	var firmId=${firmId};
		//	var partyId=${partyId};
		//	var cId = ${clientId};
			//alert("hi"+cId);
			//var fpId = ${firmPracticeId};
			//alert("hi"+fpId);
		
		$("#accordion").accordion({
				header : "h3",
				autoHeight : false,
				collapsible : true,
				active : false
			});
			
			$( "#tabs" ).tabs();
			    
		});
	 
</script>

<div id="accordion" style="min-width: 150px;">  
		<form:form action="">
		<br/>
			<span class="menuCap"></span>
			<!-- sample code begins here -->
      		<div class="bs-docs-sidebar">
      		 <!--<ul class="nav nav-list bs-docs-sidenav">-->
      		 <ul class="nav nav-tabs nav-stacked">
      		   <li><a href="#typography" 	 id="AdminList"  onclick=TabHide();><i class="icon-right"></i>Admin List </a>  
          <li><a href="#code"	 	 id="AdminJuri" 	  onclick=JuriHide();><i class="icon-right"></i>Jurisdiction </a> 
          <li><a href="#tables"	 	 id="AdminCodeType"  onclick=CodeTypeCtrl();><i class="icon-right"></i>Code Type</a> 
          <li><a href="#forms"	 	 id="AdminCode" 	  onclick=CodeCtrl();><i class="icon-right"></i>Code</a> 
          <li><a href="#buttons" 	 id="AdminTemplate" 	  onclick=TemplateCtrl();><i class="icon-right"></i>Templates</a>
          <li><a href="#images"	 	 id="AdminRecepient" 	  onclick=RecepientCtrl();><i class="icon-right"></i>Recepients</a> 
        </ul>
      </div>	
	<!-- client left navigation ends here -->
			<!-- <div class="accordion-group">  
              <div class="accordion-heading">  
                <a  data-toggle="collapse" style="size: 50px;" id="adminList" data-parent="#accordion2" onclick=TabHide();>  
                   &nbsp;      Admin List
                </a>  
              </div>
              </div> -->

		</form:form>
	</div>   	

</div>

<div class="yui3-u-19-24" style="min-width:150px;">
<br/>
<div id="headerBand" class="headerCap"></div>
  <div class="span6">  
</div>
<div class="tabbable">

  <ul class="nav nav-tabs reducedBottom" style="margin-bottom: 00px;" id="mainAdminTabs">      
        <li><a data-target="#list"  href="adminList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#edit"  onClick=TabAdmin(); data-toggle="tab">Add/Edit</a></li>
  </ul> 
  <ul class="nav nav-tabs reducedBottom" id="juridTab">    
        <li><a data-target="#list"  href="juridList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#edit"  onClick=TabJurid(); data-toggle="tab">Add/Edit</a></li>
  </ul> 
  <ul class="nav nav-tabs reducedBottom" id="codeTypeTab">    
        <li><a data-target="#list"  href="codeTypeL.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#edit"  onClick=TabCodeType(); data-toggle="tab">Add/Edit</a></li>
  </ul> 
  <ul class="nav nav-tabs reducedBottom" id="codeTab">    
        <li><a data-target="#list"  href="adminCode.do" class="active" data-toggle="tab">Code</a></li>
       <!--  <li><a data-target="#edit"  onClick=TabCode(); data-toggle="tab">Add/Edit</a></li> -->
  </ul> 
  <ul class="nav nav-tabs reducedBottom" id="templatesTab">    
        <li><a data-target="#list"  href="templateList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#edit"  onClick=TabTemplate(); data-toggle="tab">Add/Edit</a></li>
  </ul> 
  <ul class="nav nav-tabs reducedBottom" id="recepientsTab">    
        <li><a data-target="#list"  href="recepientList.do" class="active" data-toggle="tab">List</a></li>
        <li><a data-target="#edit"  onClick=TabRecepient(); data-toggle="tab">Add/Edit</a></li>
  </ul> 
 <div class="tab-content">
        <div class="tab-pane" id="list"></div>
        <div class="tab-pane" id="edit"></div>
    </div>
 </div>
 </div>
 
<script>
$(function() {
$("#recepientsTab").tab().hide();
$("#templatesTab").tab().hide();
$("#codeTab").tab().hide();
$("#codeTypeTab").tab().hide();
$("#juridTab").tab().hide();
$("#mainAdminTabs").tab().show(); // initialize tabs
$("#mainAdminTabs").bind("show", function(e) {
var contentID = $(e.target).attr("data-target");
var contentURL = $(e.target).attr("href");
$(contentID).load(contentURL, function(){
$("#mainAdminTabs").tab(); // reinitialize tabs
});
});
$('#mainAdminTabs a:first').tab("show"); // Load and display content for first tab

 // Load and display content for first tab

});
function TabHide(){
	$("#recepientsTab").tab().hide();
	$("#templatesTab").tab().hide();
	$("#codeTab").tab().hide();
	$("#codeTypeTab").tab().hide();
	$("#juridTab").tab().hide();
	$("#mainAdminTabs").tab().show(); // initialize tabs
	 $("#mainAdminTabs").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#mainAdminTabs").tab(); // reinitialize tabs
	});
	});
	$('#mainAdminTabs a:first').tab("show"); 
	
}
function JuriHide(){
	$("#recepientsTab").tab().hide();
	$("#templatesTab").tab().hide();
	$("#codeTab").tab().hide();
	$("#codeTypeTab").tab().hide();
	$("#mainAdminTabs").tab().hide();
	$("#juridTab").tab().show(); // initialize tabs
	 $("#juridTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#juridTab").tab(); // reinitialize tabs
	});
	});
	$('#juridTab a:first').tab("show"); 
}
function CodeTypeCtrl(){
	$("#recepientsTab").tab().hide();
	$("#templatesTab").tab().hide();
	$("#codeTab").tab().hide();
	$("#juridTab").tab().hide();
	$("#mainAdminTabs").tab().hide();
	$("#codeTypeTab").tab().show(); // initialize tabs
	 $("#codeTypeTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#codeTypeTab").tab(); // reinitialize tabs
	});
	});
	$('#codeTypeTab a:first').tab("show");
}
function CodeCtrl(){
	$("#recepientsTab").tab().hide();
	$("#templatesTab").tab().hide();
	$("#codeTypeTab").tab().hide();
	$("#juridTab").tab().hide();
	$("#mainAdminTabs").tab().hide();
	$("#codeTab").tab().show(); // initialize tabs
	 $("#codeTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#codeTab").tab(); // reinitialize tabs
	});
	});
	$('#codeTab a:first').tab("show");
}
function TemplateCtrl(){
	$("#recepientsTab").tab().hide();
	$("#codeTab").tab().hide();
	$("#codeTypeTab").tab().hide();
	$("#juridTab").tab().hide();
	$("#mainAdminTabs").tab().hide();
	$("#templatesTab").tab().show(); // initialize tabs
	 $("#templatesTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#templatesTab").tab(); // reinitialize tabs
	});
	});
	$('#templatesTab a:first').tab("show");
}
function RecepientCtrl(){
	$("#templatesTab").tab().hide();
	$("#codeTab").tab().hide();
	$("#codeTypeTab").tab().hide();
	$("#juridTab").tab().hide();
	$("#mainAdminTabs").tab().hide();
	$("#recepientsTab").tab().show(); // initialize tabs
	 $("#recepientsTab").bind("show", function(e) {
	var contentID = $(e.target).attr("data-target");
	var contentURL = $(e.target).attr("href");
	$(contentID).load(contentURL, function(){
	   $("#recepientsTab").tab(); // reinitialize tabs
	});
	});
	$('#recepientsTab a:first').tab("show");
}
function TabJurid(){
	$('#edit').load('adminJurisdiction.do');
	$('#juridTab a:last').tab('show');
}
function TabCodeType(){
	$('#edit').load('adminCodeType.do');
	$('#codeTypeTab a:last').tab('show');
}

function TabCode(){
	$('#edit').load('adminCode.do');
	$('#codeTab a:last').tab('show');
}

function TabTemplate(){
	$('#edit').load('adminTaskNotificationTemplate.do');
	$('#templatesTab a:last').tab('show');
}
function TabRecepient(){
	$('#edit').load('adminTaskNotificationRecipient.do');
	$('#recepientsTab a:last').tab('show');
}
function TabAdmin(){
	$('#edit').load('adminFirmModule.do');
	$('#mainAdminTabs a:last').tab('show');
}
</script>