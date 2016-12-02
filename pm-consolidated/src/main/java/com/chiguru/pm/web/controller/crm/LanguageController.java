package com.chiguru.pm.web.controller.crm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.security.PMUser;
import com.chiguru.pm.crm.dto.UsersDTO;



@Controller
public class LanguageController {
	
	 @Autowired
	 CRMManager crmManager;
	
	@RequestMapping(value = "/admin/langSelect.do", method = RequestMethod.POST)
	public String langSelect(HttpServletRequest request,ModelMap model) {
		
		HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession();
		if (session != null) {
          
            String lang = request.getParameter("langValue");
            session.setAttribute("lang",lang);
            SecurityContext context = SecurityContextHolder.getContext();
            PMUser loggedInUser = null;
    		loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
    		String username=loggedInUser.getUsername();
    		crmManager.changeLanguage(lang,username);
    		UsersDTO user = new UsersDTO() ;
    		model.addAttribute("user", user);
        }
		return "redirect:"+"userProfile.do";
	}


	public String loggedInUser() {
		SecurityContext context = SecurityContextHolder.getContext();
		PMUser loggedInUser = (PMUser) context.getAuthentication().getPrincipal();
    	String username=loggedInUser.getUsername();
		return username;
	}
	 
}
