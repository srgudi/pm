package com.chiguru.pm.crm.domain;

import com.chiguru.pm.core.common.domain.PersistentEntity;

import java.util.Date;

import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;


public class PersistenceListener {
    @PrePersist
    public void onCreate(PersistentEntity entity) {
        entity.setActiveFlag(true);

        Date createDate = new Date();
        entity.setCreateDate(createDate);
        entity.setLastUpdateDate(createDate);
    }

    @PreUpdate
    public void onUpdate(PersistentEntity entity) {
        entity.setLastUpdateDate(new Date());
    }
}
