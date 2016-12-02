package com.chiguru.pm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

/**
 * This class is meant to determine which Target to forward to upon successful
 * Login.
 * 
 * @author Shrinivas Gudi
 * @since Nov 30th 2012
 * 
 */
public class CustomSuccessHandler extends
		SavedRequestAwareAuthenticationSuccessHandler {
	private static Logger logger = Logger.getLogger(CustomSuccessHandler.class);
	private String mobileTargetUrl;
	private String staffTargetUrl;
	
	
	public String getStaffTargetUrl() {
		return staffTargetUrl;
	}

	public void setStaffTargetUrl(String staffTargetUrl) {
		this.staffTargetUrl = staffTargetUrl;
	}

	public String getMobileTargetUrl() {
		return mobileTargetUrl;
	}

	public void setMobileTargetUrl(String mobileTargetUrl) {
		this.mobileTargetUrl = mobileTargetUrl;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws ServletException, IOException {
		//For Ajax requests, send the login success as false result
		if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
			response.getWriter().print("true");
			response.getWriter().flush();
		}
			else {
			//for regular web login success, forward to success page
			super.onAuthenticationSuccess(request, response, authentication);
		}
	}

	@Override
	protected String determineTargetUrl(HttpServletRequest request,
			HttpServletResponse response) {
		if (SecurityUtil.isMobileBrowser(request)) {
			logger.debug("Mobile Client detected forwarding to mobile target :"
					+ mobileTargetUrl);
			return getMobileTargetUrl();
		}else if(SecurityUtil.isStaff(request)){
			return getStaffTargetUrl();
		}else{
			return getDefaultTargetUrl();
		}
	}

	
}
