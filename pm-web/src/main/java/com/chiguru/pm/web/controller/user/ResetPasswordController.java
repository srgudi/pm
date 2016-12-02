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
	
    private static final String DEFAULT_CAPTCHA_RESPONSE_PARAMETER_NAME = "response";
	
	protected String captchaResponseParameterName = DEFAULT_CAPTCHA_RESPONSE_PARAMETER_NAME;
	private static final Long FORGOT_PASSWORD_TEMPLATE_NUMBER = new Long(17);
	
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

	@RequestMapping(value = "/user/receivePassword.do", method = RequestMethod.GET)
	public String receivePassword(HttpServletRequest request, ModelMap model,
			PMUser user) {
		logger.info("receive Password select");
		model.addAttribute("user", user);
		PMUtil.showStatusMessage(request, model);
		return "receivePassword.tilesView";
	}

	
	@RequestMapping(value = "/user/receivePassword.do", method = RequestMethod.POST)
	public String saveReceivePassword(HttpServletRequest request,
			ModelMap model, @Valid PMUser user, BindingResult result,
			String userResetPasswordKey, String userName) {
		logger.info("Receive Password Save!");
		String userKey = user.getUsersKey();
		
		if (userResetPasswordKey.equals(userKey)) {
			String Password = user.getNewPassword();
			String encryptedPassword = EncryptionUtil.getInstance().encrypt(
					Password);
			userService.splSetPassword(userName, userResetPasswordKey,
					encryptedPassword);
		}
		String baseURL = request.getParameter("baseURL");
		String returnURL = baseURL + "?saveSuccess=true"+"&userName="+userName+"&userResetPasswordKey="+userResetPasswordKey;
		return "redirect:" + returnURL;
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
		String userResetPasswordKey = String.valueOf(randomInt);
		String name = "Customer";
		String username = user.getUsername();
		String captchaId = request.getSession().getId();
		/*String response = request.getParameter(captchaResponseParameterName);*/
		String response = request.getParameter("response");
			if (userService.userExists(username)) {
				boolean valid = true;
				if(valid == false)
				{
					valid = true;
				}
				if(valid)
				{
				returnMap.put("successFlag", Boolean.TRUE);
				sendPasswordResetLink(name, username, userResetPasswordKey);
			    }
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

		StringBuffer cc = new StringBuffer();
		String emailCC = "practicem62@gmail.com";
		cc.insert(0, emailCC);
		emailService.sendMail("practicem62@gmail.com", username, cc,
				"apoorvada@yahoo.com", sub, body);

	}
	

}
