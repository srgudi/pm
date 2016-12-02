package com.chiguru.pm.crm.dto;

/**
 * @author Apoorva
 *
 */
public class CredentialsDTO {
	
	private Integer id;
	private Integer roleId;
	private Integer moduleId;
	private Integer credential;
	private String module;
	private String role;
	private Integer partyId;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Integer getModuleId() {
		return moduleId;
	}
	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}
	public Integer getCredential() {
		return credential;
	}
	public void setCredential(Integer credential) {
		this.credential = credential;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Integer getPartyId() {
		return partyId;
	}
	public void setPartyId(Integer partyId) {
		this.partyId = partyId;
	}

}
