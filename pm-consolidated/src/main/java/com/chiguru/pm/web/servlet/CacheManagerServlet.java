package com.chiguru.pm.web.servlet;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.jboss.cache.Cache;
import org.jboss.cache.CacheFactory;
import org.jboss.cache.CacheManager;
import org.jboss.cache.DefaultCacheFactory;
import org.jboss.cache.Fqn;
import org.jboss.cache.Node;
import org.jboss.cache.config.Configuration;


import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.KeyValue;

public class CacheManagerServlet extends HttpServlet{
	private static Logger logger = Logger.getLogger(CacheManagerServlet.class); // org.slf4j.LoggerFactory.getLogger(CacheManagerServlet.class);
	private static Node applicationCache;
	private static Node firmLevelCache;
	private static Set typeOfBusinessSet = Collections.synchronizedSet(new HashSet());
	private static Set yesNoSet = Collections.synchronizedSet(new HashSet());
	public static Set getYesNoSet() {
		return yesNoSet;
	}
	
	//static InputStream inputStream = getClass().getClassLoader()  
    //.getResourceAsStream("WEB-INF/cache/cache-config.xml");  
	public static void setYesNoSet(Set yesNoSet) {
		CacheManagerServlet.yesNoSet = yesNoSet;
	}
	public void init() throws ServletException{
		logger.info("Initializing CacheManagerServlet");
		CacheFactory factory = new DefaultCacheFactory();
		 InputStream resourceAsStream = getServletConfig().getServletContext().getResourceAsStream("/WEB-INF/cache/cache-config.xml");
		 //System.out.println("******** InputStream "+ resourceAsStream);
        //Cache cache = factory.createCache(inputStream, false);
        Cache cache = factory.createCache(resourceAsStream, false);
        //System.out.println("******** Created Cache "+ cache);
        logger.info("Created Cache "+ cache);
        Configuration config = cache.getConfiguration();
       // config.setClusterName(this.getClusterName());

        // Have to create and start cache before using it
        cache.create();
        cache.start();
        Fqn applicatiionFqn = Fqn.fromString("/application");
        // Let's get hold of the root node.
        Node rootNode = cache.getRoot();
        applicationCache = rootNode.addChild(applicatiionFqn);
        // let's store some data in the node
        applicationCache.put("typeOfBusinessSet", typeOfBusinessSet);
        applicationCache.put("yesNoSet", yesNoSet);
        
        Fqn firmLevelFqn = Fqn.fromString("/firmLevel");
        firmLevelCache = rootNode.addChild(firmLevelFqn);
        
        logger.info("Done with Init CacheManagerServlet");
        //System.out.println("******** Done with Init CacheManagerServlet");
      cache.evict(applicatiionFqn); //clears the cache memory     
	}

	public static List getPartyLevelCache(Long partyId, String cacheName, String type, Long parent){
		List returnList = null;
		String fqnName = null;
		if(parent == null){
			fqnName = "/firmLevel/"+partyId+"/"+type+"/cache/"+cacheName;
		}else{
			fqnName = "/firmLevel/"+partyId+"/"+type+"/parent/"+parent+"/cache/"+cacheName;
		}
		logger.info("fqnName ="+ fqnName);
		Fqn firmCacheFqn = Fqn.fromString(fqnName);
		if(firmLevelCache.hasChild(firmCacheFqn)){
			returnList = (List)firmLevelCache.get(fqnName+"List");
		}else{
			firmLevelCache.addChild(firmCacheFqn);
			returnList =  Collections.synchronizedList(new ArrayList());
			firmLevelCache.put(fqnName+"List",returnList );
		}
		return returnList;
	}
	
	public static List getChildrenCodeCache(Long partyId, Long parentCode, String cacheName){
		List returnList = null;
		String fqnName = "/firmLevel/"+partyId+"/"+parentCode+"/cache/"+cacheName;
		logger.info("fqnName ="+ fqnName);
		Fqn firmCacheFqn = Fqn.fromString(fqnName);
		
		if(firmLevelCache.hasChild(firmCacheFqn)){
			returnList = (List)firmLevelCache.get(fqnName+"List");
		}else{
			firmLevelCache.addChild(firmCacheFqn);
			returnList =  Collections.synchronizedList(new ArrayList());
			firmLevelCache.put(fqnName+"List",returnList );
		}
		return returnList;
	}
	
	private void populateYesNoSet(){
		KeyValue valueYes = new KeyValue("true", "Yes");
    	KeyValue valueNo = new KeyValue("false", "No");
    	yesNoSet.add(valueYes);
    	yesNoSet.add(valueNo);
	}
	
	
	public Node getTypeOfBusinessNode() {
		return applicationCache;
	}

	public void setTypeOfBusinessNode(Node typeOfBusinessNode) {
		this.applicationCache = typeOfBusinessNode;
	}
	
	public static Set addTypeOfBusinessList(List businessTypeList){
		typeOfBusinessSet.addAll(businessTypeList);
		return typeOfBusinessSet;
	}
	


	public static Set getTypeOfBusinessSet() {
		return typeOfBusinessSet;
	}

	public static void setTypeOfBusinessSet(Set typeOfBusinessSet) {
		CacheManagerServlet.typeOfBusinessSet = typeOfBusinessSet;
	}
	
	public static void removeFirmLevelCache(Long partyId, String cacheName, String type){
		String fqnName = "/firmLevel/"+partyId+"/"+type+"/cache/"+cacheName;
		logger.info("fqnName to be removed="+ fqnName);
		Fqn firmCacheFqn = Fqn.fromString(fqnName);
		if(firmLevelCache.hasChild(firmCacheFqn)){
			firmLevelCache.removeChild(firmCacheFqn);
		}
	}

}
