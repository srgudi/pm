<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<script type="text/javascript">
$(function() {
    $("#viewfirmlist").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileMainAdmin.do","slideup");
    });        
});
$(function() {
    $("#viewjurisdiction").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileAdminJurisdiction.do","slideup");
    });        
});
$(function() { 
    $("#viewtemplates").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileadminTaskNotificationTemplateHome.do","slideup");
    });        
});
$(function() { 
    $("#viewrecipients").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileadminTaskNotificationRecipientHome.do","slideup");
    });        
});
$(function() { 
    $("#viewcode").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileAdminCode.do","slideup");
    });        
});
$(function() { 
    $("#viewcodetype").click(function() {
        $.mobile.changePage("/pm-new/mobileadmin/mobileadminCodeTypeHome.do","slideup");
    });        
});
</script>
 <script type="text/javascript">
$(window).bind('orientationchange','load', function(event){
    if(event.orientation) {
          if(event.orientation == 'portrait') {
				jQuery("#mobileClientGrid").setGridWidth($('#grid_wrapper').width()+5, true);
				jQuery("#mobileClientStaff").setGridWidth($('#grid_wrapper').width()+5, true);
				jQuery("#mobileTaskGrid").setGridWidth($('#grid_wrapper').width()+5, true);
				jQuery("#'mobileTaxmoduleGrid'").setGridWidth($('#grid_wrapper').width()+5, true);
	          } else if (event.orientation == 'landscape') {
	        	  jQuery("#mobileClientGrid").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#mobileClientStaff").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#mobileTaskGrid").setGridWidth($('#grid_wrapper').width()-5, true);
	        	  jQuery("#'mobileTaxmoduleGrid'").setGridWidth($('#grid_wrapper').width()-5, true);
                     } 
          } else {
                // optional... PC-version javascript for example
                
                }

    }).trigger('load');	
</script>

<body>  

  <div data-role="content">
      <a  id="viewfirmlist" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'>Firm List</a> 
	  <a  id="viewjurisdiction" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Jurisdiction</a>
	  <a  id="viewcodetype" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Code Type</a>
	  <a  id="viewcode" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'>Code</a> 
	  <a  id="viewtemplates" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Templates</a>
	  <a  id="viewrecipients" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Recipients</a>
</div>
</body> 


 
