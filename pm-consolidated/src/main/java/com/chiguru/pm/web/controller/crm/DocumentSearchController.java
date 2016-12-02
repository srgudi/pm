package com.chiguru.pm.web.controller.crm;

import java.util.ResourceBundle;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.InputStream;
import java.io.IOException;
import org.apache.commons.io.IOUtils;
import org.apache.chemistry.opencmis.client.api.CmisObject;

import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.chemistry.opencmis.client.api.ItemIterable;
import org.apache.chemistry.opencmis.client.api.QueryResult;
import org.apache.chemistry.opencmis.client.api.Session;
import org.apache.chemistry.opencmis.client.api.SessionFactory;
import org.apache.chemistry.opencmis.client.bindings.spi.atompub.AbstractAtomPubService;
import org.apache.chemistry.opencmis.client.bindings.spi.atompub.AtomPubParser;
import org.apache.chemistry.opencmis.client.runtime.SessionFactoryImpl;
import org.apache.chemistry.opencmis.commons.SessionParameter;
import org.apache.chemistry.opencmis.commons.enums.BindingType;
import org.apache.chemistry.opencmis.commons.enums.CapabilityQuery;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.DocumentSerach;
import com.chiguru.pm.crm.dto.DocumentsDTO;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.crm.util.GridUtil;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.service.DocumentManager;
import com.chiguru.pm.web.util.PMUtil;
import com.chiguru.pm.web.util.GridJSONResponse;


@Controller
public class DocumentSearchController {
	private Logger logger = org.slf4j.LoggerFactory.getLogger(DocumentSearchController.class);
	  @Autowired
	    protected CRMManager crmManager;
	  @Autowired
	    protected TaxModuleManager taxModuleManager;
	  @Autowired
	  protected DocumentManager documentManager;
	
	
	  @RequestMapping(value = "/client/clientDocumentSearch.do", method = RequestMethod.GET)
	    public String newCustomer(HttpServletRequest request, ModelMap model){
			DocumentSerach documentSerach = new DocumentSerach();
			model.addAttribute("documentSerach", documentSerach);
	    	return "client/documentSearch";
	    }
	
	 
	  @RequestMapping(value = "/client/clientDocumentSearchList.do", method = RequestMethod.GET)
	    public @ResponseBody
	    GridJSONResponse clientDocumentList(HttpServletRequest request,Long clientId,String fileName,String clientName, String docDatepickerCrtFrom, String fileExtension, String docDatepickerCrtTo, String docAuthor) {
		       Long firmId = PMUtil.getFirmIdFromSession(request);
		       Long taskId = (long) 0;
			 DocumentsDTO documentsDTO = new DocumentsDTO();
			 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
			// HttpSession session1 = request.getSession();
			// clientId = (Long) session1.getAttribute("clientId");
			 String filename = fileName;
			 String fileNameUpper = null;
			 String fileNameFirstUpper = null;
			 String filenameLower = null;
			 if(clientId != null){
			 if(!filename.isEmpty()){
		     filenameLower = filename.toLowerCase();
			 fileNameUpper = filename.toUpperCase();
			 fileNameFirstUpper = Character.toUpperCase(filename.charAt(0))+filename.substring(1);
			 }
			 String clentName = clientName;
			 String clientNameUpper = null;
			 String clientNameFirstUpper = null;
			 String clientNameLower = null;
			 if(!clentName.isEmpty()){
				 clientNameUpper = clentName.toUpperCase();
				 clientNameLower = clentName.toLowerCase();
				 clientNameFirstUpper = Character.toUpperCase(clentName.charAt(0))+clentName.substring(1);
			 }
			 String date = docDatepickerCrtFrom;
			 String toDate = docDatepickerCrtTo;
			 String fileExtn = fileExtension;
			 String fileExt  = null;
			 String author = docAuthor;
			 String authorUpper = null;
			 String authorLower = null;
			 String authorFirstUpper = null;
			 if(!author.isEmpty()){
				 authorUpper = author.toUpperCase();
				 authorLower = author.toLowerCase();
				 authorFirstUpper = Character.toUpperCase(author.charAt(0))+author.substring(1);
			 }
			 String mimetype = null;
			 if(!fileExtn.isEmpty()){
				fileExt = fileExtn.toLowerCase();
			 mimetype = documentManager.getMimeTypeForFileExtension(fileExt);
			 }
			// if((filename != null)||(clientName != null)||(date != null)||(mimetype != null)|| (toDate != null) || (clientId != null) || (author != null)){
			 if((!filename.isEmpty())||(!clentName.isEmpty())||(!date.isEmpty())||(mimetype != null)|| (!toDate.isEmpty()) || (!author.isEmpty())){
			 Session session = documentManager.getCMISSession();
				if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
		                .equals(CapabilityQuery.METADATAONLY)) {				
				}else{
					String query = null;
					if(!filename.isEmpty()) {
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (d.cmis:name LIKE'%"+filename+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if(!clentName.isEmpty()){
					  query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (w.custom:CompanyName LIKE'%"+clentName+"%' or w.custom:CompanyName LIKE'%"+clientNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if((!date.isEmpty()) && (!toDate.isEmpty())){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:UploadedDate >= TIMESTAMP '"+date+"T00:00:00.000-05:00' and w.custom:UploadedDate <=  TIMESTAMP '"+toDate+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
					}else if (mimetype != null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where d.cmis:contentStreamMimeType = '"+mimetype+"' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if (!author.isEmpty()){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (a.cm:author LIKE'%"+author+"%' or a.cm:author LIKE'%"+authorFirstUpper+"%' or a.cm:author LIKE'%"+authorUpper+"%' or a.cm:author LIKE'%"+authorLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
					}
					/*else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}*/
					ItemIterable<QueryResult> q = session.query(query, false);
		            int i = 1;
		            for (QueryResult qr : q) {
		            	        String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
			                    documentsDTO.setCount(i);
			                    i++;
				    		   String fName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
				    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
				    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
				    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
				    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
				    		   Date displayDate = crtDate.getTime();
				    		   DocumentsDTO docDTO = new DocumentsDTO();
				    		   docDTO.setDocId(objectId);
				    		   docDTO.setFileName(fName);
				    		   docDTO.setClientName(clntName);
				    		   docDTO.setTitle(title);
				    		   docDTO.setAuthor(autor);
				    		   docDTO.setDisplayDate(displayDate);
				    		   String jspDate = docDTO.getFormattedDate();
				    		   docDTO.setFormattedDate(jspDate);
				    		   gridDto.add(docDTO);
				}
				}
			    }
			    }
			    String sEcho = request.getParameter("sEcho");
			    GridJSONResponse jsonResponse = prepareResponse(gridDto);
			    jsonResponse.setsEcho(sEcho);
		        jsonResponse.setiTotalDisplayRecords(documentsDTO.getCount());
		        jsonResponse.setiTotalRecords(documentsDTO.getCount());
		        return jsonResponse;
	            }
	
	
	
	@RequestMapping(value = "/task/taskDocumentSearch.do", method = RequestMethod.GET)
    public String taskDocumentSearch(HttpServletRequest request, ModelMap model){
		DocumentSerach taskDocumentSerach = new DocumentSerach();
		model.addAttribute("taskDocumentSerach", taskDocumentSerach);
		return "task/taskDocumentsSearch";
    }
	
	@RequestMapping(value = "/task/taskDocumentSearchList.do", method = RequestMethod.GET)
    public @ResponseBody
    GridJSONResponse taskDocumentList(HttpServletRequest request,Task task,Party party, Long clientId,
    		String fileName,String clentName, String frmDate, String fileExtension,
    		String to, String docAuthor,String dDate, String dDateTo,Long taskId) {
	// HttpSession session1 = request.getSession();
		 Long firmId = PMUtil.getFirmIdFromSession(request);
		 DocumentsDTO documentsDTO = new DocumentsDTO();
		 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
		 String filename = fileName;
		 String fileNameUpper = null;
		 String fileNameFirstUpper = null;
		 String filenameLower = null;
		 if(taskId != null){
		 if(!filename.isEmpty()){
	     filenameLower = filename.toLowerCase();
		 fileNameUpper = filename.toUpperCase();
		 fileNameFirstUpper = Character.toUpperCase(filename.charAt(0))+filename.substring(1);
		 }
		 String clientName = clentName;
		 String clientNameUpper = null;
		 String clientNameFirstUpper = null;
		 String clientNameLower = null;
		 if(!clientName.isEmpty()){
			 clientNameUpper = clientName.toUpperCase();
			 clientNameLower = clientName.toLowerCase();
			 clientNameFirstUpper = Character.toUpperCase(clientName.charAt(0))+clientName.substring(1);
		 }
		 String date = frmDate;
		 String toDate = to;
		 String dueDate = dDate;
		 String dueDateTo = dDateTo;
		// Long taskId =  (Long) session1.getAttribute("taskId");
		 String author = docAuthor;
		 String authorUpper = null;
		 String authorLower = null;
		 String authorFirstUpper = null;
		 if(!author.isEmpty()){
			 authorUpper = author.toUpperCase();
			 authorLower = author.toLowerCase();
			 authorFirstUpper = Character.toUpperCase(author.charAt(0))+author.substring(1);
		 }
		 if(taskId != null){
			 task = taxModuleManager.getTaskById(taskId);	
			 party = task.getClient();
		     clientId = party.getId();
			 }	
		 String fileExtn = fileExtension;
		 String mimetype = null;
		 String fileExt = null;
		 if(!fileExtn.isEmpty()){
			 fileExt = fileExtn.toLowerCase();
		 mimetype = documentManager.getMimeTypeForFileExtension(fileExt);
		 }
		// if((filename != null)||(clientName != null)||(date != null)||(mimetype != null)|| (toDate != null)||(dueDate != null)||(dueDateTo != null)||(taskId!=null)||(author != null)){
		 if((!filename.isEmpty())||(!clientName.isEmpty())||(!date.isEmpty())||(mimetype != null)|| (!toDate.isEmpty())||(!dueDate.isEmpty())||(!dueDateTo.isEmpty())||(!author.isEmpty())){
		 
		 Session session = documentManager.getCMISSession();
			if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
	                .equals(CapabilityQuery.METADATAONLY)) {			
			}else{
				String query = null;
				if(!filename.isEmpty()){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (d.cmis:name LIKE'%"+filename+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if(!clientName.isEmpty()){
				  query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (w.custom:CompanyName LIKE'%"+clientName+"%' or w.custom:CompanyName LIKE'%"+clientNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if((!date.isEmpty())&& (!toDate.isEmpty())){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:UploadedDate >= TIMESTAMP '"+date+"T00:00:00.000-05:00' and w.custom:UploadedDate <=  TIMESTAMP '"+toDate+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}else if (mimetype != null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where d.cmis:contentStreamMimeType = '"+mimetype+"' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if((!dueDate.isEmpty()) && (!dueDateTo.isEmpty())){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:DueDate >= TIMESTAMP '"+dueDate+"T00:00:00.000-05:00' and w.custom:DueDate <=  TIMESTAMP '"+dueDateTo+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}else if (!author.isEmpty()){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (a.cm:author LIKE'%"+author+"%' or a.cm:author LIKE'%"+authorFirstUpper+"%' or a.cm:author LIKE'%"+authorUpper+"%' or a.cm:author LIKE'%"+authorLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}
				/*else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate == null && dueDateTo == null && author == null ){
				query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
			}*/
				ItemIterable<QueryResult> q = session.query(query, false);
	            int i = 1;
	            for (QueryResult qr : q) {
	            	        String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
		                    documentsDTO.setCount(i);
		                    i++;
			    		   String fName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
			    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
			    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
			    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
			    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
			    		   Date displayDate = crtDate.getTime();
			    		   DocumentsDTO docDTO = new DocumentsDTO();
			    		   docDTO.setDocId(objectId);
			    		   docDTO.setFileName(fName);
			    		   docDTO.setClientName(clntName);
			    		   docDTO.setTitle(title);
			    		   docDTO.setAuthor(autor);
			    		   docDTO.setDisplayDate(displayDate);
			    		   String jspDate = docDTO.getFormattedDate();
			    		   docDTO.setFormattedDate(jspDate);
			    		   gridDto.add(docDTO);
			    
			}
	           }
		 }
		 }
		 String sEcho = request.getParameter("sEcho");
		 GridJSONResponse jsonResponse = prepareResponse(gridDto);
		    jsonResponse.setsEcho(sEcho);
	        jsonResponse.setiTotalDisplayRecords(documentsDTO.getCount());
	        jsonResponse.setiTotalRecords(documentsDTO.getCount());
	        return jsonResponse;

  }
	
	@RequestMapping(value = "/document/download.do", method = RequestMethod.GET)
	public void downloadDocument(String docId, HttpServletResponse response) {
	    try {
	      // get your file as InputStream
	    	Session session = documentManager.getCMISSession();
	    	CmisObject object = session.getObject(session.createObjectId(docId));
	    	Document document = (Document) object;
	      InputStream is = document.getContentStream().getStream();
	      response.setContentType("application/octet-stream");  //This line was added because the files were not getting downloaded correctly in android phone
	      response.setHeader("Content-Disposition", "attachment; filename="+document.getName()); 
	      
	      // copy it to response's OutputStream
	      IOUtils.copy(is, response.getOutputStream());
	     
	      response.flushBuffer();
	    } catch (IOException ex) {
	    	logger.info("Error writing file to output stream. File was '" + docId + "'");
	      throw new RuntimeException("IOError writing file to output stream");
	    }

	}
	
	@RequestMapping(value = "/document/searchDocument.do", method = RequestMethod.GET)
    public String searchDocument(HttpServletRequest request, ModelMap model){
		String fileName = request.getParameter("fn");
		model.addAttribute("fileName", fileName);
		DocumentSerach documentSerach = new DocumentSerach();
		model.addAttribute("documentSerach",documentSerach);		
    	return "searchDocument.tilesView";
    }
	
	@RequestMapping(value = "/document/documentSearchList.do", method = RequestMethod.GET)
    public @ResponseBody
    GridJSONResponse documentSearchList(HttpServletRequest request,String fileName) {
		 Long firmId = PMUtil.getFirmIdFromSession(request);
		 DocumentsDTO documentsDTO = new DocumentsDTO();
		 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
		 String fileNameUpper = null;
		 String fileNameFirstUpper = null;
		 String filenameLower = null;
		 if(fileName!= null){
		     filenameLower = fileName.toLowerCase();
			 fileNameUpper = fileName.toUpperCase();
			 fileNameFirstUpper = Character.toUpperCase(fileName.charAt(0))+fileName.substring(1);
			 
			 Session session = documentManager.getCMISSession();
				if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
		                .equals(CapabilityQuery.METADATAONLY)) {			
				}else{
					String query = documentManager.getDocuments(fileName,filenameLower,fileNameUpper,fileNameFirstUpper,firmId);
					ItemIterable<QueryResult> q = session.query(query, false);
					   int i = 1;
			            for (QueryResult qr : q) {
			            	 String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
			                    Document docu= (Document) session.getObject(objectId);
			                    documentsDTO.setCount(i);
			                    i++;
			                    String fName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
					    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
					    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
					    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
					    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
					    		   Date displayDate = crtDate.getTime();
					    		   DocumentsDTO docDTO = new DocumentsDTO();
					    		   docDTO.setDocId(objectId);
					    		   docDTO.setFileName(fName);
					    		   docDTO.setClientName(clntName);
					    		   docDTO.setTitle(title);
					    		   docDTO.setAuthor(autor);
					    		   docDTO.setDisplayDate(displayDate);
					    		   String jspDate = docDTO.getFormattedDate();
					    		   docDTO.setFormattedDate(jspDate);
					    		   gridDto.add(docDTO);
			            }
				}	
		 }
		 String sEcho = request.getParameter("sEcho");
		 GridJSONResponse jsonResponse = prepareResponse(gridDto);
		    jsonResponse.setsEcho(sEcho);
	        jsonResponse.setiTotalDisplayRecords(documentsDTO.getCount());
	        return jsonResponse;
		
	}
	
	 @RequestMapping(value= "/deleteDocument.do", method= RequestMethod.POST )
		public
		@ResponseBody
		void deleteDocuments(HttpServletRequest request){
		 String docId = request.getParameter("id");
		 if(docId!= null) {
			 Session session = documentManager.getCMISSession();
			 String query = "select d.cmis:objectId,d.cmis:name from cmis:document as d where d.cmis:objectId = '"+docId+"'";
			 ItemIterable<QueryResult> q = session.query(query, false);
	            Document docu = null;
	            for (QueryResult qr : q) {
	            	String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
	            	docu= (Document) session.getObject(objectId);
	            }
	            docu.delete(true);
		 
		 }
			}
	 
	 public static GridJSONResponse prepareResponse( List<DocumentsDTO> gridDto) {
	        GridJSONResponse jsonResponse = new GridJSONResponse();
	        List<Object[]> aaData = new ArrayList();
	        if (gridDto.size() > 0) {
	            for (DocumentsDTO documentsDTO : gridDto) {
	                Object[] objects = new Object[6];
	                objects[0] = documentsDTO.getDocId();
	                objects[1] = documentsDTO.getClientName();
	                objects[2] = documentsDTO.getFileName();
	                objects[3] = documentsDTO.getTitle();
	                objects[4] = documentsDTO.getAuthor();
	                objects[5] = documentsDTO.getFormattedDate();
	                aaData.add(objects);
	            }
	            jsonResponse.setAaData(aaData);
	            //jsonResponse.setiTotalRecords(10);
	        }
	        return jsonResponse;
	    }
	 
	
	
	}
	

