package com.chiguru.pm.security;

public class PMUserServiceImpl implements PMUserService {
    private SecurityJdbcUserDetailsManager jdbcUserDetailsManager;

    public void setJdbcUserDetailsManager(
        SecurityJdbcUserDetailsManager jdbcUserDetailsManager) {
        this.jdbcUserDetailsManager = jdbcUserDetailsManager;
    }

    @Override
    public void createNewUser(PMUser pmUser, String[] roles) {
        jdbcUserDetailsManager.createUser(pmUser);
    }
    
    /*@Override
    public void updatePassword(PMUser pmUser, String[] roles) {
        jdbcUserDetailsManager.updateUser(pmUser);
    }*/

	@Override
	public String getPassword(String username) {
		 return jdbcUserDetailsManager.getPassword(username);
	}
	
	@Override
	public void changePassword(String oldPassword, String password) {
		 jdbcUserDetailsManager.changePassword(oldPassword,password);
	}


	@Override
	public String retriveUserDetails(String to, String userNo) {
		String result = jdbcUserDetailsManager.retriveUserDetails( to,userNo);
		return result;
	}

	@Override
	public String retriveUserName(String to) {
		String result = jdbcUserDetailsManager.retriveUserName( to);
		return result;
	}
	
	@Override
	public void splSetPassword(String to, String userNo, String password){
		 jdbcUserDetailsManager.splSetPassword( to,  userNo, password);
		
	}
	
	@Override
	 public boolean userExists(String username){
		boolean result = jdbcUserDetailsManager.userExists(username);
		return result;
		
	}
}
