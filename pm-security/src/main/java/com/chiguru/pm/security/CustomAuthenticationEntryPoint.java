package com.chiguru.pm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint ;

public class CustomAuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint  {
	private String mobileLoginFormUrl;
	
	public String getMobileLoginFormUrl() {
		return mobileLoginFormUrl;
	}
	public void setMobileLoginFormUrl(String mobileLoginFormUrl) {
		this.mobileLoginFormUrl = mobileLoginFormUrl;
	}
	private static Logger logger = Logger.getLogger(CustomAuthenticationEntryPoint.class);
	@Override
	protected String determineUrlToUseForThisRequest(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) {
		if(SecurityUtil.isMobileBrowser(request)){
			logger.debug("Mobile Client detected setting to mobile login form :"+ mobileLoginFormUrl);
			return getMobileLoginFormUrl();
		}else{
			return getLoginFormUrl();
		}
    }
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) 
	throws IOException, ServletException{
		logger.debug("Inside CustomAuthenticationEntryPoint ..");
		super.commence(request, response, authException);
	}
	
}
