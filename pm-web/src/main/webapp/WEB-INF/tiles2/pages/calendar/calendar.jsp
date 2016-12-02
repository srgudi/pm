<%@ include file="../../layout/PM-INCLUDES.jsp"%>


 <link rel="stylesheet"
          href="<c:url value='/NEW_UI/calendar/css/fullcalendar.css'/>"
          type="text/css"> 

<script type="text/javascript"
            src="<c:url value='/NEW_UI/calendar/js/fullcalendar.min.js'/>"></script>

<script type='text/javascript'>

	$(document).ready(function() {
	
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		var start=new Date(y,m,d-6);
		var end=new Date(y,m,d);
		$('#calendarnew').fullCalendar({
			header: {
				left: 'prev,next, today',
				center: 'title',
				right: 'basicWeek,month,basicDay'
			},
			editable: true,			
		    events: "eventAjaxList.do?start="+start+"&end="+end
					
		});
		
	});

</script>
<style type='text/css'>
	
	#calendarnew {
		width: 100%;		
		}


</style>


	<div class="container_12">
		<div>
			<div id='calendarnew'></div>	
		</div>
	</div>
		


