package com.chiguru.pm.core.common.utilities;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import org.springframework.mail.MailException;
import org.springframework.mail.MailParseException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import org.springframework.stereotype.Service;


/**
 * <p>Email Service to send simple email messages and alerts upon failure </p>
 * @author ORANGUTAN
 *
 */
@Service("mailService")
public class EmailService {
   @Autowired
    private MailSender mailSender;
   @Autowired
    private SimpleMailMessage alertMailMessage;
   @Autowired
    private JavaMailSender newMailSender;
   
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
    
    private Logger logger = org.slf4j.LoggerFactory.getLogger(EmailService.class);
    
   // private SimpleMailMessage templateMessage;
	/*public EmailService(MailSender mailSender, SimpleMailMessage templateMessage) {
		super();
		this.mailSender = mailSender;
		this.templateMessage = templateMessage;
	}
*/
   
    public void sendMail(String from, String to, StringBuffer cc, String bCc,
        String subject, String body) {
    	String[] tokenizedTo =  getStringTokenizer(to);
    	String[] tokenizedCC =  getStringTokenizer(cc.toString());
    	String[] tokenizedBcc =  getStringTokenizer(bCc);
    	
    	/*logger.info("About to send email");
    	logger.info("from: "+ from);
    	logger.info("to: "+ tokenizedTo);
    	logger.info("cc: "+ tokenizedCC);
    	logger.info("tokenizedBcc: "+ tokenizedBcc);
    	logger.info("subject: "+ subject);
    	logger.info("body: "+ body);
    	
    	String host = "smtp.gmail.com";
        String pass = "ponderos@";
    	Properties props = System.getProperties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", from);
        props.put("mail.smtp.password", pass);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");*/

        //Session session = Session.getDefaultInstance(props, null);
    	
        SimpleMailMessage message = new SimpleMailMessage();
        	message.setFrom(from);
     		message.setTo(tokenizedTo);
        	message.setCc(tokenizedCC);
        	message.setBcc(tokenizedBcc);
        	message.setSubject(subject);
        	message.setText(body);
     		mailSender.send(message);
     	logger.debug("DONE sending email");
    }
    
    public void newSendMail(String from, String to, String bCc,
            String subject, String body,String organization) throws UnsupportedEncodingException{
       MimeMessage message = newMailSender.createMimeMessage();
		
		try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			
			helper.setFrom(new InternetAddress(from, organization));
			helper.setTo(to);
			helper.addBcc(bCc);
			helper.setSubject(subject);
			//helper.setText(body);
			helper.setText(body, true);
			
		}catch (MessagingException e) {
			throw new MailParseException(e);
		}
		newMailSender.send(message);
		logger.debug("DONE sending email");
    }
    
    public void newSendMailTax(String from, String to, String cc, String bCc,
            String subject, String body) {
       MimeMessage message = newMailSender.createMimeMessage();
		
		try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(from);
			helper.setTo(to);
			helper.addCc(cc);
			helper.addBcc(bCc);
			helper.setSubject(subject);
			//helper.setText(body);
			helper.setText(body, true);
			
		}catch (MessagingException e) {
			throw new MailParseException(e);
		}
		newMailSender.send(message);
		logger.debug("DONE sending email");
    }
    private String[] getStringTokenizer(String strEmails) {
    	String stringArray[] = null;
    	if(strEmails != null){
    		StringTokenizer token = new StringTokenizer(strEmails, ";");
    		int count = token.countTokens();
    		stringArray = new String[count];
    		for(int i=0; i< count ; i++){
    			stringArray[i] = token.nextToken();
    		}
    	}
		return stringArray;
	}

    public void sendAlertMail(String alert) {
        SimpleMailMessage mailMessage = new SimpleMailMessage(alertMailMessage);
        mailMessage.setText(alert);
        mailSender.send(mailMessage);
    }

    /*public static final void main(String[] args) {
		ApplicationContext appCtx = new ClassPathXmlApplicationContext(new String[] {
				"mail-config.xml"
		});
		
		EmailService tester = (EmailService) appCtx.getBean("mailTest");
		tester.sendMeMail();
	}*/
    
    /*public void sendMeMail() {
		SimpleMailMessage msg = new SimpleMailMessage(templateMessage);
		msg.setTo("apoorvada@yahoo.com");
		msg.setText("This is a test.\nGo Spring!\n");
		try {
			this.mailSender.send(msg);
			System.out.print("mail sent");
		} catch (MailException e) {
			System.err.println("Didn't work.");
			e.printStackTrace();
		}
	}*/
}
