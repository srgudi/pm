package com.chiguru.pm.tax.service;

import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.Page;
import com.chiguru.pm.crm.dto.TaxDTO;
import com.chiguru.pm.tax.dao.TaxModuleDao;
import com.chiguru.pm.tax.domain.ClientPracticeInfo;
import com.chiguru.pm.tax.domain.DueDateRule;
import com.chiguru.pm.tax.domain.FilingDueDateRule;
import com.chiguru.pm.tax.domain.FilingReminderRule;
import com.chiguru.pm.tax.domain.InstallmentReminderRule;
import com.chiguru.pm.tax.domain.FirmPracticeType;
import com.chiguru.pm.tax.domain.InstallmentDueDateRule;
import com.chiguru.pm.tax.domain.PaymentType;
import com.chiguru.pm.tax.domain.PracticeType;
import com.chiguru.pm.tax.domain.Task;
import com.chiguru.pm.tax.domain.TaskStatus;
import com.chiguru.pm.tax.domain.TaxInfoFilingType;
import com.chiguru.pm.tax.dto.ClientPracticeInfoDTO;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class TaxModuleManagerImpl implements TaxModuleManager {
    @Autowired
    TaxModuleDao taxModuleDao;

    @Override
    public List<ClientPracticeInfo> getClientPracticeInfo(
        Long firmPracticeType, Long clientId) {
        return taxModuleDao.getClientPracticeInfo(firmPracticeType, clientId);
    }

    @Override
    public List<FirmPracticeType> getFirmPracticeTypeList(Long firmId) {
        return taxModuleDao.getFirmPracticeTypeList(firmId);
    }

    @Transactional
    public void saveTaxPracticeInfo(ClientPracticeInfo practiceInfo,
        List[] delteListArray) {
        taxModuleDao.saveTaxPracticeInfo(practiceInfo);
        taxModuleDao.deleteDueDateRules(delteListArray);
    }

    @Override
    @Transactional //sagar

    public void saveFirmPracticeInfo(FirmPracticeType type) {
        taxModuleDao.saveFirmPracticeInfo(type);
    }

    //sagar
    @Override
    public List<TaxDTO> getPracticeType(Long firmId) {
        return taxModuleDao.getPracticeTypeList(firmId);
    }

    @Override
    public FirmPracticeType getFirmPracticeTypeById(Long id) {
        return taxModuleDao.getFirmPracticeTypeById(id);
    }

    public TaxInfoFilingType getTaxInfoFilingType(Integer id) {
        return taxModuleDao.getTaxInfoFilingType(id);
    }

    @Override
    public ClientPracticeInfo getClientPracticeInfo(Long id) {
        return taxModuleDao.getClientPracticeInfo(id);
    }

    @Override
    public DueDateRule getDueDateForId(Long id) {
        return taxModuleDao.getDueDateForId(id);
    }

    @Override
    public List<Long> getTasksByTaskId(Long taskId, Page page) {
        if ((page != null) && (page.getCount() >= page.getLimit())) {
            return taxModuleDao.getTasksByTaskId(taskId, page.getSortName(),
                page.getSortType(), page.getStart(), page.getLimit());
        } else {
            return taxModuleDao.getTasksByTaskId(taskId);
        }
    }

    @Override
    public List<Long> getTasksByTaskId(Long taskId) {
        // TODO Auto-generated method stub
        return taxModuleDao.getTasksByTaskId(taskId);
    }

   

    @Override
    public Task getTaskById(Long long1) {
        return taxModuleDao.getTaskById(long1);
    }

    @Override
    public List<TaskStatus> getTaskStatusList() {
        return taxModuleDao.getTaskStatusList();
    }

    @Override
    @Transactional
    public void saveTask(Task task) {
        taxModuleDao.saveTask(task);
    }

    @Override
    public TaskStatus getStatusById(Integer statusId) {
        return taxModuleDao.getStatusById(statusId);
    }

    @Override
    public Long getDefaultFirmPracticeIdByFirmId(Long firmId) {
        return taxModuleDao.getDefaultFirmPracticeIdByFirmId(firmId);
    }

    @Override
    public FilingDueDateRule getFilingDueDateRuleForId(Long id) {
        return taxModuleDao.getFilingDueDateRuleForId(id);
    }

    @Override
    public InstallmentDueDateRule getInstallmentDueDateRuleForId(Long id) {
        return taxModuleDao.getInstallmentDueDateRuleForId(id);
    }

	@Override
	public FilingReminderRule getFilingReminderRuleById(Long id) {
		return taxModuleDao.getFilingReminderRuleById(id);
	}
	
	@Override
	public InstallmentReminderRule getInstallmentReminderRuleById(Long id) {
		return taxModuleDao.getInstallmentReminderRuleById(id);
	}
	
	@Override
	@Transactional
	public List<FirmPracticeType> getFirmPracticeTypeByTypeId(Long id) {
		return taxModuleDao.getFirmPracticeTypeByTypeId(id);
	}
	
	@Override
	@Transactional
	public List<Party> getPartyByTaskId(Long id) {
		return taxModuleDao.getPartyByTaskId(id);
	}

	@Override
	public List<FirmPracticeType> getAllFirmPracticeTypeList(Long firmId) {
		return taxModuleDao.getAllFirmPracticeTypeList(firmId);
	}

	@Override
	public PracticeType getPracticeTypeById(Long practiceTypeId) {
		return taxModuleDao.getPracticeTypeById(practiceTypeId);
	}

	@Override
	public Long getTaxDTOListCount(Long firmId) {
		return taxModuleDao.getTaxDTOListCount(firmId);
	}

	@Override
	public List<TaxDTO> getTaxDTOList(Long firmId, Page page) {
		return taxModuleDao.getTaxDTOList(firmId, page.getLimit(), page.getStart());
	}

	@Override
	public List<PracticeType> getPractTypesByFirmId(Long firmId) {
		return taxModuleDao.getPractTypesByFirmId(firmId);
	}

	@Override
	public Long getClientPracticeInfoCount(Long firmPracticeId, Long clientId) {
		return taxModuleDao.getClientPracticeInfoCount(firmPracticeId, clientId);
	}

	@Override
	public List<ClientPracticeInfoDTO> getClientPracticeInfoList(Long firmPracticeId,
			Long clientId, Long count) {
		return taxModuleDao.getClientPracticeInfoList(firmPracticeId, clientId, count);
	}

	public Long getCliPracInfoCount(Long clientId) {
		return taxModuleDao.getCliPracInfoCount(clientId);
	}

	public List<ClientPracticeInfoDTO> getCliPracInfoList(Long clientId,
			Long count) {
		return taxModuleDao.getCliPracInfoList(clientId,count);
	}

	@Override
	public void deleteClientPracticeInfo(boolean activeFlag, Long delList) {
		taxModuleDao.deleteClientPracticeInfo(Boolean.FALSE, delList);
	}

	@Override
	public void deleteRelatedTask(boolean activeFlag, Long delList) {
		taxModuleDao.deleteRelatedTask(Boolean.FALSE, delList);
	}
	
	@Override
	public void deleteTax(boolean activeFlag, Long delList) {
		taxModuleDao.deleteTax(Boolean.FALSE, delList);
	}
	
	@Override
	public String getFirmStaffName(Long id){
		return taxModuleDao.getFirmStaffName(id);
	}

	@Override
	public List<PaymentType> getPaymentTypeList() {
		return taxModuleDao.getPaymentTypeList();
	}
}
