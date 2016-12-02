/**
 *
 */
package com.chiguru.pm.tax.dto;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;


/**
 * @author Administrator
 *
 */
public class TaskDTO implements Serializable {
    private long taskId;
    private String clientName;
    private String firmName;
    private String assignedTo;
    private String clientStaffInCharge;
    private String partnerInCharge;
    private String practiceType;
   
    private Date dueDate;
    private String status;
    private String filingType;
    private String flashFilingType;
    private Short filingTypeFromDB;
    private String formattedDueDate;
    SimpleDateFormat sd = new SimpleDateFormat("MM/dd/yyyy");
    private String taskType;
    private String officeNumber;
    private String emailAddress;
    private Integer rank;
    private Integer custcount;
    
    public String getFormattedDueDate() {
		if(formattedDueDate == null && dueDate != null){
			formattedDueDate = sd.format(dueDate);
		}
		return formattedDueDate;
	}

	public void setFormattedDueDate(String formattedDate) {
		this.formattedDueDate = formattedDate;
	}

	public Short getFilingTypeFromDB() {
		return filingTypeFromDB;
	}

	public void setFilingTypeFromDB(Short filingTypeFromDB) {
		this.filingTypeFromDB = filingTypeFromDB;
	}

	/**
	 * @return the partnerInCharge
	 */
	public String getPartnerInCharge() {
		return partnerInCharge;
	}

	/**
	 * @param partnerInCharge the partnerInCharge to set
	 */
	public void setPartnerInCharge(String partnerInCharge) {
		this.partnerInCharge = partnerInCharge;
	}

	/**
     * @return the filingType
     */
    public String getFilingType() {
        return (filingTypeFromDB != null &&  filingTypeFromDB == 1)?"Filing":"Installment";
    }

    /**
     * @param filingType the filingType to set
     */
    public void setFilingType(String filingType) {
        this.filingType = filingType;
    }

    /**
     * @return the assignedTo
     */
    public String getAssignedTo() {
        return assignedTo;
    }

    /**
     * @param assignedTo the assignedTo to set
     */
    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    /**
     * @return the clientStaffInCharge
     */
    public String getClientStaffInCharge() {
        return clientStaffInCharge;
    }

    /**
     * @param clientStaffInCharge the clientStaffInCharge to set
     */
    public void setClientStaffInCharge(String clientStaffInCharge) {
        this.clientStaffInCharge = clientStaffInCharge;
    }

    /**
     * @return the taskId
     */
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public long getTaskId() {
        return taskId;
    }

    /**
     * @param taskId the taskId to set
     */
    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    /**
     * @return the clientName
     */
    public String getClientName() {
        return clientName;
    }

    /**
     * @param clientName the clientName to set
     */
    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    /**
     * @return the firmName
     */
    public String getFirmName() {
        return firmName;
    }

    /**
     * @param firmName the firmName to set
     */
    public void setFirmName(String firmName) {
        this.firmName = firmName;
    }

    /**
     * @return the particeType
     */
    public String getPracticeType() {
        return practiceType;
    }

    /**
     * @param particeType the particeType to set
     */
    public void setPracticeType(String practiceType) {
        this.practiceType = practiceType;
    }

    /**
     * @return the dueDate
     */
    public Date getDueDate() {
        return dueDate;
    }

    /**
     * @param dueDate the dueDate to set
     */
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public String getOfficeNumber() {
		return officeNumber;
	}

	public void setOfficeNumber(String officeNumber) {
		this.officeNumber = officeNumber;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

	public Integer getRank() {
		return rank;
	}

	public void setCustcount(Integer custcount) {
		this.custcount = custcount;
	}

	public Integer getCustcount() {
		return custcount;
	}

	public void setFlashFilingType(String flashFilingType) {
		this.flashFilingType = flashFilingType;
	}

	public String getFlashFilingType() {
		return flashFilingType;
	}
}
