<%@ include file="../../layout/PM-INCLUDES.jsp" %>
<script type="text/javascript">
$(function() {
    $("#viewfirmadmin").click(function() {
        $.mobile.changePage("/pm/mobilefirmadmin/manageFirmStaffMobile.do","slideup");
    });        
});
$(function() {
    $("#viewcodemanage").click(function() {
        $.mobile.changePage("/pm/mobilefirmadmin/managePartyCodeMobile.do","slideup");
    });        
});
$(function() {
    $("#viewtaxtype").click(function() {
        $.mobile.changePage("/pm/mobilefirmadmin/manageTaxModuleMobile.do","slideup");
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
      <a  id="viewfirmadmin" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'>Firm Staff</a> 
	  <a  id="viewtaxtype" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Tax Type</a>
	  <a  id="viewcodemanage" data-icon='arrow-r' data-iconpos='right' data-role='button' data-theme='a'  >Manage Code</a>
</div>
</body> 


 
