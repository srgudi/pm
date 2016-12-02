package com.chiguru.pm.web.controller.user;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chiguru.pm.tax.domain.TaskNotificationTemplate;
import com.chiguru.pm.web.controller.crm.BaseController;
import com.chiguru.pm.web.util.EncryptionUtil;
import com.chiguru.pm.web.util.PMUtil;
import com.chiguru.pm.security.captcha.CaptchaController;
import com.chiguru.pm.security.PMUser;

import com.octo.captcha.Captcha;
import com.octo.captcha.service.CaptchaServiceException;


@Controller
public class ResetPasswordController extends BaseController {
	
	private static final String captchaResponseParameterName = "response";
	
	private static final Long FORGOT_PASSWORD_TEMPLATE_NUMBER = new Long(6);
	
	private Logger logger = org.slf4j.LoggerFactory
			.getLogger(ResetPasswordController.class);

	@ModelAttribute
	public PMUser initializeModel(Long clientId, Integer relationType,
			HttpServletRequest request, String userResetPasswordKey,
			String userName) {
		logger.info("receive Password select");
		String role = "ROLE_STAFF";
		String[] roles = { role };
		PMUser pmuser = PMUser.constructPMUserForResetPassword(userName,
				userResetPasswordKey, roles);
		if (userName != null) {
			if (userResetPasswordKey != null) {
				String user = userService.retriveUserDetails(userName,
						userResetPasswordKey);
				
				pmuser.setUsersKey(user);
				if(user == null){
					pmuser.setUsersKey(userResetPasswordKey);
				}
			}
			pmuser.setEnabled(true);
		}
		return pmuser;
	}


	@RequestMapping(value = "/user/forgotPassword.do", method = RequestMethod.GET)
	public String forgotPassword(HttpServletRequest request, ModelMap model,
			PMUser user) {
		logger.info("forgot Password select");
		model.addAttribute("user", user);
		PMUtil.showStatusMessage(request, model);
		return "forgotPassword.tilesView";
	}
	@RequestMapping(value = "/user/forgotPassword.do", method = RequestMethod.POST)
	public @ResponseBody
	Map forgotPassword(HttpServletRequest request, ModelMap model, PMUser user,
			String userName) {
		Map returnMap = new HashMap();
		returnMap.put("successFlag", Boolean.FALSE);
		logger.info("forgot Password save");
		model.addAttribute("user", user);
		java.util.Random randomGenerator = new java.util.Random();
		int randomInt = randomGenerator.nextInt(1000);
		String userResetPasswordKey = EncryptionUtil.getInstance().encrypt(String.valueOf(randomInt));
		String name = "Customer";
		String username = user.getUsername();
		String captchaId = request.getSession().getId();
		String response = request.getParameter(captchaResponseParameterName);
		boolean valid = CaptchaController.validateCaptchaFromCaptchaService(captchaId, response);
			if (userService.userExists(username)) {
				crmManager.savePassword(username,userResetPasswordKey);
				if(valid)
				{
				returnMap.put("successFlag", Boolean.TRUE);
				sendPasswordResetLink(name, username, userResetPasswordKey);
			    }
		}	
		
		return returnMap;
	}

	@RequestMapping(value = "/emailIdExists.do", method = RequestMethod.POST)
	@ResponseBody public
	Map emailExists(HttpServletRequest request, String userName) {
		Map returnMap = new HashMap();
		if (userService.userExists(userName)) {
		  returnMap.put("mailexists", Boolean.FALSE);
		}else{
		  returnMap.put("mailexists", Boolean.TRUE);
		}
			
	   return returnMap;
	}
	
	private void sendPasswordResetLink(String name, String username,
			String userResetPasswordKey) {
		String sub;
		String body;
		ResourceBundle bundle = ResourceBundle.getBundle("pm");
		String hostName = bundle.getString("APP_HOST");
		String portName = bundle.getString("APP_PORT");
		String urlName = bundle.getString("PWD_URL");
		String passwordURL = hostName + ":" + portName + urlName + "?userName="
				+ username + "&userResetPasswordKey=" + userResetPasswordKey;
		TaskNotificationTemplate taskNotificationTemplate = null;
		if (username != null) {
			taskNotificationTemplate = taskModuleDao
					.getTaskNotificationTemplate(FORGOT_PASSWORD_TEMPLATE_NUMBER);
		}
		sub = String.format(taskNotificationTemplate.getSubject(), name);
		body = String.format(taskNotificationTemplate.getBodyText(), name,
				passwordURL);

		//StringBuffer cc = new StringBuffer();
		String emailCC = "practicem62@gmail.com";
		//cc.insert(0, emailCC);
		emailService.newSendMailTax("practicem62@gmail.com", username, emailCC,
				"apoorvada@yahoo.com", sub, body);

	}
	

}
