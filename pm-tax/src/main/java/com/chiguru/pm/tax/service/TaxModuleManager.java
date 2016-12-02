package com.chiguru.pm.tax.service;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.DueDateRule;
import com.chiguru.pm.tax.domain.FilingDueDateRule;
import com.chiguru.pm.tax.domain.FilingReminderRule;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.InstallmentDueDateRule;
import com.chiguru.pm.tax.domain.PaymentType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.domain.InstallmentReminderRule;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;

import java.util.List;


public interface TaxModuleManager {
    public List<ClientPracticeInfo> getClientPracticeInfo(
        Long firmPracticeType, Long clientId);

    public ClientPracticeInfo getClientPracticeInfo(Long id);

    public List<FirmPracticeType> getFirmPracticeTypeList(Long firmId);

    public void saveTaxPracticeInfo(ClientPracticeInfo practiceInfo,
        List[] delteListArray);

    public void saveFirmPracticeInfo(FirmPracticeType type);

    public DueDateRule getDueDateForId(Long id);

    public FilingDueDateRule getFilingDueDateRuleForId(Long id);

    public InstallmentDueDateRule getInstallmentDueDateRuleForId(Long id);

    //sagar
    public List<TaxDTO> getPracticeType(Long firmId);

    public FirmPracticeType getFirmPracticeTypeById(Long id);

    public TaxInfoFilingType getTaxInfoFilingType(Integer id);

    public List<TaskStatus> getTaskStatusList();


    public List<Long> getTasksByTaskId(Long taskId, Page page);

    public List<Long> getTasksByTaskId(Long taskId);

    Task getTaskById(Long long1);

    TaskStatus getStatusById(Integer statusId);

    public void saveTask(Task task);

    public Long getDefaultFirmPracticeIdByFirmId(Long firmId);
    
    public FilingReminderRule getFilingReminderRuleById(Long id);
    
    public InstallmentReminderRule getInstallmentReminderRuleById(Long id);
    
    public List<FirmPracticeType> getFirmPracticeTypeByTypeId(Long id);
    
    public List<Party> getPartyByTaskId(Long id);

	public List<FirmPracticeType> getAllFirmPracticeTypeList(Long firmId);

	public PracticeType getPracticeTypeById(Long practiceTypeId);

	public Long getTaxDTOListCount(Long firmId);

	public List<TaxDTO> getTaxDTOList(Long firmId, Page page);

	public List<PracticeType> getPractTypesByFirmId(Long firmId);

	public Long getClientPracticeInfoCount(Long firmPracticeId, Long clientId);

	public List<ClientPracticeInfoDTO> getClientPracticeInfoList(Long firmPracticeId,
			Long clientId, Long count);

	public Long getCliPracInfoCount(Long clientId);

	public List<ClientPracticeInfoDTO> getCliPracInfoList(Long clientId,
			Long count);
	
	public void deleteClientPracticeInfo(boolean activeFlag, Long delList);
	public void deleteRelatedTask(boolean activeFlag, Long delList);
	public void deleteTax(boolean activeFlag, Long delList);
	
	public String getFirmStaffName(Long id);
	
	public List<PaymentType> getPaymentTypeList();
}

