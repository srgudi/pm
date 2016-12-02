package com.chiguru.pm.tax.domain;

import com.chiguru.pm.core.common.domain.ReadOnlyEntity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


@Entity
@Table(name = "task_status")
public class TaskStatus extends ReadOnlyEntity implements Serializable {
    public static final TaskStatus TASK_STATUS_TYPE_COMPLETE = new TaskStatus(new Integer(1));
    public static final TaskStatus TASK_STATUS_TYPE_WAITING = new TaskStatus(new Integer(2));
    public static final TaskStatus TASK_STATUS_TYPE_NEW = new TaskStatus(new Integer(3));
    public static final TaskStatus TASK_STATUS_TYPE_PROCESSED = new TaskStatus(new Integer(4));
    private String statusName;

    public TaskStatus() {
    }

    public TaskStatus(int id) {
        this.id = id;
    }

    /**
     * @return the status
     */
    @Column(name = "status", nullable = false, length = 50)
    public String getStatusName() {
        return statusName;
    }

    /**
     * @param status the status to set
     */
    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}
