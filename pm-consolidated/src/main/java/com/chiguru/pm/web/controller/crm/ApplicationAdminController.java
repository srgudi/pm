package com.chiguru.pm.web.controller.crm;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//This class is not in use. 
@Controller
public class ApplicationAdminController {


    @RequestMapping(value = {"/appadmin/mainAdmin.do","/mobileadmin/mobileMainAdmin.do"}, method = RequestMethod.GET)
    public String mainAdmin(HttpServletRequest request, ModelMap model) {
    	String servletPath=request.getServletPath();
    	if(servletPath.equals("/mobileadmin/mobileMainAdmin.do"))
    	{
    		return "mobileMainAdmin.tilesView";
    	}
        return "mainAdmin.tilesView";
    }

    @RequestMapping(value = {"/appadmin/mainEmployee.do","/mobileadmin/mobEmployeetab.do"}, method = RequestMethod.GET)
    public String mainAdminEmployee(HttpServletRequest request, ModelMap model) {
        HttpSession session = request.getSession();
        String strfirmId = request.getParameter("sessionfirmId");
        Long firmId = Long.parseLong(strfirmId);
        session.setAttribute("sessionfirmId", firmId);
        String servletPath=request.getServletPath();
    	if(servletPath.equals("/appadmin/mainEmployee.do")){
           return "mainEmployee.tilesView";
    	}else{
    	   return "mobEmployeeList.tilesView";
    	}
    }

    @RequestMapping(value = "/appadmin/adminList.do", method = RequestMethod.GET)
    public String adminList(HttpServletRequest request, ModelMap model) {
        return "appadmin/adminList";
    }

    @RequestMapping(value = "/appadmin/juridList.do", method = RequestMethod.GET)
    public String juridList(HttpServletRequest request, ModelMap model) {
        return "appadmin/juridList";
    }

    @RequestMapping(value = "/appadmin/codeTypeL.do", method = RequestMethod.GET)
    public String codeTypeList(HttpServletRequest request, ModelMap model) {
        return "appadmin/codeTypeList";
    }

    @RequestMapping(value = "/appadmin/codeLst.do", method = RequestMethod.GET)
    public String codeList(HttpServletRequest request, ModelMap model) {
        return "appadmin/codeList";
    }

    @RequestMapping(value = "/appadmin/templateList.do", method = RequestMethod.GET)
    public String templateList(HttpServletRequest request, ModelMap model) {
        return "appadmin/templateList";
    }

    @RequestMapping(value = "/appadmin/recepientList.do", method = RequestMethod.GET)
    public String recepientList(HttpServletRequest request, ModelMap model) {
        return "appadmin/recepientList";
    }
}
