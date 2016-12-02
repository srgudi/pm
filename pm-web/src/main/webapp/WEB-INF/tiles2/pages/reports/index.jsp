<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../../layout/PM-INCLUDES.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<style type='text/css'>
	
	#calendarnew {
		width: 100%;		
		}


</style>


<div>
	<%
		
		Date date1=new Date();
		System.out.print(date1);
		
		java.sql.Date tempDate1 = new java.sql.Date(((Date) date1).getTime());
		System.out.println(tempDate1);
		Date date2=new Date();
		java.sql.Date tempDate = new java.sql.Date(((Date) date2).getTime());
		System.out.println(tempDate);
		
	%>
	<!--  BUCKET -->
	<div>
		<!-- <div style="padding: 0.5em"
			class="ui-widget ui-widget-content ui-widget-header ui-corner-top ui-helper-clearfix">
			Report List</div> -->
	</div>
	<div class="ui-widget ui-widget-content ui-corner-bottom">
		<div>
		<div id="tabs">
 <center>
  <img src="../images/reports/reportsnew2.png" />
 </center>
 </div> 
		<%-- <div id='calendarnew'>
			<TABLE cellSpacing=0 cols=2 cellPadding=0 border=0 width="100%">
			<TBODY> 
				<TR>
					<TD class=content style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" >
						<!-- Page title -->
						
						<!-- Content area -->
						<!-- <p><a href="filingsByClientReport.do">Filings By Client</a>
						<br />
						<p><a href="clientListByMisDeadLinesReport.do">Client List By Missing Dead Lines</a>
						<br />
						<p><a href="taskByDueDateReport.do">Task By Due Date</a>
						<br />
						<p><a href="dueDatebytaskReport.do">Task List By Tax Type</a><br />
						<p><a href="taskModuleReport.do">Task List by Partner</a><br />
						<p><a href="taskListByFirmReport.do">Task List by Firm</a><br />
						<p><a href="taskListByEmpReport.do">Task List by Employee</a><br />
						<p><a href="clientListByFirmReport.do">Client List by Firm</a><br />
						<p><a href="taskListByFilingTypeReport.do">Task List by Filing Type</a><br />
						<p><a href="taskListByStatusReport.do">Task List by Status</a><br />
						<p><a href="clientListwithDetailsReport.do">Client List with Details</a><br />
						<p><a href="clientListbyPartnerReport.do">Client List by Partner In Charge</a><br />
						<p><a href="newTaxListByStaffReport.do">Work Load Summary Report</a><br /> -->
						<p><a href="clientListwithDetailsJasperReport.do">Client List with Details</a><br />
						<p><a href="clientListByMisDeadLinesJasper.do">Client List By Missed Deadlines</a><br />
						<p><a href="taskListByEmpJasperReport.do">Task List by Employee</a><br />
						<p><a href="dueDateByTaskJASPER.do">Task List By Tax Type</a><br />
						<p><a href="newTaxListByStaffJasperReport.do">Work Load Summary</a><br />
						<!-- <p><a href="pieChartJasperReport.do">Work Load Summary Pie Chart</a><br /> -->
						<p><a href="clientByFirmJASPER.do">Client By Firm</a><br />
						<p><a href="taskListByFilingTypeJasperReport.do">Task List by Filing Type</a><br />
						<p><a href="taskListByFirmJasperReport.do">Task List by Firm</a><br />
						<p><a href="taskListByStatusJasperReport.do">Task List by Status</a><br />
						<p><a href="filingsByClientJasper.do">Filings By Client</a><br />
						<p><a href="clientListbyPartnerJasper.do">Client List by Partner In Charge</a><br />
						<p><a href="taskByDueDateJasperReport.do">Task By Due Date</a><br />
						<p><a href="taskModuleJasperReport.do">Task List by Partner</a><br />
						<!--<p><a href="../../reports/frameset?__report=barchart.rptdesign">TEST PATH</a>
						<p><a href="../../reports/taskreport.jsp">Test Jsp</a>
						<p><a href="<%= request.getContextPath( ) + "/taskModule.jsp" %>">Task List By Date Range</a>
						<p><a href="<%= request.getContextPath( ) + "/taskModuleRep2.jsp" %>">Report2</a>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=barchart.rptdesign"%>">Pie Chart Example</a></p>
						
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=piechart.rptdesign"%>">Bar Graph Example</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=taskwithsort.rptdesign&dueDate=2011-03-10&dueDate1=2011-10-10&partnerId=2&firmId=1" %>">View Task Example</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=tasklist.rptdesign&duedate=2011-03-10&duedate1="+tempDate %>">View Task Example</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=test.rptdesign&sample=my+parameter" %>">View Example</a>						
						
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=newtaxbyfirm.rptdesign&firmId=1"%>">Tax List By Firm</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=clientlistbyfirmid.rptdesign&firmid=1"%>">Client List By Firm</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=clientlistwithdetails.rptdesign&firmid=1"%>">Client List By Firm With Details</a></p>
						<p><a href="<%= request.getContextPath( ) + "/frameset?__report=tasklistbyempname.rptdesign&staffid=8"%>">Task List By Employee</a></p> -->
						
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>	 --%>
			
		
	</div>
</div>
