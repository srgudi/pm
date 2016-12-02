package com.chiguru.pm.web.util;

import java.util.Date;

import org.apache.commons.lang.ArrayUtils;
import org.hibernate.event.PreInsertEvent;
import org.hibernate.event.PreInsertEventListener;
import org.hibernate.event.PreUpdateEvent;
import org.hibernate.event.PreUpdateEventListener;

import com.chiguru.pm.core.common.domain.PersistentEntity;
import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Person;
import com.chiguru.pm.web.controller.crm.BaseController;

public class EntityListener implements PreInsertEventListener,PreUpdateEventListener{
	
	/*public final static String DB_OPERATION_INSERT = "INSERT";
	public final static String DB_OPERATION_UPDATE= "UPDATE";
	@Override
	public boolean onPreInsert(PreInsertEvent arg0) {
			String[] propertyNames = arg0.getPersister().getEntityMetamodel().getPropertyNames();
            Object[] state = arg0.getState();
            // inserts
            setUpdatesForDatabase(propertyNames, state, arg0.getEntity(), DB_OPERATION_INSERT);
		return false;
	}

	@Override
	public boolean onPreUpdate(PreUpdateEvent arg0) {
			
			String[] propertyNames = arg0.getPersister().getEntityMetamodel().getPropertyNames();
            Object[] state = arg0.getState();
            // updated
//            setUpdatesForDatabase(propertyNames, state, arg0.getEntity(), DB_OPERATION_UPDATE);
		return false;
	}
	
	private void setUpdatesForDatabase(String[] propertyNames, Object[] state, Object entity, String operation){
		if(entity instanceof PersistentEntity || entity instanceof Person || entity instanceof Organization){
		
		Date dbTimeStamp = new Date();
//		if(DB_OPERATION_INSERT.equals(operation)){
			//insert
			setUserIdFromSession("createUserId", state, propertyNames,  entity);
			setValue(state, propertyNames, "createDate",dbTimeStamp, entity);
			int indexCreateUserId = ArrayUtils.indexOf(propertyNames, "createUserId");
			int indexCreateDate = ArrayUtils.indexOf(propertyNames, "createDate");
			if(indexCreateUserId >= 0 || indexCreateDate >= 0){
				state[indexCreateUserId] = BaseController.getUserProfileEmailId();
				state[indexCreateDate] = dbTimeStamp;
			}
//		}
        // updates			
        setUserIdFromSession("lastUpdateUserId",  state, propertyNames,  entity);
        setValue(state, propertyNames, "lastUpdateDate", dbTimeStamp, entity);
		int indexLastUpdateUserId = ArrayUtils.indexOf(propertyNames, "lastUpdateUserId");
		int indexLastUpdateDate = ArrayUtils.indexOf(propertyNames, "lastUpdateDate");
			if(indexLastUpdateUserId >= 0 || indexLastUpdateDate >= 0){
				state[indexLastUpdateUserId] = BaseController.getUserProfileEmailId();
				state[indexLastUpdateDate] = dbTimeStamp;
			}
		}
        
	}*/
	
	/*private void setUserIdFromSession(String propertyName, Object[] state , String[] propertyNames, Object entity){
		setValue(state, propertyNames, propertyName, BaseController.getUserProfileEmailId(), entity);
	}

	void setValue(Object[] currentState, String[] propertyNames, String propertyToSet, Object value, Object entity) {
	     int index = ArrayUtils.indexOf(propertyNames, propertyToSet);
	     
	     if (index >= 0) {
	          currentState[index] = value;
	          } else {
//	               Log.error("Field '" + propertyToSet + "' not found on entity '" + entity.getClass().getName() + "'.");
	          }
	}*/
	
	private void setPropertyState(Object[] propertyStates, String[] propertyNames,String propertyName,Object propertyState) {
        for(int i=0;i<propertyNames.length;i++) {
            if (propertyName.equals(propertyNames[i])) {
                propertyStates[i]=propertyState;
                return;
            }
        }
    }
    private void onInsert(Object entity,Object[] state, String[] propertyNames) {
        if (entity instanceof PersistentEntity) {
        	PersistentEntity domainObject = (PersistentEntity) entity;
            Date date=new Date();
            domainObject.setCreateDate(date);
            setPropertyState(state, propertyNames, "createUserId", BaseController.getUserProfileEmailId());
            domainObject.setLastUpdateDate(date);
            setPropertyState(state, propertyNames, "lastUpdateUserId", BaseController.getUserProfileEmailId());
        }
    }

    private void onUpdate(Object entity,Object[] state, String[] propertyNames) {
        if (entity instanceof PersistentEntity) {
        	PersistentEntity domainObject = (PersistentEntity) entity;
        	Date date=new Date();
        	if(domainObject.getCreateUserId() == null){
        		domainObject.setCreateDate(date);
        		setPropertyState(state, propertyNames, "createUserId", BaseController.getUserProfileEmailId());
        	}else{
        		domainObject.setCreateDate(domainObject.getCreateDate());
        		setPropertyState(state, propertyNames, "createUserId", domainObject.getCreateUserId());
        	}
            domainObject.setLastUpdateDate(date);
            setPropertyState(state, propertyNames, "lastUpdateUserId", BaseController.getUserProfileEmailId());
        }
    }

    @Override
    public boolean onPreInsert(PreInsertEvent event) {
        onInsert(event.getEntity(), event.getState(), event.getPersister().getEntityMetamodel().getPropertyNames());
        return false;
    }

    @Override
    public boolean onPreUpdate(PreUpdateEvent event) {
        onUpdate(event.getEntity(), event.getState(), event.getPersister().getEntityMetamodel().getPropertyNames());
        return false;
    }

	
}
