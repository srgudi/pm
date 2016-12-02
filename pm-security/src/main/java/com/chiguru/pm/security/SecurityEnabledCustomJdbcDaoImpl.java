package com.chiguru.pm.security;

import org.springframework.jdbc.core.RowMapper;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;


/**
 *
 * @author ORANGUTAN
 *
 */
public class SecurityEnabledCustomJdbcDaoImpl extends JdbcDaoImpl {
    public static final String CUSTOM_DEF_USERS_BY_USERNAME_QUERY = "select username,password, enabled,party_relationship_id " +
        "from users " + "where username = ?";
    private String rolePrefix = "";
    private boolean usernameBasedPrimaryKey = true;

    /**
     * Executes the SQL <tt>usersByUsernameQuery</tt> and returns a list of
     * UserDetails objects. There should normally only be one matching user.
     */
    protected List<UserDetails> loadUsersByUsername(String username) {
        return getJdbcTemplate().query(CUSTOM_DEF_USERS_BY_USERNAME_QUERY,
            new String[] { username },
            new RowMapper<UserDetails>() {
                public UserDetails mapRow(ResultSet rs, int rowNum)
                    throws SQLException {
                    String username = rs.getString(1);
                    String password = rs.getString(2);
                    boolean enabled = rs.getBoolean(3);
                    Long partyRelationshipId = rs.getLong(4);

                    return PMUser.defaultInstance(username, password, enabled,
                        partyRelationshipId, null);
                }
            });
    }

    /**
     * Can be overridden to customize the creation of the final
     * UserDetailsObject which is returned by the <tt>loadUserByUsername</tt>
     * method.
     *
     * @param username
     *            the name originally passed to loadUserByUsername
     * @param userFromUserQuery
     *            the object returned from the execution of the
     * @param combinedAuthorities
     *            the combined array of authorities from all the authority
     *            loading queries.
     * @return the final UserDetails which should be used in the system.
     */
    protected UserDetails createUserDetails(String username,
        UserDetails userFromUserQuery,
        List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();
        PMUser pmUser = (PMUser) userFromUserQuery;

        if (!usernameBasedPrimaryKey) {
            returnUsername = username;
        }
        	return PMUser.userWithAuthorities(pmUser.getUsername(),
                    pmUser.getPassword(), pmUser.isEnabled(),
                    pmUser.getPartyRelationshipId(), combinedAuthorities);
        
    }

    /**
     * Loads authorities by executing the SQL from
     * <tt>authoritiesByUsernameQuery</tt>.
     *
     * @return a list of GrantedAuthority objects for the user
     */
    protected List<GrantedAuthority> loadUserAuthorities(String username) {
        return getJdbcTemplate().query(DEF_AUTHORITIES_BY_USERNAME_QUERY,
            new String[] { username },
            new RowMapper<GrantedAuthority>() {
                public GrantedAuthority mapRow(ResultSet rs, int rowNum)
                    throws SQLException {
                    String roleName = rolePrefix + rs.getString(2);
                    GrantedAuthorityImpl authority = new GrantedAuthorityImpl(roleName);

                    return authority;
                }
            });
    }
}
