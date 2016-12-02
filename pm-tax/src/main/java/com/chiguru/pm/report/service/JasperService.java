package com.chiguru.pm.report.service;

import java.util.List;

import javax.sql.DataSource;


public interface JasperService {
    public DataSource getDataSource();

	public List getClientListByFirm(String sortAs);
	
}
