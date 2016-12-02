package com.chiguru.pm.web.theme;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chiguru.pm.crm.domain.Party;

/**
 * <p>Selects the theme to be used on the UI </p>
 * @author ORANGUTAN
 *
 */
@Controller
public class ThemeController {

	@RequestMapping(value = "/theme/themeSelect.do", method = RequestMethod.POST)
	public String themeSelect(HttpServletRequest request,@ModelAttribute Party party) {
		
		HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpSession session = httpReq.getSession();
		if (session != null) {
            if (session.getAttribute("inValidClientId") != null) {
                session.removeAttribute("inValidClientId");
            }

            String theme = request.getParameter("themeValue");

            
                session.setAttribute("theme", "theme ");
            
            
            // --- END THEME SET
        }
		return "clientList.tilesView";
	}

}
