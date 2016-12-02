package com.chiguru.pm.web.filter;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * The client Module enumeration for menu selection
 * </p>
 * 
 * @author ORANGUTAN
 * 
 */
public enum ClientSubMenuEnum implements Serializable {
	// TODO: The english text must be replaced with Locale Specific resource
	// Bundles
	STAFF("Client Staff", "SomeURL", 1), OFFICERS_SHAREHOLDERS(
			"Officers and ShareHolders", "SomeURL", 2), LOCATION(
			"Client Location", "SomeURL", 3), BANK("Client Bank", "SomeURL", 4), LAWYER(
			"Client Lawyer", "SomeURL", 5);

	private final String displayToken;
	private final int order;
	private final String urlPath;

	private ClientSubMenuEnum(String displayToken, String urlPath, int order) {
		this.displayToken = displayToken;
		this.order = order;
		this.urlPath = urlPath;
	}

	public String getDisplayToken() {
		return displayToken;
	}

	public int getOrder() {
		return order;
	}

	public String getUrlPath() {
		return urlPath;
	}

	public static Map<ClientSubMenuEnum, String> getUrlTokenMap() {

		Map<ClientSubMenuEnum, String> menuMap = new HashMap<ClientSubMenuEnum, String>();
		menuMap.put(STAFF, "someUrl");
		menuMap.put(BANK, "someUrl");
		menuMap.put(LOCATION, "someUrl");

		return menuMap;
	}

}
