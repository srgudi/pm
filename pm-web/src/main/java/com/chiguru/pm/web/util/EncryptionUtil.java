package com.chiguru.pm.web.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;

public final class EncryptionUtil {
	private static EncryptionUtil instance;
	private final static int SALT = 50;
//	private final static String SALT = "my-salt-text";

	  private EncryptionUtil() {
	  }

	  //do "Run As" + "Java Application", to get MD5 encryption value.
	  public static void main(String[] args) throws IOException {
		  InputStreamReader converter = new InputStreamReader(System.in);
		  BufferedReader in = new BufferedReader(converter);
		  System.out.println("Please enter password: ");
		  String enterPassword = in.readLine();
		  
		  PasswordEncoder encoder = new Md5PasswordEncoder(); 
		  String hashWithoutSalting = encoder.encodePassword(enterPassword, null);
		  System.out.println("Without Salting encypted password: "+hashWithoutSalting);
		  
		  /*String withSaltHash = generateHash(enterPassword);
		  System.out.println("With Salting encypted password: "+withSaltHash);*/
	  }
	  
	  public synchronized String encrypt(String plaintext) {
		// this is simple way of encrypting password using MD5, without salting
	    PasswordEncoder encoder = new Md5PasswordEncoder(); 
	    String hash = encoder.encodePassword(plaintext, null);
	    
	    //this is used to add SALT 
//	    String hash = generateHash(plaintext);
	    return hash; //step 6
	  }
	  
	  public static String generateHash(String plaintext) {
		  	String input = SALT + plaintext;
	        StringBuilder hash = new StringBuilder();
	        try {
	            MessageDigest sha = MessageDigest.getInstance("MD5");
	            byte[] hashedBytes = sha.digest(input.getBytes());
	            char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	                    'a', 'b', 'c', 'd', 'e', 'f' };
	            for (int idx = 0; idx < hashedBytes.length; ++idx) {
	                byte b = hashedBytes[idx];
	                hash.append(digits[(b & 0xf0) >> 4]);
	                hash.append(digits[b & 0x0f]);
	            }
	        } catch (NoSuchAlgorithmException e) {
	            // handle error here.
	        }
	        return hash.toString();
	  }
	  
	  public static synchronized EncryptionUtil getInstance() {
	    if(instance == null){
	       instance = new EncryptionUtil(); 
	    } 
	    return instance;
	  }
}
