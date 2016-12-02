package com.chiguru.pm.web.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chiguru.pm.web.controller.crm.BaseController;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.security.PMUser;


@Controller
public class ChangePasswordController extends BaseController {
	
	private Logger logger = org.slf4j.LoggerFactory
			.getLogger(ChangePasswordController.class);

	@ModelAttribute
	public PMUser initializeModel(Long clientId, Integer relationType,
			HttpServletRequest request, String userResetPasswordKey,
			String userName) {
		logger.info("change Password select");
		HttpSession session = request.getSession(false);
		PartyDTO userProfile = (PartyDTO) session.getAttribute("userProfile");
		SecurityContext context = SecurityContextHolder.getContext();
		String currentUser =  getUserProfileEmailId();
	    /*Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<GrantedAuthorityImpl> grantedAuthorityImpls = (List) authentication.getAuthorities();
        String userRole = grantedAuthorityImpls.get(0).toString();*/
        String role = "ROLE_STAFF";
		String[] roles = { role };
		
			PMUser pmuser = PMUser.constructPMUserForChangePassword(currentUser,roles);
			return pmuser;

	}


	@RequestMapping(value = "/user/changePassword.do", method = RequestMethod.GET)
	public String changePassword(HttpServletRequest request, ModelMap model,
			PMUser user) {
		logger.info("change Password select");
		model.addAttribute("user", user);
		PMUtil.showStatusMessage(request, model);
		return "changePassword.tilesView";
	}
	
	
	
	@RequestMapping(value = "/user/changePassword.do", method = RequestMethod.POST)
	public String saveChangePassword(HttpServletRequest request,
			ModelMap model, @Valid PMUser user, BindingResult result,
			String userName,String oldPassword) {
		logger.info("Change Password Save!");
		String encryptedOldPassword = EncryptionUtil.getInstance().encrypt(
				oldPassword);
		String existingPassword = userService.getPassword(user.getUsername());
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL;
		System.out.println("base url value"+baseURL);
		if (existingPassword.equals(encryptedOldPassword)) {
			String Password = user.getNewPassword();
			String encryptedPassword = EncryptionUtil.getInstance().encrypt(
					Password);
			userService.changePassword(encryptedOldPassword, encryptedPassword);
			 returnURL = baseURL + "?saveSuccess=true";
		}
		
		return "redirect:" + returnURL;
	}
	
	@RequestMapping(value = "/mobileuser/mobileChangePassword.do", method = RequestMethod.GET)
	public String changeMobilePassword(HttpServletRequest request, ModelMap model,PMUser user
			) {
		logger.info("change Password select");
		model.addAttribute("user", user);
		PMUtil.showStatusMessage(request, model);
		return "mobileChangePassword.tilesView";
	}
	
	@RequestMapping(value = "/mobileuser/mobileChangePassword.do", method = RequestMethod.POST)
	public String saveMobileChangePassword(HttpServletRequest request,
			ModelMap model, @Valid PMUser user, BindingResult result,
			String userName,String oldPassword) {
		logger.info("Mobile Change Password Save!");
		String encryptedOldPassword = EncryptionUtil.getInstance().encrypt(
				oldPassword);
		String existingPassword = userService.getPassword(user.getUsername());
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL;
		System.out.println("base url value"+baseURL);
		if (existingPassword.equals(encryptedOldPassword)) {
			String Password = user.getNewPassword();
			String encryptedPassword = EncryptionUtil.getInstance().encrypt(
					Password);
			userService.changePassword(encryptedOldPassword, encryptedPassword);
			 returnURL = baseURL + "?saveSuccess=true";
		}
		
		return "redirect:" + returnURL;
	}
		
	}


