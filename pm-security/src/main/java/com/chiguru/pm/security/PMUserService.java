package com.chiguru.pm.security;

public interface PMUserService {
    public void createNewUser(PMUser pmUser, String[] roles);

//    public void updatePassword(PMUser pmUser, String[] roles);

	public String getPassword(String username);

	public void changePassword(String oldPassword, String password);
	
	public String retriveUserDetails(String to, String userNo);
	
	public String retriveUserName(String to);

	public void splSetPassword(String to, String userNo, String password);

	public boolean userExists(String username);
    
}
