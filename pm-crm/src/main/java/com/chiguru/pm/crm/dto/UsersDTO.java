package com.chiguru.pm.crm.dto;
import java.io.Serializable;



public class UsersDTO implements Serializable {
	
	private String userName;
	private String language;
	private String newPassword;
	private String resetPassword;

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getLanguage() {
		return language;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setResetPassword(String resetPassword) {
		this.resetPassword = resetPassword;
	}

	public String getResetPassword() {
		return resetPassword;
	}
}