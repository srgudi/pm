package com.chiguru.pm.crm.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class DocumentSerach  implements Serializable {
	private static final long serialVersionUID = 1L;
	private int currentPage;
    private int limit;
    private String sortType;
    private String sortName;
    private int offset;
    private int count;
    private int totalPages;
    private String fileName;
    private String clientName;
    private Date uploadDate;
    private String formattedDate;
    private String date;
    private String fileExtension;
    private String to;
    private Long clientId;
    private String clntId;
    private Long taskId;
    private String tskId;
    private String dueDate;
    private String dueDateTo;
    private Long partId;
    private String title;
    private String description;
    private String author;
    private MultipartFile file;
    private String docAuthor;
    private String taskDueDate;
    private String taskDate;
    private String taskDateTo;
    private String taskDueDateTo;
   
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
    
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public String getFormattedDate() {
		if(uploadDate!=null && formattedDate==null){
			formattedDate=sd.format(uploadDate);
		}
		return formattedDate;
	}

	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFileExtension() {
		return fileExtension;
	}
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
	 public String getTo() {
			return to;
		}
	public void setTo(String to) {
			this.to = to;
		}
	public Long getClientId() {
		if(clntId != null){
			clientId = new Long(clntId);
		}
		return clientId;
	}
	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	public String getClntId() {
		return clntId;
	}
	public void setClntId(String clntId) {
		this.clntId = clntId;
	}
	public Long getTaskId() {
		if(tskId != null){
			taskId = new Long(tskId);
		}
		return taskId;
	}
	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}
	public String getTskId() {
		return tskId;
	}
	public void setTskId(String tskId) {
		this.tskId = tskId;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getDueDateTo() {
		return dueDateTo;
	}
	public void setDueDateTo(String dueDateTo) {
		this.dueDateTo = dueDateTo;
	}
	public Long getPartId() {
		return partId;
	}
	public void setPartId(Long partId) {
		this.partId = partId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getDocAuthor() {
		return docAuthor;
	}
	public void setDocAuthor(String docAuthor) {
		this.docAuthor = docAuthor;
	}
	public String getTaskDueDate() {
		return taskDueDate;
	}
	public void setTaskDueDate(String taskDueDate) {
		this.taskDueDate = taskDueDate;
	}
	public String getTaskDate() {
		return taskDate;
	}
	public void setTaskDate(String taskDate) {
		this.taskDate = taskDate;
	}
	public String getTaskDateTo() {
		return taskDateTo;
	}
	public void setTaskDateTo(String taskDateTo) {
		this.taskDateTo = taskDateTo;
	}
	public String getTaskDueDateTo() {
		return taskDueDateTo;
	}
	public void setTaskDueDateTo(String taskDueDateTo) {
		this.taskDueDateTo = taskDueDateTo;
	}
}
