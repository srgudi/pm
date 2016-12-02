package com.chiguru.pm.tax.domain;

import java.io.Serializable;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "task_notification")
@NamedQueries({@NamedQuery(name = "tasknotification.findtasknotification_by_tasknotification_id",query = "select id from TaskNotification where id=?")
    , @NamedQuery(name = "tasknotification.findtasknotification_by_id_with_order",query = "select id from TaskNotification taskinfo where taskinfo.notificationDate =? and taskinfo.sentDate is null  order by taskinfo.notificationDate")
    , @NamedQuery(name = "tasknotification.findtasknotification_count_by_tasknotification_id",query = "select count(id) from TaskNotification taskinfo where taskinfo.notificationDate =?")
})
public class TaskNotification implements Serializable {
    private Long id;
    private BaseTask baseTask;
    private Date notificationDate;
    private String sentTo;
    private Date sentDate;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "task_id")
    public BaseTask getBaseTask() {
        return baseTask;
    }

    public void setBaseTask(BaseTask task) {
        this.baseTask = task;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "notification_date", length = 10)
    public Date getNotificationDate() {
        return notificationDate;
    }

    public void setNotificationDate(Date notificationDate) {
        this.notificationDate = notificationDate;
    }

    @Column(name = "sent_to", length = 200)
    public String getSentTo() {
        return sentTo;
    }

    public void setSentTo(String sentTo) {
        this.sentTo = sentTo;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "sent_date", length = 19)
    public Date getSentDate() {
        return sentDate;
    }

    public void setSentDate(Date sentDate) {
        this.sentDate = sentDate;
    }
}
