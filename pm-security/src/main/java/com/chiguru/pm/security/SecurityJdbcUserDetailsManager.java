package com.chiguru.pm.security;

import org.springframework.context.ApplicationContextException;

import org.springframework.dao.IncorrectResultSizeDataAccessException;

import org.springframework.jdbc.core.PreparedStatementSetter;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.cache.NullUserCache;
import org.springframework.security.provisioning.UserDetailsManager;

import org.springframework.util.Assert;



import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.Collection;
import java.util.List;
import java.util.Map;


/**
 * <p>
 * SecurityJdbcUserDetailsManager.java
 * </p>
 *
 * @author ORANGUTAN
 * @since 01.31.2011
 */
public class SecurityJdbcUserDetailsManager
    extends SecurityEnabledCustomJdbcDaoImpl implements UserDetailsManager {
    // ----------------------- CREATE USER SQLs ----------------------------
    // UserDetailsManager SQL
    /** The Constant DEF_CREATE_USER_SQL. */
    public static final String DEF_CREATE_USER_SQL = "insert into users (username, password, enabled,party_relationship_id,created_by,created_date,updated_by,updated_date,users_key,users_expiry_date) values (?,?,?,?,?,?,?,?,?,?)";

    /** The Constant DEF_DELETE_USER_SQL. */
    public static final String DEF_DELETE_USER_SQL = "delete from users where username = ?";

    /** The Constant DEF_UPDATE_USER_SQL. */
    public static final String DEF_UPDATE_USER_SQL = "update users set password = ?, enabled = ? where username = ?";

    /** The Constant DEF_INSERT_AUTHORITY_SQL. */
    public static final String DEF_INSERT_AUTHORITY_SQL = "insert into authorities (username, authority) values (?,?)";

    /** The Constant DEF_DELETE_USER_AUTHORITIES_SQL. */
    public static final String DEF_DELETE_USER_AUTHORITIES_SQL = "delete from authorities where username = ?";

    /** The Constant DEF_USER_EXISTS_SQL. */
    public static final String DEF_USER_EXISTS_SQL = "select username from users where username = ?";
    
    /** The Constant DEF_PASSWORD_EXISTS_SQL. */
    public static final String DEF_PASSWORD_EXISTS_SQL = "select password from users where username = ?";
    
    /** The Constant DEF_USER_DETAILS_EXISTS_SQL. */
    public static final String DEF_USER_DETAILS_EXISTS_SQL = "select * from users where username = ? and users_key = ?";
    
    /** The Constant DEF_INSERT_AUTHORITY_SQL. */
    public static final String DEF_CHANGE_USERDETAILS_SQL = "select users_key  from users where username = ?";
    
    /** The Constant DEF_CHANGE_PASSWORD_SQL. */
    public static final String DEF_CHANGE_PASSWORD_SQL = "update users set password = ? where username = ?";

    /**  DEF_SPL_CHANGE_PASSWORD_SQL */
    public static final String DEF_SPL_CHANGE_PASSWORD_SQL = "update users set password = ? where username = ? and users_key = ?";
    
    /** The user cache. */
    private UserCache userCache = new NullUserCache();

    /** The authentication manager. */
    private AuthenticationManager authenticationManager;

    // ~ Methods
    // ========================================================================================================
    /* (non-Javadoc)
     * @see org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl#initDao()
     */
    protected void initDao() throws ApplicationContextException {
        if (authenticationManager == null) {
            logger.info(
                "No authentication manager set. Reauthentication of users when changing passwords will " +
                "not be performed.");
        }

        super.initDao();
    }

    // -- Manage User Details customizations
    /* (non-Javadoc)
     * @see org.springframework.security.provisioning.UserDetailsManager#createUser(org.springframework.security.core.userdetails.UserDetails)
     */
    public void createUser(final UserDetails user) {
        validateUserDetails(user);

        final PMUser pmUser = (PMUser) user;
        getJdbcTemplate().update(DEF_CREATE_USER_SQL,
            new PreparedStatementSetter() {
                public void setValues(PreparedStatement ps)
                    throws SQLException {
                    ps.setString(1, pmUser.getUsername());
                    ps.setString(2, pmUser.getPassword());
                    ps.setBoolean(3, pmUser.isEnabled());
                    ps.setLong(4, pmUser.getPartyRelationshipId());
                    ps.setString(5, pmUser.getCreatedBy());
                    ps.setDate(6, new Date(System.currentTimeMillis()));
                    ps.setString(7, pmUser.getCreatedBy());
                    ps.setDate(8, new Date(System.currentTimeMillis()));
                    ps.setString(9, pmUser.getUsersKey());
                    ps.setDate(10, (Date) pmUser.getUsersExpiryDate() );
                }
            });

        if (getEnableAuthorities()) {
            insertUserAuthorities(user);
        }
    }

    /**
     * Validate user details.
     *
     * @param user the user
     */
    private void validateUserDetails(UserDetails user) {
        Assert.hasText(user.getUsername(), "Username may not be empty or null");
        validateAuthorities(user.getAuthorities());
    }

    /**
     * Validate authorities.
     *
     * @param authorities the authorities
     */
    private void validateAuthorities(Collection<? extends GrantedAuthority> authorities) {
        Assert.notNull(authorities, "Authorities list must not be null");

        for (GrantedAuthority authority : authorities) {
            Assert.notNull(authority, "Authorities list contains a null entry");
            Assert.hasText(authority.getAuthority(),
                "getAuthority() method must return a non-empty string");
        }
    }

    /**
     * Insert user authorities.
     *
     * @param user the user
     */
    private void insertUserAuthorities(UserDetails user) {
        for (GrantedAuthority auth : user.getAuthorities()) {
            getJdbcTemplate()
                .update(DEF_INSERT_AUTHORITY_SQL, user.getUsername(),
                auth.getAuthority());
        }
    }

    /* (non-Javadoc)
     * @see org.springframework.security.provisioning.UserDetailsManager#deleteUser(java.lang.String)
     */
    public void deleteUser(String username) {
        if (getEnableAuthorities()) {
            deleteUserAuthorities(username);
        }

        getJdbcTemplate().update(DEF_DELETE_USER_SQL, new Object[] { username });
        userCache.removeUserFromCache(username);
    }

    /**
     * Delete user authorities.
     *
     * @param username the username
     */
    private void deleteUserAuthorities(String username) {
        getJdbcTemplate()
            .update(DEF_DELETE_USER_AUTHORITIES_SQL, new Object[] { username });
    }

    /* (non-Javadoc)
     * @see org.springframework.security.provisioning.UserDetailsManager#changePassword(java.lang.String, java.lang.String)
     */
    public void changePassword(String oldPassword, String newPassword)
        throws AuthenticationException {
        Authentication currentUser = SecurityContextHolder.getContext()
                                                          .getAuthentication();

        if (currentUser == null) {
            // This would indicate bad coding somewhere
            throw new AccessDeniedException(
                "Can't change password as no Authentication object found in context " +
                "for current user.");
        }

        String username = currentUser.getName();

        // If an authentication manager has been set, re-authenticate the user
        // with the supplied password.
        if (authenticationManager != null) {
            logger.debug("Reauthenticating user '" + username +
                "' for password change request.");

            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                    username, oldPassword));
        } else {
            logger.debug(
                "No authentication manager set. Password won't be re-checked.");
        }

        logger.debug("Changing password for user '" + username + "'");

        getJdbcTemplate().update(DEF_CHANGE_PASSWORD_SQL, newPassword, username);

        SecurityContextHolder.getContext()
                             .setAuthentication(createNewAuthentication(
                currentUser, newPassword));

        userCache.removeUserFromCache(username);
    }

    /**
     * Creates the new authentication.
     *
     * @param currentAuth the current auth
     * @param newPassword the new password
     * @return the authentication
     */
    protected Authentication createNewAuthentication(
        Authentication currentAuth, String newPassword) {
        UserDetails user = loadUserByUsername(currentAuth.getName());

        UsernamePasswordAuthenticationToken newAuthentication = new UsernamePasswordAuthenticationToken(user,
                user.getPassword(), user.getAuthorities());
        newAuthentication.setDetails(currentAuth.getDetails());

        return newAuthentication;
    }

    /* (non-Javadoc)
     * @see org.springframework.security.provisioning.UserDetailsManager#userExists(java.lang.String)
     */
    public boolean userExists(String username) {
        List<String> users = getJdbcTemplate()
                                 .queryForList(DEF_USER_EXISTS_SQL,
                new String[] { username }, String.class);
        int size = users.size();
        if (size == 1) {
           /* throw new IncorrectResultSizeDataAccessException(
                "More than one user found with name '" + username + "'", 1);*/
            return true;
        }

        return false;
    }

    /* (non-Javadoc)
     * @see org.springframework.security.provisioning.UserDetailsManager#updateUser(org.springframework.security.core.userdetails.UserDetails)
     */
    public void updateUser(final UserDetails user) {
        validateUserDetails(user);
        getJdbcTemplate().update(DEF_UPDATE_USER_SQL,
            new PreparedStatementSetter() {
                public void setValues(PreparedStatement ps)
                    throws SQLException {
                    ps.setString(1, user.getPassword());
                    ps.setBoolean(2, user.isEnabled());
                    ps.setString(3, user.getUsername());
                }
            });

        if (getEnableAuthorities()) {
            deleteUserAuthorities(user.getUsername());
            insertUserAuthorities(user);
        }

        userCache.removeUserFromCache(user.getUsername());
    }

	public String getPassword(String username) {
		 List<String> passwords = getJdbcTemplate().queryForList(DEF_PASSWORD_EXISTS_SQL,new String[] { username }, String.class);
	     return passwords.get(0);
	}

	
	public String retriveUserDetails(String to, String userNo) {
		
		/*insertUserDetails(userNo, username);
		List<PMUser> user = getJdbcTemplate().queryForList("select * from users where username = ? and users_key = ?",new String[] {username,userNo}, PMUser.class);
		Object user = getJdbcTemplate().queryForRowSet("select * from users where username = :username and users_key = :userNo");
		
		Map<String,Object> user = getJdbcTemplate().queryForMap(
			    "select * from users where username = ? and users_key = ?",
			    new Object[]{username,userNo}, PMUser.class);
		return (PMUser) user;*/
		/*List<String> uN = getJdbcTemplate().queryForList(DEF_USER_EXISTS_SQL,new String[] { to }, String.class);*/
		List<String> uK = getJdbcTemplate().queryForList(DEF_CHANGE_USERDETAILS_SQL,new String[] { to }, String.class);
		return uK.get(0);
	}
	
   public String retriveUserName(String to) {
		List<String> uN = getJdbcTemplate().queryForList(DEF_USER_EXISTS_SQL,new String[] { to }, String.class);
		return uN.get(0);
	}
	
   public void splSetPassword(String to, String userNo, String password) {
	   getJdbcTemplate().update(DEF_CHANGE_PASSWORD_SQL, password, to);
	   userCache.removeUserFromCache(to);
	}
	/*private void insertUserDetails(final String userNo, final String to) {
	
	        while(to != null){
	            getJdbcTemplate()
	                .update(DEF_CHANGE_USERDETAILS_SQL, userNo ,userExpiryDate,to
	                );
	            getJdbcTemplate().update(DEF_CHANGE_USERDETAILS_SQL,
	                    new PreparedStatementSetter() {
	                        public void setValues(PreparedStatement ps)
	                            throws SQLException {
	                            ps.setString(1,userNo);
	                            ps.setString(2,to);
	                        }
	                    });
	        }
	    }*/
}
