package com.chiguru.pm.security.captcha;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chiguru.pm.security.PMUser;
import com.octo.captcha.service.CaptchaServiceException;
import com.octo.captcha.service.multitype.MultiTypeCaptchaService;
@Controller
@Component
public class CaptchaController {
	public static final String CAPTCHA_IMAGE_FORMAT = "jpeg";

	
	 private static MultiTypeCaptchaService captchaService;
	 
	 @Autowired(required = true)
	  public void setCaptchaServiceAccessor(MultiTypeCaptchaService captchaService){
		 CaptchaController.captchaService = captchaService;
	 }

	 @SuppressWarnings("null")
	@RequestMapping("/captcha.do")
	 public void showForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
	  byte[] captchaChallengeAsJpeg = null;
	  // the output stream to render the captcha image as jpeg into
	  ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();  
	  try {
	   // get the session id that will identify the generated captcha.
	   // the same id must be used to validate the response, the session id is a good candidate!

	   String captchaId = request.getSession().getId();
	   BufferedImage challenge = captchaService.getImageChallengeForID(captchaId, request.getLocale());  

	   ImageIO.write(challenge, CAPTCHA_IMAGE_FORMAT, jpegOutputStream);
	  } catch (IllegalArgumentException e) {
	   response.sendError(HttpServletResponse.SC_NOT_FOUND);  
	   return;
	  } catch (CaptchaServiceException e) {
	   response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  
	   return;
	  }

	  captchaChallengeAsJpeg = jpegOutputStream.toByteArray();  

	  // flush it in the response  
	  response.setHeader("Cache-Control", "no-store");  
	  response.setHeader("Pragma", "no-cache");  
	  response.setDateHeader("Expires", 0);  
	  response.setContentType("image/"+CAPTCHA_IMAGE_FORMAT);  

	  ServletOutputStream responseOutputStream = response.getOutputStream();  
	  responseOutputStream.write(captchaChallengeAsJpeg); 
	  responseOutputStream.flush();  
	  responseOutputStream.close();
	 }
	 
	 public static boolean validateCaptchaFromCaptchaService( String captchaId,
				String response) {
			boolean isResponseCorrect = false;
			try {			
				if(response != null){
					isResponseCorrect =
						captchaService.validateResponseForID(captchaId, response);
				}
			} catch (CaptchaServiceException e) {
			    //should not happen, may be thrown if the id is not valid	
				e.printStackTrace();
			}
			return isResponseCorrect;
		}
}
