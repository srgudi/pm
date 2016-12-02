package com.chiguru.pm.web.controller.crm;

import com.chiguru.pm.crm.domain.Address;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.CommunicationType;
import com.chiguru.pm.crm.domain.EmailCommunication;
import com.chiguru.pm.crm.domain.FaxCommunication;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.OrganizationType;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.domain.PartyRelationship;
import com.chiguru.pm.crm.domain.PartySite;
import com.chiguru.pm.crm.domain.PartySiteType;
import com.chiguru.pm.crm.domain.PartyType;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.crm.domain.PersonDetails;
import com.chiguru.pm.crm.domain.PersonType;
import com.chiguru.pm.crm.domain.PhoneCommunication;
import com.chiguru.pm.crm.domain.PointOfContact;
import com.chiguru.pm.crm.domain.RelationshipType;
import com.chiguru.pm.crm.domain.WebCommunication;
import com.chiguru.pm.crm.dto.DocumentSerach;
import com.chiguru.pm.crm.dto.KeyValue;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.util.PMConstants;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;
import org.slf4j.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;

import org.springframework.util.AutoPopulatingList;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import  java.io.*;  

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFAnchor;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFPictureData;
import  org.apache.poi.hssf.usermodel.HSSFSheet;  
import  org.apache.poi.hssf.usermodel.HSSFWorkbook; 
import  org.apache.poi.hssf.usermodel.HSSFRow;
import  org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.RichTextString;
import org.hibernate.annotations.Parameter;
import javax.mail.*;
import javax.activation.*;
import javax.mail.internet.*;
import java.util.*;
@Controller
public class TestController {
	
	private HSSFWorkbook hssfWorkbook;
	private HSSFSheet hssfSheet;
	private HSSFRow hssfRowHead;
	private HSSFRow hssfRowCell;
	private int rownum=0;
	boolean isNameAdded = true;
	boolean isFileUploadDone = true;
	final static int FIRSTNAME = 0;
	final static int LASTNAME = 1;
	final static int FILESIZE = 2;
	final static int FILEPATH = 3;
	final static int FILENAME = 4;
	ResourceBundle bundle = ResourceBundle.getBundle("pm");
	private Logger logger = org.slf4j.LoggerFactory.getLogger(TestController.class);
	
	 @RequestMapping(value = "/mobiledev/app/view/uploadFile.do", method = RequestMethod.POST)
	    public ResponseEntity<String> newPage(HttpServletRequest request,MultipartRequest multipartRequest) 
	   throws IOException
	    {
		 Map  map = multipartRequest.getFileMap();
		 MultipartFile mfile = null;
		 for(Iterator iter = map.values().iterator();iter.hasNext();){
			 mfile = (MultipartFile)iter.next();
			 String filename = mfile.getName();
			 System.out.println("original file name="+filename);
			 long size = mfile.getSize();
			 System.out.println("original file size="+size);
		 }
		 
		 String originalFileName = mfile.getOriginalFilename();
		
		 System.out.println("original file name="+mfile.getOriginalFilename());
		
		 String filepath = bundle.getString("FILEPATH") + mfile.getOriginalFilename();
		 File detsination = new File(filepath);
		 mfile.transferTo(detsination);
	  int  fileSize = (int)mfile.getSize();
	      
	      try{
	    	  String fileName= bundle.getString("FILENAME") ;
		    	 if(hssfWorkbook == null && hssfSheet ==null ){
		    		 hssfWorkbook = new HSSFWorkbook();
		    		 hssfSheet = hssfWorkbook.createSheet("data sheet");
		    	 }else{
		    		 FileInputStream fileInputStream = new FileInputStream(fileName);
			    	 POIFSFileSystem fileSystem = new POIFSFileSystem(fileInputStream);
		    	 hssfWorkbook = new HSSFWorkbook(fileSystem);
		    	 hssfSheet = hssfWorkbook.getSheet("data sheet");
		    	
		    	 }
		    	 if(hssfRowHead == null){
			    	  hssfRowHead = hssfSheet.createRow(rownum);
			    	  hssfRowHead.createCell(FIRSTNAME).setCellValue("First Name");
			    	  hssfRowHead.createCell(LASTNAME).setCellValue("Last Name");
			    	  hssfRowHead.createCell(FILESIZE).setCellValue("File Size");
			    	  hssfRowHead.createCell(FILENAME).setCellValue("File Name");
		    		  hssfRowHead.createCell(FILEPATH).setCellValue("File Path");
		    	 }
		    	 if(isNameAdded && isFileUploadDone){
		    		 
		    		 isNameAdded = false;
		    		 rownum++;
		    		 hssfRowCell =  hssfSheet.createRow(rownum);
		    	 }
		    	 else{
		    		 hssfRowCell = hssfSheet.getRow(rownum);
		    	 }
		    	   	 
	    	 
	    	  hssfRowCell.createCell(FILESIZE).setCellValue(fileSize);
	    	 
	    	  hssfRowCell.createCell(FILENAME).setCellValue(originalFileName);
	    	 
	    	  hssfRowCell.createCell(FILEPATH).setCellValue(filepath);
	    	 
	  	FileOutputStream fileOut =  new FileOutputStream(fileName);
	  	hssfWorkbook.write(fileOut);
	    	  fileOut.close();
	    	  System.out.println("Your excel file has been generated!");

	    	  } catch ( Exception ex ) {
	    	      System.out.println(ex);

	    	  }
	    	  isFileUploadDone = true;
				return null;
		 
	 }
	
	
	 @RequestMapping(value = "/mobiledev/app/view/NewPage.do", method = RequestMethod.POST)
	    public ResponseEntity<String> newPage(HttpServletRequest request,String firstName ,String lastName)  throws IOException {
	   
	    	  String fileName=bundle.getString("FILENAME");
	    	 if(hssfWorkbook == null && hssfSheet ==null ){
	    		 hssfWorkbook = new HSSFWorkbook();
	    		 hssfSheet = hssfWorkbook.createSheet("data sheet");
	    	 }else{
	    		 FileInputStream fileInputStream = new FileInputStream(fileName);
		    	 POIFSFileSystem fileSystem = new POIFSFileSystem(fileInputStream);
	    	 hssfWorkbook = new HSSFWorkbook(fileSystem);
	    	 hssfSheet = hssfWorkbook.getSheet("data sheet");
	    	 }
	    	 if(hssfRowHead == null){
		    	  hssfRowHead = hssfSheet.createRow(rownum);
		    	  hssfRowHead.createCell(FIRSTNAME).setCellValue("First Name");
		    	  hssfRowHead.createCell(LASTNAME).setCellValue("Last Name");
		    	  hssfRowHead.createCell(FILESIZE).setCellValue("File Size");
		    	  hssfRowHead.createCell(FILENAME).setCellValue("File Name");
	    		  hssfRowHead.createCell(FILEPATH).setCellValue("File Path");
	    	 }
	    	 if(isNameAdded && isFileUploadDone){
	    		 isFileUploadDone = false;
	    		 rownum++;
	    		 hssfRowCell =  hssfSheet.createRow(rownum);
	    	 }
	    	 else{
	    		 hssfRowCell = hssfSheet.getRow(rownum);
	    	 }
	    	  	    	 
	    	  hssfRowCell.createCell(FIRSTNAME).setCellValue(firstName);
	    	
	    	  hssfRowCell.createCell(LASTNAME).setCellValue(lastName);
	    	  FileOutputStream fileOut =  new FileOutputStream(fileName);
	    	  hssfWorkbook.write(fileOut);
	    	  fileOut.close();
	    	  System.out.println("Your excel file has been generated!");

	    	  isNameAdded = true;
				return null;
		 
	 }
	 
	 @RequestMapping(value = "/mobiledev/app/view/sendmail.do", method = RequestMethod.POST)
	    public ResponseEntity<String> sendmail(HttpServletRequest request)  throws IOException {
		 /*String host = "smtp.gmail.com";
		  String from = "practicem62@gmail.com";
		  String to = "sgudi@tsssoft.com";
		  final String username = "practicem62@gmail.com";
		final String password = "ponderos@";*/
		  // Get system properties
		  Properties properties = new Properties();
		 
		  String host = bundle.getString("MAILHOST");
		  String from = bundle.getString("MAILFROM");
		  String to = bundle.getString("MAILTO");
		  final String username =bundle.getString("USERNAME");
			final String password = bundle.getString("PASSWORD");
		  // Setup mail server
		 properties.put("mail.smtp.auth", "true");
		  properties.put("mail.smtp.starttls.enable", "true");
		  properties.put("mail.smtp.host", host);
		  properties.put("mail.smtp.port", "587");

		  // Get the default Session object.
		  Session session = Session.getInstance(properties, new javax.mail.Authenticator(){
			  protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(username, password);
				  
			  }
		  });

		  // Define message
		  try{
		  Message message = new MimeMessage(session);
		  message.setFrom(new InternetAddress(from));
		  message.addRecipient(Message.RecipientType.TO,
		  new InternetAddress(to));
		  message.setSubject("Sencha Data Mail attachment");

		  // Create the message part 
		  BodyPart messageBodyPart = new MimeBodyPart();

		  // Fill the message
		  messageBodyPart.setText("Hi");

		  Multipart multipart = new MimeMultipart();
		  multipart.addBodyPart(messageBodyPart);

		  // Part two is attachment
		  messageBodyPart = new MimeBodyPart();
		  String filename = bundle.getString("FILENAME");
		  DataSource source = new FileDataSource(filename);
		  messageBodyPart.setDataHandler(new DataHandler(source));
		  messageBodyPart.setFileName(filename);
		  multipart.addBodyPart(messageBodyPart);

		  // Put parts in message
		  message.setContent(multipart);

		  // Send the message
		  Transport.send(message);
		  }catch (MessagingException  e) {
			e.printStackTrace();
		}
		   System.out.println("Msg Send ....") ;
		  
			return null;
		 
	 }
}
















