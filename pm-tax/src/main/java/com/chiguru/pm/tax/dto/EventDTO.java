/**
 *
 */
package com.chiguru.pm.tax.dto;

import java.io.Serializable;

import java.util.Date;


/**
 * @author Administrator
 *
 */
public class EventDTO implements Serializable {
    private int id;
    private Date start;
    private Date end;
    private String title;
    private String staffInCharge;
    private String taxType;
    private String partnerInCharge;
    private Date dueDate;
    private String description;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the start
     */
    public Date getStart() {
        return start;
    }

    /**
     * @param start the start to set
     */
    public void setStart(Date start) {
        this.start = start;
    }

    /**
     * @return the end
     */
    public Date getEnd() {
        return end;
    }

    /**
     * @param end the end to set
     */
    public void setEnd(Date end) {
        this.end = end;
    }

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

	public String getStaffInCharge() {
		return staffInCharge;
	}

	public void setStaffInCharge(String staffInCharge) {
		this.staffInCharge = staffInCharge;
	}

	public String getTaxType() {
		return taxType;
	}

	public void setTaxType(String taxType) {
		this.taxType = taxType;
	}

	public String getPartnerInCharge() {
		return partnerInCharge;
	}

	public void setPartnerInCharge(String partnerInCharge) {
		this.partnerInCharge = partnerInCharge;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
    
}
