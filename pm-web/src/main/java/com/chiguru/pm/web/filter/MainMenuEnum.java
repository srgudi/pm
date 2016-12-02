package com.chiguru.pm.web.filter;

import java.util.HashMap;
import java.util.Map;

public enum MainMenuEnum {
	CLIENT("CLIENT", "client", 1), FIRM("CLIENT", "", 1), TAX("CLIENT", "", 1), SELECTED_MENU(
			"SELECTED_MENU", "/pm", 100);
	private final String displayToken;
	private final int order;
	private final String urlPath;

	private MainMenuEnum(String displayToken, String urlPath, int order) {
		this.displayToken = displayToken;
		this.urlPath = urlPath;
		this.order = order;
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

	public static Map<MainMenuEnum, String> getUrlTokenMap() {

		Map<MainMenuEnum, String> menuMap = new HashMap<MainMenuEnum, String>();
		menuMap.put(CLIENT, "someUrl");
		menuMap.put(FIRM, "someUrl");
		menuMap.put(TAX, "someUrl");

		return menuMap;
	}

}
