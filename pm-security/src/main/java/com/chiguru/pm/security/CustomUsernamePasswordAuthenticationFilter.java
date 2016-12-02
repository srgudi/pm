package com.chiguru.pm.security;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter ;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.chiguru.pm.security.captcha.CaptchaController;
import com.octo.captcha.service.CaptchaServiceException;
import com.octo.captcha.service.image.ImageCaptchaService;
import com.octo.captcha.service.multitype.MultiTypeCaptchaService;



/**
 * This class is to override attemptValidation() with JCAPTCHA validation
 * @author gudi
 *
 */
public class CustomUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	
	private static Logger logger = Logger.getLogger(CustomUsernamePasswordAuthenticationFilter.class);
	private static final String DEFAULT_CAPTCHA_RESPONSE_PARAMETER_NAME = "j_captcha_response";
	
	protected ImageCaptchaService captchaService;
	public ImageCaptchaService getCaptchaService() {
		return captchaService;
	}


	public void setCaptchaService(ImageCaptchaService captchaService) {
		this.captchaService = captchaService;
	}
	protected String captchaResponseParameterName = DEFAULT_CAPTCHA_RESPONSE_PARAMETER_NAME;
	
    //~ Methods ========================================================================================================

   
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		
    	logger.debug("Inside CustomUsernamePasswordAuthenticationFilter ..");
    	//String errorCode = null;
		//String sessionId = null;
		BindingResult result = null;
		
		//JCAPTCHA VALIDATION CALL GOES HERE
    	//validateCaptcha( result,  sessionId,  errorCode);
    	if(request.getParameter("validatCaptcha") != null)
    	{
		 validateCaptcha(request);
		 /*return super.attemptAuthentication(request, response);*/
    	}
	   //	validateCaptcha(result,sessionId,errorCode);
    	//IF SUCCESS CALL Futher Validation, otherwise ValidationException can be thrown
    	
            return super.attemptAuthentication(request, response);
    	
    }
    /*@RequestMapping(value = "/captcha.do", method = RequestMethod.GET)
    public String getManageCode(HttpServletRequest request) {
        logger.info("Get Manage Code!");

      
    return "";
    }
   
    @RequestMapping(value = "/captcha.do", method = RequestMethod.GET)
    public String processForm(HttpServletRequest request) {
  Object result;

private Validator validator;
validator.validate(form, result);
  validateCaptcha(result, request.getSession().getId(), "registration.captcha");
  if (((BindException) result).hasErrors()) {
	   return SPRING_SECURITY_FORM_PASSWORD_KEY;
	  }
   else
   {
	   return("jcaptcha.do");
   }
  
	  
 }*/
    
    
    /*private void validateCaptcha( Object result, String sessionid,
			String errorcode) {
    	MultiTypeCaptchaService captchaService = null;
    	
  	  if (null != ((BindException) result).getFieldError("captcha")) return;
  	  boolean validCaptcha = false;
  	String sessionId;
  	String errorCode;
  	  try {
  	   
	validCaptcha = captchaService.validateResponseForID(sessionId, validCaptcha);
  	  }
  	  catch (CaptchaServiceException e) {
  	   //should not happen, may be thrown if the id is not valid
  	   logger.warn("validateCaptcha()", e);
  	  }
  	  if (validCaptcha) {
		
	} else {

	} (!validCaptcha) {
  	   ((BindException) result).rejectValue("captcha", errorCode);
  	  }
  	 }
		
	}*/

    /*protected void onBindAndValidate(HttpServletRequest request, Object command, BindException errors) throws Exception {		
		validateCaptcha(request, errors);
		validateCommandObject(command, errors);
	}*/
    
private void validateCommandObject(Object command, BindException errors) {
		// TODO Auto-generated method stub
		
	}
protected  void validateCaptcha(HttpServletRequest request) throws AuthenticationException{
	boolean isResponseCorrect = false;
	
    //remenber that we need an id to validate!
    String captchaId = request.getSession().getId();
    //retrieve the response
    String response = request.getParameter(captchaResponseParameterName);
    //validate response
    isResponseCorrect = CaptchaController.validateCaptchaFromCaptchaService(captchaId, response);
	
	if(!isResponseCorrect){
		throw new AuthenticationServiceException("Image is not matching");
		//prepare object error, captcha response isn`t valid
       /* String objectName = "Captcha";
		String[] codes = {"captchaerror"};
		Object[] arguments = {};
		String defaultMessage = "error.captcherror";
		ObjectError oe = new ObjectError(objectName, codes, arguments, defaultMessage);
		errors.addError(oe);*/
	}         
/*boolean isResponseCorrect = false;
String captchaId = request.getSession().getId();
String response = request.getParameter(captchaId);

try {
if(response != null){
// isResponseCorrect = captchaService.validateResponseForID(captchaId, response);
}
} catch (CaptchaServiceException e) {

}
if(!isResponseCorrect){
String objectName = "Captcha";
String[] codes = {"invalid"};
Object[] arguments = {};
String defaultMessage = "Invalid image test entered!";
ObjectError oe = new ObjectError(objectName, codes, arguments, defaultMessage);
errors.addError(oe);
} */
    
 }
/*protected void validateCaptcha(BindingResult result, String sessionId, String errorCode) {
	  // If the captcha field is already rejected
	  if (null != result.getFieldError("captcha")) return;
	  boolean validCaptcha = false;
	  try {
	  validCaptcha = captchaService.validateResponseForID(sessionId, captcha.getCaptcha());
	  }
	  catch (CaptchaServiceException e) {
	   //should not happen, may be thrown if the id is not valid
	   logger.warn("validateCaptcha()", e);
	  }
	  if (!validCaptcha) {
	   result.rejectValue("captcha", errorCode);
	  }
	 }*/




}
