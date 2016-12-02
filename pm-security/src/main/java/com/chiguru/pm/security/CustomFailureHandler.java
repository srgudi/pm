package com.chiguru.pm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

/**
 * This class is meant to handle login failure to forward either to mobile login or web login page.
 * @author Shrinivas Gudi
 * @since Nov 30th 2012
 *
 */
public class CustomFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	private String mobileFailureUrl;
	private String defaultFailureUrl;
	public String getMobileFailureUrl() {
		return mobileFailureUrl;
	}

	public void setMobileFailureUrl(String mobileFailureUrl) {
		this.mobileFailureUrl = mobileFailureUrl;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

	public CustomFailureHandler() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustomFailureHandler(String defaultFailureUrl) {
		super(defaultFailureUrl);
		this.defaultFailureUrl = defaultFailureUrl;
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
		String failureUrl = defaultFailureUrl;
/*		if(SecurityUtil.isMobileBrowser(request)){
			logger.debug("Mobile Client detected forwarding to mobile failure URL :"+ mobileFailureUrl);
			failureUrl = mobileFailureUrl;
		}
		 if (failureUrl == null) {
	            logger.debug("No failure URL set, sending 401 Unauthorized error");

	            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication Failed: " + exception.getMessage());
	        }*/ 
		//For Ajax requests, send the login success as false result
		if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
			response.getWriter().print("false");
			response.getWriter().flush();
		} else {
			   //for regular web login, save exception and forward to login page
		        saveException(request, exception);

	            if (isUseForward()) {
	                logger.debug("Forwarding to " + failureUrl);

	                request.getRequestDispatcher(failureUrl).forward(request, response);
	            } else {
	                logger.debug("Redirecting to " + failureUrl);
	                getRedirectStrategy().sendRedirect(request, response, failureUrl);
	            }
	        }
	}
}
