<%@ include file="../../layout/PM-INCLUDES.jsp"%>
 <meta charset="utf-8" />
<link rel="stylesheet"
          href="<c:url value='/resources/calendar/css/fullcalendar.css'/>"
          type="text/css"> 
<link rel="stylesheet" href="<c:url value='/resources/qtip/jquery.qtip.min.css'/>" type="text/css">
<script type="text/javascript"
            src="<c:url value='/resources/calendar/js/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/qtip/jquery.qtip.min.js'/>"></script>
<script type="text/javascript" src="http://swip.codylindley.com/jquery.tooltip.js"></script>
            
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
		    events: "eventAjaxList.do?start="+start+"&end="+end,
		    eventRender: function(event, element) {
		    	var formattedval = event.description;
		    	/* var decoded = $.parseHTML(formattedval).html();
		    	alert(decoded); */
		    	//html = $.parseHTML( formattedval );
		    	//alert(html);
		    	element.attr('title', formattedval);
		    	$( "#element.title" ).html( formattedval );
				 element.tooltip({ 
					         /*  tooltipSourceID:event.description,  */
					          attributeName:'title',
							   position: {
									corner:{target: 'topRight',tooltip: 'bottomLeft'}
										},	
							   show: 'mouseover',
							   hide: 'mouseout',
							   width:'200px', 
							   height:'100px', 
							   tooltipSource:'attribute',  
							   borderSize:'1', 
							   tooltipBGColor:'#efefef' 
					}); 
				}		
					
		});
		
	});

</script>


	<div class="container_12">
		<div>
			<div id='calendarnew'></div>	
		</div>
	</div>
		


