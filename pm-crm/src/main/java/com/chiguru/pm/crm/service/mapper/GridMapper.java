package com.chiguru.pm.crm.service.mapper;

import java.util.List;

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



public interface GridMapper {

	public List<Long> getRelatedPartiesCountById(SearchCommand command);

	public List<PartyDTO> getPartyDTOListById(SearchCommand command);

	public List<Long> getTaskCountById(TaskSearchCommand command);
	
	public List<TaskNewDTO> getTasksDTOListForAFirm(TaskSearchCommand command);
	
	public List<Long> getFirmStaffListCount(FirmStaffSearch command);

	public List<PersonDTO> getFirmStaffList(FirmStaffSearch command);

	public List<Long> getFirmsCountById(FirmSearch command);

	public List<PartyDTO> getFirmsListById(FirmSearch command);

	public List<Long> getPartyAccountCountById(AccountSearch command);

	public List<PartyAccountDTO> getPartyAccountListById(AccountSearch command);

	public List<Long> getLocationCount(LocationSearch command);

	public List<LocationDTO> getLocationList(LocationSearch command);

	public List<Long> getStaffCountById(StaffSearch command);

	public List<PersonDTO> getPersonDTOListById(StaffSearch command);

	public List<Long> getCliPracInfoCount(TaxSearch command);

	public List<ClientPracInfoDTO> getCliPracInfoList(TaxSearch command);

	public List<Long> getTaxDTOListCount(TaxSearch command);

	public List<TaxDTO> getTaxDTOList(TaxSearch command);

	public List<Long> getJurisdictionListCount(JurisdictionSearch command);

	public List<JurisdictionDTO> getJurisdictionDTOList(JurisdictionSearch command);

	public List<Long> getCodeTypeListCount(CodeTypeSearch command);

	public List<CodeTypeDTO> getCodeTypeDTOList(CodeTypeSearch command);

	public List<Long> getTaskNotificationTemplateListCount(TaskNotificationTemplateSearch command);

	public List<TaskNotificationTemplateDTO> getTaskNotificationTemplateDTOList(TaskNotificationTemplateSearch command);

	public List<TaskNotificationRecipientDTO> getTaskNotificationRecipientDTOList(
			TaskNotificationRecipientSearch command);

	public List<Long> getTaskNotificationRecipientListCount(
			TaskNotificationRecipientSearch command);

	public List<Long> getOfficersAndShareHoldersListCount(
			OfficerShareholderSearch command);

	public List<PartyDTO> getOfficersAndShareHoldersList(
			OfficerShareholderSearch command);

	public List<Long> getAdminCodeListCount(CodeSearch command);

	public List<CodeDTO> getAdminCodeDTOList(CodeSearch command);

	public List<Long> getStaffListCount(EmployeeSearch command);

	public List<PersonDTO> getStaffList(EmployeeSearch command);

	public List<PartyCodeDTO> getListOfCodeTypeByCodeTypeId(CodeSearch command);

	public List<Long> getCountOfCodeTypeByCodeTypeId(CodeSearch command);

	public List<CodeDTO> getAllAdminCodesDTOList(CodeSearch command);

	public List<Long> getAllAdminCodeListCount(CodeSearch command);

}
