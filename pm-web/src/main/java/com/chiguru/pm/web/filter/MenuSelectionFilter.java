package com.chiguru.pm.web.filter;

import java.io.IOException;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
/**
 * The menu selection filter inspects the request path and places the variable in the session for inspection later by the JSP
 * 
 * @author ORANGUTAN
 *
 */
public class MenuSelectionFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest http = (HttpServletRequest) request;
		http.getSession().setAttribute(
				MainMenuEnum.SELECTED_MENU.getDisplayToken(), MainMenuEnum.TAX);
		String[] path = http.getRequestURI().split("/");
		//  "/pm/client/clientList.do" 
		String url = path[2]; // url = client
		if (StringUtils.hasText(url)) {
			if (MainMenuEnum.CLIENT.getUrlPath().equals(url)) {
				http.getSession().setAttribute(
						MainMenuEnum.SELECTED_MENU.getDisplayToken(),
						MainMenuEnum.CLIENT.getDisplayToken());
			} else if (MainMenuEnum.TAX.getUrlPath().equals(url)) {
				http.getSession().setAttribute(
						MainMenuEnum.SELECTED_MENU.getDisplayToken(),
						MainMenuEnum.TAX.getDisplayToken());
			}
		}
		chain.doFilter(request, response);

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
