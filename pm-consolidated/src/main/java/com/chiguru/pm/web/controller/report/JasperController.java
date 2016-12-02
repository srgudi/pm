package com.chiguru.pm.web.controller.report;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.export.JExcelApiExporter;
import net.sf.jasperreports.engine.export.JExcelApiExporterParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;

/*import org.apache.log4j.Logger;*/
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;


import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PaymentType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.dto.AddressDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.report.service.JasperService;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.domain.TaskRep;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.util.PMUtil;
import com.sun.org.apache.xml.internal.security.keys.content.KeyValue;


@Controller
public class JasperController extends JasperReportsMultiFormatView{
	
		//protected static Logger logger = Logger.getLogger("controller");
		
		@Autowired
		private CRMManager crmManager;
		
		@Autowired
		private TaxModuleManager taxModuleManager;

	@Autowired
	private JasperService jasperService;

	 public static final String EXCEL_CONTENT_TYPE = "application/vnd.ms-excel";
	 public static final String PDF_CONTENT_TYPE = "application/pdf";

	private List<Party> getStaffInChargeData(Long partyId) {
		return crmManager.getRelatedPartiesById(partyId,
				RelationshipType.RELATIONSHIP_TYPE_STAFF.getId());
	}

	private List<Party> getPartnerInChargeData(Long partyId) {
		return crmManager.getRelatedPartiesById(partyId,
				RelationshipType.RELATIONSHIP_TYPE_PARTNER.getId());
	}

	@RequestMapping(value = "/reports/index.do", method = RequestMethod.GET)
    public String index() {
    //    logger.info("Welcome!");
        
        return "report.indexView";
    }
	
	@RequestMapping(value = "/reports/mainReport.do", method = RequestMethod.GET)
    public String mainReport() {
        return "mainreport.indexView";
    }
// the below method is related to Jasper report to display logo in html format
	protected void renderReport(JasperPrint populatedReport, Map model, HttpServletResponse response)
    throws Exception
    {
       if (model.containsKey("requestObject")) {
        HttpServletRequest request = (HttpServletRequest)                                               
        model.get("requestObject");
        request.getSession().setAttribute(net.sf.jasperreports.j2ee.servlets.ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE,
                populatedReport);
       }
    super.renderReport(populatedReport, model, response);
   }
	
	
	private void generateHtmlOutput(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response)
	        throws IOException, JRException, ServletException {
				
		        ServletContext context = getServletContext();

		 		JRHtmlExporter exporter = new JRHtmlExporter();
		 		
	            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	            exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	            exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "../logo?image=");
	            exporter.setParameter(JRHtmlExporterParameter.IMAGES_DIR_NAME,context.getRealPath("../logo/logo.jpg"));
	            exporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, false);
	            exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.FALSE);
	            exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
	            request.getSession().setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint); 
	            response.setContentType("text/html;charset=UTF-8");
	            exporter.exportReport();

	}
	public String newParameter(String val){
		if(val != null){
			System.out.println("value present");
		}else{
			val = " ";
		}
		return val;
	}
	public void getReportAddress(Map<String, Object> parameters,ModelMap model, HttpServletRequest request,Long firmid) {
		Connection con = null;
		
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		List<AddressDTO> reportAddressDTO = crmManager.getReportAddress(firmid);
		for(AddressDTO items: reportAddressDTO){
		parameters.put("addressLine",newParameter(items.getAddressLine()));
		parameters.put("city", newParameter(items.getCity()));
		parameters.put("postalCode", newParameter(items.getPostalCode()));
		
		 model.put("addressLine",newParameter(items.getAddressLine()));
		 model.put("city", newParameter(items.getCity()));
		 model.put("postalCode",newParameter(items.getPostalCode()) );
		}
	}
	
	@RequestMapping(value = "/reports/clientListwithDetails.do", method = RequestMethod.GET)
	public String clientListwithDetailsJasperReport(HttpServletRequest request,
			HttpServletResponse response, TaskRep taskRep, Long taskId,
			Long clientId, ModelMap model) throws ServletException, IOException {
		System.out.println("Hello" + taskId);
        return "clientListwithDetails.tilesView";
	}

	
	@RequestMapping(value = "/reports/pieChartJasperReport.do", method = RequestMethod.GET)
	public String wlpcJasperReport(HttpServletRequest request,
			HttpServletResponse response, TaskRep taskRep, Long taskId,
			Long clientId, ModelMap model) throws ServletException, IOException {
//		logger.info("Welcome ...!");
        return "report.workloadpcJasperView";
	}
	
	@RequestMapping(value = "/reports/pieChartJasperReport.do", method = RequestMethod.POST)
	public String workloadpcJasperReport(HttpServletRequest request, HttpServletResponse response,
			Long taskId, Long clientId, ModelMap model,Long firmid)
			throws ServletException, IOException, JRException {
//		logger.info("Welcome ...!");
		
		Connection con = null;
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		Long firmId = PMUtil.getFirmIdFromSession(request);
		Map<String, Object> parameters = new HashMap();
		model.put("REPORT_CONNECTION", con);
		parameters.put("firmId", firmId);
		model.put("firmId", firmId);
		String viewAsOption = request.getParameter("viewAs");
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			return "wlpcpdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
		    return "wlpcxlsReport";
		}
		return "wlpcpdfReport";
	}

	
	@RequestMapping(value = "/reports/clientListwithDetails.do", method = RequestMethod.POST)
	public String getclientListwithDetailsJasperReport(HttpServletRequest request, HttpServletResponse response,
			Long taskId, Long clientId, ModelMap model,Long firmid)
			throws ServletException, IOException, JRException {
//		logger.info("Welcome ClientWithDetails...!");
		System.out.println("Hello I am here" + taskId);
		Long firmId = PMUtil.getFirmIdFromSession(request);
		Connection con = null;
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//JRHtmlExporter exporter = new JRHtmlExporter();
		Map<String, Object> parameters = new HashMap();
		model.put("REPORT_CONNECTION", con);
		parameters.put("firmId", firmId);
		model.put("firmId", firmId);
		getReportAddress(parameters,model,request,firmId);
		String viewAsOption = request.getParameter("viewAs");
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			return "pdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListWithDetails.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=ClientListWithDetails.xlsx");
			response.setContentLength(os.size()); // always set the content length whenever sending back a binary file as an http response otherwise excel throws error," found unreadable file".
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
		    return "xlsReport";
		} else if (viewAsOption.equalsIgnoreCase("html")) {
			//return "htmlReport";
			ServletContext context = getServletContext();
			//File reportFile = new File(context.getRealPath("/reports/ClientListWithDetails.jasper"));
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListWithDetails.jasper");
			//ApplicationContext reportFile = new ClassPathXmlApplicationContext("classpath:reports/ClientListWithDetails.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			
		//	String logoPath = reportFile1.getPath(); 
		   // JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			//JasperReport jasperReport = JRLoader.loadObjectFromLocation(reportFile);
			parameters.put("logo", reportFile1);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);            
		}
		return "pdfReport";
	}

	@RequestMapping(value = "/reports/clientByFirm.do", method = RequestMethod.GET)
	public String clientByFirmReport(HttpServletRequest request,
			TaskRep taskRep, Long taskId, Long clientId, ModelMap model) {
//		logger.info("Welcome Due Date...!");
		System.out.println("Hello" + taskId);
		List<Organization> orgList = crmManager.getFirmList();
		crmManager.getPartyCodeByCodeId(CodeType.FORM_OF_BUSINESS_CODE_TYPE
				.getId());

		for (Organization organization : orgList) {
			System.out.println(organization.getLegalName());
		}
		model.put("orglist", orgList);
		return "clinetByFirmReport.tilesView";
	}

	@RequestMapping(value = "/reports/clientByFirm.do", method = RequestMethod.POST)
	public String getClientByFirmReport(HttpServletRequest request,Long firmid,
			HttpServletResponse response, Long taskId, Long clientId,
			ModelMap model) throws ServletException, IOException, JRException {
//		logger.info("Welcome Due Date...!");
		System.out.println("Hello I am Firm POST" + taskId);
		System.out.println("Hello My Firm is" + firmid);
		Connection con = null;
		ServletContext context = request.getSession().getServletContext();
		Map<String, Object> parameters = new HashMap();
		Long firmId = PMUtil.getFirmIdFromSession(request);
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		getReportAddress(parameters,model,request,firmid);
		String sortAs = request.getParameter("sortAs");
		 parameters.put("sortAs", sortAs);
		 model.put("sortAs", sortAs);
		parameters.put("firmId", firmId);
		model.put("firmId", firmId);
		String viewAsOption = request.getParameter("viewAs");
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();*/
			return "firmpdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
			
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByFirmreport.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // content type for "xlsx" format.
			response.setHeader("Content-Dispositio n", "inline;filename=ClientListByFirmreport.xlsx"); //inline: the browser will attempt to render it within the browser window.
			response.setContentLength(os.size()); // always set the content length whenever sending back a binary file as an http response otherwise excel throws error," found unreadable file".
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();

			return "firmxlsReport";			
		} else if (viewAsOption.equalsIgnoreCase("html")) {
			//return "firmhtmlReport";
			//File reportFile = new File(context.getRealPath("/resources/ClientListByFirmreport.jasper"));
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByFirmreport.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
		//	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
		}
		
		return "firmpdfReport";
	}

	@RequestMapping(value = "/reports/dueDateByTask.do", method = RequestMethod.GET)
	public String dueDateByTaskReport(HttpServletRequest request,
			TaskRep taskRep, Long taskId, Long clientId, ModelMap model) {
//		logger.info("Welcome Due Date...!");
		Long firmId = PMUtil.getFirmIdFromSession(request);
		System.out.println("Hello" + taskId);
		List<TaxDTO> listPracticeType = taxModuleManager
				.getPracticeType(firmId);

		for (TaxDTO practiceType : listPracticeType) {
			System.out.println(practiceType.getName());
		}

		model.put("tasknamelist", listPracticeType);
		return "dueDatebytask.tilesView";
	}

	@RequestMapping(value = "/reports/dueDateByTask.do", method = RequestMethod.POST)
	public String getDueDateByTaskReport(HttpServletRequest request,HttpServletResponse response,
			TaskRep taskRep, Long taskId, Long clientId, ModelMap model,Long firmid)
			throws ServletException, IOException, ParseException, JRException {
//		logger.info("Welcome Due Date...!");
		Long firmId = PMUtil.getFirmIdFromSession(request);
		System.out.println("Hello I am DueDate POST" + taskId);
		Map<String, Object> parameters = new HashMap();
		Connection con = null;
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con); 
		getReportAddress(parameters,model,request,firmId);
		String from = request.getParameter("dueDate1");
		String to = request.getParameter("dueDate2");
		Timestamp newFrom = dateformat(from);
		Timestamp newTo = dateformat(to);
		String status = request.getParameter("taskStatusId");
		Long newStatus = Long.parseLong( status );  
		String sortBy = request.getParameter("sortAs");
		String viewAsOption=request.getParameter("viewAs");
    	ServletContext context = request.getSession().getServletContext();
    	
		// File reportFile = new File(context.getRealPath("/resources/DueDateByTask.jasper"));
		
		 
		 parameters.put("From", newFrom);
		 parameters.put("To", newTo);
		 parameters.put("TaxType", newStatus);
		 parameters.put("SortBy", sortBy);
		 parameters.put("firmId", firmId);
		// byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 
		 model.put("From", newFrom);
		 model.put("To", newTo);
		 model.put("TaxType", newStatus);
		 model.put("SortBy", sortBy);
		 model.put("firmId", firmId);
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();
			return "done";*/
			return "dueDatepdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/DueDateByTask.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=DueDateByTask.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
			return "dueDatexlsReport";
		} else if (viewAsOption.equalsIgnoreCase("html")) {
			//return "dueDatehtmlReport";
			//File reportFile = new File(context.getRealPath("/resources/DueDateByTask.jasper"));
			InputStream reportFile = getClass().getResourceAsStream("/reports/DueDateByTask.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
		//	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
		}
		return "dueDatepdfReport";
	}

	@RequestMapping(value = "/reports/clientListByMisDeadLines.do", method = RequestMethod.GET)
	public String clientListByMissDeadLinesRep(HttpServletRequest request,
			TaskRep taskRep, Long taskId, Long clientId, ModelMap model) {
//		logger.info("Welcome clientListByMisDeadLinesReport.do!");

		return "clientListByMisDeadLines.tilesView";
	}

	@RequestMapping(value = "/reports/clientListByMisDeadLines.do", method = RequestMethod.POST)
	public String getclientListByMissDeadLinesRep(HttpServletRequest request,
			HttpServletResponse response, Long taskId, Long clientId,
			ModelMap model,Long firmid) throws ServletException, IOException, JRException {
//			logger.info("Welcome Due Date...!");
			System.out.println("Hello I am Firm POST" + taskId);
			Long firmId = PMUtil.getFirmIdFromSession(request);
			Map<String, Object> parameters = new HashMap();
			Connection con = null;
			ServletContext context = request.getSession().getServletContext();
		try {
                   con = jasperService.getDataSource().getConnection();
            } catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		getReportAddress(parameters,model,request,firmid);
		String sortAs = request.getParameter("sortAs");
		String viewAsOption=request.getParameter("viewAs");
		//File reportFile = new File(context.getRealPath("/resources/ClientListByMDL.jasper"));
	    parameters.put("firmId", firmId);
		parameters.put("sortBy", sortAs);
		//byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 model.put("sortBy", sortAs);
		 model.put("firmId", firmId); 
		if (viewAsOption.equalsIgnoreCase("pdf")) {
		 /*response.setContentType("application/pdf");
		  response.setContentLength(bytes.length);
		  ServletOutputStream ouputStream = response.getOutputStream();
		  ouputStream.write(bytes, 0, bytes.length); 
		  ouputStream.flush();
		  ouputStream.close();*/
			return "MDLpdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByMDL.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=ClientListByMDL.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
				return "MDLxlsReport";
		} else if (viewAsOption.equalsIgnoreCase("html")) {
				//return "MDLhtmlReport";
			//File reportFile = new File(context.getRealPath("/resources/ClientListByMDL.jasper"));
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByMDL.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
		}
		return "MDLpdfReport";
 }
			 	
	@RequestMapping(value = "/reports/taskListByFilingType.do", method = RequestMethod.GET)
	    public String taskListByFilingTypeReport(HttpServletRequest request,
	    		TaskRep taskRep, Long taskId, Long clientId,
	            ModelMap model) {
//	        logger.info("Welcome Due Date...!");
	        List<TaxInfoFilingType> listOfAllFilingType = new ArrayList<TaxInfoFilingType>();
	        listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.TAX_FILING_TYPE.getId()));
	        listOfAllFilingType.add(new TaxInfoFilingType(TaxInfoFilingType.INSTALLMENT_FILING_TYPE.getId()));
		   
	        model.put("filingTypeList",listOfAllFilingType);       
	       
	        return "taskListByFilingType.tilesView";
	    }
	    
	    @RequestMapping(value = "/reports/taskListByFilingType.do", method = RequestMethod.POST)
	    public String getTaskListByFilingTypeReport(HttpServletRequest request,HttpServletResponse response,
	    		Long taskId, Long clientId,
	            ModelMap model,Long firmid) throws ServletException, IOException, ParseException, JRException {
//	        logger.info("Welcome Due Date...!POST Method");
	        Map<String, Object> parameters = new HashMap();
	        Connection con = null;

			try {
				con = jasperService.getDataSource().getConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			model.put("REPORT_CONNECTION",con);
			getReportAddress(parameters,model,request,firmid);
			String from = request.getParameter("dueDate1");
			String to = request.getParameter("dueDate2");
			Timestamp newFrom = dateformat(from);
			Timestamp newTo = dateformat(to);
			String status = request.getParameter("filingType");
			Integer newStatus = Integer.parseInt( status );  
			String sortBy = request.getParameter("sortAs");
			String viewAsOption=request.getParameter("viewAs");
	    	ServletContext context = request.getSession().getServletContext();
			// File reportFile = new File(context.getRealPath("/resources/taskListByFilingTypeJ.jasper"));
	    	 parameters.put("firmId", firmid);
			 parameters.put("From", newFrom);
			 parameters.put("To", newTo);
			 parameters.put("FilingType", newStatus);
			 parameters.put("SortBy", sortBy);
			// byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
			 model.put("firmId", firmid);
			 model.put("From", newFrom);
			 model.put("To", newTo);
			 model.put("FilingType", newStatus);
			 model.put("SortBy", sortBy);
			 if(newStatus != -2){
				 parameters.put("FilingType",newStatus);
				 model.put("FilingType", newStatus);
			if (viewAsOption.equalsIgnoreCase("pdf")) {
				/*response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream ouputStream = response.getOutputStream();
				ouputStream.write(bytes, 0, bytes.length); 
				ouputStream.flush();
				ouputStream.close();*/
				return "taskftpdfReport";
			}else if(viewAsOption.equalsIgnoreCase("xls")){
				JRXlsxExporter exporter = new JRXlsxExporter();
				//JExcelApiExporter exporter = new JExcelApiExporter();
				InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByFilingTypeJ.jasper");
				JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
				exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
				exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
				exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
				exporter.exportReport();
				
				response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				response.setHeader("Content-Disposition", "inline;filename=taskListByFilingTypeJ.xlsx");
				response.setContentLength(os.size());
				response.getOutputStream().write(os.toByteArray());
				response.flushBuffer();
	    		return "taskftxlsReport";
	    	}else if(viewAsOption.equalsIgnoreCase("html")){
	    		//return "taskfthtmlReport";
	    		//File reportFile = new File(context.getRealPath("/resources/taskListByFilingTypeJ.jasper"));
	    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByFilingTypeJ.jasper");
				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
				String logoPath = reportFile1.getPath(); 
				//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
				parameters.put("logo", logoPath);
				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		        this.generateHtmlOutput(jasperPrint, request, response);
	    	}
			return "taskftpdfReport";
	       
	    }else{
	    	if (viewAsOption.equalsIgnoreCase("pdf")) {
				/*response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream ouputStream = response.getOutputStream();
				ouputStream.write(bytes, 0, bytes.length); 
				ouputStream.flush();
				ouputStream.close();*/
				return "taskftAllpdfReport";
			}else if(viewAsOption.equalsIgnoreCase("xls")){
				JRXlsxExporter exporter = new JRXlsxExporter();
				//JExcelApiExporter exporter = new JExcelApiExporter();
				InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllFilingTypeJ.jasper");
				JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
				exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
				exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
				exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
				exporter.exportReport();
				
				response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				response.setHeader("Content-Disposition", "inline;filename=taskListByAllFilingTypeJ.xlsx");
				response.setContentLength(os.size());
				response.getOutputStream().write(os.toByteArray());
				response.flushBuffer();
	    		return "taskftAllxlsReport";
	    	}else if(viewAsOption.equalsIgnoreCase("html")){
	    		//return "taskfthtmlReport";
	    		//File reportFile = new File(context.getRealPath("/resources/taskListByFilingTypeJ.jasper"));
	    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllFilingTypeJ.jasper");
				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
				String logoPath = reportFile1.getPath(); 
				//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
				parameters.put("logo", logoPath);
				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		        this.generateHtmlOutput(jasperPrint, request, response);
	    	}
			return "taskftAllpdfReport";
	    }
	       
	    }

	@RequestMapping(value = "/reports/clientListbyPartner.do", method = RequestMethod.GET)
	public String clientListByPartnerReport(HttpServletRequest request,
			TaskRep taskRep, Long taskId, Long clientId, ModelMap model) {
//		logger.info("Welcome task!");
		System.out.println("Hello........" + taskId + " client id is "
				+ clientId);

		Long firmId = PMUtil.getFirmIdFromSession(request);
		System.out.println(firmId);
		model.put("partnerList", getPartnerInChargeData(firmId));
		return "clientListbyPartner.tilesView";
	}

	@RequestMapping(value = "/reports/clientListbyPartner.do", method = RequestMethod.POST)
	public String getClientListByPartnerReport(HttpServletRequest request,
			HttpServletResponse response, Long taskId, Long clientId,Person partnerInCharge,
			ModelMap model,Long firmid) throws ServletException, IOException, JRException {
//		logger.info("Welcome task!");
		System.out.println("Hello........" + taskId + " client id is "
				+ clientId);
		Map<String, Object> parameters = new HashMap();
		Connection con = null;
		ServletContext context = request.getSession().getServletContext();
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		getReportAddress(parameters,model,request,firmid);
		String partner = request.getParameter("partnerInCharge");
		//File reportFile = new File(context.getRealPath("/resources/ClientListByPartnerIncharge.jasper"));
	
		parameters.put("PartnerInCharge", partner);
		//byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con); 
		model.put("PartnerInCharge", partner);
		String viewAsOption=request.getParameter("viewAs");
		if (viewAsOption.equalsIgnoreCase("pdf")) {
		 /*response.setContentType("application/pdf");
		  response.setContentLength(bytes.length);
		  ServletOutputStream ouputStream = response.getOutputStream();
		  ouputStream.write(bytes, 0, bytes.length); 
		  ouputStream.flush();
		  ouputStream.close();*/
		  return "clientListpdfReport";
		}else if(viewAsOption.equalsIgnoreCase("xls")){
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByPartnerIncharge.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=ClientListByPartnerIncharge.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "clientListxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "clientListhtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/ClientListByPartnerIncharge.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/ClientListByPartnerIncharge.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "clientListpdfReport";
	}
    @RequestMapping(value = "/reports/taskListByEmp.do", method = RequestMethod.GET)
    public String taskByEmpReport(HttpServletRequest request,
    		TaskRep taskRep, Long taskId, Long clientId,
            ModelMap model) {
//        logger.info("Welcome Due Date...!");
        System.out.println("Hello"+taskId);
     Long firmId = PMUtil.getFirmIdFromSession(request);
        System.out.println(firmId);
       List<Party> staffList=getStaffInChargeData(firmId);
       model.put("staffList", staffList);
        return "taskListByEmp.tilesView";
    }
    
    @RequestMapping(value = "/reports/taskListByEmp.do", method = RequestMethod.POST)
    public String getTaskByEmpReport(HttpServletRequest request,
    		HttpServletResponse response, Long taskId, Long clientId,
            ModelMap model,Long firmid) throws ServletException, IOException, JRException, ParseException {
//    	logger.info("Task List By firm...!POST Method");
    	Map<String, Object> parameters = new HashMap();
    	Connection con = null;
    	Long firmId = PMUtil.getFirmIdFromSession(request);
		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		getReportAddress(parameters,model,request,firmId);
		String staff = request.getParameter("pIC");
		Integer newStatus =Integer.parseInt(staff);
		String sort = request.getParameter("days");
		String from = request.getParameter("dueDate1");
		String to = request.getParameter("dueDate2");
		Timestamp newFrom = dateformat(from);
		Timestamp newTo = dateformat(to);
		String viewAsOption=request.getParameter("viewAs");
		ServletContext context = request.getSession().getServletContext();
	//	File reportFile = new File(context.getRealPath("/resources/TaskListByEmployee.jasper"));
		parameters.put("firmId", firmId);
		parameters.put("SortBy", sort);
		parameters.put("From", newFrom);
		parameters.put("To", newTo);
	//	byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 
		 model.put("SortBy", sort);
		 model.put("From", newFrom);
		 model.put("To", newTo);
		 model.put("firmId", firmId);
		 if(newStatus != -2){
                long status = newStatus;
				parameters.put("staffIncharge", status);
				model.put("staffIncharge", status);
				
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();*/
			return "taskbyemppdfReport";
		}else if(viewAsOption.equalsIgnoreCase("xls")){
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByEmployee.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=TaskListByEmployee.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "taskbyempxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "taskbyemphtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/TaskListByEmployee.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByEmployee.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
		//	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "taskbyemppdfReport";

		 }
		 else{
			 if (viewAsOption.equalsIgnoreCase("pdf")) {
				 return "taskbyempAllpdfReport";
			 }
			 else if(viewAsOption.equalsIgnoreCase("xls")){
					JRXlsxExporter exporter = new JRXlsxExporter();
					//JExcelApiExporter exporter = new JExcelApiExporter();
					InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllEmployee.jasper");
					JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
					exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
					ByteArrayOutputStream os = new ByteArrayOutputStream();
					exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
					exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
					exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
					exporter.exportReport();
					
					response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
					response.setHeader("Content-Disposition", "inline;filename=taskListByAllEmployee.xlsx");
					response.setContentLength(os.size());
					response.getOutputStream().write(os.toByteArray());
					response.flushBuffer();
		    		return "taskbyempAllxlsReport";
		    	}
			 else if(viewAsOption.equalsIgnoreCase("html")){
		    		//return "taskbyemphtmlReport";
		    		//File reportFile = new File(context.getRealPath("/resources/TaskListByEmployee.jasper"));
		    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllEmployee.jasper");
					File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
					String logoPath = reportFile1.getPath(); 
				//	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
					parameters.put("logo", logoPath);
					JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
			        this.generateHtmlOutput(jasperPrint, request, response);
		    	}
			 return "taskbyempAllpdfReport";
		 }
    }
    
    @RequestMapping(value = "/reports/taskListByStatus.do", method = RequestMethod.GET)
    public String taskListByStatusReport(HttpServletRequest request,
    		TaskRep taskRep, Long taskId, Long clientId,
            ModelMap model) {
//        logger.info("Welcome Due Date...!");
        System.out.println("Hello"+taskId);
       
        List<TaskStatus> listOfTaskStatus=taxModuleManager.getTaskStatusList();
        model.put("statusList",listOfTaskStatus);       
       
        return "taskListByStatus.tilesView";
    }
    
    @RequestMapping(value = "/reports/taskListByStatus.do", method = RequestMethod.POST)
    public String getTaskListByStatusReport(HttpServletRequest request,HttpServletResponse response,
    		Long taskId, Long clientId,
            ModelMap model,Long firmid) throws ServletException, IOException, ParseException, JRException {
//    	logger.info("Task List By firm...!POST Method");
    	Long firmId = PMUtil.getFirmIdFromSession(request);
    	 Map<String, Object> parameters = new HashMap();
        Connection con = null;

		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION",con);
		getReportAddress(parameters,model,request,firmId);
		String from = request.getParameter("dueDate1");
		String to = request.getParameter("dueDate2");
		Timestamp newFrom = dateformat(from);
		Timestamp newTo = dateformat(to);
		String status = request.getParameter("taskStatusId");
		Short newStatus = Short.parseShort( status );
		String viewAsOption=request.getParameter("viewAs");
    	ServletContext context = request.getSession().getServletContext();
		// File reportFile = new File(context.getRealPath("/resources/taskListByStatus1.jasper"));
    	 parameters.put("firmId", firmid);
		 parameters.put("start_date", newFrom);
		 parameters.put("end_date", newTo);
		 //byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 model.put("firmId", firmid);
		 model.put("start_date", newFrom);
		 model.put("end_date", newTo);
		 
		 if(newStatus != -2){
             Short stat = newStatus;
				parameters.put("status", stat);
				model.put("status", stat);
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();*/
			//return "done";
			return "taskbystatuspdfReport";
		}
		else if(viewAsOption.equalsIgnoreCase("xls")){
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByStatus.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=taskListByStatus.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "taskbystatusxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "taskbystatushtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/taskListByStatus1.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByStatus.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "taskbystatuspdfReport";
    }else{
    	if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();*/
			//return "done";
			return "taskbystatusAllpdfReport";
		}
		else if(viewAsOption.equalsIgnoreCase("xls")){
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllStatus.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=taskListByAllStatus.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "taskbystatusAllxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "taskbystatushtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/taskListByStatus1.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllStatus.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "taskbystatusAllpdfReport";
    }
    }  
    private Timestamp dateformat(String from) throws ParseException {
    	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    	java.util.Date date = sdf.parse(from);
    	java.sql.Timestamp timest = new java.sql.Timestamp(date.getTime());
		return timest;
	}

	@RequestMapping(value = "/reports/taskListByFirm.do", method = RequestMethod.GET)
    public String taskListByFirmReport(HttpServletRequest request,
    		TaskRep taskRep, Long taskId, Long clientId,
            ModelMap model) {
//        logger.info("Task List By Firm...!");
        Long firmId = PMUtil.getFirmIdFromSession(request);
        List<Party> staffList=getStaffInChargeData(firmId);
        model.put("staffList", staffList);
        return "taskListByFirm.tilesView";
    }
    @RequestMapping(value = "/reports/taskListByFirm.do", method = RequestMethod.POST)
    public String getTaskListByFirmReport(HttpServletRequest request,
    		HttpServletResponse response, Long taskId, Long clientId,
            ModelMap model,Long firmid) throws ServletException, IOException, ParseException, JRException {
//    	logger.info("Task List By firm...!POST Method");
    	System.out.println("Firm id is:" + firmid);
    	Map<String, Object> parameters = new HashMap();
        Connection con = null;

		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION",con);
		getReportAddress(parameters,model,request,firmid);
		String from = request.getParameter("dueDate1");
		String to = request.getParameter("dueDate2");
		Timestamp newFrom = dateformat(from);
		Timestamp newTo = dateformat(to);
		
		String sortBy = request.getParameter("sortAs");
			
		String viewAsOption=request.getParameter("viewAs");
    	ServletContext context = request.getSession().getServletContext();
		// File reportFile = new File(context.getRealPath("/resources/TaskListByFirm.jasper"));
    	parameters.put("firmId", firmid);
		 parameters.put("From", newFrom);
		 parameters.put("To", newTo);
		 parameters.put("SortBy", sortBy);
		 parameters.put("firmId", firmid);
		// byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 model.put("firmId", firmid);
		 model.put("From", newFrom);
		 model.put("To", newTo);
		 model.put("SortBy", sortBy);
		 model.put("firmId", firmid);
		if (viewAsOption.equalsIgnoreCase("pdf")) {
			/*response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length); 
			ouputStream.flush();
			ouputStream.close();*/
			return "taskbyfirmpdfReport";
		}else if(viewAsOption.equalsIgnoreCase("xls")){
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByFirm.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=TaskListByFirm.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "taskbyfirmxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "taskbyfirmhtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/TaskListByFirm.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByFirm.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "taskbyfirmpdfReport";
       
    }
    
    @RequestMapping(value = "/reports/newTaxListByStaff.do", method = RequestMethod.GET)
    public String newTaxListByStaffReport(HttpServletRequest request,
    		TaskRep taskRep, Long taskId, Long clientId,
            ModelMap model) {
//        logger.info("Welcome task!");
        System.out.println("Hello........"+taskId+" client id is "+ clientId);
       
        Long firmId = PMUtil.getFirmIdFromSession(request);
        System.out.println(firmId);
        model.put("partnerList", getPartnerInChargeData(firmId));
        return "newTaxListByStaff.tilesView";
    }
    
    @RequestMapping(value = "/reports/newTaxListByStaff.do", method = RequestMethod.POST)
    public String getNewTaxListByStaffReport(HttpServletRequest request,HttpServletResponse response,
    		Long taskId, Long clientId,
            ModelMap model,Long firmid) throws ServletException, IOException, JRException {
//    	logger.info("Task List By firm...!POST Method");
    	Long firmId = PMUtil.getFirmIdFromSession(request);
    	ServletContext context = request.getSession().getServletContext();
		 Map<String, Object> parameters = new HashMap();
        Connection con = null;

		try {
			con = jasperService.getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION",con);
		getReportAddress(parameters,model,request,firmId);
		String sortBy = request.getParameter("InCharge");
		parameters.put("InCharge",sortBy);
		parameters.put("firmId",firmId);
        model.put("InCharge", sortBy);
        model.put("firmId",firmId);
		String viewAsOption=request.getParameter("viewAs");
		if(viewAsOption.equalsIgnoreCase("pdf")){
			return "workLoadsummarypdfReport";
    	}else if(viewAsOption.equalsIgnoreCase("xls")){
    		JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/workLoadSummary.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=workLoadSummary.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
    		return "workLoadsummaryxlsReport";
    	}else if(viewAsOption.equalsIgnoreCase("html")){
    		//return "workLoadsummaryhtmlReport";
    		//File reportFile = new File(context.getRealPath("/resources/workLoadSummary.jasper"));
    		InputStream reportFile = getClass().getResourceAsStream("/reports/workLoadSummary.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
    	}
		return "workLoadsummarypdfReport";
    }
	    
	    @RequestMapping(value = "/reports/taskByDueDate.do", method = RequestMethod.GET)
	    public String taskByDueDateReport(HttpServletRequest request,
	    		TaskRep taskRep, Long taskId, Long clientId,
	            ModelMap model) {
//	        logger.info("Welcome Due Date...!");
	        System.out.println("Hello"+taskId);
	        
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        System.out.println(firmId);
	       List<Party> staffList=getStaffInChargeData(firmId);
	        for (Party organization : staffList) {
				System.out.println(organization.getName());
			}
	        model.put("staffList", staffList);
	        
	        return "taskByDueDate.tilesView";
	    }
	    
	    @RequestMapping(value = "/reports/taskByDueDate.do", method = RequestMethod.POST)
	    public String getTaskBydueDateReport(HttpServletRequest request,HttpServletResponse response,
	    		TaskRep taskRep, Long taskId, Long clientId,
	            ModelMap model,Long firmid) throws ServletException, IOException, ParseException, JRException {
//	    	logger.info("Welcome Due Date...!");
	        System.out.println("Hello I am DueDate POST"+taskId);
	        Map<String, Object> parameters = new HashMap();
	       Connection con = null;
	       Timestamp newFrom = null;
			Timestamp newTo = null;
			String from = null;
			String to = null;
				try {
					con = jasperService.getDataSource().getConnection();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				model.put("REPORT_CONNECTION",con);
				getReportAddress(parameters,model,request,firmid);
				 from = request.getParameter("dueDate1");
				 to = request.getParameter("dueDate2");
				if(from != null & to != null){
					    newFrom = dateformat(from);
						newTo = dateformat(to);
						}
						String days = request.getParameter("days"); 
						
						if(days != null){
							Integer intDays = Integer.parseInt(days);
							Date today = new Date();
							DateFormat formatter ; 
							formatter = new SimpleDateFormat("MM/dd/yyyy");
							String s = formatter.format(today);
							newFrom = dateformat(s);
				            Calendar cal = Calendar.getInstance();  
				            cal.setTime(today); 
				            cal.add(Calendar.DATE,intDays); 
				            today = cal.getTime();
				            s = formatter.format(today);
							newTo = dateformat(s);
						}
						String sortBy = request.getParameter("sortAs");
						String viewAsOption=request.getParameter("viewAs");
				    	ServletContext context = request.getSession().getServletContext();
						// File reportFile = new File(context.getRealPath("/resources/TaskListDueDate.jasper"));
				    	 parameters.put("firmId", firmid);
						 parameters.put("From", newFrom);
						 parameters.put("To", newTo);
						 parameters.put("SortBy", sortBy);
						// byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
						 model.put("firmId", firmid);
						 model.put("From", newFrom);
						 model.put("To", newTo);
						 model.put("SortBy", sortBy);
						if (viewAsOption.equalsIgnoreCase("pdf")) {
							/*response.setContentType("application/pdf");
							response.setContentLength(bytes.length);
							ServletOutputStream ouputStream = response.getOutputStream();
							ouputStream.write(bytes, 0, bytes.length); 
							ouputStream.flush();
							ouputStream.close();*/
							return "taskDueDatepdfReport";
						} 
						else if(viewAsOption.equalsIgnoreCase("xls")){
							JRXlsxExporter exporter = new JRXlsxExporter();
							//JExcelApiExporter exporter = new JExcelApiExporter();
							InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListDueDate.jasper");
							JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
							exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
							ByteArrayOutputStream os = new ByteArrayOutputStream();
							exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
							exporter.exportReport();
							
							response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
							response.setHeader("Content-Disposition", "inline;filename=TaskListDueDate.xlsx");
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
							response.setContentLength(os.size());
							response.getOutputStream().write(os.toByteArray());
							response.flushBuffer();
		    		      return "taskDueDatedueDatexlsReport";
		    	       }else if(viewAsOption.equalsIgnoreCase("html")){
		    		    //  return "taskDueDatehtmlReport";
		    				//File reportFile = new File(context.getRealPath("/resources/TaskListDueDate.jasper"));
		    				InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListDueDate.jasper");
		    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
		    				String logoPath = reportFile1.getPath(); 
		    			//	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
		    				parameters.put("logo", logoPath);
		    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		    		        this.generateHtmlOutput(jasperPrint, request, response);
		    	       }
				          return "taskDueDatepdfReport";
	    }
	    
	    @RequestMapping(value = "/reports/taskPaymentDetails.do", method = RequestMethod.GET)
	    public String taskPaymentDetailsReport(HttpServletRequest request,
	    		TaskRep taskRep, Long taskId, Long clientId,
	            ModelMap model) {
//	        logger.info("Welcome task...!");
	        System.out.println("Hello"+taskId);
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        System.out.println(firmId);
	        List<PaymentType> listpaymentType = new ArrayList<PaymentType>();
	        listpaymentType.add(new PaymentType(PaymentType.PAYMENT_TYPE_CHEQUE.getId()));
	        listpaymentType.add(new PaymentType(PaymentType.PAYMENT_TYPE_EFILING.getId()));
	        listpaymentType.add(new PaymentType(PaymentType.PAYMENT_TYPE_CASH.getId()));
	        model.put("listpmtType",listpaymentType);
	        return "taskPaymentType.tilesView";
	    }
	    
	    @RequestMapping(value = "/reports/taskPaymentDetails.do", method = RequestMethod.POST)
	    public String taskPaymentDetailsReport(HttpServletRequest request,
	    		HttpServletResponse response, Long taskId, Long clientId,
	            ModelMap model,String srt,Date dueDate1,Long firmid) throws ServletException, IOException, ParseException, JRException {
//	    	logger.info("Welcome Task partner...!");
	    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	         List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
	         String userRole = grantedAuthorityImpls.get(0).toString();
	    	Map<String, Object> parameters = new HashMap();
	       Connection con = null;
	       Timestamp newFrom = null;
			Timestamp newTo = null;
			String from = null;
			String to = null;

				try {
					con = jasperService.getDataSource().getConnection();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				model.put("REPORT_CONNECTION",con);
				getReportAddress(parameters,model,request,firmid);
				 from = request.getParameter("dueDate1");
				 to = request.getParameter("dueDate2");
				if(from != null & to != null){
				newFrom = dateformat(from);
			    newTo = dateformat(to);
				}
				String days = request.getParameter("days"); 
				
				if(days != null){
					Integer intDays = Integer.parseInt(days);
					Date today = new Date();
					DateFormat formatter ; 
					formatter = new SimpleDateFormat("MM/dd/yyyy");
					String s = formatter.format(today);
					newFrom = dateformat(s);
		            Calendar cal = Calendar.getInstance();  
		            cal.setTime(today); 
		            cal.add(Calendar.DATE,intDays); 
		            today = cal.getTime();
		            s = formatter.format(today);
					newTo = dateformat(s);
				}
				String pt = request.getParameter("pmtType");
				Integer pType = Integer.parseInt(pt);
				String viewAsOption=request.getParameter("viewAs");
		    	ServletContext context = request.getSession().getServletContext();
		    	 parameters.put("firmId", firmid);
				 parameters.put("From", newFrom);
				 parameters.put("To", newTo);
				 parameters.put("pmtType", pt);
				 model.put("firmId", firmid);
				 model.put("From", newFrom);
				 model.put("To", newTo);
				 model.put("pmtType", pt);
				 if(userRole.equals("ROLE_CLIENT_STAFF")){
					 HttpSession session = request.getSession();
					 PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
					 parameters.put("clientId",userProfile.getId());
					 model.put("clientId",userProfile.getId());
					 	if (viewAsOption.equalsIgnoreCase("pdf")) {
						 
						 return "taskPaymentTypeClientPdf";
						 
					 	}else if(viewAsOption.equalsIgnoreCase("xls")){
							JRXlsxExporter exporter = new JRXlsxExporter();
							InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentType.jasper");
							JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
							exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
							ByteArrayOutputStream os = new ByteArrayOutputStream();
							exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
							exporter.exportReport();
							
							response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
							response.setHeader("Content-Disposition", "inline;filename=taskPaymentType.xlsx");
							response.setContentLength(os.size());
							response.getOutputStream().write(os.toByteArray());
							response.flushBuffer();
							return "taskPaymentTypeClientXls";
				    	}
					 	else if(viewAsOption.equalsIgnoreCase("html")){
				    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentType.jasper");
		    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
		    				String logoPath = reportFile1.getPath(); 
		    				parameters.put("logo", logoPath);
		    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		    		        this.generateHtmlOutput(jasperPrint, request, response);
				    	}
				 }
				 if(pType!=-2){
					 if (viewAsOption.equalsIgnoreCase("pdf")) {
						 
						 return "taskPaymentTypePdf";
						 
					 }else if(viewAsOption.equalsIgnoreCase("xls")){
							JRXlsxExporter exporter = new JRXlsxExporter();
							InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentType.jasper");
							JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
							exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
							ByteArrayOutputStream os = new ByteArrayOutputStream();
							exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
							exporter.exportReport();
							
							response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
							response.setHeader("Content-Disposition", "inline;filename=taskPaymentType.xlsx");
							response.setContentLength(os.size());
							response.getOutputStream().write(os.toByteArray());
							response.flushBuffer();
							return "taskPaymentTypeXls";
				    	}
					 else if(viewAsOption.equalsIgnoreCase("html")){
				    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentType.jasper");
		    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
		    				String logoPath = reportFile1.getPath(); 
		    				parameters.put("logo", logoPath);
		    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		    		        this.generateHtmlOutput(jasperPrint, request, response);
				    	}
				 }else{
					 if (viewAsOption.equalsIgnoreCase("pdf")) {
						 
						 return "taskPaymentTypeAllPdf";
						 
					 }else if(viewAsOption.equalsIgnoreCase("xls")){
							JRXlsxExporter exporter = new JRXlsxExporter();
							InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentTypeAll.jasper");
							JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
							exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
							ByteArrayOutputStream os = new ByteArrayOutputStream();
							exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
							exporter.exportReport();
							
							response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
							response.setHeader("Content-Disposition", "inline;filename=taskPaymentType.xlsx");
							response.setContentLength(os.size());
							response.getOutputStream().write(os.toByteArray());
							response.flushBuffer();
							return "taskPaymentTypeAllXls";
				    	}
					 else if(viewAsOption.equalsIgnoreCase("html")){
				    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskPaymentTypeAll.jasper");
		    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
		    				String logoPath = reportFile1.getPath(); 
		    				parameters.put("logo", logoPath);
		    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		    		        this.generateHtmlOutput(jasperPrint, request, response);
				    	}
				 }
				return "taskPaymentTypePdf";
	    }
	    
	    @RequestMapping(value = "/reports/taskListByPartner.do", method = RequestMethod.GET)
	    public String taskModuleReport(HttpServletRequest request,
	    		TaskRep taskRep, Long taskId, Long clientId,
	            ModelMap model) {
//	        logger.info("Welcome task...!");
	        System.out.println("Hello"+taskId);
	        Long firmId = PMUtil.getFirmIdFromSession(request);
	        System.out.println(firmId);
	        model.put("partnerList", getPartnerInChargeData(firmId));
	        return "taskListByPartner.tilesView";
	    }
	    
	    @RequestMapping(value = "/reports/taskListByPartner.do", method = RequestMethod.POST)
	    public String taskReportModule(HttpServletRequest request,
	    		HttpServletResponse response, Long taskId, Long clientId,
	            ModelMap model,String srt,Date dueDate1,Long firmid) throws ServletException, IOException, ParseException, JRException {
//	    	logger.info("Welcome Task partner...!");
	    	Map<String, Object> parameters = new HashMap();
	       Connection con = null;
	       Timestamp newFrom = null;
			Timestamp newTo = null;
			String from = null;
			String to = null;

				try {
					con = jasperService.getDataSource().getConnection();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				model.put("REPORT_CONNECTION",con);
				getReportAddress(parameters,model,request,firmid);
				 from = request.getParameter("dueDate1");
				 to = request.getParameter("dueDate2");
				if(from != null & to != null){
				newFrom = dateformat(from);
			    newTo = dateformat(to);
				}
				String days = request.getParameter("days"); 
				
				if(days != null){
					Integer intDays = Integer.parseInt(days);
					Date today = new Date();
					DateFormat formatter ; 
					formatter = new SimpleDateFormat("MM/dd/yyyy");
					String s = formatter.format(today);
					newFrom = dateformat(s);
		            Calendar cal = Calendar.getInstance();  
		            cal.setTime(today); 
		            cal.add(Calendar.DATE,intDays); 
		            today = cal.getTime();
		            s = formatter.format(today);
					newTo = dateformat(s);
				}
				String status = request.getParameter("pIC");
				Integer newStatus = Integer.parseInt( status );
				String sortBy = request.getParameter("sortAs");
				String viewAsOption=request.getParameter("viewAs");
		    	ServletContext context = request.getSession().getServletContext();
				// File reportFile = new File(context.getRealPath("/resources/TaskListByPartner.jasper"));
		    	 parameters.put("firmId", firmid);
				 parameters.put("From", newFrom);
				 parameters.put("To", newTo);
				 parameters.put("SortBy", sortBy);
				// byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
				 model.put("firmId", firmid);
				 model.put("From", newFrom);
				 model.put("To", newTo);
				 model.put("SortBy", sortBy);
				 if(newStatus != -2){

					 model.put("PartnerInCharge", newStatus);
					 parameters.put("PartnerInCharge", newStatus);
					 
				 if (viewAsOption.equalsIgnoreCase("pdf")) {
					/*response.setContentType("application/pdf");
					response.setContentLength(bytes.length);
					ServletOutputStream ouputStream = response.getOutputStream();
					ouputStream.write(bytes, 0, bytes.length); 
					ouputStream.flush();
					ouputStream.close();
					return "done";*/
					return "taskModulepdfReport";
				}else if(viewAsOption.equalsIgnoreCase("xls")){
					JRXlsxExporter exporter = new JRXlsxExporter();
					//JExcelApiExporter exporter = new JExcelApiExporter();
					InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByPartner.jasper");
					JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
					exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
					ByteArrayOutputStream os = new ByteArrayOutputStream();
					exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
					exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
					exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
					exporter.exportReport();
					
					response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
					response.setHeader("Content-Disposition", "inline;filename=TaskListByPartner.xlsx");
					response.setContentLength(os.size());
					response.getOutputStream().write(os.toByteArray());
					response.flushBuffer();
		    		return "taskModulexlsReport";
		    	}else if(viewAsOption.equalsIgnoreCase("html")){
		    		//return "taskModulehtmlReport";
		    		//File reportFile = new File(context.getRealPath("/resources/TaskListByPartner.jasper"));
		    		InputStream reportFile = getClass().getResourceAsStream("/reports/TaskListByPartner.jasper");
    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
    				String logoPath = reportFile1.getPath(); 
    				//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
    				parameters.put("logo", logoPath);
    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
    		        this.generateHtmlOutput(jasperPrint, request, response);
		    	}
				return "taskModulepdfReport";
	    }
				 else{
					 if (viewAsOption.equalsIgnoreCase("pdf")) {
						 
						 return "taskModuleAllpdfReport";
						 
					 }else if(viewAsOption.equalsIgnoreCase("xls")){
							JRXlsxExporter exporter = new JRXlsxExporter();
							//JExcelApiExporter exporter = new JExcelApiExporter();
							InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllPartner.jasper");
							JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
							exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
							ByteArrayOutputStream os = new ByteArrayOutputStream();
							exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
							exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
							exporter.exportReport();
							
							response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
							response.setHeader("Content-Disposition", "inline;filename=taskListByAllPartner.xlsx");
							response.setContentLength(os.size());
							response.getOutputStream().write(os.toByteArray());
							response.flushBuffer();
							return "taskModuleAllxlsReport";
				    	}
					 else if(viewAsOption.equalsIgnoreCase("html")){
				    		//return "taskModulehtmlReport";
				    		//File reportFile = new File(context.getRealPath("/resources/TaskListByPartner.jasper"));
				    		InputStream reportFile = getClass().getResourceAsStream("/reports/taskListByAllPartner.jasper");
		    				File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
		    				String logoPath = reportFile1.getPath(); 
		    				//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
		    				parameters.put("logo", logoPath);
		    				JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
		    		        this.generateHtmlOutput(jasperPrint, request, response);
				    	}
				 }
				return "taskModuleAllpdfReport";
	    }
	    
	    @RequestMapping(value = "/reports/filingsByClient.do", method = RequestMethod.GET)
		public String filingByClientReport(HttpServletRequest request,
				TaskRep taskRep, Long taskId, Long clientId, ModelMap model) {
			logger.info("Welcome filings");
			return "filingsByClient.tilesView";
		}

		@RequestMapping(value = "/reports/filingsByClient.do", method = RequestMethod.POST)
		public String getfilingByClientReport(HttpServletRequest request,HttpServletResponse response,TaskRep taskRep, Long taskId, Long clientId, ModelMap model,Long firmid) throws JRException, IOException, ServletException{
			Long firmId = PMUtil.getFirmIdFromSession(request);
			 HttpSession session = request.getSession(false);
				PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
		     Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		     List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
		     String userRole = grantedAuthorityImpls.get(0).toString();
		     
			ServletContext context = request.getSession().getServletContext();
			Map<String,Object> parameters = new HashMap();
			Connection con = null;
			try {
                con = jasperService.getDataSource().getConnection();
         } catch (SQLException e) {
			e.printStackTrace();
		}
		model.put("REPORT_CONNECTION", con);
		getReportAddress(parameters,model,request,firmid);
		String sortAs = request.getParameter("sortAs");
		String viewAsOption=request.getParameter("viewAs");
		//File reportFile = new File(context.getRealPath("/resources/ClientListByMDL.jasper"));
	    parameters.put("firmId", firmId);
		parameters.put("SortBy", sortAs);
		//byte[] bytes =JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, con);
		 model.put("SortBy", sortAs);
		 model.put("firmId", firmId); 
		if (viewAsOption.equalsIgnoreCase("pdf")) {
		 /*response.setContentType("application/pdf");
		  response.setContentLength(bytes.length);
		  ServletOutputStream ouputStream = response.getOutputStream();
		  ouputStream.write(bytes, 0, bytes.length); 
		  ouputStream.flush();
		  ouputStream.close();*/
			return "FilingspdfReport";
		} else if (viewAsOption.equalsIgnoreCase("xls")) {
			JRXlsxExporter exporter = new JRXlsxExporter();
			//JExcelApiExporter exporter = new JExcelApiExporter();
			InputStream reportFile = getClass().getResourceAsStream("/reports/FilingByClient.jasper");
			JasperPrint print = JasperFillManager.fillReport(reportFile, parameters, con);
			exporter.setParameter(JExcelApiExporterParameter.JASPER_PRINT, print);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			exporter.setParameter(JExcelApiExporterParameter.OUTPUT_STREAM, os);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
			exporter.setParameter(JExcelApiExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
			exporter.exportReport();
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "inline;filename=FilingByClient.xlsx");
			response.setContentLength(os.size());
			response.getOutputStream().write(os.toByteArray());
			response.flushBuffer();
				return "FilingsxlsReport";
		} else if (viewAsOption.equalsIgnoreCase("html")) {
				//return "MDLhtmlReport";
			//File reportFile = new File(context.getRealPath("/resources/ClientListByMDL.jasper"));
			InputStream reportFile = getClass().getResourceAsStream("/reports/FilingByClient.jasper");
			File reportFile1 = new File(context.getRealPath("/logo/logo.jpg"));
			String logoPath = reportFile1.getPath(); 
			//JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			parameters.put("logo", logoPath);
			JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile, parameters, con);
	        this.generateHtmlOutput(jasperPrint, request, response);
		}
		return "FilingspdfReport";
		}
}
