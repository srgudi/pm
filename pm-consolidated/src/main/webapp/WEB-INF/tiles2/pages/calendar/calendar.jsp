<%@ include file="../../layout/PM-INCLUDES.jsp"%>

 <link rel="stylesheet"
          href="<c:url value='/resources/calendar/css/fullcalendar.css'/>"
          type="text/css"> 
<link rel="stylesheet" href="<c:url value='/resources/qtip/jquery.qtip.min.css'/>" type="text/css">
<script type="text/javascript"
            src="<c:url value='/resources/calendar/js/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/qtip/jquery.qtip.min.js'/>"></script>
            

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
		   /*  eventMouseout: function(calEvent, domEvent) {

		           if(!$("#events-layer").hasClass('mouse_in')){
		             $("#events-layer").remove();
		           }
		   }, */
		   eventRender: function(event, element) {
				element.qtip({ content: event.description,
							   position: {
									corner:{target: 'topRight',tooltip: 'bottomLeft'}
										},	
							   show: 'mouseover',
							   hide: 'mouseout',
					});
				}/* ,
		    eventMouseover: function(event, jsEvent, view) {
		    	 event._title = event.title;
				event.title = "Click to view"
				$("#calendarnew").fullCalendar("updateEvent", event); 
		    	var eventid = event.id;
                var layer = $("<div id='events-layer'  style='position:absolute; top:"+ jsEvent.pageY +"px; left:"+ jsEvent.pageX +"px; text-align:left; z-index:9999;background-color:#00ffff;padding-right:5px;cursor:pointer;width:100px;color:#000000;'><ul style='list-style-type: none;margin-left:0px;padding:0px;overflow:hidden;' onclick=''><li onClick='editEvent("+ eventid +");'>&nbsp;what</li><li onClick='showEventMembers("+ eventid +");'>&nbsp;how</li><li onClick='emailEventMembers("+ eventid +");'>&nbsp;because</li><li onClick='printShiftplan("+ eventid +");'>&nbsp;Hello</li><li onClick='deleteEvent("+ eventid +");'></a>&nbsp;Hi</li></ul></div>");

                layer.mouseenter(function(){
                     $(this).addClass("mouse_in");
                 })

                layer.mouseleave(function(){
                     $(this).remove();
                 })

                 $("body").append(layer);

                 console.log(jsEvent);
			}		
		     */
		});
		
	});
/* $(function() {				  
		
		var opts = {
		    	autoOpen: false,
		    	height: 320,
		        width: 360,
		        modal: true
			};
		
		$("#event.title").live("click",function() {
		   $("#language-form").dialog(opt).dialog("open");
		});
	}); */
</script>
<style type='text/css'>
	
	#calendarnew {
		width: Auto;
	}
   body {
    background-color: #F5F5F5;
    }
    thead{
     background-image: linear-gradient(to bottom, #BFE3FE, #00477D);
    }
    

</style>

	<div class="row-fluid">
		<div class="span1"></div>
		<div class="span10" style="margin-top: 60px;">
			<div id='calendarnew'></div>
		</div>
		<div class="span1"></div>
	</div>
		

<!-- <div id="language-form" title="Language" class="headerCap">
<label class="popupLabel" for="newLanguage"><b>Language</b></label> 
  
  <a class="button_red10" id="cancelLanguage" href="javascript:;" onClick="CancelLanguageForm(this);"> <button id="cancelLanguage" type="reset"
                            	class="btn btn-success"
                            	 aria-disabled="false">ok</button> </a> 
</div>
 -->
