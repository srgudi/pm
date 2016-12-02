package com.chiguru.pm.security;

public enum PmRolesEnum {ROLE_PARTY,
    ROLE_STAFF,
    ROLE_APP_ADMIN,
    ROLE_FIRM_ADMIN,
	ROLE_CLIENT_STAFF;
    public static String[] getAllRoles() {
        String[] values = {  };
        int index = 0;

        for (PmRolesEnum role : PmRolesEnum.values()) {
            values[index] = role.name();
            index++;
        }

        return values;
    }
}
