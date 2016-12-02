package com.chiguru.pm.crm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chiguru.pm.crm.dto.AccountSearch;
import com.chiguru.pm.crm.dto.ClientPracInfoDTO;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.CodeSearch;
import com.chiguru.pm.crm.dto.CodeTypeDTO;
import com.chiguru.pm.crm.dto.CodeTypeSearch;
import com.chiguru.pm.crm.dto.EmployeeSearch;
import com.chiguru.pm.crm.dto.FirmSearch;
import com.chiguru.pm.crm.dto.FirmStaffSearch;
import com.chiguru.pm.crm.dto.JurisdictionDTO;
import com.chiguru.pm.crm.dto.JurisdictionSearch;
import com.chiguru.pm.crm.dto.LocationDTO;
import com.chiguru.pm.crm.dto.LocationSearch;
import com.chiguru.pm.crm.dto.OfficerShareholderSearch;
import com.chiguru.pm.crm.dto.PartyAccountDTO;
import com.chiguru.pm.crm.dto.PartyCodeDTO;
import com.chiguru.pm.crm.dto.PartyDTO;
import com.chiguru.pm.crm.dto.PersonDTO;
import com.chiguru.pm.crm.dto.SearchCommand;
import com.chiguru.pm.crm.dto.StaffSearch;
import com.chiguru.pm.crm.dto.TaskNewDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientDTO;
import com.chiguru.pm.crm.dto.TaskNotificationRecipientSearch;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateDTO;
import com.chiguru.pm.crm.dto.TaskNotificationTemplateSearch;
import com.chiguru.pm.crm.dto.TaskSearchCommand;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.crm.dto.TaxSearch;
import com.chiguru.pm.crm.service.mapper.GridMapper;

@Transactional
@Service
public class GridServiceImpl implements GridService{
	
	 @Autowired
	    public GridMapper gridMapper;
	
	@Override
	public Long getRelatedPartiesCountById(SearchCommand command){
			List<Long> listOfCount = gridMapper.getRelatedPartiesCountById(command);
			return listOfCount.get(0);
	}
	
	@Override
	public List<PartyDTO> getPartyDTOListById(SearchCommand command){
		return gridMapper.getPartyDTOListById(command);
	}
	
	@Override
	public Long getTaskCountById(TaskSearchCommand command){
		List<Long> listOfCount = gridMapper.getTaskCountById(command);
		return listOfCount.get(0);
	}

	@Override
	public List<TaskNewDTO> getTasksDTOListForAFirm(TaskSearchCommand command){
		return gridMapper.getTasksDTOListForAFirm(command);
	}
	
	@Override
	public Long getFirmStaffListCount(FirmStaffSearch command){
		List<Long> listOfCount = gridMapper.getFirmStaffListCount(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<PersonDTO> getFirmStaffList(FirmStaffSearch command){
		return gridMapper.getFirmStaffList(command);
	}
	
	@Override
	public Long getFirmsCountById(FirmSearch command){
		List<Long> listOfCount = gridMapper.getFirmsCountById(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<PartyDTO> getFirmsListById(FirmSearch command){
		return gridMapper.getFirmsListById(command);
	}
	
	@Override
	public Long getPartyAccountCountById(AccountSearch command){
		List<Long> listOfCount = gridMapper.getPartyAccountCountById(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<PartyAccountDTO> getPartyAccountListById(AccountSearch command){
		return gridMapper.getPartyAccountListById(command);
	}
	
	@Override
	public Long getLocationCount(LocationSearch command){
		List<Long> listOfCount = gridMapper.getLocationCount(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<LocationDTO> getLocationList(LocationSearch command){
		return gridMapper.getLocationList(command);
	}
	
	@Override
	public Long getStaffCountById(StaffSearch command){
		List<Long> listOfCount = gridMapper.getStaffCountById(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<PersonDTO> getPersonDTOListById(StaffSearch command){
		return gridMapper.getPersonDTOListById(command);
	}
	
	@Override
	public Long getCliPracInfoCount(TaxSearch command){
		List<Long> listOfCount = gridMapper.getCliPracInfoCount(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<ClientPracInfoDTO> getCliPracInfoList(TaxSearch command){
		return gridMapper.getCliPracInfoList(command);
	}
	
	@Override
	public Long getTaxDTOListCount(TaxSearch command){
		List<Long> listOfCount = gridMapper.getTaxDTOListCount(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<TaxDTO> getTaxDTOList(TaxSearch command){
		return gridMapper.getTaxDTOList(command);
	}

	@Override
	public Long getJurisdictionListCount(JurisdictionSearch command) {
		List<Long> listOfCount = gridMapper.getJurisdictionListCount(command);
		return listOfCount.get(0);
	}

	@Override
	public List<JurisdictionDTO> getJurisdictionDTOList(
			JurisdictionSearch command) {
		return gridMapper.getJurisdictionDTOList(command);
	}
	
	@Override
	public Long getCodeTypeListCount(CodeTypeSearch command){
		List<Long> listOfCount = gridMapper.getCodeTypeListCount(command);
		return listOfCount.get(0);
	}
	
	@Override
	public List<CodeTypeDTO> getCodeTypeDTOList(CodeTypeSearch command){
		return gridMapper.getCodeTypeDTOList(command);
	}

	@Override
	public Long getTaskNotificationTemplateListCount(TaskNotificationTemplateSearch command) {
		List<Long> listOfCount = gridMapper.getTaskNotificationTemplateListCount(command);
		return listOfCount.get(0);
	}

	@Override
	public List<TaskNotificationTemplateDTO> getTaskNotificationTemplateDTOList(
			TaskNotificationTemplateSearch command) {
		return gridMapper.getTaskNotificationTemplateDTOList(command);
	}

	@Override
	public Long getTaskNotificationRecipientListCount(
			TaskNotificationRecipientSearch command) {
		 List<Long> listOfCount = gridMapper.getTaskNotificationRecipientListCount(command);
		 return listOfCount.get(0);
	}

	@Override
	public List<TaskNotificationRecipientDTO> getTaskNotificationRecipientDTOList(
			TaskNotificationRecipientSearch command) {
		return gridMapper.getTaskNotificationRecipientDTOList(command);
	}
	
	@Override
	public Long getOfficersAndShareHoldersListCount(
			OfficerShareholderSearch command) {
		 List<Long> listOfCount = gridMapper.getOfficersAndShareHoldersListCount(command);
		 return listOfCount.get(0);
	}

	@Override
	public List<PartyDTO> getOfficersAndShareHoldersList(
			OfficerShareholderSearch command) {
		return gridMapper.getOfficersAndShareHoldersList(command);
	}

	@Override
	public Long getAdminCodeListCount(CodeSearch command) {
		List<Long> listOfCount = gridMapper.getAdminCodeListCount(command);
		 return listOfCount.get(0);
	}

	@Override
	public List<CodeDTO> getAdminCodeDTOList(CodeSearch command) {
		return gridMapper.getAdminCodeDTOList(command);
	}

	@Override
	public Long getStaffListCount(EmployeeSearch command) {
		List<Long> listOfCount = gridMapper.getStaffListCount(command);
		 return listOfCount.get(0);
	}

	@Override
	public List<PersonDTO> getStaffList(EmployeeSearch command) {
		return gridMapper.getStaffList(command);
	}

	@Override
	public List<PartyCodeDTO> getListOfCodeTypeByCodeTypeId(CodeSearch command) {
		return gridMapper.getListOfCodeTypeByCodeTypeId(command);
	}

	@Override
	public Long getCountOfCodeTypeByCodeTypeId(CodeSearch command) {
		List<Long> listOfCount = gridMapper.getCountOfCodeTypeByCodeTypeId(command);
		 return listOfCount.get(0);
	}

	public List<CodeDTO> getAllAdminCodesDTOList(CodeSearch command) {
		return gridMapper.getAllAdminCodesDTOList(command);
	}

	public Long getAllAdminCodeListCount(CodeSearch command) {
		List<Long> listOfCount = gridMapper.getAllAdminCodeListCount(command);
		 return listOfCount.get(0);
	}

}
