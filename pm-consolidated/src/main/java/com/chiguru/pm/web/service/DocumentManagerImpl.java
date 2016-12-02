package com.chiguru.pm.web.service;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.chemistry.opencmis.client.api.Session;
import org.apache.chemistry.opencmis.client.api.SessionFactory;
import org.apache.chemistry.opencmis.client.runtime.SessionFactoryImpl;
import org.apache.chemistry.opencmis.commons.SessionParameter;
import org.apache.chemistry.opencmis.commons.enums.BindingType;
import org.springframework.stereotype.Service;

@Service
public class DocumentManagerImpl implements DocumentManager{

	@Override
	public Session getCMISSession() {
		Map<String, String> parameter = new HashMap<String, String>();
		    // Set the user credentials
		    parameter.put(SessionParameter.USER, "admin");
		    parameter.put(SessionParameter.PASSWORD, "admin");
		 
		    // Specify the connection settings
			parameter.put(SessionParameter.ATOMPUB_URL, "http://localhost:8080/alfresco/service/cmis");
	//		parameter.put(SessionParameter.ATOMPUB_URL, "http://localhost:8080/alfresco/cmisatom");
			parameter.put(SessionParameter.BINDING_TYPE, BindingType.ATOMPUB.value());
			
			// Set the alfresco object factory
			parameter.put(SessionParameter.OBJECT_FACTORY_CLASS, "org.alfresco.cmis.client.impl.AlfrescoObjectFactoryImpl");
			
			// Create a session
			SessionFactory factory = SessionFactoryImpl.newInstance();
			Session session = factory.getRepositories(parameter).get(0).createSession();
			return session;
	}
	
	@Override
	public String getMimeTypeForFile(String fileName){
		 String ext= fileName.substring(fileName.lastIndexOf('.')+1,fileName.length());
			//  System.out.println("ext name:::: " +ext);
			String mimetype ="";
			  if(ext.equals("txt"))
				  mimetype = "text/plain"; 
				  else if (ext.equals("xls"))
					  mimetype = "application/vnd.ms-excel";
				  else if (ext.equals("doc"))
					  mimetype = "application/msword";
				  else if (ext.equals("html") || ext.equals("htm"))
					  mimetype = "text/html";
				  else if (ext.equals("jpg") || ext.equals("jpeg"))
					  mimetype = "image/jpeg";
				  else if (ext.equals("bmp"))
					  mimetype = "image/bmp";
				  else if (ext.equals("png"))
					  mimetype = "image/png";
				  else if (ext.equals("pdf"))
					  mimetype = "application/pdf"; 
				  else if (ext.equals("ppt"))
					  mimetype = "application/vnd.ms-powerpoint";
				  else if(ext.equals("xml"))
					  mimetype = "text/xml";
				  else if (ext.equals("zip"))
					  mimetype = "application/vnd.ms-zip";
				  else if (ext.equals("docx"))
					  mimetype = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; 
				  else if (ext.equals("xlsx"))
					  mimetype = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; 
				  else if (ext.equals("pptx"))
					  mimetype = "application/vnd.openxmlformats-officedocument.presentationml.presentation"; 
			  
			return mimetype;
		
	}
	@Override
	public String getMimeTypeForFileExtension(String ext){
		String mimetype ="";
		  if(ext.equals("txt"))
			  mimetype = "text/plain"; 
			  else if (ext.equals("xls"))
				  mimetype = "application/vnd.ms-excel";
			  else if (ext.equals("doc"))
				  mimetype = "application/msword";
			  else if (ext.equals("html") || ext.equals("htm"))
				  mimetype = "text/html";
			  else if (ext.equals("jpg") || ext.equals("jpeg"))
				  mimetype = "image/jpeg";
			  else if (ext.equals("bmp"))
				  mimetype = "image/bmp";
			  else if (ext.equals("png"))
				  mimetype = "image/png";
			  else if (ext.equals("pdf"))
				  mimetype = "application/pdf"; 
			  else if (ext.equals("ppt"))
				  mimetype = "application/vnd.ms-powerpoint";
			  else if(ext.equals("xml"))
				  mimetype = "text/xml";
			  else if (ext.equals("zip"))
				  mimetype = "application/vnd.ms-zip";
			  else if (ext.equals("docx"))
				  mimetype = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; 
			  else if (ext.equals("xlsx"))
				  mimetype = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; 
			  else if (ext.equals("pptx"))
				  mimetype = "application/vnd.openxmlformats-officedocument.presentationml.presentation"; 
		  
		return mimetype;
		
	}

	public String getDocuments(String fileName,String filenameLower,String fileNameUpper,String fileNameFirstUpper,Long firmId){
	/*	String query ="select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d"+
		" join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId"+
		" join cm:titled as s on d.cmis:objectId = s.cmis:objectId"+
		" join cm:author as a on d.cmis:objectId = a.cmis:objectId"+
		" where (d.cmis:name LIKE'%"+fileName+"%' or d.cmis:name LIKE'%"+fileNameFirstUpper+"%' or d.cmis:name LIKE'%"+fileNameUpper+"%' or d.cmis:name LIKE'%"+filenameLower+"%' or"+
		" w.custom:CompanyName LIKE'%"+fileName+"%' or w.custom:CompanyName LIKE'%"+fileNameFirstUpper+"%' or w.custom:CompanyName LIKE'%"+fileNameUpper+"%' or w.custom:CompanyName LIKE'%"+filenameLower+"%' or"+
		" a.cm:author LIKE'%"+fileName+"%' or a.cm:author LIKE'%"+fileNameFirstUpper+"%' or a.cm:author LIKE'%"+fileNameUpper+"%' or a.cm:author LIKE'%"+filenameLower+"%') and w.custom:FirmId = '"+firmId+"'";
         return query;*/
		/*String query ="select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d"+
		" join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId"+
		" join cm:titled as s on d.cmis:objectId = s.cmis:objectId"+
		" join cm:author as a on d.cmis:objectId = a.cmis:objectId"+
		" where (d.cmis:name LIKE'%"+fileName+"%' or w.custom:CompanyName LIKE'%"+fileName+"%') and w.custom:FirmId = '"+firmId+"'";*/
		
		String query = " select d.cmis:objectId,d.cmis:name,w.custom:CompanyName,s.cm:title,a.cm:author,d.cmis:creationDate from cmis:document as d"+
		" join custom:ProductDetails as w on d.cmis:objectId = w.cmis:objectId"+
		" join cm:titled as s on d.cmis:objectId = s.cmis:objectId"+
		" join cm:author as a on d.cmis:objectId = a.cmis:objectId"+
		" where (d.cmis:name LIKE '%"+fileName+"%' or d.cmis:name LIKE '%"+filenameLower+"%' or d.cmis:name LIKE '%"+fileNameUpper+"%' or d.cmis:name LIKE '%"+fileNameFirstUpper+"%'"+  
		    " or w.custom:CompanyName LIKE '%"+fileName+"%' or w.custom:CompanyName LIKE '%"+filenameLower+"%' or w.custom:CompanyName LIKE '%"+fileNameUpper+"%' or w.custom:CompanyName LIKE '%"+fileNameFirstUpper+"%'"+
		    " or s.cm:title LIKE '%"+fileName+"%' or s.cm:title LIKE '%"+filenameLower+"%' or s.cm:title LIKE '%"+fileNameUpper+"%' or s.cm:title LIKE '%"+fileNameFirstUpper+"%'"+
		    " or a.cm:author LIKE '%"+fileName+"%' or a.cm:author LIKE '%"+filenameLower+"%' or a.cm:author LIKE '%"+fileNameUpper+"%' or a.cm:author LIKE '%"+fileNameFirstUpper+"%') and  w.custom:FirmId = '"+firmId+"'";
		   return query;
	}
}
