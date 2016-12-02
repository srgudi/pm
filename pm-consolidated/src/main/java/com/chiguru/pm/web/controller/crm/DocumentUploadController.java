package com.chiguru.pm.web.controller.crm;

import java.util.ResourceBundle;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import org.apache.chemistry.opencmis.client.api.CmisObject;
import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.chemistry.opencmis.client.api.Folder;
import org.apache.chemistry.opencmis.client.api.ItemIterable;
import org.apache.chemistry.opencmis.client.api.Session;
import org.apache.chemistry.opencmis.client.api.SessionFactory;
import org.apache.chemistry.opencmis.client.runtime.SessionFactoryImpl;
import org.apache.chemistry.opencmis.commons.PropertyIds;
import org.apache.chemistry.opencmis.commons.SessionParameter;
import org.apache.chemistry.opencmis.commons.data.ContentStream;
import org.apache.chemistry.opencmis.commons.enums.BindingType;
import org.apache.chemistry.opencmis.commons.enums.VersioningState;
import org.apache.chemistry.opencmis.commons.impl.dataobjects.ContentStreamImpl;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.DocumentSerach;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.service.TaxModuleManager;
import com.chiguru.pm.web.service.DocumentManager;
import com.chiguru.pm.web.util.PMUtil;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class DocumentUploadController {

	private Logger logger = org.slf4j.LoggerFactory.getLogger(DocumentUploadController.class);
	  @Autowired
	    protected CRMManager crmManager;
	  @Autowired
	    protected TaxModuleManager taxModuleManager;
	  @Autowired
	  protected DocumentManager documentManager;
	  


@RequestMapping(value = "/client/clientDocuments.do", method = RequestMethod.GET)
public String newCustomer(HttpServletRequest request, ModelMap model){
	DocumentSerach documents = new DocumentSerach();
	model.addAttribute("documents", documents);
	 PMUtil.showStatusMessage(request, model);
	return "client/clientDocuments";
}

@RequestMapping(value = "/client/clientDocuments.do", method = RequestMethod.POST)
public ResponseEntity<String> saveDocument(HttpServletRequest request, Party party,DocumentSerach documents,
    BindingResult result, SessionStatus status, ModelMap model,
    Long clientId) throws Exception{
	HttpHeaders responseHeaders = new HttpHeaders();
	 responseHeaders.setContentType(MediaType.TEXT_HTML);
	 StringBuffer responseText = new StringBuffer("{\"id\":");
	Long firmId = PMUtil.getFirmIdFromSession(request);
	 Timestamp ts = new Timestamp(System.currentTimeMillis());	 
	 String id = null;
	 if (clientId != null) {
           party = crmManager.getPartyById(clientId);
       id = clientId.toString();  
}
	 MultipartFile fileData = documents.getFile(); 
	 String companyName = party.getName();
	 String path = documents.getFileName();
	 String title = documents.getTitle();
	 String description = documents.getDescription();
	 String author = documents.getAuthor();
	 try{
	 Session session = documentManager.getCMISSession();
		String fileName = fileData.getOriginalFilename();
			  
	    String mimetype = documentManager.getMimeTypeForFile(fileName);
	
			Folder newFolder = createNewFolder(session, id, companyName);
				 ItemIterable<CmisObject> children  = newFolder.getChildren();
				 for (CmisObject o : children) {
			            if(o.getName().equalsIgnoreCase(fileName)){
			            	String fileNameWithOutExt = FilenameUtils.removeExtension(fileName);
			            	fileName = fileNameWithOutExt+"-"+ts.getDate()+"-"+ts.getHours()+"-"+ts.getMinutes()+"-"+ts.getSeconds()+
			            	"."+fileName.substring(fileName.lastIndexOf('.')+1,fileName.length());
			            }
			        }
			
			
			
			Map<String, Object> properties = setPropertiesForDocument(fileName,title,description,author,companyName,clientId,firmId);
			

			 ContentStream contentStream = new ContentStreamImpl(fileName, null, mimetype,
			    	  fileData.getInputStream());
			 
			Document doc = newFolder.createDocument(properties, contentStream,
			    	  VersioningState.MINOR, null, null, null, session.getDefaultContext());
		        responseText.append("\""+doc.getId()+"\"}");
			 	  logger.info("SAVED ******");
				 }catch (Exception e) {
					 logger.error("Exception occurred during Document Upload"+ e);
				   	 responseText.append("\"-1\"}");
				}
			  return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
}

private Map<String, Object> setPropertiesForDocument(String fileName, String title, String description, String author, String companyName, Long clientId,Long firmId) {
	 Map<String, Object> properties = new HashMap<String, Object>();
		properties.put(PropertyIds.NAME, fileName);
		properties.put(PropertyIds.OBJECT_TYPE_ID, "cmis:document,P:custom:ProductDetails,P:cm:titled,P:cm:author");
		properties.put("cm:title", title);
		properties.put("cm:description", description);
		properties.put("cm:author", author);
		properties.put("custom:ClientId", clientId);
		properties.put("custom:FirmId", firmId);
		properties.put("custom:CompanyName", companyName);
		properties.put("custom:TaskId", "0");
		Date date = new Date();
		GregorianCalendar cal = new GregorianCalendar();
		 cal.setTime(date);
		 properties.put("custom:UploadedDate", cal);
	return properties;
}

private Folder createNewFolder(Session session, String id, String companyName) {
	 Folder root = session.getRootFolder();
	 Folder newFolder = null;
	 CmisObject folderObj = null;
	 for(CmisObject children : root.getChildren()){
  //     	 System.out.println(children.getName() + " which is of type " + children.getType().getDisplayName());
        if((children.getType().getDisplayName().equalsIgnoreCase("Folder")) && (children.getName().equalsIgnoreCase(id))){
       		folderObj = children;
       		newFolder = (Folder) folderObj;
        }  
        }
       if(newFolder == null){
       	Map<String, String> newFolderProps = new HashMap<String, String>();
           newFolderProps.put(PropertyIds.OBJECT_TYPE_ID, "cmis:folder,P:cm:titled");
           newFolderProps.put(PropertyIds.NAME, id);
           newFolderProps.put("cm:description", companyName);
           newFolder = root.createFolder(newFolderProps);
       }
	return newFolder;
}


@RequestMapping(value = "/task/taskDocuments.do", method = RequestMethod.GET)
public String taskDocument(HttpServletRequest request, ModelMap model, Long taskId,Task task,String taskStatus){
	DocumentSerach taskDocuments = new DocumentSerach();
	 HttpSession session = request.getSession();
	taskId = (Long) session.getAttribute("taskId");
	 if(taskId != null){
		  task = taxModuleManager.getTaskById(taskId);
		  taskStatus =  task.getStatus().getStatusName();
	}
	model.addAttribute("taskDocuments", taskDocuments);
	model.addAttribute("taskStatus", taskStatus);
	PMUtil.showStatusMessage(request, model);
	return "task/taskDocumentsUpload";
}

@RequestMapping(value = "/task/taskDocuments.do", method = RequestMethod.POST)
public ResponseEntity<String>  saveDocument(HttpServletRequest request, Party party,DocumentSerach taskDocuments ,
    BindingResult result, SessionStatus status, ModelMap model,Long taskId,
    Long clientId, Task task) throws Exception  {
	 HttpSession session1 = request.getSession();
	HttpHeaders responseHeaders = new HttpHeaders();
	 responseHeaders.setContentType(MediaType.TEXT_HTML);
	 StringBuffer responseText = new StringBuffer("{\"id\":");
  Long firmId = PMUtil.getFirmIdFromSession(request);
  String id = null;
 Timestamp ts = new Timestamp(System.currentTimeMillis());
   // taskId = (Long) session1.getAttribute("taskId");
 if(taskId != null){
	  task = taxModuleManager.getTaskById(taskId);
}
 MultipartFile fileData = taskDocuments.getFile(); 
party = task.getClient();
id = party.getId().toString();
String companyName = party.getName();

String path = taskDocuments.getFileName();
String title = taskDocuments.getTitle();
String description = taskDocuments.getDescription();
String author = taskDocuments.getAuthor();
try{
       Session session = documentManager.getCMISSession();
	
		String  fileName = fileData.getOriginalFilename();
		 String mimetype = documentManager.getMimeTypeForFile(fileName);
	
		
		Folder newFolder = createNewFolder(session, id, companyName);
		 ItemIterable<CmisObject> children  = newFolder.getChildren();
		 for (CmisObject o : children) {
	            if(o.getName().equalsIgnoreCase(fileName)){
	            	String fileNameWithOutExt = FilenameUtils.removeExtension(fileName);
	            	fileName = fileNameWithOutExt+"-"+ts.getDate()+"-"+ts.getHours()+"-"+ts.getMinutes()+"-"+ts.getSeconds()+
	            	"."+fileName.substring(fileName.lastIndexOf('.')+1,fileName.length());
	            }
	        }
		
		Map<String, Object> properties = setPropertiesForDocument(fileName,title,description,author,companyName,task,party,firmId);
		 ContentStream contentStream = new ContentStreamImpl(fileName, null, mimetype,
				 fileData.getInputStream());
		 
		Document doc = newFolder.createDocument(properties, contentStream,
		    	  VersioningState.MINOR, null, null, null, session.getDefaultContext());
		         responseText.append("\""+doc.getId()+"\"}");
}
catch (Exception e) {
	 logger.error("Exception occurred during Document Upload"+ e);
  	 responseText.append("\"-1\"}");
}
return new ResponseEntity<String>(responseText.toString(),responseHeaders, HttpStatus.OK); 
}

private Map<String, Object> setPropertiesForDocument(String fileName, String title, String description, String author, String companyName, Task task,
		  Party party, Long firmId) {
		 Map<String, Object> properties = new HashMap<String, Object>();
			properties.put(PropertyIds.NAME, fileName);
			properties.put(PropertyIds.OBJECT_TYPE_ID, "cmis:document,P:custom:ProductDetails,P:cm:titled,P:cm:author");
			properties.put("cm:title", title);
			properties.put("cm:description", description);
			properties.put("cm:author", author);
			properties.put("custom:ClientId", party.getId());
			properties.put("custom:TaskId", task.getId());
			properties.put("custom:FirmId", firmId);
			properties.put("custom:CompanyName", companyName);
			
			Date date = task.getDueDate();
			 GregorianCalendar cal = new GregorianCalendar();
			 cal.setTime(date);
			 properties.put("custom:DueDate",cal);
			 Date upd = new Date();
			 GregorianCalendar gc= new GregorianCalendar();
			 gc.setTime(upd);
			 properties.put("custom:UploadedDate", gc);
			return properties;
	}
}