package com.chiguru.pm.security;

import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import java.io.Serializable;

import java.util.Collection;
import java.util.Date;


/**
 * <p>
 * PMUSer.java
 * </p>
 * <p>
 * Description: A PM user captures the representation for a practice management
 * user.
 *
 * @author ORANGUTAN
 * @since 01.30.2011
 */
public class PMUser extends User implements Serializable {
    /**
         *
         */
    private static final long serialVersionUID = -8452109042365856664L;
    private Long partyRelationshipId;
    private String createdBy;
    private String usersKey;
	private Date usersExpiryDate;
	private String resetPassword;
	private Date createdDate;
	private String newPassword;
	private String oldPassword;
	private String language;
	

	public PMUser(String username, String password, boolean enabled,
        Long partyRelationshipId, boolean accountNonExpired,
        boolean credentialsNonExpired, boolean accountNonLocked,
        Collection<?extends GrantedAuthority> authorities,String usersKey) {
        super(username, password, enabled, accountNonExpired,
            credentialsNonExpired, accountNonLocked, authorities);
        this.partyRelationshipId = partyRelationshipId;
        this.usersKey = usersKey;

    }

	public PMUser(String username, String password, boolean enabled,
	        Long partyRelationshipId, boolean accountNonExpired,
	        boolean credentialsNonExpired, boolean accountNonLocked,
	        Collection<?extends GrantedAuthority> authorities) {
	        super(username, password, enabled, accountNonExpired,
	            credentialsNonExpired, accountNonLocked, authorities);
	        this.partyRelationshipId = partyRelationshipId;
	        

	    }
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Long getPartyRelationshipId() {
        return partyRelationshipId;
    }

    /**
     *
     * @param username
     * @param password
     * @param enabled
     * @param partyRelationshipId
     * @return
     */
    public static PMUser defaultInstance(String username, String password,
        boolean enabled, Long partyRelationshipId, String[] roles) {
        Collection<?extends GrantedAuthority> authorities = (roles != null)
            ? AuthorityUtils.createAuthorityList(roles)
            : AuthorityUtils.NO_AUTHORITIES;

        return new PMUser(username, password,enabled, partyRelationshipId,
            true, true, true, authorities);
    }

    /**
    *
    * @param username
    * @param password
    * @param enabled
    * @param partyRelationshipId
    * @return
    */
    public static PMUser userWithAuthorities(String username, String password,
        boolean enabled, Long partyRelationshipId,
        Collection<?extends GrantedAuthority> authorities) {
        return new PMUser(username, password, enabled, partyRelationshipId,
            true, true, true, authorities);
    }

	public void setUsersKey(String usersKey) {
		this.usersKey = usersKey;
	}

	public String getUsersKey() {
		return usersKey;
	}

	public void setUsersExpiryDate(Date usersExpiryDate) {
		this.usersExpiryDate = usersExpiryDate;
	}

	public Date getUsersExpiryDate() {
		return usersExpiryDate;
	}

	public static PMUser constructPMUserForResetPassword(String userName2,
			String user, String[] roles) {

		Collection<?extends GrantedAuthority> authorities = (roles  != null)
            ? AuthorityUtils.createAuthorityList(roles)
            : AuthorityUtils.NO_AUTHORITIES;
		return new PMUser(userName2, "", true, (long) 0,
	            true, true, true, authorities);
		
		
	}
	
	public static PMUser constructPMUserForPartyConroller(String username3, String password,
	        boolean enabled, Long partyRelationshipId, String[] roles,String usersKey) {

		Collection<?extends GrantedAuthority> authorities = (roles  != null)
            ? AuthorityUtils.createAuthorityList((String[]) roles)
            : AuthorityUtils.NO_AUTHORITIES;
           
		return new PMUser(username3, "", false, partyRelationshipId,
	            true, true, true, authorities,usersKey);
		
	}

	public void setResetPassword(String resetPassword) {
		this.resetPassword = resetPassword;
	}

	public String getResetPassword() {
		return resetPassword;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setEnabled(boolean enabled) {
		enabled = true;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public static PMUser constructPMUserForChangePassword(String user, String[] roles) {
		Collection<?extends GrantedAuthority> authorities = (roles  != null)
        ? AuthorityUtils.createAuthorityList(roles)
        : AuthorityUtils.NO_AUTHORITIES;
	return new PMUser(user, "", false, (long) 0,
            true, true, true, authorities);
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getLanguage() {
		return language;
	}

	
}
