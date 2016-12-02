package com.chiguru.pm.report.service;

import java.util.List;

import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateAccessor;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;


@Service
public class JasperServiceImpl extends HibernateDaoSupport implements  JasperService {

	@Autowired
    public void setDaoSessionFactory(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
        setAttributeMap();
    }
	
	private void setAttributeMap(){
		
	}
	private HibernateTemplate getHibernate() {
	    HibernateTemplate template = getHibernateTemplate();
	    template.setAllowCreate(false);
	    template.setFlushMode(HibernateAccessor.FLUSH_COMMIT);

	    return template;
	}

	@Autowired DataSource dataSource;
	public DataSource getDataSource() {
			return dataSource;
		}
	@Override
	public List getClientListByFirm(String sortAs) {
		SQLQuery query = getHibernate().getSessionFactory().getCurrentSession().createSQLQuery(
    			" SELECT PARTY.`party_id`, REL.`subject`, REL.`object`, ORG.`party_id` as opId,PERSON.first_name as empName,PERSON_TYPE, ORG.`name` as clientName, CODENAME.`id` as CNID, CODENAME.`long_description` " +
				"as CON, CODE1.`id` as CID,CODE1.`long_description` as C1, PARTY.`name` FROM `party` AS PARTY, `party_relationship` AS REL, `organization` AS ORG, PERSON,`code` AS CODENAME, `code` AS CODE1" +
				"  WHERE PARTY.PARTY_ID = REL.OBJECT AND REL.SUBJECT = ORG.PARTY_ID AND ORG.ORGANIZATION_TYPE = 2 AND ORG.FORM_OF_BUSINESS = CODENAME.ID AND ORG.INDUSTRY_TYPE = CODE1.ID" +
				" AND PERSON_TYPE = '1' group by rel.`subject` having count(distinct rel.`subject`) = 1 ORDER BY :sortAs ");
        
		query.setParameter("sortAs", sortAs);
        List result = query.list();
        return result;
	}

}
