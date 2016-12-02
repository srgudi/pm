package com.chiguru.pm.web.service;

import org.apache.chemistry.opencmis.client.api.Session;

public interface DocumentManager {
	public Session getCMISSession();

	public String getMimeTypeForFile(String fileName);

	public String getMimeTypeForFileExtension(String fileExtn);
	
	public String getDocuments(String fileName,String filenameLower,String fileNameUpper,String fileNameFirstUpper,Long firmId);

}
