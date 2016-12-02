package com.chiguru.pm.web.controller.crm;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	    	return "clientDocumentsSearch.tilesView";
	    }
	
	 
	@RequestMapping(value = "/client/clientDocumentSearchList.do", method = RequestMethod.GET)
	    public @ResponseBody
	    Map clientDocumentList(HttpServletRequest request,ModelMap model,Long clientId) {
		       Map retMap = new HashMap();
		       Long firmId = PMUtil.getFirmIdFromSession(request);
		       Long taskId = (long) 0;
			 Page page = PMUtil.populatePageObject(request);
			 DocumentsDTO documentsDTO = new DocumentsDTO();
			 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
			 DocumentSerach documentSearch = GridUtil.prepareDocumentSearch(page.getFilters());
			 String link = null;
			 clientId = documentSearch.getClientId();
			 String filename = documentSearch.getFileName();
			 String fileNameUpper = null;
			 String fileNameFirstUpper = null;
			 String filenameLower = null;
			 if(filename!= null){
		     filenameLower = filename.toLowerCase();
			 fileNameUpper = filename.toUpperCase();
			 fileNameFirstUpper = Character.toUpperCase(filename.charAt(0))+filename.substring(1);
			 }
			 String clientName = documentSearch.getClientName();
			 String clientNameUpper = null;
			 String clientNameFirstUpper = null;
			 String clientNameLower = null;
			 if(clientName!= null){
				 clientNameUpper = clientName.toUpperCase();
				 clientNameLower = clientName.toLowerCase();
				 clientNameFirstUpper = Character.toUpperCase(clientName.charAt(0))+clientName.substring(1);
			 }
			 String date = documentSearch.getDate();
			 String toDate = documentSearch.getTo();
			 String fileExtn = documentSearch.getFileExtension();
			 String fileExt  = null;
			 String author = documentSearch.getAuthor();
			 String authorUpper = null;
			 String authorLower = null;
			 String authorFirstUpper = null;
			 if(author!= null){
				 authorUpper = author.toUpperCase();
				 authorLower = author.toLowerCase();
				 authorFirstUpper = Character.toUpperCase(author.charAt(0))+author.substring(1);
			 }
			 String mimetype = null;
			 if(fileExtn != null){
				fileExt = fileExtn.toLowerCase();
			 mimetype = documentManager.getMimeTypeForFileExtension(fileExt);
			 }
			 if((filename != null)||(clientName != null)||(date != null)||(mimetype != null)|| (toDate != null) || (clientId != null) || (author != null)){
				 Session session = documentManager.getCMISSession();
				if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
		                .equals(CapabilityQuery.METADATAONLY)) {				
				}else{
					String query = null;
					if(filename != null && clientName == null && date == null && mimetype == null && toDate == null && author == null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (d.cmis:name LIKE'%"+filename+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if(filename == null && clientName != null && date == null && mimetype == null && toDate == null && author == null){
					  query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (w.custom:CompanyName LIKE'%"+clientName+"%' or w.custom:CompanyName LIKE'%"+clientNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if(filename == null && clientName == null && date != null && mimetype == null &&  toDate != null && author == null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:UploadedDate >= TIMESTAMP '"+date+"T00:00:00.000-05:00' and w.custom:UploadedDate <=  TIMESTAMP '"+toDate+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
					}else if (filename == null && clientName == null && date == null && mimetype != null &&  toDate == null && author == null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where d.cmis:contentStreamMimeType = '"+mimetype+"' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && author == null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
					}else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && author != null){
						query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (a.cm:author LIKE'%"+author+"%' or a.cm:author LIKE'%"+authorFirstUpper+"%' or a.cm:author LIKE'%"+authorUpper+"%' or a.cm:author LIKE'%"+authorLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
					}
					ItemIterable<QueryResult> q = session.query(query, false);
		            int i = 1;
		            for (QueryResult qr : q) {
		            	        String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
			                    Document docu= (Document) session.getObject(objectId);
			                    documentsDTO.setCount(i);
			                    i++;
				    		    try {
				    		        java.lang.reflect.Method loadLink = AbstractAtomPubService.class.getDeclaredMethod("loadLink", 
				    		            new Class[] { String.class, String.class, String.class, String.class });
				    		        
				    		        loadLink.setAccessible(true);
				    		        
				    		        link = (String) loadLink.invoke(session.getBinding().getObjectService(), session.getRepositoryInfo().getId(),
				    		            docu.getId(), AtomPubParser.LINK_REL_CONTENT, null);
				    		    } catch (Exception e) {
				    		       e.printStackTrace();
				    		    }
				    		    
				    		   String fileName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
				    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
				    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
				    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
				    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
				    		   Date displayDate = crtDate.getTime();
				    		   DocumentsDTO docDTO = new DocumentsDTO();
				    		   docDTO.setDocId(objectId);
				    		   docDTO.setFileName(fileName);
				    		   docDTO.setClientName(clntName);
				    		   docDTO.setTitle(title);
				    		   docDTO.setAuthor(autor);
				    		   docDTO.setLink(link);
				    		   docDTO.setDisplayDate(displayDate);
				    		   String jspDate = docDTO.getFormattedDate();
				    		   docDTO.setFormattedDate(jspDate);
				    		   gridDto.add(docDTO);
				    
				}
		           
				}
			 }
		
			 populateReturnMapWithPageDatails(retMap, gridDto, page); 
				return retMap;
	
	  }
	
	private void populateReturnMapWithPageDatails(Map retMap,
			List entityList, Page page) {
         retMap.put("rows", entityList);
		
		if (page != null) {
		retMap.put("page", page.getCurrentPage());
		retMap.put("total", page.getTotalPages());
		retMap.put("records", page.getCount());
		
	}
	}


	private void adjustPagination(Page page, int count) {
		// set total pages to 0 by default
		page.setCount(count);
		int totalPages = 0;
		if (count > 0) {
			if(count % 10 == 0){
				totalPages = (int) Math.ceil(count / page.getLimit());
			}else{
				totalPages = (int) Math.ceil(count / page.getLimit()) + 1;
			}
			page.setTotalPages(totalPages);

			if (page.getCurrentPage() > totalPages) {
				page.setCurrentPage(totalPages);
			}
			int start = (page.getLimit() * page.getCurrentPage())
					- page.getLimit();
			page.setStart(start);

			if (start + page.getLimit() > count) {
				page.setLimit(count - start);
			}
		}

	}
	
	@RequestMapping(value = "/task/taskDocumentSearch.do", method = RequestMethod.GET)
    public String taskDocumentSearch(HttpServletRequest request, ModelMap model){
		DocumentSerach taskDocumentSerach = new DocumentSerach();
		model.addAttribute("taskDocumentSerach", taskDocumentSerach);
    	return "taskDocumentSearch.tilesView";
    }
	
	@RequestMapping(value = "/task/taskDocumentSearchList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map taskDocumentList(HttpServletRequest request,ModelMap model,Task task,Party party, Long clientId ) {
	       Map retMap = new HashMap();
		 Page page = PMUtil.populatePageObject(request);
		 Long firmId = PMUtil.getFirmIdFromSession(request);
		 DocumentsDTO documentsDTO = new DocumentsDTO();
		 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
		 DocumentSerach documentSearch = GridUtil.prepareDocumentSearch(page.getFilters());
		 String link = null;
		 String filename = documentSearch.getFileName();
		 String fileNameUpper = null;
		 String fileNameFirstUpper = null;
		 String filenameLower = null;
		 if(filename!= null){
	     filenameLower = filename.toLowerCase();
		 fileNameUpper = filename.toUpperCase();
		 fileNameFirstUpper = Character.toUpperCase(filename.charAt(0))+filename.substring(1);
		 }
		 String clientName = documentSearch.getClientName();
		 String clientNameUpper = null;
		 String clientNameFirstUpper = null;
		 String clientNameLower = null;
		 if(clientName!= null){
			 clientNameUpper = clientName.toUpperCase();
			 clientNameLower = clientName.toLowerCase();
			 clientNameFirstUpper = Character.toUpperCase(clientName.charAt(0))+clientName.substring(1);
		 }
		 String date = documentSearch.getDate();
		 String toDate = documentSearch.getTo();
		 String dueDate = documentSearch.getDueDate();
		 String dueDateTo = documentSearch.getDueDateTo();
		 Long taskId = documentSearch.getTaskId();
		 String author = documentSearch.getAuthor();
		 String authorUpper = null;
		 String authorLower = null;
		 String authorFirstUpper = null;
		 if(author!= null){
			 authorUpper = author.toUpperCase();
			 authorLower = author.toLowerCase();
			 authorFirstUpper = Character.toUpperCase(author.charAt(0))+author.substring(1);
		 }
		 if(taskId != null){
			 task = taxModuleManager.getTaskById(taskId);	
			 party = task.getClient();
		     clientId = party.getId();
			 }	
		 String fileExtn = documentSearch.getFileExtension();
		 String mimetype = null;
		 String fileExt = null;
		 if(fileExtn != null){
			 fileExt = fileExtn.toLowerCase();
		 mimetype = documentManager.getMimeTypeForFileExtension(fileExt);
		 }
		 if((filename != null)||(clientName != null)||(date != null)||(mimetype != null)|| (toDate != null)||(dueDate != null)||(dueDateTo != null)||(taskId!=null)||(author != null)){
		Session session = documentManager.getCMISSession();
			if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
	                .equals(CapabilityQuery.METADATAONLY)) {			
			}else{
				String query = null;
				if(filename != null && clientName == null && date == null && mimetype == null && toDate == null && dueDate == null && dueDateTo == null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (d.cmis:name LIKE'%"+filename+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if(filename == null && clientName != null && date == null && mimetype == null && toDate == null && dueDate == null && dueDateTo == null && author == null){
				  query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (w.custom:CompanyName LIKE'%"+clientName+"%' or w.custom:CompanyName LIKE'%"+clientNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if(filename == null && clientName == null && date != null && mimetype == null &&  toDate != null && dueDate == null && dueDateTo == null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:UploadedDate >= TIMESTAMP '"+date+"T00:00:00.000-05:00' and w.custom:UploadedDate <=  TIMESTAMP '"+toDate+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}else if (filename == null && clientName == null && date == null && mimetype != null &&  toDate == null && dueDate == null && dueDateTo == null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where d.cmis:contentStreamMimeType = '"+mimetype+"' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if(filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate != null && dueDateTo != null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:DueDate >= TIMESTAMP '"+dueDate+"T00:00:00.000-05:00' and w.custom:DueDate <=  TIMESTAMP '"+dueDateTo+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate == null && dueDateTo == null && author == null ){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";
				}else if (filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate == null && dueDateTo == null && author != null ){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (a.cm:author LIKE'%"+author+"%' or a.cm:author LIKE'%"+authorFirstUpper+"%' or a.cm:author LIKE'%"+authorUpper+"%' or a.cm:author LIKE'%"+authorLower+"%') and w.custom:FirmId = '"+firmId+"' and w.custom:TaskId = '"+taskId+"' and w.custom:ClientId = '"+clientId+"'";	
				}
				ItemIterable<QueryResult> q = session.query(query, false);
	            int i = 1;
	            for (QueryResult qr : q) {
	            	
	            	        String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
		                    Document docu= (Document) session.getObject(objectId);
		                    documentsDTO.setCount(i);
		                    i++;
		               //     String link = null;
			    		    try {
			    		        java.lang.reflect.Method loadLink = AbstractAtomPubService.class.getDeclaredMethod("loadLink", 
			    		            new Class[] { String.class, String.class, String.class, String.class });
			    		        
			    		        loadLink.setAccessible(true);
			    		        
			    		        link = (String) loadLink.invoke(session.getBinding().getObjectService(), session.getRepositoryInfo().getId(),
			    		            docu.getId(), AtomPubParser.LINK_REL_CONTENT, null);
			    		    } catch (Exception e) {
			    		       e.printStackTrace();
			    		    }
			    		    
			    		   String fileName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
			    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
			    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
			    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
			    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
			    		   Date displayDate = crtDate.getTime();
			    		   DocumentsDTO docDTO = new DocumentsDTO();
			    		   docDTO.setDocId(objectId);
			    		   docDTO.setFileName(fileName);
			    		   docDTO.setClientName(clntName);
			    		   docDTO.setTitle(title);
			    		   docDTO.setAuthor(autor);
			    		   docDTO.setLink(link);
			    		   docDTO.setDisplayDate(displayDate);
			    		   String jspDate = docDTO.getFormattedDate();
			    		   docDTO.setFormattedDate(jspDate);
			    		   gridDto.add(docDTO);
			    
			}
	           }
		 }
		 populateReturnMapWithPageDatails(retMap, gridDto, page); 
			return retMap;

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
		DocumentSerach searchDocument = new DocumentSerach();
		model.addAttribute("searchDocument", searchDocument);
    	return "searchDocument.tilesView";
    }
	
	@RequestMapping(value = "/document/documentSearchList.do", method = RequestMethod.GET)
    public @ResponseBody
    Map documentSearchList(HttpServletRequest request,ModelMap model) {
		 Map retMap = new HashMap();
		 Page page = PMUtil.populatePageObject(request);
		 Long firmId = PMUtil.getFirmIdFromSession(request);
		 DocumentsDTO documentsDTO = new DocumentsDTO();
		 List<DocumentsDTO> gridDto = new ArrayList<DocumentsDTO>();
		 DocumentSerach documentSearch = GridUtil.prepareDocumentSearch(page.getFilters());
		 String link = null;
		 String filename = documentSearch.getFileName();
		 String fileNameUpper = null;
		 String fileNameFirstUpper = null;
		 String filenameLower = null;
		 if(filename!= null){
	     filenameLower = filename.toLowerCase();
		 fileNameUpper = filename.toUpperCase();
		 fileNameFirstUpper = Character.toUpperCase(filename.charAt(0))+filename.substring(1);
		 }
		 String clientName = documentSearch.getClientName();
		 String clientNameUpper = null;
		 String clientNameFirstUpper = null;
		 String clientNameLower = null;
		 if(clientName!= null){
			 clientNameUpper = clientName.toUpperCase();
			 clientNameLower = clientName.toLowerCase();
			 clientNameFirstUpper = Character.toUpperCase(clientName.charAt(0))+clientName.substring(1);
		 }
		 String date = documentSearch.getDate();
		 String toDate = documentSearch.getTo();
		 String dueDate = documentSearch.getDueDate();
		 String dueDateTo = documentSearch.getDueDateTo();
		 String fileExtn = documentSearch.getFileExtension();
		 String author = documentSearch.getAuthor();
		 String authorUpper = null;
		 String authorLower = null;
		 String authorFirstUpper = null;
		 if(author!= null){
			 authorUpper = author.toUpperCase();
			 authorLower = author.toLowerCase();
			 authorFirstUpper = Character.toUpperCase(author.charAt(0))+author.substring(1);
		 }
		 String mimetype = null;
		 String fileExt = null;
		 if(fileExtn != null){
			 fileExt = fileExtn.toLowerCase();
		 mimetype = documentManager.getMimeTypeForFileExtension(fileExt);
		 }
		 if((filename != null)||(clientName != null)||(date != null)||(mimetype != null)|| (toDate != null)||(dueDate != null)||(dueDateTo != null)||(author != null)){
		Session session = documentManager.getCMISSession();
			if (session.getRepositoryInfo().getCapabilities().getQueryCapability()
	                .equals(CapabilityQuery.METADATAONLY)) {			
			}else{
				String query = null;
				if(filename != null && clientName == null && date == null && mimetype == null && toDate == null && dueDate == null && dueDateTo == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (d.cmis:name LIKE'%"+filename+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"'";
				}else if(filename == null && clientName != null && date == null && mimetype == null && toDate == null && dueDate == null && dueDateTo == null){
				  query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (w.custom:CompanyName LIKE'%"+clientName+"%' or w.custom:CompanyName LIKE'%"+clientNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameUpper+"%' or w.custom:CompanyName LIKE'%"+clientNameLower+"%') and w.custom:FirmId = '"+firmId+"'";
				}else if(filename == null && clientName == null && date != null && mimetype == null &&  toDate != null && dueDate == null && dueDateTo == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:UploadedDate >= TIMESTAMP '"+date+"T00:00:00.000-05:00' and w.custom:UploadedDate <=  TIMESTAMP '"+toDate+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"'";	
				}else if (filename == null && clientName == null && date == null && mimetype != null &&  toDate == null && dueDate == null && dueDateTo == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where d.cmis:contentStreamMimeType = '"+mimetype+"' and w.custom:FirmId = '"+firmId+"'";
				}else if(filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate != null && dueDateTo != null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:DueDate >= TIMESTAMP '"+dueDate+"T00:00:00.000-05:00' and w.custom:DueDate <=  TIMESTAMP '"+dueDateTo+"T00:00:00.000-05:00' and w.custom:FirmId = '"+firmId+"'";	
				}else if(filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate == null && dueDateTo == null && author != null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where (a.cm:author LIKE'%"+author+"%' or a.cm:author LIKE'%"+authorFirstUpper+"%' or a.cm:author LIKE'%"+authorUpper+"%' or a.cm:author LIKE'%"+authorLower+"%') and w.custom:FirmId = '"+firmId+"'";	
				}/*else if(filename == null && clientName == null && date == null && mimetype == null &&  toDate == null && dueDate == null && dueDateTo == null && author == null){
					query = "select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId join cm:titled as s on d.cmis:objectId = s.cmis:objectId join cm:author as a on d.cmis:objectId = a.cmis:objectId where w.custom:FirmId = '"+firmId+"'";	
				}*/
				ItemIterable<QueryResult> q = session.query(query, false);
	            int i = 1;
	            for (QueryResult qr : q) {
	            	
	            	        String objectId = qr.getPropertyValueByQueryName("d.cmis:objectId").toString();
		                    Document docu= (Document) session.getObject(objectId);
		                    documentsDTO.setCount(i);
		                    i++;
		               //     String link = null;
			    		    try {
			    		        java.lang.reflect.Method loadLink = AbstractAtomPubService.class.getDeclaredMethod("loadLink", 
			    		            new Class[] { String.class, String.class, String.class, String.class });
			    		        
			    		        loadLink.setAccessible(true);
			    		        
			    		        link = (String) loadLink.invoke(session.getBinding().getObjectService(), session.getRepositoryInfo().getId(),
			    		            docu.getId(), AtomPubParser.LINK_REL_CONTENT, null);
			    		    } catch (Exception e) {
			    		       e.printStackTrace();
			    		    }
			    		    
			    		   String fileName = (String) qr.getPropertyByQueryName("d.cmis:name").getFirstValue();
			    		   String clntName = qr.getPropertyByQueryName("w.custom:CompanyName").getFirstValue().toString();
			    		   String title = (String) qr.getPropertyByQueryName("s.cm:title").getFirstValue();
			    		   String autor = (String)qr.getPropertyByQueryName("a.cm:author").getFirstValue();
			    		   GregorianCalendar crtDate = (GregorianCalendar) qr.getPropertyByQueryName("d.cmis:creationDate").getFirstValue();
			    		   Date displayDate = crtDate.getTime();
			    		   DocumentsDTO docDTO = new DocumentsDTO();
			    		   docDTO.setDocId(objectId);
			    		   docDTO.setFileName(fileName);
			    		   docDTO.setClientName(clntName);
			    		   docDTO.setTitle(title);
			    		   docDTO.setAuthor(autor);
			    		   docDTO.setLink(link);
			    		   docDTO.setDisplayDate(displayDate);
			    		   String jspDate = docDTO.getFormattedDate();
			    		   docDTO.setFormattedDate(jspDate);
			    		   gridDto.add(docDTO);
			    
			}
	           }
		 }
		 populateReturnMapWithPageDatails(retMap, gridDto, page); 
			return retMap;
		
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
	 
	
	
	}
	

