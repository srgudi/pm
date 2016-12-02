/**
 * 
 */
package com.chiguru.pm.web.controller.crm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chiguru.pm.crm.dto.UsersDTO;
import com.chiguru.pm.crm.service.CRMManager;
import com.chiguru.pm.web.util.EncryptionUtil;



/**
 * @author Apoorva
 *
 */
@Controller
public class NewPasswordController {
	
	@Autowired
    protected CRMManager crmManager;
	
	@ModelAttribute
	public UsersDTO initiazeobject(HttpServletRequest request,String userName,String userResetPasswordKey){
		UsersDTO currentuser = new UsersDTO();
		if(userResetPasswordKey != null & !request.getMethod().equals("POST")){
			Boolean validUser = crmManager.isValidUser(userName,userResetPasswordKey);
			if(validUser){
			HttpSession session = request.getSession();
			session.setAttribute("newUserName", userName);
			currentuser.setUserName(userName);
			return currentuser;
			}
		}
		return currentuser;
		
	}
	
	@RequestMapping(value = {"/user/receivePassword.do","/mobileuser/receivePasswordMobile.do"}, method = RequestMethod.GET)
    public String createFirm(HttpServletRequest request, ModelMap model,UsersDTO currentuser) {
		model.addAttribute("newuser", currentuser);
		if (request.getRequestURI().contains("/user/receivePassword.do")){
		   return "/user/receivePassword";
		}else{
		   return "/mobileuser/receivePassword";
		}
	}

	@RequestMapping(value = {"/user/receivePassword.do","/mobileuser/receivePasswordMobile.do"}, method = RequestMethod.POST)
    public String saveFirm(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("newUserName");
		session.setAttribute("newUserName", null);
		String returnURL = null;
		if(user == null){
			if (request.getRequestURI().contains("/user/receivePassword.do")){
		      returnURL = "/login.jsp?user=hacker";
			}else{
			  returnURL = "/mobile_login.jsp?user=hacker";
			}
		}else{
		   String encriptPass = EncryptionUtil.getInstance().encrypt(request.getParameter("newpassword"));
		   crmManager.savePassword(user,encriptPass);
		   if (request.getRequestURI().contains("/user/receivePassword.do")){
		      returnURL = "/login.jsp?user=genuine";
		   }else{
			  returnURL = "/mobile_login.jsp?user=genuine";
		   }
		}
		return "redirect:" + returnURL;
	}
}
